class Fraction  
  
  include Comparable 

  # Instance getter methods for those instance variables (do not define yourself)
  attr_accessor :num, :den

  #Constructor method with numer and denom that default to 0 and 1, respectively.
  def initialize(num = 0, den = 1)
    @num = num 
    @den = den
    self.simplify
  end

  def value
    return @num / @den.to_f
  end

  def simplify
    div = self.num.gcd(self.den)
    self.num = self.num / div 
    self.den = self.den / div 
  end

 # Instance methods to cast to a float and to an integer
  def to_f 
    return self.value
  end

  def to_i 
    return @num / @den
  end

  # Instance method to cast to a string as "NUMER / DENOM"
  def to_s 
    return "%s/%s" % [@num.to_s, @den.to_s]
  end

  def self.zero
    return Fraction.new
  end

  def print
    puts(self.value)
  end

  #Instance spaceship and arithmetic operators (+,-,*,/,**) and negation
  def <=>(other)
    if other.is_a? Fraction 
      return self.value <=> other.value
    else
      return self.value <=> other
    end
  end

  def +(other)
    if other.is_a? Fraction
      mul = self.den.lcm(other.den)
      nNum = ((self.num * (mul / self.den)) + other.num * (mul / other.den))
      new = Fraction.new(nNum, mul)
      return new.num if new.den == 1
      return Fraction.new(nNum, mul)
    elsif other.integer?
      nNum = self.num + (other * self.den)
      return nNum if Fraction.new(nNum, self.den).den == 1
      return Fraction.new(nNum, self.den)
    else 
      return self.value + other
    end 
  end

  def -(other)
    if other.is_a? Fraction
      mul = self.den.lcm(other.den)
      nNum = ((self.num * (mul / self.den)) - other.num * (mul / other.den))
      new = Fraction.new(nNum, mul)
      return new.num if new.den == 1
      return new
    elsif other.integer?
      nNum = self.num - (other * self.den)
      return nNum if Fraction.new(nNum, self.den).den == 1
      return Fraction.new(nNum, self.den)
    else 
      return self.value - other
    end 
  end

  def *(other)
    if other.is_a? Fraction
      new = Fraction.new(self.num * other.num, self.den * other.den)
      return new.num if new.den == 1
      return new
    elsif other.integer?
      new = Fraction.new(self.num * other, self.den)
      return new.num if new.den == 1
      return new 
    else 
      return self.value + other
    end 
  end

  def /(other)
    if other.is_a? Fraction
      new = Fraction.new(self.num * other.den, self.den * other.num)
      return new.num if new.den == 1
      return new
    elsif other.integer?
      new = Fraction.new(self.num, self.den * other)
      return new.num if new.den == 1
      return new 
    else 
      return self.value / other
    end  
  end

  def **(other)
    if other.is_a? Fraction 
      return self.value ** other.value
    else
      return self.value ** other
    end 
  end

  def -@
    return -self.value
  end

  # Additional method for arithmetic operators to work the other way, e.g., 1 + f instead of f + 1
  def coerce(x)
    return x.coerce(self.value)
  end

end

puts("\nTesting:")

f = Fraction.new(2, 4)
g = Fraction.new(2, 8)

puts("Automatic simplification")
puts('f = Fraction.new(2, 4)')
puts('f = ' + f.to_s)
puts('g = Fraction.new(2, 8)')
puts('g = ' + g.to_s)

puts("\nCase f.value = #{f.value}: #{f.value == 0.5}")

puts("\nCase f.to_f = #{f.to_f} : #{f.to_f == 0.5}")
puts("Case f.to_i = #{f.to_i}: #{f.to_i == 0}")
puts("Case f.to_s = '#{f.to_s}': #{f.to_s == '1/2'}")

puts("\nCase f <=> g = #{(f <=> g)}: #{(f <=> g) == 1}")
puts("Case -f = #{-f}: #{-f == -0.5}")

puts("\nCase f + g = #{f + g}: #{f + g == Fraction.new(3, 4)}")
puts("Case f - g = #{f - g}: #{f - g == Fraction.new(1, 4)}")
puts("Case f * g = #{f * g}: #{f * g == Fraction.new(1, 8)}")
puts("Case f / g = #{f / g}: #{f / g == 2}")
puts("Case f ** g = #{f ** g}: #{f ** g == 0.8408964152537145}")

puts("\nCase f + 1 = #{f + 1}: #{f + 1 == 1.5}")
puts("Case f - 1.2 = #{f - 1.2}: #{f - 1.2 == -0.7}")
puts("Case f * 2 = #{f * 2}: #{f * 2 == 1}")
puts("Case f / 2.8 = #{f / 2.8}: #{f / 2.8 == 0.17857142857142858}")
puts("Case f ** 3 = #{f ** 3}: #{f ** 3 == 0.125}")

puts("\nCase 1 + g: #{1 + g == 1.25}")
puts("Case 2.0 * g: #{2.0 * g == 0.5 }")