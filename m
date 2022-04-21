Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395B50A187
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388952AbiDUOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388943AbiDUOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:06:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68F39BAA;
        Thu, 21 Apr 2022 07:03:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id A61541F45A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650549784;
        bh=5yKz0U94/C7HPRU4rE29jULG4W5PjD4E16GGWENPBY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESUCE4EQ2WCbVMp/AgSMiosNGxRNRv92edHfBI8tO72G89Hf7LhQdjg1Pd8fgl9q/
         H5vSUOr5/dYAUjixkR4n2eDy8Q64nul0oxPiC/8/6FQJhVEEkbLukLy1KvmSFHx2Lk
         4YCOaXy5cbpWKKOH6fobewS/fl5aSLDykmCICE0EKE1i5z+qGb95R3//s1casn847c
         yq10XRdp1Nx4DJhHoM848JL3G3cSYc6AvFA/RusTObDWdgBOMBkrny0ZbratEAn2c7
         9J2e40A2I7T1yI+PFcPbPRSm+ylOQWu+DIK9GxOgtreMl2L3JlIknuA+lGSBZjzEHi
         mdDqRH52hrA5g==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 3/3] iio: light: Add support for ltrf216a sensor
Date:   Thu, 21 Apr 2022 19:31:33 +0530
Message-Id: <20220421140133.354498-4-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421140133.354498-1-shreeya.patel@collabora.com>
References: <20220421140133.354498-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhigang Shi <Zhigang.Shi@liteon.com>

Add initial support for ltrf216a ambient light sensor.

Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
---

Changes in v2
  - Add support for 25ms and 50ms integration time.
  - Rename some of the macros as per names given in datasheet
  - Add a comment for the mutex lock
  - Use read_avail callback instead of attributes and set the
    appropriate _available bit.
  - Use FIELD_PREP() at appropriate places.
  - Add a constant lookup table for integration time and reg val
  - Use BIT() macro for magic numbers.
  - Improve error handling at few places.
  - Use get_unaligned_le24() and div_u64()
  - Use probe_new() callback and devm functions
  - Return errors in probe using dev_err_probe()
  - Use DEFINE_SIMPLE_DEV_PM_OPS()
  - Correct the formula for lux to use 0.45 instead of 0.8


 drivers/iio/light/Kconfig    |  10 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/ltrf216a.c | 349 +++++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)
 create mode 100644 drivers/iio/light/ltrf216a.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a62c7b4b8678..33d2b24ba1da 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -318,6 +318,16 @@ config SENSORS_LM3533
 	  changes. The ALS-control output values can be set per zone for the
 	  three current output channels.
 
+config LTRF216A
+	tristate "Liteon LTRF216A Light Sensor"
+	depends on I2C
+	help
+	  If you say Y or M here, you get support for Liteon LTRF216A
+	  Ambient Light Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  ltrf216a.
+
 config LTR501
 	tristate "LTR-501ALS-01 light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index d10912faf964..8fa91b9fe5b6 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
+obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
 obj-$(CONFIG_MAX44000)		+= max44000.o
diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
new file mode 100644
index 000000000000..de6d2e2e7f08
--- /dev/null
+++ b/drivers/iio/light/ltrf216a.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LTRF216A Ambient Light Sensor
+ *
+ * Copyright (C) 2021 Lite-On Technology Corp (Singapore)
+ * Author: Shi Zhigang <Zhigang.Shi@liteon.com>
+ *
+ * IIO driver for LTRF216A (7-bit I2C slave address 0x53).
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mod_devicetable.h>
+#include <linux/bitfield.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <asm/unaligned.h>
+
+#define LTRF216A_DRV_NAME "ltrf216a"
+
+#define LTRF216A_MAIN_CTRL		0x00
+
+#define LTRF216A_ALS_DATA_STATUS	BIT(3)
+#define LTRF216A_ALS_ENABLE_MASK	BIT(1)
+
+#define LTRF216A_ALS_MEAS_RES		0x04
+#define LTRF216A_MAIN_STATUS		0x07
+#define LTRF216A_CLEAR_DATA_0		0x0A
+
+#define LTRF216A_ALS_DATA_0		0x0D
+
+static const int int_time_mapping[] = { 400000, 200000, 100000, 50000, 25000 };
+
+static const int ltrf216a_int_time_available[5][2] = {
+	{0, 400000},
+	{0, 200000},
+	{0, 100000},
+	{0, 50000},
+	{0, 25000},
+};
+
+static const int ltrf216a_int_time_reg[5][2] = {
+	{400, 0x03},
+	{200, 0x13},
+	{100, 0x22},
+	{50, 0x31},
+	{25, 0x40},
+};
+
+struct ltrf216a_data {
+	struct i2c_client *client;
+	u32 int_time;
+	u8 int_time_fac;
+	u8 als_gain_fac;
+	struct mutex mutex; /* Protect read and write operations */
+};
+
+/* open air. need to update based on TP transmission rate. */
+#define WIN_FAC	1
+
+static const struct iio_chan_spec ltrf216a_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	}
+};
+
+static int ltrf216a_init(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+
+	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
+		return ret;
+	}
+
+	/* enable sensor */
+	ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
+	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ltrf216a_disable(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+
+	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
+	if (ret < 0)
+		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
+
+	return ret;
+}
+
+static void als_ltrf216a_disable(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	ltrf216a_disable(indio_dev);
+}
+
+static int ltrf216a_set_int_time(struct ltrf216a_data *data, int itime)
+{
+	int i, ret, index = -1;
+	u8 reg_val;
+
+	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
+		if (int_time_mapping[i] == itime) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
+
+	reg_val = ltrf216a_int_time_reg[index][1];
+	data->int_time_fac = ltrf216a_int_time_reg[index][0];
+
+	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RES, reg_val);
+	if (ret < 0)
+		return ret;
+
+	data->int_time = itime;
+
+	return 0;
+}
+
+static int ltrf216a_get_int_time(struct ltrf216a_data *data, int *val, int *val2)
+{
+	*val = 0;
+	*val2 = data->int_time;
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
+{
+	int i, ret = -1, tries = 25;
+	u8 buf[3];
+
+	while (tries--) {
+		ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
+		if (ret < 0)
+			return ret;
+		if (ret & LTRF216A_ALS_DATA_STATUS)
+			break;
+		msleep(20);
+	}
+
+	for (i = 0; i < 3; i++) {
+		ret = i2c_smbus_read_byte_data(data->client, addr);
+		if (ret < 0)
+			return ret;
+		buf[i] = ret;
+		addr++;
+	}
+
+	return get_unaligned_le24(&buf[0]);
+}
+
+static int ltrf216a_get_lux(struct ltrf216a_data *data)
+{
+	int greendata, cleardata;
+	u64 lux, div;
+
+	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
+	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
+
+	if (greendata < 0 || cleardata < 0) {
+		return -EINVAL;
+
+	} else {
+		lux = greendata * 45 * WIN_FAC * 100;
+		div = data->als_gain_fac * data->int_time_fac * 100;
+		lux = div_u64(lux, div);
+	}
+
+	return lux;
+}
+
+static int ltrf216a_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	int ret;
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->mutex);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = ltrf216a_get_lux(data);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = ltrf216a_get_int_time(data, val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int ltrf216a_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+		mutex_lock(&data->mutex);
+		ret = ltrf216a_set_int_time(data, val2);
+		mutex_unlock(&data->mutex);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltrf216a_read_available(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   const int **vals, int *type, int *length,
+				   long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(ltrf216a_int_time_available) * 2;
+		*vals = (const int *)ltrf216a_int_time_available;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltrf216a_info = {
+	.read_raw	= ltrf216a_read_raw,
+	.write_raw	= ltrf216a_write_raw,
+	.read_avail	= ltrf216a_read_available,
+};
+
+static int ltrf216a_probe(struct i2c_client *client)
+{
+	struct ltrf216a_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	mutex_init(&data->mutex);
+
+	indio_dev->info = &ltrf216a_info;
+	indio_dev->name = LTRF216A_DRV_NAME;
+	indio_dev->channels = ltrf216a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = ltrf216a_init(indio_dev);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "ltrf216a chip init failed\n");
+
+	data->int_time = 100000;
+	data->int_time_fac = 100;
+	data->als_gain_fac = 3;
+
+	ret = devm_add_action_or_reset(&client->dev, als_ltrf216a_disable,
+				       indio_dev);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int ltrf216a_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return ltrf216a_disable(indio_dev);
+}
+
+static int ltrf216a_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return ltrf216a_init(indio_dev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_suspend, ltrf216a_resume);
+
+static const struct i2c_device_id ltrf216a_id[] = {
+	{ LTRF216A_DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
+
+static const struct of_device_id ltrf216a_of_match[] = {
+	{ .compatible = "liteon,ltrf216a", },
+	{ .compatible = "ltr,ltrf216a", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
+
+static struct i2c_driver ltrf216a_driver = {
+	.driver = {
+		.name = LTRF216A_DRV_NAME,
+		.pm = pm_sleep_ptr(&ltrf216a_pm_ops),
+		.of_match_table = ltrf216a_of_match,
+	},
+	.probe_new	= ltrf216a_probe,
+	.id_table	= ltrf216a_id,
+};
+
+module_i2c_driver(ltrf216a_driver);
+
+MODULE_AUTHOR("Shi Zhigang <Zhigang.Shi@liteon.com>");
+MODULE_DESCRIPTION("LTRF216A ambient light sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

