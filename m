Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5094BB0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiBREVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBREVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:21:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE31AE2EA;
        Thu, 17 Feb 2022 20:20:57 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso7376450pjh.5;
        Thu, 17 Feb 2022 20:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fY4fw1P6g60UFW9BgNtnccPQ/82yWPQRO5vRCK+fANs=;
        b=ClCdP2CDl+Z+jFxnhyUJIcQ7+OoRriDR23TWylekktSYR4K/2d+OUFJRPJAbsgv3ea
         h4bC8ReUaU/D/dxxLqjkGnOL696ZaBG3OtkFoewqXaL0yGNA9fZX1HDALqkRdNNSiQTi
         8rdKK0LeaemLxNhVkD5IC6hOaOp7c1InhR7ufR0sBx9sszRTqHEbVMIuBhWbSLsVEmoQ
         5WktYa9itfPbNBxtbw0ElyO+LB2o/CZyw+GqTy8Lm2IOrruCm5JwAQA3C4R6Bd3UZ17u
         D9+fD9uDvWnCjnJPs1VewDz78/iqQ1/+OyE8695njdHuFK+TbZI40Ut0V3c2NqYk0gmE
         fQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fY4fw1P6g60UFW9BgNtnccPQ/82yWPQRO5vRCK+fANs=;
        b=RTQXhOBNWvWivPcGzNtfyaCzxx0Kg1RjflIzE7g/eqwKlkLZ14c0Zl+Ij55dgVPt6z
         KmdzQSdob1iVc6/zfSZM9AN6XH8E2PzoTps1fM0C+56sZIPGM/HIX+gqwTnI67A9LyZj
         Z6XUHxfaG2Iih3eEgmWmg24LKn20EJ2jxVrPC7FgTFxgPK9M9XS7xuzXZ11l3cr+8li/
         2nJF5DNASodbyH+hx/EU6Mvr62P4B2M1INCFqDQsS8z1HOnpfj/MGAjH8SAbdo4Tjrw6
         Hzvn+oDYzv5ruCsqtvI3Kee9yM7uu+H9ygyEUjfQdQRhduYhg4bjOQhsdCHOcsnEZTxF
         KbUQ==
X-Gm-Message-State: AOAM530UEC1isWpLX1ICMwYHJ1OATDdDdYXGYwFXgL7PF0vaRV/m4s4F
        A5X4NJO2DOQx+/wq3Cnqzm2mIBDqEaRa3EBA
X-Google-Smtp-Source: ABdhPJwjU060BnmToi8aTv75GIOWO/bO9dX92GyVfzNIP6IopoFtWxnQlJxge7H0+KRxXIwcHSGefg==
X-Received: by 2002:a17:90b:4391:b0:1b8:efac:58b6 with SMTP id in17-20020a17090b439100b001b8efac58b6mr10558860pjb.60.1645158057224;
        Thu, 17 Feb 2022 20:20:57 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:56 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] iio: potentiometer: Add support for Maxim DS3502
Date:   Fri, 18 Feb 2022 09:50:37 +0530
Message-Id: <20220218042038.15176-6-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218042038.15176-1-jagathjog1996@gmail.com>
References: <20220218042038.15176-1-jagathjog1996@gmail.com>
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
DS3502 support is implemented into existing DS1803 driver.
Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/Kconfig  |  6 ++--
 drivers/iio/potentiometer/ds1803.c | 46 ++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 832df8da2bc6..79c524640196 100644
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
+	  Say yes here to build support for the Maxim Integrated Devices DS1803 and
+	  DS3502 digital potentiometer chip.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ds1803.
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index ca28ad147402..ca903e9c2816 100644
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
@@ -18,11 +21,13 @@
 
 #define DS1803_WIPER_0         0xA9
 #define DS1803_WIPER_1         0xAA
+#define DS3502_WR_IVR          0x00
 
 enum ds1803_type {
 	DS1803_010,
 	DS1803_050,
 	DS1803_100,
+	DS3502,
 };
 
 struct ds1803_cfg {
@@ -36,6 +41,7 @@ struct ds1803_cfg {
 struct ds1803_data {
 	struct i2c_client *client;
 	const struct ds1803_cfg *cfg;
+	enum ds1803_type chip_type;
 };
 
 #define DS1803_CHANNEL(ch, addr) {					\
@@ -54,6 +60,10 @@ static const struct iio_chan_spec ds1803_channels[] = {
 	DS1803_CHANNEL(1, DS1803_WIPER_1),
 };
 
+static const struct iio_chan_spec ds3502_channels[] = {
+	DS1803_CHANNEL(0, DS3502_WR_IVR),
+};
+
 static const struct ds1803_cfg ds1803_cfg[] = {
 	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
 			 .channels = ds1803_channels,
@@ -64,6 +74,9 @@ static const struct ds1803_cfg ds1803_cfg[] = {
 	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
 			 .channels = ds1803_channels,
 			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10,
+			 .channels = ds3502_channels,
+			 .num_channels = ARRAY_SIZE(ds3502_channels) },
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -77,13 +90,26 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 
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
@@ -156,6 +182,7 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
 	if (!data->cfg)
 		data->cfg = &ds1803_cfg[id->driver_data];
 
+	data->chip_type = id->driver_data;
 	indio_dev->info = &ds1803_info;
 	indio_dev->channels = data->cfg->channels;
 	indio_dev->num_channels = data->cfg->num_channels;
@@ -168,6 +195,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
 	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
 	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
 	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
+	{ .compatible = "maxim,ds3502", .data = &ds1803_cfg[DS3502] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
@@ -176,6 +204,7 @@ static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-010", DS1803_010 },
 	{ "ds1803-050", DS1803_050 },
 	{ "ds1803-100", DS1803_100 },
+	{ "ds3502", DS3502 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
@@ -192,5 +221,6 @@ static struct i2c_driver ds1803_driver = {
 module_i2c_driver(ds1803_driver);
 
 MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_DESCRIPTION("DS1803 digital potentiometer");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

