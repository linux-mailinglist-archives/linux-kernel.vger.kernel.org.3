Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CE5A603C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiH3KF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH3KEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:04:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A398FE97D6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so14799101lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NyEmf2M1e+Cx8yVp7xvweK7vYjjHIieJMUUkfw92hEY=;
        b=HRagqWs0uKyJkWHrB2/entSi7Eu0TwHPuZmaL2kRvIbisCwzHxg5zwxVL3VCTH3u+d
         wMXgWB2+7mfoYhOiKiU93oMdF5EVZ7++5NpPPF/wijxFde2QPf/QiJ1V2VQHXbmxfkke
         UwmEQUvH53b0ohb8szDEM2Hlmb780LRI8mIGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NyEmf2M1e+Cx8yVp7xvweK7vYjjHIieJMUUkfw92hEY=;
        b=wW/kkXGNXRJVHQHvvvjS6bbAjHQr3dPykcGtKL0FWiQWrUNlST1rMxQWj5qMrj8aQm
         nGhnGkZ9eX27glHr8S3Z4v1aga1k37ke1FVFa8UWvQRxXUd50E6Pb8296fNyyUeyaKrx
         Pv2Pp3RibVHRWPEnZntnJ8dKsESo2FCIoiuDkU7MhH6H6q4tJlc10lwfyFLWToN3iFuu
         H6vX6ZNBU7EYf8lmKPy7EAI1FgqTQPbmuGDEpBy3Zz7Aq7KvumjCHbf10YHxnwrg64nJ
         /yqbb4hV0zf4t01YP2d2+D5NvkXRLbRkvDMb5smCKHbe8UbJi2w6c5Vo2gPBCvLkhTQ4
         6J0Q==
X-Gm-Message-State: ACgBeo2bWzcl8Gs1kapdUqQHVfj1libpBIp04k6msf733VN8QG12Y3Bf
        QXRElY/sO4JfN4ifgtC7Oe+AmA==
X-Google-Smtp-Source: AA6agR5OOhhSHRmZqPkpMLXmGQ2lnHNpMqz/ph3dJYMjZscgAnvOYzwtHQ+7Dz/mAE6FFjlEQZZe+w==
X-Received: by 2002:a05:6512:6d5:b0:491:a52b:2a47 with SMTP id u21-20020a05651206d500b00491a52b2a47mr7293215lff.608.1661853727873;
        Tue, 30 Aug 2022 03:02:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm1573435lfg.14.2022.08.30.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:02:07 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] rtc: isl12022: switch to using regmap API
Date:   Tue, 30 Aug 2022 12:01:51 +0200
Message-Id: <20220830100152.698506-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap abstraction allows us to avoid the private i2c transfer
helpers, and also offers some nice utility functions such as the
regmap_update_bits family.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/Kconfig        |   1 +
 drivers/rtc/rtc-isl12022.c | 101 +++++++++----------------------------
 2 files changed, 26 insertions(+), 76 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b8de25118ad0..bb63edb507da 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -423,6 +423,7 @@ config RTC_DRV_ISL1208
 
 config RTC_DRV_ISL12022
 	tristate "Intersil ISL12022"
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the
 	  Intersil ISL12022 RTC chip.
diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 659f8e7f33f0..b295ec92ee17 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 
 /* ISL register offsets */
 #define ISL12022_REG_SC		0x00
@@ -42,72 +43,23 @@ static struct i2c_driver isl12022_driver;
 
 struct isl12022 {
 	struct rtc_device *rtc;
+	struct regmap *regmap;
 
 	bool write_enabled;	/* true if write enable is set */
 };
 
-
-static int isl12022_read_regs(struct i2c_client *client, uint8_t reg,
-			      uint8_t *data, size_t n)
-{
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= data
-		},		/* setup read ptr */
-		{
-			.addr	= client->addr,
-			.flags	= I2C_M_RD,
-			.len	= n,
-			.buf	= data
-		}
-	};
-
-	int ret;
-
-	data[0] = reg;
-	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
-	if (ret != ARRAY_SIZE(msgs)) {
-		dev_err(&client->dev, "%s: read error, ret=%d\n",
-			__func__, ret);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-
-static int isl12022_write_reg(struct i2c_client *client,
-			      uint8_t reg, uint8_t val)
-{
-	uint8_t data[2] = { reg, val };
-	int err;
-
-	err = i2c_master_send(client, data, sizeof(data));
-	if (err != sizeof(data)) {
-		dev_err(&client->dev,
-			"%s: err=%d addr=%02x, data=%02x\n",
-			__func__, err, data[0], data[1]);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-
 /*
  * In the routines that deal directly with the isl12022 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
  */
 static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct isl12022 *isl12022 = dev_get_drvdata(dev);
+	struct regmap *regmap = isl12022->regmap;
 	uint8_t buf[ISL12022_REG_INT + 1];
 	int ret;
 
-	ret = isl12022_read_regs(client, ISL12022_REG_SC, buf, sizeof(buf));
+	ret = regmap_bulk_read(regmap, ISL12022_REG_SC, buf, sizeof(buf));
 	if (ret)
 		return ret;
 
@@ -152,9 +104,8 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct isl12022 *isl12022 = dev_get_drvdata(dev);
-	size_t i;
+	struct regmap *regmap = isl12022->regmap;
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
 
@@ -165,24 +116,17 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
 	if (!isl12022->write_enabled) {
+		bool change;
 
-		ret = isl12022_read_regs(client, ISL12022_REG_INT, buf, 1);
+		ret = regmap_update_bits_check(regmap, ISL12022_REG_INT,
+					       ISL12022_INT_WRTC, ISL12022_INT_WRTC,
+					       &change);
 		if (ret)
 			return ret;
 
-		/* Check if WRTC (write rtc enable) is set factory default is
-		 * 0 (not set) */
-		if (!(buf[0] & ISL12022_INT_WRTC)) {
+		if (change)
 			dev_info(dev, "init write enable\n");
 
-			/* Set the write enable bit. */
-			ret = isl12022_write_reg(client,
-						 ISL12022_REG_INT,
-						 buf[0] | ISL12022_INT_WRTC);
-			if (ret)
-				return ret;
-		}
-
 		isl12022->write_enabled = true;
 	}
 
@@ -201,15 +145,8 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	buf[ISL12022_REG_DW] = tm->tm_wday & 0x07;
 
-	/* write register's data */
-	for (i = 0; i < ARRAY_SIZE(buf); i++) {
-		ret = isl12022_write_reg(client, ISL12022_REG_SC + i,
-					 buf[ISL12022_REG_SC + i]);
-		if (ret)
-			return -EIO;
-	}
-
-	return 0;
+	return regmap_bulk_write(isl12022->regmap, ISL12022_REG_SC,
+				 buf, sizeof(buf));
 }
 
 static const struct rtc_class_ops isl12022_rtc_ops = {
@@ -217,6 +154,12 @@ static const struct rtc_class_ops isl12022_rtc_ops = {
 	.set_time	= isl12022_rtc_set_time,
 };
 
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_write = true,
+};
+
 static int isl12022_probe(struct i2c_client *client)
 {
 	struct isl12022 *isl12022;
@@ -230,6 +173,12 @@ static int isl12022_probe(struct i2c_client *client)
 		return -ENOMEM;
 	dev_set_drvdata(&client->dev, isl12022);
 
+	isl12022->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(isl12022->regmap)) {
+		dev_err(&client->dev, "regmap allocation failed\n");
+		return PTR_ERR(isl12022->regmap);
+	}
+
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
 		return PTR_ERR(isl12022->rtc);
-- 
2.37.2

