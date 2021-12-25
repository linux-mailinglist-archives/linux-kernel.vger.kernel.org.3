Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1347F42E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhLYRyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:54:00 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:45521 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:53:59 -0500
Received: (Authenticated sender: frank@zago.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B4219200002;
        Sat, 25 Dec 2021 17:53:56 +0000 (UTC)
From:   frank zago <frank@zago.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        frank zago <frank@zago.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: position: Add support for ams AS5600 angle sensor
Date:   Sat, 25 Dec 2021 11:53:53 -0600
Message-Id: <20211225175353.4254-1-frank@zago.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AS5600 is a Hall-based rotary magnetic position sensor using
planar sensors that convert the magnetic field component perpendicular
to the surface of the chip into a voltage, or a numerical value
available through i2c.

The driver registers the chip as an IIO_ANGL device. It also exposes
the various registers through debugfs for further configuration.

Signed-off-by: frank zago <frank@zago.net>
---

changes in v2
- set the scale for both channels
- moved the sysfs entries into debugfs
- add enums for each register fields
- add rst doc for the driver

 Documentation/iio/as5600.rst  | 143 ++++++++++++++
 Documentation/iio/index.rst   |   2 +
 drivers/iio/position/Kconfig  |  10 +
 drivers/iio/position/Makefile |   1 +
 drivers/iio/position/as5600.c | 350 ++++++++++++++++++++++++++++++++++
 5 files changed, 506 insertions(+)
 create mode 100644 Documentation/iio/as5600.rst
 create mode 100644 drivers/iio/position/as5600.c

diff --git a/Documentation/iio/as5600.rst b/Documentation/iio/as5600.rst
new file mode 100644
index 000000000000..4f672baa78b6
--- /dev/null
+++ b/Documentation/iio/as5600.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=================
+ams AS5600 driver
+=================
+
+
+Overview
+========
+
+The ams AS5600 is a 12-Bit Programmable Contactless Potentiometer. Its
+i2c address is 0x36.
+
+For more information, see the datasheet at
+
+  https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
+
+
+Accessing the device registers
+==============================
+
+If needed, the device can be configured through debugfs, where most
+register fields are accessible.
+
+.. flat-table:: Registers and fields
+
+  * - Register
+    - Field
+    - Index
+    - Writable range
+
+  * - ZMCO
+    - ZMCO
+    - 0
+
+  * - ZPOS
+    - ZPOS
+    - 1
+    - 0 to 4095
+
+  * - MPOS
+    - MPOS
+    - 2
+    - 0 to 4095
+
+  * - MANG
+    - MANG
+    - 3
+
+  * - CONF
+    - PM
+    - 4
+    - 0 to 3
+
+  * - CONF
+    - HYST
+    - 5
+    - 0 to 3
+
+  * - CONF
+    - OUTS
+    - 6
+    - 0 to 3
+
+  * - CONF
+    - PWMF
+    - 7
+    - 0 to 3
+
+  * - CONF
+    - SF
+    - 8
+    - 0 to 3
+
+  * - CONF
+    - FTH
+    - 9
+    - 0 to 7
+
+  * - CONF
+    - WD
+    - 10
+    - 0 or 1
+
+  * - STATUS
+    - MH
+    - 11
+
+  * - STATUS
+    - ML
+    - 12
+
+  * - STATUS
+    - MD
+    - 13
+
+  * - AGC
+    - AGC
+    - 14
+
+  * - MAGNITUDE
+    - MAGNITUDE
+    - 15
+
+These registers allow the user to check the device and, if needed, to
+configure it.
+
+Assuming the device is iio:device0, its debugfs path will be::
+
+  AS5600=/sys/kernel/debug/iio/iio:device0/direct_reg_access
+
+Locate the index of a register to access in the table above, then use
+the following commands to read a value::
+
+  $ echo <index> > $AS5600/direct_reg_access
+  $ cat $AS5600/direct_reg_access
+
+or this to write a value::
+
+  $ echo <index> <value> > $AS5600/direct_reg_access
+
+For instance, this would return 1 if the magnet is present::
+
+  $ echo 13 > $AS5600/direct_reg_access
+  $ cat $AS5600/direct_reg_access
+
+
+Channels
+========
+
+The driver provides 2 channels. The channel 0 returns the raw,
+unscaled data. The channel 1 returns the data as was scaled by the
+device when ZPOS / MPOS are used. All angles returned have a value of
+0 to 4095.
+
+ZPOS and MPOS let a user restrict the angle returned, which improves
+the precision returned, since the angle returned is still in the 0 to
+4095 range. The minimal angle recommended is 18 degrees. For instance,
+this sets ZPOS and MPOS to a 70 degrees angle (4096/360*70=796), starting
+at some given offset (1200)::
+
+  echo 1 1200 > $AS5600
+  echo 2 1996 > $AS5600
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 58b7a4ebac51..937b626e64d4 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -9,4 +9,6 @@ Industrial I/O

    iio_configfs

+   as5600
+
    ep93xx_adc
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..111ed551ae79 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,16 @@

 menu "Linear and angular position sensors"

+config AS5600
+	tristate "ams AS5600 angular position sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to build support for the ams 5600
+	  12-Bit Programmable Contactless Potentiometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called as5600.
+
 config IQS624_POS
 	tristate "Azoteq IQS624/625 angular position sensors"
 	depends on MFD_IQS62X || COMPILE_TEST
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
index d70902f2979d..53930681e6a4 100644
--- a/drivers/iio/position/Makefile
+++ b/drivers/iio/position/Makefile
@@ -4,5 +4,6 @@

 # When adding new entries keep the list in alphabetical order

+obj-$(CONFIG_AS5600)		+= as5600.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
 obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
diff --git a/drivers/iio/position/as5600.c b/drivers/iio/position/as5600.c
new file mode 100644
index 000000000000..2c45dbfe170d
--- /dev/null
+++ b/drivers/iio/position/as5600.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ams AS5600 -- 12-Bit Programmable Contactless Potentiometer
+ *
+ * Copyright 2021, Frank Zago
+ *
+ * datasheet v1.06 (2018-Jun-20):
+ *    https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
+ *
+ * The rotating magnet is installed from 0.5mm to 3mm parallel to and
+ * above the chip.
+ *
+ * The raw angle value returned by the chip is [0..4095]. The channel
+ * 0 (in_angl0_raw) returns the unscaled and unmodified angle, always
+ * covering the 360 degrees. The channel 1 returns the chip adjusted
+ * angle, covering from 18 to 360 degrees, as modified by its
+ * ZPOS/MPOS/MANG values,
+ *
+ * ZPOS and MPOS can be programmed through their debugfs entries. The
+ * MANG register doesn't appear to be programmable without flashing
+ * the chip.
+ *
+ * If the DIR pin is grounded, angles will increase when the magnet is
+ * turned clockwise. If DIR is connected to Vcc, it will be the opposite.
+ *
+ * Permanent programming of the MPOS/ZPOS/MANG/CONF registers is not
+ * implemented.
+ *
+ * The i2c address of the device is 0x36.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+
+/* Registers and their fields, as defined in the datasheet */
+#define REG_ZMCO 0x00
+#define REG_ZPOS 0x01
+#define   REG_ZPOS_ZPOS GENMASK(11, 0)
+#define REG_MPOS 0x03
+#define   REG_MPOS_MPOS GENMASK(11, 0)
+#define REG_MANG 0x05
+#define   REG_MANG_MANG GENMASK(11, 0)
+#define REG_CONF 0x07
+#define REG_STATUS 0x0b
+#define   REG_STATUS_MD BIT(5)
+#define REG_RAW_ANGLE 0x0c
+#define   REG_RAW_ANGLE_ANGLE GENMASK(11, 0)
+#define REG_ANGLE 0x0e
+#define   REG_ANGLE_ANGLE GENMASK(11, 0)
+#define REG_AGC 0x1a
+#define REG_MAGNITUDE 0x1b
+#define REG_BURN 0xff
+
+enum {
+	X_REG_ZMCO_ZMCO,
+	X_REG_ZPOS_ZPOS,
+	X_REG_MPOS_MPOS,
+	X_REG_MANG_MANG,
+	X_REG_CONF_PM,
+	X_REG_CONF_HYST,
+	X_REG_CONF_OUTS,
+	X_REG_CONF_PWMF,
+	X_REG_CONF_SF,
+	X_REG_CONF_FTH,
+	X_REG_CONF_WD,
+	X_REG_STATUS_MH,
+	X_REG_STATUS_ML,
+	X_REG_STATUS_MD,
+	X_REG_AGC_AGC,
+	X_REG_MAGNITUDE_MAGNITUDE,
+
+	X_REG_NUM_ENTRIES,	/* last */
+};
+
+static const struct {
+	u8 reg;
+	u16 mask;
+	u16 max_value;		/* maximum writable value */
+} reg_access[] = {
+	[X_REG_ZMCO_ZMCO] = { REG_ZMCO, GENMASK(1, 0) },
+	[X_REG_ZPOS_ZPOS] = { REG_ZPOS, REG_ZPOS_ZPOS, 4095 },
+	[X_REG_MPOS_MPOS] = { REG_MPOS, REG_MPOS_MPOS, 4095 },
+	[X_REG_MANG_MANG] = { REG_MANG, REG_MANG_MANG, 4095 },
+	[X_REG_CONF_PM] = { REG_CONF, GENMASK(1, 0), 3 },
+	[X_REG_CONF_HYST] = { REG_CONF, GENMASK(3, 2), 3 },
+	[X_REG_CONF_OUTS] = { REG_CONF, GENMASK(5, 4), 3 },
+	[X_REG_CONF_PWMF] = { REG_CONF, GENMASK(7, 6), 3 },
+	[X_REG_CONF_SF] = { REG_CONF, GENMASK(9, 8), 3 },
+	[X_REG_CONF_FTH] = { REG_CONF, GENMASK(12, 10), 7},
+	[X_REG_CONF_WD] = { REG_CONF, BIT(13), 1 },
+	[X_REG_STATUS_MH] = { REG_STATUS, BIT(3) },
+	[X_REG_STATUS_ML] = { REG_STATUS, BIT(4) },
+	[X_REG_STATUS_MD] = { REG_STATUS, REG_STATUS_MD },
+	[X_REG_AGC_AGC] = { REG_AGC, GENMASK(7, 0) },
+	[X_REG_MAGNITUDE_MAGNITUDE] = { REG_MAGNITUDE, GENMASK(11, 0) },
+};
+
+/* runtime versions of the FIELD_GET/FIELD_PREP macros */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
+struct as5600_priv {
+	struct iio_dev *iio_dev;
+	struct i2c_client *client;
+	struct mutex lock;
+	u16 zpos;
+	u16 mpos;
+};
+
+static int as5600_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct as5600_priv *priv = iio_priv(indio_dev);
+	u16 bitmask;
+	s32 angle;
+	u16 reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel == 0) {
+			reg = REG_RAW_ANGLE;
+			bitmask = REG_RAW_ANGLE_ANGLE;
+		} else {
+			reg = REG_ANGLE;
+			bitmask = REG_ANGLE_ANGLE;
+		}
+		angle = i2c_smbus_read_word_swapped(priv->client, reg);
+
+		if (angle < 0)
+			return angle;
+		*val = field_get(bitmask, angle);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Always 4096 steps, but angle range varies between
+		 * 18 and 360 degrees.
+		 */
+		if (chan->channel == 0) {
+			/* Whole angle range - 2*pi / 4096 */
+			*val = 3141592;
+			*val2 = 2048000000;
+		} else {
+			s32 range;
+
+			/* Partial angle - (range/4096) * (2*pi / 4096) */
+			mutex_lock(&priv->lock);
+			range = priv->mpos - priv->zpos;
+			mutex_unlock(&priv->lock);
+			if (range <= 0)
+				range += 4096;
+
+			*val = range * 314159;
+			*val /= 4096;
+			*val2 = 204800000;
+		}
+
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t as5600_reg_access_read(struct as5600_priv *priv,
+				      unsigned int reg_access_idx,
+				      unsigned int *readval)
+{
+	unsigned int reg = reg_access[reg_access_idx].reg;
+	unsigned int mask = reg_access[reg_access_idx].mask;
+	int ret;
+
+	switch (reg) {
+	case REG_ZMCO:
+	case REG_STATUS:
+	case REG_AGC:
+		ret = i2c_smbus_read_byte_data(priv->client, reg);
+		if (ret < 0)
+			return ret;
+
+		*readval = field_get(mask, ret);
+		return 0;
+
+	case REG_ZPOS:
+	case REG_MPOS:
+	case REG_CONF:
+	case REG_MAGNITUDE:
+		ret = i2c_smbus_read_word_swapped(priv->client, reg);
+		if (ret < 0)
+			return ret;
+
+		*readval = field_get(mask, ret);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t as5600_reg_access_write(struct as5600_priv *priv,
+				       unsigned int reg_access_idx,
+				       unsigned int writeval)
+{
+	unsigned int reg = reg_access[reg_access_idx].reg;
+	unsigned int mask = reg_access[reg_access_idx].mask;
+	u16 out;
+	int ret;
+
+	switch (reg) {
+	case REG_ZPOS:
+	case REG_MPOS:
+	case REG_CONF:
+		if (writeval > reg_access[reg_access_idx].max_value)
+			return -EINVAL;
+
+		/* Read then write, as per spec */
+		ret = i2c_smbus_read_word_swapped(priv->client, reg);
+		if (ret < 0)
+			return ret;
+
+		out = ret & ~mask;
+		out |= field_prep(mask, writeval);
+
+		ret = i2c_smbus_write_word_swapped(priv->client, reg, out);
+		if (ret < 0)
+			return ret;
+
+		if (reg == REG_ZPOS)
+			priv->zpos = writeval;
+		else if (reg == REG_MPOS)
+			priv->mpos = writeval;
+
+		break;
+
+	default:
+		/* Not a writable register */
+		return -EINVAL;
+
+	}
+
+	return 0;
+}
+
+static int as5600_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct as5600_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	if (reg >= X_REG_NUM_ENTRIES)
+		return -EINVAL;
+
+	if (readval) {
+		ret = as5600_reg_access_read(priv, reg, readval);
+	} else {
+
+		mutex_lock(&priv->lock);
+		ret = as5600_reg_access_write(priv, reg, writeval);
+		mutex_unlock(&priv->lock);
+	}
+
+	return ret;
+}
+
+static const struct iio_chan_spec as5600_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 0,
+	},
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 1,
+	},
+};
+
+static const struct iio_info as5600_info = {
+	.read_raw = &as5600_read_raw,
+	.debugfs_reg_access = &as5600_reg_access,
+};
+
+static int as5600_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct as5600_priv *priv;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	priv->client = client;
+	mutex_init(&priv->lock);
+
+	indio_dev->info = &as5600_info;
+	indio_dev->name = "as5600";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = as5600_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as5600_channels);
+
+	ret = i2c_smbus_read_byte_data(client, REG_STATUS);
+	if (ret < 0)
+		return ret;
+
+	/* No magnet present could be a problem. */
+	if ((ret & REG_STATUS_MD) == 0)
+		dev_warn(&client->dev, "Magnet not detected\n");
+
+	ret = i2c_smbus_read_byte_data(client, REG_ZPOS);
+	if (ret < 0)
+		return ret;
+	priv->zpos = FIELD_GET(REG_ZPOS_ZPOS, ret);
+
+	ret = i2c_smbus_read_byte_data(client, REG_MPOS);
+	if (ret < 0)
+		return ret;
+	priv->mpos = FIELD_GET(REG_MPOS_MPOS, ret);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id as5600_i2c_id[] = {
+	{"as5600", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, as5600_i2c_id);
+
+static struct i2c_driver as5600_driver = {
+	.driver = {
+		.name = "as5600_i2c",
+	},
+	.probe = as5600_probe,
+	.id_table   = as5600_i2c_id,
+};
+
+module_i2c_driver(as5600_driver);
+
+MODULE_AUTHOR("Frank Zago <frank@zago.net>");
+MODULE_DESCRIPTION("ams AS5600 Contactless Potentiometer");
+MODULE_LICENSE("GPL");
--
2.32.0
