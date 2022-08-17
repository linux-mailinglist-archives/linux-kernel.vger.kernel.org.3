Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42187596E46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiHQMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiHQMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:18:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8B44558;
        Wed, 17 Aug 2022 05:18:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so24248345ejp.2;
        Wed, 17 Aug 2022 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2h5BFCj/5sE0SmxPOUwIAGY6VqSnHEJYEL+Mpx8YvNg=;
        b=moNI8yW7kC9xffsAIVMGl4YxkEdr0uWAzbiB+jlXasbN6BkDshvoL6iVmaKO8hRXvm
         GmESPasr3N76Zqq5mfR4UsZgI0pGuGLKQHgP6TgqJNAyb4ihKlwYCzDIIoCg02fEaRQG
         9CaXhXYYbG4FvW66M0GYAUH9lrBkMjjmJ2lUeqKxpLTjygAT1AyORiKg/syE8BMNbyDk
         BActmNS0sVfQcKpVCIaGWUZeQO6/uCefTcCaQOLq/xBFnnGpNVCDtOTv8rmlyK+d/kFp
         C9BlNKZWL7brFcjqizFNKitrWlv7n8D8mH9xE1iXJ4zIopwFgmNDXwf8clsmiy9DhtKd
         DCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2h5BFCj/5sE0SmxPOUwIAGY6VqSnHEJYEL+Mpx8YvNg=;
        b=fINRLJifXsyXFEicpdlgEGeEeiuOo3X5NJW2kZJyhRiMA5TqsRlJPnPu+fOgPRDOTl
         wXcddP1jPCNm7VrQcwaqXwwLSOyLWMWD3njXWJfnE/uDd5vU+bepoJaWZ9KOP1lPyI8C
         2XPUEyAgzzE476h5/HDdiYb/DWfmqWvnw+Fq9bydmKzYGWpqWxhSEv2VjkfyGQi7KOzM
         UqFkxWadIeSlQ4rR1wqXJslo9aqCOr0eEzmCxTMXmx44iILWOkjeNNfuZ7LEUCa7fItO
         PBWV3n26DSGJV0LNFTfSMu5ePAnJfG8eg79C6kglACdr75HRKA45nfmEKE1mnwQuartv
         U5Rg==
X-Gm-Message-State: ACgBeo3iUj9sTkneGcLEb7qqEms5q7XH/m/IKjDLCMpg0XiumWLuZ0je
        YkUIHlxV+TboGUwYMqv5qRqlqchcNdo9xQ==
X-Google-Smtp-Source: AA6agR73o8Y2oDlf9qUqUgnCxJVEaiglWNWM47JwOUUwUKJWxhWKUudshn24a4OP244YkPhC8C3UTg==
X-Received: by 2002:a17:906:cc5e:b0:730:cf6d:5451 with SMTP id mm30-20020a170906cc5e00b00730cf6d5451mr16544105ejb.725.1660738710747;
        Wed, 17 Aug 2022 05:18:30 -0700 (PDT)
Received: from fedora.localdomain ([87.116.162.39])
        by smtp.gmail.com with ESMTPSA id ds13-20020a170907724d00b0071cef8bafc3sm6745556ejc.1.2022.08.17.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:18:30 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for reading virtual temp sensors
Date:   Wed, 17 Aug 2022 14:14:41 +0200
Message-Id: <20220817121441.112198-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Add support for reading virtual temperature sensors for the D5 Next, Octo,
Quadro and Farbwerk 360.

Virtual temperature sensors are written to the device by the user, pulling
from an arbitrary value source. Writing to them is not yet reverse
engineered, so the only way to set them for now is to use the official
software.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst | 32 +++++---
 drivers/hwmon/aquacomputer_d5next.c         | 88 +++++++++++++++++++--
 2 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 33649a1e3a05..b63a78d47624 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -20,10 +20,11 @@ This driver exposes hardware sensors of listed Aquacomputer devices, which
 communicate through proprietary USB HID protocols.
 
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
-and current, as well as coolant temperature. Also available through debugfs are
-the serial number, firmware version and power-on count. Attaching a fan to it is
-optional and allows it to be controlled using temperature curves directly from the
-pump. If it's not connected, the fan-related sensors will report zeroes.
+and current, as well as coolant temperature and eight virtual temp sensors. Also
+available through debugfs are the serial number, firmware version and power-on
+count. Attaching a fan to it is optional and allows it to be controlled using
+temperature curves directly from the pump. If it's not connected, the fan-related
+sensors will report zeroes.
 
 The pump can be configured either through software or via its physical
 interface. Configuring the pump through this driver is not implemented, as it
@@ -31,14 +32,19 @@ seems to require sending it a complete configuration. That includes addressable
 RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
 better suited for userspace tools.
 
-The Octo exposes four temperature sensors and eight PWM controllable fans, along
-with their speed (in RPM), power, voltage and current.
+The Octo exposes four physical and sixteen virtual temperature sensors, as well as
+eight PWM controllable fans, along with their speed (in RPM), power, voltage and
+current.
 
-The Quadro exposes four temperature sensors, a flow sensor and four PWM controllable
-fans, along with their speed (in RPM), power, voltage and current.
+The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
+sensor and four PWM controllable fans, along with their speed (in RPM), power,
+voltage and current.
 
-The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
-not all sysfs and debugfs entries will be available.
+The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
+sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
+
+Depending on the device, not all sysfs and debugfs entries will be available.
+Writing to virtual temperature sensors is not currently supported.
 
 Usage notes
 -----------
@@ -49,14 +55,14 @@ the kernel and supports hotswapping.
 Sysfs entries
 -------------
 
-================ ==============================================
-temp[1-4]_input  Temperature sensors (in millidegrees Celsius)
+================ ==============================================================
+temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
 curr[1-8]_input  Pump/fan current (in milli Amperes)
 pwm[1-8]         Fan PWM (0 - 255)
-================ ==============================================
+================ ==============================================================
 
 Debugfs entries
 ---------------
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 66430553cc45..b2b0c4fdfa84 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -71,6 +71,8 @@ static u8 secondary_ctrl_report[] = {
 #define D5NEXT_COOLANT_TEMP		0x57
 #define D5NEXT_NUM_FANS			2
 #define D5NEXT_NUM_SENSORS		1
+#define D5NEXT_NUM_VIRTUAL_SENSORS	8
+#define D5NEXT_VIRTUAL_SENSORS_START	0x3f
 #define D5NEXT_PUMP_OFFSET		0x6c
 #define D5NEXT_FAN_OFFSET		0x5f
 #define D5NEXT_5V_VOLTAGE		0x39
@@ -86,14 +88,18 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
 #define FARBWERK_SENSOR_START		0x2f
 
 /* Register offsets for the Farbwerk 360 RGB controller */
-#define FARBWERK360_NUM_SENSORS		4
-#define FARBWERK360_SENSOR_START	0x32
+#define FARBWERK360_NUM_SENSORS			4
+#define FARBWERK360_SENSOR_START		0x32
+#define FARBWERK360_NUM_VIRTUAL_SENSORS		16
+#define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
 
 /* Register offsets for the Octo fan controller */
 #define OCTO_POWER_CYCLES		0x18
 #define OCTO_NUM_FANS			8
 #define OCTO_NUM_SENSORS		4
 #define OCTO_SENSOR_START		0x3D
+#define OCTO_NUM_VIRTUAL_SENSORS	16
+#define OCTO_VIRTUAL_SENSORS_START	0x45
 #define OCTO_CTRL_REPORT_SIZE		0x65F
 static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
@@ -105,6 +111,8 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 #define QUADRO_NUM_FANS			4
 #define QUADRO_NUM_SENSORS		4
 #define QUADRO_SENSOR_START		0x34
+#define QUADRO_NUM_VIRTUAL_SENSORS	16
+#define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_CTRL_REPORT_SIZE		0x3c1
 #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
 static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
@@ -147,6 +155,25 @@ static const char *const label_temp_sensors[] = {
 	"Sensor 4"
 };
 
+static const char *const label_virtual_temp_sensors[] = {
+	"Virtual sensor 1",
+	"Virtual sensor 2",
+	"Virtual sensor 3",
+	"Virtual sensor 4",
+	"Virtual sensor 5",
+	"Virtual sensor 6",
+	"Virtual sensor 7",
+	"Virtual sensor 8",
+	"Virtual sensor 9",
+	"Virtual sensor 10",
+	"Virtual sensor 11",
+	"Virtual sensor 12",
+	"Virtual sensor 13",
+	"Virtual sensor 14",
+	"Virtual sensor 15",
+	"Virtual sensor 16",
+};
+
 /* Labels for Octo and Quadro (except speed) */
 static const char *const label_fan_speed[] = {
 	"Fan 1 speed",
@@ -220,6 +247,8 @@ struct aqc_data {
 	u16 *fan_ctrl_offsets;
 	int num_temp_sensors;
 	int temp_sensor_start_offset;
+	int num_virtual_temp_sensors;
+	int virtual_temp_sensor_start_offset;
 	u16 power_cycle_count_offset;
 	u8 flow_sensor_offset;
 
@@ -231,7 +260,7 @@ struct aqc_data {
 	u32 power_cycles;
 
 	/* Sensor values */
-	s32 temp_input[4];
+	s32 temp_input[20];	/* Max 4 physical and 16 virtual */
 	u16 speed_input[8];
 	u32 power_input[8];
 	u16 voltage_input[8];
@@ -239,6 +268,7 @@ struct aqc_data {
 
 	/* Label values */
 	const char *const *temp_label;
+	const char *const *virtual_temp_label;
 	const char *const *speed_label;
 	const char *const *power_label;
 	const char *const *voltage_label;
@@ -345,7 +375,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 
 	switch (type) {
 	case hwmon_temp:
-		if (channel < priv->num_temp_sensors)
+		if (channel < priv->num_temp_sensors + priv->num_virtual_temp_sensors)
 			return 0444;
 		break;
 	case hwmon_pwm:
@@ -447,7 +477,10 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
 
 	switch (type) {
 	case hwmon_temp:
-		*str = priv->temp_label[channel];
+		if (channel < priv->num_temp_sensors)
+			*str = priv->temp_label[channel];
+		else
+			*str = priv->virtual_temp_label[channel - priv->num_temp_sensors];
 		break;
 	case hwmon_fan:
 		*str = priv->speed_label[channel];
@@ -509,6 +542,22 @@ static const struct hwmon_ops aqc_hwmon_ops = {
 
 static const struct hwmon_channel_info *aqc_info[] = {
 	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
@@ -568,7 +617,7 @@ static const struct hwmon_chip_info aqc_chip_info = {
 
 static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
 {
-	int i, sensor_value;
+	int i, j, sensor_value;
 	struct aqc_data *priv;
 
 	if (report->id != STATUS_REPORT_ID)
@@ -581,7 +630,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	priv->serial_number[1] = get_unaligned_be16(data + SERIAL_SECOND_PART);
 	priv->firmware_version = get_unaligned_be16(data + FIRMWARE_VERSION);
 
-	/* Temperature sensor readings */
+	/* Physical temperature sensor readings */
 	for (i = 0; i < priv->num_temp_sensors; i++) {
 		sensor_value = get_unaligned_be16(data +
 						  priv->temp_sensor_start_offset +
@@ -592,6 +641,18 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 			priv->temp_input[i] = sensor_value * 10;
 	}
 
+	/* Virtual temperature sensor readings */
+	for (j = 0; j < priv->num_virtual_temp_sensors; j++) {
+		sensor_value = get_unaligned_be16(data +
+						  priv->virtual_temp_sensor_start_offset +
+						  j * AQC_TEMP_SENSOR_SIZE);
+		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+			priv->temp_input[i] = -ENODATA;
+		else
+			priv->temp_input[i] = sensor_value * 10;
+		i++;
+	}
+
 	/* Fan speed and related readings */
 	for (i = 0; i < priv->num_fans; i++) {
 		priv->speed_input[i] =
@@ -717,10 +778,13 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->fan_ctrl_offsets = d5next_ctrl_fan_offsets;
 		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
 		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
+		priv->num_virtual_temp_sensors = D5NEXT_NUM_VIRTUAL_SENSORS;
+		priv->virtual_temp_sensor_start_offset = D5NEXT_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
 
 		priv->temp_label = label_d5next_temp;
+		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->speed_label = label_d5next_speeds;
 		priv->power_label = label_d5next_power;
 		priv->voltage_label = label_d5next_voltages;
@@ -740,7 +804,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_fans = 0;
 		priv->num_temp_sensors = FARBWERK360_NUM_SENSORS;
 		priv->temp_sensor_start_offset = FARBWERK360_SENSOR_START;
+		priv->num_virtual_temp_sensors = FARBWERK360_NUM_VIRTUAL_SENSORS;
+		priv->virtual_temp_sensor_start_offset = FARBWERK360_VIRTUAL_SENSORS_START;
+
 		priv->temp_label = label_temp_sensors;
+		priv->virtual_temp_label = label_virtual_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_OCTO:
 		priv->kind = octo;
@@ -750,10 +818,13 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->fan_ctrl_offsets = octo_ctrl_fan_offsets;
 		priv->num_temp_sensors = OCTO_NUM_SENSORS;
 		priv->temp_sensor_start_offset = OCTO_SENSOR_START;
+		priv->num_virtual_temp_sensors = OCTO_NUM_VIRTUAL_SENSORS;
+		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
 
 		priv->temp_label = label_temp_sensors;
+		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->speed_label = label_fan_speed;
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
@@ -767,11 +838,14 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->fan_ctrl_offsets = quadro_ctrl_fan_offsets;
 		priv->num_temp_sensors = QUADRO_NUM_SENSORS;
 		priv->temp_sensor_start_offset = QUADRO_SENSOR_START;
+		priv->num_virtual_temp_sensors = QUADRO_NUM_VIRTUAL_SENSORS;
+		priv->virtual_temp_sensor_start_offset = QUADRO_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
+		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->speed_label = label_quadro_speeds;
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
-- 
2.30.2

