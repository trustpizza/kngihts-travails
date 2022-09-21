class Chess
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def knights_moves(start, destination)
    current = moves_tree(start, destination)
    history = []
    move_history(current, start, history)
    show_moves(history)
  end

  def moves_tree(start, destination)
    queue = [Knight.new(start)]
    current = queue.shift

    until current.location == destination
      current.next_moves.each do |move|
        current.children << knight = Knight.new(move, current)
        queue << knight
      end
      current = queue.shift
    end
    current
  end

  def move_history(current, start, history)
    until current.location == start
      history << current
      current = current.parent
    end
    history << current
  end

  def show_moves(history)
    history.reverse!
    history.each do |knight|
     p knight.location
    end
  end
end

class Knight
  attr_reader :location
  attr_accessor :children, :parent

  def initialize(location, parent = nil)
    @location = location
    @children = []
    @parent = parent
  end

  def next_moves(out = [])
    moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]

    moves.map do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]

      out << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end
    out
  end
end

game = Chess.new
game.knights_moves([3, 3], [4, 3])
