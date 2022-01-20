Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB3495154
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376710AbiATPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbiATPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:22:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B05C061747
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:22:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 3FA1E1F45344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692157;
        bh=fRteeuvXlCY4UzbbyjV0hj4DKSOldSNjMQV/0bDII5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5kDWp/7oNwWNlRD1Cn1ML3r1KzrUL1S19bqaFfgpebkc4GGO3XCm07G0OtnfO6nc
         DwwUUgq7KyuLGd6Xce5IRfs6d5qJ7PQRFZIME9bJ7h1ioBU5mkKuuc4HOYfggI9l+t
         /QjdF0Fh1NDVR0sH6+MEvvJS99gBzmlUGTvpZwPUKIhkHEnBW/fueBJVupf9DmSE0K
         7LKkdPimd2mONf2CevWKUHVk6fNgQakksCfaxVi38FmSdMkC53Vh1dSK53Eze7/4qZ
         ZVC5iq9ZdJFK9CAcK8HyTUvmQAxhQL2wLGUVokpqCR4qMatjH/p2FhT+onQ2gdbkIA
         yrT32ltURpBwg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6/9] regulator: rpi-panel: Add GPIO control for panel and touch resets
Date:   Thu, 20 Jan 2022 10:21:47 -0500
Message-Id: <20220120152150.1952568-7-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152150.1952568-1-detlev.casanova@collabora.com>
References: <20220120152150.1952568-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

We need independent control of the resets for the panel&bridge,
vs the touch controller.

Expose the reset lines that are on the Atmel's port C via the GPIO
API so that they can be controlled appropriately.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../regulator/rpi-panel-attiny-regulator.c    | 115 +++++++++++++++---
 1 file changed, 97 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 995915ca4a9b..998233f14085 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -8,6 +8,7 @@
 #include <linux/backlight.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -44,10 +45,30 @@
 #define PC_RST_LCD_N		BIT(2)
 #define PC_RST_BRIDGE_N		BIT(3)
 
+enum gpio_signals {
+	RST_BRIDGE_N,	/* TC358762 bridge reset */
+	RST_TP_N,	/* Touch controller reset */
+	NUM_GPIO
+};
+
+struct gpio_signal_mappings {
+	unsigned int reg;
+	unsigned int mask;
+};
+
+static const struct gpio_signal_mappings mappings[NUM_GPIO] = {
+	[RST_BRIDGE_N] = { REG_PORTC, PC_RST_BRIDGE_N | PC_RST_LCD_N  },
+	[RST_TP_N] = { REG_PORTC, PC_RST_TP_N },
+};
+
 struct attiny_lcd {
 	/* lock to serialise overall accesses to the Atmel */
 	struct mutex	lock;
 	struct regmap	*regmap;
+	bool gpio_states[NUM_GPIO];
+	u8 port_states[3];
+
+	struct gpio_chip gc;
 };
 
 static const struct regmap_config attiny_regmap_config = {
@@ -58,6 +79,17 @@ static const struct regmap_config attiny_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static int attiny_set_port_state(struct attiny_lcd *state, int reg, u8 val)
+{
+	state->port_states[reg - REG_PORTA] = val;
+	return regmap_write(state->regmap, reg, val);
+};
+
+static u8 attiny_get_port_state(struct attiny_lcd *state, int reg)
+{
+	return state->port_states[reg - REG_PORTA];
+};
+
 static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 {
 	struct attiny_lcd *state = rdev_get_drvdata(rdev);
@@ -65,7 +97,7 @@ static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 	mutex_lock(&state->lock);
 
 	/* Ensure bridge, and tp stay in reset */
-	regmap_write(rdev->regmap, REG_PORTC, 0);
+	attiny_set_port_state(state, REG_PORTC, 0);
 	usleep_range(5000, 10000);
 
 	/* Default to the same orientation as the closed source
@@ -73,26 +105,16 @@ static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 	 * configuration will be supported using VC4's plane
 	 * orientation bits.
 	 */
-	regmap_write(rdev->regmap, REG_PORTA, PA_LCD_LR);
+	attiny_set_port_state(state, REG_PORTA, PA_LCD_LR);
 	usleep_range(5000, 10000);
-	regmap_write(rdev->regmap, REG_PORTB, PB_LCD_MAIN);
+	/* Main regulator on, and power to the panel (LCD_VCC_N) */
+	attiny_set_port_state(state, REG_PORTB, PB_LCD_MAIN);
 	usleep_range(5000, 10000);
 	/* Bring controllers out of reset */
-	regmap_write(rdev->regmap, REG_PORTC,
-		     PC_LED_EN | PC_RST_BRIDGE_N | PC_RST_LCD_N | PC_RST_TP_N);
+	attiny_set_port_state(state, REG_PORTC, PC_LED_EN);
 
 	msleep(80);
 
-	regmap_write(rdev->regmap, REG_ADDR_H, 0x04);
-	usleep_range(5000, 8000);
-	regmap_write(rdev->regmap, REG_ADDR_L, 0x7c);
-	usleep_range(5000, 8000);
-	regmap_write(rdev->regmap, REG_WRITE_DATA_H, 0x00);
-	usleep_range(5000, 8000);
-	regmap_write(rdev->regmap, REG_WRITE_DATA_L, 0x00);
-
-	msleep(100);
-
 	mutex_unlock(&state->lock);
 
 	return 0;
@@ -106,11 +128,12 @@ static int attiny_lcd_power_disable(struct regulator_dev *rdev)
 
 	regmap_write(rdev->regmap, REG_PWM, 0);
 	usleep_range(5000, 10000);
-	regmap_write(rdev->regmap, REG_PORTA, 0);
+
+	attiny_set_port_state(state, REG_PORTA, 0);
 	usleep_range(5000, 10000);
-	regmap_write(rdev->regmap, REG_PORTB, PB_LCD_VCC_N);
+	attiny_set_port_state(state, REG_PORTB, PB_LCD_VCC_N);
 	usleep_range(5000, 10000);
-	regmap_write(rdev->regmap, REG_PORTC, 0);
+	attiny_set_port_state(state, REG_PORTC, 0);
 	msleep(30);
 
 	mutex_unlock(&state->lock);
@@ -211,6 +234,45 @@ static const struct backlight_ops attiny_bl = {
 	.get_brightness	= attiny_get_brightness,
 };
 
+static int attiny_gpio_get_direction(struct gpio_chip *gc, unsigned int off)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static void attiny_gpio_set(struct gpio_chip *gc, unsigned int off, int val)
+{
+	struct attiny_lcd *state = gpiochip_get_data(gc);
+	u8 last_val;
+
+	if (off >= NUM_GPIO)
+		return;
+
+	mutex_lock(&state->lock);
+
+	last_val = attiny_get_port_state(state, mappings[off].reg);
+	if (val)
+		last_val |= mappings[off].mask;
+	else
+		last_val &= ~mappings[off].mask;
+
+	attiny_set_port_state(state, mappings[off].reg, last_val);
+
+	if (off == RST_BRIDGE_N && val) {
+		usleep_range(5000, 8000);
+		regmap_write(state->regmap, REG_ADDR_H, 0x04);
+		usleep_range(5000, 8000);
+		regmap_write(state->regmap, REG_ADDR_L, 0x7c);
+		usleep_range(5000, 8000);
+		regmap_write(state->regmap, REG_WRITE_DATA_H, 0x00);
+		usleep_range(5000, 8000);
+		regmap_write(state->regmap, REG_WRITE_DATA_L, 0x00);
+
+		msleep(100);
+	}
+
+	mutex_unlock(&state->lock);
+}
+
 /*
  * I2C driver interface functions
  */
@@ -289,6 +351,23 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 
 	bl->props.brightness = 0xff;
 
+	state->gc.parent = &i2c->dev;
+	state->gc.label = i2c->name;
+	state->gc.owner = THIS_MODULE;
+	state->gc.of_node = i2c->dev.of_node;
+	state->gc.base = -1;
+	state->gc.ngpio = NUM_GPIO;
+
+	state->gc.set = attiny_gpio_set;
+	state->gc.get_direction = attiny_gpio_get_direction;
+	state->gc.can_sleep = true;
+
+	ret = devm_gpiochip_add_data(&i2c->dev, &state->gc, state);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to create gpiochip: %d\n", ret);
+		goto error;
+	}
+
 	return 0;
 
 error:
-- 
2.34.1

