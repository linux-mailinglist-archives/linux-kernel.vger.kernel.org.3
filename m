Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE754E87A4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiC0MQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiC0MQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:16:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E83537A04;
        Sun, 27 Mar 2022 05:15:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yy13so23499195ejb.2;
        Sun, 27 Mar 2022 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFeAdfh+uFFygwIofZUcwHH3/SuesRvoL3kWQMURoiw=;
        b=Kdba1i8MTHZT9fE4eluzcT2H5BDdN8a1zubJUiUsq8USrbeb7+Jl54FIvDezyKWDkX
         WQCkKxiNK9RurYqCv3CZf7crnzHSvrDeoI3+lM/WP84zyKnpjUrBML3UY0/MvNgWF5oG
         9s1vyFwCvFeDDYE3clN1Gj1tC6dtZkcZ0NLWvJkE+Jpg03NUy6x/BrsNNqO1lXz50Lpq
         dA9hLRoANDBlIOOzU0rHy7dMSzK56hJpRypIbX9/me1hMuAtNCmkSawhYwoUOMHN7M7j
         AN1PZNsW+lxg5VNnwqnJCY+X04r+gqascnLnfEK1HL5C5GO+tuzLVU/976tRSI79R2RP
         slLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFeAdfh+uFFygwIofZUcwHH3/SuesRvoL3kWQMURoiw=;
        b=WOFEsAhBABu0JHQvOhIThhadKGTap0YeNnnYKOlMJY22gONgfFLDdauq+69SQUT4Rp
         OYOyfzZAknHojsF5Lp2xVAqh6HmYbVPQ3+YEmYuaKjaNSi9IqNScbS7110NIvpBYy2O5
         UWFXD5lwbwJSBA/V0fmWfTzteTKywrJ2zH1TGeFz9EDtTLsdLwUq9SuWgRB2cWYXmgy+
         I+6LUiWJCJgG3Af8GD3rSXF0ErDpudyjapKuSQ/FI7SxtxqZTL9tDpKIE5wYhX35eA8F
         0jDtocdQsCvv2wQtA1LAVsFrSYG2PW5S5mG5chEZCqYnYhLLmzfWs0GIX4PhX6f0ovkI
         wtAg==
X-Gm-Message-State: AOAM532S8c60sZuOua1CiadxO8fisY1rBl14dXQxbs6gHL0kmbnpHBq9
        YWAC6fo2vJSLZCiwyBDvCBY=
X-Google-Smtp-Source: ABdhPJyV/878GH+ND439D5twggrd/P8IDFTivqpu2GlNIilCFr9W9EBMu1VnIk4tyeR5hTXt76Z5kw==
X-Received: by 2002:a17:906:168f:b0:6df:b4ed:7c49 with SMTP id s15-20020a170906168f00b006dfb4ed7c49mr22006747ejd.36.1648383307600;
        Sun, 27 Mar 2022 05:15:07 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f06c2008407e4c213cb9d01.dip0.t-ipconnect.de. [2003:cf:9f06:c200:8407:e4c2:13cb:9d01])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm4530127ejc.64.2022.03.27.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:15:06 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info struct for board data
Date:   Sun, 27 Mar 2022 14:14:01 +0200
Message-Id: <20220327121404.1702631-2-eugene.shalygin@gmail.com>
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

We need to keep some more information about the current board than just
the sensors set, and with more boards to add the dmi id array grows
quickly. Our probe code is always the same so let's switch to a custom
test code and a custom board info array. That allows us to omit board
vendor string (ASUS uses two strings that differ in case) in the board
info and use case-insensitive comparison, and also do not duplicate
sensor definitions for such board variants as " (WI-FI)" when sensors
are identical to the base variant.

Also saves a quarter of the module size by replacing big dmi_system_id
structs with smaller ones.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 209 ++++++++++++++++++--------------
 1 file changed, 119 insertions(+), 90 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index b5cf0136360c..7e28fc62f717 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -54,8 +54,7 @@ static char *mutex_path_override;
 /* ACPI mutex for locking access to the EC for the firmware */
 #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
 
-/* There are two variants of the vendor spelling */
-#define VENDOR_ASUS_UPPER_CASE	"ASUSTeK COMPUTER INC."
+#define MAX_IDENTICAL_BOARD_VARIATIONS	2
 
 typedef union {
 	u32 value;
@@ -164,68 +163,88 @@ static const struct ec_sensor_info known_ec_sensors[] = {
 	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
 #define SENSOR_SET_TEMP_WATER (SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT)
 
-#define DMI_EXACT_MATCH_BOARD(vendor, name, sensors) {                         \
-	.matches = {                                                           \
-		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, vendor),                     \
-		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),                         \
-	},                                                                     \
-	.driver_data = (void *)(sensors), \
-}
+struct ec_board_info {
+	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
+	unsigned long sensors;
+};
 
-static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "PRIME X570-PRO",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
-		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
-		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
-			      "ROG CROSSHAIR VIII DARK HERO",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
-		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
-			      "ROG CROSSHAIR VIII FORMULA",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG CROSSHAIR VIII HERO",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
-			      "ROG CROSSHAIR VIII HERO (WI-FI)",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
-			      "ROG CROSSHAIR VIII IMPACT",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
-		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-E GAMING",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I GAMING",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
-		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-E GAMING",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
-		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
-		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
-	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
-		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
-		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
+static const struct ec_board_info board_info[] __initconst = {
+	{
+		.board_names = {"PRIME X570-PRO"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+	},
+	{
+		.board_names = {"Pro WS X570-ACE"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR |
+			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
+			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {
+			"ROG CROSSHAIR VIII HERO",
+			"ROG CROSSHAIR VIII HERO (WI-FI)",
+		},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR |
+			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {"ROG STRIX B550-E GAMING"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CPU_OPT,
+	},
+	{
+		.board_names = {"ROG STRIX B550-I GAMING"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {"ROG STRIX X570-E GAMING"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+	},
+	{
+		.board_names = {"ROG STRIX X570-F GAMING"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
+	},
+	{
+		.board_names = {"ROG STRIX X570-I GAMING"},
+		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
+			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+	},
 	{}
 };
 
@@ -235,7 +254,7 @@ struct ec_sensor {
 };
 
 struct ec_sensors_data {
-	unsigned long board_sensors;
+	struct ec_board_info board_info;
 	struct ec_sensor *sensors;
 	/* EC registers to read from */
 	u16 *registers;
@@ -245,8 +264,6 @@ struct ec_sensors_data {
 	/* in jiffies */
 	unsigned long last_updated;
 	acpi_handle aml_mutex;
-	/* number of board EC sensors */
-	u8 nr_sensors;
 	/*
 	 * number of EC registers to read
 	 * (sensor might span more than 1 register)
@@ -281,12 +298,17 @@ get_sensor_info(const struct ec_sensors_data *state, int index)
 	return &known_ec_sensors[state->sensors[index].info_index];
 }
 
+static int sensor_count(const struct ec_board_info *board)
+{
+	return hweight_long(board->sensors);
+}
+
 static int find_ec_sensor_index(const struct ec_sensors_data *ec,
 				enum hwmon_sensor_types type, int channel)
 {
 	unsigned int i;
 
-	for (i = 0; i < ec->nr_sensors; i++) {
+	for (i = 0; i < sensor_count(&ec->board_info); i++) {
 		if (get_sensor_info(ec, i)->type == type) {
 			if (channel == 0)
 				return i;
@@ -301,11 +323,6 @@ static int __init bank_compare(const void *a, const void *b)
 	return *((const s8 *)a) - *((const s8 *)b);
 }
 
-static int __init board_sensors_count(unsigned long sensors)
-{
-	return hweight_long(sensors);
-}
-
 static void __init setup_sensor_data(struct ec_sensors_data *ec)
 {
 	struct ec_sensor *s = ec->sensors;
@@ -316,8 +333,8 @@ static void __init setup_sensor_data(struct ec_sensors_data *ec)
 	ec->nr_banks = 0;
 	ec->nr_registers = 0;
 
-	for_each_set_bit(i, &ec->board_sensors,
-			  BITS_PER_TYPE(ec->board_sensors)) {
+	for_each_set_bit(i, &ec->board_info.sensors,
+			 BITS_PER_TYPE(ec->board_info.sensors)) {
 		s->info_index = i;
 		s->cached_value = 0;
 		ec->nr_registers +=
@@ -343,7 +360,7 @@ static void __init fill_ec_registers(struct ec_sensors_data *ec)
 	const struct ec_sensor_info *si;
 	unsigned int i, j, register_idx = 0;
 
-	for (i = 0; i < ec->nr_sensors; ++i) {
+	for (i = 0; i < sensor_count(&ec->board_info); ++i) {
 		si = get_sensor_info(ec, i);
 		for (j = 0; j < si->addr.components.size; ++j, ++register_idx) {
 			ec->registers[register_idx] =
@@ -457,9 +474,10 @@ static inline s32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
 static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
 {
 	const struct ec_sensor_info *si;
-	struct ec_sensor *s;
+	struct ec_sensor *s, *sensor_end;
 
-	for (s = ec->sensors; s != ec->sensors + ec->nr_sensors; s++) {
+	sensor_end = ec->sensors + sensor_count(&ec->board_info);
+	for (s = ec->sensors; s != sensor_end; s++) {
 		si = &known_ec_sensors[s->info_index];
 		s->cached_value = get_sensor_value(si, data);
 		data += si->addr.components.size;
@@ -597,12 +615,24 @@ static struct hwmon_chip_info asus_ec_chip_info = {
 	.ops = &asus_ec_hwmon_ops,
 };
 
-static unsigned long __init get_board_sensors(void)
+static const struct ec_board_info * __init get_board_info(void)
 {
-	const struct dmi_system_id *dmi_entry =
-		dmi_first_match(asus_ec_dmi_table);
+	const char *dmi_board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	const char *dmi_board_name = dmi_get_system_info(DMI_BOARD_NAME);
+	const struct ec_board_info *board;
+
+	if (!dmi_board_vendor || !dmi_board_name ||
+	    strcasecmp(dmi_board_vendor, "ASUSTeK COMPUTER INC."))
+		return NULL;
+
+	for (board = board_info; board->sensors; board++) {
+		if (match_string(board->board_names,
+				 MAX_IDENTICAL_BOARD_VARIATIONS,
+				 dmi_board_name) >= 0)
+			return board;
+	}
 
-	return dmi_entry ? (unsigned long)dmi_entry->driver_data : 0;
+	return NULL;
 }
 
 static int __init asus_ec_probe(struct platform_device *pdev)
@@ -610,17 +640,17 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	const struct hwmon_channel_info **ptr_asus_ec_ci;
 	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
 	struct hwmon_channel_info *asus_ec_hwmon_chan;
+	const struct ec_board_info *pboard_info;
 	const struct hwmon_chip_info *chip_info;
 	struct device *dev = &pdev->dev;
 	struct ec_sensors_data *ec_data;
 	const struct ec_sensor_info *si;
 	enum hwmon_sensor_types type;
-	unsigned long board_sensors;
 	struct device *hwdev;
 	unsigned int i;
 
-	board_sensors = get_board_sensors();
-	if (!board_sensors)
+	pboard_info = get_board_info();
+	if (!pboard_info)
 		return -ENODEV;
 
 	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
@@ -629,9 +659,8 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, ec_data);
-	ec_data->board_sensors = board_sensors;
-	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
-	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
+	ec_data->board_info = *pboard_info;
+	ec_data->sensors = devm_kcalloc(dev, sensor_count(&ec_data->board_info),
 					sizeof(struct ec_sensor), GFP_KERNEL);
 
 	setup_sensor_data(ec_data);
@@ -647,7 +676,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
 	ec_data->aml_mutex = asus_hw_access_mutex(dev);
 
-	for (i = 0; i < ec_data->nr_sensors; ++i) {
+	for (i = 0; i < sensor_count(&ec_data->board_info); ++i) {
 		si = get_sensor_info(ec_data, i);
 		if (!nr_count[si->type])
 			++nr_types;
@@ -681,7 +710,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	}
 
 	dev_info(dev, "board has %d EC sensors that span %d registers",
-		 ec_data->nr_sensors, ec_data->nr_registers);
+		 sensor_count(&ec_data->board_info), ec_data->nr_registers);
 
 	hwdev = devm_hwmon_device_register_with_info(dev, "asusec",
 						     ec_data, chip_info, NULL);
@@ -703,8 +732,8 @@ static struct platform_driver asus_ec_sensors_platform_driver = {
 	},
 };
 
-MODULE_DEVICE_TABLE(dmi, asus_ec_dmi_table);
 module_platform_driver_probe(asus_ec_sensors_platform_driver, asus_ec_probe);
+MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);
 
 module_param_named(mutex_path, mutex_path_override, charp, 0);
 MODULE_PARM_DESC(mutex_path,
-- 
2.35.1

