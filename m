Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4748E459
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiANGq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiANGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:46:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45BC061574;
        Thu, 13 Jan 2022 22:46:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZsJw3lxQz4xdl;
        Fri, 14 Jan 2022 17:46:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642142784;
        bh=OJmVhMiwrRX//9NTnM3lbdJsh+nTpe1UlUcQsbZlTW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X493sEO3qPLenahXu6dSA6/95hgqKcdHfH0VTw7VKek/7ys3GErSRuzujc6F3RN8V
         JH1gAoaksST3cItdbUn2jphMN+iBDahIf6b70J7zUT0MCLS7NCJkNJI0CU0EpJzdZ5
         aJJ7S93ABpFko7vJWkjUzn0FqgwVr1fkhGfVEzMotmHL+x78bRJaZOCES5ui4NhOuN
         AsTZj6m8YnbZ8MVTKH003852NFioCYOY5aLbl9uC47bTESVJsT45VRa013OjYNflmX
         P6CglsMypMQBqNYpkDTt+mlpZHRqaY7t6vZ3sQ3wtOG8/d7jCffPvg8/gRK40SuyWB
         WT4nXn2wGjlOA==
Date:   Fri, 14 Jan 2022 17:46:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yinan Liu <yinan@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the kbuild
 tree
Message-ID: <20220114174623.729249d7@canb.auug.org.au>
In-Reply-To: <20220112112147.3e19ce23@canb.auug.org.au>
References: <20220112112147.3e19ce23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2lWe_CB8Z3r0wLv6QS/n6+S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2lWe_CB8Z3r0wLv6QS/n6+S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 12 Jan 2022 11:21:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the ftrace tree got a conflict in:
>=20
>   scripts/link-vmlinux.sh
>=20
> between commit:
>=20
>   7d153696e5db ("kbuild: do not include include/config/auto.conf from she=
ll scripts")
>=20
> from the kbuild tree and commit:
>=20
>   4f1f18311591 ("scripts: ftrace - move the sort-processing in ftrace_ini=
t")
>=20
> from the ftrace tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc scripts/link-vmlinux.sh
> index 5189c9a12066,dd9955f45774..000000000000
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@@ -412,11 -411,8 +412,8 @@@ if is_enabled CONFIG_BUILDTIME_TABLE_SO
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

My mistake, the merge resolution should be as below.

--=20
Cheers,
Stephen Rothwell

diff --cc scripts/link-vmlinux.sh
index 5189c9a12066,dd9955f45774..000000000000
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@@ -404,7 -400,10 +404,10 @@@ if is_enabled CONFIG_DEBUG_INFO_BTF &&=20
  	${RESOLVE_BTFIDS} vmlinux
  fi
 =20
+ info SYSMAP System.map
+ mksysmap vmlinux System.map
+=20
 -if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 +if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
  	info SORTTAB vmlinux
  	if ! sorttable vmlinux; then
  		echo >&2 Failed to sort kernel tables
@@@ -412,11 -411,8 +415,8 @@@
  	fi
  fi
 =20
- info SYSMAP System.map
- mksysmap vmlinux System.map
-=20
  # step a (see comment above)
 -if [ -n "${CONFIG_KALLSYMS}" ]; then
 +if is_enabled CONFIG_KALLSYMS; then
  	mksysmap ${kallsyms_vmlinux} .tmp_System.map
 =20
  	if ! cmp -s System.map .tmp_System.map; then

--Sig_/2lWe_CB8Z3r0wLv6QS/n6+S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHhHD8ACgkQAVBC80lX
0Gyhcwf/aauuYeap6/YqGpdeSCYmc2Tq7Vc564DQXX6n3Mmn1aCeAXec8yqyn329
fdP6vy1NiEyCNlngzyBaNz7C2iEGiRe0gcBrO7XZx8N6tVq9UtAvO0kfcVDwB1ju
XyXPqeIbByeJugYsZyy8xF8wp0eMKm7OqVM/9wm6z2cYWaAxdyGO6aaN8hChYHmL
i8RRGSl6Nm2r6Wb4Ai5MVPN2hDCNUcC8cyHvwarxUM/1c3b6m6PEjpmRT6gYZPcG
EAOfhU2vKBnIprfsbVxCGbRDFkpgIc7fWzFrW9JhlBwx5A0M+sO8SDiIOvIBF/Vp
W9n3J/1IAeBtljxf5BaOf0jq4Al4ag==
=51bd
-----END PGP SIGNATURE-----

--Sig_/2lWe_CB8Z3r0wLv6QS/n6+S--
