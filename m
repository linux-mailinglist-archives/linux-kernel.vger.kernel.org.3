Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34647DB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 00:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhLVXrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 18:47:10 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:59583 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbhLVXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:47:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JK93H23tsz4xZ1;
        Thu, 23 Dec 2021 10:47:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640216828;
        bh=34nDuBhsacLhqyEbLB21aao7b8KPXpJzCaQIVuvITmE=;
        h=Date:From:To:Cc:Subject:From;
        b=LUov80UI5aIfp4Kt5cOe4Fa7ren5ZsWS36frHOcmD0+3hb9kftVXQeIEHjRk+Nvsr
         qenO3EyUqfXS+ja6GfQab1KJx1KymvzrljRf8NcovParFDfbma8M4MivnP8+P4Xg55
         kqsayjOXxl47VPWojMix5ZTnzeQSs2XUp1jHBFHqGebYba1yKlKJ3zYYbP0abvbCat
         xCLZWHFHSLFu6ZZLL2RJEoYSx4DKNY91QXIJ3t0ebpC3tbKQF0pHTOSyJGD8/g1bb8
         yJvoeyt9oUrU+sZyAQEMC+Ptvuu/g/ISIVGNr9VhDqFxXiw429MacPZvik/wKupA9X
         YZRmv7qcqMuXw==
Date:   Thu, 23 Dec 2021 10:47:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>
Subject: linux-next: manual merge of the nand tree with the drivers-memory
 tree
Message-ID: <20211223104704.35fa3a41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IzdqL2uUTP76_L0plyVbCWR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IzdqL2uUTP76_L0plyVbCWR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  drivers/mtd/nand/raw/omap2.c

between commit:

  f2f8115fe8b3 ("memory: omap-gpmc: Use a compatible match table when check=
ing for NAND controller")

from the drivers-memory tree and commit:

  0137c74ad873 ("mtd: rawnand: omap2: Add compatible for AM64 SoC")

from the nand tree.

I fixed it up (I used the former version and added the following patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Dec 2021 10:41:35 +1100
Subject: [PATCH] fixup for "memory: omap-gpmc: Use a compatible match table=
 when checking for NAND controller"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/platform_data/mtd-nand-omap2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/p=
latform_data/mtd-nand-omap2.h
index 92f011805ad4..8c2f1f185353 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -65,6 +65,7 @@ struct gpmc_nand_regs {
=20
 static const struct of_device_id omap_nand_ids[] =3D {
 	{ .compatible =3D "ti,omap2-nand", },
+	{ .compatible =3D "ti,am64-nand", },
 	{},
 };
=20
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/IzdqL2uUTP76_L0plyVbCWR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHDuPkACgkQAVBC80lX
0GxlNgf/bDolQqo7UGnffq0BLDiPOuvIihfG9FxkWOc2jc386JOAR5i5bKetxuuz
G++xf2sKJqWTMkztH5rwaf3oPAjUwyKGFEM76kKS/YpeF6GZRN/VcIi4AZg0bl8y
/Z/eDXQSM9FnmRX77m4uedwh122d/qc+ldHuVVWooO+CW+kBZX8JsDQWgdnpcvSw
ev57m0expuEKvpyvoip2MHkBatjnxP8j9Z8drXr1H9lwwsXEfN2d0Ug9/toXidQs
akJE5o0zca8xwZkLmgFy22wZMT76Ul1oJ5VmiXqbwEx57rp1cKBe723tWrPyPYqW
7seHvJBxt38QTzlFxFM9nszVTsYvGA==
=tFy9
-----END PGP SIGNATURE-----

--Sig_/IzdqL2uUTP76_L0plyVbCWR--
