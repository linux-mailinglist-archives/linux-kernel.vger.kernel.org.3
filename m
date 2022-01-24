Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA549A7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315572AbiAYCxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374224AbiAYAQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:16:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFDC038AF1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:01:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id E1DB41F438F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643061700;
        bh=Aho1tR4hmf+9rCfrJot4fBHsOTXqSf7FX4Duswh2g2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0sPGnx59UbDM0j9YK830cyRBXWpZpelPvzc/PkIkz0U9CLcoLwmedLjofkTecKRC
         nzDyqZ3CONtZEveFqKq3F22m5OC0TJctHgC2T7JBmHtzv4NA2aDwGU3GmWAWKjY6uh
         KBDk0hTeN8l0sac1F0Wk8KX+TP5Hoi1epLwDiBrGdu0kSNk0BIsjnYAgPUamfBuTmI
         g1bQ6PMM+0pKnqiyBiqXAKmk0okbn7cNyfsQtkRNS+THApXH+Qa+qnZD+wfLAbaOR+
         DhibbQ8yelG8n8j8P9jaSnf5Ye/6yDgxFA45R3viE+yPPPODP2nrdR6HPoN0CGHiNK
         THTRQ8w1KdCQQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 2/9] regulator: rpi-panel: Handle I2C errors/timing to the Atmel
Date:   Mon, 24 Jan 2022 17:01:22 -0500
Message-Id: <20220124220129.158891-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220129.158891-1-detlev.casanova@collabora.com>
References: <20220124220129.158891-1-detlev.casanova@collabora.com>
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
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
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

