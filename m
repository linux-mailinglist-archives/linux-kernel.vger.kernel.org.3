Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E07B5AE317
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiIFIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbiIFIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:39:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6372B64;
        Tue,  6 Sep 2022 01:37:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 145so10667035pfw.4;
        Tue, 06 Sep 2022 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X2c8HiFtZtT40/1N/slgJQVOA1aM14Oprn847vWNQSs=;
        b=AOTdnEA0zNNZin3+4U52W1NAusirXCLrN7iksoZUlGkoqGEBr1nGwyUN2gA2oxndGt
         lQEIdCFOODe7b4UjAzRg9m8807EXRZ34H227/CvU3Y0V4KNwIQebynBh0sB4FN3Y7AlA
         TXkVPQODjkXV1gPsLextistGiBvEsKYoO4/gSCUQQnsChUf4wJuCqiiLkTdTWGKKswMp
         iHgXsxMcNWUGpG13qi4v7FGYSbZ9rOvvVSEcCjHSVoZZcFMKJBDHqyN6utJACMCCVK5L
         crqari4y8acpvQCJ5noxRPHtzBZhzL/Gum/F3+bY6aMr0THp6QghjuIsQXTTRtegYxgc
         qtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X2c8HiFtZtT40/1N/slgJQVOA1aM14Oprn847vWNQSs=;
        b=3nMiwdSY2F26Jw7kjjl9UlxmfUvRt4SYjRG8SDE/v8j0Ud2YNaGDhgZXDf4L7RH3NF
         8LHptKe5igOf+CIFFhcjr7A9tE0t2vcpdHopo80XfnaaHFPzcnfUV51+FPA3bYjs8Ss0
         /tsY8WmAKm5MyRFRVrgdG04Fu0uJnZ5IqOc/XW9oiW+QaXPe0faYdaXbz9nq/yvd/8Yg
         mBFmze6XpJsI93Na7W363B7TsNwHyWLMRsn/WWQNq56y6r35l8/GCQg+1Bb+83SMtJHv
         6zg88JYR7Oo1yOnKh2auvFJEwI4MCyr4qW5LCf73m8ddNWfPEGnNL4sK1KrxB/+LGHaw
         EDog==
X-Gm-Message-State: ACgBeo1+gjio9lEbBA0pd0xVH7IrPrcJC3hg9o1bdicKYS+xjLTC/ICg
        52CBSAKIYtYwuEpSAjUE2TM=
X-Google-Smtp-Source: AA6agR6VIZX91ye7WWDy44hdyUGbd8XNWS9B2AsPsGs3I/dz9a8xwT+ss93b6xwkqlU9guslEEDlbA==
X-Received: by 2002:a63:e906:0:b0:41b:eba0:8b6d with SMTP id i6-20020a63e906000000b0041beba08b6dmr43982642pgh.501.1662453423715;
        Tue, 06 Sep 2022 01:37:03 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-80-193.emome-ip.hinet.net. [42.73.80.193])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm9474506pfj.57.2022.09.06.01.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 01:37:03 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 5/8] iio: adc: mt6370: Add MediaTek MT6370 support
Date:   Tue,  6 Sep 2022 16:34:01 +0800
Message-Id: <2cbe19e828e082aef848aee9f76b01fb9fc94d5a.1662476695.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662476695.git.chiaen_wu@richtek.com>
References: <cover.1662476695.git.chiaen_wu@richtek.com>
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

Add support for the MT6370 ADC driver for system monitoring, including
charger current, voltage, and temperature.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 drivers/iio/adc/Kconfig      |  12 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/mt6370-adc.c | 305 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 drivers/iio/adc/mt6370-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930..995cbb5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -736,6 +736,18 @@ config MEDIATEK_MT6360_ADC
 	  is used in smartphones and tablets and supports a 11 channel
 	  general purpose ADC.
 
+config MEDIATEK_MT6370_ADC
+	tristate "MediaTek MT6370 ADC driver"
+	depends on MFD_MT6370
+	help
+	  Say yes here to enable MediaTek MT6370 ADC support.
+
+	  This ADC driver provides 9 channels for system monitoring (charger
+	  current, voltage, and temperature).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "mt6370-adc".
+
 config MEDIATEK_MT6577_AUXADC
 	tristate "MediaTek AUXADC driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1772a54..c6bc35f 100644
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
index 0000000..2a46471
--- /dev/null
+++ b/drivers/iio/adc/mt6370-adc.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiaEn Wu <chiaen_wu@richtek.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+
+#include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
+
+#define MT6370_REG_CHG_CTRL3		0x113
+#define MT6370_REG_CHG_CTRL7		0x117
+#define MT6370_REG_CHG_ADC		0x121
+#define MT6370_REG_ADC_DATA_H		0x14C
+
+#define MT6370_ADC_START_MASK		BIT(0)
+#define MT6370_ADC_IN_SEL_MASK		GENMASK(7, 4)
+#define MT6370_AICR_ICHG_MASK		GENMASK(7, 2)
+
+#define MT6370_AICR_100_mA		0x0
+#define MT6370_AICR_150_mA		0x1
+#define MT6370_AICR_200_mA		0x2
+#define MT6370_AICR_250_mA		0x3
+#define MT6370_AICR_300_mA		0x4
+#define MT6370_AICR_350_mA		0x5
+
+#define MT6370_ICHG_100_mA		0x0
+#define MT6370_ICHG_200_mA		0x1
+#define MT6370_ICHG_300_mA		0x2
+#define MT6370_ICHG_400_mA		0x3
+#define MT6370_ICHG_500_mA		0x4
+#define MT6370_ICHG_600_mA		0x5
+#define MT6370_ICHG_700_mA		0x6
+#define MT6370_ICHG_800_mA		0x7
+
+#define ADC_CONV_TIME_MS		35
+#define ADC_CONV_POLLING_TIME_US	1000
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
+	unsigned int reg_val;
+	__be16 be_val;
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
+	msleep(ADC_CONV_TIME_MS);
+
+	ret = regmap_read_poll_timeout(priv->regmap,
+				       MT6370_REG_CHG_ADC, reg_val,
+				       !(reg_val & MT6370_ADC_START_MASK),
+				       ADC_CONV_POLLING_TIME_US,
+				       ADC_CONV_TIME_MS * MILLI * 3);
+	if (ret) {
+		dev_err(priv->dev, "Failed to read ADC register (%d)\n", ret);
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
+		switch (reg_val) {
+		case MT6370_AICR_100_mA:
+		case MT6370_AICR_150_mA:
+		case MT6370_AICR_200_mA:
+		case MT6370_AICR_250_mA:
+		case MT6370_AICR_300_mA:
+		case MT6370_AICR_350_mA:
+			*val1 = 3350;
+			break;
+		default:
+			*val1 = 5000;
+			break;
+		}
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
+		switch (reg_val) {
+		case MT6370_ICHG_100_mA:
+		case MT6370_ICHG_200_mA:
+		case MT6370_ICHG_300_mA:
+		case MT6370_ICHG_400_mA:
+			*val1 = 2375;
+			break;
+		case MT6370_ICHG_500_mA:
+		case MT6370_ICHG_600_mA:
+		case MT6370_ICHG_700_mA:
+		case MT6370_ICHG_800_mA:
+			*val1 = 2680;
+			break;
+		default:
+			*val1 = 5000;
+			break;
+		}
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
+	return sysfs_emit(label, "%s\n", mt6370_channel_labels[chan->channel]);
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
+			      _extra_info,			\
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
+	struct device *dev = &pdev->dev;
+	struct mt6370_adc_data *priv;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = dev;
+	priv->regmap = regmap;
+	mutex_init(&priv->adc_lock);
+
+	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset ADC\n");
+
+	indio_dev->name = "mt6370-adc";
+	indio_dev->info = &mt6370_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6370_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6370_adc_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
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
+MODULE_DESCRIPTION("MT6370 ADC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

