Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49458EB40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiHJLaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHJLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:30:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FA12A95
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:30:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v2so12168788lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=SFoCwOXNr0V39FyKhCLQaYvVdFKqeXujdHzvpYNfbIQ=;
        b=l3jmBboJ998Hwr8yFQDRZhKEuNZgIIS35r9X9X8IT4vtg60yZOLMJ8Q9RRkIeQLRSS
         /ZfP/Enp5O5LxEmlGQtm57Xc9U8IV5WXq4nDJz5IP8iwHhfLEgfS5lnaTaF1LxXr3p6u
         zo2SO+LUsfSj9LkwPzuCAfRla49YRRHvJ6qloGUKVzjvFYG77DtPDI/5QEBDmCPBAAS8
         YEo1YTGl1cTI1dUCuo+HR2vc5X9fteC0UjIXL8VMS4JrwzBTjCdwVnkMVcerybpgWJ03
         6LaRwpAqLoBmf87+2ZWOSl+kb+e8qYOaSHH7vl0aT2vf9VP9UvHoUKdUblmVsRfT+4qm
         43Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SFoCwOXNr0V39FyKhCLQaYvVdFKqeXujdHzvpYNfbIQ=;
        b=NPRpWhPwUxIoZHBCmq/Ix1lt/kF7eAgYmvnSXAtMh0pItMq8BDz20Buqyadr6YhNMq
         wI2IvU3dZrXoXBSkT/SJTOhqyQlJCyxdAKOoDlezBOqyl6ErkUnMpjqC8w3PxvwEbOtP
         i1DpHwUBAsRbBNEMSKSYjIdppgGfiox9Gm5XJWOzbPg6xnN/k8zhx1eJn6MfjiLjFeXu
         Ayi7qzJWVe/J5OIz6G4QfD+f3/ipiSUwUUEwNCbKR2IMOtIEjgBRNM6melvua6CFgMcW
         JAo+e9HcVyG3Cd64a2ifXXGgm5n+gP20iyu541eDg4B0l5UnE5qDa37r0nD5RUvh6PI+
         yzqw==
X-Gm-Message-State: ACgBeo0pnqoC71ABy/9UozLXePBHQvGhaEXLq3TGyP+3l6+qXWglGw+K
        wIzxozSnR5YdQVbviWVnTxV2Gh+wbgK79A==
X-Google-Smtp-Source: AA6agR75eRwjMdqZZsyN3FnDGrXo30NXB3d4aY6I3Mikcgb59H+oJRBURNwGvg31kMw89PO59+Hejw==
X-Received: by 2002:a05:6512:3406:b0:48c:2e06:6c72 with SMTP id i6-20020a056512340600b0048c2e066c72mr6043502lfr.324.1660131017164;
        Wed, 10 Aug 2022 04:30:17 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h28-20020a19ca5c000000b0048af3e54b47sm311069lfj.95.2022.08.10.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:30:16 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:29:55 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] regulator: Add devm helpers for get and enable
Message-ID: <b6058e052b842a19c8bb639798d8692cd0e7589f.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o0HAkEsHRf+3t9c6"
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


--o0HAkEsHRf+3t9c6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few regulator consumer drivers seem to be just getting a regulator,
enabling it and registering a devm-action to disable the regulator at
the driver detach and then forget about it.

We can simplify this a bit by adding a devm-helper for this pattern.
Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/devres.c         | 59 ++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h | 13 +++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 9113233f41cd..61b0facc975b 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -70,6 +70,65 @@ struct regulator *devm_regulator_get_exclusive(struct de=
vice *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_get_exclusive);
=20
+static void regulator_action_disable(void *d)
+{
+	struct regulator *r =3D (struct regulator *)d;
+
+	regulator_disable(r);
+}
+
+static int _devm_regulator_get_enable(struct device *dev, const char *id,
+				      int get_type)
+{
+	struct regulator *r;
+	int ret;
+
+	r =3D _devm_regulator_get(dev, id, get_type);
+	if (IS_ERR(r))
+		return PTR_ERR(r);
+
+	ret =3D regulator_enable(r);
+	if (!ret)
+		ret =3D devm_add_action_or_reset(dev, &regulator_action_disable, r);
+
+	if (ret)
+		devm_regulator_put(r);
+
+	return ret;
+}
+
+/**
+ * devm_regulator_get_enable_optional - Resource managed regulator get and=
 enable
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on dri=
ver
+ * detach. See regulator_get_optional() and regulator_enable() for more
+ * information.
+ */
+int devm_regulator_get_enable_optional(struct device *dev, const char *id)
+{
+	return _devm_regulator_get_enable(dev, id, OPTIONAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable_optional);
+
+/**
+ * devm_regulator_get_enable - Resource managed regulator get and enable
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on dri=
ver
+ * detach. See regulator_get() and regulator_enable() for more
+ * information.
+ */
+int devm_regulator_get_enable(struct device *dev, const char *id)
+{
+	return _devm_regulator_get_enable(dev, id, NORMAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable);
+
 /**
  * devm_regulator_get_optional - Resource managed regulator_get_optional()
  * @dev: device to supply
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index bbf6590a6dec..58e3dbcddb12 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -203,6 +203,8 @@ struct regulator *__must_check regulator_get_optional(s=
truct device *dev,
 						      const char *id);
 struct regulator *__must_check devm_regulator_get_optional(struct device *=
dev,
 							   const char *id);
+int devm_regulator_get_enable(struct device *dev, const char *id);
+int devm_regulator_get_enable_optional(struct device *dev, const char *id);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
=20
@@ -346,6 +348,17 @@ devm_regulator_get_exclusive(struct device *dev, const=
 char *id)
 	return ERR_PTR(-ENODEV);
 }
=20
+static inline int devm_regulator_get_enable(struct device *dev, const char=
 *id)
+{
+	return -ENODEV;
+}
+
+static inline int devm_regulator_get_enable_optional(struct device *dev,
+						     const char *id)
+{
+	return -ENODEV;
+}
+
 static inline struct regulator *__must_check
 regulator_get_optional(struct device *dev, const char *id)
 {
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

--o0HAkEsHRf+3t9c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzlrMACgkQeFA3/03a
ocXljgf/dQYLub1c+SOBZGohlwrTURR/rcB4ZN0V8Ayk/fjdzVgvj4DNcdwvAcjv
8X0U57U6nwMIbo//vQ/cOZEEFP3sQLyv6vNx5CjFeSc37t9WfVQTdrUh3kQlbuXb
yiEve1DcMDd8k4hC2aIJwkjlMNzpJPSWRsnXKko7cBfyM+OtvleIhzunJ+LHgVP9
zhAAhmybWYhHQWqOmvXNrctIEbZ8KdDokAkdlucJ1vdUmqrkSCUrRT5GIPmAvakD
G3s3W+f/jUmBkzlcoUYJLuxxnkHjLnSTBQBluVA3Dtl/zrGI/VtqrCfGJXRJp/Cc
mUJBV9rN2R6oI9/Gw/ZIBmnJm5F5Iw==
=l/IP
-----END PGP SIGNATURE-----

--o0HAkEsHRf+3t9c6--
