Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C748380D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiACUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:40:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52866 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:40:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D185611A8;
        Mon,  3 Jan 2022 20:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E5AC36AE9;
        Mon,  3 Jan 2022 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641242445;
        bh=Rb9Put4CZYBjJMBE6EfigJflIlUFmXCrr9zZca+eiDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/MjYuWBd45UQFZNknBDPyyPsHMvebAhmk5n7du4JyV3+XgN7JI94mGhA0vNwOC0i
         pWv8jeYL3T7oE6UvL4iRMvW+TNt3xJqIa4vg8Rf3R9zo5rPI8lsVnhXM6VRo8FaSGv
         FUwBblGF/3u4koAelJRP6nxxCFKm4AF29owzIm/vxUevlAgMDnM1G4+BGQ6CNHadb5
         iXRCCoN+5WCxn3IF7i9BQT9ZIVMHdk8ap5VO4d6QoiHNUshHdOrMSsA3/2e9w3gAI6
         hEOaf1yjF/c7hpkSHSD2q+SL9ZrMoctBuekKhBeCq6aB1VfmEWpwsiWbtEs19fmdZy
         Q6Z0KJCWHSLYA==
Date:   Mon, 3 Jan 2022 21:40:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
Message-ID: <20220103214023.15cd2570@coco.lan>
In-Reply-To: <87h7b8cfg0.fsf@meer.lwn.net>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
        <87h7b8cfg0.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 16 Dec 2021 16:12:15 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:
>=20
> > The only change in the script execution flow is the replacement
> > of the 'usage' function with the native core Perl 'pod2usage'.
> >
> > This entails:
> > - an overall documentation restructuring
> > - addition of a synopsis
> >
> > Otherwise my intervention is minimal:
> > - a few tiny language, formatting and spacing corrections
> > - a few missing bits added in the command syntax description
> > - adding subsections in the "FORMAT OF COMMENTS" section
> > - alphabetical sorting within OPTIONS subections =20
>=20
> So I think that this is generally a good thing, but I do have some
> quibbles.  Starting with the above, which is a pretty clear violation of
> the "each patch does one thing" rule.  Please separate out your changes
> into separate patches so that they are more easily reviewed.

I almost did that in the past, but due to a different rationale ;-)

Besides the points that Jonathan already mentioned, I'd like to add
one additional request...

Pod is very useful when associated with Getopt, e. g.:

	use Getopt::Long;
	use Pod::Usage;

In a similar way to scripts/get_abi.pl (and scripts/get_feat.pl).

This simplifies a lot the parameter handling, as it would
be like:

	GetOptions(
		"debug=3Di" =3D> \$debug,
		"enable-lineno" =3D> \$enable_lineno,
		"rst-source!" =3D> \$description_is_rst,
		"dir=3Ds" =3D> \$prefix,
		'help|?' =3D> \$help,
		"show-hints" =3D> \$hint,
		"search-string=3Ds" =3D> \$search_string,
		man =3D> \$man
	) or pod2usage(2);

This would make easier to maintain the parameters and the associated
summary help and man-like help. An additional advantage of using Getopt
is that the parameters can be added before or after the file name.

IMO, the best would be to add a patch at the version 2 of this series
in order to use GetOpt too.

> A few other things below...
>=20
> > Finally, the TODO stub evolves into a section:
> > - perldoc request removed
> > - undocumented options added
> >
> > Run `kernel-doc -h` to see the full doc.
> >
> > The TODO suggestion is ancient, thus I can't address its author with
> > a "Suggested-by" tag.
> >
> > Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> > ---
> >  scripts/kernel-doc | 613 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 413 insertions(+), 200 deletions(-)
> >
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index 3106b7536b89..00c0c7f5ff58 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -4,46 +4,33 @@
> >  use warnings;
> >  use strict;

I would also add:

	BEGIN { $Pod::Usage::Formatter =3D 'Pod::Text::Termcap'; }

at the final version, in order to produce a better output.

Regards,
Mauro


Thanks,
Mauro
