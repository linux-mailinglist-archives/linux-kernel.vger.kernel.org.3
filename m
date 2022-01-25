Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5223499FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842809AbiAXXCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:02:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578113AbiAXWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:01:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 734D91F43900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643061703;
        bh=E7KQciq+gZwcuyzcIcpVaVqUOalWdKPMLnu7+2ncJzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPl9UZaaAU4D43NQ9GOQd1MRPMJ6BZ8kk9kKvQ+Ga7QgeP9DP8LNHnMmbqxhiu3J2
         pfmCLPWPLbBgPOzRhjWyuopYIBV+vDnIq0XDZBXue0fFVVUaiwlmiHbsOIWisQYq//
         teYhljnzSpWL7lU4QKhrkyqEd/5ZF7j1V3xdVfGX4yo/ac2v/JMAmz5J9iI7VSF9g3
         b3PwyxmxBrLzRKOlnp+eLR1frSNelx20db/X0feuByI3D/v4/V1/jsGndi7+NpvKCB
         tCgK6C9SBTNw/wZC/H7vRlGSnX25JfURAxqDZgEHzyjZZQDnE8JWVM8NBAy+yEt4PR
         y6ioYCMYsl0Aw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 5/9] regulator: rpi-panel: Convert to drive lines directly
Date:   Mon, 24 Jan 2022 17:01:25 -0500
Message-Id: <20220124220129.158891-6-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220129.158891-1-detlev.casanova@collabora.com>
References: <20220124220129.158891-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The Atmel was doing a load of automatic sequencing of
control lines, however it was combining the touch controller's
reset with the bridge/panel control.

Change to control the control signals directly rather than
through the automatic POWERON control.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../regulator/rpi-panel-attiny-regulator.c    | 111 ++++++++++--------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index b3629a1e0e50..995915ca4a9b 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -21,11 +21,28 @@
 /* I2C registers of the Atmel microcontroller. */
 #define REG_ID		0x80
 #define REG_PORTA	0x81
-#define REG_PORTA_HF	BIT(2)
-#define REG_PORTA_VF	BIT(3)
 #define REG_PORTB	0x82
+#define REG_PORTC	0x83
 #define REG_POWERON	0x85
 #define REG_PWM		0x86
+#define REG_ADDR_L	0x8c
+#define REG_ADDR_H	0x8d
+#define REG_WRITE_DATA_H	0x90
+#define REG_WRITE_DATA_L	0x91
+
+#define PA_LCD_DITHB		BIT(0)
+#define PA_LCD_MODE		BIT(1)
+#define PA_LCD_LR		BIT(2)
+#define PA_LCD_UD		BIT(3)
+
+#define PB_BRIDGE_PWRDNX_N	BIT(0)
+#define PB_LCD_VCC_N		BIT(1)
+#define PB_LCD_MAIN		BIT(7)
+
+#define PC_LED_EN		BIT(0)
+#define PC_RST_TP_N		BIT(1)
+#define PC_RST_LCD_N		BIT(2)
+#define PC_RST_BRIDGE_N		BIT(3)
 
 struct attiny_lcd {
 	/* lock to serialise overall accesses to the Atmel */
@@ -37,99 +54,91 @@ static const struct regmap_config attiny_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.disable_locking = 1,
-	.max_register = REG_PWM,
+	.max_register = REG_WRITE_DATA_L,
 	.cache_type = REGCACHE_NONE,
 };
 
 static int attiny_lcd_power_enable(struct regulator_dev *rdev)
 {
-	struct mutex *lock = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret, i;
-
-	mutex_lock(lock);
-
-	regmap_write(rdev->regmap, REG_POWERON, 1);
-	msleep(80);
+	struct attiny_lcd *state = rdev_get_drvdata(rdev);
 
-	/* Wait for nPWRDWN to go low to indicate poweron is done. */
-	for (i = 0; i < 20; i++) {
-		ret = regmap_read(rdev->regmap, REG_PORTB, &data);
-		if (!ret) {
-			if (data & BIT(0))
-				break;
-		}
-		usleep_range(10000, 12000);
-	}
-	usleep_range(10000, 12000);
+	mutex_lock(&state->lock);
 
-	if (ret)
-		pr_err("%s: regmap_read_poll_timeout failed %d\n", __func__, ret);
+	/* Ensure bridge, and tp stay in reset */
+	regmap_write(rdev->regmap, REG_PORTC, 0);
+	usleep_range(5000, 10000);
 
 	/* Default to the same orientation as the closed source
 	 * firmware used for the panel.  Runtime rotation
 	 * configuration will be supported using VC4's plane
 	 * orientation bits.
 	 */
-	regmap_write(rdev->regmap, REG_PORTA, BIT(2));
+	regmap_write(rdev->regmap, REG_PORTA, PA_LCD_LR);
+	usleep_range(5000, 10000);
+	regmap_write(rdev->regmap, REG_PORTB, PB_LCD_MAIN);
+	usleep_range(5000, 10000);
+	/* Bring controllers out of reset */
+	regmap_write(rdev->regmap, REG_PORTC,
+		     PC_LED_EN | PC_RST_BRIDGE_N | PC_RST_LCD_N | PC_RST_TP_N);
+
+	msleep(80);
+
+	regmap_write(rdev->regmap, REG_ADDR_H, 0x04);
+	usleep_range(5000, 8000);
+	regmap_write(rdev->regmap, REG_ADDR_L, 0x7c);
+	usleep_range(5000, 8000);
+	regmap_write(rdev->regmap, REG_WRITE_DATA_H, 0x00);
+	usleep_range(5000, 8000);
+	regmap_write(rdev->regmap, REG_WRITE_DATA_L, 0x00);
+
+	msleep(100);
 
-	mutex_unlock(lock);
+	mutex_unlock(&state->lock);
 
 	return 0;
 }
 
 static int attiny_lcd_power_disable(struct regulator_dev *rdev)
 {
-	struct mutex *lock = rdev_get_drvdata(rdev);
+	struct attiny_lcd *state = rdev_get_drvdata(rdev);
 
-	mutex_lock(lock);
+	mutex_lock(&state->lock);
 
 	regmap_write(rdev->regmap, REG_PWM, 0);
-	regmap_write(rdev->regmap, REG_POWERON, 0);
+	usleep_range(5000, 10000);
+	regmap_write(rdev->regmap, REG_PORTA, 0);
+	usleep_range(5000, 10000);
+	regmap_write(rdev->regmap, REG_PORTB, PB_LCD_VCC_N);
+	usleep_range(5000, 10000);
+	regmap_write(rdev->regmap, REG_PORTC, 0);
 	msleep(30);
 
-	mutex_unlock(lock);
+	mutex_unlock(&state->lock);
 
 	return 0;
 }
 
 static int attiny_lcd_power_is_enabled(struct regulator_dev *rdev)
 {
-	struct mutex *lock = rdev_get_drvdata(rdev);
+	struct attiny_lcd *state = rdev_get_drvdata(rdev);
 	unsigned int data;
 	int ret, i;
 
-	mutex_lock(lock);
-
-	for (i = 0; i < 10; i++) {
-		ret = regmap_read(rdev->regmap, REG_POWERON, &data);
-		if (!ret)
-			break;
-		usleep_range(10000, 12000);
-	}
-	if (ret < 0) {
-		mutex_unlock(lock);
-		return ret;
-	}
-
-	if (!(data & BIT(0))) {
-		mutex_unlock(lock);
-		return 0;
-	}
+	mutex_lock(&state->lock);
 
 	for (i = 0; i < 10; i++) {
-		ret = regmap_read(rdev->regmap, REG_PORTB, &data);
+		ret = regmap_read(rdev->regmap, REG_PORTC, &data);
 		if (!ret)
 			break;
 		usleep_range(10000, 12000);
 	}
 
-	mutex_unlock(lock);
+	mutex_unlock(&state->lock);
 
 	if (ret < 0)
 		return ret;
 
-	return data & BIT(0);
+	return data & PC_RST_BRIDGE_N;
 }
 
 static const struct regulator_init_data attiny_regulator_default = {
@@ -256,7 +265,7 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 	config.regmap = regmap;
 	config.of_node = i2c->dev.of_node;
 	config.init_data = &attiny_regulator_default;
-	config.driver_data = &state->lock;
+	config.driver_data = state;
 
 	rdev = devm_regulator_register(&i2c->dev, &attiny_regulator, &config);
 	if (IS_ERR(rdev)) {
-- 
2.34.1

