Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529454E87AA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiC0MRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiC0MQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:16:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BD37A06;
        Sun, 27 Mar 2022 05:15:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p15so23469654ejc.7;
        Sun, 27 Mar 2022 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WldFtAHd8wTe30jg8gERDP/O6DG4ckMHTfgNZOG6XQ=;
        b=hPUt2lsbPYshz9HpUnwntZkZyULLp9hLfdILfFYHqCAX72e972isNiR6cCJ5SHDTcR
         nvSRK2CqOh5kllw88dBOx/fuvKeYLvIqfVTUBaGnkOhkGLIgbOdrhOiBv3JBogCAxH82
         3jVWIhnq2dqP+c3PiwrHbbc/T6TedNk0Gf+CVuYpZGykE+vWcj9thViMxW0UFieCYHB3
         QqBsEb/qVOAqKUNzneFtJNSGba259oilZFssmdRA0fl0kIhErdGy1r5xAC2l0tuqqlX8
         81z2NPvXuvkpdUNtHdaRUJNySTgIN51IxJhQJSJ7xBOE6vc4FsMtbSBr9qtjCINnmCDE
         7fXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WldFtAHd8wTe30jg8gERDP/O6DG4ckMHTfgNZOG6XQ=;
        b=Gs+2wmW+CWXzASM4x/qEPpRvTKRg0jaMnKts7u+yBlveLNd22ZXJ5YdyexOiOVC1n2
         +wflV5B6q9jMB17ofdfyO2urV+tWbqj0lDaLJ1XWRAYGNb0WmM+eSkYZTO1Pkn9oJ4OG
         wfHXmeNMYfBWSvlGxa7RlAtZlrIFsNMlOtWR5YTMwH+aQ3E24uxKMAvdf20ksi4W7nrz
         2VTa5rWwMazWedAcMxKWTvnvJXrqF8HoviY/IcYLMROZte90rZpP4neQCV8yA4AJ2rer
         ZuSoyAU8kXp+gBfsi99xLBVNtGl0b00bBZ6EgScq84XaiUECDZXqllA9gi/JYbYNOoTc
         jCLg==
X-Gm-Message-State: AOAM5332Ao/lTA41om96MTMpwGfJjgsH/euCNIaMfhI6Gn62BBT16B2b
        tqQHcPori78f0CB3h+vxFCaU2d3Ky1PrVg==
X-Google-Smtp-Source: ABdhPJxoOZeNLemdMIJnH39zCDm/Ul5LFDyfMUWkJsdNPPLrnuh66Y1R/A+77lL94FS5olXL+OleHA==
X-Received: by 2002:a17:907:6e2a:b0:6db:c440:532b with SMTP id sd42-20020a1709076e2a00b006dbc440532bmr22002697ejc.95.1648383309005;
        Sun, 27 Mar 2022 05:15:09 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f06c2008407e4c213cb9d01.dip0.t-ipconnect.de. [2003:cf:9f06:c200:8407:e4c2:13cb:9d01])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm4530127ejc.64.2022.03.27.05.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:15:08 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the ACPI global lock
Date:   Sun, 27 Mar 2022 14:14:02 +0200
Message-Id: <20220327121404.1702631-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
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

For some board models ASUS uses the global ACPI lock to guard access to
the hardware, so do we.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 143 +++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 7e28fc62f717..34841eeb800f 100644
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
 
 static const struct ec_board_info board_info[] __initconst = {
@@ -173,12 +184,14 @@ static const struct ec_board_info board_info[] __initconst = {
 		.board_names = {"PRIME X570-PRO"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"Pro WS X570-ACE"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
@@ -187,6 +200,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
@@ -194,6 +208,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {
@@ -206,6 +221,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
@@ -213,12 +229,14 @@ static const struct ec_board_info board_info[] __initconst = {
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
@@ -226,6 +244,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 	},
 	{
 		.board_names = {"ROG STRIX X570-E GAMING"},
@@ -233,17 +252,20 @@ static const struct ec_board_info board_info[] __initconst = {
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
@@ -253,6 +275,57 @@ struct ec_sensor {
 	s32 cached_value;
 };
 
+struct lock_data {
+	union {
+		acpi_handle aml;
+		u32 global_lock_handle;
+		struct mutex regular;
+	} mutex;
+	int (*lock)(struct lock_data *data);
+	int (*unlock)(struct lock_data *data);
+};
+
+/*
+ * The next function pairs implement options for locking access to the
+ * state and the EC
+ */
+static int lock_via_acpi_mutex(struct lock_data *data)
+{
+	/*
+	 * ASUS DSDT does not specify that access to the EC has to be guarded,
+	 * but firmware does access it via ACPI
+	 */
+	return acpi_acquire_mutex(data->mutex.aml, NULL,
+				  ACPI_LOCK_DELAY_MS);
+}
+
+static int unlock_acpi_mutex(struct lock_data *data)
+{
+	return acpi_release_mutex(data->mutex.aml, NULL);
+}
+
+static int lock_via_global_acpi_lock(struct lock_data *data)
+{
+	return acpi_acquire_global_lock(ACPI_LOCK_DELAY_MS,
+					&data->mutex.global_lock_handle);
+}
+
+static int unlock_global_acpi_lock(struct lock_data *data)
+{
+	return acpi_release_global_lock(data->mutex.global_lock_handle);
+}
+
+static int lock_via_mutex(struct lock_data *data)
+{
+	return mutex_trylock(&data->mutex.regular) ? 0 : -EBUSY;
+}
+
+static int unlock_mutex(struct lock_data *data)
+{
+	mutex_unlock(&data->mutex.regular);
+	return 0;
+}
+
 struct ec_sensors_data {
 	struct ec_board_info board_info;
 	struct ec_sensor *sensors;
@@ -263,7 +336,9 @@ struct ec_sensors_data {
 	u8 banks[ASUS_EC_MAX_BANK + 1];
 	/* in jiffies */
 	unsigned long last_updated;
-	acpi_handle aml_mutex;
+	struct lock_data lock_data;
+	/* number of board EC sensors */
+	u8 nr_sensors;
 	/*
 	 * number of EC registers to read
 	 * (sensor might span more than 1 register)
@@ -370,23 +445,36 @@ static void __init fill_ec_registers(struct ec_sensors_data *ec)
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
-
-	status = acpi_get_handle(NULL, (acpi_string)mutex_path, &res);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev,
-			"Could not get hardware access guard mutex '%s': error %d",
-			mutex_path, status);
-		return NULL;
+		mutex_path_override : state->board_info.mutex_path;
+
+	if (!mutex_path || !strlen(mutex_path)) {
+		mutex_init(&state->lock_data.mutex.regular);
+		state->lock_data.lock = lock_via_mutex;
+		state->lock_data.unlock = unlock_mutex;
+	} else if (!strcmp(mutex_path, ACPI_GLOBAL_LOCK_PSEUDO_PATH)) {
+		state->lock_data.lock = lock_via_global_acpi_lock;
+		state->lock_data.unlock = unlock_global_acpi_lock;
+	} else {
+		status = acpi_get_handle(NULL, (acpi_string)mutex_path,
+					 &state->lock_data.mutex.aml);
+		if (ACPI_FAILURE(status)) {
+			dev_err(dev,
+				"Failed to get hardware access guard AML mutex"
+				"'%s': error %d",
+				mutex_path, status);
+			return -ENOENT;
+		}
+		state->lock_data.lock = lock_via_acpi_mutex;
+		state->lock_data.unlock = unlock_acpi_mutex;
 	}
-	return res;
+	return 0;
 }
 
 static int asus_ec_bank_switch(u8 bank, u8 *old)
@@ -417,7 +505,8 @@ static int asus_ec_block_read(const struct device *dev,
 	if (prev_bank) {
 		/* oops... somebody else is working with the EC too */
 		dev_warn(dev,
-			"Concurrent access to the ACPI EC detected.\nRace condition possible.");
+			"Concurrent access to the ACPI EC detected.\n"
+			"Race condition possible.");
 	}
 
 	/* read registers minimizing bank switches. */
@@ -489,15 +578,9 @@ static int update_ec_sensors(const struct device *dev,
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
+	if (ec->lock_data.lock(&ec->lock_data)) {
+		dev_warn(dev, "Failed to acquire mutex");
+		return -EBUSY;
 	}
 
 	status = asus_ec_block_read(dev, ec);
@@ -505,10 +588,10 @@ static int update_ec_sensors(const struct device *dev,
 	if (!status) {
 		update_sensor_values(ec, ec->read_buffer);
 	}
-	if (ACPI_FAILURE(acpi_release_mutex(ec->aml_mutex, NULL))) {
-		dev_err(dev, "Failed to release AML mutex");
-	}
-cleanup:
+
+	if (ec->lock_data.unlock(&ec->lock_data))
+		dev_err(dev, "Failed to release mutex");
+
 	return status;
 }
 
@@ -648,6 +731,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	enum hwmon_sensor_types type;
 	struct device *hwdev;
 	unsigned int i;
+	int status;
 
 	pboard_info = get_board_info();
 	if (!pboard_info)
@@ -663,6 +747,11 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	ec_data->sensors = devm_kcalloc(dev, sensor_count(&ec_data->board_info),
 					sizeof(struct ec_sensor), GFP_KERNEL);
 
+	status = setup_lock_data(dev);
+	if (status) {
+		dev_err(dev, "Failed to setup state/EC locking: %d", status);
+		return status;
+	}
 	setup_sensor_data(ec_data);
 	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
 					  sizeof(u16), GFP_KERNEL);
@@ -674,8 +763,6 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
 	fill_ec_registers(ec_data);
 
-	ec_data->aml_mutex = asus_hw_access_mutex(dev);
-
 	for (i = 0; i < sensor_count(&ec_data->board_info); ++i) {
 		si = get_sensor_info(ec_data, i);
 		if (!nr_count[si->type])
-- 
2.35.1

