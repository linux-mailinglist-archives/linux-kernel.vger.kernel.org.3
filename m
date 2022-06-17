Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1454F45D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381056AbiFQJdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381128AbiFQJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:33:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45CD2F3A5;
        Fri, 17 Jun 2022 02:33:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so4077046pjl.5;
        Fri, 17 Jun 2022 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mez5EYREdjKLyaqf8fIRmT2LGawYULPJW6Jh3Kf03/4=;
        b=fQ04Xel58yHysqGF6okB4GLDb8twmJKpo4jzpXoA4a+Iat4PzJfIIQhoPzIIOStpH9
         VkIfYAJWGkxORruCvHC1BbmnVsh63ak/YBllO0jGD+pfKgRpp7i/FGzFqZlLgDmcV1TU
         dYUwXuxtM4HR3mp5BKcYnOGbAhnAw/tkW006nE/77khgkH81VBEwaL4xtBvpaO614fuV
         +yYTtGQqpEYwOdPw7B8K1tAqsa6NzVmhHqHwlS9/eAQeP2JPFwO5YBTxGWwVNT18ks4r
         md3oymMhF0P57qvykU4WrJKejdWGDINoq+mD4XqGGVL5/rfFLv6n0G973ugmW0n8JSYI
         hvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mez5EYREdjKLyaqf8fIRmT2LGawYULPJW6Jh3Kf03/4=;
        b=u+idP+oS3Lump6AFaGlsUvtM7QL3SqDtuJd3yQ5XaxYSZh6sa9WRAIchNrljwpY/zN
         JWUU9N/NtCKoshLXxaV2T3Ea7iWP8s0/ymUOHFPM5fJU78cyoEYngNkAaQY81XSYNGsu
         km++QDyDHFvoB5hTxid74QqY6ThKXmwQHpbgplzKD57N0nf32Sw7aKVI+mqBsz285ZNb
         rJQRqW6y9wu3Pzt0y1O5F0ucFe51p0zXRbGNkLH7obreSQS8Yjq3iRqLRoZXUSzTn0xD
         OJbcu5pDqii29PhxtFdZsEI+YD5VlJK03u7i4fWt/3TyD3XNsd0/W94Rb3aAyUXyRj0A
         7U+Q==
X-Gm-Message-State: AJIora/teMb9eskaTo8OuuQLYpicMF6D+5LM5H/4qzlsi9ZMd9EmO/Si
        QcZsoECiL6pg5IHC4XSQ3eE=
X-Google-Smtp-Source: AGRyM1tAF4ld9BuXcFKuSgbKMN6BQp4b15EbeIHsQ9fq/4o5+QBhelMZO6toOl53U5hlOwNHeScIsA==
X-Received: by 2002:a17:90a:1d0:b0:1ec:7066:49b8 with SMTP id 16-20020a17090a01d000b001ec706649b8mr4384985pjd.163.1655458386980;
        Fri, 17 Jun 2022 02:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:e813:14e7:c8c7:4065:3f67])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b0015e8d4eb242sm3103576plg.140.2022.06.17.02.33.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:33:06 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: Add rtq6056 support
Date:   Fri, 17 Jun 2022 17:32:55 +0800
Message-Id: <1655458375-30478-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add Richtek RTQ6056 supporting.

It can be used for the system to monitor load current and power with 16bit
resolution.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |  58 +++
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rtq6056-adc.c                      | 548 +++++++++++++++++++++
 4 files changed, 622 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
 create mode 100644 drivers/iio/adc/rtq6056-adc.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
new file mode 100644
index 00000000..0516429
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
@@ -0,0 +1,58 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_raw
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		Shunt IN +/- sensing range from -82mV to +81.9175mV
+		Calculating with scale (2.5 uV)
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_raw
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		BUS voltage sensing range from 0V to 36V.
+		Calculating with scale (1.25 mV)
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_power2_raw
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		Power loading that equals to bus voltage multiple loading
+		current.
+		Calculating with scale (25 mWatt)
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current3_raw
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		Consuming current from bus voltage.
+		Directly report loading current in mA
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_integration_time
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		Shunt voltage conversion time in uS
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_integration_time
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		BUS voltage conversion time in uS
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_oversampling_ratio
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		The number of average sample
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_sampling_frequency
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		Sampling frequency in HZ for power and current report
+
+What:		/sys/bus/iio/devices/iio:deviceX/integration_time_available
+KernelVersion:	5.18.2
+Contact:	cy_huang@richtek.com
+Description:
+		Sample conversion time available for BUS and Shunt, unit in second
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace74..0b2d17c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -908,6 +908,21 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config RICHTEK_RTQ6056_ADC
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
+	  called rtq6056-adc.
+
 config RZG2L_ADC
 	tristate "Renesas RZ/G2L ADC driver"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f..e8c6e6e 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
 obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
+obj-$(CONFIG_RICHTEK_RTQ6056_ADC) += rtq6056-adc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
diff --git a/drivers/iio/adc/rtq6056-adc.c b/drivers/iio/adc/rtq6056-adc.c
new file mode 100644
index 00000000..8374fce
--- /dev/null
+++ b/drivers/iio/adc/rtq6056-adc.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
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
+#define RTQ6056_REG_CALIBRATION	0x05
+#define RTQ6056_REG_MASKENABLE	0x06
+#define RTQ6056_REG_ALERTLIMIT	0x07
+#define RTQ6056_REG_MANUFACTID	0xFE
+#define RTQ6056_REG_DIEID	0xFF
+
+#define RTQ6056_VENDOR_ID	0x1214
+#define RTQ6056_DEFAULT_CONFIG	0x4127
+#define RTQ6056_DEFAULT_CONVT	1037
+#define RTQ6056_DEFAULT_AVG	1
+#define RTQ6056_DEFAULT_RSHUNT	2000
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
+	F_OPMODE = 0, F_VSHUNTCT, F_VBUSCT, F_AVG, F_RESET,
+	F_MAX_FIELDS
+};
+
+struct rtq6056_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_field *rm_fields[F_MAX_FIELDS];
+	u32 shunt_resistor_uohm;
+	int vshuntct; /* vshunt conversion time in uS */
+	int vbusct; /* vbus conversion time in uS */
+	int avg_sample;
+};
+
+static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] = {
+	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
+	[F_VSHUNTCT] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 5),
+	[F_VBUSCT] = REG_FIELD(RTQ6056_REG_CONFIG, 6, 8),
+	[F_AVG]	= REG_FIELD(RTQ6056_REG_CONFIG, 9, 11),
+	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15)
+};
+
+static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = RTQ6056_CH_VSHUNT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
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
+		.channel = RTQ6056_CH_VBUS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
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
+		.channel = RTQ6056_CH_POWER,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
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
+		.channel = RTQ6056_CH_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL)
+};
+
+static int rtq6056_adc_read_channel(struct rtq6056_priv *priv, int channel,
+				    int *val)
+{
+	unsigned int reg = RTQ6056_REG_SHUNTVOLT + channel;
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(priv->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/* Only power and vbus channel is unsigned */
+	if (channel == RTQ6056_CH_VBUS || channel == RTQ6056_CH_POWER)
+		*val = regval;
+	else
+		*val = (s16)regval;
+
+	return IIO_VAL_INT;
+}
+
+static int rtq6056_adc_read_scale(int channel, int *val, int *val2)
+{
+	switch (channel) {
+	case RTQ6056_CH_VSHUNT:
+		/* VSHUNT lsb  2.5uV */
+		*val = 2500;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_CH_VBUS:
+		/* VBUS lsb 1.25mV */
+		*val = 1250;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+	case RTQ6056_CH_POWER:
+		/* Power lsb 25mV */
+		*val = 25;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Conversion time in uS for channel VSHUNT and VBUS */
+static const int rtq6056_conv_time_list[] = {
+	139, 203, 269, 525, 1037, 2061, 4109, 8205
+};
+
+static int rtq6056_adc_set_conv_time(struct rtq6056_priv *priv, int channel,
+				     int val)
+{
+	struct regmap_field *rm_field;
+	unsigned int selector;
+	int *ct, ret;
+
+	if (val > 8205 || val < 139)
+		return -EINVAL;
+
+	if (channel == RTQ6056_CH_VSHUNT) {
+		rm_field = priv->rm_fields[F_VSHUNTCT];
+		ct = &priv->vshuntct;
+	} else {
+		rm_field = priv->rm_fields[F_VBUSCT];
+		ct = &priv->vbusct;
+	}
+
+	selector = find_closest(val, rtq6056_conv_time_list,
+				ARRAY_SIZE(rtq6056_conv_time_list));
+
+	ret = regmap_field_write(rm_field, selector);
+	if (ret)
+		return ret;
+
+	*ct = rtq6056_conv_time_list[selector];
+	return 0;
+}
+
+static const int rtq6056_avg_sample_list[] = {
+	1, 4, 16, 64, 128, 256, 512, 1024
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
+	return 0;
+}
+
+static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv, int *val)
+{
+	int sample_time;
+
+	sample_time = priv->vshuntct + priv->vbusct;
+	sample_time *= priv->avg_sample;
+
+	*val = DIV_ROUND_UP(1000000, sample_time);
+	return IIO_VAL_INT;
+}
+
+static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	int channel = chan->channel;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return rtq6056_adc_read_channel(priv, channel, val);
+	case IIO_CHAN_INFO_SCALE:
+		return rtq6056_adc_read_scale(channel, val, val2);
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->channel == RTQ6056_CH_VSHUNT)
+			*val = priv->vshuntct;
+		else
+			*val = priv->vbusct;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = priv->avg_sample;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return rtq6056_adc_get_sample_freq(priv, val);
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
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return rtq6056_adc_set_conv_time(priv, chan->channel, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return rtq6056_adc_set_average(priv, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
+	[RTQ6056_CH_VSHUNT] = "Vshunt(uV)",
+	[RTQ6056_CH_VBUS] = "Vbus(mV)",
+	[RTQ6056_CH_POWER] = "Power(mW)",
+	[RTQ6056_CH_CURRENT] = "Current(mA)",
+};
+
+static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  char *label)
+{
+	return snprintf(label, PAGE_SIZE, "%s\n",
+			rtq6056_channel_labels[chan->channel]);
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
+	/* calibration = 5120000 / (Rshunt (uohm) * current lsb (1mA)) */
+	calib_val = 5120000 / resistor_uohm;
+	ret = regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib_val);
+	if (ret)
+		return ret;
+
+	priv->shunt_resistor_uohm = resistor_uohm;
+	return 0;
+}
+
+static ssize_t rtq6056_shunt_resistor_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct rtq6056_priv *priv = iio_priv(dev_to_iio_dev(dev));
+	int vals[2] = { priv->shunt_resistor_uohm, 1000000 };
+
+	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
+}
+
+static ssize_t rtq6056_shunt_resistor_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	struct rtq6056_priv *priv = iio_priv(dev_to_iio_dev(dev));
+	int val, val_fract, ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
+	if (ret)
+		return ret;
+
+	ret = rtq6056_set_shunt_resistor(priv, val * 1000000 + val_fract);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_CONST_ATTR_NAMED(rtq6056_conv_time_available,
+			    integration_time_available,
+			    "0.000139 0.000203 0.000269 0.000525 0.001037 0.002061 0.004109 0.008205");
+
+static IIO_DEVICE_ATTR(shunt_resistor, 0644,
+		       rtq6056_shunt_resistor_show,
+		       rtq6056_shunt_resistor_store, 0);
+
+static struct attribute *rtq6056_attributes[] = {
+	&iio_const_attr_rtq6056_conv_time_available.dev_attr.attr,
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
+	.write_raw = rtq6056_adc_write_raw,
+	.read_label = rtq6056_adc_read_label,
+};
+
+static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct rtq6056_priv *priv = iio_priv(indio_dev);
+	struct {
+		u16 vals[RTQ6056_MAX_CHANNEL];
+		int64_t timestamp;
+	} data __aligned(8);
+	unsigned int raw;
+	int i = 0, bit, ret;
+
+	memset(&data, 0, sizeof(data));
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+
+		ret = regmap_read(priv->regmap, RTQ6056_REG_SHUNTVOLT + bit,
+				  &raw);
+		if (ret)
+			goto out;
+
+		data.vals[i++] = raw;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
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
+	unsigned int vendor_id, shunt_resistor_uohm;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = &i2c->dev;
+	priv->vshuntct = priv->vbusct = RTQ6056_DEFAULT_CONVT;
+	priv->avg_sample = RTQ6056_DEFAULT_AVG;
+	i2c_set_clientdata(i2c, priv);
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(priv->regmap),
+				     "Failed to init regmap\n");
+
+	ret = regmap_read(priv->regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to get manufacturer info\n");
+
+	if (vendor_id != RTQ6056_VENDOR_ID)
+		return dev_err_probe(&i2c->dev, -ENODEV,
+				     "invalid vendor id 0x%04x\n", vendor_id);
+
+	ret = devm_regmap_field_bulk_alloc(&i2c->dev, priv->regmap,
+					   priv->rm_fields, rtq6056_reg_fields,
+					   F_MAX_FIELDS);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to init regmap field\n");
+
+	/* Write the default config value */
+	ret = regmap_write(priv->regmap, RTQ6056_REG_CONFIG,
+			   RTQ6056_DEFAULT_CONFIG);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to write default config\n");
+
+	ret = of_property_read_u32(i2c->dev.of_node,
+				   "richtek,shunt-resistor-uohm",
+				   &shunt_resistor_uohm);
+	if (ret)
+		shunt_resistor_uohm = RTQ6056_DEFAULT_RSHUNT;
+
+	ret = rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
+	if (ret)
+		dev_err_probe(&i2c->dev, ret,
+			      "Failed to init shunt resistor\n");
+
+	indio_dev->name = "rtq6056";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = rtq6056_channels;
+	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
+	indio_dev->info = &rtq6056_info;
+
+	ret = devm_iio_triggered_buffer_setup(&i2c->dev, indio_dev, NULL,
+					      rtq6056_buffer_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to allocate iio trigger buffer\n");
+
+	return devm_iio_device_register(&i2c->dev, indio_dev);
+}
+
+static int rtq6056_remove(struct i2c_client *i2c)
+{
+	struct rtq6056_priv *priv = i2c_get_clientdata(i2c);
+
+	/* Config opmode to 'shutdown' mode to minimize quiescient current */
+	return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
+}
+
+static void rtq6056_shutdown(struct i2c_client *i2c)
+{
+	struct rtq6056_priv *priv = i2c_get_clientdata(i2c);
+
+	/* Config opmode to 'shutdown' mode to minimize quiescient current */
+	regmap_field_write(priv->rm_fields[F_OPMODE], 0);
+}
+
+static const struct of_device_id rtq6056_device_match[] = {
+	{ .compatible = "richtek,rtq6056", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtq6056_device_match);
+
+static struct i2c_driver rtq6056_driver = {
+	.driver = {
+		.name = "rtq6056",
+		.of_match_table = rtq6056_device_match,
+	},
+	.probe_new = rtq6056_probe,
+	.remove = rtq6056_remove,
+	.shutdown = rtq6056_shutdown,
+};
+module_i2c_driver(rtq6056_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTQ6056 ADC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

