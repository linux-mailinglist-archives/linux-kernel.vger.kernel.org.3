Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6435156D145
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGJU2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGJU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:28:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7391409A;
        Sun, 10 Jul 2022 13:27:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so4651413wrd.8;
        Sun, 10 Jul 2022 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0k2zF0O8Dezyoaka8gcKnbwBTdSGFZmQ+t8biXBBv8=;
        b=drWRp0KmleqSTXBVY3rpEf/Mak2Ti9MFnmWzqd898GkytxKKZuO6Bjw7RuaSSRgMRd
         aPE6uURcD8YFB6pEfOVXUrCSVwV5irXt3A4hGyr4FyB6kYSUgeb4EJdNHqzB56Ov52CJ
         gpZKCKg18VNOVxHQG0DMVCCnfxo+VbOO8+BaxAhjENOasNi7LdBrbF0BNaeq9LuT0pzd
         ggmnWlJidojOQ+Z8rEiRVTpzkbp4kdxwkNT0Gfq1ok9IwxapIuAUqfkf+U8bl5dLdSWO
         geK+NrwLWPmWSW2HgAoo8H0cGil3Sbye35hxH7UWe5XUQxZFsj3i2FI2JFnn32Tzph4p
         9omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0k2zF0O8Dezyoaka8gcKnbwBTdSGFZmQ+t8biXBBv8=;
        b=CdGKEttiLlSCKupWDf2O/v1PRGUM6a2ju4CQKHUoS5j/RraB7OuDr40n4wRnH1G3FZ
         eXAVyDcvIktTbbIA0odpQuRYaaxE8iD/5IJ2LP4Pj7m0VsZaG6Jr27TenKf1EjjK+4b9
         UONIjUffcUMtBXiHtwWN3KertFYgxhAfnooLvKzilDNcETUD+D1O3KjYMiZrh0/bq82n
         6zrtHIbmUPC3Y5OndhxqSZWNOWLSiCXkgjrH+AMFH1atUf49F4j4iV++M4GOjrZtTao+
         vtizgEwY+3ENBRh5RmOsc57RgZZyihHHPtT3ee8unEE9YmPf4qkaOt0LVtS2kwtLtCi/
         kOlg==
X-Gm-Message-State: AJIora9xiUFyXDbTW6uaTxmhKeTBmoxUE65/JSkYaOyUbFkuuD+NXClb
        XD7uKN6R8c7tE9XNEEUcFbQzqOoLPGXu6Q==
X-Google-Smtp-Source: AGRyM1sIbpzlmiS9zsskabWHGbfryL4HVDQDigEE04LOQyCLAEE7/1SrUZyDebD8oIhYu2Vn52Vb1w==
X-Received: by 2002:a05:6000:1841:b0:21b:bf66:62b7 with SMTP id c1-20020a056000184100b0021bbf6662b7mr13661264wri.111.1657484877208;
        Sun, 10 Jul 2022 13:27:57 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2e4000d7544521133919bb.dip0.t-ipconnect.de. [2003:cf:9f2e:4000:d754:4521:1339:19bb])
        by smtp.googlemail.com with ESMTPSA id o9-20020a05600c4fc900b003a2e51bbbb8sm2566021wmq.30.2022.07.10.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 13:27:56 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Urs Schroffenegger <nabajour@lampshade.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (asus-ec-sensors) add definitions for ROG ZENITH II EXTREME
Date:   Sun, 10 Jul 2022 22:26:39 +0200
Message-Id: <20220710202639.1812058-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220710202639.1812058-1-eugene.shalygin@gmail.com>
References: <20220710202639.1812058-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Urs Schroffenegger <nabajour@lampshade.ch>

Add definitions for ROG ZENITH II EXTREME and some unknown yet
temperature sensors in the second EC bank. Details are available at
[1, 2].

[1] https://github.com/zeule/asus-ec-sensors/pull/26
[2] https://github.com/zeule/asus-ec-sensors/issues/16

Signed-off-by: Urs Schroffenegger <nabajour@lampshade.ch>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 47 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 1e40c123db77..02f4ad314a1e 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -22,6 +22,7 @@ Supported boards:
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
+ * ROG ZENITH II EXTREME
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 625c2baa35ec..3049537130be 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -56,6 +56,8 @@ static char *mutex_path_override;
 
 #define ASUS_HW_ACCESS_MUTEX_RMTW_ASMX	"\\RMTW.ASMX"
 
+#define ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0 "\\_SB_.PCI0.SBRG.SIO1.MUT0"
+
 #define MAX_IDENTICAL_BOARD_VARIATIONS	3
 
 /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
@@ -121,6 +123,18 @@ enum ec_sensors {
 	ec_sensor_temp_water_in,
 	/* "Water_Out" temperature sensor reading [℃] */
 	ec_sensor_temp_water_out,
+	/* "Water_Block_In" temperature sensor reading [℃] */
+	ec_sensor_temp_water_block_in,
+	/* "Water_Block_Out" temperature sensor reading [℃] */
+	ec_sensor_temp_water_block_out,
+	/* "T_sensor_2" temperature sensor reading [℃] */
+	ec_sensor_temp_t_sensor_2,
+	/* "Extra_1" temperature sensor reading [℃] */
+	ec_sensor_temp_sensor_extra_1,
+	/* "Extra_2" temperature sensor reading [℃] */
+	ec_sensor_temp_sensor_extra_2,
+	/* "Extra_3" temperature sensor reading [℃] */
+	ec_sensor_temp_sensor_extra_3,
 };
 
 #define SENSOR_TEMP_CHIPSET BIT(ec_sensor_temp_chipset)
@@ -136,6 +150,12 @@ enum ec_sensors {
 #define SENSOR_CURR_CPU BIT(ec_sensor_curr_cpu)
 #define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
+#define SENSOR_TEMP_WATER_BLOCK_IN BIT(ec_sensor_temp_water_block_in)
+#define SENSOR_TEMP_WATER_BLOCK_OUT BIT(ec_sensor_temp_water_block_out)
+#define SENSOR_TEMP_T_SENSOR_2 BIT(ec_sensor_temp_t_sensor_2)
+#define SENSOR_TEMP_SENSOR_EXTRA_1 BIT(ec_sensor_temp_sensor_extra_1)
+#define SENSOR_TEMP_SENSOR_EXTRA_2 BIT(ec_sensor_temp_sensor_extra_2)
+#define SENSOR_TEMP_SENSOR_EXTRA_3 BIT(ec_sensor_temp_sensor_extra_3)
 
 enum board_family {
 	family_unknown,
@@ -199,6 +219,18 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
 		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
 	[ec_sensor_temp_water_out] =
 		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+	[ec_sensor_temp_water_block_in] =
+		EC_SENSOR("Water_Block_In", hwmon_temp, 1, 0x01, 0x02),
+	[ec_sensor_temp_water_block_out] =
+		EC_SENSOR("Water_Block_Out", hwmon_temp, 1, 0x01, 0x03),
+	[ec_sensor_temp_sensor_extra_1] =
+		EC_SENSOR("Extra_1", hwmon_temp, 1, 0x01, 0x09),
+	[ec_sensor_temp_t_sensor_2] =
+		EC_SENSOR("T_sensor_2", hwmon_temp, 1, 0x01, 0x0a),
+	[ec_sensor_temp_sensor_extra_2] =
+		EC_SENSOR("Extra_2", hwmon_temp, 1, 0x01, 0x0b),
+	[ec_sensor_temp_sensor_extra_3] =
+		EC_SENSOR("Extra_3", hwmon_temp, 1, 0x01, 0x0c),
 };
 
 static const struct ec_sensor_info sensors_family_intel_300[] = {
@@ -231,6 +263,9 @@ static const struct ec_sensor_info sensors_family_intel_600[] = {
 #define SENSOR_SET_TEMP_CHIPSET_CPU_MB                                         \
 	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
 #define SENSOR_SET_TEMP_WATER (SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT)
+#define SENSOR_SET_WATER_BLOCK                                                 \
+	(SENSOR_TEMP_WATER_BLOCK_IN | SENSOR_TEMP_WATER_BLOCK_OUT)
+
 
 struct ec_board_info {
 	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
@@ -378,6 +413,18 @@ static const struct ec_board_info board_info[] = {
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
 		.family = family_intel_600_series,
 	},
+	{
+		.board_names = {"ROG ZENITH II EXTREME"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET | SENSOR_FAN_VRM_HS |
+			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE |
+			SENSOR_SET_WATER_BLOCK |
+			SENSOR_TEMP_T_SENSOR_2 | SENSOR_TEMP_SENSOR_EXTRA_1 |
+			SENSOR_TEMP_SENSOR_EXTRA_2 | SENSOR_TEMP_SENSOR_EXTRA_3,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+		.family = family_amd_500_series,
+	},
 	{}
 };
 
-- 
2.35.1

