Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACCE596B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiHQIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiHQII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:08:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA64D4D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1413556wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vHkwxzsudrVxqicDXKTih8N8OK6yYAZy8EiUAJDQT8Q=;
        b=YfI4beuQw+jEoemgIqC3NHoOTNGC3jQjNRXPWRKpuUH9Iy4PU7MMuNez09OlH/EqS8
         Ohff2URi0/UwNiDPw1rgUEVoUrfct3DrmCxd6T4CbnIcunTkVp9xaADR+Ox6YFOYtLIJ
         MXXC1iqYgVTC0LUUrgq16c7n33WyQ/qA8C30DLNZ16Exlw6SiQQiDy1OPsxHppmFK2bl
         x/GLWrEzqsgLUWg1dhggrnt+7kd4vCtWCeCaXnaieJxKfYV+AmRC/fbPuH31O88sSd5t
         q3jNuFJcCBwT4OwLV2O3sITKwrzxgI8+1vd+ov8TYeguzcl4MNHA4950slApO9r5Gy5f
         Av/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vHkwxzsudrVxqicDXKTih8N8OK6yYAZy8EiUAJDQT8Q=;
        b=lYNb1+z2+b0yofW6qDJJQAdBJswZsuPN+Q07nFnieiKUrBsapWFhCQxGF9nQIe8FWH
         tqEVxwSQnWOYnJ8I57lFs5GqrQFo6CEVvisSpcoI9pnujZdkXQCc19tx65Yk5upqQOQU
         OwMsk3HTk1u0JCsoJpzxCm7e6ta3ESd5mpa5ttclN8zAD9k/iYjWxwiW7p98LX9ARkRF
         RMEzlU3m/7i2JM93e1FleMnR9LDqZqHfelgQDtvjlCWW4fDPI04/iJ8qgLwWbVRlEhig
         /vOgLu3fir24Q/pG3ynnR5RF1SvzhP4PVeNLjHbw2VVxEHI/zQK4P9HKjfxpTeTFbRMm
         3BhQ==
X-Gm-Message-State: ACgBeo0pAjUyOI+5Lm293p9FvQiOfHJqQHKPOEnrRVlSPi1zloqo2JzE
        xShxh5jOQzp3Ive5QlxONDpdDw==
X-Google-Smtp-Source: AA6agR5KjYclAQozdwJI9frY8l6H0O7fXXwcf2KuIsy9jc4oRs04gp7uX7VpcWRR2WV7sSZ885m1Aw==
X-Received: by 2002:a7b:cd14:0:b0:3a5:c5b3:508 with SMTP id f20-20020a7bcd14000000b003a5c5b30508mr1248270wmj.179.1660723733751;
        Wed, 17 Aug 2022 01:08:53 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a54d610e5fsm1391992wmq.26.2022.08.17.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:08:53 -0700 (PDT)
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
Subject: [PATCH v9,7/7] thermal: mediatek: Add LVTS driver settings for mt8195 thermal zones
Date:   Wed, 17 Aug 2022 10:07:57 +0200
Message-Id: <20220817080757.352021-8-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080757.352021-1-bchihi@baylibre.com>
References: <20220817080757.352021-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Add LVTS v4 (Low Voltage Thermal Sensor) driver settings to report junction
temperatures in MediaTek SoC mt8195 and register the maximum temperature
of sensors and each sensor as a thermal zone.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Co-developed-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.h |   1 +
 drivers/thermal/mediatek/lvts_v4.c      | 230 ++++++++++++++++++++++++
 2 files changed, 231 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.h b/drivers/thermal/mediatek/lvts_thermal.h
index a94ce46acccd..059b1eb98b1c 100644
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
index 3dc00d2589f9..41473312b644 100644
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
@@ -171,6 +257,96 @@ static const struct lvts_tc_settings mt8192_tc_ap_settings[] = {
 	}
 };
 
+static const struct lvts_tc_settings mt8195_tc_mcu_settings[] = {
+	[0] = {
+		.dev_id = 0x81,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.ts_offset = 0,
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
+		.ts_offset = 0,
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
+		.ts_offset = 0,
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
+		.ts_offset = 0,
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
+		.ts_offset = 0,
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
+		.ts_offset = 0,
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
+		.ts_offset = 0,
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
@@ -223,9 +399,63 @@ static const struct lvts_data mt8192_lvts_ap_data = {
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

