# features/mitra/mitra.feature
Feature: mitra

  Background: testing mitra in a generic context
    Given I'm in a context
    And I use "tikz"
    And I use the "kodi.mitra" TikZ library

  Scenario Outline: using a cell with an unknown TikZ key
    Given I code \tikz\matrix[mitra]{|[foo]|};
    Then compilation fails

  Scenario Outline: using cells with no node options
    Given I want a debugging dump
    And the body is
    """
    \kDMitraDebugtrue
    \let\foo\relax
    \let\bar\relax
    \tikz\matrix[mitra]{%
    <code>&X&X\\
    X&<code>&X\\
    X&X&<code>\\
    };
    """
    Then compilation succeeds
    And the dump gives "<options>" and "<content>" for cells
      | row | col |
      | 1   | 1   |
      | 2   | 2   |
      | 3   | 3   |

  Examples: empty cell
    | code | content | options |
    | «»   | «»      | «»      |
    | «  » | «»      | «»      |
  Examples: text
    | code       | content   | options |
    | «foo»      | «foo»     | «»      |
    | «  foo»    | «foo»     | «»      |
    | «foo  »    | «foo»     | «»      |
    | «foo  bar» | «foo bar» | «»      |
  Examples: macros
    | code         | content      | options |
    | «\foo»       | «\foo »      | «»      |
    | «  \foo»     | «\foo »      | «»      |
    | «\foo  »     | «\foo »      | «»      |
    | «\foo\bar»   | «\foo \bar » | «»      |
    | «\foo  \bar» | «\foo \bar » | «»      |

  Scenario Outline: using cells with node options
    Given I want a debugging dump
    And the body is
    """
    \kDMitraDebugtrue
    \let\foo\relax
    \tikz\matrix[mitra]{%
    <code>&X&X\\
    X&<code>&X\\
    X&X&<code>\\
    };
    """
    Then compilation succeeds
    And the dump gives "<options>" and "<content>" for cells
      | row | col |
      | 1   | 1   |
      | 2   | 2   |
      | 3   | 3   |

  Examples: empty cell
    | code       | content | options |
    | «\|[]\|»   | «»      | «[]»    |
    | «  \|[]\|» | «»      | «[]»    |
    | «\|[]\|  » | «»      | «[]»    |
  Examples: text
    | code          | content | options |
    | «\|[]\|foo»   | «foo»   | «[]»    |
    | «  \|[]\|foo» | «foo»   | «[]»    |
    | «\|[]\|  foo» | «foo»   | «[]»    |
  Examples: macros
    | code           | content | options |
    | «\|[]\|\foo»   | «\foo » | «[]»    |
    | «  \|[]\|\foo» | «\foo » | «[]»    |
    | «\|[]\|  \foo» | «\foo » | «[]»    |