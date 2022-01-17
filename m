Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC66848FFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiAQBHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiAQBHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:07:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2156C061574;
        Sun, 16 Jan 2022 17:07:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JcYf14mrmz4xmt;
        Mon, 17 Jan 2022 12:07:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642381627;
        bh=cIhXADsW7fvLJYa35kgegOVCUxFvaGrSY3xxhY1Hkc4=;
        h=Date:From:To:Cc:Subject:From;
        b=Tgec0MVRucx4dXCNyo23No99lbgBgsxOUDOmhKHN2WB3Hnd3jPnNWEkLhYo8OoKb9
         bSPayvYf1sr9pEmWRUIuBaO1j9vRGaxUoiCaPrJBAsb50+gI32Ku5Ji9RbjIA0CZoN
         sULJd6uTMDFWp29VHeg9ZYv2akTPfa0BE8nlwxWNqTKvFlCC77B83LDQZHAm+OYZrW
         z/tWBQnKwiNfAJbhIb8iPJcXnDfnp1bhOjY8s4jy4p8EYZGhtwNfTD9VyOQUSv2nbf
         FV3FW0EHH1HtnqHWiYwUVGn+GNU+gf9GVF76EYBRvU3brrZXlTXDiBaHZlC+jbNfeG
         D2xAQK4GUSjgA==
Date:   Mon, 17 Jan 2022 12:07:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: linux-next: manual merge of the akpm tree with the random tree
Message-ID: <20220117120704.19968aab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/roPOorcg1iZ0ALkG/MXfp+V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/roPOorcg1iZ0ALkG/MXfp+V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  drivers/char/random.c

between commit:

  f90d704ab3cd ("random: de-duplicate INPUT_POOL constants")

from the random tree and patch:

  "random: move the random sysctl declarations to its own file"

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/char/random.c
index 7e9caf092cd8,d7c034ea59bf..000000000000
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@@ -2013,9 -2087,8 +2013,8 @@@ static int proc_do_entropy(struct ctl_t
  	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
  }
 =20
 -static int sysctl_poolsize =3D INPUT_POOL_WORDS * 32;
 +static int sysctl_poolsize =3D POOL_BITS;
- extern struct ctl_table random_table[];
- struct ctl_table random_table[] =3D {
+ static struct ctl_table random_table[] =3D {
  	{
  		.procname	=3D "poolsize",
  		.data		=3D &sysctl_poolsize,

--Sig_/roPOorcg1iZ0ALkG/MXfp+V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHkwTgACgkQAVBC80lX
0GzHKggAh78jVKWwZx5Z97AnCQani20INUVVfESg8hak+aXBR9W/Q4GaJsI6I366
cipEXUYxCHWZMFLDLdRFb1pg1QM7N085c14yThVTMCI1d3c1np1X9LbCp6fcWpjw
/aGEgecKCb2jtzaDRKRHU/HoXA9CBek0kvmaFD2VIxX0vL9saorlUWzfx/MUNpgU
1hp2HM9EOrlIVKGgrz8UUSI9qfJyyXRB96r/PpGFNtlPXyoC/Q8zo0IzfQpOpjKi
tv2FAK60iZgz1tUWuIkIOOZmroYU+WaxJ1vxsNO1Vkq9JNZh/dtpP8dnAH0GP8im
ujQ2P3L0udQRUQv2V1+WY39bexq1TQ==
=DLw5
-----END PGP SIGNATURE-----

--Sig_/roPOorcg1iZ0ALkG/MXfp+V--
