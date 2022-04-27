Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2404F511AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiD0Odi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiD0Od2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:33:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BDCF55;
        Wed, 27 Apr 2022 07:30:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x18so2824180wrc.0;
        Wed, 27 Apr 2022 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPY2RBBUppVq+Xf2lJAMzWiZhBUTz4JXi2Mn7VuYgDk=;
        b=V8KSLPIDC34vdohlTmGNIuA4UeObNlpS/2W7QL64/5Xe0U8LpKsHdNHUvojwDO/Qj3
         ohcvLkJrSsoG2iuWDlR4NvsuVLh+P90jujELwq5K7JIoL60cm6y+K4CEp+sA45BRLmdL
         VMFP0O6OQlW010sFVKqmZP3lH7KndZ8V8fQP/7sg5M47YsV8unWVSu7wSCauOe5mvZka
         K//b1MPAEGTO3dsqEeazMly+8spc0kQzXaNPEXLmu8RxDPvnK6jvMwhuazsEOuk7R8NH
         Ya5K1c+ueYy/VGU6eM4A2ibMaK3w7MmTcZD7du2oPVn0/DGSK6Nn1RKpGzN0dTKoWPfG
         g7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPY2RBBUppVq+Xf2lJAMzWiZhBUTz4JXi2Mn7VuYgDk=;
        b=DYtHqw4K3sdfsmplhpixtrGD7CDQCGt0PXFa6ZivwFP3YwaCT6MAwQm7sovKh3v4D3
         johgf8rGftECKb2scUnPRHkWABRbFzPhtS9peeZRhoM/S0dv+T8cLyLGAEKgjzedkO2x
         o/KoklFR18vuNb1Ia69Gtp2ikETOUNWWf47/W6E3qXw9TI0JAGhgDLB5cAfLDgf7z+c5
         0n/zigaY+UruvO85bWu3OlJyMX9EiDdAhgHCprxiBSGTwF2ViHJGKhr9mhGIAnBuudHw
         czHxc5s7K0Y4nrRRPmaSZUlQwDiIBcNrcphrUyWCqUm23OLVabiWpMy1VKsXTos++imW
         BZDw==
X-Gm-Message-State: AOAM533z4humbuLr3g0pQ0mM3kI1yHesOxiNh89a5+uvTfdskAaEpEiW
        GB6onMXyYf3PETsjpDvUHAc=
X-Google-Smtp-Source: ABdhPJz2amJedm0h+S7JpXD+Kc8SX2VdJlRXZ3JKH/eX/OK+uO3CBy6zAkhwBu58H8Ain8SogvqYIA==
X-Received: by 2002:a5d:620f:0:b0:20a:d560:9996 with SMTP id y15-20020a5d620f000000b0020ad5609996mr16506884wru.471.1651069812972;
        Wed, 27 Apr 2022 07:30:12 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id i14-20020a1c540e000000b00393dc91e9c9sm1721625wmb.17.2022.04.27.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:30:12 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] hwmon: (asus-ec-sensors) implement locking via the ACPI global lock
Date:   Wed, 27 Apr 2022 16:29:59 +0200
Message-Id: <20220427143001.1443605-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some board models ASUS uses the global ACPI lock to guard access to
the hardware, so do we.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |   2 +
 drivers/hwmon/asus-ec-sensors.c         | 125 +++++++++++++++++++-----
 2 files changed, 101 insertions(+), 26 deletions(-)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index b3469851ab9a..36ca531d32dd 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -53,3 +53,5 @@ Module Parameters
 		the path is mostly identical for them). If ASUS changes this path
 		in a future BIOS update, this parameter can be used to override
 		the stored in the driver value until it gets updated.
+		A special string ":GLOBAL_LOCK" can be passed to use the ACPI
+		global lock instead of a dedicated mutex.
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 0c82723f85b5..581df4053060 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -56,6 +56,9 @@ static char *mutex_path_override;
 
 #define MAX_IDENTICAL_BOARD_VARIATIONS	2
 
+/* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
+#define ACPI_GLOBAL_LOCK_PSEUDO_PATH	":GLOBAL_LOCK"
+
 typedef union {
 	u32 value;
 	struct {
@@ -166,6 +169,14 @@ static const struct ec_sensor_info known_ec_sensors[] = {
 struct ec_board_info {
 	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
 	unsigned long sensors;
+	/*
+	 * Defines which mutex to use for guarding access to the state and the
+	 * hardware. Can be either a full path to an AML mutex or the
+	 * pseudo-path ACPI_GLOBAL_LOCK_PSEUDO_PATH to use the global ACPI lock,
+	 * or left empty to use a regular mutex object, in which case access to
+	 * the hardware is not guarded.
+	 */
+	const char *mutex_path;
 };
 
 static const struct ec_board_info board_info[] = {
@@ -173,6 +184,7 @@ static const struct ec_board_info board_info[] = {
 		.board_names = {"PRIME X570-PRO"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ProArt X570-CREATOR WIFI"},
@@ -185,6 +197,7 @@ static const struct ec_board_info board_info[] = {
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
@@ -193,6 +206,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
@@ -200,6 +214,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {
@@ -212,6 +227,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
@@ -219,12 +235,14 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG STRIX B550-E GAMING"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CPU_OPT,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG STRIX B550-I GAMING"},
@@ -232,6 +250,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG STRIX X570-E GAMING"},
@@ -239,17 +258,20 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG STRIX X570-F GAMING"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG STRIX X570-I GAMING"},
 		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{}
 };
@@ -259,6 +281,46 @@ struct ec_sensor {
 	s32 cached_value;
 };
 
+struct lock_data {
+	union {
+		acpi_handle aml;
+		/* global lock handle */
+		u32 glk;
+	} mutex;
+	bool (*lock)(struct lock_data *data);
+	bool (*unlock)(struct lock_data *data);
+};
+
+/*
+ * The next function pairs implement options for locking access to the
+ * state and the EC
+ */
+static bool lock_via_acpi_mutex(struct lock_data *data)
+{
+	/*
+	 * ASUS DSDT does not specify that access to the EC has to be guarded,
+	 * but firmware does access it via ACPI
+	 */
+	return ACPI_SUCCESS(acpi_acquire_mutex(data->mutex.aml,
+					       NULL, ACPI_LOCK_DELAY_MS));
+}
+
+static bool unlock_acpi_mutex(struct lock_data *data)
+{
+	return ACPI_SUCCESS(acpi_release_mutex(data->mutex.aml, NULL));
+}
+
+static bool lock_via_global_acpi_lock(struct lock_data *data)
+{
+	return ACPI_SUCCESS(acpi_acquire_global_lock(ACPI_LOCK_DELAY_MS,
+						     &data->mutex.glk));
+}
+
+static bool unlock_global_acpi_lock(struct lock_data *data)
+{
+	return ACPI_SUCCESS(acpi_release_global_lock(data->mutex.glk));
+}
+
 struct ec_sensors_data {
 	const struct ec_board_info *board_info;
 	struct ec_sensor *sensors;
@@ -269,7 +331,7 @@ struct ec_sensors_data {
 	u8 banks[ASUS_EC_MAX_BANK + 1];
 	/* in jiffies */
 	unsigned long last_updated;
-	acpi_handle aml_mutex;
+	struct lock_data lock_data;
 	/* number of board EC sensors */
 	u8 nr_sensors;
 	/*
@@ -373,23 +435,36 @@ static void __init fill_ec_registers(struct ec_sensors_data *ec)
 	}
 }
 
-static acpi_handle __init asus_hw_access_mutex(struct device *dev)
+static int __init setup_lock_data(struct device *dev)
 {
 	const char *mutex_path;
-	acpi_handle res;
 	int status;
+	struct ec_sensors_data *state = dev_get_drvdata(dev);
 
 	mutex_path = mutex_path_override ?
-		mutex_path_override : ASUS_HW_ACCESS_MUTEX_ASMX;
+		mutex_path_override : state->board_info->mutex_path;
 
-	status = acpi_get_handle(NULL, (acpi_string)mutex_path, &res);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev,
-			"Could not get hardware access guard mutex '%s': error %d",
-			mutex_path, status);
-		return NULL;
+	if (!mutex_path || !strlen(mutex_path)) {
+		dev_err(dev, "Hardware access guard mutex name is empty");
+		return -EINVAL;
 	}
-	return res;
+	if (!strcmp(mutex_path, ACPI_GLOBAL_LOCK_PSEUDO_PATH)) {
+		state->lock_data.mutex.glk = 0;
+		state->lock_data.lock = lock_via_global_acpi_lock;
+		state->lock_data.unlock = unlock_global_acpi_lock;
+	} else {
+		status = acpi_get_handle(NULL, (acpi_string)mutex_path,
+					 &state->lock_data.mutex.aml);
+		if (ACPI_FAILURE(status)) {
+			dev_err(dev,
+				"Failed to get hardware access guard AML mutex '%s': error %d",
+				mutex_path, status);
+			return -ENOENT;
+		}
+		state->lock_data.lock = lock_via_acpi_mutex;
+		state->lock_data.unlock = unlock_acpi_mutex;
+	}
+	return 0;
 }
 
 static int asus_ec_bank_switch(u8 bank, u8 *old)
@@ -492,15 +567,9 @@ static int update_ec_sensors(const struct device *dev,
 {
 	int status;
 
-	/*
-	 * ASUS DSDT does not specify that access to the EC has to be guarded,
-	 * but firmware does access it via ACPI
-	 */
-	if (ACPI_FAILURE(acpi_acquire_mutex(ec->aml_mutex, NULL,
-					    ACPI_LOCK_DELAY_MS))) {
-		dev_err(dev, "Failed to acquire AML mutex");
-		status = -EBUSY;
-		goto cleanup;
+	if (!ec->lock_data.lock(&ec->lock_data)) {
+		dev_warn(dev, "Failed to acquire mutex");
+		return -EBUSY;
 	}
 
 	status = asus_ec_block_read(dev, ec);
@@ -508,10 +577,10 @@ static int update_ec_sensors(const struct device *dev,
 	if (!status) {
 		update_sensor_values(ec, ec->read_buffer);
 	}
-	if (ACPI_FAILURE(acpi_release_mutex(ec->aml_mutex, NULL))) {
-		dev_err(dev, "Failed to release AML mutex");
-	}
-cleanup:
+
+	if (!ec->lock_data.unlock(&ec->lock_data))
+		dev_err(dev, "Failed to release mutex");
+
 	return status;
 }
 
@@ -651,6 +720,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	enum hwmon_sensor_types type;
 	struct device *hwdev;
 	unsigned int i;
+	int status;
 
 	pboard_info = get_board_info();
 	if (!pboard_info)
@@ -667,6 +737,11 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
 					sizeof(struct ec_sensor), GFP_KERNEL);
 
+	status = setup_lock_data(dev);
+	if (status) {
+		dev_err(dev, "Failed to setup state/EC locking: %d", status);
+		return status;
+	}
 	setup_sensor_data(ec_data);
 	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
 					  sizeof(u16), GFP_KERNEL);
@@ -678,8 +753,6 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
 	fill_ec_registers(ec_data);
 
-	ec_data->aml_mutex = asus_hw_access_mutex(dev);
-
 	for (i = 0; i < ec_data->nr_sensors; ++i) {
 		si = get_sensor_info(ec_data, i);
 		if (!nr_count[si->type])
-- 
2.35.1

