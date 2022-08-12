Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF543590EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiHLKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiHLKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:12:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FC7AB43C;
        Fri, 12 Aug 2022 03:12:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u1so721174lfq.4;
        Fri, 12 Aug 2022 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DeD431ghxLD17wCgiWSV6MzDX9uBGSE2qzGxwjVq9ao=;
        b=FVLMV6OrkixVc9xqZyTFxZ6fDC4wdgglZqQWmPC0gadPUxdsibc8yAymFp/f9fZ6qo
         MA9WYi0FCl4LVSjs+akVCpLHqNirqxOnQyyrA8WdaJKt0AJPDOSBzL3uNrv5y5IRIDEg
         QdA/skH1xWk/JYe924m+6Id0qZwQCGcmH2y62OkGuLJhglzcIQ8VwVmJ3/xNqCyJ5HVI
         a7sPayaWEvmjpvPzgJySMbEV/OKPejNwCbT5X+aswGPfGZHuJXadw13LlIHAKC/3dnR4
         kc6Nq3ruIInwKR4khTznbYKAwMqiTRzzPLhbQoityr3PiyIxEWuE6GRJ8nW4A2P3NYIz
         H/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DeD431ghxLD17wCgiWSV6MzDX9uBGSE2qzGxwjVq9ao=;
        b=K5f2oh68l8mk8aY+FDKgbFWYbavoTZVcMhO1/4tiRWFw0SMwNluaNFDZ/TpxCq7Ran
         /FQ17Ho2OvtwuULmvHMoa2FSdBXXnV1rHyaoRqvPAf5G7CrR7wBBg5VNtL9LsvfZsmq0
         ykywDmZX0xrs+LdjGbdyDIENwkV7K3JJSLZAbOY3cHDTpgujcAfrwTyu0+ACJS33EW4c
         FlHDuWFY4pHSFbc+UYEUQMALPOs1I1H7dEX/ax06SPAjvlfAedmhrqISQOvf/9p1IwKA
         4RK8EEbVvqPt7zHgIPNvpCGy8C2+pe+se6sIOVDKmGXQB6UM6vIOBUkLgWVCIXncPSWt
         3obQ==
X-Gm-Message-State: ACgBeo0OuYr+pVeOEgLJ/T8DeRsDkW5gORJgaTkg8Zc7yfqHfJN/i/hI
        JH3sse+GBdzRkfo6kCOxYza1DhCuh+4+ew==
X-Google-Smtp-Source: AA6agR7u7LbwWwJWt0KfxYKaZu/OiJn6LdLRjYedua1UfKa+8e1lE1IF9M/JPZzPYRHAmmjt7OQ4fA==
X-Received: by 2002:a19:5e49:0:b0:48a:7697:ddb1 with SMTP id z9-20020a195e49000000b0048a7697ddb1mr1085776lfi.323.1660299128266;
        Fri, 12 Aug 2022 03:12:08 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 10-20020ac2484a000000b0048af7e58c9dsm156345lfy.278.2022.08.12.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:12:06 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:12:02 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] iio: Simplify drivers using
 devm_regulator_*get_enable()
Message-ID: <13bb483e1f3ee003ca3a6949e27eee7f505e047d.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SnNffchV/nAgRcji"
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


--SnNffchV/nAgRcji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

adc/ad7192:
Use devm_regulator_get_enable() instead of open coded get, enable,
add-action-to-disable-at-detach - pattern. Also drop the seemingly unused
struct member 'dvdd'.

dac/ltc2688:
gyro/bmg160_core:
Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
bulk-enable, add-action-to-disable-at-detach - pattern.

imu/st_lsm6dsx:
Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
bulk-enable, add-action-to-disable-at-detach - pattern.

A functional change (which seems like a bugfix) is that if
regulator_bulk_get fails, the enable is not attempted.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> v2:
Squashed all IIO changes to one patch. Added use of
devm_regulator_bulk_get_enable().

Please note - this is only compile-tested due to the lack of HW. Careful
review and testing is _highly_ appreciated.
---
 drivers/iio/adc/ad7192.c                     | 15 ++--------
 drivers/iio/dac/ltc2688.c                    | 23 ++-------------
 drivers/iio/gyro/bmg160_core.c               | 24 ++--------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 --
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++----------------
 5 files changed, 13 insertions(+), 81 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977be7d22..8a52c0dec3f9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,7 +177,6 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
-	struct regulator		*dvdd;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1015,19 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	st->dvdd =3D devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd))
-		return PTR_ERR(st->dvdd);
-
-	ret =3D regulator_enable(st->dvdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
-		return ret;
-	}
-
-	ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->dvdd);
+	ret =3D devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd su=
pply\n");
=20
 	ret =3D regulator_get_voltage(st->avdd);
 	if (ret < 0) {
diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 937b0d25a11c..1abc88cd99f9 100644
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
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 81a6d09788bd..acfabac645b6 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -93,7 +93,6 @@
=20
 struct bmg160_data {
 	struct regmap *regmap;
-	struct regulator_bulk_data regulators[2];
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
 	struct iio_mount_matrix orientation;
@@ -1067,19 +1066,13 @@ static const char *bmg160_match_acpi_device(struct =
device *dev)
 	return dev_name(dev);
 }
=20
-static void bmg160_disable_regulators(void *d)
-{
-	struct bmg160_data *data =3D d;
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
-}
-
 int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name)
 {
 	struct bmg160_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	static const char * const regulators[] =3D {"vdd", "vddio"};
=20
 	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -1090,22 +1083,11 @@ int bmg160_core_probe(struct device *dev, struct re=
gmap *regmap, int irq,
 	data->irq =3D irq;
 	data->regmap =3D regmap;
=20
-	data->regulators[0].supply =3D "vdd";
-	data->regulators[1].supply =3D "vddio";
-	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
-				      data->regulators);
+	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get regulators\n");
=20
-	ret =3D regulator_bulk_enable(ARRAY_SIZE(data->regulators),
-				    data->regulators);
-	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(dev, bmg160_disable_regulators, data);
-	if (ret)
-		return ret;
-
 	ret =3D iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx.h
index a86dd29a4738..03238c64c777 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -372,7 +372,6 @@ struct st_lsm6dsx_sensor {
  * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
  * @dev: Pointer to instance of struct device (I2C or SPI).
  * @regmap: Register map of the device.
- * @regulators: VDD/VDDIO voltage regulators.
  * @irq: Device interrupt line (I2C or SPI).
  * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
  * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
@@ -395,7 +394,6 @@ struct st_lsm6dsx_sensor {
 struct st_lsm6dsx_hw {
 	struct device *dev;
 	struct regmap *regmap;
-	struct regulator_bulk_data regulators[2];
 	int irq;
=20
 	struct mutex fifo_lock;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 910397716833..7b40f6b58834 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2172,36 +2172,20 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_h=
w *hw)
=20
 static int st_lsm6dsx_init_regulators(struct device *dev)
 {
-	struct st_lsm6dsx_hw *hw =3D dev_get_drvdata(dev);
 	int err;
-
 	/* vdd-vddio power regulators */
-	hw->regulators[0].supply =3D "vdd";
-	hw->regulators[1].supply =3D "vddio";
-	err =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(hw->regulators),
-				      hw->regulators);
-	if (err)
-		return dev_err_probe(dev, err, "failed to get regulators\n");
+	static const char * const regulators[] =3D {"vdd", "vddio"};
=20
-	err =3D regulator_bulk_enable(ARRAY_SIZE(hw->regulators),
-				    hw->regulators);
-	if (err) {
-		dev_err(dev, "failed to enable regulators: %d\n", err);
-		return err;
-	}
+	err =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (err)
+		return dev_err_probe(dev, err, "failed to enable regulators\n");
=20
 	msleep(50);
=20
 	return 0;
 }
=20
-static void st_lsm6dsx_chip_uninit(void *data)
-{
-	struct st_lsm6dsx_hw *hw =3D data;
-
-	regulator_bulk_disable(ARRAY_SIZE(hw->regulators), hw->regulators);
-}
-
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -2225,10 +2209,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, in=
t hw_id,
 	if (err)
 		return err;
=20
-	err =3D devm_add_action_or_reset(dev, st_lsm6dsx_chip_uninit, hw);
-	if (err)
-		return err;
-
 	hw->buff =3D devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
 	if (!hw->buff)
 		return -ENOMEM;
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

--SnNffchV/nAgRcji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2J3IACgkQeFA3/03a
ocW2Ugf9GtyiWREszLlcfd7XlOiqb0aI8GXb9PRuL4pev4jWGaTsClRml6uKBlVw
RQKfdrZrBrjfWhO6Ack3P5avUozowABn6AIyxR3iWldnFH7jF4/UAr6Q6LaRurMM
N9WkwgAFi86+ZGxbdM7r24liigHd2ltZnt8OQ0FEQSyFyvu/9Co7UrJ3eWdOYNmm
QKS+EJZTMC2TpSI0dLgVH6F9p3M53RN55hTwq4dNN/RKyLlmcq3xUHP+mfjDsoRa
4y7k6xHFU5ZTDWOq/PLjHTLjUCEGPv69ry0ezJ+JunAXwlq8q9B9w3Z+T9v5scBk
C2H0r3mup7RobLyOxbv7Q4rDeYG25w==
=xFzp
-----END PGP SIGNATURE-----

--SnNffchV/nAgRcji--
