Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF76648FF52
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiAPVw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:52:58 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:46699 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiAPVw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:52:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JcTKx5CWpz4y4r;
        Mon, 17 Jan 2022 08:52:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642369974;
        bh=bwhuUlxc+ba6Mt/6tWzdvb7bvoFl9C80gEw9GihBUjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IwU+qr7YC0pUAqeZ6HpOf5xuk4Sz8l0mXtUxRje8/c+98Rmkwp/OhLYJqA4HF38cq
         Oq3eve4XvFF5knG69Ek+zM7dpLtLhsW9MELOBVtNyPoQ7/G/kDWK6R6MrfkBPk6tTY
         SYBqKWi5SpUIjcr6WvIer61veSjbk5KHH3JcMeOUtxpvwSKYDe3uS9GFVgNz/H/5zm
         Ehy19hkln1wyUpve2RLJqqmazENeZkx1z6n/6e3I/EECPIqiTo9Juu3zqHMIJOFvYC
         w6QSS0JkpoTluYNolvjIL3M6y4a0x4lFK4Tnzm0qXR148ZD1lLUZnoTt3CRuu9TInW
         N4ZqXPmZmsVHQ==
Date:   Mon, 17 Jan 2022 08:52:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yinan Liu <yinan@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the kbuild
 tree
Message-ID: <20220117085252.57a45537@canb.auug.org.au>
In-Reply-To: <20220114174623.729249d7@canb.auug.org.au>
References: <20220112112147.3e19ce23@canb.auug.org.au>
        <20220114174623.729249d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wt+/v9r1wJaf+lVLe6gHxOR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wt+/v9r1wJaf+lVLe6gHxOR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 14 Jan 2022 17:46:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 12 Jan 2022 11:21:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the ftrace tree got a conflict in:
> >=20
> >   scripts/link-vmlinux.sh
> >=20
> > between commit:
> >=20
> >   7d153696e5db ("kbuild: do not include include/config/auto.conf from s=
hell scripts")
> >=20
> > from the kbuild tree and commit:
> >=20
> >   4f1f18311591 ("scripts: ftrace - move the sort-processing in ftrace_i=
nit")
> >=20
> > from the ftrace tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> >=20
> > diff --cc scripts/link-vmlinux.sh
> > index 5189c9a12066,dd9955f45774..000000000000
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@@ -412,11 -411,8 +412,8 @@@ if is_enabled CONFIG_BUILDTIME_TABLE_SO
> >   	fi
> >   fi
> >  =20
> > - info SYSMAP System.map
> > - mksysmap vmlinux System.map
> > -=20
> >   # step a (see comment above)
> >  -if [ -n "${CONFIG_KALLSYMS}" ]; then
> >  +if is_enabled CONFIG_KALLSYMS; then
> >   	mksysmap ${kallsyms_vmlinux} .tmp_System.map
> >  =20
> >   	if ! cmp -s System.map .tmp_System.map; then =20
>=20
> My mistake, the merge resolution should be as below.
>=20
>=20
> diff --cc scripts/link-vmlinux.sh
> index 5189c9a12066,dd9955f45774..000000000000
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@@ -404,7 -400,10 +404,10 @@@ if is_enabled CONFIG_DEBUG_INFO_BTF &&=20
>   	${RESOLVE_BTFIDS} vmlinux
>   fi
>  =20
> + info SYSMAP System.map
> + mksysmap vmlinux System.map
> +=20
>  -if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>  +if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
>   	info SORTTAB vmlinux
>   	if ! sorttable vmlinux; then
>   		echo >&2 Failed to sort kernel tables
> @@@ -412,11 -411,8 +415,8 @@@
>   	fi
>   fi
>  =20
> - info SYSMAP System.map
> - mksysmap vmlinux System.map
> -=20
>   # step a (see comment above)
>  -if [ -n "${CONFIG_KALLSYMS}" ]; then
>  +if is_enabled CONFIG_KALLSYMS; then
>   	mksysmap ${kallsyms_vmlinux} .tmp_System.map
>  =20
>   	if ! cmp -s System.map .tmp_System.map; then

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/wt+/v9r1wJaf+lVLe6gHxOR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHkk7QACgkQAVBC80lX
0Gza7Qf+MqvaXRPNzg74jgaYVKmkY3KG0Ea4+PK+lQaMJtr4hmtchIfgd4ibBAHT
ruJPhbV20KiuCWvOg/wEylDLlA0LDaOS6Fqd6yoAvWJcTZ6ju4BYyAhMRAEykB24
WdXNtWIfrVXeWTBUlxAA6q0lLPxW999q8u9wkpiYkOESW8Hjw7ERiVeTv7EP9KXG
qxh3ji7ydkDfe5Aom0tlFhru2lPc6nedAe1HBm+OhQvgtqsSCs0fvI86/c5+Df92
bXRf28zM58M4ucjXqoGQK06VeHd/75K7ydyrdtTva/GwfrhT5M7k6NUDZBZm52wN
5pKQTWEzvV8WR6qJQy6aW2DXRHInxQ==
=2QTU
-----END PGP SIGNATURE-----

--Sig_/wt+/v9r1wJaf+lVLe6gHxOR--
