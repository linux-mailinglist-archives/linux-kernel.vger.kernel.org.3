Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC68581498
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiGZNzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiGZNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:55:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C46582
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r132-20020a1c448a000000b003a34ac64bdfso57061wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEiCDnBJfTCfMI+4Z4Tn0LD6y0rCD8YgBNUzFMu5IG0=;
        b=di6BHhJlUr1Fz9NcNrcQdMrllU2Mzy4WJgA/Nx0NTuHq+Tfo8jAYyp5VXc41LogQ4v
         46kWrppePbk58eHwpVIan6uqw2xPlQaRUcrMsVm60tdj5CzR9t4/+Z838F7X1y4Be/Uy
         2G+dfXV1GHEU7DZ54gjXMSq6RQQUoIvFB0HBQ0IWvA7lS8yhEkU+FzWfMou29SUB7BXn
         jnnIzWP95B7dsGddbqtQpB0SGo3EI/qwUnjAl5J275YhlDjEQY3nA1golwg7TfOYm9ea
         SOaXt4gyzuTtrp54VBKp+QMRRwCNVJ9mGH8VMCCttJDhwjz0K9zO3pwPhehEoyqQCLs1
         dJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEiCDnBJfTCfMI+4Z4Tn0LD6y0rCD8YgBNUzFMu5IG0=;
        b=d+sInQp0pVwEdZr41YBbiQ76YidqKC5GHVvnvdAuwraeOY68KhYlGAKlC15B3otrCX
         ybkrfdz5hW0fbSOYETafWoB68zaK/zcYv37ma9cRcQzoSR7yUPvqiUf/fzXKr6xzhnBO
         1yrcw98+QuR0RUlk/WUH+uMe+QSc2sP6Ls6FDXUV2dlfOl/XOj1LF3RrFRMr/kDm/T8Y
         WKcLxNCgNiUPqEtoEohdrgcU7vgfAmf/3Y1xegluWk8MCAwym2k8J3vLU61VdeOVvFCs
         wQdM4uSXfyzD7VsObB2vp1+jKmxsETmGQZxmFraqW9UHrv1m69XFUzJKJ+zGcqn0C050
         Avjg==
X-Gm-Message-State: AJIora9WfxPxhw0CefmTWgwnofmjqF0o+A+7+KHkQ7nE9GPxEBWsqLe/
        fkGu2Q4jYdOZ5A2zOLv5nY4M4hVQ4FwevA==
X-Google-Smtp-Source: AGRyM1utn7izSjqVcFH7meNIqwZCnjvN+6wA5QnozUx5tevBFho8o4sg8GAvG0e0CgbACzK+dIrZdQ==
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id m19-20020a7bce13000000b003a3102c23d3mr12040080wmc.67.1658843720995;
        Tue, 26 Jul 2022 06:55:20 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020adf9c8d000000b0021e4c3b2967sm15244670wre.65.2022.07.26.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:55:20 -0700 (PDT)
From:   Balsam CHIHI <bchihi@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8 4/6] thermal: mediatek: Add thermal zone settings for mt8195
Date:   Tue, 26 Jul 2022 15:55:04 +0200
Message-Id: <20220726135506.485108-5-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726135506.485108-1-bchihi@baylibre.com>
References: <20220726135506.485108-1-bchihi@baylibre.com>
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

Add thermal zone settings for mt8195

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/Kconfig         |  12 ++
 drivers/thermal/mediatek/Makefile        |   1 +
 drivers/thermal/mediatek/lvts_mt8195.c   | 253 +++++++++++++++++++++++
 drivers/thermal/mediatek/soc_temp_lvts.h |   1 +
 4 files changed, 267 insertions(+)
 create mode 100644 drivers/thermal/mediatek/lvts_mt8195.c

diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
index 7fc04237dd50..df3b4a033fc2 100644
--- a/drivers/thermal/mediatek/Kconfig
+++ b/drivers/thermal/mediatek/Kconfig
@@ -47,4 +47,16 @@ config LVTS_MT8192
 		configures LVTS thermal controllers to collect temperatures
 		via ASIF.
 
+config LVTS_MT8195
+	tristate "LVTS driver for MediaTek MT8195 SoC"
+	depends on HAS_IOMEM
+	depends on NVMEM
+	depends on RESET_TI_SYSCON
+	depends on MTK_SOC_THERMAL_LVTS
+	help
+		Enable this option if you want to get SoC temperature
+		information for MT8195. This driver
+		configures LVTS thermal controllers to collect temperatures
+		via ASIF.
+
 endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
index 5ff1197e80ab..dada1bf13110 100644
--- a/drivers/thermal/mediatek/Makefile
+++ b/drivers/thermal/mediatek/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_MTK_SOC_THERMAL)		+= soc_temp.o
 obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)	+= soc_temp_lvts.o
 obj-$(CONFIG_LVTS_MT8192)			+= lvts_mt8192.o
+obj-$(CONFIG_LVTS_MT8195)			+= lvts_mt8195.o
diff --git a/drivers/thermal/mediatek/lvts_mt8195.c b/drivers/thermal/mediatek/lvts_mt8195.c
new file mode 100644
index 000000000000..df69e2e79115
--- /dev/null
+++ b/drivers/thermal/mediatek/lvts_mt8195.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include "soc_temp_lvts.h"
+
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
+static struct lvts_speed_settings tc_speed_mt8195 = {
+	.period_unit = PERIOD_UNIT,
+	.group_interval_delay = GROUP_INTERVAL_DELAY,
+	.filter_interval_delay = FILTER_INTERVAL_DELAY,
+	.sensor_interval_delay = SENSOR_INTERVAL_DELAY,
+};
+
+static const struct lvts_tc_settings mt8195_tc_mcu_settings[] = {
+	[0] = {
+		.dev_id = 0x81,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = {MT8195_TS1_0, MT8195_TS1_1},
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
+		.sensor_map = {MT8195_TS2_0, MT8195_TS2_1},
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
+		.sensor_map = {MT8195_TS3_0, MT8195_TS3_1, MT8195_TS3_2, MT8195_TS3_3},
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
+		.sensor_map = {MT8195_TS4_0, MT8195_TS4_1},
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
+		.sensor_map = {MT8195_TS5_0, MT8195_TS5_1},
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
+		.sensor_map = {MT8195_TS6_0, MT8195_TS6_1, MT8195_TS6_2},
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
+		.sensor_map = {MT8195_TS7_0, MT8195_TS7_1},
+		.tc_speed = &tc_speed_mt8195,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(6),
+	}
+};
+
+static const struct lvts_data mt8195_lvts_mcu_data = {
+	.num_tc = (ARRAY_SIZE(mt8195_tc_mcu_settings)),
+	.tc = mt8195_tc_mcu_settings,
+	.num_sensor = MT8195_NUM_TS_MCU,
+	.ops = {
+		.efuse_to_cal_data = mt8195_mcu_efuse_to_cal_data,
+		.device_enable_and_init = lvts_device_enable_and_init_v4,
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
+		.device_enable_and_init = lvts_device_enable_and_init_v4,
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
+static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data, },
+	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lvts_of_match);
+
+static struct platform_driver soc_temp_lvts = {
+	.probe = lvts_probe,
+	.remove = lvts_remove,
+	.suspend = lvts_suspend,
+	.resume = lvts_resume,
+	.driver = {
+		.name = "mtk-soc-temp-lvts-mt8195",
+		.of_match_table = lvts_of_match,
+	},
+};
+module_platform_driver(soc_temp_lvts);
+
+MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
+MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek soc temperature driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/mediatek/soc_temp_lvts.h b/drivers/thermal/mediatek/soc_temp_lvts.h
index 6f8b6e3af98c..c4acb7e26e5e 100644
--- a/drivers/thermal/mediatek/soc_temp_lvts.h
+++ b/drivers/thermal/mediatek/soc_temp_lvts.h
@@ -16,6 +16,7 @@
 #define FEATURE_DEVICE_AUTO_RCK	BIT(0)
 #define NUM_EFUSE_ADDR			22
 #define NUM_EFUSE_BLOCK_MT8192	1
+#define NUM_EFUSE_BLOCK_MT8195	2
 #define DEFAULT_GOLDEN_TEMP		50
 #define DEFAULT_CUONT_R			35000
 #define DEFAULT_CUONT_RC		2750
-- 
2.34.1

