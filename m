Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F6F46946C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhLFK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbhLFK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:57:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54669C061746;
        Mon,  6 Dec 2021 02:54:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so41035443edc.6;
        Mon, 06 Dec 2021 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCFUnwbpKe0EzTNHchbQG0kNPxSapmTZ0uN5eVUAvcE=;
        b=i6jO1+VAoWe+9Tg+PHVidnSsbL9xctgNO1aY8nWTFMDY6t1SKwdRUQSJTvmo03kQyl
         JcP4jc8ZDfdbgUqjE1mQjGVHRHWDJwaRFBtqP9rAjxzWU4dOvX62rBCssI/fxLWkrfEo
         9zLACnbKr5qrP2BKHYWnrcYQWSW45NqWaKX1C1QuBCgmmQ+oNWnoUCZuK5zWTxqBYgR/
         /sm4s5s8XjEjVyu2Hlls1xFoufmbNy2uy2McQTrRj1inb88lkKtYFRCmubNzdxx1xFvb
         ZqSLFzPg6yfjKbEAJPdnITNCmPmGW0wkOSMXi2TbFs+hkYYbxLKc8vcNCq13x9J+8Mbt
         7KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCFUnwbpKe0EzTNHchbQG0kNPxSapmTZ0uN5eVUAvcE=;
        b=R/B2QoTnDZBQougiYhaenfIXTM+fnDTMeZXng+g8xWIJNEHgEaV+A8Hyw9R0LvFnNc
         vC1CdiLNR+k7XIOHwDOnmBg1BhHrxfXwt/+XQAM6l7bzbFTHpUj6+vw3jIevz1frHTHS
         qLGGYmDit6d2xsBpEQiNPJq+UIeDd0VA496k/o1/ZnEL8n6RTms8UUmLKgi0k5grAo/Q
         rAuXHpx6PNNg3eFb7Kn9dvbJN2x96yt+iJ8HK3WyXS0H4ODEU4q96J8V0+cH0V9TSrjA
         8/iW87E7hkznyRmgaXp7bggj54AJ4ne/DsvqC51RTpmlI9iPf9I7/2s79pUlRahiI5va
         sFaw==
X-Gm-Message-State: AOAM533LN0723N56O4Xjg7xRTAIAyIIzWv5MZysBaiusLIomOQlPu21H
        1ltxXGVppzAEPFrirbnWUbc=
X-Google-Smtp-Source: ABdhPJxtvEZ20SZrwnMySLJTqjipVv9tmkBx0vZ/jWMInwUDtDw6dqWO1mWHigd9Bb74l1GzhMEZww==
X-Received: by 2002:a17:907:2cc4:: with SMTP id hg4mr44426611ejc.112.1638788055488;
        Mon, 06 Dec 2021 02:54:15 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id hd18sm6462605ejc.84.2021.12.06.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:54:15 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] iio: accel: add ADXL367 driver
Date:   Mon,  6 Dec 2021 12:54:03 +0200
Message-Id: <20211206105403.53049-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206105403.53049-1-cosmin.tanislav@analog.com>
References: <20211206105403.53049-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.

The ADXL367 does not alias input signals to achieve ultralow power
consumption, it samples the full bandwidth of the sensor at all
data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
with a resolution of 0.25mg/LSB on the +-2 g range.

In addition to its ultralow power consumption, the ADXL367
has many features to enable true system level power reduction.
It includes a deep multimode output FIFO, a built-in micropower
temperature sensor, and an internal ADC for synchronous conversion
of an additional analog input.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 MAINTAINERS                     |   11 +
 drivers/iio/accel/Kconfig       |   27 +
 drivers/iio/accel/Makefile      |    3 +
 drivers/iio/accel/adxl367.c     | 1657 +++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl367.h     |   24 +
 drivers/iio/accel/adxl367_i2c.c |   89 ++
 drivers/iio/accel/adxl367_spi.c |  151 +++
 7 files changed, 1962 insertions(+)
 create mode 100644 drivers/iio/accel/adxl367.c
 create mode 100644 drivers/iio/accel/adxl367.h
 create mode 100644 drivers/iio/accel/adxl367_i2c.c
 create mode 100644 drivers/iio/accel/adxl367_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 57fb0f19ee08..72b06fb62a87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -605,6 +605,17 @@ F:	drivers/iio/accel/adxl355_core.c
 F:	drivers/iio/accel/adxl355_i2c.c
 F:	drivers/iio/accel/adxl355_spi.c
 
+ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
+F:	drivers/iio/accel/adxl367.c
+F:	drivers/iio/accel/adxl367.h
+F:	drivers/iio/accel/adxl367_i2c.c
+F:	drivers/iio/accel/adxl367_spi.c
+
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 49587c992a6d..18dd21692739 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -123,6 +123,33 @@ config ADXL355_SPI
 	  will be called adxl355_spi and you will also get adxl355_core
 	  for the core module.
 
+config ADXL367
+	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+
+config ADXL367_SPI
+	tristate "Analog Devices ADXL367 3-Axis Accelerometer SPI Driver"
+	depends on SPI
+	select ADXL367
+	select REGMAP_SPI
+	help
+	  Say yes here to add support for the Analog Devices ADXL367 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl367_spi.
+
+config ADXL367_I2C
+	tristate "Analog Devices ADXL367 3-Axis Accelerometer I2C Driver"
+	depends on I2C
+	select ADXL367
+	select REGMAP_I2C
+	help
+	  Say yes here to add support for the Analog Devices ADXL367 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl367_i2c.
+
 config ADXL372
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index d03e2f6bba08..4d8792668838 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
 obj-$(CONFIG_ADXL355) += adxl355_core.o
 obj-$(CONFIG_ADXL355_I2C) += adxl355_i2c.o
 obj-$(CONFIG_ADXL355_SPI) += adxl355_spi.o
+obj-$(CONFIG_ADXL367) += adxl367.o
+obj-$(CONFIG_ADXL367_I2C) += adxl367_i2c.o
+obj-$(CONFIG_ADXL367_SPI) += adxl367_spi.o
 obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
 obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
new file mode 100644
index 000000000000..20193d626d4d
--- /dev/null
+++ b/drivers/iio/accel/adxl367.c
@@ -0,0 +1,1657 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Analog Devices, Inc.
+ * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "adxl367.h"
+
+#define ADXL367_REG_DEVID		0x00
+#define ADXL367_DEVID_AD		0xAD
+
+#define ADXL367_REG_STATUS		0x0B
+#define ADXL367_STATUS_FIFO_FULL_MASK	BIT(2)
+#define ADXL367_STATUS_ACT_MASK		BIT(4)
+#define ADXL367_STATUS_INACT_MASK	BIT(5)
+
+#define ADXL367_REG_FIFO_ENT_L		0x0C
+#define ADXL367_REG_FIFO_ENT_H		0x0D
+#define ADXL367_FIFO_ENT_H_MASK		GENMASK(1, 0)
+
+#define ADXL367_REG_X_DATA_H		0x0E
+#define ADXL367_REG_X_DATA_L		0x0F
+#define ADXL367_REG_Y_DATA_H		0x10
+#define ADXL367_REG_Y_DATA_L		0x11
+#define ADXL367_REG_Z_DATA_H		0x12
+#define ADXL367_REG_Z_DATA_L		0x13
+#define ADXL367_REG_TEMP_DATA_H		0x14
+#define ADXL367_REG_TEMP_DATA_L		0x15
+#define ADXL367_REG_EX_ADC_DATA_H	0x16
+#define ADXL367_REG_EX_ADC_DATA_L	0x17
+
+#define ADXL367_TEMP_25C		165
+#define ADXL367_TEMP_PER_C		54
+
+#define ADXL367_VOLTAGE_OFFSET		8192
+#define ADXL367_VOLTAGE_MAX_MV		1000
+#define ADXL367_VOLTAGE_MAX_RAW		GENMASK(13, 0)
+
+#define ADXL367_REG_RESET		0x1F
+#define ADXL367_RESET_CODE		0x52
+
+#define ADXL367_REG_THRESH_ACT_H	0x20
+#define ADXL367_REG_THRESH_ACT_L	0x21
+#define ADXL367_REG_THRESH_INACT_H	0x23
+#define ADXL367_REG_THRESH_INACT_L	0x24
+#define ADXL367_THRESH_MAX		GENMASK(12, 0)
+#define ADXL367_THRESH_VAL_H_MASK	GENMASK(12, 6)
+#define ADXL367_THRESH_H_MASK		GENMASK(6, 0)
+#define ADXL367_THRESH_VAL_L_MASK	GENMASK(5, 0)
+#define ADXL367_THRESH_L_MASK		GENMASK(7, 2)
+
+#define ADXL367_REG_TIME_ACT		0x22
+#define ADXL367_REG_TIME_INACT_H	0x25
+#define ADXL367_REG_TIME_INACT_L	0x26
+#define ADXL367_TIME_ACT_MAX		GENMASK(7, 0)
+#define ADXL367_TIME_INACT_MAX		GENMASK(15, 0)
+#define ADXL367_TIME_INACT_VAL_H_MASK	GENMASK(15, 8)
+#define ADXL367_TIME_INACT_H_MASK	GENMASK(7, 0)
+#define ADXL367_TIME_INACT_VAL_L_MASK	GENMASK(7, 0)
+#define ADXL367_TIME_INACT_L_MASK	GENMASK(7, 0)
+
+#define ADXL367_REG_ACT_INACT_CTL	0x27
+#define ADXL367_ACT_EN_MASK		GENMASK(1, 0)
+#define ADXL367_ACT_LINKLOOP_MASK	GENMASK(5, 4)
+
+#define ADXL367_REG_FIFO_CTL		0x28
+#define ADXL367_FIFO_CTL_FORMAT_MASK	GENMASK(6, 3)
+#define ADXL367_FIFO_CTL_MODE_MASK	GENMASK(1, 0)
+
+#define ADXL367_REG_FIFO_SAMPLES	0x29
+#define ADXL367_FIFO_SIZE		512
+#define ADXL367_FIFO_MAX_WATERMARK	511
+
+#define ADXL367_SAMPLES_VAL_H_MASK	BIT(8)
+#define ADXL367_SAMPLES_H_MASK		BIT(2)
+#define ADXL367_SAMPLES_VAL_L_MASK	GENMASK(7, 0)
+#define ADXL367_SAMPLES_L_MASK		GENMASK(7, 0)
+
+#define ADXL367_REG_INT1_MAP		0x2A
+#define ADXL367_INT_INACT_MASK		BIT(5)
+#define ADXL367_INT_ACT_MASK		BIT(4)
+#define ADXL367_INT_FIFO_FULL_MASK	BIT(2)
+
+#define ADXL367_REG_FILTER_CTL		0x2C
+#define ADXL367_FILTER_CTL_RANGE_MASK	GENMASK(7, 6)
+#define ADXL367_2G_RANGE_1G		4095
+#define ADXL367_2G_RANGE_100MG		409
+#define ADXL367_FILTER_CTL_ODR_MASK	GENMASK(2, 0)
+
+#define ADXL367_REG_POWER_CTL		0x2D
+#define ADXL367_POWER_CTL_MODE_MASK	GENMASK(1, 0)
+
+#define ADXL367_REG_ADC_CTL		0x3C
+#define ADXL367_REG_TEMP_CTL		0x3D
+#define ADXL367_ADC_EN_MASK		BIT(0)
+
+enum adxl367_adc_mode {
+	ADXL367_ADC_MODE_NONE,
+	ADXL367_ADC_MODE_TEMP,
+	ADXL367_ADC_MODE_EX,
+};
+
+enum adxl367_range {
+	ADXL367_2G_RANGE,
+	ADXL367_4G_RANGE,
+	ADXL367_8G_RANGE,
+};
+
+enum adxl367_fifo_mode {
+	ADXL367_FIFO_MODE_DISABLED = 0b00,
+	ADXL367_FIFO_MODE_STREAM = 0b10,
+};
+
+enum adxl367_fifo_format {
+	ADXL367_FIFO_FORMAT_XYZ,
+	ADXL367_FIFO_FORMAT_X,
+	ADXL367_FIFO_FORMAT_Y,
+	ADXL367_FIFO_FORMAT_Z,
+	ADXL367_FIFO_FORMAT_XYZT,
+	ADXL367_FIFO_FORMAT_XT,
+	ADXL367_FIFO_FORMAT_YT,
+	ADXL367_FIFO_FORMAT_ZT,
+	ADXL367_FIFO_FORMAT_XYZA,
+	ADXL367_FIFO_FORMAT_XA,
+	ADXL367_FIFO_FORMAT_YA,
+	ADXL367_FIFO_FORMAT_ZA,
+};
+
+enum adxl367_op_mode {
+	ADXL367_OP_STANDBY = 0b00,
+	ADXL367_OP_MEASURE = 0b10,
+};
+
+enum adxl367_act_proc_mode {
+	ADXL367_LOOPED = 0b11,
+};
+
+enum adxl367_act_en_mode {
+	ADXL367_ACT_DISABLED = 0b00,
+	ADCL367_ACT_REF_ENABLED = 0b11,
+};
+
+enum adxl367_activity_type {
+	ADXL367_ACTIVITY,
+	ADXL367_INACTIVITY,
+};
+
+enum adxl367_odr {
+	ADXL367_ODR_12P5HZ,
+	ADXL367_ODR_25HZ,
+	ADXL367_ODR_50HZ,
+	ADXL367_ODR_100HZ,
+	ADXL367_ODR_200HZ,
+	ADXL367_ODR_400HZ,
+};
+
+struct adxl367_state {
+	const struct adxl367_ops	*ops;
+	void				*context;
+
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct iio_trigger	*dready_trig;
+
+	/*
+	 * Synchronize access to members of driver state, and ensure atomicity
+	 * of consecutive regmap operations.
+	 */
+	struct mutex		lock;
+
+	enum adxl367_odr	odr;
+	enum adxl367_range	range;
+	enum adxl367_adc_mode	adc_mode;
+
+	unsigned int	act_threshold;
+	unsigned int	act_time_ms;
+	unsigned int	inact_threshold;
+	unsigned int	inact_time_ms;
+
+	unsigned int	fifo_set_size;
+	unsigned int	fifo_watermark;
+
+	__be16		fifo_buf[ADXL367_FIFO_SIZE] ____cacheline_aligned;
+	__be16		sample_buf;
+	u8		status_buf[3];
+};
+
+static const unsigned int adxl367_threshold_h_reg_tbl[] = {
+	[ADXL367_ACTIVITY]   = ADXL367_REG_THRESH_ACT_H,
+	[ADXL367_INACTIVITY] = ADXL367_REG_THRESH_INACT_H,
+};
+
+static const unsigned int adxl367_act_en_shift_tbl[] = {
+	[ADXL367_ACTIVITY]   = 0,
+	[ADXL367_INACTIVITY] = 2,
+};
+
+static const unsigned int adxl367_act_int_mask_tbl[] = {
+	[ADXL367_ACTIVITY]   = ADXL367_INT_ACT_MASK,
+	[ADXL367_INACTIVITY] = ADXL367_INT_INACT_MASK,
+};
+
+static const int adxl367_samp_freq_tbl[][2] = {
+	[ADXL367_ODR_12P5HZ] = {12, 500000},
+	[ADXL367_ODR_25HZ]   = {25, 0},
+	[ADXL367_ODR_50HZ]   = {50, 0},
+	[ADXL367_ODR_100HZ]  = {100, 0},
+	[ADXL367_ODR_200HZ]  = {200, 0},
+	[ADXL367_ODR_400HZ]  = {400, 0},
+};
+
+static const int adxl367_time_scale_tbl[] = {
+	[ADXL367_ODR_12P5HZ] = 1,
+	[ADXL367_ODR_25HZ]   = 2,
+	[ADXL367_ODR_50HZ]   = 4,
+	[ADXL367_ODR_100HZ]  = 8,
+	[ADXL367_ODR_200HZ]  = 16,
+	[ADXL367_ODR_400HZ]  = 32,
+};
+
+/* (g * 2) * 9.80665 * 1000000 / (2^14 - 1) */
+static const int adxl367_range_scale_tbl[][2] = {
+	[ADXL367_2G_RANGE] = {0, 2394347},
+	[ADXL367_4G_RANGE] = {0, 4788695},
+	[ADXL367_8G_RANGE] = {0, 9577391},
+};
+
+static const int adxl367_range_scale_factor_tbl[] = {
+	[ADXL367_2G_RANGE] = 1,
+	[ADXL367_4G_RANGE] = 2,
+	[ADXL367_8G_RANGE] = 4,
+};
+
+enum {
+	ADXL367_X_CHANNEL_INDEX,
+	ADXL367_Y_CHANNEL_INDEX,
+	ADXL367_Z_CHANNEL_INDEX,
+	ADXL367_TEMP_CHANNEL_INDEX,
+	ADXL367_EX_ADC_CHANNEL_INDEX
+};
+
+#define ADXL367_X_CHANNEL_MASK		BIT(ADXL367_X_CHANNEL_INDEX)
+#define ADXL367_Y_CHANNEL_MASK		BIT(ADXL367_Y_CHANNEL_INDEX)
+#define ADXL367_Z_CHANNEL_MASK		BIT(ADXL367_Z_CHANNEL_INDEX)
+#define ADXL367_TEMP_CHANNEL_MASK	BIT(ADXL367_TEMP_CHANNEL_INDEX)
+#define ADXL367_EX_ADC_CHANNEL_MASK	BIT(ADXL367_EX_ADC_CHANNEL_INDEX)
+
+static const unsigned long adxl367_channel_masks[] = {
+	[ADXL367_FIFO_FORMAT_XYZ]  = ADXL367_X_CHANNEL_MASK
+				     | ADXL367_Y_CHANNEL_MASK
+				     | ADXL367_Z_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_X]    = ADXL367_X_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_Y]    = ADXL367_Y_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_Z]    = ADXL367_Z_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_XYZT] = ADXL367_X_CHANNEL_MASK
+				     | ADXL367_Y_CHANNEL_MASK
+				     | ADXL367_Z_CHANNEL_MASK
+				     | ADXL367_TEMP_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_XT]   = ADXL367_X_CHANNEL_MASK
+				     | ADXL367_TEMP_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_YT]   = ADXL367_Y_CHANNEL_MASK
+				     | ADXL367_TEMP_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_ZT]   = ADXL367_Z_CHANNEL_MASK
+				     | ADXL367_TEMP_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_XYZA] = ADXL367_X_CHANNEL_MASK
+				     | ADXL367_Y_CHANNEL_MASK
+				     | ADXL367_Z_CHANNEL_MASK
+				     | ADXL367_EX_ADC_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_XA]   = ADXL367_X_CHANNEL_MASK
+				     | ADXL367_EX_ADC_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_YA]   = ADXL367_Y_CHANNEL_MASK
+				     | ADXL367_EX_ADC_CHANNEL_MASK,
+	[ADXL367_FIFO_FORMAT_ZA]   = ADXL367_Z_CHANNEL_MASK
+				     | ADXL367_EX_ADC_CHANNEL_MASK,
+};
+
+static int adxl367_set_measure_en(struct adxl367_state *st, bool en)
+{
+	enum adxl367_op_mode op_mode = en ? ADXL367_OP_MEASURE
+					  : ADXL367_OP_STANDBY;
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL367_REG_POWER_CTL,
+				 ADXL367_POWER_CTL_MODE_MASK,
+				 FIELD_PREP(ADXL367_POWER_CTL_MODE_MASK,
+					    op_mode));
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for acceleration output to settle after entering
+	 * measure mode.
+	 */
+	if (en)
+		msleep(100);
+
+	return 0;
+}
+
+static void adxl367_scale_act_thresholds(struct adxl367_state *st,
+					 enum adxl367_range old_range,
+					 enum adxl367_range new_range)
+{
+	st->act_threshold = st->act_threshold
+			    * adxl367_range_scale_factor_tbl[old_range]
+			    / adxl367_range_scale_factor_tbl[new_range];
+	st->inact_threshold = st->inact_threshold
+			      * adxl367_range_scale_factor_tbl[old_range]
+			      / adxl367_range_scale_factor_tbl[new_range];
+}
+
+static int _adxl367_set_act_threshold(struct adxl367_state *st,
+				      enum adxl367_activity_type act,
+				      unsigned int threshold)
+{
+	u8 reg = adxl367_threshold_h_reg_tbl[act];
+	struct reg_sequence reg_seq[] = {
+		{ reg },
+		{ reg + 1 },
+	};
+	int ret;
+
+	if (threshold > ADXL367_THRESH_MAX)
+		return -EINVAL;
+
+	reg_seq[0].def = FIELD_PREP(ADXL367_THRESH_H_MASK,
+				    FIELD_GET(ADXL367_THRESH_VAL_H_MASK,
+					      threshold));
+	reg_seq[1].def = FIELD_PREP(ADXL367_THRESH_L_MASK,
+				    FIELD_GET(ADXL367_THRESH_VAL_L_MASK,
+					      threshold));
+
+	ret = regmap_multi_reg_write(st->regmap, reg_seq, ARRAY_SIZE(reg_seq));
+	if (ret)
+		return ret;
+
+	if (act == ADXL367_ACTIVITY)
+		st->act_threshold = threshold;
+	else
+		st->inact_threshold = threshold;
+
+	return 0;
+}
+
+static int adxl367_set_act_threshold(struct adxl367_state *st,
+				     enum adxl367_activity_type act,
+				     unsigned int threshold)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = _adxl367_set_act_threshold(st, act, threshold);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_set_act_proc_mode(struct adxl367_state *st,
+				     enum adxl367_act_proc_mode mode)
+{
+	return regmap_update_bits(st->regmap, ADXL367_REG_ACT_INACT_CTL,
+				  ADXL367_ACT_LINKLOOP_MASK,
+				  FIELD_PREP(ADXL367_ACT_LINKLOOP_MASK,
+					     mode));
+}
+
+static int adxl367_set_act_interrupt_en(struct adxl367_state *st,
+					enum adxl367_activity_type act,
+					bool en)
+{
+	unsigned int mask = adxl367_act_int_mask_tbl[act];
+
+	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
+				  mask, en ? mask : 0);
+}
+
+static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
+					enum adxl367_activity_type act,
+					bool *en)
+{
+	unsigned int mask = adxl367_act_int_mask_tbl[act];
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL367_REG_INT1_MAP, &val);
+	if (ret)
+		return ret;
+
+	*en = !!(val & mask);
+
+	return 0;
+}
+
+static int adxl367_set_act_en(struct adxl367_state *st,
+			      enum adxl367_activity_type act,
+			      enum adxl367_act_en_mode en)
+{
+	unsigned int ctl_shift = adxl367_act_en_shift_tbl[act];
+
+	return regmap_update_bits(st->regmap, ADXL367_REG_ACT_INACT_CTL,
+				  ADXL367_ACT_EN_MASK << ctl_shift,
+				  en << ctl_shift);
+}
+
+static int adxl367_set_fifo_full_interrupt_en(struct adxl367_state *st, bool en)
+{
+	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
+				  ADXL367_INT_FIFO_FULL_MASK,
+				  en ? ADXL367_INT_FIFO_FULL_MASK : 0);
+}
+
+static int adxl367_get_fifo_mode(struct adxl367_state *st,
+				 enum adxl367_fifo_mode *fifo_mode)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL367_REG_FIFO_CTL, &val);
+	if (ret)
+		return ret;
+
+	*fifo_mode = FIELD_GET(ADXL367_FIFO_CTL_MODE_MASK, val);
+
+	return 0;
+}
+
+static int adxl367_set_fifo_mode(struct adxl367_state *st,
+				 enum adxl367_fifo_mode fifo_mode)
+{
+	return regmap_update_bits(st->regmap, ADXL367_REG_FIFO_CTL,
+				  ADXL367_FIFO_CTL_MODE_MASK,
+				  FIELD_PREP(ADXL367_FIFO_CTL_MODE_MASK,
+					     fifo_mode));
+}
+
+static int adxl367_set_fifo_format(struct adxl367_state *st,
+				   enum adxl367_fifo_format fifo_format)
+{
+	return regmap_update_bits(st->regmap, ADXL367_REG_FIFO_CTL,
+				  ADXL367_FIFO_CTL_FORMAT_MASK,
+				  FIELD_PREP(ADXL367_FIFO_CTL_FORMAT_MASK,
+					     fifo_format));
+}
+
+static int adxl367_set_fifo_samples(struct adxl367_state *st,
+				    unsigned int fifo_watermark,
+				    unsigned int fifo_set_size)
+{
+	unsigned int fifo_samples = fifo_watermark * fifo_set_size;
+	unsigned int fifo_samples_h, fifo_samples_l;
+	int ret;
+
+	if (fifo_samples > ADXL367_FIFO_MAX_WATERMARK)
+		fifo_samples = ADXL367_FIFO_MAX_WATERMARK;
+
+	if (fifo_set_size == 0)
+		return 0;
+
+	fifo_samples /= fifo_set_size;
+
+	fifo_samples_h = FIELD_PREP(ADXL367_SAMPLES_H_MASK,
+				    FIELD_GET(ADXL367_SAMPLES_VAL_H_MASK,
+					      fifo_samples));
+	fifo_samples_l = FIELD_PREP(ADXL367_SAMPLES_L_MASK,
+				    FIELD_GET(ADXL367_SAMPLES_VAL_L_MASK,
+					      fifo_samples));
+
+	ret = regmap_update_bits(st->regmap, ADXL367_REG_FIFO_CTL,
+				 ADXL367_SAMPLES_H_MASK, fifo_samples_h);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADXL367_REG_FIFO_SAMPLES,
+				  ADXL367_SAMPLES_L_MASK, fifo_samples_l);
+}
+
+static int adxl367_set_fifo_set_size(struct adxl367_state *st,
+				     unsigned int fifo_set_size)
+{
+	int ret;
+
+	ret = adxl367_set_fifo_samples(st, st->fifo_watermark, fifo_set_size);
+	if (ret)
+		return ret;
+
+	st->fifo_set_size = fifo_set_size;
+
+	return 0;
+}
+
+static int adxl367_set_fifo_watermark(struct adxl367_state *st,
+				      unsigned int fifo_watermark)
+{
+	int ret;
+
+	ret = adxl367_set_fifo_samples(st, fifo_watermark, st->fifo_set_size);
+	if (ret)
+		return ret;
+
+	st->fifo_watermark = fifo_watermark;
+
+	return 0;
+}
+
+static int adxl367_set_range(struct adxl367_state *st,
+			     enum adxl367_range range)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
+				 ADXL367_FILTER_CTL_RANGE_MASK,
+				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
+					    range));
+	if (ret)
+		goto out;
+
+	adxl367_scale_act_thresholds(st, st->range, range);
+
+	/* Activity thresholds depend on range */
+	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
+					 st->act_threshold);
+	if (ret)
+		goto out;
+
+	ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
+					 st->inact_threshold);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+	if (ret)
+		goto out;
+
+	st->range = range;
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_time_ms_to_samples(struct adxl367_state *st, unsigned int ms)
+{
+	int freq_hz = adxl367_samp_freq_tbl[st->odr][0];
+	int freq_microhz = adxl367_samp_freq_tbl[st->odr][1];
+	/* Scale to decihertz to prevent precision loss in 12.5Hz case. */
+	int freq_dhz = freq_hz * 10 + freq_microhz / 100000;
+
+	return DIV_ROUND_CLOSEST(ms * freq_dhz, 10000);
+}
+
+static int _adxl367_set_act_time_ms(struct adxl367_state *st, unsigned int ms)
+{
+	unsigned int val = adxl367_time_ms_to_samples(st, ms);
+	int ret;
+
+	if (val > ADXL367_TIME_ACT_MAX)
+		val = ADXL367_TIME_ACT_MAX;
+
+	ret = regmap_write(st->regmap, ADXL367_REG_TIME_ACT, val);
+	if (ret)
+		return ret;
+
+	st->act_time_ms = ms;
+
+	return 0;
+}
+
+static int _adxl367_set_inact_time_ms(struct adxl367_state *st, unsigned int ms)
+{
+	struct reg_sequence reg_seq[] = {
+		{ ADXL367_REG_TIME_INACT_H },
+		{ ADXL367_REG_TIME_INACT_L },
+	};
+	unsigned int val = adxl367_time_ms_to_samples(st, ms);
+	int ret;
+
+	if (val > ADXL367_TIME_INACT_MAX)
+		val = ADXL367_TIME_INACT_MAX;
+
+	reg_seq[0].def = FIELD_PREP(ADXL367_TIME_INACT_H_MASK,
+				    FIELD_GET(ADXL367_TIME_INACT_VAL_H_MASK,
+					      val));
+	reg_seq[1].def = FIELD_PREP(ADXL367_TIME_INACT_L_MASK,
+				    FIELD_GET(ADXL367_TIME_INACT_VAL_L_MASK,
+					      val));
+
+	ret = regmap_multi_reg_write(st->regmap, reg_seq, ARRAY_SIZE(reg_seq));
+	if (ret)
+		return ret;
+
+	st->inact_time_ms = ms;
+
+	return 0;
+}
+
+static int adxl367_set_act_time_ms(struct adxl367_state *st,
+				   enum adxl367_activity_type act,
+				   unsigned int ms)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	if (act == ADXL367_ACTIVITY)
+		ret = _adxl367_set_act_time_ms(st, ms);
+	else
+		ret = _adxl367_set_inact_time_ms(st, ms);
+
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
+				 ADXL367_FILTER_CTL_ODR_MASK,
+				 FIELD_PREP(ADXL367_FILTER_CTL_ODR_MASK,
+					    odr));
+	if (ret)
+		return ret;
+
+	/* Activity timers depend on ODR */
+	ret = _adxl367_set_act_time_ms(st, st->act_time_ms);
+	if (ret)
+		return ret;
+
+	ret = _adxl367_set_inact_time_ms(st, st->inact_time_ms);
+	if (ret)
+		return ret;
+
+	st->odr = odr;
+
+	return 0;
+}
+
+static int adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = _adxl367_set_odr(st, odr);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_set_adc_en(struct adxl367_state *st,
+			      enum adxl367_adc_mode adc_mode, bool en)
+{
+	unsigned int reg;
+
+	switch (adc_mode) {
+	case ADXL367_ADC_MODE_TEMP:
+		reg = ADXL367_REG_TEMP_CTL;
+		break;
+	case ADXL367_ADC_MODE_EX:
+		reg = ADXL367_REG_ADC_CTL;
+		break;
+	default:
+		return 0;
+	}
+
+	return regmap_update_bits(st->regmap, reg, ADXL367_ADC_EN_MASK,
+				  en ? ADXL367_ADC_EN_MASK : 0);
+}
+
+static int adxl367_set_adc_mode(struct adxl367_state *st,
+				enum adxl367_adc_mode adc_mode)
+{
+	int ret;
+
+	if (st->adc_mode == adc_mode)
+		return 0;
+
+	ret = adxl367_set_adc_en(st, st->adc_mode, false);
+	if (ret)
+		return ret;
+
+	ret = adxl367_set_adc_en(st, adc_mode, true);
+	if (ret)
+		return ret;
+
+	st->adc_mode = adc_mode;
+
+	return 0;
+}
+
+static int adxl367_set_chan_en(struct adxl367_state *st,
+			       enum iio_chan_type type, bool en)
+{
+	enum adxl367_adc_mode adc_mode;
+	int ret;
+
+	switch (type) {
+	case IIO_TEMP:
+		adc_mode = ADXL367_ADC_MODE_TEMP;
+		break;
+	case IIO_VOLTAGE:
+		adc_mode = ADXL367_ADC_MODE_EX;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&st->lock);
+
+	if (!en && st->adc_mode != adc_mode) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!en)
+		adc_mode = ADXL367_ADC_MODE_NONE;
+
+	ret = adxl367_set_adc_mode(st, adc_mode);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_find_odr(struct adxl367_state *st, int val, int val2,
+			    enum adxl367_odr *odr)
+{
+	size_t size = ARRAY_SIZE(adxl367_samp_freq_tbl);
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (val == adxl367_samp_freq_tbl[i][0] &&
+		    val2 == adxl367_samp_freq_tbl[i][1])
+			break;
+
+	if (i == size)
+		return -EINVAL;
+
+	*odr = i;
+
+	return 0;
+}
+
+static int adxl367_find_range(struct adxl367_state *st, int val, int val2,
+			      enum adxl367_range *range)
+{
+	size_t size = ARRAY_SIZE(adxl367_range_scale_tbl);
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (val == adxl367_range_scale_tbl[i][0] &&
+		    val2 == adxl367_range_scale_tbl[i][1])
+			break;
+
+	if (i == size)
+		return -EINVAL;
+
+	*range = i;
+
+	return 0;
+}
+
+static int adxl367_read_sample(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	u16 sample;
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
+			       sizeof(st->sample_buf));
+	sample = be16_to_cpu(st->sample_buf) >> chan->scan_type.shift;
+	*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+
+	mutex_unlock(&st->lock);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret ?: IIO_VAL_INT;
+}
+
+static int adxl367_get_status(struct adxl367_state *st, u8 *status,
+			      u16 *fifo_entries)
+{
+	int ret;
+
+	/* Read STATUS, FIFO_ENT_L and FIFO_ENT_H */
+	ret = regmap_bulk_read(st->regmap, ADXL367_REG_STATUS,
+			       st->status_buf, sizeof(st->status_buf));
+	if (ret)
+		return ret;
+
+	st->status_buf[2] &= ADXL367_FIFO_ENT_H_MASK;
+
+	*status = st->status_buf[0];
+	*fifo_entries = get_unaligned_le16(&st->status_buf[1]);
+
+	return 0;
+}
+
+static void adxl367_push_event(struct iio_dev *indio_dev, s64 timestamp,
+			       u8 status)
+{
+	unsigned int ev_dir;
+
+	if (FIELD_GET(ADXL367_STATUS_ACT_MASK, status))
+		ev_dir = IIO_EV_DIR_RISING;
+	else if (FIELD_GET(ADXL367_STATUS_INACT_MASK, status))
+		ev_dir = IIO_EV_DIR_FALLING;
+	else
+		return;
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+					  IIO_EV_TYPE_THRESH, ev_dir),
+		       timestamp);
+}
+
+static void adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
+				   u16 fifo_entries)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
+	int i;
+
+	if (!FIELD_GET(ADXL367_STATUS_FIFO_FULL_MASK, status))
+		return;
+
+	ret = st->ops->read_fifo(st->context, st->fifo_buf, fifo_entries);
+	if (ret)
+		return;
+
+	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
+		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+}
+
+static irqreturn_t adxl367_trigger_handler(int irq, void  *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl367_state *st = iio_priv(indio_dev);
+	u16 fifo_entries;
+	u8 status;
+	int ret;
+
+	ret = adxl367_get_status(st, &status, &fifo_entries);
+	if (ret)
+		goto out;
+
+	adxl367_push_event(indio_dev, iio_get_time_ns(indio_dev), status);
+	adxl367_push_fifo_data(indio_dev, status, fifo_entries);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int adxl367_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static int adxl367_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return adxl367_read_sample(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			mutex_lock(&st->lock);
+			*val = adxl367_range_scale_tbl[st->range][0];
+			*val2 = adxl367_range_scale_tbl[st->range][1];
+			mutex_unlock(&st->lock);
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			*val = 1;
+			*val2 = ADXL367_TEMP_PER_C;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_VOLTAGE:
+			*val = ADXL367_VOLTAGE_MAX_MV;
+			*val2 = ADXL367_VOLTAGE_MAX_RAW;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = 25 * ADXL367_TEMP_PER_C - ADXL367_TEMP_25C;
+			return IIO_VAL_INT;
+		case IIO_VOLTAGE:
+			*val = ADXL367_VOLTAGE_OFFSET;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&st->lock);
+		*val = adxl367_samp_freq_tbl[st->odr][0];
+		*val2 = adxl367_samp_freq_tbl[st->odr][1];
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			mutex_lock(&st->lock);
+			*val = st->adc_mode == ADXL367_ADC_MODE_TEMP;
+			mutex_unlock(&st->lock);
+			return IIO_VAL_INT;
+		case IIO_VOLTAGE:
+			mutex_lock(&st->lock);
+			*val = st->adc_mode == ADXL367_ADC_MODE_EX;
+			mutex_unlock(&st->lock);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl367_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		enum adxl367_odr odr;
+
+		ret = adxl367_find_odr(st, val, val2, &odr);
+		if (ret)
+			return ret;
+
+		return adxl367_set_odr(st, odr);
+	}
+	case IIO_CHAN_INFO_SCALE: {
+		enum adxl367_range range;
+
+		ret = adxl367_find_range(st, val, val2, &range);
+		if (ret)
+			return ret;
+
+		return adxl367_set_range(st, range);
+	}
+	case IIO_CHAN_INFO_ENABLE:
+		return adxl367_set_chan_en(st, chan->type, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+int adxl367_write_raw_get_fmt(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int adxl367_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+
+		*vals = (int *)adxl367_range_scale_tbl;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(adxl367_range_scale_tbl) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)adxl367_samp_freq_tbl;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(adxl367_samp_freq_tbl) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl367_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE: {
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			mutex_lock(&st->lock);
+			*val = st->act_threshold;
+			mutex_unlock(&st->lock);
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			mutex_lock(&st->lock);
+			*val = st->inact_threshold;
+			mutex_unlock(&st->lock);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	}
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			mutex_lock(&st->lock);
+			*val = st->act_time_ms;
+			mutex_unlock(&st->lock);
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			mutex_lock(&st->lock);
+			*val = st->inact_time_ms;
+			mutex_unlock(&st->lock);
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl367_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val < 0)
+			return -EINVAL;
+
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl367_set_act_threshold(st, ADXL367_ACTIVITY, val);
+		case IIO_EV_DIR_FALLING:
+			return adxl367_set_act_threshold(st, ADXL367_INACTIVITY, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		if (val < 0)
+			return -EINVAL;
+
+		val = val * 1000 + DIV_ROUND_UP(val2, 1000);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl367_set_act_time_ms(st, ADXL367_ACTIVITY, val);
+		case IIO_EV_DIR_FALLING:
+			return adxl367_set_act_time_ms(st, ADXL367_INACTIVITY, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl367_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	bool en;
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = adxl367_get_act_interrupt_en(st, ADXL367_ACTIVITY, &en);
+		return ret ?: en;
+	case IIO_EV_DIR_FALLING:
+		ret = adxl367_get_act_interrupt_en(st, ADXL367_INACTIVITY, &en);
+		return ret ?: en;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl367_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	enum adxl367_activity_type act;
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		act = ADXL367_ACTIVITY;
+		break;
+	case IIO_EV_DIR_FALLING:
+		act = ADXL367_INACTIVITY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_act_interrupt_en(st, act, state);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
+						: ADXL367_ACT_DISABLED);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static ssize_t adxl367_get_fifo_enabled(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl367_state *st = iio_priv(indio_dev);
+	enum adxl367_fifo_mode fifo_mode;
+	int ret;
+
+	ret = adxl367_get_fifo_mode(st, &fifo_mode);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n",
+		       fifo_mode != ADXL367_FIFO_MODE_DISABLED);
+}
+
+static ssize_t adxl367_get_fifo_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", st->fifo_watermark);
+}
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_CONST_ATTR(hwfifo_watermark_max,
+		      __stringify(ADXL367_FIFO_MAX_WATERMARK));
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adxl367_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adxl367_get_fifo_enabled, NULL, 0);
+
+static const struct attribute *adxl367_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int adxl367_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adxl367_state *st  = iio_priv(indio_dev);
+	int ret;
+
+	if (val > ADXL367_FIFO_MAX_WATERMARK)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_watermark(st, val);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_find_mask_fifo_format(const unsigned long *scan_mask,
+					 enum adxl367_fifo_format *fifo_format)
+{
+	size_t size = ARRAY_SIZE(adxl367_channel_masks);
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (*scan_mask == adxl367_channel_masks[i])
+			break;
+
+	if (i == size)
+		return false;
+
+	*fifo_format = i;
+
+	return true;
+}
+
+static bool adxl367_validate_scan_mask(struct iio_dev *indio_dev,
+				       const unsigned long *scan_mask)
+{
+	struct adxl367_state *st  = iio_priv(indio_dev);
+	enum adxl367_adc_mode mode;
+
+	mutex_lock(&st->lock);
+	mode = st->adc_mode;
+	mutex_unlock(&st->lock);
+
+	if ((*scan_mask & ADXL367_TEMP_CHANNEL_MASK) &&
+	    mode != ADXL367_ADC_MODE_TEMP)
+		return false;
+
+	if ((*scan_mask & ADXL367_EX_ADC_CHANNEL_MASK) &&
+	    mode != ADXL367_ADC_MODE_EX)
+		return false;
+
+	return true;
+}
+
+static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
+				    const unsigned long *active_scan_mask)
+{
+	struct adxl367_state *st  = iio_priv(indio_dev);
+	enum adxl367_fifo_format fifo_format;
+	unsigned int fifo_set_size;
+	int ret;
+
+	if (!adxl367_find_mask_fifo_format(active_scan_mask, &fifo_format))
+		return -EINVAL;
+
+	fifo_set_size = bitmap_weight(active_scan_mask, indio_dev->masklength);
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_format(st, fifo_format);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_set_size(st, fifo_set_size);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_full_interrupt_en(st, true);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_STREAM);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_DISABLED);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_fifo_full_interrupt_en(st, false);
+	if (ret)
+		goto out;
+
+	ret = adxl367_set_measure_en(st, true);
+
+out:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adxl367_validate_trigger(struct iio_dev *indio_dev,
+				    struct iio_trigger *trig)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	if (st->dready_trig != trig)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops adxl367_buffer_ops = {
+	.postenable = adxl367_buffer_postenable,
+	.predisable = adxl367_buffer_predisable,
+	.validate_scan_mask = adxl367_validate_scan_mask,
+};
+
+static const struct iio_trigger_ops adxl367_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static const struct iio_info adxl367_info = {
+	.validate_trigger = adxl367_validate_trigger,
+	.read_raw = adxl367_read_raw,
+	.write_raw = adxl367_write_raw,
+	.write_raw_get_fmt = adxl367_write_raw_get_fmt,
+	.read_avail = adxl367_read_avail,
+	.read_event_config = adxl367_read_event_config,
+	.write_event_config = adxl367_write_event_config,
+	.read_event_value = adxl367_read_event_value,
+	.write_event_value = adxl367_write_event_value,
+	.debugfs_reg_access = adxl367_reg_access,
+	.hwfifo_set_watermark = adxl367_set_watermark,
+	.update_scan_mode = adxl367_update_scan_mode,
+};
+
+#define ADXL367_EVENT(_dir) {						\
+	.type = IIO_EV_TYPE_THRESH,					\
+	.dir = (_dir),							\
+	.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE) |			\
+			      BIT(IIO_EV_INFO_PERIOD) |			\
+			      BIT(IIO_EV_INFO_VALUE),			\
+}
+
+static const struct iio_event_spec adxl367_events[] = {
+	ADXL367_EVENT(IIO_EV_DIR_RISING),
+	ADXL367_EVENT(IIO_EV_DIR_FALLING),
+};
+
+#define ADXL367_14BIT_SCAN_INFO(index)					\
+	.scan_index = (index),						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 14,						\
+		.storagebits = 16,					\
+		.shift = 2,						\
+		.endianness = IIO_BE,					\
+	}
+
+#define ADXL367_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = (reg),						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_all_available =				\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.event_spec = adxl367_events,					\
+	.num_event_specs = ARRAY_SIZE(adxl367_events),			\
+	ADXL367_14BIT_SCAN_INFO(index),					\
+}
+
+#define ADXL367_CHANNEL(index, reg, _type) {				\
+	.type = (_type),						\
+	.address = (reg),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_ENABLE) |		\
+			      BIT(IIO_CHAN_INFO_OFFSET) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	ADXL367_14BIT_SCAN_INFO(index),					\
+}
+
+static const struct iio_chan_spec adxl367_channels[] = {
+	ADXL367_ACCEL_CHANNEL(ADXL367_X_CHANNEL_INDEX, ADXL367_REG_X_DATA_H, X),
+	ADXL367_ACCEL_CHANNEL(ADXL367_Y_CHANNEL_INDEX, ADXL367_REG_Y_DATA_H, Y),
+	ADXL367_ACCEL_CHANNEL(ADXL367_Z_CHANNEL_INDEX, ADXL367_REG_Z_DATA_H, Z),
+	ADXL367_CHANNEL(ADXL367_TEMP_CHANNEL_INDEX, ADXL367_REG_TEMP_DATA_H,
+			IIO_TEMP),
+	ADXL367_CHANNEL(ADXL367_EX_ADC_CHANNEL_INDEX, ADXL367_REG_EX_ADC_DATA_H,
+			IIO_VOLTAGE),
+};
+
+static int adxl367_reset(struct adxl367_state *st)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADXL367_REG_RESET, ADXL367_RESET_CODE);
+	if (ret)
+		return ret;
+
+	usleep_range(500, 600);
+
+	return 0;
+}
+
+static int adxl367_verify_devid(struct adxl367_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL367_REG_DEVID, &val);
+	if (ret)
+		return ret;
+
+	if (val != ADXL367_DEVID_AD) {
+		return dev_err_probe(st->dev, -ENODEV,
+				     "Invalid device id 0x%02X\n", val);
+	}
+
+	return 0;
+}
+
+static int adxl367_setup(struct adxl367_state *st)
+{
+	int ret;
+
+	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
+					 ADXL367_2G_RANGE_1G);
+	if (ret)
+		return ret;
+
+	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
+					 ADXL367_2G_RANGE_100MG);
+	if (ret)
+		return ret;
+
+	ret = adxl367_set_act_proc_mode(st, ADXL367_LOOPED);
+	if (ret)
+		return ret;
+
+	ret = _adxl367_set_odr(st, ADXL367_ODR_400HZ);
+	if (ret)
+		return ret;
+
+	ret = _adxl367_set_act_time_ms(st, 10);
+	if (ret)
+		return ret;
+
+	ret = _adxl367_set_inact_time_ms(st, 10000);
+	if (ret)
+		return ret;
+
+	return adxl367_set_measure_en(st, true);
+}
+
+int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
+		  void *context, struct regmap *regmap, int irq,
+		  const char *name)
+{
+	struct iio_dev *indio_dev;
+	struct adxl367_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->dev = dev;
+	st->regmap = regmap;
+	st->context = context;
+	st->ops = ops;
+
+	mutex_init(&st->lock);
+
+	indio_dev->channels = adxl367_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
+	indio_dev->name = name;
+	indio_dev->info = &adxl367_info;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;
+
+	ret = adxl367_verify_devid(st);
+	if (ret)
+		return ret;
+
+	ret = adxl367_reset(st);
+	if (ret)
+		return ret;
+
+	ret = adxl367_setup(st);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
+						  adxl367_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  &adxl367_buffer_ops,
+						  adxl367_fifo_attributes);
+	if (ret)
+		return ret;
+
+	st->dready_trig = devm_iio_trigger_alloc(st->dev, "%s-dev%d",
+						 indio_dev->name,
+						 iio_device_id(indio_dev));
+	if (!st->dready_trig)
+		return -ENOMEM;
+
+	st->dready_trig->ops = &adxl367_trigger_ops;
+	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+
+	ret = devm_iio_trigger_register(st->dev, st->dready_trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->dready_trig);
+
+	if (!irq)
+		return -EINVAL;
+
+	ret = devm_request_threaded_irq(st->dev, irq,
+					iio_trigger_generic_data_rdy_poll,
+					NULL, IRQF_ONESHOT, indio_dev->name,
+					st->dready_trig);
+	if (ret)
+		return dev_err_probe(st->dev, ret, "Failed to request irq\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(adxl367_probe);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL367 3-axis accelerometer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/adxl367.h b/drivers/iio/accel/adxl367.h
new file mode 100644
index 000000000000..0c4d7ec22d8d
--- /dev/null
+++ b/drivers/iio/accel/adxl367.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021 Analog Devices, Inc.
+ * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
+ */
+
+#ifndef _ADXL367_H_
+#define _ADXL367_H_
+
+#include <linux/types.h>
+
+struct device;
+struct regmap;
+
+struct adxl367_ops {
+	int (*read_fifo)(void *context, __be16 *fifo_buf,
+			 unsigned int fifo_entries);
+};
+
+int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
+		  void *context, struct regmap *regmap, int irq,
+		  const char *name);
+
+#endif /* _ADXL367_H_ */
diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
new file mode 100644
index 000000000000..709a43356a06
--- /dev/null
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Analog Devices, Inc.
+ * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "adxl367.h"
+
+#define ADXL367_I2C_FIFO_DATA	0x42
+
+struct adxl367_i2c_state {
+	struct regmap *regmap;
+};
+
+static bool adxl367_readable_noinc_reg(struct device *dev, unsigned int reg)
+{
+	return reg == ADXL367_I2C_FIFO_DATA;
+}
+
+static int adxl367_i2c_read_fifo(void *context, __be16 *fifo_buf,
+				 unsigned int fifo_entries)
+{
+	struct adxl367_i2c_state *st = context;
+
+	return regmap_noinc_read(st->regmap, ADXL367_I2C_FIFO_DATA, fifo_buf,
+				 fifo_entries * sizeof(*fifo_buf));
+}
+
+static const struct regmap_config adxl367_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.readable_noinc_reg = adxl367_readable_noinc_reg,
+};
+
+static const struct adxl367_ops adxl367_i2c_ops = {
+	.read_fifo = adxl367_i2c_read_fifo,
+};
+
+static int adxl367_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct adxl367_i2c_state *st;
+	struct regmap *regmap;
+
+	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &adxl367_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st->regmap = regmap;
+
+	return adxl367_probe(&client->dev, &adxl367_i2c_ops, st, regmap,
+			     client->irq, id->name);
+}
+
+static const struct i2c_device_id adxl367_i2c_id[] = {
+	{ "adxl367", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, adxl367_i2c_id);
+
+static const struct of_device_id adxl367_of_match[] = {
+	{ .compatible = "adi,adxl367" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adxl367_of_match);
+
+static struct i2c_driver adxl367_i2c_driver = {
+	.driver = {
+		.name = "adxl367_i2c",
+		.of_match_table = adxl367_of_match,
+	},
+	.probe = adxl367_i2c_probe,
+	.id_table = adxl367_i2c_id,
+};
+
+module_i2c_driver(adxl367_i2c_driver);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL367 3-axis accelerometer I2C driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
new file mode 100644
index 000000000000..9d29054f956d
--- /dev/null
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Analog Devices, Inc.
+ * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#include "adxl367.h"
+
+#define ADXL367_SPI_WRITE_COMMAND	0x0A
+#define ADXL367_SPI_READ_COMMAND	0x0B
+#define ADXL367_SPI_FIFO_COMMAND	0x0D
+
+struct adxl367_spi_state {
+	struct spi_device	*spi;
+
+	struct spi_message	reg_write_msg;
+	struct spi_transfer	reg_write_xfer[2];
+
+	struct spi_message	reg_read_msg;
+	struct spi_transfer	reg_read_xfer[2];
+
+	struct spi_message	fifo_msg;
+	struct spi_transfer	fifo_xfer[2];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8			reg_write_tx_buf[1] ____cacheline_aligned;
+	u8			reg_read_tx_buf[2];
+	u8			fifo_tx_buf[1];
+};
+
+static int adxl367_read_fifo(void *context, __be16 *fifo_buf,
+			     unsigned int fifo_entries)
+{
+	struct adxl367_spi_state *st = context;
+
+	st->fifo_xfer[1].rx_buf = fifo_buf;
+	st->fifo_xfer[1].len = fifo_entries * sizeof(*fifo_buf);
+
+	return spi_sync(st->spi, &st->fifo_msg);
+}
+
+static int adxl367_read(void *context, const void *reg_buf, size_t reg_size,
+			void *val_buf, size_t val_size)
+{
+	struct adxl367_spi_state *st = context;
+	u8 reg = ((u8 *)reg_buf)[0];
+
+	st->reg_read_tx_buf[1] = reg;
+	st->reg_read_xfer[1].rx_buf = val_buf;
+	st->reg_read_xfer[1].len = val_size;
+
+	return spi_sync(st->spi, &st->reg_read_msg);
+}
+
+static int adxl367_write(void *context, const void *val_buf, size_t val_size)
+{
+	struct adxl367_spi_state *st = context;
+
+	st->reg_write_xfer[1].tx_buf = val_buf;
+	st->reg_write_xfer[1].len = val_size;
+
+	return spi_sync(st->spi, &st->reg_write_msg);
+}
+
+static struct regmap_bus adxl367_spi_regmap_bus = {
+	.read = adxl367_read,
+	.write = adxl367_write,
+};
+
+static const struct regmap_config adxl367_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct adxl367_ops adxl367_spi_ops = {
+	.read_fifo = adxl367_read_fifo,
+};
+
+static int adxl367_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct adxl367_spi_state *st;
+	struct regmap *regmap;
+
+	st = devm_kzalloc(&spi->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->spi = spi;
+
+	st->reg_write_tx_buf[0] = ADXL367_SPI_WRITE_COMMAND;
+	st->reg_write_xfer[0].tx_buf = st->reg_write_tx_buf;
+	st->reg_write_xfer[0].len = sizeof(st->reg_write_tx_buf);
+	spi_message_init_with_transfers(&st->reg_write_msg,
+					st->reg_write_xfer, 2);
+
+	st->reg_read_tx_buf[0] = ADXL367_SPI_READ_COMMAND;
+	st->reg_read_xfer[0].tx_buf = st->reg_read_tx_buf;
+	st->reg_read_xfer[0].len = sizeof(st->reg_read_tx_buf);
+	spi_message_init_with_transfers(&st->reg_read_msg,
+					st->reg_read_xfer, 2);
+
+	st->fifo_tx_buf[0] = ADXL367_SPI_FIFO_COMMAND;
+	st->fifo_xfer[0].tx_buf = st->fifo_tx_buf;
+	st->fifo_xfer[0].len = sizeof(st->fifo_tx_buf);
+	spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer, 2);
+
+	regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
+				  &adxl367_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return adxl367_probe(&spi->dev, &adxl367_spi_ops, st, regmap, spi->irq,
+			     id->name);
+}
+
+static const struct spi_device_id adxl367_spi_id[] = {
+	{ "adxl367", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, adxl367_spi_id);
+
+static const struct of_device_id adxl367_of_match[] = {
+	{ .compatible = "adi,adxl367" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adxl367_of_match);
+
+static struct spi_driver adxl367_spi_driver = {
+	.driver = {
+		.name = "adxl367_spi",
+		.of_match_table = adxl367_of_match,
+	},
+	.probe = adxl367_spi_probe,
+	.id_table = adxl367_spi_id,
+};
+
+module_spi_driver(adxl367_spi_driver);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL367 3-axis accelerometer SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

