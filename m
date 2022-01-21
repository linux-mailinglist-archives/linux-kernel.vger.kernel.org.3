Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256D4961F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381542AbiAUPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381527AbiAUPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id C46071F46211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778489;
        bh=bCIz9lIKmGxNsVU4TA/XNq7Ir5i7GiXO8VWDQOzf+eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ii0FG1zha6Ib46oLatCM1En00pYGm/MeAOANcofcs24rTfer5l0gg8s3RexjIB87y
         Qja5plVupBYOBvcDdDyI6l3IykwYz/rI8d0Ssp0UHu5Bm1Qb93B/C+GIKKmDCrJUJN
         kGizNNRGuXyMweqFpJmealBRTAs+KMKy6Z2Ku4NFFTfzPPUWeI9Yg2/yLeJJ3kM4mv
         RRjyTAW5xagp2q/uQxBqyPJ6uzqo6drel/KeWeUvJ4ZfjoOgVfsHncqTeUHe/AClv0
         5fso60gAGIpC054EauWh/tbVA15l5Vnn14dptscv7oddx43wJ3GEAhE3w8/R3XjeFu
         XkqmpcLrAMHpg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/9] regulator: rpi-panel: Serialise operations.
Date:   Fri, 21 Jan 2022 10:20:50 -0500
Message-Id: <20220121152056.2044551-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121152056.2044551-1-detlev.casanova@collabora.com>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The driver was using the regmap lock to serialise the
individual accesses, but we really need to protect the
timings of enabling the regulators, including any communication
with the Atmel.

Use a mutex within the driver to control overall accesses to
the Atmel, instead of the regmap lock.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../regulator/rpi-panel-attiny-regulator.c    | 91 ++++++++++++++++---
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 00fb69efcfa2..a4af7adad2b5 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -27,18 +27,28 @@
 #define REG_POWERON	0x85
 #define REG_PWM		0x86
 
+struct attiny_lcd {
+	/* lock to serialise overall accesses to the Atmel */
+	struct mutex	lock;
+	struct regmap	*regmap;
+};
+
 static const struct regmap_config attiny_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.disable_locking = 1,
 	.max_register = REG_PWM,
 	.cache_type = REGCACHE_NONE,
 };
 
 static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 {
+	struct mutex *lock = rdev_get_drvdata(rdev);
 	unsigned int data;
 	int ret, i;
 
+	mutex_lock(lock);
+
 	regmap_write(rdev->regmap, REG_POWERON, 1);
 	msleep(80);
 
@@ -63,33 +73,49 @@ static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 	 */
 	regmap_write(rdev->regmap, REG_PORTA, BIT(2));
 
+	mutex_unlock(lock);
+
 	return 0;
 }
 
 static int attiny_lcd_power_disable(struct regulator_dev *rdev)
 {
+	struct mutex *lock = rdev_get_drvdata(rdev);
+
+	mutex_lock(lock);
+
 	regmap_write(rdev->regmap, REG_PWM, 0);
 	regmap_write(rdev->regmap, REG_POWERON, 0);
 	msleep(30);
+
+	mutex_unlock(lock);
+
 	return 0;
 }
 
 static int attiny_lcd_power_is_enabled(struct regulator_dev *rdev)
 {
+	struct mutex *lock = rdev_get_drvdata(rdev);
 	unsigned int data;
 	int ret, i;
 
+	mutex_lock(lock);
+
 	for (i = 0; i < 10; i++) {
 		ret = regmap_read(rdev->regmap, REG_POWERON, &data);
 		if (!ret)
 			break;
 		usleep_range(10000, 12000);
 	}
-	if (ret < 0)
+	if (ret < 0) {
+		mutex_unlock(lock);
 		return ret;
+	}
 
-	if (!(data & BIT(0)))
+	if (!(data & BIT(0))) {
+		mutex_unlock(lock);
 		return 0;
+	}
 
 	for (i = 0; i < 10; i++) {
 		ret = regmap_read(rdev->regmap, REG_PORTB, &data);
@@ -98,6 +124,8 @@ static int attiny_lcd_power_is_enabled(struct regulator_dev *rdev)
 		usleep_range(10000, 12000);
 	}
 
+	mutex_unlock(lock);
+
 	if (ret < 0)
 		return ret;
 
@@ -125,10 +153,13 @@ static const struct regulator_desc attiny_regulator = {
 
 static int attiny_update_status(struct backlight_device *bl)
 {
-	struct regmap *regmap = bl_get_data(bl);
+	struct attiny_lcd *state = bl_get_data(bl);
+	struct regmap *regmap = state->regmap;
 	int brightness = bl->props.brightness;
 	int ret, i;
 
+	mutex_lock(&state->lock);
+
 	if (bl->props.power != FB_BLANK_UNBLANK ||
 	    bl->props.fb_blank != FB_BLANK_UNBLANK)
 		brightness = 0;
@@ -139,20 +170,27 @@ static int attiny_update_status(struct backlight_device *bl)
 			break;
 	}
 
+	mutex_unlock(&state->lock);
+
 	return ret;
 }
 
 static int attiny_get_brightness(struct backlight_device *bl)
 {
-	struct regmap *regmap = bl_get_data(bl);
+	struct attiny_lcd *state = bl_get_data(bl);
+	struct regmap *regmap = state->regmap;
 	int ret, brightness, i;
 
+	mutex_lock(&state->lock);
+
 	for (i = 0; i < 10; i++) {
 		ret = regmap_read(regmap, REG_PWM, &brightness);
 		if (!ret)
 			break;
 	}
 
+	mutex_unlock(&state->lock);
+
 	if (ret)
 		return ret;
 
@@ -174,22 +212,30 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 	struct regulator_config config = { };
 	struct backlight_device *bl;
 	struct regulator_dev *rdev;
+	struct attiny_lcd *state;
 	struct regmap *regmap;
 	unsigned int data;
 	int ret;
 
+	state = devm_kzalloc(&i2c->dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	mutex_init(&state->lock);
+	i2c_set_clientdata(i2c, state);
+
 	regmap = devm_regmap_init_i2c(i2c, &attiny_regmap_config);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto error;
 	}
 
 	ret = regmap_read(regmap, REG_ID, &data);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to read REG_ID reg: %d\n", ret);
-		return ret;
+		goto error;
 	}
 
 	switch (data) {
@@ -198,7 +244,8 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 		break;
 	default:
 		dev_err(&i2c->dev, "Unknown Atmel firmware revision: 0x%02x\n", data);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	regmap_write(regmap, REG_POWERON, 0);
@@ -208,23 +255,44 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 	config.regmap = regmap;
 	config.of_node = i2c->dev.of_node;
 	config.init_data = &attiny_regulator_default;
+	config.driver_data = &state->lock;
 
 	rdev = devm_regulator_register(&i2c->dev, &attiny_regulator, &config);
 	if (IS_ERR(rdev)) {
 		dev_err(&i2c->dev, "Failed to register ATTINY regulator\n");
-		return PTR_ERR(rdev);
+		ret = PTR_ERR(rdev);
+		goto error;
 	}
 
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = 0xff;
+
+	state->regmap = regmap;
+
 	bl = devm_backlight_device_register(&i2c->dev, dev_name(&i2c->dev),
-					    &i2c->dev, regmap, &attiny_bl,
+					    &i2c->dev, state, &attiny_bl,
 					    &props);
-	if (IS_ERR(bl))
-		return PTR_ERR(bl);
+	if (IS_ERR(bl)) {
+		ret = PTR_ERR(bl);
+		goto error;
+	}
 
 	bl->props.brightness = 0xff;
 
+	return 0;
+
+error:
+	mutex_destroy(&state->lock);
+
+	return ret;
+}
+
+static int attiny_i2c_remove(struct i2c_client *client)
+{
+	struct attiny_lcd *state = i2c_get_clientdata(client);
+
+	mutex_destroy(&state->lock);
+
 	return 0;
 }
 
@@ -240,6 +308,7 @@ static struct i2c_driver attiny_regulator_driver = {
 		.of_match_table = of_match_ptr(attiny_dt_ids),
 	},
 	.probe = attiny_i2c_probe,
+	.remove	= attiny_i2c_remove,
 };
 
 module_i2c_driver(attiny_regulator_driver);
-- 
2.34.1

