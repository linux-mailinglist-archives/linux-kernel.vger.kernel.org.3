Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC57C295
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiGUDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGUDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:11:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C520BDD;
        Wed, 20 Jul 2022 20:11:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpHfH32D2z4x1f;
        Thu, 21 Jul 2022 13:11:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658373096;
        bh=WrX66Z+kbLW7AE5ClgZGgpn3AoDiYXk1lHbgmg5iv5E=;
        h=Date:From:To:Cc:Subject:From;
        b=R2XLmPyhlQ7Jw6zM5cN+G+NNPMd9pwMn6VTUDeDDrNSiCD0dudjEuJ7OcNj3nzm/E
         8LatozH2kP8eKYDQWAyeFve2YoxpLH09pfx2apIyEyPKn6Vd62j4oxfMQpN3pxxyKc
         vf0/6Aj4+PV+FXWKj77cVVrN6rQDNfe9kshcVk1+p6utR5B03/saRmC3erLwBZg/+S
         bORLVt4wDai165uGxdhnXUDUIiw3Iz0hycGxdAUCVgDyK8aBSX+pCEqaF9nLbxmQCs
         NL1okfgYHZ1FSi2cCRcbJeGHU3iHZGYEn9UA/GeovIuTKCOPfRq7DHCMgNFCwMpLxt
         UtzJKvc972TBg==
Date:   Thu, 21 Jul 2022 13:11:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220721131132.070be166@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i_TL0w7IMtiRDWOEXsNOfGU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i_TL0w7IMtiRDWOEXsNOfGU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/md/md.c:717:22: error: 'mddev_find' defined but not used [-Werror=
=3Dunused-function]
  717 | static struct mddev *mddev_find(dev_t unit)
      |                      ^~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  4500d5c17910 ("md: simplify md_open")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Jul 2022 13:03:16 +1000
Subject: [PATCH] fix for "md: simplify md_open"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/md/md.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fa500ae9863b..673a39042208 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -714,6 +714,7 @@ static dev_t mddev_alloc_unit(void)
 	return dev;
 }
=20
+#ifndef MODULE
 static struct mddev *mddev_find(dev_t unit)
 {
 	struct mddev *mddev;
@@ -729,6 +730,7 @@ static struct mddev *mddev_find(dev_t unit)
=20
 	return mddev;
 }
+#endif
=20
 static struct mddev *mddev_alloc(dev_t unit)
 {
--=20
2.35.1
--=20
Cheers,
Stephen Rothwell

--Sig_/i_TL0w7IMtiRDWOEXsNOfGU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLYw+QACgkQAVBC80lX
0GxWTQf/caRcsFoIuiMqcmcxvJ/isHvU7KhPxz7FAJV/dQS/VhS3ShYoOeGUfYB+
57bJSa1pM7YvOee6JCjxWNNp67tRdDHq5ovePMiieX9e7fegC6x5GIbHhqQ861yL
8dAkvjVfDkrhV/zTAypQT5DEHarhirkxTdTkjsaumXZQR5P9pOX61PgpKCEopdyg
0x4KDEuuMx4stCTQ70ox8d/YlgN7BK9tB5YwEO93FuH5onncBtqWCKxoLFzSo1+p
A/5oeZEauUk/+akUB3FdLAIbY14kp19YNJEmPITpTRaU4/jkVtFknjUWjUyLVceZ
8H4gIU/rytxBe+OhUp46tPoL308eHw==
=+ZKm
-----END PGP SIGNATURE-----

--Sig_/i_TL0w7IMtiRDWOEXsNOfGU--
