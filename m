Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30A53CA04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiFCM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:28:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55B3A5DC;
        Fri,  3 Jun 2022 05:28:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fu3so14133640ejc.7;
        Fri, 03 Jun 2022 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYSeRFJf+M9aNqS1LqyGbAOqdo1Ua1JvigqLt2idPAQ=;
        b=cApS9/KdM+AKtD0BQHIShPWRYK9yv+z1A51dOi0JcW8tho065IFK4pMyHHOnL9CodW
         7mgl+/rGHpwa8CM4iBjJo7oXSCJX7fQns+AjQrNT7OjQfDiY/y9BL4msoibUpFPDb/tq
         JHkjA5X3vUo0j29wl0mfviqteThl+I8JI2vgE4E+FPthWNbXdF+ouU5xGrkB1CPG5Yvw
         oBxhxZ6QVbdgm8nfcD7i4zXvsC30bofVbE7XHanAOSSaIuC8OUtJHq0GV6AAguiDcgkz
         CrLWaN9Xn2mqMXYZ6kAKy2GS1rbicNaOIOQcw0HBCWoJpqQ3u+emF2ArJmhhhm4G9O7R
         AleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYSeRFJf+M9aNqS1LqyGbAOqdo1Ua1JvigqLt2idPAQ=;
        b=Z8TccpXYw2qnigLXhdNZ4F0OBxnNxioFUqLmMzbzlqakMrLISLG1PTVoXUEul1r72T
         gXy5fPPsRvbOmnsJ1wDOF5B39KR3i+H576y8P73wH1PSHU6lPP1DJIgoEk2IfLAPyvwh
         KBxWOR6PvNENS09yUyZlPc5rZPnHT7hVKRNjFgQomJXkYRYMZ2jtadelfXE5wePCVxUQ
         DR1SHzUSXmY37vUbw6eca7A/MuRdqEQuwpOqPxpPbmi2SOROE/E0sD0ijNnweXk7PYfx
         GmVsqlPdyW+vxpKPxw+xbSMM5kujZQOhbr2e94zmCYbSMepXm1Zc3ttD0EODgYA4Y0d1
         /Fnw==
X-Gm-Message-State: AOAM532SLwfGuoIhZVHnTM9EYNsssA82y/FI3F71MTxHjx4gF1wOqYBH
        VpCqD2YCEfMTLSid2bjIpQJFrtYZV3JWs4or
X-Google-Smtp-Source: ABdhPJwGyY6+XKUXe3U/N1bT/Su6zfWYWGUd3DiPengdRwJcKEBMLabu7csFrNmFeRjmfGmhW67HNA==
X-Received: by 2002:a17:907:9619:b0:6ff:5c3c:bcae with SMTP id gb25-20020a170907961900b006ff5c3cbcaemr8663841ejc.585.1654259307262;
        Fri, 03 Jun 2022 05:28:27 -0700 (PDT)
Received: from caracal.goemobile.intern (erm103.goemobile.de. [134.76.0.103])
        by smtp.googlemail.com with ESMTPSA id o13-20020a17090608cd00b006fedcb78854sm2785521eje.164.2022.06.03.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:26 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Shady Nawara <shady.nawara@outlook.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add support for Strix Z690-a D4
Date:   Fri,  3 Jun 2022 14:27:58 +0200
Message-Id: <20220603122758.1561064-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shady Nawara <shady.nawara@outlook.com>

adds T_Sensor and VRM Temp sensors for the Asus Strix z690-a D4 motherboard

Signed-off-by: Shady Nawara <shady.nawara@outlook.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 78ca69eda877..00d8c46ef9e0 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -19,6 +19,7 @@ Supported boards:
  * ROG STRIX X570-E GAMING WIFI II
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
+ * ROG STRIX Z690-A GAMING WIFI D4
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 57e11b2bab74..886a71b4c64e 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -54,6 +54,8 @@ static char *mutex_path_override;
 /* ACPI mutex for locking access to the EC for the firmware */
 #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
 
+#define ASUS_HW_ACCESS_MUTEX_RMTW_ASMX	"\\RMTW.ASMX"
+
 #define MAX_IDENTICAL_BOARD_VARIATIONS	3
 
 /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
@@ -139,6 +141,7 @@ enum board_family {
 	family_unknown,
 	family_amd_400_series,
 	family_amd_500_series,
+	family_intel_600_series
 };
 
 /* All the known sensors for ASUS EC controllers */
@@ -197,6 +200,12 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
 		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
 };
 
+static const struct ec_sensor_info sensors_family_intel_600[] = {
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
+	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
+};
+
 /* Shortcuts for common combinations */
 #define SENSOR_SET_TEMP_CHIPSET_CPU_MB                                         \
 	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
@@ -330,6 +339,12 @@ static const struct ec_board_info board_info[] = {
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 		.family = family_amd_500_series,
 	},
+	{
+		.board_names = {"ROG STRIX Z690-A GAMING WIFI D4"},
+		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+		.family = family_intel_600_series,
+	},
 	{}
 };
 
@@ -799,6 +814,9 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	case family_amd_500_series:
 		ec_data->sensors_info = sensors_family_amd_500;
 		break;
+	case family_intel_600_series:
+		ec_data->sensors_info = sensors_family_intel_600;
+		break;
 	default:
 		dev_err(dev, "Unknown board family: %d",
 			ec_data->board_info->family);
-- 
2.35.1

