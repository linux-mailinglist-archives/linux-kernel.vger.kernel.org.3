Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFF4E8668
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiC0HHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiC0HHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:07:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D93668A;
        Sun, 27 Mar 2022 00:05:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lr4so14349722ejb.11;
        Sun, 27 Mar 2022 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03Rz+DKLv+r2yISdGfp+0iE6M9fSjc538Kgqm6ohMxY=;
        b=o9u9Se0bABTyN6+j7kpyqoqyVDFzON2rJT4Zhc18GyeFLDrWJzYp3zHmO5cYm8jBUt
         1i6Az77srWuFBgWJ4ulvJQtgooIoKlmpfVlrjA3hHBsWpr7qKH0ro95xBeWUSt80nH8J
         IPswLS38wI3PHnk6pc7nKCgOzO+WH+wILa8CeFH2CHxUvSuWnXN2hhypbu3SwlrgIu8U
         JHFZIGw4N4sqqVv/jXTUm1vAwMf+I7f4+L6ZmzrOC+fQX29dnGxNoDZswDgYH0r9vX4F
         ai5wOdGBFpiYQs6vIaNrghg3OYIuxkB46n0fQYf/yreMXFqr7OpvP0LEIhQ6qync4yCB
         dcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03Rz+DKLv+r2yISdGfp+0iE6M9fSjc538Kgqm6ohMxY=;
        b=sThsrU+TkzhrccHSXGrVTp1cU3fG0sQTUvi2vw6ihnhUYMqwU0+PhvQ2byj6MZhbNm
         MY2c/lN2jthjFon9os3uifA7G8t+IDtAXcYoNTBRmqZhz7swCaz2CgFgSmQo4FzEKvht
         9irVcIVESxDr8uKj0hCfzJbugAFksfYg15mwQPeVsHD8APJSXI4aEdH/QPiXa1XRTaL7
         xp/h72nnvNKA7wdfi/EVITvka4nEjsK4d4MmYlKQYNr5nx/X955JTmRe4VoCKhcKNNdQ
         6maAyih2FwV6ZtdQLnm4AwauE/lFyFBpiYT9K91kaMrZWW/RPgpoEHP9N9NT4Ct5DSY3
         MzOA==
X-Gm-Message-State: AOAM532EaiDRJaa3i6cggVJml3IifydM9HqH4G+kd3aYF1mlKbCIZuQM
        G9WSjiPMQHzGeLZ51uPbZbXuxHkQPvasxg==
X-Google-Smtp-Source: ABdhPJyN135OQy5R80RHfEdb2D1aIZBO0oiCSaJ/zP64b6+4Ia4Xq8D2cfYsvzVFXzdixP+byJBwDQ==
X-Received: by 2002:a17:906:c211:b0:6ce:e221:4c21 with SMTP id d17-20020a170906c21100b006cee2214c21mr20295374ejz.691.1648364720313;
        Sun, 27 Mar 2022 00:05:20 -0700 (PDT)
Received: from fedora.. ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id j17-20020a05640211d100b00419357a2647sm5520330edw.25.2022.03.27.00.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 00:05:19 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     savicaleksa83@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo
Date:   Sun, 27 Mar 2022 09:04:46 +0200
Message-Id: <20220327070446.8151-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose hardware temperature sensors
and fans of the Aquacomputer Octo fan controller, which communicates
through a proprietary USB HID protocol.

Four temperature sensors and eight PWM controllable fans are available.
Additionally, serial number, firmware version and power-on count are
exposed through debugfs.

This driver has been tested on x86_64.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v3:
- Added break; statements where needed
- aqc_set_ctrl_val() now only sets values with a length of 2
- Replace goto with return in aqc_send_ctrl_data()

Changes in v2:
- Fixed formatting
- HID report values from device are now being converted sooner
- aqc_pwm_to_percent() is now range checked
- Put pointers to labels in aqc_data
- Simplified checksum calculation call
---
 Documentation/hwmon/aquacomputer_d5next.rst |   4 +
 drivers/hwmon/Kconfig                       |   7 +-
 drivers/hwmon/aquacomputer_d5next.c         | 431 +++++++++++++++++---
 3 files changed, 390 insertions(+), 52 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 3373e27b707d..e69f718caf5b 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -7,6 +7,7 @@ Supported devices:
 
 * Aquacomputer D5 Next watercooling pump
 * Aquacomputer Farbwerk 360 RGB controller
+* Aquacomputer Octo fan controller
 
 Author: Aleksa Savic
 
@@ -28,6 +29,9 @@ seems to require sending it a complete configuration. That includes addressable
 RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
 better suited for userspace tools.
 
+The Octo exposes four temperature sensors and eight PWM controllable fans, along
+with their speed (in RPM), power, voltage and current.
+
 The Farbwerk 360 exposes four temperature sensors. Depending on the device,
 not all sysfs and debugfs entries will be available.
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index db8bc55e5f50..5beadd8a0932 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -256,11 +256,12 @@ config SENSORS_AHT10
 	  will be called aht10.
 
 config SENSORS_AQUACOMPUTER_D5NEXT
-	tristate "Aquacomputer D5 Next watercooling pump"
+	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
 	depends on USB_HID
 	help
-	  If you say yes here you get support for the Aquacomputer D5 Next
-	  watercooling pump sensors.
+	  If you say yes here you get support for sensors and fans of
+	  the Aquacomputer D5 Next watercooling pump, Octo fan
+	  controller and Farbwerk 360 RGB controller, where available.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called aquacomputer_d5next.
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 525809cf7c95..cd008bfa03be 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360)
+ * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values.
@@ -8,23 +8,27 @@
  * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
  */
 
+#include <linux/crc16.h>
 #include <linux/debugfs.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <asm/unaligned.h>
 
 #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
 #define USB_PRODUCT_ID_D5NEXT		0xf00e
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
+#define USB_PRODUCT_ID_OCTO		0xf011
 
-enum kinds { d5next, farbwerk360 };
+enum kinds { d5next, farbwerk360, octo };
 
 static const char *const aqc_device_names[] = {
 	[d5next] = "d5next",
-	[farbwerk360] = "farbwerk360"
+	[farbwerk360] = "farbwerk360",
+	[octo] = "octo"
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -35,6 +39,18 @@ static const char *const aqc_device_names[] = {
 #define SERIAL_SECOND_PART		5
 #define FIRMWARE_VERSION		13
 
+#define CTRL_REPORT_ID			0x03
+
+/* The HID report that the official software always sends
+ * after writing values, currently same for all devices
+ */
+#define SECONDARY_CTRL_REPORT_ID	0x02
+#define SECONDARY_CTRL_REPORT_SIZE	0x0B
+
+static u8 secondary_ctrl_report[] = {
+	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
+};
+
 /* Register offsets for the D5 Next pump */
 #define D5NEXT_POWER_CYCLES		24
 
@@ -55,12 +71,38 @@ static const char *const aqc_device_names[] = {
 
 /* Register offsets for the Farbwerk 360 RGB controller */
 #define FARBWERK360_NUM_SENSORS		4
-#define FARBWERK360_SENSOR_START		0x32
+#define FARBWERK360_SENSOR_START	0x32
 #define FARBWERK360_SENSOR_SIZE		0x02
 #define FARBWERK360_SENSOR_DISCONNECTED	0x7FFF
 
+/* Register offsets for the Octo fan controller */
+#define OCTO_POWER_CYCLES		0x18
+#define OCTO_NUM_FANS			8
+#define OCTO_FAN_PERCENT_OFFSET		0x00
+#define OCTO_FAN_VOLTAGE_OFFSET		0x02
+#define OCTO_FAN_CURRENT_OFFSET		0x04
+#define OCTO_FAN_POWER_OFFSET		0x06
+#define OCTO_FAN_SPEED_OFFSET		0x08
+
+static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
+
+#define OCTO_NUM_SENSORS		4
+#define OCTO_SENSOR_START		0x3D
+#define OCTO_SENSOR_SIZE		0x02
+#define OCTO_SENSOR_DISCONNECTED	0x7FFF
+
+#define OCTO_CTRL_REPORT_SIZE			0x65F
+#define OCTO_CTRL_REPORT_CHECKSUM_OFFSET	0x65D
+#define OCTO_CTRL_REPORT_CHECKSUM_START		0x01
+#define OCTO_CTRL_REPORT_CHECKSUM_LENGTH	0x65C
+
+/* Fan speed registers in Octo control report (from 0-100%) */
+static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
+
 /* Labels for D5 Next */
-#define L_D5NEXT_COOLANT_TEMP		"Coolant temp"
+static const char *const label_d5next_temp[] = {
+	"Coolant temp"
+};
 
 static const char *const label_d5next_speeds[] = {
 	"Pump speed",
@@ -83,7 +125,7 @@ static const char *const label_d5next_current[] = {
 	"Fan current"
 };
 
-/* Labels for Farbwerk 360 temperature sensors */
+/* Labels for Farbwerk 360 and Octo temperature sensors */
 static const char *const label_temp_sensors[] = {
 	"Sensor 1",
 	"Sensor 2",
@@ -91,32 +133,180 @@ static const char *const label_temp_sensors[] = {
 	"Sensor 4"
 };
 
+/* Labels for Octo */
+static const char *const label_fan_speed[] = {
+	"Fan 1 speed",
+	"Fan 2 speed",
+	"Fan 3 speed",
+	"Fan 4 speed",
+	"Fan 5 speed",
+	"Fan 6 speed",
+	"Fan 7 speed",
+	"Fan 8 speed"
+};
+
+static const char *const label_fan_power[] = {
+	"Fan 1 power",
+	"Fan 2 power",
+	"Fan 3 power",
+	"Fan 4 power",
+	"Fan 5 power",
+	"Fan 6 power",
+	"Fan 7 power",
+	"Fan 8 power"
+};
+
+static const char *const label_fan_voltage[] = {
+	"Fan 1 voltage",
+	"Fan 2 voltage",
+	"Fan 3 voltage",
+	"Fan 4 voltage",
+	"Fan 5 voltage",
+	"Fan 6 voltage",
+	"Fan 7 voltage",
+	"Fan 8 voltage"
+};
+
+static const char *const label_fan_current[] = {
+	"Fan 1 current",
+	"Fan 2 current",
+	"Fan 3 current",
+	"Fan 4 current",
+	"Fan 5 current",
+	"Fan 6 current",
+	"Fan 7 current",
+	"Fan 8 current"
+};
+
 struct aqc_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
 	struct dentry *debugfs;
+	struct mutex mutex;	/* Used for locking access when reading and writing PWM values */
 	enum kinds kind;
 	const char *name;
 
+	int buffer_size;
+	u8 *buffer;
+	int checksum_start;
+	int checksum_length;
+	int checksum_offset;
+
 	/* General info, same across all devices */
 	u32 serial_number[2];
 	u16 firmware_version;
 
-	/* D5 Next specific - how many times the device was powered on */
+	/* How many times the device was powered on */
 	u32 power_cycles;
 
 	/* Sensor values */
 	s32 temp_input[4];
-	u16 speed_input[2];
-	u32 power_input[2];
-	u16 voltage_input[3];
-	u16 current_input[2];
+	u16 speed_input[8];
+	u32 power_input[8];
+	u16 voltage_input[8];
+	u16 current_input[8];
+
+	/* Label values */
+	const char *const *temp_label;
+	const char *const *speed_label;
+	const char *const *power_label;
+	const char *const *voltage_label;
+	const char *const *current_label;
 
 	unsigned long updated;
 };
 
-static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
-			      int channel)
+static int aqc_percent_to_pwm(u16 val)
+{
+	return DIV_ROUND_CLOSEST(val * 255, 100 * 100);
+}
+
+static int aqc_pwm_to_percent(long val)
+{
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	return DIV_ROUND_CLOSEST(val * 100 * 100, 255);
+}
+
+/* Expects the mutex to be locked */
+static int aqc_get_ctrl_data(struct aqc_data *priv)
+{
+	int ret;
+
+	memset(priv->buffer, 0x00, priv->buffer_size);
+	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0)
+		ret = -ENODATA;
+
+	return ret;
+}
+
+/* Expects the mutex to be locked */
+static int aqc_send_ctrl_data(struct aqc_data *priv)
+{
+	int ret;
+	u16 checksum;
+
+	/* Init and xorout value for CRC-16/USB is 0xffff */
+	checksum = crc16(0xffff, priv->buffer + priv->checksum_start, priv->checksum_length);
+	checksum ^= 0xffff;
+
+	/* Place the new checksum at the end of the report */
+	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
+
+	/* Send the patched up report back to the device */
+	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		return ret;
+
+	/* The official software sends this report after every change, so do it here as well */
+	ret = hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
+				 SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	return ret;
+}
+
+/* Refreshes the control buffer and returns value at offset */
+static int aqc_get_ctrl_val(struct aqc_data *priv, int offset)
+{
+	int ret;
+
+	mutex_lock(&priv->mutex);
+
+	ret = aqc_get_ctrl_data(priv);
+	if (ret < 0)
+		goto unlock_and_return;
+
+	ret = get_unaligned_be16(priv->buffer + offset);
+
+unlock_and_return:
+	mutex_unlock(&priv->mutex);
+	return ret;
+}
+
+static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
+{
+	int ret;
+
+	mutex_lock(&priv->mutex);
+
+	ret = aqc_get_ctrl_data(priv);
+	if (ret < 0)
+		goto unlock_and_return;
+
+	put_unaligned_be16((u16)val, priv->buffer + offset);
+
+	ret = aqc_send_ctrl_data(priv);
+
+unlock_and_return:
+	mutex_unlock(&priv->mutex);
+	return ret;
+}
+
+static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr, int channel)
 {
 	const struct aqc_data *priv = data;
 
@@ -128,17 +318,47 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 				return 0444;
 			break;
 		case farbwerk360:
+		case octo:
 			return 0444;
 		default:
 			break;
 		}
 		break;
+	case hwmon_pwm:
+		switch (priv->kind) {
+		case octo:
+			switch (attr) {
+			case hwmon_pwm_input:
+				return 0644;
+			default:
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+		break;
 	case hwmon_fan:
 	case hwmon_power:
-	case hwmon_in:
 	case hwmon_curr:
 		switch (priv->kind) {
 		case d5next:
+			if (channel < 2)
+				return 0444;
+			break;
+		case octo:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_in:
+		switch (priv->kind) {
+		case d5next:
+			if (channel < 3)
+				return 0444;
+			break;
+		case octo:
 			return 0444;
 		default:
 			break;
@@ -154,6 +374,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		    int channel, long *val)
 {
+	int ret;
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
 	if (time_after(jiffies, priv->updated + STATUS_UPDATE_INTERVAL))
@@ -172,6 +393,19 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_power:
 		*val = priv->power_input[channel];
 		break;
+	case hwmon_pwm:
+		switch (priv->kind) {
+		case octo:
+			ret = aqc_get_ctrl_val(priv, octo_ctrl_fan_offsets[channel]);
+			if (ret < 0)
+				return ret;
+
+			*val = aqc_percent_to_pwm(ret);
+			break;
+		default:
+			break;
+		}
+		break;
 	case hwmon_in:
 		*val = priv->voltage_input[channel];
 		break;
@@ -192,48 +426,51 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
 
 	switch (type) {
 	case hwmon_temp:
-		switch (priv->kind) {
-		case d5next:
-			*str = L_D5NEXT_COOLANT_TEMP;
-			break;
-		case farbwerk360:
-			*str = label_temp_sensors[channel];
-			break;
-		default:
-			break;
-		}
+		*str = priv->temp_label[channel];
 		break;
 	case hwmon_fan:
-		switch (priv->kind) {
-		case d5next:
-			*str = label_d5next_speeds[channel];
-			break;
-		default:
-			break;
-		}
+		*str = priv->speed_label[channel];
 		break;
 	case hwmon_power:
-		switch (priv->kind) {
-		case d5next:
-			*str = label_d5next_power[channel];
-			break;
-		default:
-			break;
-		}
+		*str = priv->power_label[channel];
 		break;
 	case hwmon_in:
-		switch (priv->kind) {
-		case d5next:
-			*str = label_d5next_voltages[channel];
-			break;
-		default:
-			break;
-		}
+		*str = priv->voltage_label[channel];
 		break;
 	case hwmon_curr:
-		switch (priv->kind) {
-		case d5next:
-			*str = label_d5next_current[channel];
+		*str = priv->current_label[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+		     long val)
+{
+	int ret, pwm_value;
+	struct aqc_data *priv = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			switch (priv->kind) {
+			case octo:
+				pwm_value = aqc_pwm_to_percent(val);
+				if (pwm_value < 0)
+					return pwm_value;
+
+				ret = aqc_set_ctrl_val(priv, octo_ctrl_fan_offsets[channel],
+						       pwm_value);
+				if (ret < 0)
+					return ret;
+				break;
+			default:
+				break;
+			}
 			break;
 		default:
 			break;
@@ -250,6 +487,7 @@ static const struct hwmon_ops aqc_hwmon_ops = {
 	.is_visible = aqc_is_visible,
 	.read = aqc_read,
 	.read_string = aqc_read_string,
+	.write = aqc_write
 };
 
 static const struct hwmon_channel_info *aqc_info[] = {
@@ -259,16 +497,48 @@ static const struct hwmon_channel_info *aqc_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
 	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
 			   HWMON_P_INPUT | HWMON_P_LABEL),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT),
 	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
 			   HWMON_I_INPUT | HWMON_I_LABEL),
 	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
 			   HWMON_C_INPUT | HWMON_C_LABEL,
 			   HWMON_C_INPUT | HWMON_C_LABEL),
 	NULL
@@ -326,6 +596,35 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 				priv->temp_input[i] = sensor_value * 10;
 		}
 		break;
+	case octo:
+		priv->power_cycles = get_unaligned_be32(data + OCTO_POWER_CYCLES);
+
+		/* Fan speed and related readings */
+		for (i = 0; i < OCTO_NUM_FANS; i++) {
+			priv->speed_input[i] =
+			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
+					       OCTO_FAN_SPEED_OFFSET);
+			priv->power_input[i] =
+			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
+					       OCTO_FAN_POWER_OFFSET) * 10000;
+			priv->voltage_input[i] =
+			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
+					       OCTO_FAN_VOLTAGE_OFFSET) * 10;
+			priv->current_input[i] =
+			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
+					       OCTO_FAN_CURRENT_OFFSET);
+		}
+
+		/* Temperature sensor readings */
+		for (i = 0; i < OCTO_NUM_SENSORS; i++) {
+			sensor_value = get_unaligned_be16(data + OCTO_SENSOR_START +
+							  i * OCTO_SENSOR_SIZE);
+			if (sensor_value == OCTO_SENSOR_DISCONNECTED)
+				priv->temp_input[i] = -ENODATA;
+			else
+				priv->temp_input[i] = sensor_value * 10;
+		}
+		break;
 	default:
 		break;
 	}
@@ -378,8 +677,14 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
 	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
 
-	if (priv->kind == d5next)
+	switch (priv->kind) {
+	case d5next:
+	case octo:
 		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
+		break;
+	default:
+		break;
+	}
 }
 
 #else
@@ -419,9 +724,30 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	switch (hdev->product) {
 	case USB_PRODUCT_ID_D5NEXT:
 		priv->kind = d5next;
+
+		priv->temp_label = label_d5next_temp;
+		priv->speed_label = label_d5next_speeds;
+		priv->power_label = label_d5next_power;
+		priv->voltage_label = label_d5next_voltages;
+		priv->current_label = label_d5next_current;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
+
+		priv->temp_label = label_temp_sensors;
+		break;
+	case USB_PRODUCT_ID_OCTO:
+		priv->kind = octo;
+		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->checksum_start = OCTO_CTRL_REPORT_CHECKSUM_START;
+		priv->checksum_length = OCTO_CTRL_REPORT_CHECKSUM_LENGTH;
+		priv->checksum_offset = OCTO_CTRL_REPORT_CHECKSUM_OFFSET;
+
+		priv->temp_label = label_temp_sensors;
+		priv->speed_label = label_fan_speed;
+		priv->power_label = label_fan_power;
+		priv->voltage_label = label_fan_voltage;
+		priv->current_label = label_fan_current;
 		break;
 	default:
 		break;
@@ -429,6 +755,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	priv->name = aqc_device_names[priv->kind];
 
+	priv->buffer = devm_kzalloc(&hdev->dev, priv->buffer_size, GFP_KERNEL);
+	if (!priv->buffer)
+		return -ENOMEM;
+
+	mutex_init(&priv->mutex);
+
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, priv->name, priv,
 							  &aqc_chip_info, NULL);
 
@@ -462,6 +794,7 @@ static void aqc_remove(struct hid_device *hdev)
 static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ }
 };
 
-- 
2.35.1

