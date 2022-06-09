Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4D54548C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiFITAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiFITAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:00:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD908FD2B;
        Thu,  9 Jun 2022 12:00:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so49202900ejj.10;
        Thu, 09 Jun 2022 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJf6fFb6Bv5aKL9SKFu5C2l7dJTaGApxOFaJtSi49Qg=;
        b=c8ndKPMge2lR5WlCOzKI63k4dOmTtoH8L4G/dNVCDs1CMHFjquM17rdZYvaTo8q6m6
         xXKCiTmizVyrYsC1KF5zdcm9Zu4f6TY8aZhqt62n3iTatjTeiCmOCN8k1AQwU8oi03ic
         GUvEpNUQMw7Uon8Bzuvz39Vc1M8NP6OBs4imq8yzA6Ph4yF+Mkr9fCQBeH7dsa4JDdCc
         VeZUitpsVX9bt6Dioa64hNUi6fFZEZMn0nx15ZlFAUzfCLOOH9J04Dgmbu4zLDPZpNCP
         Z8BCOM4sQUH0NFwaPmp2DPMkoGX6Xn8wiLe2hZpCiF1S7hq/emntp/8UNkZ8GFXvHlRY
         VOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJf6fFb6Bv5aKL9SKFu5C2l7dJTaGApxOFaJtSi49Qg=;
        b=3+b8v5wbpHe1DGH2Zei9JULGGl8OGlojPIE9q3vakCophd8brE8Ni+xlYpNm3QdkPl
         aWLinEtBA9aoeQSRUxGThSkvbgXR75E1HRytNC+9yIs6MKiJBlbE+wxIrss5ZbVGNOF5
         H1fr8Y+5R+wbMsKpv3RBGmqCdrt90CrTch8Y8AJcflnPrZl75Q8yKhudh8kO7Sl6AF9Z
         aH8+D5mcw/6OrOJBD0PIgK/TD0ygY4ut+IKEsJoBsbUSixayTmq66k6DLi5ZGHnI1mIz
         soERPbrLAjlYMdqY2GmFqlkXWO3NG7b8Bcr+nHxVGCyTvysRLuVUWlJ325d0qLJq1M6z
         FwEQ==
X-Gm-Message-State: AOAM530QGjLwJkgI+VEUIa7Xzcz18LIqkz2OmZBXX2BDabOUYe/9dFM6
        5jrG5/JZ8ouWI3QEDNpIz8ovuXdkuVc=
X-Google-Smtp-Source: ABdhPJwd3EBpt2FG608xlMaq3YrI1GZXoSQDqBEZFU7EhlNx9Svy4iiDNZ5k5X5NmyNI0mD8y43Vog==
X-Received: by 2002:a17:907:2d2a:b0:710:76a1:4d89 with SMTP id gs42-20020a1709072d2a00b0071076a14d89mr28153993ejc.307.1654801205635;
        Thu, 09 Jun 2022 12:00:05 -0700 (PDT)
Received: from DESKTOP-A98GP49.. (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906139900b006fe8c831632sm10923261ejc.73.2022.06.09.12.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:00:05 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Move device-specific data into struct aqc_data
Date:   Thu,  9 Jun 2022 20:59:35 +0200
Message-Id: <20220609185935.64539-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for adding support for more devices in upcoming patches,
move device-specific data, such as number of fans, temperature sensors,
register offsets etc. to struct aqc_data. This is made possible by
the fact that the supported Aquacomputer devices share the same layouts
of sensor substructures. This allows aqc_raw_event() and others to stay
general and not be cluttered with similar loops for each device.

Signed-off-by: Jack Doan <me@jackdoan.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 246 ++++++++++------------------
 1 file changed, 83 insertions(+), 163 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a0e69f7ece36..a210732dd229 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -54,57 +54,22 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
-/* Register offsets for the D5 Next pump */
-#define D5NEXT_POWER_CYCLES		24
-
-#define D5NEXT_COOLANT_TEMP		87
-
-#define D5NEXT_PUMP_SPEED		116
-#define D5NEXT_FAN_SPEED		103
-
-#define D5NEXT_PUMP_POWER		114
-#define D5NEXT_FAN_POWER		101
-
-#define D5NEXT_PUMP_VOLTAGE		110
-#define D5NEXT_FAN_VOLTAGE		97
-#define D5NEXT_5V_VOLTAGE		57
+/* Register offsets for all Aquacomputer devices */
+#define AQC_TEMP_SENSOR_SIZE		0x02
+#define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
+#define AQC_FAN_PERCENT_OFFSET		0x00
+#define AQC_FAN_VOLTAGE_OFFSET		0x02
+#define AQC_FAN_CURRENT_OFFSET		0x04
+#define AQC_FAN_POWER_OFFSET		0x06
+#define AQC_FAN_SPEED_OFFSET		0x08
 
-#define D5NEXT_PUMP_CURRENT		112
-#define D5NEXT_FAN_CURRENT		99
-
-/* Register offsets for the Farbwerk RGB controller */
-#define FARBWERK_NUM_SENSORS		4
-#define FARBWERK_SENSOR_START		0x2f
-#define FARBWERK_SENSOR_SIZE		0x02
-#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
-
-/* Register offsets for the Farbwerk 360 RGB controller */
-#define FARBWERK360_NUM_SENSORS		4
-#define FARBWERK360_SENSOR_START	0x32
-#define FARBWERK360_SENSOR_SIZE		0x02
-#define FARBWERK360_SENSOR_DISCONNECTED	0x7FFF
+/* Register offsets for the D5 Next pump */
+#define D5NEXT_5V_VOLTAGE		0x39
+static u8 d5next_sensor_fan_offsets[] = { 0x5F, 0x6C }; /* Pump and fan speed */
 
 /* Register offsets for the Octo fan controller */
-#define OCTO_POWER_CYCLES		0x18
-#define OCTO_NUM_FANS			8
-#define OCTO_FAN_PERCENT_OFFSET		0x00
-#define OCTO_FAN_VOLTAGE_OFFSET		0x02
-#define OCTO_FAN_CURRENT_OFFSET		0x04
-#define OCTO_FAN_POWER_OFFSET		0x06
-#define OCTO_FAN_SPEED_OFFSET		0x08
-
 static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
-#define OCTO_NUM_SENSORS		4
-#define OCTO_SENSOR_START		0x3D
-#define OCTO_SENSOR_SIZE		0x02
-#define OCTO_SENSOR_DISCONNECTED	0x7FFF
-
-#define OCTO_CTRL_REPORT_SIZE			0x65F
-#define OCTO_CTRL_REPORT_CHECKSUM_OFFSET	0x65D
-#define OCTO_CTRL_REPORT_CHECKSUM_START		0x01
-#define OCTO_CTRL_REPORT_CHECKSUM_LENGTH	0x65C
-
 /* Fan speed registers in Octo control report (from 0-100%) */
 static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
 
@@ -201,6 +166,13 @@ struct aqc_data {
 	int checksum_length;
 	int checksum_offset;
 
+	int num_fans;
+	u8 *fan_sensor_offsets;
+	u16 *fan_ctrl_offsets;
+	int num_temp_sensors;
+	int temp_sensor_start_offset;
+	u16 power_cycle_count_offset;
+
 	/* General info, same across all devices */
 	u32 serial_number[2];
 	u16 firmware_version;
@@ -323,56 +295,34 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 
 	switch (type) {
 	case hwmon_temp:
-		switch (priv->kind) {
-		case d5next:
-			if (channel == 0)
-				return 0444;
-			break;
-		case farbwerk:
-		case farbwerk360:
-		case octo:
+		if (channel < priv->num_temp_sensors)
 			return 0444;
-		default:
-			break;
-		}
 		break;
 	case hwmon_pwm:
-		switch (priv->kind) {
-		case octo:
+		if (priv->fan_ctrl_offsets && channel < priv->num_fans) {
 			switch (attr) {
 			case hwmon_pwm_input:
 				return 0644;
 			default:
 				break;
 			}
-			break;
-		default:
-			break;
 		}
 		break;
 	case hwmon_fan:
 	case hwmon_power:
 	case hwmon_curr:
-		switch (priv->kind) {
-		case d5next:
-			if (channel < 2)
-				return 0444;
-			break;
-		case octo:
+		if (channel < priv->num_fans)
 			return 0444;
-		default:
-			break;
-		}
 		break;
 	case hwmon_in:
 		switch (priv->kind) {
 		case d5next:
-			if (channel < 3)
+			if (channel < priv->num_fans + 1)	/* Allow the 5V voltage sensor */
 				return 0444;
 			break;
-		case octo:
-			return 0444;
 		default:
+			if (channel < priv->num_fans)
+				return 0444;
 			break;
 		}
 		break;
@@ -406,16 +356,12 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		*val = priv->power_input[channel];
 		break;
 	case hwmon_pwm:
-		switch (priv->kind) {
-		case octo:
-			ret = aqc_get_ctrl_val(priv, octo_ctrl_fan_offsets[channel]);
+		if (priv->fan_ctrl_offsets) {
+			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel]);
 			if (ret < 0)
 				return ret;
 
 			*val = aqc_percent_to_pwm(ret);
-			break;
-		default:
-			break;
 		}
 		break;
 	case hwmon_in:
@@ -469,19 +415,15 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
-			switch (priv->kind) {
-			case octo:
+			if (priv->fan_ctrl_offsets) {
 				pwm_value = aqc_pwm_to_percent(val);
 				if (pwm_value < 0)
 					return pwm_value;
 
-				ret = aqc_set_ctrl_val(priv, octo_ctrl_fan_offsets[channel],
+				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
 						       pwm_value);
 				if (ret < 0)
 					return ret;
-				break;
-			default:
-				break;
 			}
 			break;
 		default:
@@ -576,76 +518,38 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	priv->serial_number[1] = get_unaligned_be16(data + SERIAL_SECOND_PART);
 	priv->firmware_version = get_unaligned_be16(data + FIRMWARE_VERSION);
 
-	/* Sensor readings */
-	switch (priv->kind) {
-	case d5next:
-		priv->power_cycles = get_unaligned_be32(data + D5NEXT_POWER_CYCLES);
-
-		priv->temp_input[0] = get_unaligned_be16(data + D5NEXT_COOLANT_TEMP) * 10;
+	/* Temperature sensor readings */
+	for (i = 0; i < priv->num_temp_sensors; i++) {
+		sensor_value = get_unaligned_be16(data +
+						  priv->temp_sensor_start_offset +
+						  i * AQC_TEMP_SENSOR_SIZE);
+		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+			priv->temp_input[i] = -ENODATA;
+		else
+			priv->temp_input[i] = sensor_value * 10;
+	}
 
-		priv->speed_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_SPEED);
-		priv->speed_input[1] = get_unaligned_be16(data + D5NEXT_FAN_SPEED);
+	/* Fan speed and related readings */
+	for (i = 0; i < priv->num_fans; i++) {
+		priv->speed_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_SPEED_OFFSET);
+		priv->power_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+				       AQC_FAN_POWER_OFFSET) * 10000;
+		priv->voltage_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+				       AQC_FAN_VOLTAGE_OFFSET) * 10;
+		priv->current_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_CURRENT_OFFSET);
+	}
 
-		priv->power_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_POWER) * 10000;
-		priv->power_input[1] = get_unaligned_be16(data + D5NEXT_FAN_POWER) * 10000;
+	if (priv->power_cycle_count_offset != 0)
+		priv->power_cycles = get_unaligned_be32(data + priv->power_cycle_count_offset);
 
-		priv->voltage_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_VOLTAGE) * 10;
-		priv->voltage_input[1] = get_unaligned_be16(data + D5NEXT_FAN_VOLTAGE) * 10;
+	/* Additional readings of sensors not related to fans */
+	switch (priv->kind) {
+	case d5next:
 		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
-
-		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
-		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
-		break;
-	case farbwerk:
-		/* Temperature sensor readings */
-		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
-			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
-							  i * FARBWERK_SENSOR_SIZE);
-			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
-				priv->temp_input[i] = -ENODATA;
-			else
-				priv->temp_input[i] = sensor_value * 10;
-		}
-		break;
-	case farbwerk360:
-		/* Temperature sensor readings */
-		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
-			sensor_value = get_unaligned_be16(data + FARBWERK360_SENSOR_START +
-							  i * FARBWERK360_SENSOR_SIZE);
-			if (sensor_value == FARBWERK360_SENSOR_DISCONNECTED)
-				priv->temp_input[i] = -ENODATA;
-			else
-				priv->temp_input[i] = sensor_value * 10;
-		}
-		break;
-	case octo:
-		priv->power_cycles = get_unaligned_be32(data + OCTO_POWER_CYCLES);
-
-		/* Fan speed and related readings */
-		for (i = 0; i < OCTO_NUM_FANS; i++) {
-			priv->speed_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_SPEED_OFFSET);
-			priv->power_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_POWER_OFFSET) * 10000;
-			priv->voltage_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_VOLTAGE_OFFSET) * 10;
-			priv->current_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_CURRENT_OFFSET);
-		}
-
-		/* Temperature sensor readings */
-		for (i = 0; i < OCTO_NUM_SENSORS; i++) {
-			sensor_value = get_unaligned_be16(data + OCTO_SENSOR_START +
-							  i * OCTO_SENSOR_SIZE);
-			if (sensor_value == OCTO_SENSOR_DISCONNECTED)
-				priv->temp_input[i] = -ENODATA;
-			else
-				priv->temp_input[i] = sensor_value * 10;
-		}
 		break;
 	default:
 		break;
@@ -699,14 +603,8 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
 	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
 
-	switch (priv->kind) {
-	case d5next:
-	case octo:
+	if (priv->power_cycle_count_offset != 0)
 		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
-		break;
-	default:
-		break;
-	}
 }
 
 #else
@@ -747,6 +645,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case USB_PRODUCT_ID_D5NEXT:
 		priv->kind = d5next;
 
+		priv->num_fans = 2;
+		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
+		priv->num_temp_sensors = 1;
+		priv->temp_sensor_start_offset = 0x57;
+		priv->power_cycle_count_offset = 0x18;
+
 		priv->temp_label = label_d5next_temp;
 		priv->speed_label = label_d5next_speeds;
 		priv->power_label = label_d5next_power;
@@ -756,19 +660,29 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case USB_PRODUCT_ID_FARBWERK:
 		priv->kind = farbwerk;
 
+		priv->num_fans = 0;
+		priv->num_temp_sensors = 4;
+		priv->temp_sensor_start_offset = 0x2f;
 		priv->temp_label = label_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
 
+		priv->num_fans = 0;
+		priv->num_temp_sensors = 4;
+		priv->temp_sensor_start_offset = 0x32;
 		priv->temp_label = label_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_OCTO:
 		priv->kind = octo;
-		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
-		priv->checksum_start = OCTO_CTRL_REPORT_CHECKSUM_START;
-		priv->checksum_length = OCTO_CTRL_REPORT_CHECKSUM_LENGTH;
-		priv->checksum_offset = OCTO_CTRL_REPORT_CHECKSUM_OFFSET;
+
+		priv->num_fans = 8;
+		priv->fan_sensor_offsets = octo_sensor_fan_offsets;
+		priv->fan_ctrl_offsets = octo_ctrl_fan_offsets;
+		priv->num_temp_sensors = 4;
+		priv->temp_sensor_start_offset = 0x3d;
+		priv->power_cycle_count_offset = 0x18;
+		priv->buffer_size = 0x65f;
 
 		priv->temp_label = label_temp_sensors;
 		priv->speed_label = label_fan_speed;
@@ -780,6 +694,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	}
 
+	if (priv->buffer_size != 0) {
+		priv->checksum_start = 0x01;
+		priv->checksum_length = priv->buffer_size - 3;
+		priv->checksum_offset = priv->buffer_size - 2;
+	}
+
 	priv->name = aqc_device_names[priv->kind];
 
 	priv->buffer = devm_kzalloc(&hdev->dev, priv->buffer_size, GFP_KERNEL);
-- 
2.36.1

