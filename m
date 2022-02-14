Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4846D4B4062
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiBNDgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:36:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbiBNDgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:36:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA45549F;
        Sun, 13 Feb 2022 19:36:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id f6so5988116pfj.11;
        Sun, 13 Feb 2022 19:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nv4JMXgMO20d7B2ax+48GScvasA65BFCFc5OkzevOTQ=;
        b=qlE73LKY0kBePfGFTxDbJIXAQQeLmyp+GS/34vW7PPnrmzGfnXQLcZJ/qRC0kkQNcB
         fF8k3/lz9HiVxVLAEriZtY+/Bm3jfa1ATAddQRsy7/3458uy+jBzedIapK+bgZ9+ifPh
         6sRy4Wt6JZ+WRigwuxrB85Hda6VnTFmXDe/2GbIXRNwTMWmQo+qkmgTF0VYakketlk2G
         g6fAhXA09NWxPTQz6VQywo38TyL0weNR1KrYzpZzNIRc9AcTxrC6o8DU2LRnhKHmUU+f
         xPe/e7hP+kPw0iMV4RGWARexdm6lV8E9rbauXqFT8zuGw6Wgjga1E1oATntdmlnWhkOF
         XGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nv4JMXgMO20d7B2ax+48GScvasA65BFCFc5OkzevOTQ=;
        b=TVgu+XNeakrhD/lNH9ghBVdK9kucCJpeT3PxxJpXszHn3UYWvtFZBYtb9z8smOSYi6
         oGc3eiNsA0QGiC7z+UFkTOeLznmM/6xTFMPUXwkQluYlnJyaviOfya9zW1IRJg/znipp
         98ABSbclqVa5LfGbRog44lftwmSKJDJzZmUyrufufZqC3YjJNDpLdL2Xuvo352+SmumV
         d0cbKvA9VgpubbZeEEjP8g3LF0MnMLxqKahP4GT7Ri+g2ZH4Uf7qVnsuSaUQ4Gy0dVt5
         xPxKZCuFn15XcFvBtvN+2iShC7aW3x4PLpN/HOgrl/PxKiB7ndUM6KflCmEYOpRfPaku
         caLQ==
X-Gm-Message-State: AOAM532YUnjAW5HXExte1Zqrs6Agrjo5V/EOYKEhwgdDoKDk67Hy8zN+
        mOWXNaSJo8mj7axy7lMe1Gk=
X-Google-Smtp-Source: ABdhPJzo22jpHlKs2Q/5p+4d57dolvve3lfK53/i2MmdK+JcTaVF2vjUVEwfBXvLag8jWxxZAp5sqQ==
X-Received: by 2002:a63:8a:: with SMTP id 132mr10192837pga.338.1644809793069;
        Sun, 13 Feb 2022 19:36:33 -0800 (PST)
Received: from localhost.localdomain ([27.7.103.158])
        by smtp.gmail.com with ESMTPSA id me14sm36012pjb.41.2022.02.13.19.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:36:32 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iio: potentiometer: Add support for Maxim DS3502
Date:   Mon, 14 Feb 2022 09:06:19 +0530
Message-Id: <20220214033620.4059-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214033620.4059-1-jagathjog1996@gmail.com>
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
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
 drivers/iio/potentiometer/Kconfig  |   6 +-
 drivers/iio/potentiometer/ds1803.c | 101 ++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 832df8da2bc6..cd9aaceb15fe 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -27,11 +27,11 @@ config AD5272
 	  module will be called ad5272.
 
 config DS1803
-	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
+	tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"
 	depends on I2C
 	help
-	  Say yes here to build support for the Maxim Integrated DS1803
-	  digital potentiometer chip.
+	  Say yes here to build support for the Maxim Integrated DS1803 and
+	  similar digital potentiometer chip.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ds1803.
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index bccb9ccac931..0990536e7f36 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Maxim Integrated DS1803 digital potentiometer driver
+ * Maxim Integrated DS1803 and similar digital potentiometer driver
  * Copyright (c) 2016 Slawomir Stepien
+ * Copyright (c) 2022 Jagath Jog J
  *
  * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
  *
  * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
  * ds1803	2	256		10, 50, 100		0101xxx
+ * ds3502	1	128		10			01010xx
  */
 
 #include <linux/err.h>
@@ -16,44 +19,64 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 
-#define DS1803_MAX_POS		255
-#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
+#define DS1803_WIPER_0		0xA9
+#define DS1803_WIPER_1		0xAA
+#define DS3502_WR_IVR		0x00
 
 enum ds1803_type {
 	DS1803_010,
 	DS1803_050,
 	DS1803_100,
+	DS3502,
 };
 
 struct ds1803_cfg {
+	int wipers;
 	int kohms;
 	int avail[3];
-};
-
-static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
-	[DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
-	[DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
 };
 
 struct ds1803_data {
 	struct i2c_client *client;
 	const struct ds1803_cfg *cfg;
+	enum ds1803_type chip_type;
 };
 
-#define DS1803_CHANNEL(ch) {						\
+#define DS1803_CHANNEL(ch, addr) {					\
 	.type = IIO_RESISTANCE,						\
 	.indexed = 1,							\
 	.output = 1,							\
 	.channel = (ch),						\
+	.address = (addr),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),   \
 }
 
 static const struct iio_chan_spec ds1803_channels[] = {
-	DS1803_CHANNEL(0),
-	DS1803_CHANNEL(1),
+	DS1803_CHANNEL(0, DS1803_WIPER_0),
+	DS1803_CHANNEL(1, DS1803_WIPER_1),
+};
+
+static const struct iio_chan_spec ds3502_channels[] = {
+	DS1803_CHANNEL(0, DS3502_WR_IVR),
+};
+
+static const struct ds1803_cfg ds1803_cfg[] = {
+	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10,
+			 .channels = ds3502_channels,
+			 .num_channels = ARRAY_SIZE(ds3502_channels) },
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -67,17 +90,30 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_master_recv(data->client, result,
-				      indio_dev->num_channels);
-		if (ret < 0)
-			return ret;
-
-		*val = result[pot];
-		return IIO_VAL_INT;
+		switch (data->chip_type) {
+		case DS1803_010:
+		case DS1803_050:
+		case DS1803_100:
+			ret = i2c_master_recv(data->client, result,
+					      indio_dev->num_channels);
+			if (ret < 0)
+				return ret;
+			*val = result[pot];
+			return IIO_VAL_INT;
+		case DS3502:
+			ret = i2c_smbus_read_byte_data(data->client,
+						       chan->address);
+			if (ret < 0)
+				return ret;
+			*val = ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = DS1803_MAX_POS;
+		*val2 = data->cfg->avail[2]; /* Max wiper position */
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -89,21 +125,22 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
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
 			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
+	return i2c_smbus_write_byte_data(data->client, addr, val);
 }
 
 static int ds1803_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
@@ -142,20 +179,24 @@ static int ds1803_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->cfg = &ds1803_cfg[id->driver_data];
+	data->chip_type = (uintptr_t)device_get_match_data(dev);
+	if (data->chip_type < DS1803_010 || data->chip_type > DS3502)
+		data->chip_type = id->driver_data;
 
+	data->cfg = &ds1803_cfg[data->chip_type];
 	indio_dev->info = &ds1803_info;
-	indio_dev->channels = ds1803_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
+	indio_dev->channels = data->cfg->channels;
+	indio_dev->num_channels = data->cfg->num_channels;
 	indio_dev->name = client->name;
 
 	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id ds1803_dt_ids[] = {
-	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
-	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
-	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
+	{ .compatible = "maxim,ds1803-010", .data = (void *)DS1803_010 },
+	{ .compatible = "maxim,ds1803-050", .data = (void *)DS1803_050 },
+	{ .compatible = "maxim,ds1803-100", .data = (void *)DS1803_100 },
+	{ .compatible = "maxim,ds3502",     .data = (void *)DS3502 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
@@ -164,6 +205,7 @@ static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-010", DS1803_010 },
 	{ "ds1803-050", DS1803_050 },
 	{ "ds1803-100", DS1803_100 },
+	{ "ds3502",	DS3502	   },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
@@ -180,5 +222,6 @@ static struct i2c_driver ds1803_driver = {
 module_i2c_driver(ds1803_driver);
 
 MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_DESCRIPTION("DS1803 digital potentiometer");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

