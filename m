Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676184CEEE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 01:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiCGAOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 19:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiCGAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 19:14:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826504B87F;
        Sun,  6 Mar 2022 16:13:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBf7r630bz4xsk;
        Mon,  7 Mar 2022 11:13:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646612026;
        bh=OfUQf/emLmUE3ac6PJaQkNyOVOPCgK/lCEyh/+gJ6tA=;
        h=Date:From:To:Cc:Subject:From;
        b=NR1yJ4g+bwE30i2MCd/3NvchRgxp89qmYuujjfqYkx6ZDmaNniBvCRc3ersqQApDV
         Y/XfoZsivQCT4CTU0gfZQwt8dI8j/G5jMweDA+tLFgyIYkPGC4GemaOKqP9/J0UNQt
         L/OB1hkpPantcJpRHbZ/Muqvsrb4vaEL47Q1M9lFA7LWYxicQToZ81WL3/oeAv26sO
         xwQOSEauCeIh4dNUBaH0SlHsDkp+FZ6tsd5H3U6Jrffz4ZpIQHne7uYSFR0Dya81QU
         XGf3XPT5ixMYK5NdV3krL4eXiN/y+unX3OsNWJa8cxg3mBDQSOev2mNU5XcMQXVQRa
         d2gtO5RatWr8g==
Date:   Mon, 7 Mar 2022 11:13:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220307111342.105ce204@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C4CihK6q6=.LhC.PZI7Q3UD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C4CihK6q6=.LhC.PZI7Q3UD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/tiny/panel-mipi-dbi.c:391:19: error: initialization of 'voi=
d (*)(struct spi_device *)' from incompatible pointer type 'int (*)(struct =
spi_device *)' [-Werror=3Dincompatible-pointer-types]
  391 |         .remove =3D panel_mipi_dbi_spi_remove,
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  0e65e2e6abb0 ("drm/tiny: Add MIPI DBI compatible SPI driver")

interacting with commit

  a0386bba7093 ("spi: make remove callback a void function")

from the spi trees.

I have applied the following merge fix.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 7 Mar 2022 11:01:01 +1100
Subject: [PATCH] fix up for "spi: make remove callback a void function"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/p=
anel-mipi-dbi.c
index 7f8c6c51387f..c759ff9c2c87 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -336,14 +336,12 @@ static int panel_mipi_dbi_spi_probe(struct spi_device=
 *spi)
 	return 0;
 }
=20
-static int panel_mipi_dbi_spi_remove(struct spi_device *spi)
+static void panel_mipi_dbi_spi_remove(struct spi_device *spi)
 {
 	struct drm_device *drm =3D spi_get_drvdata(spi);
=20
 	drm_dev_unplug(drm);
 	drm_atomic_helper_shutdown(drm);
-
-	return 0;
 }
=20
 static void panel_mipi_dbi_spi_shutdown(struct spi_device *spi)
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/C4CihK6q6=.LhC.PZI7Q3UD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlTjYACgkQAVBC80lX
0Gya9AgAnf8khqgClzhiCdnkQ72wArvffQGdP9ZzlX50GJ0Dz0fz0dkNytNbA0Jr
26FAhcX56OTtcWtmWguHcLLMowmzA350EBop3eQM9+wpj382CdMepoOJIfLn0/Ik
tHv+IjrkHKR+Gzlhhi563J/mx2+lXSapG69FANtK6p5CO1IxCIRx9FT5MbnDa71Z
mT4pkBkEOGZnaRmmnnKBsrtdTOucAfDRrhtDjj84gHfH8j2G9ggkkPJHv/LhOxz+
OQItxBl2kkRcpFxp0rhgy9XMrIwtdk5+Nu9jw0a1oKDs59xb7Dp3Drwziq7SikDf
igJO88twe7Hm3gZwF59s79hPpEI8Og==
=wta6
-----END PGP SIGNATURE-----

--Sig_/C4CihK6q6=.LhC.PZI7Q3UD--
