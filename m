Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717CB590ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiHLKLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiHLKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:10:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A516069B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:10:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u6so481775ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=rME1hlHehvkpkCjZbKN0/GWU+K0a+iodQIRupA8e4s0=;
        b=AvdrbNIBlnKEhzBY3cpesIFWSAr+dg3Q+Hlq6H8NiUfezwUxYU8CtwkuBH4uQESU02
         yxLwwoS5Y7NhLjbRpYAmFJ2SiUNUxQ4bPjsUn/KmFTpf6s1YO09ZAX0ewfbiOvrJTTJd
         G4UcKtXpONssng1DeTxDyGWvuiD5sjLbAOHKkmx0ld07d+0eUl14fv2+zTYdu0F3wp31
         6rF5orfE655x2fYataU1Jo1iBmnTYPTb1VH+CbI0rW8mg+niwIxPFbcxYeeSeTrgKbQr
         A1iGw9Z8FhVrrdH9TAbPMubIciLtk3KEqs8rEX4sjD+GJeC/J7HMZHAYKCTCT6wPa56v
         pBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rME1hlHehvkpkCjZbKN0/GWU+K0a+iodQIRupA8e4s0=;
        b=wn+kfUNUWJc7BciXkkUkZKflNIu0L7EEPh/MPqrPt0PNPOTGZATtkLxacNY3jAUQIS
         GDyoWQqwMN+h3a45lnF3y42mJoZhqRaSzvk4qkAd7vxdQstUfrP/zlWiZsiE/TOJEvIa
         qUQaWNQJF+QScldAZKUmJQjA+UQYSfCYwG+ZFoVt5a0kvY4DV0w27OcRm+RW5FaZ/NgJ
         ozHxZSV9sEvCBWKTaD6ss854Ykub+LO60x2lI9FxfeqQqBQQFNyc/xeh4JKWFB3D4qpZ
         3us6zVV5C36LpsQ6amZx7338dJhZogm5jPMP/Lj8QRziKTci4t6zVvrpa82As+eM41TP
         B2cg==
X-Gm-Message-State: ACgBeo0Vxd8k1aCZe2qezbqUtHVoI+VOfe1PWP39vBmw8NDx80fOWk5u
        Jks5dT/bIjKgRjzLbb/KMc4=
X-Google-Smtp-Source: AA6agR6s+5lWKjSbrhXM6b9DKEDihrll2YNJSr2ExETwbG9w/z2oEpnvOHQucT0hE6rwqZMCzyYFpQ==
X-Received: by 2002:a05:651c:a12:b0:25e:bd44:b74b with SMTP id k18-20020a05651c0a1200b0025ebd44b74bmr871154ljq.381.1660299042350;
        Fri, 12 Aug 2022 03:10:42 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w19-20020ac254b3000000b0048b37d29256sm164928lfk.63.2022.08.12.03.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:10:41 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:10:37 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] regulator: Add devm helpers for get and enable
Message-ID: <ed7b8841193bb9749d426f3cb3b199c9460794cd.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VZj9oCS0OEeVyhn7"
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


--VZj9oCS0OEeVyhn7
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
RFCv1 =3D> v2
 - Add devm_regulator_bulk_put() and devm_regulator_bulk_get_enable()
---
 drivers/regulator/devres.c         | 164 +++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  27 +++++
 2 files changed, 191 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 9113233f41cd..ca3d702b0634 100644
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
@@ -166,6 +225,111 @@ int devm_regulator_bulk_get(struct device *dev, int n=
um_consumers,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_bulk_get);
=20
+static int devm_regulator_bulk_match(struct device *dev, void *res,
+				     void *data)
+{
+	struct regulator_bulk_devres *match =3D res;
+	struct regulator_bulk_data *target =3D data;
+
+	/*
+	 * We check the put uses same consumer list as the get did.
+	 * We _could_ scan all entries in consumer array and check the
+	 * regulators match but ATM I don't see the need. We can change this
+	 * later if needed.
+	 */
+	return match->consumers =3D=3D target;
+}
+
+/**
+ * devm_regulator_bulk_put - Resource managed regulator_bulk_put()
+ * @consumers: consumers to free
+ *
+ * Deallocate regulators allocated with devm_regulator_bulk_get(). Normally
+ * this function will not need to be called and the resource management
+ * code will ensure that the resource is freed.
+ */
+void devm_regulator_bulk_put(struct regulator_bulk_data *consumers)
+{
+	int rc;
+	struct regulator *regulator =3D consumers[0].consumer;
+
+	rc =3D devres_release(regulator->dev, devm_regulator_bulk_release,
+			    devm_regulator_bulk_match, consumers);
+	if (rc !=3D 0)
+		WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_put);
+
+static void devm_regulator_bulk_disable(void *res)
+{
+	struct regulator_bulk_devres *devres =3D res;
+	int i;
+
+	for (i =3D 0; i < devres->num_consumers; i++)
+		regulator_disable(devres->consumers[i].consumer);
+}
+
+/**
+ * devm_regulator_bulk_get_enable - managed get'n enable multiple regulato=
rs
+ *
+ * @dev:           device to supply
+ * @num_consumers: number of consumers to register
+ * @id:            list of supply names or regulator IDs
+ *
+ * @return 0 on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several regulator
+ * consumers in one operation with management, the regulators will
+ * automatically be freed when the device is unbound.  If any of the
+ * regulators cannot be acquired then any regulators that were
+ * allocated will be freed before returning to the caller.
+ */
+int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
+				   const char * const *id)
+{
+	struct regulator_bulk_devres *devres;
+	struct regulator_bulk_data *consumers;
+	int i, ret;
+
+	devres =3D devm_kmalloc(dev, sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	devres->consumers =3D devm_kcalloc(dev, num_consumers, sizeof(*consumers),
+					 GFP_KERNEL);
+	consumers =3D devres->consumers;
+	if (!consumers)
+		return -ENOMEM;
+
+	devres->num_consumers =3D num_consumers;
+
+	for (i =3D 0; i < num_consumers; i++)
+		consumers[i].supply =3D id[i];
+
+	ret =3D devm_regulator_bulk_get(dev, num_consumers, consumers);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < num_consumers; i++) {
+		ret =3D regulator_enable(consumers[i].consumer);
+		if (ret)
+			goto unwind;
+	}
+
+	ret =3D devm_add_action(dev, devm_regulator_bulk_disable, devres);
+	if (!ret)
+		return 0;
+
+unwind:
+	while (--i >=3D 0)
+		regulator_disable(consumers[i].consumer);
+
+	devm_regulator_bulk_put(consumers);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_get_enable);
+
 static void devm_rdev_release(struct device *dev, void *res)
 {
 	regulator_unregister(*(struct regulator_dev **)res);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index bbf6590a6dec..24cf5f099eef 100644
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
@@ -240,8 +242,11 @@ int __must_check regulator_bulk_get(struct device *dev=
, int num_consumers,
 				    struct regulator_bulk_data *consumers);
 int __must_check devm_regulator_bulk_get(struct device *dev, int num_consu=
mers,
 					 struct regulator_bulk_data *consumers);
+void devm_regulator_bulk_put(struct regulator_bulk_data *consumers);
 int __must_check regulator_bulk_enable(int num_consumers,
 				       struct regulator_bulk_data *consumers);
+int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
+				   const char * const *id);
 int regulator_bulk_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers);
 int regulator_bulk_force_disable(int num_consumers,
@@ -346,6 +351,17 @@ devm_regulator_get_exclusive(struct device *dev, const=
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
@@ -367,6 +383,10 @@ static inline void devm_regulator_put(struct regulator=
 *regulator)
 {
 }
=20
+static inline void devm_regulator_bulk_put(struct regulator_bulk_data *con=
sumers)
+{
+}
+
 static inline int regulator_register_supply_alias(struct device *dev,
 						  const char *id,
 						  struct device *alias_dev,
@@ -457,6 +477,13 @@ static inline int regulator_bulk_enable(int num_consum=
ers,
 	return 0;
 }
=20
+static inline int devm_regulator_bulk_get_enable(struct device *dev,
+						 int num_consumers,
+						 const char * const *id)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_disable(int num_consumers,
 					 struct regulator_bulk_data *consumers)
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

--VZj9oCS0OEeVyhn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2Jx0ACgkQeFA3/03a
ocXmSAgApigTF0T1Hfye+lj960dlL1DA+2O2o8rHxGcxc0INZ/kcJ9o2JDxx9yb+
0/TcNrvy5OFS4orNn9MLm+U8B7fd8581pwGx+zDcp4ki6W7152omYoxBtRKrLy3R
0D6/VLrz8akParG8tW3cKT2zMNTy/EvI8OsiJSfC+IDl32hWRIFHJm68t7YYX/Uf
PuyFhCUp/I8XNkWyqeyv6nmWoH5xt+ayxBcH7KEJmFoJWTOCORWEnhUIBA+FTnXB
+beVBnWxbPI5slZWyH9BMxp/Th1Bt4YvwwLSJCHpgmz1CBEUmYBRwajyaEYRFXBY
Evx/ZaaO3aYlSVV5Y2BpyR0eXvIKlw==
=un37
-----END PGP SIGNATURE-----

--VZj9oCS0OEeVyhn7--
