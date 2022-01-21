Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A044961F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381629AbiAUPVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381518AbiAUPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 226BB1F46216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778491;
        bh=iK4Vk+E5mvUAnxE6Jr5IGm+xLJMyJoTeSBj/0jLq41o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PM5heMwdvHxU+M+U8X05uX9NvjqWouUKC6yjGRBFaNvIkPfJSr0ksshXPm9CV25wS
         k6GRxzYBGZzXpciVTajsiwApbBcLex7JI6yLzMpWl4WMn1iEVgAsKYeBmvJy4+4VQM
         goY/TC8RAJy4+D45e9G1u23040F3zTBDf6BDa5ah+2T/1LMAfK2XzdawFddz2QiVI+
         i9eMmf93ZW6B35fhEmr2TcBLHquNq/Imx9nbF4Lc7Wyv+LNNEhcgHjILpWAy17Tqy3
         Ts2wZMtnSUEfnmO8nH8FVO1BbJilJm8pTm9VEzSPXPwhtlBqyML/aSYSsO8vzm9q0O
         4V14R5UMeQLmA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 6/9] regulator: rpi-panel: Add GPIO control for panel and touch resets
Date:   Fri, 21 Jan 2022 10:20:53 -0500
Message-Id: <20220121152056.2044551-7-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121152056.2044551-1-detlev.casanova@collabora.com>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
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
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/regulator/Kconfig                     |   1 +
 .../regulator/rpi-panel-attiny-regulator.c    | 115 +++++++++++++++---
 2 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 1c35fed20d34..22503e4f5327 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -984,6 +984,7 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
 	tristate "Raspberry Pi 7-inch touchscreen panel ATTINY regulator"
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on I2C
+	depends on OF_GPIO
 	select REGMAP_I2C
 	help
 	  This driver supports ATTINY regulator on the Raspberry Pi 7-inch
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

