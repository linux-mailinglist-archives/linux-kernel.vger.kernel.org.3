Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0898057FDBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiGYKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiGYKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:41:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0018B01;
        Mon, 25 Jul 2022 03:41:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C5C06601AA7;
        Mon, 25 Jul 2022 11:41:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658745693;
        bh=+q+8NDBUhNtIg9GLJCwDUtusuXKwwoWj8pLwJloG18Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhFpPMg9l7tEfuwzf2/5Rt/v5yBkklwVrW91bOibfwoV/EZDS/MrqSt9KS5LwnWOI
         eLr3SmKcrYQ3KUEzlxkoBCifCwHtaVVTflz3Zjn0M2Cvvv1yhPVqcljp0jFENUYCaF
         5OcH35vH1XmHvO/NPKQGzMH4R4zGDco5eHZ9UbegiUO3UkejC/6S9jlNyNnaPEy8u/
         zVTKrnAch3gVhWBkaiKx51NL4kLuHQmXFTkZrYqFV0yx8B6RPTlPBZQgxjKiWIXgAd
         0GNV4uKLdHqUbFYY9360st2qTghSsdPHBYufGKFWFvchofP5XPMwoNhehwLshx2eQs
         01EOFLQTz2pWg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, dmitry.osipenko@collabora.com
Cc:     krisman@collabora.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v10 2/2] iio: light: Add support for ltrf216a sensor
Date:   Mon, 25 Jul 2022 16:10:50 +0530
Message-Id: <20220725104050.491396-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725104050.491396-1-shreeya.patel@collabora.com>
References: <20220725104050.491396-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for ltrf216a ambient light sensor.

Datasheet: https://gitlab.collabora.com/shreeya/iio/-/blob/master/LTRF216A.pdf
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Co-developed-by: Zhigang Shi <Zhigang.Shi@liteon.com>
Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
Co-developed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
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
+       { .compatible = "ltr,ltrf216a", },

WARNING: DT compatible string vendor "ltr" appears un-documented
-- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#474: FILE: drivers/iio/light/ltrf216a.c:421:
+       { .compatible = "ltr,ltrf216a", },


Changes in v10
  - Handle !CONFIG_PM scenario similar to how other IIO drivers
    do it.
  - Fix kernel test robot warning.

Changes in v9
  - Add LTRF216A_MAIN_STATUS register in volatile function.
  - Update the datasheet link.

Changes in v8
  - Add caching mechanism to restore register state after h/w resume.
  - Add callback functions and disable locking in regmap config.
  - Update mutex comment as per it's current scope in the driver.
  - Add Shreeya as author of the driver.
  - Make some minor cleanups.

Changes in v7
  - Add regmap support.
  - Fix runtime power management implementation.
  - Fix the ordering of devm and non-devm functions.
  - Use DEFINE_RUNTIME_DEV_PM_OPS macro

Changes in v6
  - Fix some errors reported by kernel test robot.
  - Add protocol details for the datasheet link.
  - Remove useless assignments.
  - Add unit details for read data delay macro.
  - Use pm_sleep_ptr().

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

 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/ltrf216a.c | 537 +++++++++++++++++++++++++++++++++++
 3 files changed, 549 insertions(+)
 create mode 100644 drivers/iio/light/ltrf216a.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 8537e88f02e3..7cf6e8490123 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -331,6 +331,17 @@ config LTR501
 	  This driver can also be built as a module.  If so, the module
 	  will be called ltr501.
 
+config LTRF216A
+	tristate "Liteon LTRF216A Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
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
index 000000000000..e6e24e70d2b9
--- /dev/null
+++ b/drivers/iio/light/ltrf216a.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LTRF216A Ambient Light Sensor
+ *
+ * Copyright (C) 2022 Collabora, Ltd.
+ * Author: Shreeya Patel <shreeya.patel@collabora.com>
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
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+
+#include <asm/unaligned.h>
+
+#define LTRF216A_ALS_RESET_MASK		BIT(4)
+#define LTRF216A_ALS_DATA_STATUS	BIT(3)
+#define LTRF216A_ALS_ENABLE_MASK	BIT(1)
+#define LTRF216A_MAIN_CTRL		0x00
+#define LTRF216A_ALS_MEAS_RES		0x04
+#define LTRF216A_ALS_GAIN		0x05
+#define LTRF216A_PART_ID		0x06
+#define LTRF216A_MAIN_STATUS		0x07
+#define LTRF216A_ALS_CLEAR_DATA_0	0x0a
+#define LTRF216A_ALS_CLEAR_DATA_1	0x0b
+#define LTRF216A_ALS_CLEAR_DATA_2	0x0c
+#define LTRF216A_ALS_DATA_0		0x0d
+#define LTRF216A_ALS_DATA_1		0x0e
+#define LTRF216A_ALS_DATA_2		0x0f
+#define LTRF216A_INT_CFG		0x19
+#define LTRF216A_INT_PST		0x1a
+#define LTRF216A_ALS_THRES_UP_0		0x21
+#define LTRF216A_ALS_THRES_UP_1		0x22
+#define LTRF216A_ALS_THRES_UP_2		0x23
+#define LTRF216A_ALS_THRES_LOW_0	0x24
+#define LTRF216A_ALS_THRES_LOW_1	0x25
+#define LTRF216A_ALS_THRES_LOW_2	0x26
+#define LTRF216A_ALS_READ_DATA_DELAY_US	20000
+
+static const int ltrf216a_int_time_available[][2] = {
+	{ 0, 400000 },
+	{ 0, 200000 },
+	{ 0, 100000 },
+	{ 0,  50000 },
+	{ 0,  25000 },
+};
+
+static const int ltrf216a_int_time_reg[][2] = {
+	{ 400, 0x03 },
+	{ 200, 0x13 },
+	{ 100, 0x22 },
+	{  50, 0x31 },
+	{  25, 0x40 },
+};
+
+/*
+ * Window Factor is needed when the device is under Window glass
+ * with coated tinted ink. This is to compensate for the light loss
+ * due to the lower transmission rate of the window glass and helps
+ * in calculating lux.
+ */
+#define LTRF216A_WIN_FAC	1
+
+struct ltrf216a_data {
+	struct regmap *regmap;
+	struct i2c_client *client;
+	u32 int_time;
+	u16 int_time_fac;
+	u8 als_gain_fac;
+	/*
+	 * Protects regmap accesses and makes sure integration time
+	 * remains constant during the measurement of lux.
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
+static void ltrf216a_reset(struct iio_dev *indio_dev)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+
+	/* reset sensor, chip fails to respond to this, so ignore any errors */
+	regmap_write(data->regmap, LTRF216A_MAIN_CTRL, LTRF216A_ALS_RESET_MASK);
+
+	/* reset time */
+	usleep_range(1000, 2000);
+}
+
+static int ltrf216a_enable(struct iio_dev *indio_dev)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	/* enable sensor */
+	ret = regmap_set_bits(data->regmap,
+			      LTRF216A_MAIN_CTRL, LTRF216A_ALS_ENABLE_MASK);
+	if (ret) {
+		dev_err(dev, "failed to enable sensor: %d\n", ret);
+		return ret;
+	}
+
+	/* sleep for one integration cycle after enabling the device */
+	msleep(ltrf216a_int_time_reg[0][0]);
+
+	return 0;
+}
+
+static int ltrf216a_disable(struct iio_dev *indio_dev)
+{
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = regmap_write(data->regmap, LTRF216A_MAIN_CTRL, 0);
+	if (ret)
+		dev_err(dev, "failed to disable sensor: %d\n", ret);
+
+	return ret;
+}
+
+static void ltrf216a_cleanup(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	ltrf216a_disable(indio_dev);
+}
+
+static int ltrf216a_set_int_time(struct ltrf216a_data *data, int itime)
+{
+	struct device *dev = &data->client->dev;
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
+	ret = regmap_write(data->regmap, LTRF216A_ALS_MEAS_RES, reg_val);
+	if (ret) {
+		dev_err(dev, "failed to set integration time: %d\n", ret);
+		return ret;
+	}
+
+	data->int_time_fac = ltrf216a_int_time_reg[i][0];
+	data->int_time = itime;
+
+	return 0;
+}
+
+static int ltrf216a_get_int_time(struct ltrf216a_data *data,
+				 int *val, int *val2)
+{
+	*val = 0;
+	*val2 = data->int_time;
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
+{
+	struct device *dev = &data->client->dev;
+	int ret = 0;
+
+	if (on) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "failed to resume runtime PM: %d\n", ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret;
+}
+
+static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
+{
+	struct device *dev = &data->client->dev;
+	int ret, val;
+	u8 buf[3];
+
+	ret = regmap_read_poll_timeout(data->regmap, LTRF216A_MAIN_STATUS,
+				       val, val & LTRF216A_ALS_DATA_STATUS,
+				       LTRF216A_ALS_READ_DATA_DELAY_US,
+				       LTRF216A_ALS_READ_DATA_DELAY_US * 50);
+	if (ret) {
+		dev_err(dev, "failed to wait for measurement data: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_read(data->regmap, addr, buf, sizeof(buf));
+	if (ret) {
+		dev_err(dev, "failed to read measurement data: %d\n", ret);
+		return ret;
+	}
+
+	return get_unaligned_le24(&buf[0]);
+}
+
+static int ltrf216a_get_lux(struct ltrf216a_data *data)
+{
+	int ret, greendata;
+	u64 lux, div;
+
+	ret = ltrf216a_set_power_state(data, true);
+	if (ret)
+		return ret;
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
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->lock);
+		ret = ltrf216a_get_lux(data);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		ret = ltrf216a_get_int_time(data, val, val2);
+		mutex_unlock(&data->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
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
+	.read_raw = ltrf216a_read_raw,
+	.write_raw = ltrf216a_write_raw,
+	.read_avail = ltrf216a_read_available,
+};
+
+static bool ltrf216a_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTRF216A_MAIN_CTRL:
+	case LTRF216A_ALS_MEAS_RES:
+	case LTRF216A_ALS_GAIN:
+	case LTRF216A_PART_ID:
+	case LTRF216A_MAIN_STATUS:
+	case LTRF216A_ALS_CLEAR_DATA_0:
+	case LTRF216A_ALS_CLEAR_DATA_1:
+	case LTRF216A_ALS_CLEAR_DATA_2:
+	case LTRF216A_ALS_DATA_0:
+	case LTRF216A_ALS_DATA_1:
+	case LTRF216A_ALS_DATA_2:
+	case LTRF216A_INT_CFG:
+	case LTRF216A_INT_PST:
+	case LTRF216A_ALS_THRES_UP_0:
+	case LTRF216A_ALS_THRES_UP_1:
+	case LTRF216A_ALS_THRES_UP_2:
+	case LTRF216A_ALS_THRES_LOW_0:
+	case LTRF216A_ALS_THRES_LOW_1:
+	case LTRF216A_ALS_THRES_LOW_2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ltrf216a_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTRF216A_MAIN_CTRL:
+	case LTRF216A_ALS_MEAS_RES:
+	case LTRF216A_ALS_GAIN:
+	case LTRF216A_INT_CFG:
+	case LTRF216A_INT_PST:
+	case LTRF216A_ALS_THRES_UP_0:
+	case LTRF216A_ALS_THRES_UP_1:
+	case LTRF216A_ALS_THRES_UP_2:
+	case LTRF216A_ALS_THRES_LOW_0:
+	case LTRF216A_ALS_THRES_LOW_1:
+	case LTRF216A_ALS_THRES_LOW_2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ltrf216a_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTRF216A_MAIN_STATUS:
+	case LTRF216A_ALS_CLEAR_DATA_0:
+	case LTRF216A_ALS_CLEAR_DATA_1:
+	case LTRF216A_ALS_CLEAR_DATA_2:
+	case LTRF216A_ALS_DATA_0:
+	case LTRF216A_ALS_DATA_1:
+	case LTRF216A_ALS_DATA_2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ltrf216a_precious_reg(struct device *dev, unsigned int reg)
+{
+	return reg == LTRF216A_MAIN_STATUS;
+}
+
+static const struct regmap_config ltrf216a_regmap_config = {
+	.name = "ltrf216a",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = LTRF216A_ALS_THRES_LOW_2,
+	.readable_reg = ltrf216a_readable_reg,
+	.writeable_reg = ltrf216a_writable_reg,
+	.volatile_reg = ltrf216a_volatile_reg,
+	.precious_reg = ltrf216a_precious_reg,
+	.disable_locking = true,
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
+
+	data->regmap = devm_regmap_init_i2c(client, &ltrf216a_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
+
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	mutex_init(&data->lock);
+
+	indio_dev->info = &ltrf216a_info;
+	indio_dev->name = "ltrf216a";
+	indio_dev->channels = ltrf216a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret)
+		return ret;
+
+	/* reset sensor, chip fails to respond to this, so ignore any errors */
+	ltrf216a_reset(indio_dev);
+
+	ret = regmap_reinit_cache(data->regmap, &ltrf216a_regmap_config);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to reinit regmap cache\n");
+
+	ret = ltrf216a_enable(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, ltrf216a_cleanup,
+				       indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable runtime PM\n");
+
+	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	data->int_time = 100000;
+	data->int_time_fac = 100;
+	data->als_gain_fac = 3;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int ltrf216a_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = ltrf216a_disable(indio_dev);
+	if (ret)
+		return ret;
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int ltrf216a_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ltrf216a_data *data = iio_priv(indio_dev);
+	int ret;
+
+	regcache_cache_only(data->regmap, false);
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		goto cache_only;
+
+	ret = ltrf216a_enable(indio_dev);
+	if (ret)
+		goto cache_only;
+
+	return 0;
+
+cache_only:
+	regcache_cache_only(data->regmap, true);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
+				 ltrf216a_runtime_resume, NULL);
+
+static const struct i2c_device_id ltrf216a_id[] = {
+	{ "ltrf216a" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
+
+static const struct of_device_id ltrf216a_of_match[] = {
+	{ .compatible = "liteon,ltrf216a" },
+	{ .compatible = "ltr,ltrf216a" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
+
+static struct i2c_driver ltrf216a_driver = {
+	.driver = {
+		.name = "ltrf216a",
+		.pm = pm_ptr(&ltrf216a_pm_ops),
+		.of_match_table = ltrf216a_of_match,
+	},
+	.probe_new = ltrf216a_probe,
+	.id_table = ltrf216a_id,
+};
+module_i2c_driver(ltrf216a_driver);
+
+MODULE_AUTHOR("Shreeya Patel <shreeya.patel@collabora.com>");
+MODULE_AUTHOR("Shi Zhigang <Zhigang.Shi@liteon.com>");
+MODULE_DESCRIPTION("LTRF216A ambient light sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

