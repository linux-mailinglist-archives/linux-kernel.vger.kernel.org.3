Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF954871C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbiAGEdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiAGEdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:33:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7214AC061245;
        Thu,  6 Jan 2022 20:33:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVVhM1Nlzz4xgr;
        Fri,  7 Jan 2022 15:33:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641529987;
        bh=iTKh+7zuFx/fXKoFulVxDndjC5u90yEuRUIk3fdVIJw=;
        h=Date:From:To:Cc:Subject:From;
        b=NC1w7yzsVsC+qSVZdTIhdxfjySXaRw+4AJc99AhJxi0G6YzRETy2qxW25NH9U5XAa
         xHwcnmWWpvHYgfZJGyhwnQ/SJOB+KdDQjoRmSSg2bAcsMk9PAFkF6+VOfHfNnncsS5
         AapwGz137kgQ9R3X2k8Pqds7Fgoxvjy1cdaV+70IRVVsyjX3Sf6cl8nVbrR/lT032t
         5bFwCZY9+q8NIfj1PBuXXkBePMeP7mE17lSqEP9CBvLomh2TeNxW5+7ULiwIikfWcB
         SrFGJIjaChnO4xw3PdANTWzMBYqVY8JFFpTgFKPpZ7GzH32BvL7CJwcBNUjzmqa8uJ
         HcjjfKfMurKUA==
Date:   Fri, 7 Jan 2022 15:33:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?B?bg==?= 
        <mic@linux.microsoft.com>
Subject: linux-next: manual merge of the tpmdd tree with the kbuild tree
Message-ID: <20220107153306.3f8a2329@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UxZA.PrK7RLqTQum2UVkq_Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UxZA.PrK7RLqTQum2UVkq_Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tpmdd tree got a conflict in:

  MAINTAINERS
  certs/.gitignore

between commit:

  98bb79d61f0c ("certs: move scripts/extract-cert to certs/")

from the kbuild tree and commit:

  0fde37e9c004 ("certs: Check that builtin blacklist hashes are valid")

from the tpmdd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index d38fd8f77cbc,f8188efa3854..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -4445,7 -4410,10 +4445,9 @@@ L:	keyrings@vger.kernel.or
  S:	Maintained
  F:	Documentation/admin-guide/module-signing.rst
  F:	certs/
+ F:	scripts/check-blacklist-hashes.awk
 -F:	scripts/extract-cert.c
  F:	scripts/sign-file.c
+ F:	tools/certs/
 =20
  CFAG12864B LCD DRIVER
  M:	Miguel Ojeda <ojeda@kernel.org>
diff --cc certs/.gitignore
index 9e42fe3e02f5,01de9442e4e2..000000000000
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@@ -1,4 -1,4 +1,5 @@@
  # SPDX-License-Identifier: GPL-2.0-only
+ /blacklist_hashes_checked
 +/extract-cert
  /x509_certificate_list
  /x509_revocation_list

--Sig_/UxZA.PrK7RLqTQum2UVkq_Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXwoIACgkQAVBC80lX
0GxynwgAny3fH1eDy2QKqAZGUPFMdwG0JKpFPKmTXEF6NVlGvW4ozfJvkLFRTJgI
kYQd48jGeqErootVLrtaFG3SQtrEljGKGetvotB1yFiwRpktq9qVxGwmHJo+dnxX
xWNFBHB3xIDjLly1iXUCoI9+IPj859HNapEReQr1d/1ijHtRAu70tzR2w0Jclnnf
sNjE2rHiK9Ba2bTcuAF2k2thcbFzDJ+69ComwkuWbWDQ3mjtFAbMZwfYdpyNvohM
8PD/68XJa4OY2HQnH0dWjLIKyt384ugeueJw/N9vKKhXRaiB6e1wlotCRd2rUwGY
tLkVfY7EirMD4HYZ/S7Cg79Bs4kafQ==
=q2oz
-----END PGP SIGNATURE-----

--Sig_/UxZA.PrK7RLqTQum2UVkq_Q--
