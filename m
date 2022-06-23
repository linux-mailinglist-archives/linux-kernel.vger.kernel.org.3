Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4F557989
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiFWL7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiFWL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:59:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139614DF61;
        Thu, 23 Jun 2022 04:58:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p14so13206648pfh.6;
        Thu, 23 Jun 2022 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7GXYn5rKkvEUotNDztIkIhNm6MA/8dsUTEnwEI1gNU=;
        b=o+0Wa53zTV1uyFaCoWaTrEOzodPyOVApNu/2UJ3dvsm2wAEKNwOAKXzF0J2vnq/bJr
         3zu5OXBBLh/Ux66mi9fjjjBrzG9cdRV8dDqiaK+ttrzcAp981Ds25mVFXm+gjsb6mXAS
         OLhJqjLom+2A0Vmi7H5So7ocleGDkXjb5JBW3G5zRlJu1A/UN2G5DCi3e0d61aTwiZKo
         X1L1Iph9/YIqZBQ9DU/3OdSgZB10qZWS8ZmfHxEyVwb1MOl2U7xtrsz1ipucqL5UfyJA
         CzuK3ESN/FmncgBlzGV7V1XAjp5JV7ZDKnk3+UQBHe5zbcbOQQjn/YbN6NTZmayy6Bx3
         C2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7GXYn5rKkvEUotNDztIkIhNm6MA/8dsUTEnwEI1gNU=;
        b=H+6A0PEaVIwYUwebbB5ZapAs6WMqVZcuWuyeRQv6SvWBBZfjoDDeFae2rtLwcQ4Vez
         EbSUObGvFAsekYU6v92ctm84thrvYJIIGzWSXEa85KZ2TzuvAS8SYOaBBDNKR/tproqW
         9uO91qO2gdXOQNXIbk/OY9T5mmEt7QZJdY6WLZmv/J8chFf/gOPF2sAMyROmPDxsetOd
         VmGAH4MAGvE8jWRZ4xyk1wim3dDa5NArR0qLq98ix3QSholL1CV/d/DO+O9BwMWAs/kx
         MsYNWNs9md4sGs30c2E75GO7mKYIBzpKyF2OG0LtoSN6+PerCZzA0rCKHT2hIdso/O4g
         UyZw==
X-Gm-Message-State: AJIora8tdfQYbFMxm9Pw6WZl+laclm+XSgMScV7goiafjhExQGhvHLhz
        ECTKLLDoSYNjCKEUuSQOc3bslMcR0Pc=
X-Google-Smtp-Source: AGRyM1vT/0PFSzRdbbE0OHeCOoudfWfuzy1UKXPrhg8oPMEcKCUz7qfwtfsdxSj/unanuyEAqCR2LA==
X-Received: by 2002:a63:3f48:0:b0:40c:f2ca:4769 with SMTP id m69-20020a633f48000000b0040cf2ca4769mr7315452pga.205.1655985512230;
        Thu, 23 Jun 2022 04:58:32 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-71-94-93.emome-ip.hinet.net. [111.71.94.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b003fbfe88be17sm15016516pgo.24.2022.06.23.04.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:58:31 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v3 14/14] video: backlight: mt6370: Add Mediatek MT6370 support
Date:   Thu, 23 Jun 2022 19:56:31 +0800
Message-Id: <20220623115631.22209-15-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623115631.22209-1-peterwu.pub@gmail.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
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

Add Mediatek MT6370 Backlight support.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v3
- Refine bool properties parsing (pwm-enable, ovp-shutdown, ocp-shutdown) in DT
  parsing function
- Refine u32 and u8 properties parsing (pwm-hys-input-th-steps, ovp-microvolt,
  ocp-microamp), from using register value to using actual value
- Refine error string of "channle-use" parsing failed
- Refine Kconfig help text
---
 drivers/video/backlight/Kconfig            |   9 +
 drivers/video/backlight/Makefile           |   1 +
 drivers/video/backlight/mt6370-backlight.c | 346 +++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)
 create mode 100644 drivers/video/backlight/mt6370-backlight.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index a003e02..7cd823d 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -268,6 +268,15 @@ config BACKLIGHT_MAX8925
 	  If you have a LCD backlight connected to the WLED output of MAX8925
 	  WLED output, say Y here to enable this driver.
 
+config BACKLIGHT_MT6370
+	tristate "Mediatek MT6370 Backlight Driver"
+	depends on MFD_MT6370
+	help
+	  This enables support for Mediatek MT6370 Backlight driver.
+	  It's commonly used to drive the display WLED. There are 4 channels
+	  inside, and each channel supports up to 30mA of current capability
+	  with 2048 current steps in exponential or linear mapping curves.
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
index 0000000..c2ba09d
--- /dev/null
+++ b/drivers/video/backlight/mt6370-backlight.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/backlight.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
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
+#define MT6370_BL_CONFIG_MASK		BIT(0)
+#define MT6370_BL_CH_MASK		GENMASK(5, 2)
+#define MT6370_BL_DIM2_MASK		GENMASK(2, 0)
+#define MT6370_BL_DUMMY_6372_MASK	GENMASK(2, 0)
+#define MT6370_BL_DIM2_6372_SHIFT	3
+#define MT6370_BL_PWM_EN_MASK		BIT(7)
+#define MT6370_BL_PWM_HYS_EN_MASK	BIT(2)
+#define MT6370_BL_PWM_HYS_SEL_MASK	GENMASK(1, 0)
+#define MT6370_BL_OVP_EN_MASK		BIT(7)
+#define MT6370_BL_OVP_SEL_MASK		GENMASK(6, 5)
+#define MT6370_BL_OC_EN_MASK		BIT(3)
+#define MT6370_BL_OC_SEL_MASK		GENMASK(2, 1)
+
+#define MT6370_BL_PWM_HYS_TH_MIN_STEP	1
+#define MT6370_BL_PWM_HYS_TH_MAX_STEP	64
+#define MT6370_BL_OVP_MIN_UV		17000000
+#define MT6370_BL_OVP_MAX_UV		29000000
+#define MT6370_BL_OVP_STEP_UV		4000000
+#define MT6370_BL_OCP_MIN_UA		900000
+#define MT6370_BL_OCP_MAX_UA		1800000
+#define MT6370_BL_OCP_STEP_UA		300000
+#define MT6370_BL_MAX_BRIGHTNESS	2048
+#define MT6370_BL_MAX_CH		15
+
+enum {
+	MT6370_VID_COMMON = 0,
+	MT6370_VID_6372,
+};
+
+struct mt6370_priv {
+	int vid_type;
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
+		brightness_val[0] = (brightness - 1) & MT6370_BL_DIM2_MASK;
+		brightness_val[1] = (brightness - 1)
+				    >> fls(MT6370_BL_DIM2_MASK);
+
+		/*
+		 * To make MT6372 using 14 bits to control the brightness
+		 * backward compatible with 11 bits brightness control
+		 * (like MT6370 and MT6371 do), we left shift the value
+		 * and pad with 1 to remaining bits. Hence, the MT6372's
+		 * backlight brightness will be almost the same as MT6370's
+		 * and MT6371's.
+		 */
+		if (priv->vid_type == MT6370_VID_6372) {
+			brightness_val[0] <<= MT6370_BL_DIM2_6372_SHIFT;
+			brightness_val[0] |= MT6370_BL_DUMMY_6372_MASK;
+		}
+
+		ret = regmap_raw_write(priv->regmap, MT6370_REG_BL_DIM2,
+				       brightness_val, sizeof(brightness_val));
+		if (ret)
+			return ret;
+	}
+
+	if (priv->enable_gpio)
+		gpiod_set_value(priv->enable_gpio, brightness ? 1 : 0);
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
+	if (priv->vid_type == MT6370_VID_6372)
+		brightness_val[0] >>= MT6370_BL_DIM2_6372_SHIFT;
+
+	brightness = brightness_val[1] << fls(MT6370_BL_DIM2_MASK);
+	brightness += (brightness_val[0] & MT6370_BL_DIM2_MASK);
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
+		/*
+		 * prop_val =  1      -->  1 steps --> 0x00
+		 * prop_val =  2 ~  4 -->  4 steps --> 0x01
+		 * prop_val =  5 ~ 16 --> 16 steps --> 0x10
+		 * prop_val = 17 ~ 64 --> 64 steps --> 0x11
+		 */
+		prop_val = (ilog2(roundup_pow_of_two(prop_val)) + 1) >> 1;
+		val |= prop_val << (ffs(MT6370_BL_PWM_HYS_SEL_MASK) - 1);
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
+		val |= ovp_uV << (ffs(MT6370_BL_OVP_SEL_MASK) - 1);
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
+		val |= ocp_uA << (ffs(MT6370_BL_OC_SEL_MASK) - 1);
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
+		brightness = MT6370_BL_MAX_BRIGHTNESS;
+
+	props->max_brightness = min_t(u32, brightness,
+				      MT6370_BL_MAX_BRIGHTNESS);
+
+	ret = device_property_read_u32(dev, "default-brightness", &brightness);
+	if (ret)
+		brightness = props->max_brightness;
+
+	props->brightness = min_t(u32, brightness, props->max_brightness);
+
+	val = 0;
+	prop_val = 0;
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
+	val = prop_val << (ffs(MT6370_BL_CH_MASK) - 1);
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
+	 * MT6372 uses 14 bits to control the brightness but MT6370 and MT6371
+	 * use 11 bits. They are different so we have to use this function to
+	 * check the vendor ID and use different methods to calculate the
+	 * brightness.
+	 */
+	unsigned int dev_info, vid;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MT6370_REG_DEV_INFO, &dev_info);
+	if (ret)
+		return ret;
+
+	vid = FIELD_GET(MT6370_VENID_MASK, dev_info);
+	if (vid == 0x9 || vid == 0xb)
+		priv->vid_type = MT6370_VID_6372;
+	else
+		priv->vid_type = MT6370_VID_COMMON;
+
+	return 0;
+}
+
+static int mt6370_bl_probe(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv;
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.scale = BACKLIGHT_SCALE_LINEAR,
+	};
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap)
+		dev_err_probe(&pdev->dev, -ENODEV, "Failed to get regmap\n");
+
+	ret = mt6370_check_vendor_info(priv);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "Failed to check vendor info\n");
+
+	priv->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio))
+		dev_err_probe(&pdev->dev, PTR_ERR(priv->enable_gpio),
+			      "Failed to get 'enable' gpio\n");
+
+	ret = mt6370_init_backlight_properties(priv, &props);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret,
+			      "Failed to init backlight properties\n");
+
+	priv->bl = devm_backlight_device_register(&pdev->dev, pdev->name,
+						  &pdev->dev, priv,
+						  &mt6370_bl_ops, &props);
+	if (IS_ERR(priv->bl))
+		dev_err_probe(&pdev->dev, PTR_ERR(priv->bl),
+			      "Failed to register backlight\n");
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
+static const struct of_device_id __maybe_unused mt6370_bl_of_match[] = {
+	{ .compatible = "mediatek,mt6370-backlight", },
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
+MODULE_DESCRIPTION("Mediatek MT6370 Backlight Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

