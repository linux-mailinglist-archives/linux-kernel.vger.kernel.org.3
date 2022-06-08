Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06030542F55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiFHLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiFHLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:37:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830ED1D64C7;
        Wed,  8 Jun 2022 04:37:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [103.15.253.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B917166017E5;
        Wed,  8 Jun 2022 12:37:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654688243;
        bh=LwtmuuUt6Hbb/BlOFJPF9xiZ//a4NmlZeAoPL815UZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZO8BxqERaA7RRPA0e1lXgLLQBSzvYBXPTdmSwqeyoCNZT0gfSBS/owPsMj4rBi695
         AD2EF/jpiYVM/qRoohhunTdW8n313X8jX3c5Wpe7e1anc4mIJksyNXUfpCjzbHxyxd
         rvvhsOZIrnxBjiskqTfVlmlSqusx38O3BeBTt26ZWMrMOzYnTZBV0IFbR6Akp2zlDC
         CCuHw3CgmjiJcPklPhTMF4azC7151LgqSuYnxTimMD/51GtNKfaw6281LbvuYXmIP3
         NmcBUYFrATAxpEqxcUThejXXrmM/qffwLpl4n17fcm2MuwhqeLUu2cwY8/ba08GxKh
         2Z4nGL88igvKQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v5 2/2] iio: light: Add support for ltrf216a sensor
Date:   Wed,  8 Jun 2022 17:05:53 +0530
Message-Id: <20220608113553.32083-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608113553.32083-1-shreeya.patel@collabora.com>
References: <20220608113553.32083-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Note :-

This patch generates the below mentioned warnings due to not documenting
the 'ltr' string in vendors-prefix.yaml and liteon,ltrf216a.yaml files.
The thread for the discussion of not documenting 'ltr' as deprecated
prefix can be found here.
https://lore.kernel.org/lkml/20220511094024.175994-2-shreeya.patel@collabora.com/

There are released devices which uses ltr216a light sensor and exposes the
vendor prefix name as 'ltr' through ACPI. Hence, we would like to add
this string under compatible property which would help probe the light sensor
driver.

WARNING: DT compatible string "ltr,ltrf216a" appears un-documented
-- check ./Documentation/devicetree/bindings/
#474: FILE: drivers/iio/light/ltrf216a.c:421:
+	{ .compatible = "ltr,ltrf216a", },

WARNING: DT compatible string vendor "ltr" appears un-documented
-- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#474: FILE: drivers/iio/light/ltrf216a.c:421:
+	{ .compatible = "ltr,ltrf216a", },


Changes in v5
  - Add power management support.
  - Add reset functionality.
  - Use readx_poll_timeout() to get data.
  - Cleanup some of the redundant code.
  - Update int_time_fac after I2C write is successful.
  - Rename mutex to lock.
  - Use Reverse Xmas tree pattern for all variable definitions.
  - Improve error handling messages and add error codes.
  - Add one more MODULE_AUTHOR.
  - Remove cleardata which was reading data for infrared light.

Changes in v4
  - Add more descriptive comment for mutex lock
  - Fix mutex locking in read_raw()
  - Use i2c_smbus_read_i2c_block_data()

Changes in v3
  - Use u16 instead of u8 for int_time_fac
  - Reorder headers in ltrf216a.c file
  - Remove int_time_mapping table and use int_time_available

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
 drivers/iio/light/ltrf216a.c | 441 +++++++++++++++++++++++++++++++++++
 3 files changed, 452 insertions(+)
 create mode 100644 drivers/iio/light/ltrf216a.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a62c7b4b8678..6c95431d12f6 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -332,6 +332,16 @@ config LTR501
 	  This driver can also be built as a module.  If so, the module
 	  will be called ltr501.
 
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
 config LV0104CS
 	tristate "LV0104CS Ambient Light Sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index d10912faf964..6f23817fae6f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
+obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
 obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
 obj-$(CONFIG_MAX44000)		+= max44000.o
 obj-$(CONFIG_MAX44009)		+= max44009.o
diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
new file mode 100644
index 000000000000..20a72105645e
--- /dev/null
+++ b/drivers/iio/light/ltrf216a.c
@@ -0,0 +1,441 @@
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
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <asm/unaligned.h>
+
+#define LTRF216A_DRV_NAME "ltrf216a"
+
+#define LTRF216A_ALS_RESET_MASK         BIT(4)
+#define LTRF216A_ALS_DATA_STATUS	BIT(3)
+#define LTRF216A_ALS_ENABLE_MASK	BIT(1)
+#define LTRF216A_MAIN_CTRL		0x00
+#define LTRF216A_ALS_MEAS_RES		0x04
+#define LTRF216A_MAIN_STATUS		0x07
+#define LTRF216A_CLEAR_DATA_0		0x0A
+#define LTRF216A_ALS_DATA_0		0x0D
+#define LTRF216A_ALS_READ_DATA_DELAY	20000
+
+static const int ltrf216a_int_time_available[][2] = {
+	{0, 400000},
+	{0, 200000},
+	{0, 100000},
+	{0, 50000},
+	{0, 25000},
+};
+
+static const int ltrf216a_int_time_reg[][2] = {
+	{400, 0x03},
+	{200, 0x13},
+	{100, 0x22},
+	{50, 0x31},
+	{25, 0x40},
+};
+
+/* Window Factor is needed when device is under Window glass
+ * with coated tinted ink. This is to compensate the light loss
+ * due to the lower transmission rate of the window glass.
+ */
+#define LTRF216A_WIN_FAC	1
+
+struct ltrf216a_data {
+	struct i2c_client *client;
+	u32 int_time;
+	u16 int_time_fac;
+	u8 als_gain_fac;
+	/*
+	 * Ensure cached value of integration time is consistent
+	 * with hardware setting and remains constant during a
+	 * measurement of Lux.
+	 */
+	struct mutex lock;
+};
+
+static const struct iio_chan_spec ltrf216a_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+};
+
+static int ltrf216a_init(struct iio_dev *indio_dev)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	/* enable sensor */
+	ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
+	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
+	if (ret < 0)
+		dev_err(&data->client->dev,
+			"Error writing to LTRF216A_MAIN_CTRL while enabling the sensor: %d\n", ret);
+
+	return ret;
+}
+
+static void ltrf216a_reset(struct iio_dev *indio_dev)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int regval = FIELD_PREP(LTRF216A_ALS_RESET_MASK, 1);
+
+	/* reset sensor, chip fails to respond to this, so ignore any errors */
+	i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, regval);
+
+	/* reset time */
+	usleep_range(1000, 2000);
+}
+
+static int ltrf216a_disable(struct iio_dev *indio_dev)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
+	if (ret < 0)
+		dev_err(&data->client->dev,
+			"Error writing to LTRF216A_MAIN_CTRL while disabling the sensor: %d\n",
+			ret);
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
+	unsigned int i;
+	u8 reg_val;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(ltrf216a_int_time_available); i++) {
+		if (ltrf216a_int_time_available[i][1] == itime)
+			break;
+	}
+	if (i == ARRAY_SIZE(ltrf216a_int_time_available))
+		return -EINVAL;
+
+	reg_val = ltrf216a_int_time_reg[i][1];
+
+	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RES, reg_val);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Error writing to LTRF216A_ALS_MEAS_RES: %d\n", ret);
+		return ret;
+	}
+
+	data->int_time_fac = ltrf216a_int_time_reg[i][0];
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
+#ifdef CONFIG_PM
+static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
+{
+	struct device *dev = &data->client->dev;
+	int ret = 0, suspended;
+
+	if (on) {
+		suspended = pm_runtime_suspended(dev);
+		ret = pm_runtime_get_sync(dev);
+
+		/* Allow one integration cycle before allowing a reading */
+		if (suspended)
+			msleep(ltrf216a_int_time_reg[0][0]);
+	} else {
+		pm_runtime_mark_last_busy(dev);
+		ret = pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret;
+}
+#else
+static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
+{
+	return 0;
+}
+#endif
+
+int ltrf216a_check_for_data(struct i2c_client *client)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, LTRF216A_MAIN_STATUS);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read LTRF216A_MAIN_STATUS register: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
+{
+	int ret, val;
+	u8 buf[3];
+
+	ret = readx_poll_timeout(ltrf216a_check_for_data, data->client, val,
+				 val & LTRF216A_ALS_DATA_STATUS, LTRF216A_ALS_READ_DATA_DELAY,
+				 LTRF216A_ALS_READ_DATA_DELAY * 25);
+	if (ret) {
+		dev_err(&data->client->dev, "Timed out waiting for valid data: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_smbus_read_i2c_block_data(data->client, addr, sizeof(buf), buf);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading measurement data: %d\n", ret);
+		return ret;
+	}
+
+	return get_unaligned_le24(&buf[0]);
+}
+
+static int ltrf216a_get_lux(struct ltrf216a_data *data)
+{
+	int greendata;
+	u64 lux, div;
+
+	ltrf216a_set_power_state(data, true);
+
+	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
+	if (greendata < 0)
+		return greendata;
+
+	ltrf216a_set_power_state(data, false);
+
+	lux = greendata * 45 * LTRF216A_WIN_FAC * 100;
+	div = data->als_gain_fac * data->int_time_fac * 100;
+
+	return div_u64(lux, div);
+}
+
+static int ltrf216a_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = ltrf216a_get_lux(data);
+		if (ret < 0)
+			break;
+		*val = ret;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = ltrf216a_get_int_time(data, val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&data->lock);
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
+		mutex_lock(&data->lock);
+		ret = ltrf216a_set_int_time(data, val2);
+		mutex_unlock(&data->lock);
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
+	mutex_init(&data->lock);
+
+	indio_dev->info = &ltrf216a_info;
+	indio_dev->name = LTRF216A_DRV_NAME;
+	indio_dev->channels = ltrf216a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* reset sensor, chip fails to respond to this, so ignore any errors */
+	ltrf216a_reset(indio_dev);
+
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret)
+		goto error_power_down;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, 5000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	ltrf216a_set_power_state(data, true);
+
+	ret = ltrf216a_init(indio_dev);
+	if (ret < 0) {
+		dev_err_probe(&client->dev, ret, "ltrf216a chip init failed\n");
+		goto error_power_down;
+	}
+
+	data->int_time = 100000;
+	data->int_time_fac = 100;
+	data->als_gain_fac = 3;
+
+	ret = devm_add_action_or_reset(&client->dev, als_ltrf216a_disable, indio_dev);
+	if (ret < 0)
+		goto error_power_down;
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret)
+		goto error_power_down;
+
+error_power_down:
+	ltrf216a_set_power_state(data, false);
+
+	return ret;
+}
+
+static int ltrf216a_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	ltrf216a_disable(indio_dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ltrf216a_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return ltrf216a_disable(indio_dev);
+}
+
+static int ltrf216a_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return ltrf216a_init(indio_dev);
+}
+#endif
+
+static const struct dev_pm_ops ltrf216a_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
+			   ltrf216a_runtime_resume, NULL)
+};
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
+	.remove         = ltrf216a_remove,
+	.id_table	= ltrf216a_id,
+};
+module_i2c_driver(ltrf216a_driver);
+
+MODULE_AUTHOR("Shi Zhigang <Zhigang.Shi@liteon.com>");
+MODULE_AUTHOR("Shreeya Patel <shreeya.patel@collabora.com>");
+MODULE_DESCRIPTION("LTRF216A ambient light sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

