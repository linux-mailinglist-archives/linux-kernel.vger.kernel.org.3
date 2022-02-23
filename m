Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2514C18BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiBWQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiBWQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F656C06;
        Wed, 23 Feb 2022 08:35:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e13so1557745plh.3;
        Wed, 23 Feb 2022 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCt65LTa8zW6DS3Nb8ZpZQR8g7aGxwmOYcejdqUg5PU=;
        b=hZjKkv1gvycJnJIzNRcDfYHHryzx2OGSF8uprtAAuYsdshuAIWZUHki2WcHYGKurH6
         2IPxLjvUxQYkcQESkbga/T0NZaGW4kiU2SKyu5rVIpQTW5zThLGODxhfsO6mLrK9amik
         VwZk1+01aRfsjb7UD3NWqVj6CpHn1K3DZDllQfiw1dM8DyKaHwwbSJejSWSR9dVD18gV
         fvhHfO6SYGzP73YcbCx75PaHdDJp84Q8JHRqd5RsNhfBzP471/yWbsUUuIDM1hjpzpyc
         M87GyigX3YXmrzaa4ZRET7vGGj9vI6KCQMe+NfWYKFItZQm1eTpy3qCTRViVGqqO8zMC
         oO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCt65LTa8zW6DS3Nb8ZpZQR8g7aGxwmOYcejdqUg5PU=;
        b=PLiktwDIfQ/6LQPUdU996jKqylMLnM0TSL1HgxNq7CGVO1DwB762rGOKvpTeb9UMfI
         nWETMRYtDDdAxq2WtQJxfc7XmSK1rq/e9lyWQ4uy85G7WN+E0Ono30eEJYkyec6/xDyN
         InmUCdmeQJjZ2AhboVE8YCtBu2cp34wJb0nbrkvc22wpp0623pgAbbYdFuqFGP0SFf0U
         0Egc4GR4PAqUuN4C1O7e0vrsb1rXO+8brMczFsk0LgR8n6SHD77Du6grntoLGf0h1are
         51x3MtjqDoIsUj/d+kptXjQAJyxb5jS5c936p6/CA2W5Ft/X/q5NDNL0h+RCyFQ/X4Gq
         wV1w==
X-Gm-Message-State: AOAM531fflG5u56UBx1ooHCVw/7WIjwb+1UBUgp/JUczVDVZGNcKmC4A
        yVtCiHW4O033pBvoBFRbwOa1m9qJtZd48GMc
X-Google-Smtp-Source: ABdhPJxPOZrMzxejDhmaNCrS5/WxAUEmIFBPPBqwn2W95RQn8+D1QGZquM65JT4EJn8yURZQGvtHUg==
X-Received: by 2002:a17:902:a98b:b0:14f:ae28:c660 with SMTP id bh11-20020a170902a98b00b0014fae28c660mr431352plb.94.1645634152030;
        Wed, 23 Feb 2022 08:35:52 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:51 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] iio: potentiometer: Add support for Maxim DS3502
Date:   Wed, 23 Feb 2022 22:05:24 +0530
Message-Id: <20220223163525.13399-7-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
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
an output voltage range of up to 15.5V. DS3502 support is added
into existing DS1803 driver.

Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/Kconfig  |  6 ++---
 drivers/iio/potentiometer/ds1803.c | 37 +++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 832df8da2bc6..01dd3f858d99 100644
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
+	  DS3502 digital potentiometer chip.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ds1803.
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 878188351f8f..81456b7d314b 100644
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
@@ -19,11 +22,13 @@
 
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
@@ -57,6 +62,10 @@ static const struct iio_chan_spec ds1803_channels[] = {
 	DS1803_CHANNEL(1, DS1803_WIPER_1),
 };
 
+static const struct iio_chan_spec ds3502_channels[] = {
+	DS1803_CHANNEL(0, DS3502_WR_IVR),
+};
+
 static int ds1803_read(struct iio_dev *indio_dev,
 		       struct iio_chan_spec const *chan,
 		       int *val)
@@ -73,6 +82,21 @@ static int ds1803_read(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ds3502_read(struct iio_dev *indio_dev,
+		       struct iio_chan_spec const *chan,
+		       int *val)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, chan->address);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return ret;
+}
+
 static const struct ds1803_cfg ds1803_cfg[] = {
 	[DS1803_010] = {
 	  .wipers = 2,
@@ -98,6 +122,14 @@ static const struct ds1803_cfg ds1803_cfg[] = {
 	  .num_channels = ARRAY_SIZE(ds1803_channels),
 	  .read = ds1803_read,
 	},
+	[DS3502] = {
+	  .wipers = 1,
+	  .avail = { 0, 1, 127 },
+	  .kohms =  10,
+	  .channels = ds3502_channels,
+	  .num_channels = ARRAY_SIZE(ds3502_channels),
+	  .read = ds3502_read,
+	},
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -199,6 +231,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
 	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
 	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
 	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
+	{ .compatible = "maxim,ds3502", .data = &ds1803_cfg[DS3502] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
@@ -207,6 +240,7 @@ static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-010", DS1803_010 },
 	{ "ds1803-050", DS1803_050 },
 	{ "ds1803-100", DS1803_100 },
+	{ "ds3502", DS3502 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
@@ -223,5 +257,6 @@ static struct i2c_driver ds1803_driver = {
 module_i2c_driver(ds1803_driver);
 
 MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_DESCRIPTION("DS1803 digital potentiometer");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

