Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0B509920
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385727AbiDUHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiDUHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:31:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4869AE40;
        Thu, 21 Apr 2022 00:28:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id x3so2612758wmj.5;
        Thu, 21 Apr 2022 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVcUd33TF8f6ZtTFduCfuS5Af+o0e9jEQEOkEXblH+c=;
        b=lAXa/6GPAVzY+POcPHX7uYwK0iesKTsRDcYPuRioQcp7mKEbEy8OteKie5/yplIFHA
         IEeCGYVChiiuNypK63/9/mMxFr0XxOT6Pf5NuPg5MNv/H6h/cJYuSCKdgE5C79sWgxMg
         FMvpc/JlJpEqVegxHJ2pExql5X0nzP5i7IWZ9xH80Vl0d7DEORPgV+jB6g9nVzxRpoga
         6vjgfn6Un+chRjZdL9jkadQvSdOgh4/r6MkSXdZRbW5Ll/QufoedZTFtnjt0V1hGzak0
         WbFdHZH+UBfWAJrBUmDwhDKSTVUj9339lu4Pi3rNHzVJfJemIQkR4KvIVea794CIPBoz
         6HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVcUd33TF8f6ZtTFduCfuS5Af+o0e9jEQEOkEXblH+c=;
        b=svlZsF1Xr7/HV17dX8NmkDeVXLMLVoxEr1Wtcb7+st0zvJVmklq+k+MGabtu0E3poA
         LxtFPNxBdHweKEo7yxEtYAq3jCQViP95Pth5OvOATpZTpP8CnqS3FRUPfZWRZp56s5so
         fCF3x1XrW+hvOgAsjdPltopWHLcYtDz1qR1qFZtx5dCqbS3HbjiAlVCTn9WpJ90douuZ
         bkrhBkRN8xEQm5x5NvyhwmZhQUyn8jtcOSBYLFDIwWInbPdQaK2PBJQYRWKJNSDbdFuM
         2Eqa2fr7+RulzIdM4USBHmcr19B/ozkYOS0f6sK1wgkNs1aGJmSfUwFIHpSwB+CEVCW9
         WSNA==
X-Gm-Message-State: AOAM530LqdABkSzLzlCjgXOxKnaIe7n1NyAftf/Vp30du84X+QR5g52n
        fFxszA2aVbYypiEiz5fi8vwFdSdazOCZuQ==
X-Google-Smtp-Source: ABdhPJyxOCa2EfufJCDTkwLazEmN2JPZfxw6npHwm9VGRvzv7yn8Z3NsmkOeMInAyCnVkvRALXGn+A==
X-Received: by 2002:a7b:c201:0:b0:38f:f7f5:f6db with SMTP id x1-20020a7bc201000000b0038ff7f5f6dbmr7160900wmi.191.1650526104018;
        Thu, 21 Apr 2022 00:28:24 -0700 (PDT)
Received: from fedora.. ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000188200b0020aa2581c7fsm1743733wri.104.2022.04.21.00.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:28:23 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     savicaleksa83@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Farbwerk
Date:   Thu, 21 Apr 2022 09:27:42 +0200
Message-Id: <20220421072743.5058-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose hardware temperature sensors
of the Aquacomputer Farbwerk RGB controller, which communicates through
a proprietary USB HID protocol.

Four temperature sensors are available. Additionally, serial number and
firmware version are exposed through debugfs.

Also, add Jack Doan to MAINTAINERS for this driver.

Signed-off-by: Jack Doan <me@jackdoan.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
If adding to MAINTAINERS requires a separate commit, I'll send it
separately.
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
 MAINTAINERS                                 |  1 +
 drivers/hwmon/Kconfig                       |  5 +--
 drivers/hwmon/aquacomputer_d5next.c         | 37 ++++++++++++++++++---
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index e69f718caf5b..717e28226cde 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -6,6 +6,7 @@ Kernel driver aquacomputer-d5next
 Supported devices:
 
 * Aquacomputer D5 Next watercooling pump
+* Aquacomputer Farbwerk RGB controller
 * Aquacomputer Farbwerk 360 RGB controller
 * Aquacomputer Octo fan controller
 
@@ -32,7 +33,7 @@ better suited for userspace tools.
 The Octo exposes four temperature sensors and eight PWM controllable fans, along
 with their speed (in RPM), power, voltage and current.
 
-The Farbwerk 360 exposes four temperature sensors. Depending on the device,
+The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
 not all sysfs and debugfs entries will be available.
 
 Usage notes
diff --git a/MAINTAINERS b/MAINTAINERS
index ea2cd656ee6c..d8e3ca0fbc3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1389,6 +1389,7 @@ F:	drivers/media/i2c/aptina-pll.*
 
 AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
 M:	Aleksa Savic <savicaleksa83@gmail.com>
+M:	Jack Doan <me@jackdoan.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/aquacomputer_d5next.rst
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5beadd8a0932..01d10c9b633a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -256,12 +256,13 @@ config SENSORS_AHT10
 	  will be called aht10.
 
 config SENSORS_AQUACOMPUTER_D5NEXT
-	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
+	tristate "Aquacomputer D5 Next, Octo, Farbwerk, Farbwerk 360"
 	depends on USB_HID
 	help
 	  If you say yes here you get support for sensors and fans of
 	  the Aquacomputer D5 Next watercooling pump, Octo fan
-	  controller and Farbwerk 360 RGB controller, where available.
+	  controller, Farbwerk and Farbwerk 360 RGB controllers, where
+	  available.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called aquacomputer_d5next.
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a464473bc981..7d2e7279abfb 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
+ * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values.
  *
  * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
+ * Copyright 2022 Jack Doan <me@jackdoan.com>
  */
 
 #include <linux/crc16.h>
@@ -19,14 +20,16 @@
 #include <asm/unaligned.h>
 
 #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
+#define USB_PRODUCT_ID_FARBWERK		0xf00a
 #define USB_PRODUCT_ID_D5NEXT		0xf00e
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
 #define USB_PRODUCT_ID_OCTO		0xf011
 
-enum kinds { d5next, farbwerk360, octo };
+enum kinds { d5next, farbwerk, farbwerk360, octo };
 
 static const char *const aqc_device_names[] = {
 	[d5next] = "d5next",
+	[farbwerk] = "farbwerk",
 	[farbwerk360] = "farbwerk360",
 	[octo] = "octo"
 };
@@ -69,6 +72,12 @@ static u8 secondary_ctrl_report[] = {
 #define D5NEXT_PUMP_CURRENT		112
 #define D5NEXT_FAN_CURRENT		99
 
+/* Register offsets for the Farbwerk RGB controller */
+#define FARBWERK_NUM_SENSORS		4
+#define FARBWERK_SENSOR_START		0x2f
+#define FARBWERK_SENSOR_SIZE		0x02
+#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
+
 /* Register offsets for the Farbwerk 360 RGB controller */
 #define FARBWERK360_NUM_SENSORS		4
 #define FARBWERK360_SENSOR_START	0x32
@@ -125,7 +134,7 @@ static const char *const label_d5next_current[] = {
 	"Fan current"
 };
 
-/* Labels for Farbwerk 360 and Octo temperature sensors */
+/* Labels for Farbwerk, Farbwerk 360 and Octo temperature sensors */
 static const char *const label_temp_sensors[] = {
 	"Sensor 1",
 	"Sensor 2",
@@ -319,6 +328,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			if (channel == 0)
 				return 0444;
 			break;
+		case farbwerk:
 		case farbwerk360:
 		case octo:
 			return 0444;
@@ -551,8 +561,7 @@ static const struct hwmon_chip_info aqc_chip_info = {
 	.info = aqc_info,
 };
 
-static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
-			 int size)
+static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
 {
 	int i, sensor_value;
 	struct aqc_data *priv;
@@ -587,6 +596,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
 		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
 		break;
+	case farbwerk:
+		/* Temperature sensor readings */
+		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
+			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
+							  i * FARBWERK_SENSOR_SIZE);
+			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
+				priv->temp_input[i] = -ENODATA;
+			else
+				priv->temp_input[i] = sensor_value * 10;
+		}
+		break;
 	case farbwerk360:
 		/* Temperature sensor readings */
 		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
@@ -733,6 +753,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->voltage_label = label_d5next_voltages;
 		priv->current_label = label_d5next_current;
 		break;
+	case USB_PRODUCT_ID_FARBWERK:
+		priv->kind = farbwerk;
+
+		priv->temp_label = label_temp_sensors;
+		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
 
@@ -795,6 +820,7 @@ static void aqc_remove(struct hid_device *hdev)
 
 static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ }
@@ -826,4 +852,5 @@ module_exit(aqc_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
+MODULE_AUTHOR("Jack Doan <me@jackdoan.com>");
 MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");
-- 
2.35.1

