Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976CF59A66D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbiHSTUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351290AbiHSTTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D524F13;
        Fri, 19 Aug 2022 12:19:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u9so7267387lfg.11;
        Fri, 19 Aug 2022 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ExwQj6OxxYffzIEbicVKMuJlzABDjdqO2Cx3MfYHzWI=;
        b=hnjXCBFPtyC8FZIu5Ggbdvmh2xLpIzJqiWuiVbNQ1BNEUdAzr6gw65fWLIvuC/UO05
         YqAOiKwtq6ZY/GiVsFyuePNQ78cV+8hre8dm1k8jF2RIpgL8RRQAf/4k+c2P4c7YDZT6
         Mem+5mt0mkOTM5B9pz1PQRdhMbEmWfH19T/iJoCgjIDd15H3nBZ3v5OkXIcBpMSv35ds
         ihooGBLZ5Dq0ObWe0nyWpcl8v7DeDoVh4m78hL9tsPrnNzlPFCG8OsExRb+yuEddgY9F
         eWwJ8fptlEFy/ZkG7I5AFkYfGjPHW6EWrol7dbj2dRDW7MiJM5lufy779HvzgY2amJW/
         v6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ExwQj6OxxYffzIEbicVKMuJlzABDjdqO2Cx3MfYHzWI=;
        b=5mo4dqw2gXF8cQ/D4KEgPWa2oO+yPuEBqBB6cXRTpmp8n4TquvC9JGX2o0CsSg2W/g
         4IpB3M6xizCKN9TL2O92J6KthSv1990SdR36c4wwrL7y0g8Lcgm07o0FX/snBITIlrP8
         BGcH2Q0/yR3bGjiW4cjPGVGIyOlx1IWg/FXYvhP0nXSHo4ghKTjinzJmPf3QC0mPV/R0
         id8yI8YDR1ASpF0mWSVIuxar4JwOeiG+2RRatXl8WUusSSbOdnV9yNush2Ur0z/gToMY
         F43O8BeZpsJ0abcHSaidVcKXMPPYDh1iZn6TExclTJuGIost9gRnvNXizXhj14iEQzHV
         aPXQ==
X-Gm-Message-State: ACgBeo00VYQNHEL4/+ZbCwFlz2XTn23rxr3hZvs67BTpgMpAlh39JCMM
        3leDPdS3RcTR/hKtrDeuZ/s=
X-Google-Smtp-Source: AA6agR6IDvsDzM94+byJN3IeqXk5VH6LQuv8Iy1GJYSDqHomnQQoHPryRAw6enrzyx1YiAM0Dw0Pdw==
X-Received: by 2002:a05:6512:2316:b0:48a:f2e3:be97 with SMTP id o22-20020a056512231600b0048af2e3be97mr2721404lfu.383.1660936762055;
        Fri, 19 Aug 2022 12:19:22 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25f63000000b00492bf0eaedfsm712558lfc.187.2022.08.19.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:19:21 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:19:17 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Message-ID: <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eXpOsAKDszvvoKFo"
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


--eXpOsAKDszvvoKFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
bulk-enable, add-action-to-disable-at-detach - pattern.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3
Split to own patch.
---
 drivers/iio/dac/ltc2688.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 28bdde2d3088..fcad3efe62ea 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -84,7 +84,6 @@ struct ltc2688_chan {
 struct ltc2688_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
-	struct regulator_bulk_data regulators[2];
 	struct ltc2688_chan channels[LTC2688_DAC_CHANNELS];
 	struct iio_chan_spec *iio_chan;
 	/* lock to protect against multiple access to the device and shared data =
*/
@@ -902,13 +901,6 @@ static int ltc2688_setup(struct ltc2688_state *st, str=
uct regulator *vref)
 			       LTC2688_CONFIG_EXT_REF);
 }
=20
-static void ltc2688_disable_regulators(void *data)
-{
-	struct ltc2688_state *st =3D data;
-
-	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
-}
-
 static void ltc2688_disable_regulator(void *regulator)
 {
 	regulator_disable(regulator);
@@ -970,6 +962,7 @@ static int ltc2688_probe(struct spi_device *spi)
 	struct regulator *vref_reg;
 	struct device *dev =3D &spi->dev;
 	int ret;
+	static const char * const regulators[] =3D {"vcc", "iovcc"};
=20
 	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
@@ -988,21 +981,11 @@ static int ltc2688_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to init regmap");
=20
-	st->regulators[0].supply =3D "vcc";
-	st->regulators[1].supply =3D "iovcc";
-	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
-				      st->regulators);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get regulators\n");
-
-	ret =3D regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
+	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
=20
-	ret =3D devm_add_action_or_reset(dev, ltc2688_disable_regulators, st);
-	if (ret)
-		return ret;
-
 	vref_reg =3D devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(vref_reg)) {
 		if (PTR_ERR(vref_reg) !=3D -ENODEV)
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

--eXpOsAKDszvvoKFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4jUACgkQeFA3/03a
ocX2TAgAtL0Lyeb8TRKB7n4prL/7gnSvDUEO/8ZyDNZpf0yS7OWMbHA+WuC8/Sng
OjBp5KN//zqEFjW9rmacm7EZf3gKRIdw4s/TjkP4JHnpE9S2XPuZQaP5Eha24so9
oBNXLZZUyJ00yVf+9YZuIX3navZff2BTEOmNB9mlh8yvImdU0He9B0p50Xo79wy+
8KFjtAqugrh+vDzobV/jM61co3bIqr/T+czcbkI/vYqboNIII3S0uMvXIIdGWELE
1oxWRk9SG+KDJWrRguQrDxzd4Pl0Wsgu5AgJYXGKA4KKhOk2rpIKfoGveBicWTFV
6yVdReHVgtnTJaZDq2UltAz1g/SV6A==
=1c3M
-----END PGP SIGNATURE-----

--eXpOsAKDszvvoKFo--
