Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6333565FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGEAFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiGEAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038CB1EB;
        Mon,  4 Jul 2022 17:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8636617CC;
        Tue,  5 Jul 2022 00:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D58C385A2;
        Tue,  5 Jul 2022 00:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656979505;
        bh=LRKVRTYaJZIsCHc04ldgxDQ8AlUsJFAeoF80UNiF0m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=td8dy8pte3WaWZfy3b9Zwi8TkYfSDaMnzwfXThKA81dGYiYnh/t0ZxM0payaUP/Im
         CmPstWDUAadNQGnjMaY9k2GLhcF/THdLoSC0j/POqON/OFBi3iR26Dzwyc6J2vcoaC
         U1T6dQgSoyg0bDUcHmwY5WET3GOHmqwwd1sdHK4OmLlF8j0fVRqLvwjASLISVzgLPg
         H4fIuSLaJuKTaN5WnQ2a1EbcwNoOZdXe6kLbsVTV+QaEWw3fvXBguGEcj7e6QvAz0u
         43/qCvEbRea6/rKq9hfWBN/0eHJ5kdZS23C0j6D2sxHRRyeNmfmMH4H3htm/WNaKGb
         0qmtkN715MOVQ==
Received: by pali.im (Postfix)
        id 1C9A27AE; Tue,  5 Jul 2022 02:05:02 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] leds: Add support for Turris 1.x LEDs
Date:   Tue,  5 Jul 2022 02:04:48 +0200
Message-Id: <20220705000448.14337-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220705000448.14337-1-pali@kernel.org>
References: <20220705000448.14337-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the RGB LEDs found on the front panel of the
Turris 1.x routers. There are 8 RGB LEDs that are controlled by
CZ.NIC CPLD firmware running on Lattice FPGA.

CPLD firmware provides HW triggering mode for all LEDs except WiFi LED
which is automatically enabled after power on reset. LAN LEDs share HW
registers for RGB colors settings, so it is not possible to set different
colors for individual LAN LEDs.

CZ.NIC CPLD firmware is open source and available at:
https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v

This driver uses the multicolor LED framework and HW led triggers.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../testing/sysfs-class-led-driver-turris1x   |  23 +
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-turris-1x.c                 | 412 ++++++++++++++++++
 4 files changed, 445 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-turris1x
 create mode 100644 drivers/leds/leds-turris-1x.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-turris1x b/Documentation/ABI/testing/sysfs-class-led-driver-turris1x
new file mode 100644
index 000000000000..02be9197554d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-turris1x
@@ -0,0 +1,23 @@
+What:		/sys/class/leds/<led>/device/brightness
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Pali Rohár <pali@kernel.org>
+Description:	(RW) On the back size of the Turris 1.x routers there is also
+		a button which can be used to control the intensity of all the
+		LEDs at once, so that if they are too bright, user can dim them.
+
+		The CPLD firmware cycles between 8 levels of this global
+		brightness (from 100% to 0%), but this setting can have any
+		integer value between 0 and 255. It is therefore convenient to be
+		able to change this setting from software.
+
+		Format: %u
+
+What:		/sys/class/leds/<led>/device/brightness_values
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Pali Rohár <pali@kernel.org>
+Description:	(RW) Values of all 8 levels between which CPLD firmware cycles
+		when brightness buffer is pressed.
+
+		Format: %u %u %u %u %u %u %u %u
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a49979f41eee..71caf45c8ac3 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -157,6 +157,15 @@ config LEDS_EL15203000
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-el15203000.
 
+config LEDS_TURRIS_1X
+	tristate "LED support for CZ.NIC's Turris 1.x"
+	depends on LEDS_CLASS_MULTICOLOR
+	depends on OF
+	select LEDS_TRIGGERS
+	help
+	  This option enables support for LEDs found on the front side of
+	  CZ.NIC's Turris 1.x routers.
+
 config LEDS_TURRIS_OMNIA
 	tristate "LED support for CZ.NIC's Turris Omnia"
 	depends on LEDS_CLASS_MULTICOLOR
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..de08083dbbca 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_LEDS_TCA6507)		+= leds-tca6507.o
 obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= leds-ti-lmu-common.o
 obj-$(CONFIG_LEDS_TLC591XX)		+= leds-tlc591xx.o
 obj-$(CONFIG_LEDS_TPS6105X)		+= leds-tps6105x.o
+obj-$(CONFIG_LEDS_TURRIS_1X)		+= leds-turris-1x.o
 obj-$(CONFIG_LEDS_TURRIS_OMNIA)		+= leds-turris-omnia.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
diff --git a/drivers/leds/leds-turris-1x.c b/drivers/leds/leds-turris-1x.c
new file mode 100644
index 000000000000..bd566f5210c7
--- /dev/null
+++ b/drivers/leds/leds-turris-1x.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+// (C) 2022 Pali Rohár <pali@kernel.org>
+//
+// CZ.NIC's Turris 1.x LEDs driver, controlled by CPLD firmware:
+// https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
+
+#include <linux/i2c.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include "leds.h"
+
+/* LED registers starts at byte 0x13 in CPLD memory map */
+#define TURRIS1X_LED_REG_OFF(reg) ((reg)-0x13)
+
+/* LEDs 1-5 share common register for setting brightness */
+#define TURRIS1X_LED_BRIGHTNESS_OFF(idx)	({ const u8 _idx = (idx) & 7; \
+						   (_idx == 0) ? 0 : \
+						   (_idx <= 5) ? 1 : \
+						   (_idx - 4); })
+
+#define TURRIS1X_LED_BRIGHTNESS_REG(idx, color)	TURRIS1X_LED_REG_OFF(0x13 + \
+						  3 * TURRIS1X_LED_BRIGHTNESS_OFF(idx) + \
+						  ((color) & 3))
+#define TURRIS1X_LED_GLOBAL_LEVEL_REG		TURRIS1X_LED_REG_OFF(0x20)
+#define TURRIS1X_LED_GET_GLOBAL_BRIGHTNESS_REG	TURRIS1X_LED_REG_OFF(0x21)
+#define TURRIS1X_LED_SW_OVERRIDE_REG		TURRIS1X_LED_REG_OFF(0x22)
+#define TURRIS1X_LED_SW_DISABLE_REG		TURRIS1X_LED_REG_OFF(0x23)
+#define TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(lvl)	TURRIS1X_LED_REG_OFF(0x28 + ((lvl) & 7))
+
+struct turris1x_led {
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled_info[3];
+	u32 reg;
+	bool registered;
+};
+
+#define to_turris1x_led(l)	container_of(l, struct turris1x_led, mc_cdev)
+
+struct turris1x_leds {
+	void __iomem *regs;
+	struct mutex lock;
+	struct turris1x_led leds[8];
+};
+
+static struct led_hw_trigger_type turris1x_hw_trigger_type;
+
+static int turris1x_hwtrig_activate(struct led_classdev *cdev)
+{
+	struct turris1x_leds *leds = dev_get_drvdata(cdev->dev->parent);
+	struct turris1x_led *led = to_turris1x_led(lcdev_to_mccdev(cdev));
+	u8 val;
+
+	/* Disable software control of LED */
+	mutex_lock(&leds->lock);
+	val = readb(leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG);
+	val &= ~BIT(led->reg);
+	writeb(val, leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG);
+	mutex_unlock(&leds->lock);
+
+	return 0;
+}
+
+static void turris1x_hwtrig_deactivate(struct led_classdev *cdev)
+{
+	struct turris1x_leds *leds = dev_get_drvdata(cdev->dev->parent);
+	struct turris1x_led *led = to_turris1x_led(lcdev_to_mccdev(cdev));
+	u8 val;
+
+	/* Enable software control of LED */
+	mutex_lock(&leds->lock);
+	val = readb(leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG);
+	val |= BIT(led->reg);
+	writeb(val, leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG);
+	mutex_unlock(&leds->lock);
+}
+
+static struct led_trigger turris1x_hw_trigger = {
+	.name		= "turris1x-cpld",
+	.activate	= turris1x_hwtrig_activate,
+	.deactivate	= turris1x_hwtrig_deactivate,
+	.trigger_type	= &turris1x_hw_trigger_type,
+};
+
+static enum led_brightness turris1x_led_brightness_get(struct led_classdev *cdev)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct turris1x_leds *leds = dev_get_drvdata(cdev->dev->parent);
+	struct turris1x_led *led = to_turris1x_led(mc_cdev);
+
+	if (!(readb(leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG) & BIT(led->reg)))
+		return LED_ON;
+	else if (!(readb(leds->regs + TURRIS1X_LED_SW_DISABLE_REG) & BIT(led->reg)))
+		return LED_ON;
+	else
+		return LED_OFF;
+}
+
+static int turris1x_led_brightness_set_blocking(struct led_classdev *cdev,
+						enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct turris1x_leds *leds = dev_get_drvdata(cdev->dev->parent);
+	struct turris1x_led *led = to_turris1x_led(mc_cdev);
+	int i, j;
+	u8 val;
+
+	mutex_lock(&leds->lock);
+
+	/* Set new brightness value for each color when LED is enabled */
+	if (brightness == LED_ON) {
+		led_mc_calc_color_components(mc_cdev, brightness);
+		for (i = 0; i < ARRAY_SIZE(led->subled_info); i++)
+			writeb(mc_cdev->subled_info[i].brightness,
+			       leds->regs + TURRIS1X_LED_BRIGHTNESS_REG(led->reg, i));
+
+		/*
+		 * LEDs 1-5 (LAN) share common color settings in same sets
+		 * of HW registers and therefore it is not possible to set
+		 * different colors. So when chaning color of one LED then
+		 * reflect color change for all of them.
+		 */
+		if (led->reg >= 1 && led->reg <= 5) {
+			for (j = 0; j < ARRAY_SIZE(leds->leds); j++) {
+				if (leds->leds[j].reg < 1 ||
+				    leds->leds[j].reg > 5 ||
+				    leds->leds[j].reg == led->reg)
+					continue;
+				for (i = 0; i < ARRAY_SIZE(led->subled_info); i++)
+					leds->leds[j].mc_cdev.subled_info[i].intensity =
+						mc_cdev->subled_info[i].intensity;
+			}
+		}
+	}
+
+	/* Enable / disable LED for software control */
+	val = readb(leds->regs + TURRIS1X_LED_SW_DISABLE_REG);
+	if (brightness == LED_ON && (val & BIT(led->reg)))
+		writeb(val & ~BIT(led->reg),
+		       leds->regs + TURRIS1X_LED_SW_DISABLE_REG);
+	else if (brightness == LED_OFF && !(val & BIT(led->reg)))
+		writeb(val | BIT(led->reg),
+		       leds->regs + TURRIS1X_LED_SW_DISABLE_REG);
+
+	mutex_unlock(&leds->lock);
+
+	return 0;
+}
+
+static int turris1x_led_register(struct device *dev, struct turris1x_leds *leds,
+				 struct device_node *np, u8 val_sw_override,
+				 u8 val_sw_disable)
+{
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct turris1x_led *led;
+	int ret, color;
+	u32 reg;
+
+	ret = of_property_read_u32(np, "reg", &reg);
+	if (ret || reg >= ARRAY_SIZE(leds->leds)) {
+		dev_err(dev,
+			"Node %pOF: must contain 'reg' property with values between 0 and %u\n",
+			np, (unsigned int)ARRAY_SIZE(leds->leds)-1);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret || color != LED_COLOR_ID_RGB) {
+		dev_err(dev,
+			"Node %pOF: must contain 'color' property with value LED_COLOR_ID_RGB\n",
+			np);
+		return -EINVAL;
+	}
+
+	led = &leds->leds[reg];
+
+	if (led->registered) {
+		dev_err(dev, "Node %pOF: duplicate 'reg' property %u\n",
+			     np, reg);
+		return -EINVAL;
+	}
+
+	led->registered = true;
+	led->reg = reg;
+
+	led->subled_info[0].color_index = LED_COLOR_ID_RED;
+	led->subled_info[0].intensity = 255;
+	led->subled_info[0].channel = 0;
+	led->subled_info[1].color_index = LED_COLOR_ID_GREEN;
+	led->subled_info[1].intensity = 255;
+	led->subled_info[1].channel = 1;
+	led->subled_info[2].color_index = LED_COLOR_ID_BLUE;
+	led->subled_info[2].intensity = 255;
+	led->subled_info[2].channel = 2;
+
+	led->mc_cdev.subled_info = led->subled_info;
+	led->mc_cdev.num_colors = ARRAY_SIZE(led->subled_info);
+
+	init_data.fwnode = &np->fwnode;
+
+	cdev = &led->mc_cdev.led_cdev;
+	cdev->max_brightness = LED_ON;
+	cdev->brightness_get = turris1x_led_brightness_get;
+	cdev->brightness_set_blocking = turris1x_led_brightness_set_blocking;
+
+	/* All LEDs except LED 6 (WiFi) can be controller by hardware trigger */
+	if (reg != 6)
+		cdev->trigger_type = &turris1x_hw_trigger_type;
+
+	/* Disable hardware trigger for LED 6 (WiFi) - allow software control */
+	if (reg == 6 && !(val_sw_override & BIT(6))) {
+		if (!(val_sw_disable & BIT(6))) {
+			val_sw_disable |= BIT(6);
+			writeb(val_sw_disable,
+			       leds->regs + TURRIS1X_LED_SW_DISABLE_REG);
+		}
+		val_sw_override |= BIT(6);
+		writeb(val_sw_override,
+		       leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG);
+	}
+
+	if (!(val_sw_override & BIT(reg)))
+		cdev->default_trigger = turris1x_hw_trigger.name;
+
+	if (!(val_sw_override & BIT(reg)) || !(val_sw_disable & BIT(reg)))
+		cdev->brightness = LED_ON;
+
+	ret = devm_led_classdev_multicolor_register_ext(dev, &led->mc_cdev,
+							&init_data);
+	if (ret) {
+		dev_err(dev, "Cannot register LED %pOF: %i\n", np, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t brightness_show(struct device *dev, struct device_attribute *a,
+			       char *buf)
+{
+	struct turris1x_leds *leds = dev_get_drvdata(dev);
+	unsigned int brightness;
+
+	/*
+	 * Current brightness value is available in read-only register
+	 * TURRIS1X_LED_GET_GLOBAL_BRIGHTNESS_REG. Equivalent code is:
+	 * level = readb(leds->regs + TURRIS1X_LED_GLOBAL_LEVEL_REG) & 7;
+	 * brightness = readb(leds->regs + TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(level));
+	 */
+	brightness = readb(leds->regs + TURRIS1X_LED_GET_GLOBAL_BRIGHTNESS_REG);
+
+	return sprintf(buf, "%u\n", brightness);
+}
+
+static ssize_t brightness_store(struct device *dev, struct device_attribute *a,
+				const char *buf, size_t count)
+{
+	struct turris1x_leds *leds = dev_get_drvdata(dev);
+	int best_error, error, level, value;
+	unsigned long brightness;
+	u8 best_level;
+
+	if (kstrtoul(buf, 10, &brightness))
+		return -EINVAL;
+
+	if (brightness > 255)
+		return -EINVAL;
+
+	/*
+	 * Brightness can be set only to one of 8 predefined value levels
+	 * available in TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(level) registers.
+	 * Choose level which has nearest value to the specified brightness.
+	 */
+	best_level = 0;
+	best_error = INT_MAX;
+	for (level = 0; level < 8; level++) {
+		value = readb(leds->regs +
+			      TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(level));
+		error = abs(value - (int)brightness);
+		if (best_error > error) {
+			best_error = error;
+			best_level = level;
+		}
+	}
+
+	writeb(best_level, leds->regs + TURRIS1X_LED_GLOBAL_LEVEL_REG);
+
+	return count;
+}
+static DEVICE_ATTR_RW(brightness);
+
+static ssize_t brightness_values_show(struct device *dev,
+				      struct device_attribute *a, char *buf)
+{
+	struct turris1x_leds *leds = dev_get_drvdata(dev);
+	unsigned int vals[8];
+	int i;
+
+	for (i = 0; i < 8; i++)
+		vals[i] = readb(leds->regs +
+				TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(i));
+
+	return sprintf(buf, "%u %u %u %u %u %u %u %u\n", vals[0], vals[1],
+		       vals[2], vals[3], vals[4], vals[5], vals[6], vals[7]);
+}
+
+static ssize_t brightness_values_store(struct device *dev,
+				       struct device_attribute *a,
+				       const char *buf, size_t count)
+{
+	struct turris1x_leds *leds = dev_get_drvdata(dev);
+	unsigned int vals[8];
+	int nchars;
+	int i;
+
+	if (sscanf(buf, "%u %u %u %u %u %u %u %u%n", &vals[0], &vals[1],
+		   &vals[2], &vals[3], &vals[4], &vals[5], &vals[6], &vals[7],
+		   &nchars) != 8 || nchars + 1 < count)
+		return -EINVAL;
+
+	for (i = 0; i < 8; i++)
+		writeb(vals[i],
+		       leds->regs + TURRIS1X_LED_GLOBAL_BRIGHTNESS_REG(i));
+
+	return count;
+}
+static DEVICE_ATTR_RW(brightness_values);
+
+static struct attribute *turris1x_leds_controller_attrs[] = {
+	&dev_attr_brightness.attr,
+	&dev_attr_brightness_values.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(turris1x_leds_controller);
+
+static int turris1x_leds_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct device_node *child;
+	struct turris1x_leds *leds;
+	struct resource *res;
+	void __iomem *regs;
+	u8 val_sw_override;
+	u8 val_sw_disable;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, leds);
+
+	leds->regs = regs;
+	mutex_init(&leds->lock);
+
+	ret = devm_led_trigger_register(dev, &turris1x_hw_trigger);
+	if (ret) {
+		dev_err(dev, "Cannot register private LED trigger: %d\n", ret);
+		return ret;
+	}
+
+	val_sw_override = readb(leds->regs + TURRIS1X_LED_SW_OVERRIDE_REG);
+	val_sw_disable = readb(leds->regs + TURRIS1X_LED_SW_DISABLE_REG);
+
+	for_each_available_child_of_node(np, child) {
+		ret = turris1x_led_register(dev, leds, child,
+					    val_sw_override, val_sw_disable);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	ret = devm_device_add_groups(dev, turris1x_leds_controller_groups);
+	if (ret) {
+		dev_err(dev, "Could not add attribute group!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_turris1x_leds_match[] = {
+	{ .compatible = "cznic,turris1x-leds" },
+	{},
+};
+
+static struct platform_driver turris1x_leds_driver = {
+	.probe = turris1x_leds_probe,
+	.driver = {
+		.name = "turris1x_leds",
+		.of_match_table = of_turris1x_leds_match,
+	},
+};
+module_platform_driver(turris1x_leds_driver);
+
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
+MODULE_DESCRIPTION("CZ.NIC's Turris 1.x LEDs");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:turris1x_leds");
-- 
2.20.1

