Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D758EB56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiHJLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHJLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:32:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBAE6DF96;
        Wed, 10 Aug 2022 04:32:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f20so20776606lfc.10;
        Wed, 10 Aug 2022 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=C7PP55XLKwk3Ov8DaaLsfjSN7+Fbj+g7x+jMv9Fy+O8=;
        b=hv9hgdfkJ5AxzikQUS60rpuILK9NqDDXlWKzc8hO7hrZI4x6iJUFEpO2xyGRn99AtC
         fiuGhpGi821ulpOdkMIRb4bK0Ul5NciCSyBDYrMHYsx4Y6Veq+cU6q1Vsp29etpqCMW4
         LwDz5hrMfgHk/1HHCu24hi4p7FRPSL5b/VXT2n8ccZVwqTCq9XU6TM083h0kGked0nad
         kGUrA3Ra2vOlRUIHbJmMm9UTmdzo4TWgQZa1kFh9IJo04cariKMZJb5ToJLbH17mE2+B
         3fO/TWZOoeR4Vte3Ym4cdno3r0b9WB8oI1cFp/4WGFNWOZ2mwh8s31jqsR9iQYaWGPmM
         k+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=C7PP55XLKwk3Ov8DaaLsfjSN7+Fbj+g7x+jMv9Fy+O8=;
        b=Ug6XDMU1dm3gHUBk6VhInqu+/+AEhIWv6ylanZ5AjnSYU1px7iV0oy5NIYGHUtYkhk
         4YWaOKiLxBA5KuDVK+9c/O13AdHNYE1OZX1R9ksN/wMEFpymAAPbjjJzRel51WLzykk+
         JGS5gG5VZdZljMBWoPV8PloZHEcOi/9SaJLF+1lWE5NAm133PqreHBzQ+JDrve5uBCHy
         6jT2CbzTPiuqa0GvskjX3z0WnziHnCNoADnpXHErUwb5KDO7hquXA8zJ57VZDL9jaH38
         8Fv4OojaqWqlJlkGgn/lHCLRq1m5gV5cUYbkwmDr8oPlqGFvCsBTuBUMaEU4gSzv8Ku7
         t7cQ==
X-Gm-Message-State: ACgBeo1wrt0BdjS8+dWUjbwE3tVHLfslx2WcDPtV1kG7FWmMfUOr3wdK
        GpN/rpzzXjYLGYJaC/icsAo=
X-Google-Smtp-Source: AA6agR6Xq1QwE7A7NhkBgpQo3mWmrrFZhTsvzsp8tWf86CYVVLXEuMTCMlUC/jvaEufDdGjrCdaEXw==
X-Received: by 2002:a05:6512:234f:b0:48d:b66:9b54 with SMTP id p15-20020a056512234f00b0048d0b669b54mr2866706lfu.118.1660131152866;
        Wed, 10 Aug 2022 04:32:32 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p21-20020a2eb7d5000000b0025fde1697b0sm369392ljo.135.2022.08.10.04.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:32:32 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:32:18 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] hwmon: lm90: simplify using
 devm_regulator_get_enable()
Message-ID: <4565950ddca2f78209dad49e169d4af7517db27e.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dUGNtiJXsye5By6f"
Content-Disposition: inline
In-Reply-To: <cover.1660127865.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dUGNtiJXsye5By6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/hwmon/lm90.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 3820f0e61510..2ab561ec367c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1848,12 +1848,6 @@ static void lm90_remove_pec(void *dev)
 	device_remove_file(dev, &dev_attr_pec);
 }
=20
-static void lm90_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
-
 static const struct hwmon_ops lm90_ops =3D {
 	.is_visible =3D lm90_is_visible,
 	.read =3D lm90_read,
@@ -1865,24 +1859,13 @@ static int lm90_probe(struct i2c_client *client)
 	struct device *dev =3D &client->dev;
 	struct i2c_adapter *adapter =3D client->adapter;
 	struct hwmon_channel_info *info;
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct lm90_data *data;
 	int err;
=20
-	regulator =3D devm_regulator_get(dev, "vcc");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err =3D regulator_enable(regulator);
-	if (err < 0) {
-		dev_err(dev, "Failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm90_regulator_disable, regulator);
+	err =3D devm_regulator_get_enable(dev, "vcc");
 	if (err)
-		return err;
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
=20
 	data =3D devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
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

--dUGNtiJXsye5By6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzl0EACgkQeFA3/03a
ocW8hAgAwkdNU8q2l23A0DVzeCBVBsc0QTY0W7HwHu18UT5Oj+j4xWyA2tP8Q28L
NXNG8k+tWvZJFqZepKzi/qnCFE08xUTwED11WkPdOTFfAARqSw/kVDKsfcf5bQw4
rFZtNpF6Wl7i28l5wadqW1K/fWbkKzgxh0kpkSrKl/HoHVcS7UpJIu/TzwT4o1hH
ReOkCwl6GMsS8emD29//+PM3WigB5a7gp+mnQiXGjdUTTkEZ40p7ujG5SWobB4Qu
aqdE2LfFtp4fvtMLr+9g2hCwyFBOqivBEfDU2wO18z1H3/dqKKakaEzTOfJYr5Wt
lMkj6Hvn7O1wCMcyEYoSoTlxM++yVg==
=NVIF
-----END PGP SIGNATURE-----

--dUGNtiJXsye5By6f--
