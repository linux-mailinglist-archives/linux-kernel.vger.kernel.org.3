Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479FD4C5E63
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 20:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiB0TSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 14:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiB0TSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 14:18:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FD3ED3E;
        Sun, 27 Feb 2022 11:18:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q17so14641940edd.4;
        Sun, 27 Feb 2022 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnEOnt5PieM5IAmr5dTnnzMbL5ZCql9W4sSeh6dElLw=;
        b=SEvMdRwWSOWZno8x4YOxlmiukZjtGua72YNN+Iq6lj9yvpgRuqTgGsSrzsNk2R/ucD
         IYRcGtRmA9FkEHpG49PoHUZ1yJ7Ix48qaqY69BRvtCRYIUwHciHdCdwi0bCdlQK6Iob7
         P9mojY/k9rScxCoybPDw1cOunsslk4jGynM5DQkFpoBQre7hwHyPU7z1ifisHCwZxWEt
         Je60h0+DYTpBjMnYcvHZQkiNjHlwtaj5wCZtw4XDSrfrpanF0sXFLoknR18bGyApBvrf
         49PavjyfpuHMYxdFZCpaNICR1IhfewyyJjUpJoR4RmTueOWBTY6P1negLq5NaYX2XcBi
         YOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnEOnt5PieM5IAmr5dTnnzMbL5ZCql9W4sSeh6dElLw=;
        b=Bv9e7VAy6EZ6guvhEJJxVAsNdLvtxKAROeDtIxiuqUYi5qD/gbw9GrO17+3XPhYgS3
         +28H75RjhWNMRa2SLUCfWoszXBQ2LoGR7V/lSrxpuQBJx/swdQ5zL1/kVc5KgViFFS4F
         TwCFtSgawFk43xGihZHhiQDJvg9QCdWNn58tpsityFwvA8gv44/iX+lwr5v9XcdsAeeP
         rvRU3nBxZcQ/03C+nZ0IdAnppAttP/PTMWEXIG3vSfIvtRkvRvqKRrvsFAcZ341Fl2JX
         WYYWtWpVHajsORQZtjxF30vz/czo9cta8aKmHCtgYAcNmqz+IJBaAVqiuO8RsDFAVihV
         56nA==
X-Gm-Message-State: AOAM532S2IX5Rjbos6UP4j9KcRa2jPwjZTMOrui/7yvcccBkU9TnRspb
        NbrEcfURFeJorw/Vr2Cvbfc+RKQ+rUiUzRKd
X-Google-Smtp-Source: ABdhPJwZ13Zyofu2p2xgOBSmHGolwuLSDv2Eo4IL0kcxPXpP6tt5+NEaARl+tFJugS/R0efWnibvog==
X-Received: by 2002:a50:ef10:0:b0:410:b95b:a89b with SMTP id m16-20020a50ef10000000b00410b95ba89bmr16225592eds.146.1645989481764;
        Sun, 27 Feb 2022 11:18:01 -0800 (PST)
Received: from fedora.. ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm4967262edz.29.2022.02.27.11.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:18:01 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Farbwerk 360
Date:   Sun, 27 Feb 2022 20:17:48 +0100
Message-Id: <20220227191749.23551-1-savicaleksa83@gmail.com>
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
of the Aquacomputer Farbwerk 360 RGB controller, which communicates through
a proprietary USB HID protocol.

Four temperature sensors are available. Additionally, serial number and
firmware version are exposed through debugfs.

This driver has been tested on x86_64.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v3:
- Reformatted channel info and array holding device names
- Shortened prefix of methods and structs to aqc

Changes in v2:
- Extended the existing aquacomputer_d5next driver instead of creating
  a new one and extended docs
- Moved asm include to the end
- Report ENODATA if sensor is disconnected instead of 0 degrees
---
 Documentation/hwmon/aquacomputer_d5next.rst |  49 ++-
 drivers/hwmon/aquacomputer_d5next.c         | 388 +++++++++++++-------
 2 files changed, 287 insertions(+), 150 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 1f4bb4ba2e4b..3373e27b707d 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -6,22 +6,21 @@ Kernel driver aquacomputer-d5next
 Supported devices:
 
 * Aquacomputer D5 Next watercooling pump
+* Aquacomputer Farbwerk 360 RGB controller
 
 Author: Aleksa Savic
 
 Description
 -----------
 
-This driver exposes hardware sensors of the Aquacomputer D5 Next watercooling
-pump, which communicates through a proprietary USB HID protocol.
+This driver exposes hardware sensors of listed Aquacomputer devices, which
+communicate through proprietary USB HID protocols.
 
-Available sensors are pump and fan speed, power, voltage and current, as
-well as coolant temperature. Also available through debugfs are the serial
-number, firmware version and power-on count.
-
-Attaching a fan is optional and allows it to be controlled using temperature
-curves directly from the pump. If it's not connected, the fan-related sensors
-will report zeroes.
+For the D5 Next pump, available sensors are pump and fan speed, power, voltage
+and current, as well as coolant temperature. Also available through debugfs are
+the serial number, firmware version and power-on count. Attaching a fan to it is
+optional and allows it to be controlled using temperature curves directly from the
+pump. If it's not connected, the fan-related sensors will report zeroes.
 
 The pump can be configured either through software or via its physical
 interface. Configuring the pump through this driver is not implemented, as it
@@ -29,33 +28,31 @@ seems to require sending it a complete configuration. That includes addressable
 RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
 better suited for userspace tools.
 
+The Farbwerk 360 exposes four temperature sensors. Depending on the device,
+not all sysfs and debugfs entries will be available.
+
 Usage notes
 -----------
 
-The pump communicates via HID reports. The driver is loaded automatically by
+The devices communicate via HID reports. The driver is loaded automatically by
 the kernel and supports hotswapping.
 
 Sysfs entries
 -------------
 
-============ =============================================
-temp1_input  Coolant temperature (in millidegrees Celsius)
-fan1_input   Pump speed (in RPM)
-fan2_input   Fan speed (in RPM)
-power1_input Pump power (in micro Watts)
-power2_input Fan power (in micro Watts)
-in0_input    Pump voltage (in milli Volts)
-in1_input    Fan voltage (in milli Volts)
-in2_input    +5V rail voltage (in milli Volts)
-curr1_input  Pump current (in milli Amperes)
-curr2_input  Fan current (in milli Amperes)
-============ =============================================
+================ =============================================
+temp[1-4]_input  Temperature sensors (in millidegrees Celsius)
+fan[1-2]_input   Pump/fan speed (in RPM)
+power[1-2]_input Pump/fan power (in micro Watts)
+in[0-2]_input    Pump/fan voltage (in milli Volts)
+curr[1-2]_input  Pump/fan current (in milli Amperes)
+================ =============================================
 
 Debugfs entries
 ---------------
 
-================ ===============================================
-serial_number    Serial number of the pump
+================ =================================================
+serial_number    Serial number of the device
 firmware_version Version of installed firmware
-power_cycles     Count of how many times the pump was powered on
-================ ===============================================
+power_cycles     Count of how many times the device was powered on
+================ =================================================
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index fb9341a53051..257a526261f1 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,32 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * hwmon driver for Aquacomputer D5 Next watercooling pump
+ * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360)
  *
- * The D5 Next sends HID reports (with ID 0x01) every second to report sensor values
- * (coolant temperature, pump and fan speed, voltage, current and power). It responds to
- * Get_Report requests, but returns a dummy value of no use.
+ * Aquacomputer devices send HID reports (with ID 0x01) every second to report
+ * sensor values
  *
  * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
  */
 
-#include <asm/unaligned.h>
 #include <linux/debugfs.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <asm/unaligned.h>
 
-#define DRIVER_NAME			"aquacomputer-d5next"
+#define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
+#define USB_PRODUCT_ID_D5NEXT		0xf00e
+#define USB_PRODUCT_ID_FARBWERK360	0xf010
 
-#define D5NEXT_STATUS_REPORT_ID	0x01
-#define D5NEXT_STATUS_UPDATE_INTERVAL	(2 * HZ) /* In seconds */
+enum kinds { d5next, farbwerk360 };
 
-/* Register offsets for the D5 Next pump */
+static const char *const aqc_device_names[] = {
+	[d5next] = "d5next",
+	[farbwerk360] = "farbwerk360"
+};
 
-#define D5NEXT_SERIAL_FIRST_PART	3
-#define D5NEXT_SERIAL_SECOND_PART	5
-#define D5NEXT_FIRMWARE_VERSION	13
+#define DRIVER_NAME			"aquacomputer_d5next"
+
+#define STATUS_REPORT_ID		0x01
+#define STATUS_UPDATE_INTERVAL		(2 * HZ)	/* In seconds */
+#define SERIAL_FIRST_PART		3
+#define SERIAL_SECOND_PART		5
+#define FIRMWARE_VERSION		13
+
+/* Register offsets for the D5 Next pump */
 #define D5NEXT_POWER_CYCLES		24
 
 #define D5NEXT_COOLANT_TEMP		87
@@ -44,76 +53,119 @@
 #define D5NEXT_PUMP_CURRENT		112
 #define D5NEXT_FAN_CURRENT		99
 
-/* Labels for provided values */
-
-#define L_COOLANT_TEMP			"Coolant temp"
+/* Register offsets for the Farbwerk 360 RGB controller */
+#define FARBWERK360_NUM_SENSORS		4
+#define FARBWERK360_SENSOR_START	0x32
+#define FARBWERK360_SENSOR_SIZE		0x02
+#define FARBWERK360_SENSOR_DISCONNECTED	0x7FFF
 
-#define L_PUMP_SPEED			"Pump speed"
-#define L_FAN_SPEED			"Fan speed"
+/* Labels for D5 Next */
+#define L_D5NEXT_COOLANT_TEMP		"Coolant temp"
 
-#define L_PUMP_POWER			"Pump power"
-#define L_FAN_POWER			"Fan power"
-
-#define L_PUMP_VOLTAGE			"Pump voltage"
-#define L_FAN_VOLTAGE			"Fan voltage"
-#define L_5V_VOLTAGE			"+5V voltage"
-
-#define L_PUMP_CURRENT			"Pump current"
-#define L_FAN_CURRENT			"Fan current"
+static const char *const label_d5next_speeds[] = {
+	"Pump speed",
+	"Fan speed"
+};
 
-static const char *const label_speeds[] = {
-	L_PUMP_SPEED,
-	L_FAN_SPEED,
+static const char *const label_d5next_power[] = {
+	"Pump power",
+	"Fan power"
 };
 
-static const char *const label_power[] = {
-	L_PUMP_POWER,
-	L_FAN_POWER,
+static const char *const label_d5next_voltages[] = {
+	"Pump voltage",
+	"Fan voltage",
+	"+5V voltage"
 };
 
-static const char *const label_voltages[] = {
-	L_PUMP_VOLTAGE,
-	L_FAN_VOLTAGE,
-	L_5V_VOLTAGE,
+static const char *const label_d5next_current[] = {
+	"Pump current",
+	"Fan current"
 };
 
-static const char *const label_current[] = {
-	L_PUMP_CURRENT,
-	L_FAN_CURRENT,
+/* Labels for Farbwerk 360 temperature sensors */
+static const char *const label_temp_sensors[] = {
+	"Sensor 1",
+	"Sensor 2",
+	"Sensor 3",
+	"Sensor 4"
 };
 
-struct d5next_data {
+struct aqc_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
 	struct dentry *debugfs;
-	s32 temp_input;
+	enum kinds kind;
+	const char *name;
+
+	/* General info, same across all devices */
+	u32 serial_number[2];
+	u16 firmware_version;
+
+	/* D5 Next specific - how many times the device was powered on */
+	u32 power_cycles;
+
+	/* Sensor values */
+	s32 temp_input[4];
 	u16 speed_input[2];
 	u32 power_input[2];
 	u16 voltage_input[3];
 	u16 current_input[2];
-	u32 serial_number[2];
-	u16 firmware_version;
-	u32 power_cycles; /* How many times the device was powered on */
+
 	unsigned long updated;
 };
 
-static umode_t d5next_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
-				 int channel)
+static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
+				       int channel)
 {
-	return 0444;
+	const struct aqc_data *priv = data;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (priv->kind) {
+		case d5next:
+			if (channel == 0)
+				return 0444;
+			break;
+		case farbwerk360:
+			return 0444;
+		default:
+			break;
+		}
+
+		break;
+	case hwmon_fan:
+	case hwmon_power:
+	case hwmon_in:
+	case hwmon_curr:
+		switch (priv->kind) {
+		case d5next:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
 }
 
-static int d5next_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
-		       long *val)
+static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			     int channel, long *val)
 {
-	struct d5next_data *priv = dev_get_drvdata(dev);
+	struct aqc_data *priv = dev_get_drvdata(dev);
 
-	if (time_after(jiffies, priv->updated + D5NEXT_STATUS_UPDATE_INTERVAL))
+	if (time_after(jiffies, priv->updated + STATUS_UPDATE_INTERVAL))
 		return -ENODATA;
 
 	switch (type) {
 	case hwmon_temp:
-		*val = priv->temp_input;
+		if (priv->temp_input[channel] == -ENODATA)
+			return -ENODATA;
+
+		*val = priv->temp_input[channel];
 		break;
 	case hwmon_fan:
 		*val = priv->speed_input[channel];
@@ -134,24 +186,64 @@ static int d5next_read(struct device *dev, enum hwmon_sensor_types type, u32 att
 	return 0;
 }
 
-static int d5next_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
-			      int channel, const char **str)
+static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+				    int channel, const char **str)
 {
+	struct aqc_data *priv = dev_get_drvdata(dev);
+
 	switch (type) {
 	case hwmon_temp:
-		*str = L_COOLANT_TEMP;
+		switch (priv->kind) {
+		case d5next:
+			*str = L_D5NEXT_COOLANT_TEMP;
+			break;
+		case farbwerk360:
+			*str = label_temp_sensors[channel];
+			break;
+		default:
+			break;
+		}
+
 		break;
 	case hwmon_fan:
-		*str = label_speeds[channel];
+		switch (priv->kind) {
+		case d5next:
+			*str = label_d5next_speeds[channel];
+			break;
+		default:
+			break;
+		}
+
 		break;
 	case hwmon_power:
-		*str = label_power[channel];
+		switch (priv->kind) {
+		case d5next:
+			*str = label_d5next_power[channel];
+			break;
+		default:
+			break;
+		}
+
 		break;
 	case hwmon_in:
-		*str = label_voltages[channel];
+		switch (priv->kind) {
+		case d5next:
+			*str = label_d5next_voltages[channel];
+			break;
+		default:
+			break;
+		}
+
 		break;
 	case hwmon_curr:
-		*str = label_current[channel];
+		switch (priv->kind) {
+		case d5next:
+			*str = label_d5next_current[channel];
+			break;
+		default:
+			break;
+		}
+
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -160,60 +252,89 @@ static int d5next_read_string(struct device *dev, enum hwmon_sensor_types type,
 	return 0;
 }
 
-static const struct hwmon_ops d5next_hwmon_ops = {
-	.is_visible = d5next_is_visible,
-	.read = d5next_read,
-	.read_string = d5next_read_string,
+static const struct hwmon_ops aqc_hwmon_ops = {
+	.is_visible = aqc_is_visible,
+	.read = aqc_read,
+	.read_string = aqc_read_string,
 };
 
-static const struct hwmon_channel_info *d5next_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
-	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL),
-	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL, HWMON_P_INPUT | HWMON_P_LABEL),
-	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+static const struct hwmon_channel_info *aqc_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
 			   HWMON_I_INPUT | HWMON_I_LABEL),
-	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_LABEL, HWMON_C_INPUT | HWMON_C_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
 	NULL
 };
 
-static const struct hwmon_chip_info d5next_chip_info = {
-	.ops = &d5next_hwmon_ops,
-	.info = d5next_info,
+static const struct hwmon_chip_info aqc_chip_info = {
+	.ops = &aqc_hwmon_ops,
+	.info = aqc_info,
 };
 
-static int d5next_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
+static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
+				  int size)
 {
-	struct d5next_data *priv;
+	int i, sensor_value;
+	struct aqc_data *priv;
 
-	if (report->id != D5NEXT_STATUS_REPORT_ID)
+	if (report->id != STATUS_REPORT_ID)
 		return 0;
 
 	priv = hid_get_drvdata(hdev);
 
 	/* Info provided with every report */
-
-	priv->serial_number[0] = get_unaligned_be16(data + D5NEXT_SERIAL_FIRST_PART);
-	priv->serial_number[1] = get_unaligned_be16(data + D5NEXT_SERIAL_SECOND_PART);
-
-	priv->firmware_version = get_unaligned_be16(data + D5NEXT_FIRMWARE_VERSION);
-	priv->power_cycles = get_unaligned_be32(data + D5NEXT_POWER_CYCLES);
+	priv->serial_number[0] = get_unaligned_be16(data + SERIAL_FIRST_PART);
+	priv->serial_number[1] = get_unaligned_be16(data + SERIAL_SECOND_PART);
+	priv->firmware_version = get_unaligned_be16(data + FIRMWARE_VERSION);
 
 	/* Sensor readings */
+	switch (priv->kind) {
+	case d5next:
+		priv->power_cycles = get_unaligned_be32(data + D5NEXT_POWER_CYCLES);
 
-	priv->temp_input = get_unaligned_be16(data + D5NEXT_COOLANT_TEMP) * 10;
+		priv->temp_input[0] = get_unaligned_be16(data + D5NEXT_COOLANT_TEMP) * 10;
 
-	priv->speed_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_SPEED);
-	priv->speed_input[1] = get_unaligned_be16(data + D5NEXT_FAN_SPEED);
+		priv->speed_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_SPEED);
+		priv->speed_input[1] = get_unaligned_be16(data + D5NEXT_FAN_SPEED);
 
-	priv->power_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_POWER) * 10000;
-	priv->power_input[1] = get_unaligned_be16(data + D5NEXT_FAN_POWER) * 10000;
+		priv->power_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_POWER) * 10000;
+		priv->power_input[1] = get_unaligned_be16(data + D5NEXT_FAN_POWER) * 10000;
 
-	priv->voltage_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_VOLTAGE) * 10;
-	priv->voltage_input[1] = get_unaligned_be16(data + D5NEXT_FAN_VOLTAGE) * 10;
-	priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
+		priv->voltage_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_VOLTAGE) * 10;
+		priv->voltage_input[1] = get_unaligned_be16(data + D5NEXT_FAN_VOLTAGE) * 10;
+		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
 
-	priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
-	priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
+		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
+		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
+		break;
+	case farbwerk360:
+		/* Temperature sensor readings */
+		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
+			sensor_value = get_unaligned_be16(data + FARBWERK360_SENSOR_START +
+							  i * FARBWERK360_SENSOR_SIZE);
+			if (sensor_value == FARBWERK360_SENSOR_DISCONNECTED)
+				priv->temp_input[i] = -ENODATA;
+			else
+				priv->temp_input[i] = sensor_value * 10;
+		}
+		break;
+	default:
+		break;
+	}
 
 	priv->updated = jiffies;
 
@@ -224,57 +345,63 @@ static int d5next_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 static int serial_number_show(struct seq_file *seqf, void *unused)
 {
-	struct d5next_data *priv = seqf->private;
+	struct aqc_data *priv = seqf->private;
 
 	seq_printf(seqf, "%05u-%05u\n", priv->serial_number[0], priv->serial_number[1]);
 
 	return 0;
 }
+
 DEFINE_SHOW_ATTRIBUTE(serial_number);
 
 static int firmware_version_show(struct seq_file *seqf, void *unused)
 {
-	struct d5next_data *priv = seqf->private;
+	struct aqc_data *priv = seqf->private;
 
 	seq_printf(seqf, "%u\n", priv->firmware_version);
 
 	return 0;
 }
+
 DEFINE_SHOW_ATTRIBUTE(firmware_version);
 
 static int power_cycles_show(struct seq_file *seqf, void *unused)
 {
-	struct d5next_data *priv = seqf->private;
+	struct aqc_data *priv = seqf->private;
 
 	seq_printf(seqf, "%u\n", priv->power_cycles);
 
 	return 0;
 }
+
 DEFINE_SHOW_ATTRIBUTE(power_cycles);
 
-static void d5next_debugfs_init(struct d5next_data *priv)
+static void aqc_debugfs_init(struct aqc_data *priv)
 {
-	char name[32];
+	char name[64];
 
-	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
+	scnprintf(name, sizeof(name), "%s_%s-%s", "aquacomputer", priv->name,
+		  dev_name(&priv->hdev->dev));
 
 	priv->debugfs = debugfs_create_dir(name, NULL);
 	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
 	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
-	debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
+
+	if (priv->kind == d5next)
+		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
 }
 
 #else
 
-static void d5next_debugfs_init(struct d5next_data *priv)
+static void aqc_debugfs_init(struct aqc_data *priv)
 {
 }
 
 #endif
 
-static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
+static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	struct d5next_data *priv;
+	struct aqc_data *priv;
 	int ret;
 
 	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -284,7 +411,7 @@ static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	priv->hdev = hdev;
 	hid_set_drvdata(hdev, priv);
 
-	priv->updated = jiffies - D5NEXT_STATUS_UPDATE_INTERVAL;
+	priv->updated = jiffies - STATUS_UPDATE_INTERVAL;
 
 	ret = hid_parse(hdev);
 	if (ret)
@@ -298,15 +425,28 @@ static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret)
 		goto fail_and_stop;
 
-	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "d5next", priv,
-							  &d5next_chip_info, NULL);
+	switch (hdev->product) {
+	case USB_PRODUCT_ID_D5NEXT:
+		priv->kind = d5next;
+		break;
+	case USB_PRODUCT_ID_FARBWERK360:
+		priv->kind = farbwerk360;
+		break;
+	default:
+		break;
+	}
+
+	priv->name = aqc_device_names[priv->kind];
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, priv->name, priv,
+							  &aqc_chip_info, NULL);
 
 	if (IS_ERR(priv->hwmon_dev)) {
 		ret = PTR_ERR(priv->hwmon_dev);
 		goto fail_and_close;
 	}
 
-	d5next_debugfs_init(priv);
+	aqc_debugfs_init(priv);
 
 	return 0;
 
@@ -317,9 +457,9 @@ static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 }
 
-static void d5next_remove(struct hid_device *hdev)
+static void aqc_remove(struct hid_device *hdev)
 {
-	struct d5next_data *priv = hid_get_drvdata(hdev);
+	struct aqc_data *priv = hid_get_drvdata(hdev);
 
 	debugfs_remove_recursive(priv->debugfs);
 	hwmon_device_unregister(priv->hwmon_dev);
@@ -328,36 +468,36 @@ static void d5next_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
-static const struct hid_device_id d5next_table[] = {
-	{ HID_USB_DEVICE(0x0c70, 0xf00e) }, /* Aquacomputer D5 Next */
-	{},
+static const struct hid_device_id aqc_table[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
+	{ }
 };
 
-MODULE_DEVICE_TABLE(hid, d5next_table);
+MODULE_DEVICE_TABLE(hid, aqc_table);
 
-static struct hid_driver d5next_driver = {
+static struct hid_driver aqc_driver = {
 	.name = DRIVER_NAME,
-	.id_table = d5next_table,
-	.probe = d5next_probe,
-	.remove = d5next_remove,
-	.raw_event = d5next_raw_event,
+	.id_table = aqc_table,
+	.probe = aqc_probe,
+	.remove = aqc_remove,
+	.raw_event = aqc_raw_event,
 };
 
-static int __init d5next_init(void)
+static int __init aqc_init(void)
 {
-	return hid_register_driver(&d5next_driver);
+	return hid_register_driver(&aqc_driver);
 }
 
-static void __exit d5next_exit(void)
+static void __exit aqc_exit(void)
 {
-	hid_unregister_driver(&d5next_driver);
+	hid_unregister_driver(&aqc_driver);
 }
 
 /* Request to initialize after the HID bus to ensure it's not being loaded before */
-
-late_initcall(d5next_init);
-module_exit(d5next_exit);
+late_initcall(aqc_init);
+module_exit(aqc_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
-MODULE_DESCRIPTION("Hwmon driver for Aquacomputer D5 Next pump");
+MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");
-- 
2.35.1

