Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820CF5A5A68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiH3Dn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiH3DnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:43:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D411AAB4D4;
        Mon, 29 Aug 2022 20:43:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r69so9532468pgr.2;
        Mon, 29 Aug 2022 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wkGTGJ6wWTf9qroYpkUbY5a+QE4YIYnkQYRn2mIn9b4=;
        b=U5JilDxSUbtryAeFD7QjgPxSf2JXRn/w0NpKEzo/DKQ17RSvpU61jE46msBVyQ9Jzv
         qQGv8YGWFTwj+YrgYnyBaoHxjkXVwhhCe7g29UQ5uSsr/dWAQJLTKY+8GXB5h1DGRGJg
         EJ2T4uuMtstt0t2awRASScfyrhcjozhj76oOwApT8j827GsItZmpddHm4jjFk6UZfPHx
         0RoUn7uB/ASAWnia5gvp4X18VnscyxID3/F0XsZ7gpvraK9PGEEnyDW8qVreK+4XXCTF
         eA8qeIu4qlLCK1ank+gxQuBhruXr40Sz1HE5anz0AetrMef3xfNM8kuGmzwTlEUvFYP7
         1JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wkGTGJ6wWTf9qroYpkUbY5a+QE4YIYnkQYRn2mIn9b4=;
        b=I2uiAogI6nlrgdluIJFadbDK4VkvQqkIufTXPeFDWefvA+lmZRTe4/Mu6Pm97H8KlP
         m9+ZqkcUGFdlGBRHiHkdSZWLuQq1IYH4amJlX/DSguag5pErqf1+ealY9vqrsXDXtuzi
         PG4OzwC1sM4YjTe4GZLpmD1wCZsazvTwOi+W2pLoljyuQgHIjCjHa9Ok1C+aN2+rSn3c
         fZfXEyM3BHmv4ZUfPTbp8S13s5JnTfly6nmsfUxFj04StbHdQGgvZlDalV6F/6Wo+K+m
         TyyKvmYtKbYcRt3OxVykOqNBNo3QJQmYYtCGuhkFUXMS3UuP15/mhFLlPl/qZLzdKA2U
         nVvg==
X-Gm-Message-State: ACgBeo3ztm6v36Bsx6eI3FclKS+BHzSdTrO+n+NxcFKxm1Glzxg2oJuz
        jOX48UiR+ADJuFCC0t+OEPE=
X-Google-Smtp-Source: AA6agR53XQ4tIf/pefuICUvYvnYOqEdu8ZT++mXPc9F2Xt6GHHaIS3Nq3zswCdvcZeb96m3oZoTD6A==
X-Received: by 2002:a65:60d5:0:b0:41a:625e:4c44 with SMTP id r21-20020a6560d5000000b0041a625e4c44mr16213202pgv.364.1661830985076;
        Mon, 29 Aug 2022 20:43:05 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-77-88-242.emome-ip.hinet.net. [42.77.88.242])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm8439577plh.170.2022.08.29.20.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 20:43:04 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v9 10/10] video: backlight: mt6370: Add MediaTek MT6370 support
Date:   Tue, 30 Aug 2022 11:40:42 +0800
Message-Id: <20220830034042.9354-11-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830034042.9354-2-peterwu.pub@gmail.com>
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
driver, display bias voltage supply, one general purpose LDO, and the
USB Type-C & PD controller complies with the latest USB Type-C and PD
standards.

Add support for the MediaTek MT6370 backlight driver.
It controls 4 channels of 8 series WLEDs in
2048 (only for MT6370/MT6371) / 16384 (only for MT6372)
current steps (30 mA) in exponential or linear mapping curves.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v9
- Revise the format of the comments.
---
 drivers/video/backlight/Kconfig            |  13 ++
 drivers/video/backlight/Makefile           |   1 +
 drivers/video/backlight/mt6370-backlight.c | 351 +++++++++++++++++++++++++++++
 3 files changed, 365 insertions(+)
 create mode 100644 drivers/video/backlight/mt6370-backlight.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index a003e02..936ba1e 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -268,6 +268,19 @@ config BACKLIGHT_MAX8925
 	  If you have a LCD backlight connected to the WLED output of MAX8925
 	  WLED output, say Y here to enable this driver.
 
+config BACKLIGHT_MT6370
+	tristate "MediaTek MT6370 Backlight Driver"
+	depends on MFD_MT6370
+	help
+	  This enables support for Mediatek MT6370 Backlight driver.
+	  It's commonly used to drive the display WLED. There are 4 channels
+	  inside, and each channel supports up to 30mA of current capability
+	  with 2048 current steps (only for MT6370/MT6371) or 16384 current
+	  steps (only for MT6372) in exponential or linear mapping curves.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "mt6370-backlight".
+
 config BACKLIGHT_APPLE
 	tristate "Apple Backlight Driver"
 	depends on X86 && ACPI
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index cae2c83..e815f3f 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_BACKLIGHT_LP855X)		+= lp855x_bl.o
 obj-$(CONFIG_BACKLIGHT_LP8788)		+= lp8788_bl.o
 obj-$(CONFIG_BACKLIGHT_LV5207LP)	+= lv5207lp.o
 obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
+obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
diff --git a/drivers/video/backlight/mt6370-backlight.c b/drivers/video/backlight/mt6370-backlight.c
new file mode 100644
index 0000000..623d4f2
--- /dev/null
+++ b/drivers/video/backlight/mt6370-backlight.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiaEn Wu <chiaen_wu@richtek.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define MT6370_REG_DEV_INFO		0x100
+#define MT6370_REG_BL_EN		0x1A0
+#define MT6370_REG_BL_BSTCTRL		0x1A1
+#define MT6370_REG_BL_PWM		0x1A2
+#define MT6370_REG_BL_DIM2		0x1A4
+
+#define MT6370_VENID_MASK		GENMASK(7, 4)
+#define MT6370_BL_EXT_EN_MASK		BIT(7)
+#define MT6370_BL_EN_MASK		BIT(6)
+#define MT6370_BL_CODE_MASK		BIT(0)
+#define MT6370_BL_CH_MASK		GENMASK(5, 2)
+#define MT6370_BL_CH_SHIFT		2
+#define MT6370_BL_DIM2_COMMON_MASK	GENMASK(2, 0)
+#define MT6370_BL_DIM2_COMMON_SHIFT	3
+#define MT6370_BL_DIM2_6372_MASK	GENMASK(5, 0)
+#define MT6370_BL_DIM2_6372_SHIFT	6
+#define MT6370_BL_PWM_EN_MASK		BIT(7)
+#define MT6370_BL_PWM_HYS_EN_MASK	BIT(2)
+#define MT6370_BL_PWM_HYS_SEL_MASK	GENMASK(1, 0)
+#define MT6370_BL_OVP_EN_MASK		BIT(7)
+#define MT6370_BL_OVP_SEL_MASK		GENMASK(6, 5)
+#define MT6370_BL_OVP_SEL_SHIFT		5
+#define MT6370_BL_OC_EN_MASK		BIT(3)
+#define MT6370_BL_OC_SEL_MASK		GENMASK(2, 1)
+#define MT6370_BL_OC_SEL_SHIFT		1
+
+#define MT6370_BL_PWM_HYS_TH_MIN_STEP	1
+#define MT6370_BL_PWM_HYS_TH_MAX_STEP	64
+#define MT6370_BL_OVP_MIN_UV		17000000
+#define MT6370_BL_OVP_MAX_UV		29000000
+#define MT6370_BL_OVP_STEP_UV		4000000
+#define MT6370_BL_OCP_MIN_UA		900000
+#define MT6370_BL_OCP_MAX_UA		1800000
+#define MT6370_BL_OCP_STEP_UA		300000
+#define MT6370_BL_MAX_COMMON_BRIGHTNESS	2048
+#define MT6370_BL_MAX_6372_BRIGHTNESS	16384
+#define MT6370_BL_MAX_CH		15
+
+enum {
+	MT6370_VID_COMMON = 1,
+	MT6370_VID_6372,
+};
+
+struct mt6370_priv {
+	u8 dim2_mask;
+	u8 dim2_shift;
+	int def_max_brightness;
+	struct backlight_device *bl;
+	struct device *dev;
+	struct gpio_desc *enable_gpio;
+	struct regmap *regmap;
+};
+
+static int mt6370_bl_update_status(struct backlight_device *bl_dev)
+{
+	struct mt6370_priv *priv = bl_get_data(bl_dev);
+	int brightness = backlight_get_brightness(bl_dev);
+	unsigned int enable_val;
+	u8 brightness_val[2];
+	int ret;
+
+	if (brightness) {
+		brightness_val[0] = (brightness - 1) & priv->dim2_mask;
+		brightness_val[1] = (brightness - 1) >> priv->dim2_shift;
+
+		ret = regmap_raw_write(priv->regmap, MT6370_REG_BL_DIM2,
+				       brightness_val, sizeof(brightness_val));
+		if (ret)
+			return ret;
+	}
+
+	gpiod_set_value(priv->enable_gpio, !!brightness);
+
+	enable_val = brightness ? MT6370_BL_EN_MASK : 0;
+	return regmap_update_bits(priv->regmap, MT6370_REG_BL_EN,
+				  MT6370_BL_EN_MASK, enable_val);
+}
+
+static int mt6370_bl_get_brightness(struct backlight_device *bl_dev)
+{
+	struct mt6370_priv *priv = bl_get_data(bl_dev);
+	unsigned int enable;
+	u8 brightness_val[2];
+	int brightness, ret;
+
+	ret = regmap_read(priv->regmap, MT6370_REG_BL_EN, &enable);
+	if (ret)
+		return ret;
+
+	if (!(enable & MT6370_BL_EN_MASK))
+		return 0;
+
+	ret = regmap_raw_read(priv->regmap, MT6370_REG_BL_DIM2,
+			      brightness_val, sizeof(brightness_val));
+	if (ret)
+		return ret;
+
+	brightness = brightness_val[1] << priv->dim2_shift;
+	brightness += brightness_val[0] & priv->dim2_mask;
+
+	return brightness + 1;
+}
+
+static const struct backlight_ops mt6370_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = mt6370_bl_update_status,
+	.get_brightness = mt6370_bl_get_brightness,
+};
+
+static int mt6370_init_backlight_properties(struct mt6370_priv *priv,
+					    struct backlight_properties *props)
+{
+	struct device *dev = priv->dev;
+	u8 prop_val;
+	u32 brightness, ovp_uV, ocp_uA;
+	unsigned int mask, val;
+	int ret;
+
+	/* Vendor optional properties */
+	val = 0;
+	if (device_property_read_bool(dev, "mediatek,bled-pwm-enable"))
+		val |= MT6370_BL_PWM_EN_MASK;
+
+	if (device_property_read_bool(dev, "mediatek,bled-pwm-hys-enable"))
+		val |= MT6370_BL_PWM_HYS_EN_MASK;
+
+	ret = device_property_read_u8(dev,
+				      "mediatek,bled-pwm-hys-input-th-steps",
+				      &prop_val);
+	if (!ret) {
+		prop_val = clamp_val(prop_val,
+				     MT6370_BL_PWM_HYS_TH_MIN_STEP,
+				     MT6370_BL_PWM_HYS_TH_MAX_STEP);
+		prop_val = prop_val <= 1 ? 0 :
+			   prop_val <= 4 ? 1 :
+			   prop_val <= 16 ? 2 : 3;
+		val |= prop_val;
+	}
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
+				 val, val);
+	if (ret)
+		return ret;
+
+	val = 0;
+	if (device_property_read_bool(dev, "mediatek,bled-ovp-shutdown"))
+		val |= MT6370_BL_OVP_EN_MASK;
+
+	ret = device_property_read_u32(dev, "mediatek,bled-ovp-microvolt",
+				       &ovp_uV);
+	if (!ret) {
+		ovp_uV = clamp_val(ovp_uV, MT6370_BL_OVP_MIN_UV,
+				   MT6370_BL_OVP_MAX_UV);
+		ovp_uV = DIV_ROUND_UP(ovp_uV - MT6370_BL_OVP_MIN_UV,
+				      MT6370_BL_OVP_STEP_UV);
+		val |= ovp_uV << MT6370_BL_OVP_SEL_SHIFT;
+	}
+
+	if (device_property_read_bool(dev, "mediatek,bled-ocp-shutdown"))
+		val |= MT6370_BL_OC_EN_MASK;
+
+	ret = device_property_read_u32(dev, "mediatek,bled-ocp-microamp",
+				       &ocp_uA);
+	if (!ret) {
+		ocp_uA = clamp_val(ocp_uA, MT6370_BL_OCP_MIN_UA,
+				   MT6370_BL_OCP_MAX_UA);
+		ocp_uA = DIV_ROUND_UP(ocp_uA - MT6370_BL_OCP_MIN_UA,
+				      MT6370_BL_OCP_STEP_UA);
+		val |= ocp_uA << MT6370_BL_OC_SEL_SHIFT;
+	}
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_BSTCTRL,
+				 val, val);
+	if (ret)
+		return ret;
+
+	/* Common properties */
+	ret = device_property_read_u32(dev, "max-brightness", &brightness);
+	if (ret)
+		brightness = priv->def_max_brightness;
+
+	props->max_brightness = min_t(u32, brightness, priv->def_max_brightness);
+
+	ret = device_property_read_u32(dev, "default-brightness", &brightness);
+	if (ret)
+		brightness = props->max_brightness;
+
+	props->brightness = min_t(u32, brightness, props->max_brightness);
+
+	val = 0;
+	if (device_property_read_bool(dev, "mediatek,bled-exponential-mode-enable")) {
+		val |= MT6370_BL_CODE_MASK;
+		props->scale = BACKLIGHT_SCALE_NON_LINEAR;
+	} else
+		props->scale = BACKLIGHT_SCALE_LINEAR;
+
+	ret = device_property_read_u8(dev, "mediatek,bled-channel-use",
+				      &prop_val);
+	if (ret) {
+		dev_err(dev, "mediatek,bled-channel-use DT property missing\n");
+		return ret;
+	}
+
+	if (!prop_val || prop_val > MT6370_BL_MAX_CH) {
+		dev_err(dev,
+			"No channel specified or over than upper bound (%d)\n",
+			prop_val);
+		return -EINVAL;
+	}
+
+	mask = MT6370_BL_EXT_EN_MASK | MT6370_BL_CH_MASK;
+	val |= prop_val << MT6370_BL_CH_SHIFT;
+
+	if (priv->enable_gpio)
+		val |= MT6370_BL_EXT_EN_MASK;
+
+	return regmap_update_bits(priv->regmap, MT6370_REG_BL_EN, mask, val);
+}
+
+static int mt6370_check_vendor_info(struct mt6370_priv *priv)
+{
+	/*
+	 * Because MT6372 uses 14 bits to control the brightness,
+	 * MT6370 and MT6371 use 11 bits. This function is used
+	 * to check the vendor's ID and set the relative hardware
+	 * mask, shift and default maximum brightness value that
+	 * should be used.
+	 */
+	unsigned int dev_info, hw_vid, of_vid;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MT6370_REG_DEV_INFO, &dev_info);
+	if (ret)
+		return ret;
+
+	of_vid = (uintptr_t)device_get_match_data(priv->dev);
+	hw_vid = FIELD_GET(MT6370_VENID_MASK, dev_info);
+	hw_vid = (hw_vid == 0x9 || hw_vid == 0xb) ? MT6370_VID_6372 : MT6370_VID_COMMON;
+	if (hw_vid != of_vid)
+		return dev_err_probe(priv->dev, -EINVAL,
+				     "Buggy DT, wrong compatible string\n");
+
+	if (hw_vid == MT6370_VID_6372) {
+		priv->dim2_mask = MT6370_BL_DIM2_6372_MASK;
+		priv->dim2_shift = MT6370_BL_DIM2_6372_SHIFT;
+		priv->def_max_brightness = MT6370_BL_MAX_6372_BRIGHTNESS;
+	} else {
+		priv->dim2_mask = MT6370_BL_DIM2_COMMON_MASK;
+		priv->dim2_shift = MT6370_BL_DIM2_COMMON_SHIFT;
+		priv->def_max_brightness = MT6370_BL_MAX_COMMON_BRIGHTNESS;
+	}
+
+	return 0;
+}
+
+static int mt6370_bl_probe(struct platform_device *pdev)
+{
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+	};
+	struct device *dev = &pdev->dev;
+	struct mt6370_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
+
+	ret = mt6370_check_vendor_info(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to check vendor info\n");
+
+	priv->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->enable_gpio),
+				     "Failed to get 'enable' gpio\n");
+
+	ret = mt6370_init_backlight_properties(priv, &props);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to init backlight properties\n");
+
+	priv->bl = devm_backlight_device_register(dev, pdev->name, dev, priv,
+						  &mt6370_bl_ops, &props);
+	if (IS_ERR(priv->bl))
+		return dev_err_probe(dev, PTR_ERR(priv->bl),
+				     "Failed to register backlight\n");
+
+	backlight_update_status(priv->bl);
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int mt6370_bl_remove(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv = platform_get_drvdata(pdev);
+	struct backlight_device *bl_dev = priv->bl;
+
+	bl_dev->props.brightness = 0;
+	backlight_update_status(priv->bl);
+
+	return 0;
+}
+
+static const struct of_device_id mt6370_bl_of_match[] = {
+	{ .compatible = "mediatek,mt6370-backlight", .data = (void *)MT6370_VID_COMMON },
+	{ .compatible = "mediatek,mt6372-backlight", .data = (void *)MT6370_VID_6372 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6370_bl_of_match);
+
+static struct platform_driver mt6370_bl_driver = {
+	.driver = {
+		.name = "mt6370-backlight",
+		.of_match_table = mt6370_bl_of_match,
+	},
+	.probe = mt6370_bl_probe,
+	.remove = mt6370_bl_remove,
+};
+module_platform_driver(mt6370_bl_driver);
+
+MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
+MODULE_DESCRIPTION("MediaTek MT6370 Backlight Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

