Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852834AB3F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiBGFuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351166AbiBGEEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:04:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B5C043180;
        Sun,  6 Feb 2022 20:04:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso2649308pjg.0;
        Sun, 06 Feb 2022 20:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16v0cC1TvpKhlFbTNq1A18dbL8TX/lGmAdN0x49ucuc=;
        b=YBzJmObXlO3nu/xcZSjYigtBCOdcVkVI7++1MWimj3x4sxZVv4tuLnKHIWbmttgnfu
         5BiffbdWgh3R7WrmsTQzlpe1XY4MX0eLPVCmOGU1jdySmBJHGEzn4H3A7wj20uIimQrX
         AjEp2SVT3oApu5TVPQnXUiCy40K1Cm4HeeLZxdcEJhnLlMQci2vo47bA8Zd4GVeZYFMI
         q3PjmqcHcUdr24a2w/XvtrYz3TI7OC8DQW2wT1XHoAfdWxYbjsYoMNtXlyU4A7cjxjU5
         8k9f7eZDjvtmxBTZIenH50hq/wWEXzVjQqfTBuh0PP+oaYvA91+pbdT9JbYCj5P08/AD
         CD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=16v0cC1TvpKhlFbTNq1A18dbL8TX/lGmAdN0x49ucuc=;
        b=JOCzDA84iUQrw22Ul5lRNcVSvLmpELIlPy6mMbl3H83dJq9Hx4Ud0sC2VpERwxS5wu
         29OPQgdBjAvDJhDKbURlR4w8Ig9KK2s8ep8KBjsa5vgT4WvZSQwX2bV8siVM6rt6gd2y
         tsNCiPPvtnWxZ54z0yM49TkCtZxZ3t/uDA6DKNXdRI118BzGNTrs61+AKesQzQHI+Iqn
         3iy0hXkq7auBRdxBNl1ztWkIqeDSumuJPaO1RL1EELfKjZYXlUb4Wf5PxDT3r3Fpj2Fu
         yc5ij8FtIfJVFUzIQmX17qrpZ5plZIFwapbAgsayhujgWzHHWLcMR7W+AefyT1OUfgW8
         2g1g==
X-Gm-Message-State: AOAM533dF+6lgbF+VRrNN5eBlNeCc1Vgi+Yfz/hDP3Q8WM4deI55RkrF
        5+v8kvXK6369C/YLLn2w9aM=
X-Google-Smtp-Source: ABdhPJyyzhCLWwzxQt2xfOIIPRPYd3U8JsrS7xz8kNwQgrN0D4pB+eAoZxL/CV6twQGXaEo9qUg0Cw==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr12102473pjq.68.1644206659029;
        Sun, 06 Feb 2022 20:04:19 -0800 (PST)
Received: from localhost.localdomain ([27.7.146.135])
        by smtp.gmail.com with ESMTPSA id j18sm10601234pfj.13.2022.02.06.20.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 20:04:18 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: potentiometer: Add support for Maxim DS3502
Date:   Mon,  7 Feb 2022 09:34:08 +0530
Message-Id: <20220207040408.4273-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207040408.4273-1-jagathjog1996@gmail.com>
References: <20220207040408.4273-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
an output voltage range of up to 15.5V.
DS3502 support is implemented into existing ds1803 driver

Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/Kconfig  |   4 +-
 drivers/iio/potentiometer/ds1803.c | 150 +++++++++++++++++++++++------
 2 files changed, 120 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 832df8da2bc6..1741af33672c 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -27,10 +27,10 @@ config AD5272
 	  module will be called ad5272.
 
 config DS1803
-	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
+	tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"
 	depends on I2C
 	help
-	  Say yes here to build support for the Maxim Integrated DS1803
+	  Say yes here to build support for the Maxim Integrated DS1803 and DS3502
 	  digital potentiometer chip.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 20b45407eaac..5e403e3400f7 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Maxim Integrated DS1803 digital potentiometer driver
+ * Maxim Integrated DS1803 and DS3502 digital potentiometer driver
  * Copyright (c) 2016 Slawomir Stepien
+ * Copyright (c) 2022 Jagath Jog J
  *
  * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
  *
  * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
  * ds1803	2	256		10, 50, 100		0101xxx
+ * DS3502       1       128             10                      01010xx
  */
 
 #include <linux/err.h>
@@ -16,47 +19,88 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 
-#define DS1803_MAX_POS		255
-#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
+#define DS1803_WIPER_0		(0xA9)
+#define DS1803_WIPER_1		(0xAA)
+#define DS3502_WR_IVR		(0x00)
+#define DS3502_CR               (0x02)
+#define DS3502_MODE0		(0x00)
+#define DS3502_MODE1		(0x80)
 
 enum ds1803_type {
 	DS1803_010,
 	DS1803_050,
 	DS1803_100,
+	DS3502,
 };
 
 struct ds1803_cfg {
+	int wipers;
+	int avail[3];
 	int kohms;
 };
 
 static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .kohms =  10, },
-	[DS1803_050] = { .kohms =  50, },
-	[DS1803_100] = { .kohms = 100, },
+	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10, },
+	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50, },
+	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100, },
+	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10, },
+};
+
+struct maxim_potentiometer {
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
 };
 
 struct ds1803_data {
 	struct i2c_client *client;
+	enum ds1803_type chip_type;
 	const struct ds1803_cfg *cfg;
+	const struct maxim_potentiometer *chip;
 };
 
-#define DS1803_CHANNEL(ch) {					\
-	.type = IIO_RESISTANCE,					\
-	.indexed = 1,						\
-	.output = 1,						\
-	.channel = (ch),					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+#define DS1803_CHANNEL(ch, addr) {					\
+	.type = IIO_RESISTANCE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (ch),						\
+	.address = (addr),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),	\
 }
 
 static const struct iio_chan_spec ds1803_channels[] = {
-	DS1803_CHANNEL(0),
-	DS1803_CHANNEL(1),
+	DS1803_CHANNEL(0, DS1803_WIPER_0),
+	DS1803_CHANNEL(1, DS1803_WIPER_1),
+};
+
+static const struct iio_chan_spec ds3502_channels[] = {
+	{
+		.type = IIO_RESISTANCE,
+		.indexed = 1,
+		.output = 1,
+		.channel = 0,
+		.address = (DS3502_WR_IVR),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_ENABLE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static const struct maxim_potentiometer maxim_potentiometer_chips[] = {
+	[DS1803_100] = {
+				.channels = ds1803_channels,
+				.num_channels = ARRAY_SIZE(ds1803_channels),
+		},
+	[DS3502]     = {
+				.channels = ds3502_channels,
+				.num_channels = ARRAY_SIZE(ds3502_channels),
+		},
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int *val, int *val2, long mask)
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
@@ -65,17 +109,28 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_master_recv(data->client, result,
-				indio_dev->num_channels);
+		switch (data->chip_type) {
+		case DS1803_010:
+		case DS1803_050:
+		case DS1803_100:
+			ret = i2c_master_recv(data->client, result,
+					      indio_dev->num_channels);
+			*val = result[pot];
+			break;
+		case DS3502:
+			ret = i2c_smbus_read_byte_data(data->client, chan->address);
+			*val = ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+
 		if (ret < 0)
 			return ret;
-
-		*val = result[pot];
 		return IIO_VAL_INT;
-
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = DS1803_MAX_POS;
+		*val2 = data->cfg->avail[2];
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -83,38 +138,64 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 }
 
 static int ds1803_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
-	int pot = chan->channel;
+	int max_pos = data->cfg->avail[2];
+	u8 addr = chan->address;
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > DS1803_MAX_POS || val < 0)
+		if (val > max_pos || val < 0)
+			return -EINVAL;
+		break;
+	case IIO_CHAN_INFO_ENABLE:
+		if (val == 1)
+			val = DS3502_MODE1;
+		else if (val != DS3502_MODE0)
 			return -EINVAL;
+		addr = DS3502_CR;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
+	return i2c_smbus_write_byte_data(data->client, addr, val);
+}
+
+static int ds1803_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length, long mask)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = data->cfg->avail;
+		*length = ARRAY_SIZE(data->cfg->avail);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	}
+	return -EINVAL;
 }
 
 static const struct iio_info ds1803_info = {
 	.read_raw = ds1803_read_raw,
+	.read_avail = ds1803_read_avail,
 	.write_raw = ds1803_write_raw,
 };
 
 static int ds1803_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct ds1803_data *data;
 	struct iio_dev *indio_dev;
+	enum ds1803_type chip_type = (id->driver_data <= DS1803_100 ? DS1803_100 : DS3502);
+	const struct maxim_potentiometer *chip = &maxim_potentiometer_chips[chip_type];
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -125,10 +206,12 @@ static int ds1803_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	data->cfg = &ds1803_cfg[id->driver_data];
+	data->chip = chip;
+	data->chip_type = chip_type;
 
 	indio_dev->info = &ds1803_info;
-	indio_dev->channels = ds1803_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
+	indio_dev->channels = chip->channels;
+	indio_dev->num_channels = chip->num_channels;
 	indio_dev->name = client->name;
 
 	return devm_iio_device_register(dev, indio_dev);
@@ -138,6 +221,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
 	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
 	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
 	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
+	{ .compatible = "maxim,ds3502",     .data = &ds1803_cfg[DS3502] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
@@ -146,6 +230,7 @@ static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-010", DS1803_010 },
 	{ "ds1803-050", DS1803_050 },
 	{ "ds1803-100", DS1803_100 },
+	{ "ds3502",	DS3502	   },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
@@ -162,5 +247,6 @@ static struct i2c_driver ds1803_driver = {
 module_i2c_driver(ds1803_driver);
 
 MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
-MODULE_DESCRIPTION("DS1803 digital potentiometer");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
+MODULE_DESCRIPTION("DS1803 and DS3502 digital potentiometer");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

