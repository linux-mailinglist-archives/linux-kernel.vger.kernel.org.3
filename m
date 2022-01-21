Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE524961F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381540AbiAUPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381535AbiAUPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 063E21F46210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778488;
        bh=TbuvCyeFhQOeUscmwg0p9HgBI6FntNsxNfpdvpXAuvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bgriqk+JmX5EK0FhTqFDacVC/CWtrqugH/idVD53731OVDRNTrTAFnsB5oZ7qs7AP
         QjoPiXZrUehxuMA4BtJ1Hy5huNp2RGli03uu9ZEKzYCKBL9mpMrJCDh+nBtruM2yda
         ih/b06Bjc8doYCi/9QOFtpxeb3tzrSCtgFr2QavBv+xvIIzrnsa5jU4F9Ot7TxgjYW
         KLhi5zjeI7zLKk0E2fxIozUiQkCiLBx0MKlzaq2O2LNm98olOarjE4BEq5GasmEZ9z
         CrXp8tS8C7Rd2ogRdcJoFO7q27Xz/QAUGaZ8DFACw5cKa+BjY9FeUTFlUdqaLEacjt
         0jWogHk+CJvUg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/9] regulator: rpi-panel: Handle I2C errors/timing to the Atmel
Date:   Fri, 21 Jan 2022 10:20:49 -0500
Message-Id: <20220121152056.2044551-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121152056.2044551-1-detlev.casanova@collabora.com>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The Atmel is doing some things in the I2C ISR, during which
period it will not respond to further commands. This is
particularly true of the POWERON command.

Increase delays appropriately, and retry should I2C errors be
reported.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../regulator/rpi-panel-attiny-regulator.c    | 56 +++++++++++++++----
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 370b9ae363dd..00fb69efcfa2 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -37,11 +37,24 @@ static const struct regmap_config attiny_regmap_config = {
 static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 {
 	unsigned int data;
+	int ret, i;
 
 	regmap_write(rdev->regmap, REG_POWERON, 1);
+	msleep(80);
+
 	/* Wait for nPWRDWN to go low to indicate poweron is done. */
-	regmap_read_poll_timeout(rdev->regmap, REG_PORTB, data,
-					data & BIT(0), 10, 1000000);
+	for (i = 0; i < 20; i++) {
+		ret = regmap_read(rdev->regmap, REG_PORTB, &data);
+		if (!ret) {
+			if (data & BIT(0))
+				break;
+		}
+		usleep_range(10000, 12000);
+	}
+	usleep_range(10000, 12000);
+
+	if (ret)
+		pr_err("%s: regmap_read_poll_timeout failed %d\n", __func__, ret);
 
 	/* Default to the same orientation as the closed source
 	 * firmware used for the panel.  Runtime rotation
@@ -57,23 +70,34 @@ static int attiny_lcd_power_disable(struct regulator_dev *rdev)
 {
 	regmap_write(rdev->regmap, REG_PWM, 0);
 	regmap_write(rdev->regmap, REG_POWERON, 0);
-	udelay(1);
+	msleep(30);
 	return 0;
 }
 
 static int attiny_lcd_power_is_enabled(struct regulator_dev *rdev)
 {
 	unsigned int data;
-	int ret;
+	int ret, i;
 
-	ret = regmap_read(rdev->regmap, REG_POWERON, &data);
+	for (i = 0; i < 10; i++) {
+		ret = regmap_read(rdev->regmap, REG_POWERON, &data);
+		if (!ret)
+			break;
+		usleep_range(10000, 12000);
+	}
 	if (ret < 0)
 		return ret;
 
 	if (!(data & BIT(0)))
 		return 0;
 
-	ret = regmap_read(rdev->regmap, REG_PORTB, &data);
+	for (i = 0; i < 10; i++) {
+		ret = regmap_read(rdev->regmap, REG_PORTB, &data);
+		if (!ret)
+			break;
+		usleep_range(10000, 12000);
+	}
+
 	if (ret < 0)
 		return ret;
 
@@ -103,20 +127,32 @@ static int attiny_update_status(struct backlight_device *bl)
 {
 	struct regmap *regmap = bl_get_data(bl);
 	int brightness = bl->props.brightness;
+	int ret, i;
 
 	if (bl->props.power != FB_BLANK_UNBLANK ||
 	    bl->props.fb_blank != FB_BLANK_UNBLANK)
 		brightness = 0;
 
-	return regmap_write(regmap, REG_PWM, brightness);
+	for (i = 0; i < 10; i++) {
+		ret = regmap_write(regmap, REG_PWM, brightness);
+		if (!ret)
+			break;
+	}
+
+	return ret;
 }
 
 static int attiny_get_brightness(struct backlight_device *bl)
 {
 	struct regmap *regmap = bl_get_data(bl);
-	int ret, brightness;
+	int ret, brightness, i;
+
+	for (i = 0; i < 10; i++) {
+		ret = regmap_read(regmap, REG_PWM, &brightness);
+		if (!ret)
+			break;
+	}
 
-	ret = regmap_read(regmap, REG_PWM, &brightness);
 	if (ret)
 		return ret;
 
@@ -166,7 +202,7 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 	}
 
 	regmap_write(regmap, REG_POWERON, 0);
-	mdelay(1);
+	msleep(30);
 
 	config.dev = &i2c->dev;
 	config.regmap = regmap;
-- 
2.34.1

