Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8914BCBCC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiBTCr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbiBTCrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:47:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB12377C0;
        Sat, 19 Feb 2022 18:46:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 27so6011637pgk.10;
        Sat, 19 Feb 2022 18:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8mw4ee1LJrxfyyuuaxhOLEBcGc/sqxiZHRacFpkmAkA=;
        b=AY7W9Q5GaUl50IhGEv8vu9lDJWDqtFUawuJxwqKrn0lkz2LdKvgjrvhDzTJa7rk9ZQ
         iQrT14ckj2mlwiLfBOyHNOl4qMTxIv34l+tzrTEIhRwUR1Fi1Rla18c3+ytYfltY2wqw
         ZuGub9elSce+xP95oYxgMf+U7oc4kISu0JWxCBPlRMMtTgjrcolpnuEFLKyomOI9gDGJ
         Yimhcw89fwx+7jlU5DvC8rqPnjhWCDS8AjClZxgc6OL6ih50x7DxzRHCRAZaRd6K3GKx
         f7MOrC3pU8Q938dfZjueNKFgLCM++z6oiGiCgdcelBp3oqMXchwY+LpD0sO5I56jrl83
         /p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8mw4ee1LJrxfyyuuaxhOLEBcGc/sqxiZHRacFpkmAkA=;
        b=adv4FktbX+9+RKeJ02kGFHh0ILl72ujusJN8CN5He5do2rLAdsM7x9Eu5DalSjIugx
         MVK4xxH1dRN91LZ3OHpZXWU/4Jl6KoPLZrGpOgeW6qBC5d9JZObsOnhr8qWr3Oi+t4LY
         SvCDhU6cBreNjIu12F1VDCz4lN/m9+NrEw2wdJ+ty+2X3M4mbXejqcdlPJf8wWfasnJk
         QFNV5zaZRwZZcE+cEkv1wP+OOzw91HBA92hnkTwSuF5o1kyRj2NqJ2tKXl74Efeyl6jX
         JgnC1ygB+i8W0WIEDBfJh8yY3fFWPo7QpQHUbFNAesrwaSnH8LkJRNpT6n0PPfNE0Jbw
         0YYA==
X-Gm-Message-State: AOAM530DFs3QVmgy/X/3V9w7zN2mpM2XWHWCho8AvriYWpoAsrCU3n6L
        tgDqQ1uyMjznZrD0AdKKsPo=
X-Google-Smtp-Source: ABdhPJwXxmkznixH0ltMhBA3nqjmCtnIw1nOySQM06n++/BtLwhf5J9XaZGPbesn6fukINyzM1vVhw==
X-Received: by 2002:a63:161c:0:b0:372:e459:70e6 with SMTP id w28-20020a63161c000000b00372e45970e6mr11496080pgl.596.1645325212762;
        Sat, 19 Feb 2022 18:46:52 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:52 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] iio: potentiometer: Add support for Maxim DS3502
Date:   Sun, 20 Feb 2022 08:16:31 +0530
Message-Id: <20220220024632.4183-7-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
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
 drivers/iio/potentiometer/Kconfig  |  6 +++---
 drivers/iio/potentiometer/ds1803.c | 33 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

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
index 1d6175dc4319..e1e0e81270c0 100644
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
@@ -56,6 +61,10 @@ static const struct iio_chan_spec ds1803_channels[] = {
 	DS1803_CHANNEL(1, DS1803_WIPER_1),
 };
 
+static const struct iio_chan_spec ds3502_channels[] = {
+	DS1803_CHANNEL(0, DS3502_WR_IVR),
+};
+
 static int ds1803_read(struct iio_dev *indio_dev,
 		       struct iio_chan_spec const *chan,
 		       int *val)
@@ -72,6 +81,21 @@ static int ds1803_read(struct iio_dev *indio_dev,
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
 	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
 			 .channels = ds1803_channels,
@@ -85,6 +109,10 @@ static const struct ds1803_cfg ds1803_cfg[] = {
 			 .channels = ds1803_channels,
 			 .num_channels = ARRAY_SIZE(ds1803_channels),
 			 .read = ds1803_read },
+	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10,
+			 .channels = ds3502_channels,
+			 .num_channels = ARRAY_SIZE(ds3502_channels),
+			 .read = ds3502_read },
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -186,6 +214,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
 	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
 	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
 	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
+	{ .compatible = "maxim,ds3502", .data = &ds1803_cfg[DS3502] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
@@ -194,6 +223,7 @@ static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-010", DS1803_010 },
 	{ "ds1803-050", DS1803_050 },
 	{ "ds1803-100", DS1803_100 },
+	{ "ds3502", DS3502 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
@@ -210,5 +240,6 @@ static struct i2c_driver ds1803_driver = {
 module_i2c_driver(ds1803_driver);
 
 MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_DESCRIPTION("DS1803 digital potentiometer");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

