Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1C59A643
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbiHSTSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbiHSTSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:18:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1967113684;
        Fri, 19 Aug 2022 12:18:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v4so5413081ljg.0;
        Fri, 19 Aug 2022 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IsUO8cjqK6j9t5ufhnBr2L3srWVx7mZOW1F4ZJN89Y0=;
        b=qleaLdb7jAVVbh/58XagMiTb/RXI+4sJI14FNOZsN/KCidstYqf29QGOHSqWhaIYZ0
         0kArbj8U9ShDeDkCd8r7uYSHDLsteOpEj/K6hCIeFEXcVRr1QaSitUMyJAXAZhYbNRHc
         ukVC6odcQh/dy3l27CD2te7TC6SVbtOowXKPM1WMoGam2XRpj8zox9OHLJI2Z1wSmS8v
         ZZgVYo2JcmdU+ZCho0BKgwTVpA6dpzM3toVHjIws7A/wWQCv+Kvdlx9dHB/MJxWS6XMz
         +98f/6ioDNvRT3UQy86oslj/DUXhb216MRlIpQbPR93CpK1AQVKSY6PjyO7INm1K3e2J
         uzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IsUO8cjqK6j9t5ufhnBr2L3srWVx7mZOW1F4ZJN89Y0=;
        b=rhGbGZlGfpC5Uh2vV18n8P/pwoZlp/ATawYmZG5Vfgo3xvwZb7gfa4DeT0qYDfZCAx
         +fFhqoWtLuJEkua3pukxjOeMCcy01FVGCner6cif2DSnvp5vIp2luk1+7jEYt6eFr3oW
         si1hYNTaS5U6IL57Ek/Y8K4iAWltaAO+P+pk6IQfAxENAHaICu2Nc6sCf3oi6ucbhyM6
         OgHgddim4IOfMvZHi7R1rRDV6vNmdmXbj4TpfCwV2wDPN6Y2WmpU9/cyHfwwcaAO/FGK
         Fwd12E5Pq+l2q6LPx5qopDPGN9ym6EDbNIp8umWEsF6siC93d8dQNyDsuiZ60CfZxUZU
         XM9A==
X-Gm-Message-State: ACgBeo0f5TKSn7sQqb6ctpFqih4ZS5H9EInYh00EFqrh9UqYu8hu9Lfq
        MxljFGLr+WLlKJfnXLTO4mI=
X-Google-Smtp-Source: AA6agR7hQ58J7ca56spqfg6X9CYIsTBLS6KkO0LJ2N1nHtFVyTWX/8pjtnuPzXjsbRkIRpX0Rs6kjg==
X-Received: by 2002:a2e:a587:0:b0:25f:e6ac:c287 with SMTP id m7-20020a2ea587000000b0025fe6acc287mr2495671ljp.416.1660936679279;
        Fri, 19 Aug 2022 12:17:59 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u18-20020a056512129200b0048afa870525sm737894lfs.65.2022.08.19.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:17:58 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:17:53 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] clk: cdce925: simplify using
 devm_regulator_get_enable()
Message-ID: <1f46b06be44527a93cd0bfd5de2fa8e2899524ab.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uH6rNyT7/164d/HR"
Content-Disposition: inline
In-Reply-To: <cover.1660934107.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uH6rNyT7/164d/HR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify the driver using devm_regulator_get_enable() instead of
open-coding the devm_add_action_or_reset().

A (minor?) functional change is that we don't print an error in case of a
deferred probe. Now we also print the error no matter which of the
involved calls caused the failure.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> onwards:
- No changes
---
 drivers/clk/clk-cdce925.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index ef9a2d44e40c..6350682f7e6d 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -603,28 +603,15 @@ of_clk_cdce925_get(struct of_phandle_args *clkspec, v=
oid *_data)
 	return &data->clk[idx].hw;
 }
=20
-static void cdce925_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int cdce925_regulator_enable(struct device *dev, const char *name)
 {
-	struct regulator *regulator;
 	int err;
=20
-	regulator =3D devm_regulator_get(dev, name);
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err =3D regulator_enable(regulator);
-	if (err) {
-		dev_err(dev, "Failed to enable %s: %d\n", name, err);
-		return err;
-	}
+	err =3D devm_regulator_get_enable(dev, name);
+	if (err)
+		dev_err_probe(dev, err, "Failed to enable %s:\n", name);
=20
-	return devm_add_action_or_reset(dev, cdce925_regulator_disable,
-					regulator);
+	return err;
 }
=20
 /* The CDCE925 uses a funky way to read/write registers. Bulk mode is
--=20
2.37.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--uH6rNyT7/164d/HR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4eEACgkQeFA3/03a
ocVt1Af/dfnAxC9B5G5W2XjOddTaq8+2N3/crh+jW6N5YiM8uhiwAY52jj2ioAFQ
RADo/EDAPr/FjOXyhdt0+7YfnK9MhnxcqDVjAdcYQZdGT1ssdZk9wnITSCXJb1wj
/MR1BOXg9877uQONLnBAJXHT4HByM6kn9w7p94je3xxCy8GPsTtRRJq9e7Z6GOkr
GBEkBqiBaCJM9hA5nRxfVm6O73D2CGbxH9gfEfG43KMV6iSSMQs5ZVtuAk4YRJTz
3DowSJXk0bTDpOh+hpIe6RT8gTW5L9AmRqjSoJw09PWgJzjbrbIxIhLHHw+PXNw3
P467ut9y7mw6G/5f0I5CQBoFex5j1A==
=oEEU
-----END PGP SIGNATURE-----

--uH6rNyT7/164d/HR--
