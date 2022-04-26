Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A059A510BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355696AbiDZWSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355679AbiDZWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F332A71F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so132801wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ig54l1xdqr17o4YvNAsqxn7MN0zhygiBhw+8D8uvy5E=;
        b=dl1pcaURJ+oaIQrxmVIgcznmvSDVpezVgPO19LGaSjxawy2+fzKC3OE//jVkiQzXUe
         3xwJeXhSsXZWUcZR/L4EBkdqWiyHULtu7RytgP1JtccsjlD9YeR4BX5snlF0Tv0Ifkvb
         i/l/5VbWV1U+KnQ7m5/RLl7l7l0Wo0Kpe8yCPupr8GrLxvjzOggfHVLM+AtblLFBjKyQ
         vVMCNOskUbb5w4aMKYuLSc3iW0mkMcP7YqxiIvfYeHBS4SpopUmAj8cp+j64uGOu1Tq5
         cCT49Q/HFXGmAxhhA49iXfOcniDr4LLdGVFMshRuLb941JrrluEBw0365eKiwSbBf1NY
         o8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ig54l1xdqr17o4YvNAsqxn7MN0zhygiBhw+8D8uvy5E=;
        b=zWK4uy3u1YaHecQPnPipEYuMN1O38FmS3EuKCTrGyRtvy+3XP6SmpLDPwYC7Xxw3GB
         qV93Aqme9D+9MuacCao3D4nxqUAjBJtt4MsVamuhI72y64h6/wLeBYk/J6CEdHfSY+QM
         u19wNicTp9M1eKct1bdZPYGDXIS0j/1ywJj8E9iOEuSfqQG63neixMkrtc6SBEBQHsZb
         YQjXZXpaBfp2Pf8p+M1bqmk6slSUVhu5LueDS2U+z1Lml1bnCa+KIGLswVmStncwEJoL
         V8hHdQ6y82aGsn7KSILj5/FMDlsxts9dWGwyP4J/K1QJS7BVQyXgKlDulYtpIlfFSJot
         +mmA==
X-Gm-Message-State: AOAM533ufflURmVn5+6RF8cuFBzaDzPRtK2neE9OYN0ZKvvDdRA0mgVQ
        lm2jjGusLTCJGstlC1iqcC730Q==
X-Google-Smtp-Source: ABdhPJwb5l7zjRviUym9EQUnpRUGZGDWN8M7EKz8cH3mKooKy3itU9ttAIs1wFadeLV3UVbIGL0gbg==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr23391013wma.108.1651011336959;
        Tue, 26 Apr 2022 15:15:36 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] thermal/core: Change thermal_zone_ops to thermal_sensor_ops
Date:   Wed, 27 Apr 2022 00:15:10 +0200
Message-Id: <20220426221523.3056696-3-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A thermal zone is software abstraction of a sensor associated with
properties and cooling devices if any.

The fact that we have thermal_zone and thermal_zone_ops mixed is
confusing and does not clearly identify the different components
entering in the thermal management process. A thermal zone appears to
be a sensor while it is not.

In order to set the scene for multiple thermal sensors aggregated into
a single thermal zone. Rename the thermal_zone_ops to
thermal_sensor_ops, that will appear clearyl the thermal zone is not a
sensor but an abstraction of one [or multiple] sensor(s).

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 Documentation/driver-api/thermal/sysfs-api.rst            | 2 +-
 drivers/acpi/thermal.c                                    | 6 +++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c        | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c        | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c               | 2 +-
 drivers/platform/x86/acerhdf.c                            | 2 +-
 drivers/power/supply/power_supply_core.c                  | 2 +-
 drivers/thermal/armada_thermal.c                          | 2 +-
 drivers/thermal/da9062-thermal.c                          | 2 +-
 drivers/thermal/dove_thermal.c                            | 2 +-
 drivers/thermal/imx_thermal.c                             | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c   | 2 +-
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c  | 6 +++---
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.h  | 4 ++--
 .../intel/int340x_thermal/processor_thermal_device.c      | 4 ++--
 .../intel/int340x_thermal/processor_thermal_device_pci.c  | 2 +-
 drivers/thermal/intel/intel_pch_thermal.c                 | 2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c           | 2 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c                | 2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c              | 2 +-
 drivers/thermal/kirkwood_thermal.c                        | 2 +-
 drivers/thermal/rcar_thermal.c                            | 4 ++--
 drivers/thermal/spear_thermal.c                           | 2 +-
 drivers/thermal/st/st_thermal.c                           | 2 +-
 drivers/thermal/thermal_core.c                            | 2 +-
 drivers/thermal/thermal_of.c                              | 4 ++--
 include/linux/thermal.h                                   | 8 ++++----
 27 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 113afc8c5479..6d207d89f736 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -41,7 +41,7 @@ temperature) and throttle appropriate devices.
 	struct thermal_zone
 	*thermal_zone_register(char *type,
 				      int trips, int mask, void *devdata,
-				      struct thermal_zone_ops *ops,
+				      struct thermal_sensor_ops *ops,
 				      const struct thermal_zone_params *tzp,
 				      int passive_delay, int polling_delay))
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 23373af58565..253089214185 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -774,7 +774,7 @@ acpi_thermal_unbind_cooling_device(struct thermal_zone *thermal,
 	return acpi_thermal_cooling_device_cb(thermal, cdev, false);
 }
 
-static struct thermal_zone_ops acpi_thermal_zone_ops = {
+static struct thermal_sensor_ops acpi_thermal_sensor_ops = {
 	.bind = acpi_thermal_bind_cooling_device,
 	.unbind	= acpi_thermal_unbind_cooling_device,
 	.get_temp = thermal_get_temp,
@@ -808,13 +808,13 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone =
 			thermal_zone_register("acpitz", trips, 0, tz,
-						&acpi_thermal_zone_ops, NULL,
+						&acpi_thermal_sensor_ops, NULL,
 						     tz->trips.passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
 			thermal_zone_register("acpitz", trips, 0, tz,
-						&acpi_thermal_zone_ops, NULL,
+						&acpi_thermal_sensor_ops, NULL,
 						0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
index 460a26699f68..92d8a63e48a9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -53,7 +53,7 @@ static int cxgb4_thermal_get_trip_temp(struct thermal_zone *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_ops cxgb4_thermal_ops = {
+static struct thermal_sensor_ops cxgb4_thermal_ops = {
 	.get_temp = cxgb4_thermal_get_temp,
 	.get_trip_type = cxgb4_thermal_get_trip_type,
 	.get_trip_temp = cxgb4_thermal_get_trip_temp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index f70ca5525202..5c8d79103e76 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -361,7 +361,7 @@ static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
 
-static struct thermal_zone_ops mlxsw_thermal_ops = {
+static struct thermal_sensor_ops mlxsw_thermal_ops = {
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
 	.get_temp = mlxsw_thermal_get_temp,
@@ -553,7 +553,7 @@ static int mlxsw_thermal_module_trend_get(struct thermal_zone *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_ops mlxsw_thermal_module_ops = {
+static struct thermal_sensor_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
@@ -590,7 +590,7 @@ static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_ops mlxsw_thermal_gearbox_ops = {
+static struct thermal_sensor_ops mlxsw_thermal_gearbox_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index e20e5e46d342..09c691efd08a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -718,7 +718,7 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone *device,
 	return ret;
 }
 
-static  struct thermal_zone_ops tzone_ops = {
+static  struct thermal_sensor_ops tzone_ops = {
 	.get_temp = iwl_mvm_tzone_get_temp,
 	.get_trip_temp = iwl_mvm_tzone_get_trip_temp,
 	.get_trip_type = iwl_mvm_tzone_get_trip_type,
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index f6be06d1e723..a2b081f8013f 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -469,7 +469,7 @@ static int acerhdf_get_crit_temp(struct thermal_zone *thermal,
 }
 
 /* bind callback functions to thermalzone */
-static struct thermal_zone_ops acerhdf_dev_ops = {
+static struct thermal_sensor_ops acerhdf_dev_ops = {
 	.bind = acerhdf_bind,
 	.unbind = acerhdf_unbind,
 	.get_temp = acerhdf_get_ec_temp,
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 51b052774478..4af288168837 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1149,7 +1149,7 @@ static int power_supply_read_temp(struct thermal_zone *tzd,
 	return ret;
 }
 
-static struct thermal_zone_ops psy_tzd_ops = {
+static struct thermal_sensor_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 18707f34df1b..4ec5ebd8bc09 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -416,7 +416,7 @@ static int armada_get_temp_legacy(struct thermal_zone *thermal,
 	return ret;
 }
 
-static struct thermal_zone_ops legacy_ops = {
+static struct thermal_sensor_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index acabb93a5140..77862f8222cd 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -170,7 +170,7 @@ static int da9062_thermal_get_temp(struct thermal_zone *z,
 	return 0;
 }
 
-static struct thermal_zone_ops da9062_thermal_ops = {
+static struct thermal_sensor_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
 	.get_trip_type	= da9062_thermal_get_trip_type,
 	.get_trip_temp	= da9062_thermal_get_trip_temp,
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 59a6adefde2f..f0e94e7a4292 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -109,7 +109,7 @@ static int dove_get_temp(struct thermal_zone *thermal,
 	return 0;
 }
 
-static struct thermal_zone_ops ops = {
+static struct thermal_sensor_ops ops = {
 	.get_temp = dove_get_temp,
 };
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index f0cf4a6c6bc0..835cb99ddd78 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -418,7 +418,7 @@ static int imx_unbind(struct thermal_zone *tz,
 	return 0;
 }
 
-static struct thermal_zone_ops imx_tz_ops = {
+static struct thermal_sensor_ops imx_tz_ops = {
 	.bind = imx_bind,
 	.unbind = imx_unbind,
 	.get_temp = imx_get_temp,
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 12b0452b3142..135b59e15399 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -485,7 +485,7 @@ static int int3400_thermal_change_mode(struct thermal_zone *thermal,
 	return result;
 }
 
-static struct thermal_zone_ops int3400_thermal_ops = {
+static struct thermal_sensor_ops int3400_thermal_ops = {
 	.get_temp = int3400_thermal_get_temp,
 	.change_mode = int3400_thermal_change_mode,
 };
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 90c060c0e97f..d726fb7c846f 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -151,7 +151,7 @@ static void int340x_thermal_critical(struct thermal_zone *zone)
 	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
 }
 
-static struct thermal_zone_ops int340x_thermal_zone_ops = {
+static struct thermal_sensor_ops int340x_thermal_sensor_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
 	.get_trip_temp	= int340x_thermal_get_trip_temp,
 	.get_trip_type	= int340x_thermal_get_trip_type,
@@ -217,7 +217,7 @@ static struct thermal_zone_params int340x_thermal_params = {
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
-				struct thermal_zone_ops *override_ops)
+				struct thermal_sensor_ops *override_ops)
 {
 	struct int34x_thermal_zone *int34x_thermal_zone;
 	acpi_status status;
@@ -262,7 +262,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						acpi_device_bid(adev),
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
-						&int340x_thermal_zone_ops,
+						&int340x_thermal_sensor_ops,
 						&int340x_thermal_params,
 						0, 0);
 	if (IS_ERR(int34x_thermal_zone->zone)) {
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index f6be7d8f59d5..01ce3415d4fd 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -29,13 +29,13 @@ struct int34x_thermal_zone {
 	int hot_temp;
 	int hot_trip_id;
 	struct thermal_zone *zone;
-	struct thermal_zone_ops *override_ops;
+	struct thermal_sensor_ops *override_ops;
 	void *priv_data;
 	struct acpi_lpat_conversion_table *lpat_table;
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
-				struct thermal_zone_ops *override_ops);
+				struct thermal_sensor_ops *override_ops);
 void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone);
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 1da96d5f30c3..c60e466809ef 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -207,7 +207,7 @@ static int proc_thermal_get_zone_temp(struct thermal_zone *zone,
 	return ret;
 }
 
-static struct thermal_zone_ops proc_thermal_local_ops = {
+static struct thermal_sensor_ops proc_thermal_local_ops = {
 	.get_temp       = proc_thermal_get_zone_temp,
 };
 
@@ -285,7 +285,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	struct acpi_device *adev;
 	acpi_status status;
 	unsigned long long tmp;
-	struct thermal_zone_ops *ops = NULL;
+	struct thermal_sensor_ops *ops = NULL;
 	int ret;
 
 	adev = ACPI_COMPANION(dev);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 55f1c23d1235..f70f85ad752a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -200,7 +200,7 @@ static int sys_set_trip_temp(struct thermal_zone *tzd, int trip, int temp)
 	return 0;
 }
 
-static struct thermal_zone_ops tzone_ops = {
+static struct thermal_sensor_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 596949da0e7e..7f0118c23251 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -331,7 +331,7 @@ static void pch_critical(struct thermal_zone *tzd)
 	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
 }
 
-static struct thermal_zone_ops tzd_ops = {
+static struct thermal_sensor_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
 	.get_trip_type = pch_get_trip_type,
 	.get_trip_temp = pch_get_trip_temp,
diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index ad992fabb6ba..1744f81caf8b 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -313,7 +313,7 @@ static int sys_change_mode(struct thermal_zone *tzd,
 	return ret;
 }
 
-static struct thermal_zone_ops tzone_ops = {
+static struct thermal_sensor_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index c395bafd4fef..5e6d8d92f1bb 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -243,7 +243,7 @@ static int sys_get_curr_temp(struct thermal_zone *tzd,
 	return 0;
 }
 
-static struct thermal_zone_ops tzone_ops = {
+static struct thermal_sensor_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 418e99a0f999..ab695aed96a5 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -220,7 +220,7 @@ static int sys_get_trip_type(struct thermal_zone *thermal, int trip,
 }
 
 /* Thermal zone callback registry */
-static struct thermal_zone_ops tzone_ops = {
+static struct thermal_sensor_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index e4133fb20f1b..4da621d7bcb9 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -51,7 +51,7 @@ static int kirkwood_get_temp(struct thermal_zone *thermal,
 	return 0;
 }
 
-static struct thermal_zone_ops ops = {
+static struct thermal_sensor_ops ops = {
 	.get_temp = kirkwood_get_temp,
 };
 
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index ea296b0b02f3..a60a16b7be06 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -327,7 +327,7 @@ static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops = {
 	.get_temp	= rcar_thermal_of_get_temp,
 };
 
-static struct thermal_zone_ops rcar_thermal_zone_ops = {
+static struct thermal_sensor_ops rcar_thermal_sensor_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 	.get_trip_type	= rcar_thermal_get_trip_type,
 	.get_trip_temp	= rcar_thermal_get_trip_temp,
@@ -534,7 +534,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			priv->zone = thermal_zone_register(
 						"rcar_thermal",
 						1, 0, priv,
-						&rcar_thermal_zone_ops, NULL, 0,
+						&rcar_thermal_sensor_ops, NULL, 0,
 						idle);
 
 			ret = thermal_zone_enable(priv->zone);
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 0f4492ab927c..d32b3b0976df 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -41,7 +41,7 @@ static inline int thermal_get_temp(struct thermal_zone *thermal,
 	return 0;
 }
 
-static struct thermal_zone_ops ops = {
+static struct thermal_sensor_ops ops = {
 	.get_temp = thermal_get_temp,
 };
 
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 97f2d8c3493a..1a09c7d24d82 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -170,7 +170,7 @@ static int st_thermal_get_trip_temp(struct thermal_zone *th,
 	return 0;
 }
 
-static struct thermal_zone_ops st_tz_ops = {
+static struct thermal_sensor_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
 	.get_trip_type	= st_thermal_get_trip_type,
 	.get_trip_temp	= st_thermal_get_trip_temp,
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 64f736b9e877..d0eef7297c99 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1184,7 +1184,7 @@ static void bind_tz(struct thermal_zone *tz)
  */
 struct thermal_zone *
 thermal_zone_register(const char *type, int trips, int mask,
-			     void *devdata, struct thermal_zone_ops *ops,
+			     void *devdata, struct thermal_sensor_ops *ops,
 			     struct thermal_zone_params *tzp, int passive_delay,
 			     int polling_delay)
 {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index f29d4f99522a..8d958bec69d9 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -360,7 +360,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone *tz,
 	return -EINVAL;
 }
 
-static struct thermal_zone_ops of_thermal_ops = {
+static struct thermal_sensor_ops of_thermal_ops = {
 	.get_trip_type = of_thermal_get_trip_type,
 	.get_trip_temp = of_thermal_get_trip_temp,
 	.set_trip_temp = of_thermal_set_trip_temp,
@@ -1046,7 +1046,7 @@ int __init of_parse_thermal_zones(void)
 {
 	struct device_node *np, *child;
 	struct __thermal_zone *tz;
-	struct thermal_zone_ops *ops;
+	struct thermal_sensor_ops *ops;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c599b7f8c9c5..06b6b743d5c4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -57,7 +57,7 @@ enum thermal_notify_event {
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
 };
 
-struct thermal_zone_ops {
+struct thermal_sensor_ops {
 	int (*bind) (struct thermal_zone *,
 		     struct thermal_cooling_device *);
 	int (*unbind) (struct thermal_zone *,
@@ -164,7 +164,7 @@ struct thermal_zone {
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-	struct thermal_zone_ops *ops;
+	struct thermal_sensor_ops *ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
@@ -361,7 +361,7 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 
 #ifdef CONFIG_THERMAL
 struct thermal_zone *thermal_zone_register(const char *, int, int,
-		void *, struct thermal_zone_ops *,
+		void *, struct thermal_sensor_ops *,
 		struct thermal_zone_params *, int, int);
 void thermal_zone_unregister(struct thermal_zone *);
 
@@ -396,7 +396,7 @@ void thermal_zone_critical(struct thermal_zone *tz);
 #else
 static inline struct thermal_zone *thermal_zone_register(
 	const char *type, int trips, int mask, void *devdata,
-	struct thermal_zone_ops *ops,
+	struct thermal_sensor_ops *ops,
 	struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
-- 
2.25.1

