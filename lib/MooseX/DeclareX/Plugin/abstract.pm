package MooseX::DeclareX::Plugin::abstract;

BEGIN {
	$MooseX::DeclareX::Plugin::abstract::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::DeclareX::Plugin::abstract::VERSION   = '0.004';
}

use Moose;
with 'MooseX::DeclareX::Plugin';

use MooseX::Declare ();
use Moose::Util ();
use MooseX::ABCD ();

sub plugin_setup
{
	my ($class, $kw) = @_;

	if ($kw->isa('MooseX::DeclareX::Keyword::class'))
	{
		$kw->register_feature(abstract => \&_abstract);
		$kw->register_feature(concrete => sub { (1) });
	}
}

sub _abstract
{
	my ($self, $ctx, $package) = @_;
	$ctx->add_scope_code_parts('use MooseX::ABCD');
}

1;

__END__

=head1 NAME

MooseX::DeclareX::Plugin::abstract - shiny syntax for MooseX::ABCD

=head1 SYNOPSIS

	class Shape is abstract {
		requires 'draw';
	}
	
	class Circle extends Shape {
		method draw { ... }
	}
	
	class Square extends Shape {
		# does not implement 'draw'
	} # dies
	
	my $shape  = Shape->new;  # dies
	my $circle = Circle->new; # succeeds

=head1 DESCRIPTION

This distribution adds two new plugins to L<MooseX::DeclareX>.

=over

=item C<< is abstract >>

Declares that a class cannot be instantiated.

Also allows the standard Moose C<requires> function to work within
classes (it normally only works within roles).

When a class requires a method, then subclasses are supposed to provide that
method. If the subclass itself is also abstract, then it doesn't need to
provide the required methods. (There's also a little cheat: classes which
are mutable may extend abstract classes without implementing required methods.
You should not do this though.)

=item C<< is concrete >>

A counterpart to C<< is abstract >>. Currently, this is a no-op, but in
future it might enable some checks related to abstract classes.

=back

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=MooseX-DeclareX-Plugin-abstract>.

=head1 SEE ALSO

L<MooseX::DeclareX>, L<MooseX::ABCD>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2012 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

