Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3B589C4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiHDNKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiHDNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:10:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DE3B7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:10:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c22so10281603wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cla0lM4BldOpdb6hEqlLWVngdnoWs3axmUG8txIxp54=;
        b=IJrM87wbpGCvXj70KwixdInKdcktY/525oInwlXZaqH3/HWmLnQHPLGgV+IzGKCQLD
         qaD0iwZSqgD09TxvOOWc3+rvefb0CTTt6K0PGyuhVFHolhiaIFpR00ot+3GsmOjrlElz
         V2o1Pi8oxEDLoiCoDc5z31p+P2foC+McHOht/KSu3FHsuV/idbm47AWTqHW0Tf/zJi7m
         t+yBUQfVe7YlI/5q6UsvrzgV9shJKZ/GA0R+dfw3mnhCDlNDHA2wnb1x7tP5w6N+IRDQ
         Yc0gXiSxBA24lnN4Pt9ygruZrDJMZ0gxwD0zvBg9PvZ96yZxfA7nDCEWh8EownBGPOIk
         Lq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cla0lM4BldOpdb6hEqlLWVngdnoWs3axmUG8txIxp54=;
        b=a49+iYjUnkekLIjU1JykgMZCsFQIBbGAGo1MyzradFXIzHrTO3UH9q4IxywxYCXy4Z
         G/EQ1w/Q4GqLUCYjauefPyvETuw0iB0ApE4ScNiFMcMXvfX8ef0OqKcEgNmPQFoih1Be
         Pp+je4M7Zi+z92nlNSSZf63pvlGin9H7RGp4mUCMBPnp97L5OOFsROxZ3ho35iuVkSas
         Hbpmq/RbpvuKPbJD/qGAQVgGq0KoI+xbCNfbG15MsvcOc7O2KhL5wgw6UITbbinA3yYO
         pQiPer0njxXqb9dkBHyGP3rMKtrlVcbz3hi71WFFy/n3zJDTuL473xPUY1hYFMEjAPou
         e5lA==
X-Gm-Message-State: ACgBeo379X6Y1yMDC7BYzUslU3ipyLKi0l/QJMeZgHQrYnvbi93AhhX1
        Tahedtf7ZWGCssuqtDn3QmmGyQ==
X-Google-Smtp-Source: AA6agR4FHom/Hb5zs4LT+11P8Qnc2UjkasWQfOka/HpKPxrvCMFaQXG6iQpiiTxD44HRyTYVlSeb9Q==
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr6193299wmq.58.1659618609259;
        Thu, 04 Aug 2022 06:10:09 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.. (235.163.185.81.rev.sfr.net. [81.185.163.235])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm1156817wrj.47.2022.08.04.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:10:08 -0700 (PDT)
From:   bchihi@baylibre.com
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8.1, 7/7] thermal: mediatek: Add thermal zone settings for mt8195
Date:   Thu,  4 Aug 2022 15:09:12 +0200
Message-Id: <20220804130912.676043-8-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220804130912.676043-1-bchihi@baylibre.com>
References: <20220804130912.676043-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Add thermal zone settings for mt8195

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.h |   1 +
 drivers/thermal/mediatek/lvts_v4.c      | 223 ++++++++++++++++++++++++
 2 files changed, 224 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.h b/drivers/thermal/mediatek/lvts_thermal.h
index 9095f9cd232b..4db2c135661e 100644
--- a/drivers/thermal/mediatek/lvts_thermal.h
+++ b/drivers/thermal/mediatek/lvts_thermal.h
@@ -16,6 +16,7 @@
 #define FEATURE_DEVICE_AUTO_RCK	BIT(0)
 #define NUM_EFUSE_ADDR			22
 #define NUM_EFUSE_BLOCK_MT8192	1
+#define NUM_EFUSE_BLOCK_MT8195	2
 #define DEFAULT_GOLDEN_TEMP		50
 #define DEFAULT_CUONT_R			35000
 #define DEFAULT_CUONT_RC		2750
diff --git a/drivers/thermal/mediatek/lvts_v4.c b/drivers/thermal/mediatek/lvts_v4.c
index 6477d386c9e1..e216b66625db 100644
--- a/drivers/thermal/mediatek/lvts_v4.c
+++ b/drivers/thermal/mediatek/lvts_v4.c
@@ -32,6 +32,31 @@ enum mt8192_lvts_ap_sensor_enum {
 	MT8192_NUM_TS_AP
 };
 
+enum mt8195_lvts_mcu_sensor_enum {
+	MT8195_TS1_0,		// cpu_big1
+	MT8195_TS1_1,		// cpu_big2
+	MT8195_TS2_0,		// cpu_big3
+	MT8195_TS2_1,		// cpu_big4
+	MT8195_TS3_0,		// cpu_little1
+	MT8195_TS3_1,		// cpu_little2
+	MT8195_TS3_2,		// cpu_little3
+	MT8195_TS3_3,		// cpu_little4
+	MT8195_NUM_TS_MCU
+};
+
+enum mt8195_lvts_ap_sensor_enum {
+	MT8195_TS4_0,		// vpu1
+	MT8195_TS4_1,		// vpu2
+	MT8195_TS5_0,		// gpu1
+	MT8195_TS5_1,		// gpu2
+	MT8195_TS6_0,		// vdec
+	MT8195_TS6_1,		// img
+	MT8195_TS6_2,		// infra
+	MT8195_TS7_0,		// cam1
+	MT8195_TS7_1,		// cam2
+	MT8195_NUM_TS_AP
+};
+
 static void mt8192_mcu_efuse_to_cal_data(struct lvts_data *lvts_data)
 {
 	const unsigned int mt8192_ts[] = { MT8192_TS2_0, MT8192_TS3_0 };
@@ -74,6 +99,60 @@ static void mt8192_ap_efuse_to_cal_data(struct lvts_data *lvts_data)
 	}
 }
 
+static void mt8195_mcu_efuse_to_cal_data(struct lvts_data *lvts_data)
+{
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+
+	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
+
+	cal_data->count_r[MT8195_TS1_0] = GET_CAL_DATA_BITMASK(1, lvts_data, 23, 0);
+	cal_data->count_r[MT8195_TS1_1] = (GET_CAL_DATA_BITMASK(2, lvts_data, 15, 0) << 8) +
+		GET_CAL_DATA_BITMASK(1, lvts_data, 31, 24);
+	cal_data->count_r[MT8195_TS2_0] = GET_CAL_DATA_BITMASK(3, lvts_data, 31, 8);
+	cal_data->count_r[MT8195_TS2_1] = GET_CAL_DATA_BITMASK(4, lvts_data, 23, 0);
+	cal_data->count_r[MT8195_TS3_0] = (GET_CAL_DATA_BITMASK(6, lvts_data, 7, 0) << 16) +
+		GET_CAL_DATA_BITMASK(5, lvts_data, 31, 16);
+	cal_data->count_r[MT8195_TS3_1] = GET_CAL_DATA_BITMASK(6, lvts_data, 31, 8);
+	cal_data->count_r[MT8195_TS3_2] = GET_CAL_DATA_BITMASK(7, lvts_data, 23, 0);
+	cal_data->count_r[MT8195_TS3_3] = (GET_CAL_DATA_BITMASK(8, lvts_data, 15, 0) << 8) +
+		GET_CAL_DATA_BITMASK(7, lvts_data, 31, 24);
+
+	cal_data->count_rc[MT8195_TS1_0] = (GET_CAL_DATA_BITMASK(3, lvts_data, 7, 0) << 16) +
+		GET_CAL_DATA_BITMASK(2, lvts_data, 31, 16);
+	cal_data->count_rc[MT8195_TS2_0] = (GET_CAL_DATA_BITMASK(5, lvts_data, 15, 0) << 8) +
+		GET_CAL_DATA_BITMASK(4, lvts_data, 31, 24);
+	cal_data->count_rc[MT8195_TS3_0] = (GET_CAL_DATA_BITMASK(9, lvts_data, 7, 0) << 16) +
+		GET_CAL_DATA_BITMASK(8, lvts_data, 31, 16);
+}
+
+static void mt8195_ap_efuse_to_cal_data(struct lvts_data *lvts_data)
+{
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+
+	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
+
+	cal_data->count_r[MT8195_TS4_0] = GET_CAL_DATA_BITMASK(9, lvts_data, 31, 8);
+	cal_data->count_r[MT8195_TS4_1] = GET_CAL_DATA_BITMASK(10, lvts_data, 23, 0);
+	cal_data->count_r[MT8195_TS5_0] = (GET_CAL_DATA_BITMASK(12, lvts_data, 7, 0) << 16) +
+		GET_CAL_DATA_BITMASK(11, lvts_data, 31, 16);
+	cal_data->count_r[MT8195_TS5_1] = GET_CAL_DATA_BITMASK(12, lvts_data, 31, 8);
+	cal_data->count_r[MT8195_TS6_0] = (GET_CAL_DATA_BITMASK(14, lvts_data, 15, 0) << 8) +
+		GET_CAL_DATA_BITMASK(13, lvts_data, 31, 24);
+	cal_data->count_r[MT8195_TS6_1] = (GET_CAL_DATA_BITMASK(15, lvts_data, 7, 0) << 16) +
+		GET_CAL_DATA_BITMASK(14, lvts_data, 31, 16);
+	cal_data->count_r[MT8195_TS6_2] = GET_CAL_DATA_BITMASK(15, lvts_data, 31, 8);
+	cal_data->count_r[MT8195_TS7_0] = (GET_CAL_DATA_BITMASK(17, lvts_data, 15, 0) << 8) +
+		GET_CAL_DATA_BITMASK(16, lvts_data, 31, 24);
+	cal_data->count_r[MT8195_TS7_1] = (GET_CAL_DATA_BITMASK(18, lvts_data, 7, 0) << 16) +
+		GET_CAL_DATA_BITMASK(17, lvts_data, 31, 16);
+
+	cal_data->count_rc[MT8195_TS4_0] = (GET_CAL_DATA_BITMASK(11, lvts_data, 15, 0) << 8) +
+						GET_CAL_DATA_BITMASK(10, lvts_data, 31, 24);
+	cal_data->count_rc[MT8195_TS5_0] = GET_CAL_DATA_BITMASK(13, lvts_data, 23, 0);
+	cal_data->count_rc[MT8195_TS6_0] = GET_CAL_DATA_BITMASK(16, lvts_data, 23, 0);
+	cal_data->count_rc[MT8195_TS7_0] = GET_CAL_DATA_BITMASK(18, lvts_data, 31, 8);
+}
+
 static struct lvts_speed_settings tc_speed_mt8192 = {
 	.period_unit = PERIOD_UNIT,
 	.group_interval_delay = GROUP_INTERVAL_DELAY,
@@ -81,6 +160,13 @@ static struct lvts_speed_settings tc_speed_mt8192 = {
 	.sensor_interval_delay = SENSOR_INTERVAL_DELAY,
 };
 
+static struct lvts_speed_settings tc_speed_mt8195 = {
+	.period_unit = PERIOD_UNIT,
+	.group_interval_delay = GROUP_INTERVAL_DELAY,
+	.filter_interval_delay = FILTER_INTERVAL_DELAY,
+	.sensor_interval_delay = SENSOR_INTERVAL_DELAY,
+};
+
 static const struct lvts_tc_settings mt8192_tc_mcu_settings[] = {
 	[0] = {
 		.dev_id = 0x81,
@@ -164,6 +250,89 @@ static const struct lvts_tc_settings mt8192_tc_ap_settings[] = {
 	}
 };
 
+static const struct lvts_tc_settings mt8195_tc_mcu_settings[] = {
+	[0] = {
+		.dev_id = 0x81,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = { MT8195_TS1_0, MT8195_TS1_1 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(3),
+	},
+	[1] = {
+		.dev_id = 0x82,
+		.addr_offset = 0x100,
+		.num_sensor = 2,
+		.sensor_map = { MT8195_TS2_0, MT8195_TS2_1 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(4),
+	},
+	[2] = {
+		.dev_id = 0x83,
+		.addr_offset = 0x200,
+		.num_sensor = 4,
+		.sensor_map = { MT8195_TS3_0, MT8195_TS3_1, MT8195_TS3_2, MT8195_TS3_3 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(5),
+	}
+};
+
+static const struct lvts_tc_settings mt8195_tc_ap_settings[] = {
+	[0] = {
+		.dev_id = 0x84,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = { MT8195_TS4_0, MT8195_TS4_1 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(3),
+	},
+	[1] = {
+		.dev_id = 0x85,
+		.addr_offset = 0x100,
+		.num_sensor = 2,
+		.sensor_map = { MT8195_TS5_0, MT8195_TS5_1 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(4),
+	},
+	[2] = {
+		.dev_id = 0x86,
+		.addr_offset = 0x200,
+		.num_sensor = 3,
+		.sensor_map = { MT8195_TS6_0, MT8195_TS6_1, MT8195_TS6_2 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(5),
+	},
+	[3] = {
+		.dev_id = 0x87,
+		.addr_offset = 0x300,
+		.num_sensor = 2,
+		.sensor_map = { MT8195_TS7_0, MT8195_TS7_1 },
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(6),
+	}
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.num_tc = (ARRAY_SIZE(mt8192_tc_mcu_settings)),
 	.tc = mt8192_tc_mcu_settings,
@@ -216,9 +385,63 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	},
 };
 
+static const struct lvts_data mt8195_lvts_mcu_data = {
+	.num_tc = (ARRAY_SIZE(mt8195_tc_mcu_settings)),
+	.tc = mt8195_tc_mcu_settings,
+	.num_sensor = MT8195_NUM_TS_MCU,
+	.ops = {
+		.efuse_to_cal_data = mt8195_mcu_efuse_to_cal_data,
+		.device_enable_and_init = lvts_device_enable_and_init,
+		.device_enable_auto_rck = lvts_device_enable_auto_rck_v4,
+		.device_read_count_rc_n = lvts_device_read_count_rc_n_v4,
+		.set_cal_data = lvts_set_calibration_data_v4,
+		.init_controller = lvts_init_controller_v4,
+	},
+	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
+	.num_efuse_addr = NUM_EFUSE_ADDR,
+	.num_efuse_block = NUM_EFUSE_BLOCK_MT8195,
+	.cal_data = {
+		.default_golden_temp = DEFAULT_GOLDEN_TEMP,
+		.default_count_r = DEFAULT_CUONT_R,
+		.default_count_rc = DEFAULT_CUONT_RC,
+	},
+	.coeff = {
+		.a = COEFF_A,
+		.b = COEFF_B,
+	},
+};
+
+static const struct lvts_data mt8195_lvts_ap_data = {
+	.num_tc = (ARRAY_SIZE(mt8195_tc_ap_settings)),
+	.tc = mt8195_tc_ap_settings,
+	.num_sensor = MT8195_NUM_TS_AP,
+	.ops = {
+		.efuse_to_cal_data = mt8195_ap_efuse_to_cal_data,
+		.device_enable_and_init = lvts_device_enable_and_init,
+		.device_enable_auto_rck = lvts_device_enable_auto_rck_v4,
+		.device_read_count_rc_n = lvts_device_read_count_rc_n_v4,
+		.set_cal_data = lvts_set_calibration_data_v4,
+		.init_controller = lvts_init_controller_v4,
+	},
+	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
+	.num_efuse_addr = NUM_EFUSE_ADDR,
+	.num_efuse_block = NUM_EFUSE_BLOCK_MT8195,
+	.cal_data = {
+		.default_golden_temp = DEFAULT_GOLDEN_TEMP,
+		.default_count_r = DEFAULT_CUONT_R,
+		.default_count_rc = DEFAULT_CUONT_RC,
+	},
+	.coeff = {
+		.a = COEFF_A,
+		.b = COEFF_B,
+	},
+};
+
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data, },
 	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data, },
+	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data, },
+	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lvts_of_match);
-- 
2.34.1

