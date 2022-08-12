Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99270590ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiHLKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiHLKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E1AB1A9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u3so702076lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6aDzddAdi44gYxrtGzveI8akk+ZLwKh2Jsp1l+35n5M=;
        b=Q+3sLXPMIeE2lr8ycY3m5xLmWKjUKdY+/y2OWnnTBfTY4EuhUxMHlTfjcNOi1HTbkt
         3dBmfvGNeHbZ0HbmM4st2HjDTDHYu26MMAOXD6OJEcfS/HQvuSBlinhjrPCQc1mAqJzd
         POaxkLRQGk9/fw/H6a1YB80KUrRYJvylB2tJhxXxE15r5GZhc+HhE9QVhGE8b4MG503F
         JAEG67em8oUa4w0Vutxw67ugsmfW8GyNxbRDSL37q+XW1toBFfJoB+n00OG64sHSXULS
         4x0NYx2TlidOqAM+vExwUDYG85Yi5K6zRZhN8Ac0nuQFwxwhHWesDxw1H5+MFcsiKa6c
         iFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6aDzddAdi44gYxrtGzveI8akk+ZLwKh2Jsp1l+35n5M=;
        b=i4qL2VHXiKLDQvmt9UBrB4hSmfSIpa5QQFAo7e+A2xo3ZXcWb+0St2YNpz7SZ8PrD1
         o7IyzaLF96O1ZDX754yCaxF6DMuLIRz7/efLf/P9847F5+1xA/Dklk3Vp0zbdILJJMUe
         UNp2zPy4o67ibdLJHu3JXDIkEGhhbsgQkOQbgdY9J+ZYom7YMSyPGq1pzLbgjtRKODI7
         eVM1E6/yn/dMvwZgyawOaRcVhHu8LNizhsHxBmmdzGHfpeVGp9+q2p4hf1QjHzaEqUBG
         NDayflays4S2TgZ/o9L1n9GJUKCs4cse+AyONyuK9ACu2B7mqbN7LDUiPtxcHAxKAHSu
         eiZw==
X-Gm-Message-State: ACgBeo05U8CsrfyeT+NnPvPkx7yAG17lyO3Fp5Mu9vM4/4ZccveePTts
        CJzXpmz4eY6OpDtUqIRTSrs=
X-Google-Smtp-Source: AA6agR5pNSqr97WKqmglCzCsOwtkCD5QhIzi4+k+Y/zOxRe9qNoFU4jVUA/TOBFEMWXyD+dQOb+w0Q==
X-Received: by 2002:a05:6512:3403:b0:48c:9727:50b0 with SMTP id i3-20020a056512340300b0048c972750b0mr972034lfr.309.1660299094169;
        Fri, 12 Aug 2022 03:11:34 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t13-20020a056512068d00b0048b052a7980sm160143lfe.168.2022.08.12.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:11:33 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:11:29 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/7] gpu: drm: simplify drivers using
 devm_regulator_*get_enable*()
Message-ID: <986ab4650ee4fb6fa9ec1a813152ac36da6119ce.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZglrX0HKdtncVIEd"
Content-Disposition: inline
In-Reply-To: <cover.1660292316.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZglrX0HKdtncVIEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify drivers using managed "regulator get and enable".

meson:
Use the devm_regulator_get_enable_optional(). Also drop the seemingly
unused struct member 'hdmi_supply'.

sii902x:
Simplify using devm_regulator_bulk_get_enable()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> v2:
- Change also sii902x to use devm_regulator_bulk_get_enable()

Please note - this is only compile-tested due to the lack of HW. Careful
review and testing is _highly_ appreciated.
---
 drivers/gpu/drm/bridge/sii902x.c      | 22 +++-------------------
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
 2 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii9=
02x.c
index 65549fbfdc87..4bf572b7ca77 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -170,7 +170,6 @@ struct sii902x {
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
-	struct regulator_bulk_data supplies[2];
 	bool sink_is_hdmi;
 	/*
 	 * Mutex protects audio and video functions from interfering
@@ -1070,6 +1069,7 @@ static int sii902x_probe(struct i2c_client *client,
 	struct device *dev =3D &client->dev;
 	struct device_node *endpoint;
 	struct sii902x *sii902x;
+	static const char * const supplies[] =3D {"iovcc", "cvcc12"};
 	int ret;
=20
 	ret =3D i2c_check_functionality(client->adapter,
@@ -1120,27 +1120,13 @@ static int sii902x_probe(struct i2c_client *client,
=20
 	mutex_init(&sii902x->mutex);
=20
-	sii902x->supplies[0].supply =3D "iovcc";
-	sii902x->supplies[1].supply =3D "cvcc12";
-	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
-				      sii902x->supplies);
-	if (ret < 0)
-		return ret;
-
-	ret =3D regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
-				    sii902x->supplies);
+	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), supplie=
s);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to enable supplies");
 		return ret;
 	}
=20
-	ret =3D sii902x_init(sii902x);
-	if (ret < 0) {
-		regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
-				       sii902x->supplies);
-	}
-
-	return ret;
+	return sii902x_init(sii902x);
 }
=20
 static int sii902x_remove(struct i2c_client *client)
@@ -1150,8 +1136,6 @@ static int sii902x_remove(struct i2c_client *client)
=20
 	i2c_mux_del_adapters(sii902x->i2cmux);
 	drm_bridge_remove(&sii902x->bridge);
-	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
-			       sii902x->supplies);
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/=
meson_dw_hdmi.c
index 5cd2b2ebbbd3..7642f740272b 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -140,7 +140,6 @@ struct meson_dw_hdmi {
 	struct reset_control *hdmitx_apb;
 	struct reset_control *hdmitx_ctrl;
 	struct reset_control *hdmitx_phy;
-	struct regulator *hdmi_supply;
 	u32 irq_stat;
 	struct dw_hdmi *hdmi;
 	struct drm_bridge *bridge;
@@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *m=
eson_dw_hdmi)
=20
 }
=20
-static void meson_disable_regulator(void *data)
-{
-	regulator_disable(data);
-}
-
 static void meson_disable_clk(void *data)
 {
 	clk_disable_unprepare(data);
@@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, stru=
ct device *master,
 	meson_dw_hdmi->data =3D match;
 	dw_plat_data =3D &meson_dw_hdmi->dw_plat_data;
=20
-	meson_dw_hdmi->hdmi_supply =3D devm_regulator_get_optional(dev, "hdmi");
-	if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
-		if (PTR_ERR(meson_dw_hdmi->hdmi_supply) =3D=3D -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		meson_dw_hdmi->hdmi_supply =3D NULL;
-	} else {
-		ret =3D regulator_enable(meson_dw_hdmi->hdmi_supply);
-		if (ret)
-			return ret;
-		ret =3D devm_add_action_or_reset(dev, meson_disable_regulator,
-					       meson_dw_hdmi->hdmi_supply);
-		if (ret)
-			return ret;
-	}
+	ret =3D devm_regulator_get_enable_optional(dev, "hdmi");
+	if (ret !=3D -ENODEV)
+		return ret;
=20
 	meson_dw_hdmi->hdmitx_apb =3D devm_reset_control_get_exclusive(dev,
 						"hdmitx_apb");
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

--ZglrX0HKdtncVIEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2J1AACgkQeFA3/03a
ocXSqAf/VegCKp8gEwmyftaqdq9aTM7DX2Kktp0s+iK2JcKZ7zLzga4D3RRXlXs/
CsdpQ2uBx/lHbDi4leEwpCHSabV6AGBHxzGHbuyMckWRak46bOwuybhU/6AZqwNW
QH9sNCqUDjVRqXQ9kpoejELJXJOIts6bDQ12WQHHAv5r5nIyz5Qv4hfIJMUF4AhF
/RLkgLwj+hEpC+Kk0M8m+q/Gu+vdZO7HuZZYIXO8CxnOSYVsySL1COkHDj1+tkPh
NR6XoM8p8LxFzX1HvZM14sonIc6Fok0qIbUDUwELlin8YKMtsWNivVRjv7xiHQva
skZaRpV8t4qzAvHQOAt9hHy027E3Cg==
=TFoX
-----END PGP SIGNATURE-----

--ZglrX0HKdtncVIEd--
