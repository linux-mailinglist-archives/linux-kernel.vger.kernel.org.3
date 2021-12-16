Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20305478051
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhLPXMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:12:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:50986 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234434AbhLPXMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:12:16 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0D3A8740;
        Thu, 16 Dec 2021 23:12:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D3A8740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639696336; bh=XtoOzlOc3FwUPRLRpqRjlKNoegAHtXMtnWsx8Gomyj8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dmm9ZeV9ZyNhIs1mOucim28WHzFmN1iMHHgDXn5+QAnT0alRcAA3UzKCFGu4iaq0F
         A3wJrfAhwt2K6cUuslN50jQWhdiUAWwJIAreG/bn7jYJaMvNqpajws6BSrrkBwOBXs
         7RP4lzh1pW2bZ8uhk+d5fxHqXfPpXnF28tJdCLOgxBY8PU/uIYRrwTA5ErTyWOmynO
         ExCIA64sabrKANjdcwa92fcZZKhGIqkVrrjEVMtYqePB+toI/El++6EW3bjbZilDd+
         /h+tvaGv7cCEw6Hdj90etpzia3xC7C5yE2mzvE5qkdXzBh6TVs9fXzrj/l9Y53imn6
         iw5NLvDAkWM2g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
In-Reply-To: <20211209225549.69010-1-tomasz.warniello@gmail.com>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
Date:   Thu, 16 Dec 2021 16:12:15 -0700
Message-ID: <87h7b8cfg0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> The only change in the script execution flow is the replacement
> of the 'usage' function with the native core Perl 'pod2usage'.
>
> This entails:
> - an overall documentation restructuring
> - addition of a synopsis
>
> Otherwise my intervention is minimal:
> - a few tiny language, formatting and spacing corrections
> - a few missing bits added in the command syntax description
> - adding subsections in the "FORMAT OF COMMENTS" section
> - alphabetical sorting within OPTIONS subections

So I think that this is generally a good thing, but I do have some
quibbles.  Starting with the above, which is a pretty clear violation of
the "each patch does one thing" rule.  Please separate out your changes
into separate patches so that they are more easily reviewed.

A few other things below...

> Finally, the TODO stub evolves into a section:
> - perldoc request removed
> - undocumented options added
>
> Run `kernel-doc -h` to see the full doc.
>
> The TODO suggestion is ancient, thus I can't address its author with
> a "Suggested-by" tag.
>
> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 613 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 413 insertions(+), 200 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 3106b7536b89..00c0c7f5ff58 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -4,46 +4,33 @@
>  use warnings;
>  use strict;
>=20=20
> -## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
> -## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
> -## Copyright (C) 2001  Simon Huggins                             ##
> -## Copyright (C) 2005-2012  Randy Dunlap                         ##
> -## Copyright (C) 2012  Dan Luedtke                               ##
> -## 								 ##
> -## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
> -## Copyright (c) 2000 MontaVista Software, Inc.			 ##

My immediate reaction is that you shouldn't be removing copyright lines,
though I did see that you put them back later.  I think, though, that
the copyright assertions should remain at the top of the file; they
don't need to be part of the help text that the program emits.  So leave
them here, please.

(I guess I should add one of my own, assuming I want any part of this
file actually associated with my name...:)

> -## This software falls under the GNU General Public License.     ##
> -## Please read the COPYING file for more information             ##

This could come out, though; that's what the SPDX line is for.

> -# 18/01/2001 - 	Cleanups
> -# 		Functions prototyped as foo(void) same as foo()
> -# 		Stop eval'ing where we don't need to.
> -# -- huggie@earth.li
> -
> -# 27/06/2001 -  Allowed whitespace after initial "/**" and
> -#               allowed comments before function declarations.
> -# -- Christian Kreibich <ck@whoop.org>
> -
> -# Still to do:
> -# 	- add perldoc documentation
> -# 	- Look more closely at some of the scarier bits :)
> -
> -# 26/05/2001 - 	Support for separate source and object trees.
> -#		Return error code.
> -# 		Keith Owens <kaos@ocs.com.au>
> -
> -# 23/09/2001 - Added support for typedefs, structs, enums and unions
> -#              Support for Context section; can be terminated using empt=
y line
> -#              Small fixes (like spaces vs. \s in regex)
> -# -- Tim Jansen <tim@tjansen.de>
> -
> -# 25/07/2012 - Added support for HTML5
> -# -- Dan Luedtke <mail@danrl.de>

These, too, should come out; that's what the git log is for.

[...]

>  my $kernelversion;
> @@ -468,7 +306,7 @@ while ($ARGV[0] =3D~ m/^--?(.*)/) {
>      } elsif ($cmd eq "Werror") {
>  	$Werror =3D 1;
>      } elsif (($cmd eq "h") || ($cmd eq "help")) {
> -	usage();
> +			pod2usage(-exitval =3D> 0, -verbose =3D> 2);

Why the strange indentation here?  This file is far from pretty, but
that makes it worse.  (Other places too).

[...]

Thanks,

jon
