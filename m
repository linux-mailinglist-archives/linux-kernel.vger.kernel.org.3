Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148B757A273
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiGSOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiGSOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:53:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC2EF7E;
        Tue, 19 Jul 2022 07:52:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b9so13761503pfp.10;
        Tue, 19 Jul 2022 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5L8WZgwrQBlzN7NQ51s1WwHIlKrQQGcZkSlbQU03QI=;
        b=HPFhtDxnGxilU9gopw71eEs2wRP8N8B+JE0ihidZrFyPgv/XzbPIH3HzJSWszDLmoe
         fZZt5D73n+1NVDEy+v1MTEDbfUrcF0/soLaXXhj+Z2ETYV/VAcnJrFQLIEPsxO/nFKBx
         Suqj6YJJSbAjj1/FQFQezkm0plcpW1Xn09E4czQxY/eQD+gBOl6b76anB7OQdjtnBYXB
         FGjsz6WQjsaFMTMWdPPe+/qmqttyOX4G3HhYwE+GuOsyoZjrMtyBi5adPE91BrQh9VVL
         u7IX7nD+lcXMF5TFGptaUMO5GlMxTmX8YxWM9CzJFPp2NokfogLraDGVDpoqQI5ykw6z
         WY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5L8WZgwrQBlzN7NQ51s1WwHIlKrQQGcZkSlbQU03QI=;
        b=bTCTOpWHTCAQwmZ3Xmo4D4gtDCt46ls3BVZydR/A+6ykEHNQtij5rGDYn8pmToCq+p
         oC2Y+HZU60PJg/iIILfUHONsy1Vd8YfVF22S44eqTlo3FQ2AQhCvMnX8ncqNQSfsdUIJ
         NdCfmvaBBRB7HtHDPk03ZEOW7QQQOANfMIXClv/37bwdlgiCiLIQUXx/PnKwABr1/IDV
         68OXjHA3HsrZ0a+lyuuQP1aiqc/sTkZ8ohkSz3tz6DsMhKQJT4yzJ4pfEJGOFJX7vnoi
         WHXxtO64EV9dLK3Oje1NgPlSy1yIWG28UzAuUjdnOWY6cHNf3ZOGOBVeAdWZYTQgnqrw
         BbUw==
X-Gm-Message-State: AJIora8+O14uPzSXBmSrv/N91ayTMxjjKxvoi7rargDlmjAkGk6p8Bsl
        I+TgHgsgPKhJMY0cTHDVwAc=
X-Google-Smtp-Source: AGRyM1vl/AR794363jw0OcHOPQ5WLnKcG6I4rW/dAAgh9zLpA4LUg8KLRo1YCyf6+75Ahfs4LzKL4w==
X-Received: by 2002:a63:8649:0:b0:419:be28:bc36 with SMTP id x70-20020a638649000000b00419be28bc36mr22767462pgd.549.1658242378984;
        Tue, 19 Jul 2022 07:52:58 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-142.dynamic-ip.hinet.net. [1.171.6.142])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b001615f64aaabsm11630842ple.244.2022.07.19.07.52.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:52:58 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 2/3] iio: adc: Add rtq6056 support
Date:   Tue, 19 Jul 2022 22:52:44 +0800
Message-Id: <1658242365-27797-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
References: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add Richtek rtq6056 supporting.

It can be used for the system to monitor load current and power with 16-bit
resolution.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Since v8
- Instead of 'integraion_time' for voltage channel, use per channel sampling
  frequency to be more generic.

Since v7
- Use 'DEFINE_RUNTIME_DEV_PM_OPS' to replace the explicit declaration of pm_ops.

Since v6
- Remove specific rtq6056 ABI document.
- Remove the redundant blank line.
- To prevent the race condition for attribute wrtie and shunt resistor write,
  use 'iio_device_claim_direct_mode' API.
- Refine the order for 'action_reset' and 'pm_runtime'.
- Fix text typo in comment like as ohm to Ohm and timea to time.

Since v5
- Fix kernel version text for ABI.

Since v4
- Add '__aligned(8)' for timestamp member in buffer_trigger_handler function.
- Declare timestamp from 'int64_t' to more unified 's64'.

Since v3
- Refine pm_runtime API calling order in 'read_channel' API.
- Fix vshunt wrong scale for divider.
- Refine the comment text.
- Use 'devm_add_action_or_reset' to decrease the code usage in probe
  function.
- Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
- minor fix for the comma.
- Use pm_ptr to replace the direct assigned pm_ops.

Since v2
- Rename file from 'rtq6056-adc' to 'rtq6056'.
- Refine the ABI, if generic already defined it, remove it and check the channel
  report unit.
- Add copyright text.
- include the correct header.
- change the property parsing name.
- To use iio_chan_spec address field.
- Refine each channel separate and shared_by_all.
- Use pm_runtime and pm_runtime_autosuspend.
- Remove the shutdown callback. From the HW suggestion, it's not recommended to
  use battery as the power supply.
- Check all scale unit (voltage->mV, current->mA, power->milliWatt).
- Use the read_avail to provide the interface for attribute value list.
- Add comma for the last element in the const integer array.
- Refine each ADC label text.
- In read_label callback, replace snprintf to sysfs_emit.
---
 drivers/iio/adc/Kconfig   |  15 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/rtq6056.c | 661 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 677 insertions(+)
 create mode 100644 drivers/iio/adc/rtq6056.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace74..caebd1a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -908,6 +908,21 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config RICHTEK_RTQ6056
+	tristate "Richtek RTQ6056 Current and Power Monitor ADC"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to enable RQT6056 ADC support.
+	  RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
+	  compatible interface, and the device provides full information for
+	  system by reading out the load current and power.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called rtq6056.
+
 config RZG2L_ADC
 	tristate "Renesas RZ/G2L ADC driver"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f..cda7580 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
 obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
+obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
new file mode 100644
index 00000000..c1b2e8d
--- /dev/null
+++ b/drivers/iio/adc/rtq6056.c
@@ -0,0 +1,661 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Richtek Technology Corp.
+ *
+ * ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/util_macros.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define RTQ6056_REG_CONFIG	0x00
+#define RTQ6056_REG_SHUNTVOLT	0x01
+#define RTQ6056_REG_BUSVOLT	0x02
+#define RTQ6056_REG_POWER	0x03
+#define RTQ6056_REG_CURRENT	0x04
+#define RTQ6056_REG_CALIBRATION	0x05
+#define RTQ6056_REG_MASKENABLE	0x06
+#define RTQ6056_REG_ALERTLIMIT	0x07
+#define RTQ6056_REG_MANUFACTID	0xFE
+#define RTQ6056_REG_DIEID	0xFF
+
+#define RTQ6056_VENDOR_ID	0x1214
+#define RTQ6056_DEFAULT_CONFIG	0x4127
+#define RTQ6056_CONT_ALLON	7
+
+enum {
+	RTQ6056_CH_VSHUNT = 0,
+	RTQ6056_CH_VBUS,
+	RTQ6056_CH_POWER,
+	RTQ6056_CH_CURRENT,
+	RTQ6056_MAX_CHANNEL
+};
+
+enum {
+	F_OPMODE = 0,
+	F_VSHUNTCT,
+	F_VBUSCT,
+	F_AVG,
+	F_RESET,
+	F_MAX_FIELDS
+};
+
+struct rtq6056_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_field *rm_fields[F_MAX_FIELDS];
+	u32 shunt_resistor_uohm;
+	int vshuntct_us;
+	int vbusct_us;
+	int avg_sample;
+};
+
+static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] = {
+	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
+	[F_VSHUNTCT] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 5),
+	[F_VBUSCT] = REG_FIELD(RTQ6056_REG_CONFIG, 6, 8),
+	[F_AVG]	= REG_FIELD(RTQ6056_REG_CONFIG, 9, 11),
+	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),
+};
+
+static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.address = RTQ6056_REG_SHUNTVOLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.address = RTQ6056_REG_BUSVOLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_POWER,
+		.indexed = 1,
+		.channel = 2,
+		.address = RTQ6056_REG_POWER,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_CURRENT,
+		.indexed = 1,
+		.channel = 3,
+		.address = RTQ6056_REG_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL),
+};
+
+static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
+				    struct iio_chan_spec const *ch,
+				    int *val)
+{
+	struct device *dev = priv->dev;
+	unsigned int addr = ch->address;
+	unsigned int regval;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = regmap_read(priv->regmap, addr, &regval);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
+	if (ret)
+		return ret;
+
+	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
+	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
+		*val = regval;
+	else
+		*val = sign_extend32(regval, 16);
+
+	return IIO_VAL_INT;
+}
+
+static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
+				  int *val2)
+{
+	switch (ch->address) {
+	case RTQ6056_REG_SHUNTVOLT:
+		/* VSHUNT lsb  2.5uV */
+		*val = 2500;
+		*val2 = 1000000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_REG_BUSVOLT:
+		/* VBUS lsb 1.25mV */
+		*val = 1250;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_REG_POWER:
+		/* Power lsb 25mW */
+		*val = 25;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Sample frequency for channel VSHUNT and VBUS. The indices correspond
+ * with the bit value expected by the chip. And it can be found at
+ * https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+ */
+static const int rtq6056_samp_freq_list[] = {
+	7194, 4926, 3717, 1904, 964, 485, 243, 122,
+};
+
+static int rtq6056_adc_set_samp_freq(struct rtq6056_priv *priv,
+				     struct iio_chan_spec const *ch, int val)
+{
+	struct regmap_field *rm_field;
+	unsigned int selector;
+	int *ct, ret;
+
+	if (val > 7194 || val < 122)
+		return -EINVAL;
+
+	if (ch->address == RTQ6056_REG_SHUNTVOLT) {
+		rm_field = priv->rm_fields[F_VSHUNTCT];
+		ct = &priv->vshuntct_us;
+	} else if (ch->address == RTQ6056_REG_BUSVOLT) {
+		rm_field = priv->rm_fields[F_VBUSCT];
+		ct = &priv->vbusct_us;
+	} else
+		return -EINVAL;
+
+	selector = find_closest_descending(val, rtq6056_samp_freq_list,
+					   ARRAY_SIZE(rtq6056_samp_freq_list));
+
+	ret = regmap_field_write(rm_field, selector);
+	if (ret)
+		return ret;
+
+	*ct = 1000000 / rtq6056_samp_freq_list[selector];
+
+	return 0;
+}
+
+/*
+ * Available averaging rate for rtq6056. The indices correspond with the bit
+ * value expected by the chip. And it can be found at
+ * https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+ */
+static const int rtq6056_avg_sample_list[] = {
+	1, 4, 16, 64, 128, 256, 512, 1024,
+};
+
+static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
+{
+	unsigned int selector;
+	int ret;
+
+	if (val > 1024 || val < 1)
+		return -EINVAL;
+
+	selector = find_closest(val, rtq6056_avg_sample_list,
+				ARRAY_SIZE(rtq6056_avg_sample_list));
+
+	ret = regmap_field_write(priv->rm_fields[F_AVG], selector);
+	if (ret)
+		return ret;
+
+	priv->avg_sample = rtq6056_avg_sample_list[selector];
+
+	return 0;
+}
+
+static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv,
+				       struct iio_chan_spec const *ch, int *val)
+{
+	int sample_time;
+
+	if (ch->address == RTQ6056_REG_SHUNTVOLT)
+		sample_time = priv->vshuntct_us;
+	else if (ch->address == RTQ6056_REG_BUSVOLT)
+		sample_time = priv->vbusct_us;
+	else {
+		sample_time = priv->vshuntct_us + priv->vbusct_us;
+		sample_time *= priv->avg_sample;
+	}
+
+	*val = 1000000 / sample_time;
+
+	return IIO_VAL_INT;
+}
+
+static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return rtq6056_adc_read_channel(priv, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		return rtq6056_adc_read_scale(chan, val, val2);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = priv->avg_sample;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return rtq6056_adc_get_sample_freq(priv, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = rtq6056_samp_freq_list;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(rtq6056_samp_freq_list);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = rtq6056_avg_sample_list;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(rtq6056_avg_sample_list);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int val,
+				 int val2, long mask)
+{
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = rtq6056_adc_set_average(priv, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
+	[RTQ6056_CH_VSHUNT] = "Vshunt",
+	[RTQ6056_CH_VBUS] = "Vbus",
+	[RTQ6056_CH_POWER] = "Power",
+	[RTQ6056_CH_CURRENT] = "Current",
+};
+
+static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  char *label)
+{
+	return sysfs_emit(label, "%s\n", rtq6056_channel_labels[chan->channel]);
+}
+
+static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
+				      int resistor_uohm)
+{
+	unsigned int calib_val;
+	int ret;
+
+	if (resistor_uohm <= 0) {
+		dev_err(priv->dev, "Invalid resistor [%d]\n", resistor_uohm);
+		return -EINVAL;
+	}
+
+	/* calibration = 5120000 / (Rshunt (uOhm) * current lsb (1mA)) */
+	calib_val = 5120000 / resistor_uohm;
+	ret = regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib_val);
+	if (ret)
+		return ret;
+
+	priv->shunt_resistor_uohm = resistor_uohm;
+
+	return 0;
+}
+
+static ssize_t shunt_resistor_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct rtq6056_priv *priv = iio_priv(dev_to_iio_dev(dev));
+	int vals[2] = { priv->shunt_resistor_uohm, 1000000 };
+
+	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
+}
+
+static ssize_t shunt_resistor_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	int val, val_fract, ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
+	if (ret)
+		goto out_store;
+
+	ret = rtq6056_set_shunt_resistor(priv, val * 1000000 + val_fract);
+
+out_store:
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret ?: len;
+}
+
+static IIO_DEVICE_ATTR_RW(shunt_resistor, 0);
+
+static struct attribute *rtq6056_attributes[] = {
+	&iio_dev_attr_shunt_resistor.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group rtq6056_attribute_group = {
+	.attrs = rtq6056_attributes,
+};
+
+static const struct iio_info rtq6056_info = {
+	.attrs = &rtq6056_attribute_group,
+	.read_raw = rtq6056_adc_read_raw,
+	.read_avail = rtq6056_adc_read_avail,
+	.write_raw = rtq6056_adc_write_raw,
+	.read_label = rtq6056_adc_read_label,
+};
+
+static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	struct device *dev = priv->dev;
+	struct {
+		u16 vals[RTQ6056_MAX_CHANNEL];
+		s64 timestamp __aligned(8);
+	} data;
+	unsigned int raw;
+	int i = 0, bit, ret;
+
+	memset(&data, 0, sizeof(data));
+
+	pm_runtime_get_sync(dev);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		unsigned int addr = rtq6056_channels[bit].address;
+
+		ret = regmap_read(priv->regmap, addr, &raw);
+		if (ret)
+			goto out;
+
+		data.vals[i++] = raw;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static void rtq6056_enter_shutdown_state(void *dev)
+{
+	struct rtq6056_priv *priv = dev_get_drvdata(dev);
+
+	/* Enter shutdown state */
+	regmap_field_write(priv->rm_fields[F_OPMODE], 0);
+}
+
+static bool rtq6056_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RTQ6056_REG_CONFIG ... RTQ6056_REG_ALERTLIMIT:
+	case RTQ6056_REG_MANUFACTID ... RTQ6056_REG_DIEID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rtq6056_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RTQ6056_REG_CONFIG:
+	case RTQ6056_REG_CALIBRATION ... RTQ6056_REG_ALERTLIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rtq6056_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = RTQ6056_REG_DIEID,
+	.readable_reg = rtq6056_is_readable_reg,
+	.writeable_reg = rtq6056_is_writeable_reg,
+};
+
+static int rtq6056_probe(struct i2c_client *i2c)
+{
+	struct iio_dev *indio_dev;
+	struct rtq6056_priv *priv;
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+	unsigned int vendor_id, shunt_resistor_uohm;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = dev;
+	priv->vshuntct_us = priv->vbusct_us = 1037;
+	priv->avg_sample = 1;
+	i2c_set_clientdata(i2c, priv);
+
+	regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init regmap\n");
+
+	priv->regmap = regmap;
+
+	ret = regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get manufacturer info\n");
+
+	if (vendor_id != RTQ6056_VENDOR_ID)
+		return dev_err_probe(dev, -ENODEV,
+				     "Invalid vendor id 0x%04x\n", vendor_id);
+
+	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
+					   rtq6056_reg_fields, F_MAX_FIELDS);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regmap field\n");
+
+	/*
+	 * By default, configure average sample as 1, bus and shunt conversion
+	 * time as 1037 microsecond, and operating mode to all on.
+	 */
+	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable continuous sensing\n");
+
+	ret = devm_add_action_or_reset(dev, rtq6056_enter_shutdown_state, dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_mark_last_busy(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
+
+	/* By default, use 2000 micro-Ohm resistor */
+	shunt_resistor_uohm = 2000;
+	device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				 &shunt_resistor_uohm);
+
+	ret = rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to init shunt resistor\n");
+
+	indio_dev->name = "rtq6056";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = rtq6056_channels;
+	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
+	indio_dev->info = &rtq6056_info;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      rtq6056_buffer_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to allocate iio trigger buffer\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int rtq6056_runtime_suspend(struct device *dev)
+{
+	struct rtq6056_priv *priv = dev_get_drvdata(dev);
+
+	/* Configure to shutdown mode */
+	return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
+}
+
+static int rtq6056_runtime_resume(struct device *dev)
+{
+	struct rtq6056_priv *priv = dev_get_drvdata(dev);
+	int sample_rdy_time_us, ret;
+
+	ret = regmap_field_write(priv->rm_fields[F_OPMODE], RTQ6056_CONT_ALLON);
+	if (ret)
+		return ret;
+
+	sample_rdy_time_us = priv->vbusct_us + priv->vshuntct_us;
+	sample_rdy_time_us *= priv->avg_sample;
+
+	usleep_range(sample_rdy_time_us, sample_rdy_time_us + 100);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(rtq6056_pm_ops, rtq6056_runtime_suspend,
+				 rtq6056_runtime_resume, NULL);
+
+static const struct of_device_id rtq6056_device_match[] = {
+	{ .compatible = "richtek,rtq6056" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtq6056_device_match);
+
+static struct i2c_driver rtq6056_driver = {
+	.driver = {
+		.name = "rtq6056",
+		.of_match_table = rtq6056_device_match,
+		.pm = pm_ptr(&rtq6056_pm_ops),
+	},
+	.probe_new = rtq6056_probe,
+};
+module_i2c_driver(rtq6056_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTQ6056 Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

