Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C385823D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiG0KHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiG0KHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:07:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2308D205FF;
        Wed, 27 Jul 2022 03:07:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j22so30646710ejs.2;
        Wed, 27 Jul 2022 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEFFbVE5fkcHwDG06EcZfk/hymgox/YXRHkwB4f1AUE=;
        b=eHxqf11IawgeQLRLAfpJeCkGZCpCaS6xCkIklYHl8Y/hoU8bxhacXPQkUoVI1U2rst
         9cdSWj/J/1T0iPpPNvylrfq3pUQcaQ04ZsGOG54xFM0ZpJRbGg6qJ+6jRUiw9vwMbBFF
         2WvydI91lgEC6FQv262k9xVZDN4HdrcY8aKvcB5lcwRkkhtRbWadewrp002vypqrSIIU
         qzYJNIPwtoWzn58BYZT5wJc5rJN5bly8lE8J81iyJZMbGcDgBdNhmaMFKMyMjlG0JN0y
         s9UJyZKgr/33J+/YnKUq1aw6YUn1rg1yryltfJeoLmNWmxcKf1LPyFrNTM0BHQetMFnY
         ftSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEFFbVE5fkcHwDG06EcZfk/hymgox/YXRHkwB4f1AUE=;
        b=6ayeizq3ZfOOrx6fqF/QBxbrjL6MsJmXZbgVhya62Ud14eRBYwdJ81a6446dssU90L
         QHFrOEePds9qB8sG0Ct0M4Tn+/NOdVy7DJFLIEsONMA0C2Bj94BhI6b81ixdoH+Bb94y
         kPCfgThKMmCXbMdqNM+vsIl8RniAQnQGgbHZ2fCbckjbZ3ezugKSogSzBxCRPU2Ac9aX
         SJoXKZULmkx/s+HirnJYvb/nLr903aHONPReGsrhnAqjDKtr8W+0JBidHakIMIK2KTGy
         Sczc54AOh1wTrHRba8cbnhFvYDAgybDf9DQ9j6RJGuzWf2l3krEXRbvIkK/2Tdb75b2K
         m2LA==
X-Gm-Message-State: AJIora9g77b8R+YWj69og/c0kQDy551oU5JpHyjhaD+0Hzdyo0GUB27s
        lYs3xk8az7JW5Fb9DeVtLU6ArLL0Kro/Pw==
X-Google-Smtp-Source: AGRyM1tQjJ86pmeA3B0d5d4yKEfeaHLpzqhLN7jp+wFhZtGQPqh6bFxhbabTOicANyth0cUCI8NkLg==
X-Received: by 2002:a17:906:cc15:b0:72b:5e0d:9a2a with SMTP id ml21-20020a170906cc1500b0072b5e0d9a2amr16331658ejb.614.1658916469148;
        Wed, 27 Jul 2022 03:07:49 -0700 (PDT)
Received: from DESKTOP-A98GP49.. (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906318900b0072b31123174sm7460777ejy.62.2022.07.27.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:07:48 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Quadro fan controller
Date:   Wed, 27 Jul 2022 12:06:05 +0200
Message-Id: <20220727100606.9328-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose hardware temperature sensors
and fans of the Aquacomputer Quadro fan controller, which communicates
through a proprietary USB HID protocol. Implemented by Jack Doan [1].

Four temperature sensors and PWM controllable fans are available. The
liquid flow sensor is also exposed, implemented by Leonard Anderweit [2].

Additionally, serial number, firmware version and power-on count are
exposed through debugfs.

This driver has been tested on x86_64.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/5
[2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/9

Originally-from: Jack Doan <me@jackdoan.com>
Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst | 17 +++--
 drivers/hwmon/Kconfig                       |  6 +-
 drivers/hwmon/aquacomputer_d5next.c         | 69 +++++++++++++++++++--
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 717e28226cde..33649a1e3a05 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -9,6 +9,7 @@ Supported devices:
 * Aquacomputer Farbwerk RGB controller
 * Aquacomputer Farbwerk 360 RGB controller
 * Aquacomputer Octo fan controller
+* Aquacomputer Quadro fan controller
 
 Author: Aleksa Savic
 
@@ -33,6 +34,9 @@ better suited for userspace tools.
 The Octo exposes four temperature sensors and eight PWM controllable fans, along
 with their speed (in RPM), power, voltage and current.
 
+The Quadro exposes four temperature sensors, a flow sensor and four PWM controllable
+fans, along with their speed (in RPM), power, voltage and current.
+
 The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
 not all sysfs and debugfs entries will be available.
 
@@ -45,13 +49,14 @@ the kernel and supports hotswapping.
 Sysfs entries
 -------------
 
-================ =============================================
+================ ==============================================
 temp[1-4]_input  Temperature sensors (in millidegrees Celsius)
-fan[1-2]_input   Pump/fan speed (in RPM)
-power[1-2]_input Pump/fan power (in micro Watts)
-in[0-2]_input    Pump/fan voltage (in milli Volts)
-curr[1-2]_input  Pump/fan current (in milli Amperes)
-================ =============================================
+fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
+power[1-8]_input Pump/fan power (in micro Watts)
+in[0-7]_input    Pump/fan voltage (in milli Volts)
+curr[1-8]_input  Pump/fan current (in milli Amperes)
+pwm[1-8]         Fan PWM (0 - 255)
+================ ==============================================
 
 Debugfs entries
 ---------------
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index fd2446cf343b..e70d9614bec2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -257,13 +257,13 @@ config SENSORS_AHT10
 	  will be called aht10.
 
 config SENSORS_AQUACOMPUTER_D5NEXT
-	tristate "Aquacomputer D5 Next, Octo, Farbwerk, and Farbwerk 360"
+	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, and Farbwerk 360"
 	depends on USB_HID
 	select CRC16
 	help
 	  If you say yes here you get support for sensors and fans of
-	  the Aquacomputer D5 Next watercooling pump, Octo fan
-	  controller, Farbwerk and Farbwerk 360 RGB controllers, where
+	  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
+	  controllers, Farbwerk and Farbwerk 360 RGB controllers, where
 	  available.
 
 	  This driver can also be built as a module. If so, the module
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 738a1df8eae6..66430553cc45 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo)
+ * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
+ * Quadro)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values.
@@ -21,17 +22,19 @@
 
 #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
 #define USB_PRODUCT_ID_FARBWERK		0xf00a
+#define USB_PRODUCT_ID_QUADRO		0xf00d
 #define USB_PRODUCT_ID_D5NEXT		0xf00e
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
 #define USB_PRODUCT_ID_OCTO		0xf011
 
-enum kinds { d5next, farbwerk, farbwerk360, octo };
+enum kinds { d5next, farbwerk, farbwerk360, octo, quadro };
 
 static const char *const aqc_device_names[] = {
 	[d5next] = "d5next",
 	[farbwerk] = "farbwerk",
 	[farbwerk360] = "farbwerk360",
-	[octo] = "octo"
+	[octo] = "octo",
+	[quadro] = "quadro"
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -97,6 +100,18 @@ static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB
 /* Fan speed registers in Octo control report (from 0-100%) */
 static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
 
+/* Register offsets for the Quadro fan controller */
+#define QUADRO_POWER_CYCLES		0x18
+#define QUADRO_NUM_FANS			4
+#define QUADRO_NUM_SENSORS		4
+#define QUADRO_SENSOR_START		0x34
+#define QUADRO_CTRL_REPORT_SIZE		0x3c1
+#define QUADRO_FLOW_SENSOR_OFFSET	0x6e
+static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
+
+/* Fan speed registers in Quadro control report (from 0-100%) */
+static u16 quadro_ctrl_fan_offsets[] = { 0x36, 0x8b, 0xe0, 0x135 };
+
 /* Labels for D5 Next */
 static const char *const label_d5next_temp[] = {
 	"Coolant temp"
@@ -124,7 +139,7 @@ static const char *const label_d5next_current[] = {
 	"Fan current"
 };
 
-/* Labels for Farbwerk, Farbwerk 360 and Octo temperature sensors */
+/* Labels for Farbwerk, Farbwerk 360 and Octo and Quadro temperature sensors */
 static const char *const label_temp_sensors[] = {
 	"Sensor 1",
 	"Sensor 2",
@@ -132,7 +147,7 @@ static const char *const label_temp_sensors[] = {
 	"Sensor 4"
 };
 
-/* Labels for Octo */
+/* Labels for Octo and Quadro (except speed) */
 static const char *const label_fan_speed[] = {
 	"Fan 1 speed",
 	"Fan 2 speed",
@@ -177,6 +192,15 @@ static const char *const label_fan_current[] = {
 	"Fan 8 current"
 };
 
+/* Labels for Quadro fan speeds */
+static const char *const label_quadro_speeds[] = {
+	"Fan 1 speed",
+	"Fan 2 speed",
+	"Fan 3 speed",
+	"Fan 4 speed",
+	"Flow speed [dL/h]"
+};
+
 struct aqc_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
@@ -197,6 +221,7 @@ struct aqc_data {
 	int num_temp_sensors;
 	int temp_sensor_start_offset;
 	u16 power_cycle_count_offset;
+	u8 flow_sensor_offset;
 
 	/* General info, same across all devices */
 	u32 serial_number[2];
@@ -334,6 +359,18 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		}
 		break;
 	case hwmon_fan:
+		switch (priv->kind) {
+		case quadro:
+			/* Special case to support flow sensor */
+			if (channel < priv->num_fans + 1)
+				return 0444;
+			break;
+		default:
+			if (channel < priv->num_fans)
+				return 0444;
+			break;
+		}
+		break;
 	case hwmon_power:
 	case hwmon_curr:
 		if (channel < priv->num_fans)
@@ -578,6 +615,9 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
 		priv->voltage_input[3] = get_unaligned_be16(data + D5NEXT_12V_VOLTAGE) * 10;
 		break;
+	case quadro:
+		priv->speed_input[4] = get_unaligned_be16(data + priv->flow_sensor_offset);
+		break;
 	default:
 		break;
 	}
@@ -719,6 +759,24 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
 		break;
+	case USB_PRODUCT_ID_QUADRO:
+		priv->kind = quadro;
+
+		priv->num_fans = QUADRO_NUM_FANS;
+		priv->fan_sensor_offsets = quadro_sensor_fan_offsets;
+		priv->fan_ctrl_offsets = quadro_ctrl_fan_offsets;
+		priv->num_temp_sensors = QUADRO_NUM_SENSORS;
+		priv->temp_sensor_start_offset = QUADRO_SENSOR_START;
+		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
+		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
+		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
+
+		priv->temp_label = label_temp_sensors;
+		priv->speed_label = label_quadro_speeds;
+		priv->power_label = label_fan_power;
+		priv->voltage_label = label_fan_voltage;
+		priv->current_label = label_fan_current;
+		break;
 	default:
 		break;
 	}
@@ -774,6 +832,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
 	{ }
 };
 
-- 
2.37.1

