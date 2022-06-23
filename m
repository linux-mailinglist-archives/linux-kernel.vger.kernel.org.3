Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2206D557987
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiFWL7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiFWL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:58:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB9A12ABC;
        Thu, 23 Jun 2022 04:58:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t21so12629392pfq.1;
        Thu, 23 Jun 2022 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twoX90vjNZ5TJVryjZwIV5usboeuJvKudWY5Eq7pX2s=;
        b=Yu7r2PkQT35giInU8omF0mxG27zUw+oY0/yY1UNdyqA0McCyZswDO6SuiqyhMqw8jp
         LsiKgOUPrRM4OuJPWb73hTBZo759/H+evuq/oJq7pqcYhXPyoEW3LWsiXRhxZPGus9kD
         6uBjIadWhcRvel96bTc/0Okm3yjffom4UT2gZGH+5H6+w1OL90ON2mY2f6RgMrdXPegb
         sm+IyDIsRkLdqAQ6+Bu931eNbnvxAU2wmXK8neVanNagsEiMfOzBctQ5cTZIOCUXYpdt
         Hsg4YkqnGrM1shtQnIdBIfCDZ+KU8j/1oQKRGkgJz6Nb0uVDxrwkMy5jsXgMN0M6lqVN
         sgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twoX90vjNZ5TJVryjZwIV5usboeuJvKudWY5Eq7pX2s=;
        b=qC7RGysyCJnTMJnz1YUvIeee9qmD7gxMktRDV5trLUk8L5Orp0BDzJSinu+iM2f/LX
         coyBvcnyt73dILi4GQW8TZ8aoIuRfH8Pl4j6N1Ty4PDxnsiOvYs3I2iyldUz2PW0FM6f
         tzeT3vumAfyXC1R9DlMbGb04NBhm3r3HjsfrKfnR/BaMNZCCIqRqaJv7bXJLIgm7FTz8
         ZVXOdBKjLZTsUD94Gj/yaZiLiigYupjgKh+cyztjLtQw0QNdWWRST5lCnpr1Wq0iPtbX
         iMsPwCno/WA+V3j8uFXH/DhZyV869hJSrXY0eiVW24sceQIgfUrvh3lUM+WaljxG1iL1
         zNxg==
X-Gm-Message-State: AJIora8fcN+wCDNXxSstosLS7Rqn6sJk1q49n7Mull4PojZpqjbLV4NP
        4OwLafqiUhpZtR5MlG6WBcY=
X-Google-Smtp-Source: AGRyM1sDJESM2kA9i+aKrOwizpVH5nHvPIj+9yIwNXqrO5I8a0DrRwgjsOWNA89htMIvZYHMUO16Bw==
X-Received: by 2002:a63:5248:0:b0:402:de14:ab74 with SMTP id s8-20020a635248000000b00402de14ab74mr7336620pgl.18.1655985485965;
        Thu, 23 Jun 2022 04:58:05 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-71-94-93.emome-ip.hinet.net. [111.71.94.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b003fbfe88be17sm15016516pgo.24.2022.06.23.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:58:05 -0700 (PDT)
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
Subject: [PATCH v3 10/14] iio: adc: mt6370: Add Mediatek MT6370 support
Date:   Thu, 23 Jun 2022 19:56:27 +0800
Message-Id: <20220623115631.22209-11-peterwu.pub@gmail.com>
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

Add Mediatek MT6370 ADC support.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v3
- Refine Kconfig help text
- Refine all channel value in read_scale()
	a. current: uA --> mA
	b. voltage: uV --> mV
	c. temperature: degrees Celsius --> milli degrees Celsius
- Add "default:" condition of switch statement in read_scale() and read_raw()
- Add error message for reading ADC register failed
- Add the comment for adc_lock
- Add <linux/mod_devicetable.h> header file for struct of_device_id
- Replace "adc" text with "ADC" in all of the error messages
---
 drivers/iio/adc/Kconfig      |   9 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/mt6370-adc.c | 275 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100644 drivers/iio/adc/mt6370-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace74..c36b640 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -737,6 +737,15 @@ config MEDIATEK_MT6360_ADC
 	  is used in smartphones and tablets and supports a 11 channel
 	  general purpose ADC.
 
+config MEDIATEK_MT6370_ADC
+	tristate "Mediatek MT6370 ADC driver"
+	depends on MFD_MT6370
+	help
+	  Say yes here to enable Mediatek MT6370 ADC support.
+
+	  This ADC driver provides 9 channels for system monitoring (charger
+	  current, voltage, and temperature).
+
 config MEDIATEK_MT6577_AUXADC
 	tristate "MediaTek AUXADC driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f..0ce285c 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
+obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
new file mode 100644
index 0000000..ed7f1b3
--- /dev/null
+++ b/drivers/iio/adc/mt6370-adc.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MT6370_REG_CHG_CTRL3		0x113 /* AICR */
+#define MT6370_REG_CHG_CTRL7		0x117 /* ICHG */
+#define MT6370_REG_CHG_ADC		0x121
+#define MT6370_REG_ADC_DATA_H		0x14C
+
+#define MT6370_ADC_START_MASK		BIT(0)
+#define MT6370_ADC_IN_SEL_MASK		GENMASK(7, 4)
+#define MT6370_AICR_ICHG_MASK		GENMASK(7, 2)
+
+#define MT6370_AICR_400MA		0x6
+#define MT6370_ICHG_500MA		0x4
+#define MT6370_ICHG_900MA		0x8
+
+#define ADC_CONV_TIME_US		35000
+#define ADC_CONV_POLLING_TIME		1000
+
+struct mt6370_adc_data {
+	struct device *dev;
+	struct regmap *regmap;
+	/*
+	 * This mutex lock is for preventing the different ADC channels
+	 * from being read at the same time.
+	 */
+	struct mutex adc_lock;
+};
+
+static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
+				   unsigned long addr, int *val)
+{
+	__be16 be_val;
+	unsigned int reg_val;
+	int ret;
+
+	mutex_lock(&priv->adc_lock);
+
+	reg_val = MT6370_ADC_START_MASK |
+		  FIELD_PREP(MT6370_ADC_IN_SEL_MASK, addr);
+	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, reg_val);
+	if (ret)
+		goto adc_unlock;
+
+	msleep(ADC_CONV_TIME_US / 1000);
+
+	ret = regmap_read_poll_timeout(priv->regmap,
+				       MT6370_REG_CHG_ADC, reg_val,
+				       !(reg_val & MT6370_ADC_START_MASK),
+				       ADC_CONV_POLLING_TIME,
+				       ADC_CONV_TIME_US * 3);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(priv->dev, "Failed to wait ADC conversion\n");
+		else
+			dev_err(priv->dev,
+				"Failed to read ADC register (%d)\n", ret);
+
+		goto adc_unlock;
+	}
+
+	ret = regmap_raw_read(priv->regmap, MT6370_REG_ADC_DATA_H,
+			      &be_val, sizeof(be_val));
+	if (ret)
+		goto adc_unlock;
+
+	*val = be16_to_cpu(be_val);
+	ret = IIO_VAL_INT;
+
+adc_unlock:
+	mutex_unlock(&priv->adc_lock);
+
+	return ret;
+}
+
+static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
+				 int chan, int *val1, int *val2)
+{
+	unsigned int reg_val;
+	int ret;
+
+	switch (chan) {
+	case MT6370_CHAN_VBAT:
+	case MT6370_CHAN_VSYS:
+	case MT6370_CHAN_CHG_VDDP:
+		*val1 = 5;
+		return IIO_VAL_INT;
+	case MT6370_CHAN_IBUS:
+		ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL3, &reg_val);
+		if (ret)
+			return ret;
+
+		reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
+		if (reg_val < MT6370_AICR_400MA)
+			*val1 = 3350;
+		else
+			*val1 = 5000;
+
+		*val2 = 100;
+
+		return IIO_VAL_FRACTIONAL;
+	case MT6370_CHAN_IBAT:
+		ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL7, &reg_val);
+		if (ret)
+			return ret;
+
+		reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
+		if (reg_val < MT6370_ICHG_500MA)
+			*val1 = 2375;
+		else if (reg_val >= MT6370_ICHG_500MA &&
+			 reg_val < MT6370_ICHG_900MA)
+			*val1 = 2680;
+		else
+			*val1 = 5000;
+
+		*val2 = 100;
+
+		return IIO_VAL_FRACTIONAL;
+	case MT6370_CHAN_VBUSDIV5:
+		*val1 = 25;
+		return IIO_VAL_INT;
+	case MT6370_CHAN_VBUSDIV2:
+		*val1 = 50;
+		return IIO_VAL_INT;
+	case MT6370_CHAN_TS_BAT:
+		*val1 = 25;
+		*val2 = 10000;
+		return IIO_VAL_FRACTIONAL;
+	case MT6370_CHAN_TEMP_JC:
+		*val1 = 2000;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt6370_adc_read_offset(struct mt6370_adc_data *priv,
+				  int chan, int *val)
+{
+	*val = -20;
+
+	return IIO_VAL_INT;
+}
+
+static int mt6370_adc_read_raw(struct iio_dev *iio_dev,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2, long mask)
+{
+	struct mt6370_adc_data *priv = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return mt6370_adc_read_channel(priv, chan->channel,
+					       chan->address, val);
+	case IIO_CHAN_INFO_SCALE:
+		return mt6370_adc_read_scale(priv, chan->channel, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		return mt6370_adc_read_offset(priv, chan->channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const char * const mt6370_channel_labels[MT6370_CHAN_MAX] = {
+	[MT6370_CHAN_VBUSDIV5] = "vbusdiv5",
+	[MT6370_CHAN_VBUSDIV2] = "vbusdiv2",
+	[MT6370_CHAN_VSYS] = "vsys",
+	[MT6370_CHAN_VBAT] = "vbat",
+	[MT6370_CHAN_TS_BAT] = "ts_bat",
+	[MT6370_CHAN_IBUS] = "ibus",
+	[MT6370_CHAN_IBAT] = "ibat",
+	[MT6370_CHAN_CHG_VDDP] = "chg_vddp",
+	[MT6370_CHAN_TEMP_JC] = "temp_jc",
+};
+
+static int mt6370_adc_read_label(struct iio_dev *iio_dev,
+				 struct iio_chan_spec const *chan, char *label)
+{
+	return snprintf(label, PAGE_SIZE, "%s\n",
+			mt6370_channel_labels[chan->channel]);
+}
+
+static const struct iio_info mt6370_adc_iio_info = {
+	.read_raw = mt6370_adc_read_raw,
+	.read_label = mt6370_adc_read_label,
+};
+
+#define MT6370_ADC_CHAN(_idx, _type, _addr, _extra_info) {	\
+	.type = _type,						\
+	.channel = MT6370_CHAN_##_idx,				\
+	.address = _addr,					\
+	.scan_index = MT6370_CHAN_##_idx,			\
+	.indexed = 1,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE) |	\
+			      _extra_info			\
+}
+
+static const struct iio_chan_spec mt6370_adc_channels[] = {
+	MT6370_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE, 1, 0),
+	MT6370_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE, 2, 0),
+	MT6370_ADC_CHAN(VSYS, IIO_VOLTAGE, 3, 0),
+	MT6370_ADC_CHAN(VBAT, IIO_VOLTAGE, 4, 0),
+	MT6370_ADC_CHAN(TS_BAT, IIO_VOLTAGE, 6, 0),
+	MT6370_ADC_CHAN(IBUS, IIO_CURRENT, 8, 0),
+	MT6370_ADC_CHAN(IBAT, IIO_CURRENT, 9, 0),
+	MT6370_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE, 11, 0),
+	MT6370_ADC_CHAN(TEMP_JC, IIO_TEMP, 12, BIT(IIO_CHAN_INFO_OFFSET)),
+};
+
+static int mt6370_adc_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct mt6370_adc_data *priv;
+	struct regmap *regmap;
+	struct iio_dev *indio_dev;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "Failed to get regmap\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = &pdev->dev;
+	priv->regmap = regmap;
+	mutex_init(&priv->adc_lock);
+
+	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to reset ADC\n");
+		return ret;
+	}
+
+	indio_dev->name = "mt6370-adc";
+	indio_dev->info = &mt6370_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6370_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6370_adc_channels);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct of_device_id mt6370_adc_of_id[] = {
+	{ .compatible = "mediatek,mt6370-adc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6370_adc_of_id);
+
+static struct platform_driver mt6370_adc_driver = {
+	.driver = {
+		.name = "mt6370-adc",
+		.of_match_table = mt6370_adc_of_id,
+	},
+	.probe = mt6370_adc_probe,
+};
+module_platform_driver(mt6370_adc_driver);
+
+MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
+MODULE_DESCRIPTION("MT6370 ADC Drvier");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

