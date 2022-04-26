Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81AF510BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355751AbiDZWTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355704AbiDZWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840C29CBF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 129so153727wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyoPm9zcmwJ8h7GUPGbk8zQ5wBA1xy4NS6732KQk0IQ=;
        b=LI8OPpj3AppOjiex0S1HgOGL4W8w+GVEvyU1HMzOiVpNw67+1tZJSmfQHzv52FfMvU
         w6reR+OkSRTs1xzFJ1+RcsBcNZndlaC/oDjPDzlN3SzZhbghIVSc9Sq+5ilFh+by3Q/8
         lhBYEHJdy/tkU6YExuJuSlbKwl5bEiuttak/KRhuzYAZ6WttFmblPDvPfNgg1bYpmy3+
         vYm23QvxofJnTgeZQBb7BhWbyILUGWG9D3+bg9AklLzAXoKukb/uEQw+V1XqyIqiunlL
         Aeo6vkjC8/mJ+5Aorq7rs2X1wIxNR/8XKpduAENNJUJtWsjgCiMkTnYv3mqx2T12OD4I
         X9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyoPm9zcmwJ8h7GUPGbk8zQ5wBA1xy4NS6732KQk0IQ=;
        b=xUd1EPx+2o3l7zIkNMTs2//JXkxMijml9domK+w7HjInRu8aEY9BBbTIAR7eMuRuAG
         iShEes+++3mOmFsaDBRb69PgqtS7bpjFNyN8WtNZGOQApMt4JMTnDC4zQmyYjHvW26Tb
         tSBnjzuhlHG4DD5XPY2FLpWASLcxOxJOy5W6AYxIJAOdYHUD0QCp1kbyKYh46bciNiGo
         c41+OSz9olCZj8s83M21QPmUGOIy8lcZuT8i1uVozU988GBCIK5P8kVzS26ZBosmwGRq
         v8/hPXLXnmEAqWMTWIsdII6s521R777k/SKTYBg9ABCTtcHvJjqEhiIMN7hujNtWP8/d
         ZKTg==
X-Gm-Message-State: AOAM533hoBuGwlBJVBb7GhEe6UyOeo6aVx+iTNvdz4zwHTTdudFXkbuP
        EqaAbD291ARxO5y9pYVVFdtv/w==
X-Google-Smtp-Source: ABdhPJzo4owFcd+uFIR9KxYqgKDelFYRvfWYud+TSOxilSwlF0CP6QNGde+LTVr00rTDN1M8zNzENA==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr32646465wmk.77.1651011336204;
        Tue, 26 Apr 2022 15:15:36 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] thermal/core: Rename thermal_zone_device to thermal_zone
Date:   Wed, 27 Apr 2022 00:15:09 +0200
Message-Id: <20220426221523.3056696-2-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
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

A thermal zone is a component to represent a sensor, a given number of
properties, a policy and some associated cooling devices.

The current name is 'thermal_zone_device' but that is confusing
because it implies it is a device while it is a software component.

For the sake of clarity and the process of cleaning up the thermal
framework, simply rename it to 'thermal zone'.

No functional change, just renaming.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 .../driver-api/thermal/power_allocator.rst    |  10 +-
 .../driver-api/thermal/sysfs-api.rst          |  28 ++--
 drivers/acpi/thermal.c                        |  42 ++---
 drivers/gpu/drm/tiny/repaper.c                |   2 +-
 drivers/hwmon/hwmon.c                         |   6 +-
 drivers/hwmon/scpi-hwmon.c                    |   2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c             |   2 +-
 drivers/input/touchscreen/sun4i-ts.c          |   2 +-
 drivers/mmc/host/sdhci-omap.c                 |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |  16 +-
 .../ethernet/mellanox/mlxsw/core_thermal.c    |  78 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  20 +--
 drivers/platform/x86/acerhdf.c                |  30 ++--
 drivers/platform/x86/gpd-pocket-fan.c         |   4 +-
 drivers/power/supply/power_supply_core.c      |  12 +-
 drivers/regulator/max8973-regulator.c         |   6 +-
 drivers/thermal/amlogic_thermal.c             |   2 +-
 drivers/thermal/armada_thermal.c              |  24 +--
 drivers/thermal/broadcom/bcm2711_thermal.c    |   4 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |   6 +-
 drivers/thermal/broadcom/brcmstb_thermal.c    |   6 +-
 drivers/thermal/broadcom/ns-thermal.c         |   2 +-
 drivers/thermal/broadcom/sr-thermal.c         |   2 +-
 drivers/thermal/da9062-thermal.c              |  22 +--
 drivers/thermal/db8500_thermal.c              |   6 +-
 drivers/thermal/dove_thermal.c                |  16 +-
 drivers/thermal/gov_bang_bang.c               |   6 +-
 drivers/thermal/gov_fair_share.c              |   8 +-
 drivers/thermal/gov_power_allocator.c         |  22 +--
 drivers/thermal/gov_step_wise.c               |   8 +-
 drivers/thermal/gov_user_space.c              |   6 +-
 drivers/thermal/hisi_thermal.c                |  10 +-
 drivers/thermal/imx8mm_thermal.c              |   2 +-
 drivers/thermal/imx_sc_thermal.c              |   2 +-
 drivers/thermal/imx_thermal.c                 |  36 ++--
 .../intel/int340x_thermal/int3400_thermal.c   |  14 +-
 .../intel/int340x_thermal/int3402_thermal.c   |   2 +-
 .../intel/int340x_thermal/int3403_thermal.c   |   4 +-
 .../int340x_thermal/int340x_thermal_zone.c    |  24 +--
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 .../processor_thermal_device.c                |   8 +-
 .../processor_thermal_device_pci.c            |  26 +--
 .../thermal/intel/intel_bxt_pmic_thermal.c    |   4 +-
 drivers/thermal/intel/intel_menlow.c          |   2 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  20 +--
 .../thermal/intel/intel_quark_dts_thermal.c   |  28 ++--
 drivers/thermal/intel/intel_soc_dts_iosf.c    |  20 +--
 drivers/thermal/intel/intel_soc_dts_iosf.h    |   2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  26 +--
 drivers/thermal/k3_bandgap.c                  |   2 +-
 drivers/thermal/kirkwood_thermal.c            |  16 +-
 drivers/thermal/max77620_thermal.c            |   4 +-
 drivers/thermal/mtk_thermal.c                 |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   6 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   6 +-
 drivers/thermal/qcom/tsens.c                  |   6 +-
 drivers/thermal/qcom/tsens.h                  |   2 +-
 drivers/thermal/qoriq_thermal.c               |   2 +-
 drivers/thermal/rcar_gen3_thermal.c           |  10 +-
 drivers/thermal/rcar_thermal.c                |  20 +--
 drivers/thermal/rockchip_thermal.c            |  10 +-
 drivers/thermal/rzg2l_thermal.c               |   4 +-
 drivers/thermal/samsung/exynos_tmu.c          |  16 +-
 drivers/thermal/spear_thermal.c               |  20 +--
 drivers/thermal/sprd_thermal.c                |   8 +-
 drivers/thermal/st/st_thermal.c               |  16 +-
 drivers/thermal/st/st_thermal.h               |   2 +-
 drivers/thermal/st/st_thermal_memmap.c        |   2 +-
 drivers/thermal/st/stm_thermal.c              |   6 +-
 drivers/thermal/sun8i_thermal.c               |   4 +-
 drivers/thermal/tegra/soctherm.c              |  28 ++--
 drivers/thermal/tegra/tegra-bpmp-thermal.c    |   6 +-
 drivers/thermal/tegra/tegra30-tsensor.c       |  14 +-
 drivers/thermal/thermal-generic-adc.c         |   2 +-
 drivers/thermal/thermal_core.c                | 154 +++++++++---------
 drivers/thermal/thermal_core.h                |  34 ++--
 drivers/thermal/thermal_helpers.c             |  16 +-
 drivers/thermal/thermal_hwmon.c               |  22 +--
 drivers/thermal/thermal_hwmon.h               |  12 +-
 drivers/thermal/thermal_mmio.c                |   2 +-
 drivers/thermal/thermal_netlink.c             |   8 +-
 drivers/thermal/thermal_of.c                  |  76 ++++-----
 drivers/thermal/thermal_sysfs.c               |  54 +++---
 .../ti-soc-thermal/ti-thermal-common.c        |  10 +-
 drivers/thermal/uniphier_thermal.c            |   4 +-
 include/linux/power/charger-manager.h         |   2 +-
 include/linux/power_supply.h                  |   2 +-
 include/linux/thermal.h                       | 118 +++++++-------
 include/trace/events/thermal.h                |   4 +-
 .../trace/events/thermal_power_allocator.h    |   4 +-
 92 files changed, 691 insertions(+), 691 deletions(-)

diff --git a/Documentation/driver-api/thermal/power_allocator.rst b/Documentation/driver-api/thermal/power_allocator.rst
index aa5f66552d6f..fd31832f11e5 100644
--- a/Documentation/driver-api/thermal/power_allocator.rst
+++ b/Documentation/driver-api/thermal/power_allocator.rst
@@ -95,7 +95,7 @@ will suffice::
 	};
 
 and then pass `tz_params` as the 5th parameter to
-`thermal_zone_device_register()`
+`thermal_zone_register()`
 
 k_po and k_pu
 -------------
@@ -186,7 +186,7 @@ Cooling devices controlled by this governor must supply the additional
 1. ::
 
     int get_requested_power(struct thermal_cooling_device *cdev,
-			    struct thermal_zone_device *tz, u32 *power);
+			    struct thermal_zone *tz, u32 *power);
 
 
 @cdev:
@@ -205,7 +205,7 @@ device.
 2. ::
 
 	int state2power(struct thermal_cooling_device *cdev, struct
-			thermal_zone_device *tz, unsigned long state,
+			thermal_zone *tz, unsigned long state,
 			u32 *power);
 
 @cdev:
@@ -255,7 +255,7 @@ the same kind of compute, but with different efficiency.  For example,
 a system with two different types of processors.
 
 If the thermal zone is registered using
-`thermal_zone_device_register()` (i.e., platform code), then weights
+`thermal_zone_register()` (i.e., platform code), then weights
 are passed as part of the thermal zone's `thermal_bind_parameters`.
 If the platform is registered using device tree, then they are passed
 as the `contribution` property of each map in the `cooling-maps` node.
@@ -265,7 +265,7 @@ Limitations of the power allocator governor
 
 The power allocator governor's PID controller works best if there is a
 periodic tick.  If you have a driver that calls
-`thermal_zone_device_update()` (or anything that ends up calling the
+`thermal_zone_update()` (or anything that ends up calling the
 governor's `throttle()` function) repetitively, the governor response
 won't be very good.  Note that this is not particular to this
 governor, step-wise will also misbehave if you call its throttle()
diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 2e0f79a9e2ee..113afc8c5479 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -38,10 +38,10 @@ temperature) and throttle appropriate devices.
 
     ::
 
-	struct thermal_zone_device
-	*thermal_zone_device_register(char *type,
+	struct thermal_zone
+	*thermal_zone_register(char *type,
 				      int trips, int mask, void *devdata,
-				      struct thermal_zone_device_ops *ops,
+				      struct thermal_zone_ops *ops,
 				      const struct thermal_zone_params *tzp,
 				      int passive_delay, int polling_delay))
 
@@ -99,7 +99,7 @@ temperature) and throttle appropriate devices.
 
     ::
 
-	void thermal_zone_device_unregister(struct thermal_zone_device *tz)
+	void thermal_zone_unregister(struct thermal_zone *tz)
 
     This interface function removes the thermal zone device.
     It deletes the corresponding entry from /sys/class/thermal folder and
@@ -107,7 +107,7 @@ temperature) and throttle appropriate devices.
 
 	::
 
-	   struct thermal_zone_device
+	   struct thermal_zone
 	   *thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
 				void *data,
 				const struct thermal_zone_of_device_ops *ops)
@@ -140,7 +140,7 @@ temperature) and throttle appropriate devices.
 			set_trips	a pointer to a function that sets a
 					temperature window. When this window is
 					left the driver must inform the thermal
-					core via thermal_zone_device_update.
+					core via thermal_zone_update.
 			get_trend 	a pointer to a function that reads the
 					sensor temperature trend.
 			set_emul_temp	a pointer to a function that sets
@@ -158,7 +158,7 @@ temperature) and throttle appropriate devices.
 	::
 
 	    void thermal_zone_of_sensor_unregister(struct device *dev,
-						   struct thermal_zone_device *tzd)
+						   struct thermal_zone *tzd)
 
 	This interface unregisters a sensor from a DT thermal zone which was
 	successfully added by interface thermal_zone_of_sensor_register().
@@ -169,7 +169,7 @@ temperature) and throttle appropriate devices.
 
 	::
 
-	  struct thermal_zone_device
+	  struct thermal_zone
 	  *devm_thermal_zone_of_sensor_register(struct device *dev,
 				int sensor_id,
 				void *data,
@@ -189,7 +189,7 @@ temperature) and throttle appropriate devices.
 	::
 
 		void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-						struct thermal_zone_device *tzd)
+						struct thermal_zone *tzd)
 
 	This interface is resource managed version of
 	thermal_zone_of_sensor_unregister().
@@ -200,7 +200,7 @@ temperature) and throttle appropriate devices.
 
 	::
 
-		int thermal_zone_get_slope(struct thermal_zone_device *tz)
+		int thermal_zone_get_slope(struct thermal_zone *tz)
 
 	This interface is used to read the slope attribute value
 	for the thermal zone device, which might be useful for platform
@@ -208,7 +208,7 @@ temperature) and throttle appropriate devices.
 
 	::
 
-		int thermal_zone_get_offset(struct thermal_zone_device *tz)
+		int thermal_zone_get_offset(struct thermal_zone *tz)
 
 	This interface is used to read the offset attribute value
 	for the thermal zone device, which might be useful for platform
@@ -256,7 +256,7 @@ temperature) and throttle appropriate devices.
 
     ::
 
-	int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
+	int thermal_zone_bind_cooling_device(struct thermal_zone *tz,
 		int trip, struct thermal_cooling_device *cdev,
 		unsigned long upper, unsigned long lower, unsigned int weight);
 
@@ -286,7 +286,7 @@ temperature) and throttle appropriate devices.
 
     ::
 
-	int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
+	int thermal_zone_unbind_cooling_device(struct thermal_zone *tz,
 				int trip, struct thermal_cooling_device *cdev);
 
     This interface function unbinds a thermal cooling device from a particular
@@ -446,7 +446,7 @@ Please read Documentation/hwmon/sysfs-interface.rst for additional information.
 ACPI thermal zone may support multiple trip points like critical, hot,
 passive, active. If an ACPI thermal zone supports critical, passive,
 active[0] and active[1] at the same time, it may register itself as a
-thermal_zone_device (thermal_zone1) with 4 trip points in all.
+thermal_zone (thermal_zone1) with 4 trip points in all.
 It has one processor and one fan, which are both registered as
 thermal_cooling_device. Both are considered to have the same
 effectiveness in cooling the thermal zone.
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 539660ef93c7..23373af58565 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -168,7 +168,7 @@ struct acpi_thermal {
 	struct acpi_thermal_state state;
 	struct acpi_thermal_trips trips;
 	struct acpi_handle_list devices;
-	struct thermal_zone_device *thermal_zone;
+	struct thermal_zone *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
 	struct mutex thermal_check_lock;
@@ -498,7 +498,7 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 
 /* sys I/F for generic thermal sysfs support */
 
-static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
+static int thermal_get_temp(struct thermal_zone *thermal, int *temp)
 {
 	struct acpi_thermal *tz = thermal->devdata;
 	int result;
@@ -515,7 +515,7 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
 	return 0;
 }
 
-static int thermal_get_trip_type(struct thermal_zone_device *thermal,
+static int thermal_get_trip_type(struct thermal_zone *thermal,
 				 int trip, enum thermal_trip_type *type)
 {
 	struct acpi_thermal *tz = thermal->devdata;
@@ -560,7 +560,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	return -EINVAL;
 }
 
-static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
+static int thermal_get_trip_temp(struct thermal_zone *thermal,
 				 int trip, int *temp)
 {
 	struct acpi_thermal *tz = thermal->devdata;
@@ -613,7 +613,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	return -EINVAL;
 }
 
-static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
+static int thermal_get_crit_temp(struct thermal_zone *thermal,
 				int *temperature)
 {
 	struct acpi_thermal *tz = thermal->devdata;
@@ -627,7 +627,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 		return -EINVAL;
 }
 
-static int thermal_get_trend(struct thermal_zone_device *thermal,
+static int thermal_get_trend(struct thermal_zone *thermal,
 				int trip, enum thermal_trend *trend)
 {
 	struct acpi_thermal *tz = thermal->devdata;
@@ -670,7 +670,7 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)
+static void acpi_thermal_zone_hot(struct thermal_zone *thermal)
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
@@ -679,7 +679,7 @@ static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)
 					ACPI_THERMAL_NOTIFY_HOT, 1);
 }
 
-static void acpi_thermal_zone_device_critical(struct thermal_zone_device *thermal)
+static void acpi_thermal_zone_critical(struct thermal_zone *thermal)
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
@@ -687,10 +687,10 @@ static void acpi_thermal_zone_device_critical(struct thermal_zone_device *therma
 					dev_name(&tz->device->dev),
 					ACPI_THERMAL_NOTIFY_CRITICAL, 1);
 
-	thermal_zone_device_critical(thermal);
+	thermal_zone_critical(thermal);
 }
 
-static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
+static int acpi_thermal_cooling_device_cb(struct thermal_zone *thermal,
 					struct thermal_cooling_device *cdev,
 					bool bind)
 {
@@ -761,20 +761,20 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 }
 
 static int
-acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
+acpi_thermal_bind_cooling_device(struct thermal_zone *thermal,
 					struct thermal_cooling_device *cdev)
 {
 	return acpi_thermal_cooling_device_cb(thermal, cdev, true);
 }
 
 static int
-acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
+acpi_thermal_unbind_cooling_device(struct thermal_zone *thermal,
 					struct thermal_cooling_device *cdev)
 {
 	return acpi_thermal_cooling_device_cb(thermal, cdev, false);
 }
 
-static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
+static struct thermal_zone_ops acpi_thermal_zone_ops = {
 	.bind = acpi_thermal_bind_cooling_device,
 	.unbind	= acpi_thermal_unbind_cooling_device,
 	.get_temp = thermal_get_temp,
@@ -782,8 +782,8 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.get_trip_temp = thermal_get_trip_temp,
 	.get_crit_temp = thermal_get_crit_temp,
 	.get_trend = thermal_get_trend,
-	.hot = acpi_thermal_zone_device_hot,
-	.critical = acpi_thermal_zone_device_critical,
+	.hot = acpi_thermal_zone_hot,
+	.critical = acpi_thermal_zone_critical,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
@@ -807,13 +807,13 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
+			thermal_zone_register("acpitz", trips, 0, tz,
 						&acpi_thermal_zone_ops, NULL,
 						     tz->trips.passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
+			thermal_zone_register("acpitz", trips, 0, tz,
 						&acpi_thermal_zone_ops, NULL,
 						0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
@@ -836,7 +836,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 		goto remove_dev_link;
 	}
 
-	result = thermal_zone_device_enable(tz->thermal_zone);
+	result = thermal_zone_enable(tz->thermal_zone);
 	if (result)
 		goto acpi_bus_detach;
 
@@ -852,7 +852,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 remove_tz_link:
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 unregister_tzd:
-	thermal_zone_device_unregister(tz->thermal_zone);
+	thermal_zone_unregister(tz->thermal_zone);
 
 	return result;
 }
@@ -861,7 +861,7 @@ static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
-	thermal_zone_device_unregister(tz->thermal_zone);
+	thermal_zone_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
 }
@@ -1011,7 +1011,7 @@ static void acpi_thermal_check_fn(struct work_struct *work)
 
 	mutex_lock(&tz->thermal_check_lock);
 
-	thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
 
 	refcount_inc(&tz->thermal_check_count);
 
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 37b6bb90e46e..31dba1741244 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -73,7 +73,7 @@ struct repaper_epd {
 	struct gpio_desc *reset;
 	struct gpio_desc *busy;
 
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 
 	unsigned int height;
 	unsigned int width;
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 989e2c8496dd..a4e36c259de9 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -63,7 +63,7 @@ struct hwmon_thermal_data {
 	struct list_head node;		/* hwmon tzdata list entry */
 	struct device *dev;		/* Reference to hwmon device */
 	int index;			/* sensor index */
-	struct thermal_zone_device *tzd;/* thermal zone device */
+	struct thermal_zone *tzd;/* thermal zone device */
 };
 
 static ssize_t
@@ -217,7 +217,7 @@ static int hwmon_thermal_add_sensor(struct device *dev, int index)
 {
 	struct hwmon_device *hwdev = to_hwmon_device(dev);
 	struct hwmon_thermal_data *tdata;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	int err;
 
 	tdata = devm_kzalloc(dev, sizeof(*tdata), GFP_KERNEL);
@@ -286,7 +286,7 @@ static void hwmon_thermal_notify(struct device *dev, int index)
 
 	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
 		if (tzdata->index == index) {
-			thermal_zone_device_update(tzdata->tzd,
+			thermal_zone_update(tzdata->tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 	}
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 5187c6dd5a4f..2f377406f285 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -263,7 +263,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&scpi_sensors->thermal_zones);
 	for (i = 0; i < nr_sensors; i++) {
 		struct sensor_data *sensor = &scpi_sensors->data[i];
-		struct thermal_zone_device *z;
+		struct thermal_zone *z;
 		struct scpi_thermal_zone *zone;
 
 		if (sensor->info.class != TEMPERATURE)
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..546d7c87957d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -102,7 +102,7 @@ struct sun4i_gpadc_iio {
 	bool				no_irq;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
-	struct thermal_zone_device	*tzd;
+	struct thermal_zone	*tzd;
 	struct device			*sensor_device;
 };
 
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 742a7e96c1b5..21ac40a06fe1 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -237,7 +237,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device *hwmon;
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 	int error;
 	u32 reg;
 	bool ts_attached;
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 64e27c2821f9..03e3ec30a9d6 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -319,7 +319,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
-	struct thermal_zone_device *thermal_dev;
+	struct thermal_zone *thermal_dev;
 	struct device *dev = omap_host->dev;
 	struct mmc_ios *ios = &mmc->ios;
 	u32 start_window = 0, max_window = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 5657ac8cfca0..ac80b109bc2d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1078,7 +1078,7 @@ struct mbox_list {
 
 #if IS_ENABLED(CONFIG_THERMAL)
 struct ch_thermal {
-	struct thermal_zone_device *tzdev;
+	struct thermal_zone *tzdev;
 	int trip_temp;
 	int trip_type;
 };
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
index 9a6d65243334..460a26699f68 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -9,7 +9,7 @@
 
 #define CXGB4_NUM_TRIPS 1
 
-static int cxgb4_thermal_get_temp(struct thermal_zone_device *tzdev,
+static int cxgb4_thermal_get_temp(struct thermal_zone *tzdev,
 				  int *temp)
 {
 	struct adapter *adap = tzdev->devdata;
@@ -29,7 +29,7 @@ static int cxgb4_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int cxgb4_thermal_get_trip_type(struct thermal_zone_device *tzdev,
+static int cxgb4_thermal_get_trip_type(struct thermal_zone *tzdev,
 				       int trip, enum thermal_trip_type *type)
 {
 	struct adapter *adap = tzdev->devdata;
@@ -41,7 +41,7 @@ static int cxgb4_thermal_get_trip_type(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int cxgb4_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
+static int cxgb4_thermal_get_trip_temp(struct thermal_zone *tzdev,
 				       int trip, int *temp)
 {
 	struct adapter *adap = tzdev->devdata;
@@ -53,7 +53,7 @@ static int cxgb4_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_device_ops cxgb4_thermal_ops = {
+static struct thermal_zone_ops cxgb4_thermal_ops = {
 	.get_temp = cxgb4_thermal_get_temp,
 	.get_trip_type = cxgb4_thermal_get_trip_type,
 	.get_trip_temp = cxgb4_thermal_get_trip_temp,
@@ -84,7 +84,7 @@ int cxgb4_thermal_init(struct adapter *adap)
 	}
 
 	snprintf(ch_tz_name, sizeof(ch_tz_name), "cxgb4_%s", adap->name);
-	ch_thermal->tzdev = thermal_zone_device_register(ch_tz_name, num_trip,
+	ch_thermal->tzdev = thermal_zone_register(ch_tz_name, num_trip,
 							 0, adap,
 							 &cxgb4_thermal_ops,
 							 NULL, 0, 0);
@@ -95,10 +95,10 @@ int cxgb4_thermal_init(struct adapter *adap)
 		return ret;
 	}
 
-	ret = thermal_zone_device_enable(ch_thermal->tzdev);
+	ret = thermal_zone_enable(ch_thermal->tzdev);
 	if (ret) {
 		dev_err(adap->pdev_dev, "Failed to enable thermal zone\n");
-		thermal_zone_device_unregister(adap->ch_thermal.tzdev);
+		thermal_zone_unregister(adap->ch_thermal.tzdev);
 		return ret;
 	}
 
@@ -108,7 +108,7 @@ int cxgb4_thermal_init(struct adapter *adap)
 int cxgb4_thermal_remove(struct adapter *adap)
 {
 	if (adap->ch_thermal.tzdev) {
-		thermal_zone_device_unregister(adap->ch_thermal.tzdev);
+		thermal_zone_unregister(adap->ch_thermal.tzdev);
 		adap->ch_thermal.tzdev = NULL;
 	}
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 05f54bd982c0..f70ca5525202 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -79,7 +79,7 @@ struct mlxsw_thermal;
 
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
-	struct thermal_zone_device *tzdev;
+	struct thermal_zone *tzdev;
 	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	int module; /* Module or gearbox number */
 };
@@ -87,7 +87,7 @@ struct mlxsw_thermal_module {
 struct mlxsw_thermal {
 	struct mlxsw_core *core;
 	const struct mlxsw_bus_info *bus_info;
-	struct thermal_zone_device *tzdev;
+	struct thermal_zone *tzdev;
 	int polling_delay;
 	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
 	u8 cooling_levels[MLXSW_THERMAL_MAX_STATE + 1];
@@ -97,7 +97,7 @@ struct mlxsw_thermal {
 	struct mlxsw_thermal_module *tz_gearbox_arr;
 	u8 tz_gearbox_num;
 	unsigned int tz_highest_score;
-	struct thermal_zone_device *tz_highest_dev;
+	struct thermal_zone *tz_highest_dev;
 };
 
 static inline u8 mlxsw_state_to_duty(int state)
@@ -187,7 +187,7 @@ mlxsw_thermal_module_trips_update(struct device *dev, struct mlxsw_core *core,
 }
 
 static void mlxsw_thermal_tz_score_update(struct mlxsw_thermal *thermal,
-					  struct thermal_zone_device *tzdev,
+					  struct thermal_zone *tzdev,
 					  struct mlxsw_thermal_trip *trips,
 					  int temp)
 {
@@ -214,7 +214,7 @@ static void mlxsw_thermal_tz_score_update(struct mlxsw_thermal *thermal,
 	}
 }
 
-static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_bind(struct thermal_zone *tzdev,
 			      struct thermal_cooling_device *cdev)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -240,7 +240,7 @@ static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_unbind(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_unbind(struct thermal_zone *tzdev,
 				struct thermal_cooling_device *cdev)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -262,7 +262,7 @@ static int mlxsw_thermal_unbind(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_get_temp(struct thermal_zone *tzdev,
 				  int *p_temp)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -287,7 +287,7 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_get_trip_type(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_get_trip_type(struct thermal_zone *tzdev,
 				       int trip,
 				       enum thermal_trip_type *p_type)
 {
@@ -300,7 +300,7 @@ static int mlxsw_thermal_get_trip_type(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_get_trip_temp(struct thermal_zone *tzdev,
 				       int trip, int *p_temp)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -312,7 +312,7 @@ static int mlxsw_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_set_trip_temp(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_set_trip_temp(struct thermal_zone *tzdev,
 				       int trip, int temp)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -324,7 +324,7 @@ static int mlxsw_thermal_set_trip_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_get_trip_hyst(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_get_trip_hyst(struct thermal_zone *tzdev,
 				       int trip, int *p_hyst)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -333,7 +333,7 @@ static int mlxsw_thermal_get_trip_hyst(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_set_trip_hyst(struct thermal_zone *tzdev,
 				       int trip, int hyst)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -342,7 +342,7 @@ static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_trend_get(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_trend_get(struct thermal_zone *tzdev,
 				   int trip, enum thermal_trend *trend)
 {
 	struct mlxsw_thermal *thermal = tzdev->devdata;
@@ -361,7 +361,7 @@ static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
 
-static struct thermal_zone_device_ops mlxsw_thermal_ops = {
+static struct thermal_zone_ops mlxsw_thermal_ops = {
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
 	.get_temp = mlxsw_thermal_get_temp,
@@ -373,7 +373,7 @@ static struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.get_trend	= mlxsw_thermal_trend_get,
 };
 
-static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_module_bind(struct thermal_zone *tzdev,
 				     struct thermal_cooling_device *cdev)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -402,7 +402,7 @@ static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
 	return err;
 }
 
-static int mlxsw_thermal_module_unbind(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_module_unbind(struct thermal_zone *tzdev,
 				       struct thermal_cooling_device *cdev)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -447,7 +447,7 @@ mlxsw_thermal_module_temp_and_thresholds_get(struct mlxsw_core *core,
 			      NULL);
 }
 
-static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_module_temp_get(struct thermal_zone *tzdev,
 					 int *p_temp)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -479,7 +479,7 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 }
 
 static int
-mlxsw_thermal_module_trip_type_get(struct thermal_zone_device *tzdev, int trip,
+mlxsw_thermal_module_trip_type_get(struct thermal_zone *tzdev, int trip,
 				   enum thermal_trip_type *p_type)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -492,7 +492,7 @@ mlxsw_thermal_module_trip_type_get(struct thermal_zone_device *tzdev, int trip,
 }
 
 static int
-mlxsw_thermal_module_trip_temp_get(struct thermal_zone_device *tzdev,
+mlxsw_thermal_module_trip_temp_get(struct thermal_zone *tzdev,
 				   int trip, int *p_temp)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -505,7 +505,7 @@ mlxsw_thermal_module_trip_temp_get(struct thermal_zone_device *tzdev,
 }
 
 static int
-mlxsw_thermal_module_trip_temp_set(struct thermal_zone_device *tzdev,
+mlxsw_thermal_module_trip_temp_set(struct thermal_zone *tzdev,
 				   int trip, int temp)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -518,7 +518,7 @@ mlxsw_thermal_module_trip_temp_set(struct thermal_zone_device *tzdev,
 }
 
 static int
-mlxsw_thermal_module_trip_hyst_get(struct thermal_zone_device *tzdev, int trip,
+mlxsw_thermal_module_trip_hyst_get(struct thermal_zone *tzdev, int trip,
 				   int *p_hyst)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -528,7 +528,7 @@ mlxsw_thermal_module_trip_hyst_get(struct thermal_zone_device *tzdev, int trip,
 }
 
 static int
-mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
+mlxsw_thermal_module_trip_hyst_set(struct thermal_zone *tzdev, int trip,
 				   int hyst)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -537,7 +537,7 @@ mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
 	return 0;
 }
 
-static int mlxsw_thermal_module_trend_get(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_module_trend_get(struct thermal_zone *tzdev,
 					  int trip, enum thermal_trend *trend)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -553,7 +553,7 @@ static int mlxsw_thermal_module_trend_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
+static struct thermal_zone_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
@@ -565,7 +565,7 @@ static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.get_trend	= mlxsw_thermal_module_trend_get,
 };
 
-static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
+static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone *tzdev,
 					  int *p_temp)
 {
 	struct mlxsw_thermal_module *tz = tzdev->devdata;
@@ -590,7 +590,7 @@ static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
+static struct thermal_zone_ops mlxsw_thermal_gearbox_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
@@ -677,7 +677,7 @@ mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 
 	snprintf(tz_name, sizeof(tz_name), "mlxsw-module%d",
 		 module_tz->module + 1);
-	module_tz->tzdev = thermal_zone_device_register(tz_name,
+	module_tz->tzdev = thermal_zone_register(tz_name,
 							MLXSW_THERMAL_NUM_TRIPS,
 							MLXSW_THERMAL_TRIP_MASK,
 							module_tz,
@@ -690,16 +690,16 @@ mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 		return err;
 	}
 
-	err = thermal_zone_device_enable(module_tz->tzdev);
+	err = thermal_zone_enable(module_tz->tzdev);
 	if (err)
-		thermal_zone_device_unregister(module_tz->tzdev);
+		thermal_zone_unregister(module_tz->tzdev);
 
 	return err;
 }
 
-static void mlxsw_thermal_module_tz_fini(struct thermal_zone_device *tzdev)
+static void mlxsw_thermal_module_tz_fini(struct thermal_zone *tzdev)
 {
-	thermal_zone_device_unregister(tzdev);
+	thermal_zone_unregister(tzdev);
 }
 
 static int
@@ -803,7 +803,7 @@ mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 
 	snprintf(tz_name, sizeof(tz_name), "mlxsw-gearbox%d",
 		 gearbox_tz->module + 1);
-	gearbox_tz->tzdev = thermal_zone_device_register(tz_name,
+	gearbox_tz->tzdev = thermal_zone_register(tz_name,
 						MLXSW_THERMAL_NUM_TRIPS,
 						MLXSW_THERMAL_TRIP_MASK,
 						gearbox_tz,
@@ -813,9 +813,9 @@ mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 	if (IS_ERR(gearbox_tz->tzdev))
 		return PTR_ERR(gearbox_tz->tzdev);
 
-	ret = thermal_zone_device_enable(gearbox_tz->tzdev);
+	ret = thermal_zone_enable(gearbox_tz->tzdev);
 	if (ret)
-		thermal_zone_device_unregister(gearbox_tz->tzdev);
+		thermal_zone_unregister(gearbox_tz->tzdev);
 
 	return ret;
 }
@@ -823,7 +823,7 @@ mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 static void
 mlxsw_thermal_gearbox_tz_fini(struct mlxsw_thermal_module *gearbox_tz)
 {
-	thermal_zone_device_unregister(gearbox_tz->tzdev);
+	thermal_zone_unregister(gearbox_tz->tzdev);
 }
 
 static int
@@ -957,7 +957,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 				 MLXSW_THERMAL_SLOW_POLL_INT :
 				 MLXSW_THERMAL_POLL_INT;
 
-	thermal->tzdev = thermal_zone_device_register("mlxsw",
+	thermal->tzdev = thermal_zone_register("mlxsw",
 						      MLXSW_THERMAL_NUM_TRIPS,
 						      MLXSW_THERMAL_TRIP_MASK,
 						      thermal,
@@ -978,7 +978,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	if (err)
 		goto err_thermal_gearboxes_init;
 
-	err = thermal_zone_device_enable(thermal->tzdev);
+	err = thermal_zone_enable(thermal->tzdev);
 	if (err)
 		goto err_thermal_zone_device_enable;
 
@@ -991,7 +991,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	mlxsw_thermal_modules_fini(thermal);
 err_thermal_modules_init:
 	if (thermal->tzdev) {
-		thermal_zone_device_unregister(thermal->tzdev);
+		thermal_zone_unregister(thermal->tzdev);
 		thermal->tzdev = NULL;
 	}
 err_thermal_zone_device_register:
@@ -1012,7 +1012,7 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
 	mlxsw_thermal_gearboxes_fini(thermal);
 	mlxsw_thermal_modules_fini(thermal);
 	if (thermal->tzdev) {
-		thermal_zone_device_unregister(thermal->tzdev);
+		thermal_zone_unregister(thermal->tzdev);
 		thermal->tzdev = NULL;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c6bc85d4600a..8c22dd38f385 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -503,7 +503,7 @@ struct iwl_mvm_tt_mgmt {
 struct iwl_mvm_thermal_device {
 	s16 temp_trips[IWL_MAX_DTS_TRIPS];
 	u8 fw_trips_index[IWL_MAX_DTS_TRIPS];
-	struct thermal_zone_device *tzone;
+	struct thermal_zone *tzone;
 };
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 69cf3a372759..e20e5e46d342 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -146,7 +146,7 @@ void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	if (mvm->tz_device.tzone) {
 		struct iwl_mvm_thermal_device *tz_dev = &mvm->tz_device;
 
-		thermal_zone_device_update(tz_dev->tzone,
+		thermal_zone_update(tz_dev->tzone,
 					   THERMAL_TRIP_VIOLATED);
 	}
 #endif /* CONFIG_THERMAL */
@@ -612,7 +612,7 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 }
 
 #ifdef CONFIG_THERMAL
-static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
+static int iwl_mvm_tzone_get_temp(struct thermal_zone *device,
 				  int *temperature)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
@@ -638,7 +638,7 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 	return ret;
 }
 
-static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone_device *device,
+static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone *device,
 				       int trip, int *temp)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
@@ -651,7 +651,7 @@ static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone_device *device,
 	return 0;
 }
 
-static int iwl_mvm_tzone_get_trip_type(struct thermal_zone_device *device,
+static int iwl_mvm_tzone_get_trip_type(struct thermal_zone *device,
 				       int trip, enum thermal_trip_type *type)
 {
 	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS)
@@ -662,7 +662,7 @@ static int iwl_mvm_tzone_get_trip_type(struct thermal_zone_device *device,
 	return 0;
 }
 
-static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
+static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone *device,
 				       int trip, int temp)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
@@ -718,7 +718,7 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 	return ret;
 }
 
-static  struct thermal_zone_device_ops tzone_ops = {
+static  struct thermal_zone_ops tzone_ops = {
 	.get_temp = iwl_mvm_tzone_get_temp,
 	.get_trip_temp = iwl_mvm_tzone_get_trip_temp,
 	.get_trip_type = iwl_mvm_tzone_get_trip_type,
@@ -743,7 +743,7 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
 
 	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
-	mvm->tz_device.tzone = thermal_zone_device_register(name,
+	mvm->tz_device.tzone = thermal_zone_register(name,
 							IWL_MAX_DTS_TRIPS,
 							IWL_WRITABLE_TRIPS_MSK,
 							mvm, &tzone_ops,
@@ -756,10 +756,10 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 		return;
 	}
 
-	ret = thermal_zone_device_enable(mvm->tz_device.tzone);
+	ret = thermal_zone_enable(mvm->tz_device.tzone);
 	if (ret) {
 		IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone\n");
-		thermal_zone_device_unregister(mvm->tz_device.tzone);
+		thermal_zone_unregister(mvm->tz_device.tzone);
 		return;
 	}
 
@@ -851,7 +851,7 @@ static void iwl_mvm_thermal_zone_unregister(struct iwl_mvm *mvm)
 
 	IWL_DEBUG_TEMP(mvm, "Thermal zone device unregister\n");
 	if (mvm->tz_device.tzone) {
-		thermal_zone_device_unregister(mvm->tz_device.tzone);
+		thermal_zone_unregister(mvm->tz_device.tzone);
 		mvm->tz_device.tzone = NULL;
 	}
 }
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 3463629f8764..f6be06d1e723 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -78,7 +78,7 @@ static unsigned int fanstate = ACERHDF_FAN_AUTO;
 static char force_bios[16];
 static char force_product[16];
 static unsigned int prev_interval;
-static struct thermal_zone_device *thz_dev;
+static struct thermal_zone *thz_dev;
 static struct thermal_cooling_device *cl_dev;
 static struct platform_device *acerhdf_dev;
 
@@ -318,7 +318,7 @@ static void acerhdf_change_fanstate(int state)
 	}
 }
 
-static void acerhdf_check_param(struct thermal_zone_device *thermal)
+static void acerhdf_check_param(struct thermal_zone *thermal)
 {
 	if (fanon > ACERHDF_MAX_FANON) {
 		pr_err("fanon temperature too high, set to %d\n",
@@ -349,7 +349,7 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
  * as late as the polling interval is since we can't do that in the respective
  * accessors of the module parameters.
  */
-static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, int *t)
+static int acerhdf_get_ec_temp(struct thermal_zone *thermal, int *t)
 {
 	int temp, err = 0;
 
@@ -364,7 +364,7 @@ static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, int *t)
 	return 0;
 }
 
-static int acerhdf_bind(struct thermal_zone_device *thermal,
+static int acerhdf_bind(struct thermal_zone *thermal,
 			struct thermal_cooling_device *cdev)
 {
 	/* if the cooling device is the one from acerhdf bind it */
@@ -380,7 +380,7 @@ static int acerhdf_bind(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int acerhdf_unbind(struct thermal_zone_device *thermal,
+static int acerhdf_unbind(struct thermal_zone *thermal,
 			  struct thermal_cooling_device *cdev)
 {
 	if (cdev != cl_dev)
@@ -413,7 +413,7 @@ static inline void acerhdf_enable_kernelmode(void)
  *          the temperature and the fan.
  * disabled: the BIOS takes control of the fan.
  */
-static int acerhdf_change_mode(struct thermal_zone_device *thermal,
+static int acerhdf_change_mode(struct thermal_zone *thermal,
 			       enum thermal_device_mode mode)
 {
 	if (mode == THERMAL_DEVICE_DISABLED && kernelmode)
@@ -424,7 +424,7 @@ static int acerhdf_change_mode(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int acerhdf_get_trip_type(struct thermal_zone_device *thermal, int trip,
+static int acerhdf_get_trip_type(struct thermal_zone *thermal, int trip,
 				 enum thermal_trip_type *type)
 {
 	if (trip == 0)
@@ -437,7 +437,7 @@ static int acerhdf_get_trip_type(struct thermal_zone_device *thermal, int trip,
 	return 0;
 }
 
-static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, int trip,
+static int acerhdf_get_trip_hyst(struct thermal_zone *thermal, int trip,
 				 int *temp)
 {
 	if (trip != 0)
@@ -448,7 +448,7 @@ static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, int trip,
 	return 0;
 }
 
-static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, int trip,
+static int acerhdf_get_trip_temp(struct thermal_zone *thermal, int trip,
 				 int *temp)
 {
 	if (trip == 0)
@@ -461,7 +461,7 @@ static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, int trip,
 	return 0;
 }
 
-static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
+static int acerhdf_get_crit_temp(struct thermal_zone *thermal,
 				 int *temperature)
 {
 	*temperature = ACERHDF_TEMP_CRIT;
@@ -469,7 +469,7 @@ static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 }
 
 /* bind callback functions to thermalzone */
-static struct thermal_zone_device_ops acerhdf_dev_ops = {
+static struct thermal_zone_ops acerhdf_dev_ops = {
 	.bind = acerhdf_bind,
 	.unbind = acerhdf_unbind,
 	.get_temp = acerhdf_get_ec_temp,
@@ -710,7 +710,7 @@ static int __init acerhdf_register_thermal(void)
 	if (IS_ERR(cl_dev))
 		return -EINVAL;
 
-	thz_dev = thermal_zone_device_register("acerhdf", 2, 0, NULL,
+	thz_dev = thermal_zone_register("acerhdf", 2, 0, NULL,
 					      &acerhdf_dev_ops,
 					      &acerhdf_zone_params, 0,
 					      (kernelmode) ? interval*1000 : 0);
@@ -718,9 +718,9 @@ static int __init acerhdf_register_thermal(void)
 		return -EINVAL;
 
 	if (kernelmode)
-		ret = thermal_zone_device_enable(thz_dev);
+		ret = thermal_zone_enable(thz_dev);
 	else
-		ret = thermal_zone_device_disable(thz_dev);
+		ret = thermal_zone_disable(thz_dev);
 	if (ret)
 		return ret;
 
@@ -742,7 +742,7 @@ static void acerhdf_unregister_thermal(void)
 	}
 
 	if (thz_dev) {
-		thermal_zone_device_unregister(thz_dev);
+		thermal_zone_unregister(thz_dev);
 		thz_dev = NULL;
 	}
 }
diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 7a20f68ae206..f54db299b2b1 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -44,8 +44,8 @@ MODULE_PARM_DESC(speed_on_ac,
 
 struct gpd_pocket_fan_data {
 	struct device *dev;
-	struct thermal_zone_device *dts0;
-	struct thermal_zone_device *dts1;
+	struct thermal_zone *dts0;
+	struct thermal_zone *dts1;
 	struct gpio_desc *gpio0;
 	struct gpio_desc *gpio1;
 	struct delayed_work work;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d925cb137e12..51b052774478 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1130,7 +1130,7 @@ static bool psy_has_property(const struct power_supply_desc *psy_desc,
 }
 
 #ifdef CONFIG_THERMAL
-static int power_supply_read_temp(struct thermal_zone_device *tzd,
+static int power_supply_read_temp(struct thermal_zone *tzd,
 		int *temp)
 {
 	struct power_supply *psy;
@@ -1149,7 +1149,7 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 	return ret;
 }
 
-static struct thermal_zone_device_ops psy_tzd_ops = {
+static struct thermal_zone_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
@@ -1162,13 +1162,13 @@ static int psy_register_thermal(struct power_supply *psy)
 
 	/* Register battery zone device psy reports temperature */
 	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
-		psy->tzd = thermal_zone_device_register(psy->desc->name,
+		psy->tzd = thermal_zone_register(psy->desc->name,
 				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
 		if (IS_ERR(psy->tzd))
 			return PTR_ERR(psy->tzd);
-		ret = thermal_zone_device_enable(psy->tzd);
+		ret = thermal_zone_enable(psy->tzd);
 		if (ret)
-			thermal_zone_device_unregister(psy->tzd);
+			thermal_zone_unregister(psy->tzd);
 		return ret;
 	}
 
@@ -1179,7 +1179,7 @@ static void psy_unregister_thermal(struct power_supply *psy)
 {
 	if (IS_ERR_OR_NULL(psy->tzd))
 		return;
-	thermal_zone_device_unregister(psy->tzd);
+	thermal_zone_unregister(psy->tzd);
 }
 
 /* thermal cooling device callbacks */
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index cb7e50003f70..eefe43cb4035 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -124,7 +124,7 @@ struct max8973_chip {
 	enum device_id id;
 	int junction_temp_warning;
 	int irq;
-	struct thermal_zone_device *tz_device;
+	struct thermal_zone *tz_device;
 };
 
 /*
@@ -472,7 +472,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 {
 	struct max8973_chip *mchip = data;
 
-	thermal_zone_device_update(mchip->tz_device,
+	thermal_zone_update(mchip->tz_device,
 				   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
@@ -484,7 +484,7 @@ static const struct thermal_zone_of_device_ops max77621_tz_ops = {
 
 static int max8973_thermal_init(struct max8973_chip *mchip)
 {
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct irq_data *irq_data;
 	unsigned long irq_flags = 0;
 	int ret;
diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index e61b91d14ad1..f59342bcd4c9 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -101,7 +101,7 @@ struct amlogic_thermal {
 	struct regmap *regmap;
 	struct regmap *sec_ao_map;
 	struct clk *clk;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	u32 trim_info;
 };
 
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..18707f34df1b 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -72,7 +72,7 @@ struct armada_thermal_priv {
 	/* serialize temperature reads/updates */
 	struct mutex update_lock;
 	struct armada_thermal_data *data;
-	struct thermal_zone_device *overheat_sensor;
+	struct thermal_zone *overheat_sensor;
 	int interrupt_source;
 	int current_channel;
 	long current_threshold;
@@ -120,7 +120,7 @@ struct armada_drvdata {
 	} type;
 	union {
 		struct armada_thermal_priv *priv;
-		struct thermal_zone_device *tz;
+		struct thermal_zone *tz;
 	} data;
 };
 
@@ -397,7 +397,7 @@ static int armada_read_sensor(struct armada_thermal_priv *priv, int *temp)
 	return 0;
 }
 
-static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
+static int armada_get_temp_legacy(struct thermal_zone *thermal,
 				  int *temp)
 {
 	struct armada_thermal_priv *priv = thermal->devdata;
@@ -416,7 +416,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	return ret;
 }
 
-static struct thermal_zone_device_ops legacy_ops = {
+static struct thermal_zone_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
@@ -542,7 +542,7 @@ static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 	int ret;
 
 	/* Notify the core in thread context */
-	thermal_zone_device_update(priv->overheat_sensor,
+	thermal_zone_update(priv->overheat_sensor,
 				   THERMAL_EVENT_UNSPECIFIED);
 
 	/*
@@ -562,7 +562,7 @@ static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
 
 	/* Notify the thermal core that the temperature is acceptable again */
-	thermal_zone_device_update(priv->overheat_sensor,
+	thermal_zone_update(priv->overheat_sensor,
 				   THERMAL_EVENT_UNSPECIFIED);
 
 enable_irq:
@@ -781,7 +781,7 @@ static void armada_set_sane_name(struct platform_device *pdev,
  * switch during overheat situations.
  */
 static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
-					 struct thermal_zone_device *tz,
+					 struct thermal_zone *tz,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
@@ -816,7 +816,7 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 
 static int armada_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct armada_thermal_sensor *sensor;
 	struct armada_drvdata *drvdata;
 	const struct of_device_id *match;
@@ -866,7 +866,7 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Wait the sensors to be valid */
 		armada_wait_sensor_validity(priv);
 
-		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
+		tz = thermal_zone_register(priv->zone_name, 0, 0, priv,
 						  &legacy_ops, NULL, 0, 0);
 		if (IS_ERR(tz)) {
 			dev_err(&pdev->dev,
@@ -874,9 +874,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 			return PTR_ERR(tz);
 		}
 
-		ret = thermal_zone_device_enable(tz);
+		ret = thermal_zone_enable(tz);
 		if (ret) {
-			thermal_zone_device_unregister(tz);
+			thermal_zone_unregister(tz);
 			return ret;
 		}
 
@@ -959,7 +959,7 @@ static int armada_thermal_exit(struct platform_device *pdev)
 	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
 	if (drvdata->type == LEGACY)
-		thermal_zone_device_unregister(drvdata->data.tz);
+		thermal_zone_unregister(drvdata->data.tz);
 
 	return 0;
 }
diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 1ec57d9ecf53..02a41aea1997 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -28,7 +28,7 @@
 
 struct bcm2711_thermal_priv {
 	struct regmap *regmap;
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 };
 
 static int bcm2711_get_temp(void *data, int *temp)
@@ -69,7 +69,7 @@ MODULE_DEVICE_TABLE(of, bcm2711_thermal_id_table);
 
 static int bcm2711_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 	struct bcm2711_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *parent;
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index c8e4344d5a3d..b057d7a921da 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -64,7 +64,7 @@
 #define BCM2835_TS_TSENSSTAT_INTERRUPT		BIT(11)
 
 struct bcm2835_thermal_data {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	void __iomem *regs;
 	struct clk *clk;
 	struct dentry *debugfsdir;
@@ -164,7 +164,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_thermal_of_match_table);
 static int bcm2835_thermal_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct bcm2835_thermal_data *data;
 	struct resource *res;
 	int err = 0;
@@ -287,7 +287,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 static int bcm2835_thermal_remove(struct platform_device *pdev)
 {
 	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tz;
+	struct thermal_zone *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
 	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 0cedb8b4f00a..050963efee6e 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -111,7 +111,7 @@ struct brcmstb_thermal_params {
 struct brcmstb_thermal_priv {
 	void __iomem *tmon_base;
 	struct device *dev;
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 	/* Process specific thermal parameters used for calculations */
 	const struct brcmstb_thermal_params *temp_params;
 };
@@ -255,7 +255,7 @@ static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
 	 * Notify using the interrupt temperature, in case the temperature
 	 * changes before it can next be read out
 	 */
-	thermal_zone_device_update(priv->thermal, intr);
+	thermal_zone_update(priv->thermal, intr);
 
 	return IRQ_HANDLED;
 }
@@ -319,7 +319,7 @@ MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
 static int brcmstb_thermal_probe(struct platform_device *pdev)
 {
 	const struct thermal_zone_of_device_ops *of_ops;
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 	struct brcmstb_thermal_priv *priv;
 	struct resource *res;
 	int irq, ret;
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index c9468ba9d449..045cc7e1544f 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -15,7 +15,7 @@
 #define PVTMON_STATUS					0x08
 
 struct ns_thermal {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	void __iomem *pvtmon;
 };
 
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 475ce2900771..9e9308cc8ad9 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -19,7 +19,7 @@
 #define SR_TMON_MAX_LIST        6
 
 struct sr_tmon {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	unsigned int crit_temp;
 	unsigned int tmon_id;
 	struct sr_thermal *priv;
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 180edec34e07..acabb93a5140 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -48,7 +48,7 @@ struct da9062_thermal_config {
 struct da9062_thermal {
 	struct da9062 *hw;
 	struct delayed_work work;
-	struct thermal_zone_device *zone;
+	struct thermal_zone *zone;
 	struct mutex lock; /* protection for da9062_thermal temperature */
 	int temperature;
 	int irq;
@@ -92,7 +92,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		mutex_lock(&thermal->lock);
 		thermal->temperature = DA9062_MILLI_CELSIUS(125);
 		mutex_unlock(&thermal->lock);
-		thermal_zone_device_update(thermal->zone,
+		thermal_zone_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 		delay = thermal->zone->passive_delay_jiffies;
@@ -103,7 +103,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 	mutex_lock(&thermal->lock);
 	thermal->temperature = DA9062_MILLI_CELSIUS(0);
 	mutex_unlock(&thermal->lock);
-	thermal_zone_device_update(thermal->zone,
+	thermal_zone_update(thermal->zone,
 				   THERMAL_EVENT_UNSPECIFIED);
 
 err_enable_irq:
@@ -120,7 +120,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
+static int da9062_thermal_get_trip_type(struct thermal_zone *z,
 					int trip,
 					enum thermal_trip_type *type)
 {
@@ -139,7 +139,7 @@ static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
 	return 0;
 }
 
-static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
+static int da9062_thermal_get_trip_temp(struct thermal_zone *z,
 					int trip,
 					int *temp)
 {
@@ -158,7 +158,7 @@ static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
 	return 0;
 }
 
-static int da9062_thermal_get_temp(struct thermal_zone_device *z,
+static int da9062_thermal_get_temp(struct thermal_zone *z,
 				   int *temp)
 {
 	struct da9062_thermal *thermal = z->devdata;
@@ -170,7 +170,7 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 	return 0;
 }
 
-static struct thermal_zone_device_ops da9062_thermal_ops = {
+static struct thermal_zone_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
 	.get_trip_type	= da9062_thermal_get_trip_type,
 	.get_trip_temp	= da9062_thermal_get_trip_temp,
@@ -228,7 +228,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register(thermal->config->name,
+	thermal->zone = thermal_zone_register(thermal->config->name,
 					1, 0, thermal,
 					&da9062_thermal_ops, NULL, pp_tmp,
 					0);
@@ -237,7 +237,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 		ret = PTR_ERR(thermal->zone);
 		goto err;
 	}
-	ret = thermal_zone_device_enable(thermal->zone);
+	ret = thermal_zone_enable(thermal->zone);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot enable thermal zone device\n");
 		goto err_zone;
@@ -268,7 +268,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 err_zone:
-	thermal_zone_device_unregister(thermal->zone);
+	thermal_zone_unregister(thermal->zone);
 err:
 	return ret;
 }
@@ -279,7 +279,7 @@ static int da9062_thermal_remove(struct platform_device *pdev)
 
 	free_irq(thermal->irq, thermal);
 	cancel_delayed_work_sync(&thermal->work);
-	thermal_zone_device_unregister(thermal->zone);
+	thermal_zone_unregister(thermal->zone);
 	return 0;
 }
 
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 21d4d6e6409a..758667c7ba76 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -52,7 +52,7 @@ static const unsigned long db8500_thermal_points[] = {
 };
 
 struct db8500_thermal_zone {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	enum thermal_trend trend;
 	unsigned long interpolated_temp;
 	unsigned int cur_index;
@@ -132,7 +132,7 @@ static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
 	dev_dbg(&th->tz->device,
 		"PRCMU set max %ld, min %ld\n", next_high, next_low);
 
-	thermal_zone_device_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
@@ -158,7 +158,7 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 		/* So we roof out 1 degree over the max point */
 		th->interpolated_temp = db8500_thermal_points[idx] + 1;
 
-	thermal_zone_device_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 73182eb94bc0..59a6adefde2f 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -83,7 +83,7 @@ static int dove_init_sensor(const struct dove_thermal_priv *priv)
 	return 0;
 }
 
-static int dove_get_temp(struct thermal_zone_device *thermal,
+static int dove_get_temp(struct thermal_zone *thermal,
 			  int *temp)
 {
 	unsigned long reg;
@@ -109,7 +109,7 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static struct thermal_zone_ops ops = {
 	.get_temp = dove_get_temp,
 };
 
@@ -120,7 +120,7 @@ static const struct of_device_id dove_thermal_id_table[] = {
 
 static int dove_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *thermal = NULL;
+	struct thermal_zone *thermal = NULL;
 	struct dove_thermal_priv *priv;
 	struct resource *res;
 	int ret;
@@ -145,7 +145,7 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	thermal = thermal_zone_device_register("dove_thermal", 0, 0,
+	thermal = thermal_zone_register("dove_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
@@ -153,9 +153,9 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal);
 	}
 
-	ret = thermal_zone_device_enable(thermal);
+	ret = thermal_zone_enable(thermal);
 	if (ret) {
-		thermal_zone_device_unregister(thermal);
+		thermal_zone_unregister(thermal);
 		return ret;
 	}
 
@@ -166,10 +166,10 @@ static int dove_thermal_probe(struct platform_device *pdev)
 
 static int dove_thermal_exit(struct platform_device *pdev)
 {
-	struct thermal_zone_device *dove_thermal =
+	struct thermal_zone *dove_thermal =
 		platform_get_drvdata(pdev);
 
-	thermal_zone_device_unregister(dove_thermal);
+	thermal_zone_unregister(dove_thermal);
 
 	return 0;
 }
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c54296d..c899d16c23a0 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -13,7 +13,7 @@
 
 #include "thermal_core.h"
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+static void thermal_zone_trip_update(struct thermal_zone *tz, int trip)
 {
 	int trip_temp, trip_hyst;
 	struct thermal_instance *instance;
@@ -71,7 +71,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * bang_bang_control - controls devices associated with the given zone
- * @tz: thermal_zone_device
+ * @tz: thermal_zone
  * @trip: the trip point
  *
  * Regulation Logic: a two point regulation, deliver cooling state depending
@@ -96,7 +96,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  *     (trip_temp - hyst) so that the fan gets turned off again.
  *
  */
-static int bang_bang_control(struct thermal_zone_device *tz, int trip)
+static int bang_bang_control(struct thermal_zone *tz, int trip)
 {
 	struct thermal_instance *instance;
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 1e5abf4822be..b039df7ab506 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -19,7 +19,7 @@
  * get_trip_level: - obtains the current trip level for a zone
  * @tz:		thermal zone device
  */
-static int get_trip_level(struct thermal_zone_device *tz)
+static int get_trip_level(struct thermal_zone *tz)
 {
 	int count = 0;
 	int trip_temp;
@@ -46,7 +46,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	return count;
 }
 
-static long get_target_state(struct thermal_zone_device *tz,
+static long get_target_state(struct thermal_zone *tz,
 		struct thermal_cooling_device *cdev, int percentage, int level)
 {
 	unsigned long max_state;
@@ -58,7 +58,7 @@ static long get_target_state(struct thermal_zone_device *tz,
 
 /**
  * fair_share_throttle - throttles devices associated with the given zone
- * @tz: thermal_zone_device
+ * @tz: thermal_zone
  * @trip: trip point index
  *
  * Throttling Logic: This uses three parameters to calculate the new
@@ -75,7 +75,7 @@ static long get_target_state(struct thermal_zone_device *tz,
  *	(Heavily assumes the trip points are in ascending order)
  * new_state of cooling device = P3 * P2 * P1
  */
-static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
+static int fair_share_throttle(struct thermal_zone *tz, int trip)
 {
 	struct thermal_instance *instance;
 	int total_weight = 0;
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 13e375751d22..dbb4c263eaaf 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -86,7 +86,7 @@ struct power_allocator_params {
  * this governor, provide a sustainable_power in the thermal zone's
  * thermal_zone_params.
  */
-static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
+static u32 estimate_sustainable_power(struct thermal_zone *tz)
 {
 	u32 sustainable_power = 0;
 	struct thermal_instance *instance;
@@ -121,7 +121,7 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
  * This function is used to update the estimation of the PID
  * controller constants in struct thermal_zone_parameters.
  */
-static void estimate_pid_constants(struct thermal_zone_device *tz,
+static void estimate_pid_constants(struct thermal_zone *tz,
 				   u32 sustainable_power, int trip_switch_on,
 				   int control_temp)
 {
@@ -172,7 +172,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
  * happen the new value is going to be estimated and updated. It is also used
  * after thermal zone binding, where the initial values where set to 0.
  */
-static u32 get_sustainable_power(struct thermal_zone_device *tz,
+static u32 get_sustainable_power(struct thermal_zone *tz,
 				 struct power_allocator_params *params,
 				 int control_temp)
 {
@@ -214,7 +214,7 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
  *
  * Return: The power budget for the next period.
  */
-static u32 pid_controller(struct thermal_zone_device *tz,
+static u32 pid_controller(struct thermal_zone *tz,
 			  int control_temp,
 			  u32 max_allocatable_power)
 {
@@ -380,7 +380,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 		}
 }
 
-static int allocate_power(struct thermal_zone_device *tz,
+static int allocate_power(struct thermal_zone *tz,
 			  int control_temp)
 {
 	struct thermal_instance *instance;
@@ -517,7 +517,7 @@ static int allocate_power(struct thermal_zone_device *tz,
  * governor won't do anything.  In fact, its throttle function
  * won't be called at all.
  */
-static void get_governor_trips(struct thermal_zone_device *tz,
+static void get_governor_trips(struct thermal_zone *tz,
 			       struct power_allocator_params *params)
 {
 	int i, last_active, last_passive;
@@ -570,7 +570,7 @@ static void reset_pid_controller(struct power_allocator_params *params)
 	params->prev_err = 0;
 }
 
-static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
+static void allow_maximum_power(struct thermal_zone *tz, bool update)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
@@ -613,7 +613,7 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
  * Return: 0 on success, -EINVAL if any cooling device does not implement
  * the power actor API.
  */
-static int check_power_actors(struct thermal_zone_device *tz)
+static int check_power_actors(struct thermal_zone *tz)
 {
 	struct thermal_instance *instance;
 	int ret = 0;
@@ -639,7 +639,7 @@ static int check_power_actors(struct thermal_zone_device *tz)
  * Return: 0 on success, or -ENOMEM if we ran out of memory, or -EINVAL
  * when there are unsupported cooling devices in the @tz.
  */
-static int power_allocator_bind(struct thermal_zone_device *tz)
+static int power_allocator_bind(struct thermal_zone *tz)
 {
 	int ret;
 	struct power_allocator_params *params;
@@ -690,7 +690,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	return ret;
 }
 
-static void power_allocator_unbind(struct thermal_zone_device *tz)
+static void power_allocator_unbind(struct thermal_zone *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
 
@@ -705,7 +705,7 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 	tz->governor_data = NULL;
 }
 
-static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
+static int power_allocator_throttle(struct thermal_zone *tz, int trip)
 {
 	int ret;
 	int switch_on_temp, control_temp;
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 12acb12aac50..de6997fba8eb 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -102,7 +102,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	return next_target;
 }
 
-static void update_passive_instance(struct thermal_zone_device *tz,
+static void update_passive_instance(struct thermal_zone *tz,
 				enum thermal_trip_type type, int value)
 {
 	/*
@@ -113,7 +113,7 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 		tz->passive += value;
 }
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+static void thermal_zone_trip_update(struct thermal_zone *tz, int trip)
 {
 	int trip_temp;
 	enum thermal_trip_type trip_type;
@@ -169,7 +169,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * step_wise_throttle - throttles devices associated with the given zone
- * @tz: thermal_zone_device
+ * @tz: thermal_zone
  * @trip: trip point index
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
@@ -178,7 +178,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  * step. If the zone is 'cooling down' it brings back the performance of
  * the devices by one step.
  */
-static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
+static int step_wise_throttle(struct thermal_zone *tz, int trip)
 {
 	struct thermal_instance *instance;
 
diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 64a18e354a20..5d4615ca1f41 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -15,7 +15,7 @@
 
 #include "thermal_core.h"
 
-static int user_space_bind(struct thermal_zone_device *tz)
+static int user_space_bind(struct thermal_zone *tz)
 {
 	pr_warn_once("Userspace governor deprecated: use thermal netlink " \
 		     "notification instead\n");
@@ -25,12 +25,12 @@ static int user_space_bind(struct thermal_zone_device *tz)
 
 /**
  * notify_user_space - Notifies user space about thermal events
- * @tz: thermal_zone_device
+ * @tz: thermal_zone
  * @trip: trip point index
  *
  * This function notifies the user space through UEvents.
  */
-static int notify_user_space(struct thermal_zone_device *tz, int trip)
+static int notify_user_space(struct thermal_zone *tz, int trip)
 {
 	char *thermal_prop[5];
 	int i;
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9a21ac0ceb11..6499849a9994 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -67,7 +67,7 @@ struct hisi_thermal_data;
 
 struct hisi_thermal_sensor {
 	struct hisi_thermal_data *data;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	const char *irq_name;
 	uint32_t id;
 	uint32_t thres_temp;
@@ -474,7 +474,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 			 "sensor <%d> THERMAL ALARM: %d > %d\n",
 			 sensor->id, temp, sensor->thres_temp);
 
-		thermal_zone_device_update(sensor->tzd,
+		thermal_zone_update(sensor->tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else {
@@ -547,12 +547,12 @@ MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
 static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 				       bool on)
 {
-	struct thermal_zone_device *tzd = sensor->tzd;
+	struct thermal_zone *tzd = sensor->tzd;
 
 	if (on)
-		thermal_zone_device_enable(tzd);
+		thermal_zone_enable(tzd);
 	else
-		thermal_zone_device_disable(tzd);
+		thermal_zone_disable(tzd);
 }
 
 static int hisi_thermal_probe(struct platform_device *pdev)
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..c11e466a82b4 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -48,7 +48,7 @@ struct thermal_soc_data {
 struct tmu_sensor {
 	struct imx8mm_tmu *priv;
 	u32 hw_id;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 };
 
 struct imx8mm_tmu {
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 8d76dbfde6a9..2986278477e3 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -21,7 +21,7 @@
 static struct imx_sc_ipc *thermal_ipc_handle;
 
 struct imx_sc_sensor {
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	u32 resource_id;
 };
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..f0cf4a6c6bc0 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -197,7 +197,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
 struct imx_thermal_data {
 	struct device *dev;
 	struct cpufreq_policy *policy;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct thermal_cooling_device *cdev;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
@@ -248,7 +248,7 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
 		     alarm_value << soc_data->high_alarm_shift);
 }
 
-static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
+static int imx_get_temp(struct thermal_zone *tz, int *temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
 	const struct thermal_soc_data *soc_data = data->socdata;
@@ -306,7 +306,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static int imx_change_mode(struct thermal_zone_device *tz,
+static int imx_change_mode(struct thermal_zone *tz,
 			   enum thermal_device_mode mode)
 {
 	struct imx_thermal_data *data = tz->devdata;
@@ -330,7 +330,7 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,
+static int imx_get_trip_type(struct thermal_zone *tz, int trip,
 			     enum thermal_trip_type *type)
 {
 	*type = (trip == IMX_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
@@ -338,7 +338,7 @@ static int imx_get_trip_type(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
+static int imx_get_crit_temp(struct thermal_zone *tz, int *temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
 
@@ -346,7 +346,7 @@ static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
+static int imx_get_trip_temp(struct thermal_zone *tz, int trip,
 			     int *temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
@@ -356,7 +356,7 @@ static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
+static int imx_set_trip_temp(struct thermal_zone *tz, int trip,
 			     int temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
@@ -383,7 +383,7 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int imx_bind(struct thermal_zone_device *tz,
+static int imx_bind(struct thermal_zone *tz,
 		    struct thermal_cooling_device *cdev)
 {
 	int ret;
@@ -402,7 +402,7 @@ static int imx_bind(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_unbind(struct thermal_zone_device *tz,
+static int imx_unbind(struct thermal_zone *tz,
 		      struct thermal_cooling_device *cdev)
 {
 	int ret;
@@ -418,7 +418,7 @@ static int imx_unbind(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static struct thermal_zone_device_ops imx_tz_ops = {
+static struct thermal_zone_ops imx_tz_ops = {
 	.bind = imx_bind,
 	.unbind = imx_unbind,
 	.get_temp = imx_get_temp,
@@ -582,7 +582,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
 		data->alarm_temp / 1000);
 
-	thermal_zone_device_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
@@ -743,7 +743,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto legacy_cleanup;
 	}
 
-	data->tz = thermal_zone_device_register("imx_thermal_zone",
+	data->tz = thermal_zone_register("imx_thermal_zone",
 						IMX_TRIP_NUM,
 						BIT(IMX_TRIP_PASSIVE), data,
 						&imx_tz_ops, NULL,
@@ -788,7 +788,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto disable_runtime_pm;
 
 	data->irq_enabled = true;
-	ret = thermal_zone_device_enable(data->tz);
+	ret = thermal_zone_enable(data->tz);
 	if (ret)
 		goto thermal_zone_unregister;
 
@@ -805,7 +805,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 thermal_zone_unregister:
-	thermal_zone_device_unregister(data->tz);
+	thermal_zone_unregister(data->tz);
 disable_runtime_pm:
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
@@ -824,7 +824,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
 
-	thermal_zone_device_unregister(data->tz);
+	thermal_zone_unregister(data->tz);
 	imx_thermal_unregister_legacy_cooling(data);
 
 	return 0;
@@ -840,9 +840,9 @@ static int __maybe_unused imx_thermal_suspend(struct device *dev)
 	 * try to get temperature before thermal sensor resume, a wrong
 	 * temperature will be read as the thermal sensor is powered
 	 * down. This is done in change_mode() operation called from
-	 * thermal_zone_device_disable()
+	 * thermal_zone_disable()
 	 */
-	ret = thermal_zone_device_disable(data->tz);
+	ret = thermal_zone_disable(data->tz);
 	if (ret)
 		return ret;
 
@@ -858,7 +858,7 @@ static int __maybe_unused imx_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 	/* Enabled thermal sensor after resume */
-	return thermal_zone_device_enable(data->tz);
+	return thermal_zone_enable(data->tz);
 }
 
 static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 4954800b9850..12b0452b3142 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -48,7 +48,7 @@ struct odvp_attr;
 struct int3400_thermal_priv {
 	struct acpi_device *adev;
 	struct platform_device *pdev;
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 	int art_count;
 	struct art *arts;
 	int trt_count;
@@ -450,14 +450,14 @@ static void int3400_notify(acpi_handle handle,
 	kfree(thermal_prop[3]);
 }
 
-static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
+static int int3400_thermal_get_temp(struct thermal_zone *thermal,
 			int *temp)
 {
 	*temp = 20 * 1000; /* faked temp sensor with 20C */
 	return 0;
 }
 
-static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
+static int int3400_thermal_change_mode(struct thermal_zone *thermal,
 				       enum thermal_device_mode mode)
 {
 	struct int3400_thermal_priv *priv = thermal->devdata;
@@ -485,7 +485,7 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
 	return result;
 }
 
-static struct thermal_zone_device_ops int3400_thermal_ops = {
+static struct thermal_zone_ops int3400_thermal_ops = {
 	.get_temp = int3400_thermal_get_temp,
 	.change_mode = int3400_thermal_change_mode,
 };
@@ -566,7 +566,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	evaluate_odvp(priv);
 
-	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
+	priv->thermal = thermal_zone_register("INT3400 Thermal", 0, 0,
 						priv, &int3400_thermal_ops,
 						&int3400_thermal_params, 0, 0);
 	if (IS_ERR(priv->thermal)) {
@@ -615,7 +615,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 free_rel_misc:
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
-	thermal_zone_device_unregister(priv->thermal);
+	thermal_zone_unregister(priv->thermal);
 free_art_trt:
 	kfree(priv->trts);
 	kfree(priv->arts);
@@ -641,7 +641,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
-	thermal_zone_device_unregister(priv->thermal);
+	thermal_zone_unregister(priv->thermal);
 	kfree(priv->data_vault);
 	kfree(priv->trts);
 	kfree(priv->arts);
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 43fa351e2b9e..792a8797516f 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -31,7 +31,7 @@ static void int3402_notify(acpi_handle handle, u32 event, void *data)
 	case INT3402_PERF_CHANGED_EVENT:
 		break;
 	case INT3402_THERMAL_EVENT:
-		int340x_thermal_zone_device_update(priv->int340x_zone,
+		int340x_thermal_zone_update(priv->int340x_zone,
 						   THERMAL_TRIP_VIOLATED);
 		break;
 	default:
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 07e25321dfe3..a416fcca9a8f 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -65,12 +65,12 @@ static void int3403_notify(acpi_handle handle,
 	case INT3403_PERF_CHANGED_EVENT:
 		break;
 	case INT3403_THERMAL_EVENT:
-		int340x_thermal_zone_device_update(obj->int340x_zone,
+		int340x_thermal_zone_update(obj->int340x_zone,
 						   THERMAL_TRIP_VIOLATED);
 		break;
 	case INT3403_PERF_TRIP_POINT_CHANGED:
 		int340x_thermal_read_trips(obj->int340x_zone);
-		int340x_thermal_zone_device_update(obj->int340x_zone,
+		int340x_thermal_zone_update(obj->int340x_zone,
 						   THERMAL_TRIP_CHANGED);
 		break;
 	default:
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 62c0aa5d0783..90c060c0e97f 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -11,7 +11,7 @@
 #include <linux/units.h>
 #include "int340x_thermal_zone.h"
 
-static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
+static int int340x_thermal_get_zone_temp(struct thermal_zone *zone,
 					 int *temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
@@ -40,7 +40,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
+static int int340x_thermal_get_trip_temp(struct thermal_zone *zone,
 					 int trip, int *temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
@@ -72,7 +72,7 @@ static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
+static int int340x_thermal_get_trip_type(struct thermal_zone *zone,
 					 int trip,
 					 enum thermal_trip_type *type)
 {
@@ -105,7 +105,7 @@ static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
+static int int340x_thermal_set_trip_temp(struct thermal_zone *zone,
 				      int trip, int temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
@@ -127,7 +127,7 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 }
 
 
-static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
+static int int340x_thermal_get_trip_hyst(struct thermal_zone *zone,
 		int trip, int *temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
@@ -146,12 +146,12 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static void int340x_thermal_critical(struct thermal_zone_device *zone)
+static void int340x_thermal_critical(struct thermal_zone *zone)
 {
 	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
 }
 
-static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
+static struct thermal_zone_ops int340x_thermal_zone_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
 	.get_trip_temp	= int340x_thermal_get_trip_temp,
 	.get_trip_type	= int340x_thermal_get_trip_type,
@@ -217,7 +217,7 @@ static struct thermal_zone_params int340x_thermal_params = {
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
-				struct thermal_zone_device_ops *override_ops)
+				struct thermal_zone_ops *override_ops)
 {
 	struct int34x_thermal_zone *int34x_thermal_zone;
 	acpi_status status;
@@ -258,7 +258,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register(
+	int34x_thermal_zone->zone = thermal_zone_register(
 						acpi_device_bid(adev),
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
@@ -269,14 +269,14 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		ret = PTR_ERR(int34x_thermal_zone->zone);
 		goto err_thermal_zone;
 	}
-	ret = thermal_zone_device_enable(int34x_thermal_zone->zone);
+	ret = thermal_zone_enable(int34x_thermal_zone->zone);
 	if (ret)
 		goto err_enable;
 
 	return int34x_thermal_zone;
 
 err_enable:
-	thermal_zone_device_unregister(int34x_thermal_zone->zone);
+	thermal_zone_unregister(int34x_thermal_zone->zone);
 err_thermal_zone:
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone->aux_trips);
@@ -289,7 +289,7 @@ EXPORT_SYMBOL_GPL(int340x_thermal_zone_add);
 void int340x_thermal_zone_remove(struct int34x_thermal_zone
 				 *int34x_thermal_zone)
 {
-	thermal_zone_device_unregister(int34x_thermal_zone->zone);
+	thermal_zone_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone->aux_trips);
 	kfree(int34x_thermal_zone);
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index 3b4971df1b33..f6be7d8f59d5 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -28,14 +28,14 @@ struct int34x_thermal_zone {
 	int crt_trip_id;
 	int hot_temp;
 	int hot_trip_id;
-	struct thermal_zone_device *zone;
-	struct thermal_zone_device_ops *override_ops;
+	struct thermal_zone *zone;
+	struct thermal_zone_ops *override_ops;
 	void *priv_data;
 	struct acpi_lpat_conversion_table *lpat_table;
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
-				struct thermal_zone_device_ops *override_ops);
+				struct thermal_zone_ops *override_ops);
 void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone);
 
@@ -51,11 +51,11 @@ static inline void *int340x_thermal_zone_get_priv_data(
 	return tzone->priv_data;
 }
 
-static inline void int340x_thermal_zone_device_update(
+static inline void int340x_thermal_zone_update(
 					struct int34x_thermal_zone *tzone,
 					enum thermal_notify_event event)
 {
-	thermal_zone_device_update(tzone->zone, event);
+	thermal_zone_update(tzone->zone, event);
 }
 
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a8d98f1bd6c6..1da96d5f30c3 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -195,7 +195,7 @@ static int read_temp_msr(int *temp)
 	return err;
 }
 
-static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
+static int proc_thermal_get_zone_temp(struct thermal_zone *zone,
 					 int *temp)
 {
 	int ret;
@@ -207,7 +207,7 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	return ret;
 }
 
-static struct thermal_zone_device_ops proc_thermal_local_ops = {
+static struct thermal_zone_ops proc_thermal_local_ops = {
 	.get_temp       = proc_thermal_get_zone_temp,
 };
 
@@ -271,7 +271,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 	switch (event) {
 	case PROC_POWER_CAPABILITY_CHANGED:
 		proc_thermal_read_ppcc(proc_priv);
-		int340x_thermal_zone_device_update(proc_priv->int340x_zone,
+		int340x_thermal_zone_update(proc_priv->int340x_zone,
 				THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
 		break;
 	default:
@@ -285,7 +285,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	struct acpi_device *adev;
 	acpi_status status;
 	unsigned long long tmp;
-	struct thermal_zone_device_ops *ops = NULL;
+	struct thermal_zone_ops *ops = NULL;
 	int ret;
 
 	adev = ACPI_COMPANION(dev);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ca40b0967cdd..55f1c23d1235 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -18,7 +18,7 @@
 struct proc_thermal_pci {
 	struct pci_dev *pdev;
 	struct proc_thermal_device *proc_priv;
-	struct thermal_zone_device *tzone;
+	struct thermal_zone *tzone;
 	struct delayed_work work;
 	int stored_thres;
 	int no_legacy;
@@ -101,10 +101,10 @@ static void proc_thermal_threshold_work_fn(struct work_struct *work)
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct proc_thermal_pci *pci_info = container_of(delayed_work,
 						struct proc_thermal_pci, work);
-	struct thermal_zone_device *tzone = pci_info->tzone;
+	struct thermal_zone *tzone = pci_info->tzone;
 
 	if (tzone)
-		thermal_zone_device_update(tzone, THERMAL_TRIP_VIOLATED);
+		thermal_zone_update(tzone, THERMAL_TRIP_VIOLATED);
 
 	/* Enable interrupt flag */
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
@@ -133,7 +133,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
+static int sys_get_curr_temp(struct thermal_zone *tzd, int *temp)
 {
 	struct proc_thermal_pci *pci_info = tzd->devdata;
 	u32 _temp;
@@ -144,7 +144,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return 0;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
+static int sys_get_trip_temp(struct thermal_zone *tzd,
 			     int trip, int *temp)
 {
 	struct proc_thermal_pci *pci_info = tzd->devdata;
@@ -164,7 +164,7 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 	return 0;
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *tzd, int trip,
+static int sys_get_trip_type(struct thermal_zone *tzd, int trip,
 			      enum thermal_trip_type *type)
 {
 	*type = THERMAL_TRIP_PASSIVE;
@@ -172,7 +172,7 @@ static int sys_get_trip_type(struct thermal_zone_device *tzd, int trip,
 	return 0;
 }
 
-static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
+static int sys_set_trip_temp(struct thermal_zone *tzd, int trip, int temp)
 {
 	struct proc_thermal_pci *pci_info = tzd->devdata;
 	int tjmax, _temp;
@@ -181,7 +181,7 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp
 		cancel_delayed_work_sync(&pci_info->work);
 		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
-		thermal_zone_device_disable(tzd);
+		thermal_zone_disable(tzd);
 		pci_info->stored_thres = 0;
 		return 0;
 	}
@@ -194,13 +194,13 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, _temp);
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
 
-	thermal_zone_device_enable(tzd);
+	thermal_zone_enable(tzd);
 	pci_info->stored_thres = temp;
 
 	return 0;
 }
 
-static struct thermal_zone_device_ops tzone_ops = {
+static struct thermal_zone_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
@@ -251,7 +251,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	if (ret)
 		goto err_ret_thermal;
 
-	pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1, 1, pci_info,
+	pci_info->tzone = thermal_zone_register("TCPU_PCI", 1, 1, pci_info,
 							&tzone_ops,
 							&tzone_params, 0, 0);
 	if (IS_ERR(pci_info->tzone)) {
@@ -282,7 +282,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 err_free_vectors:
 	pci_free_irq_vectors(pdev);
 err_ret_tzone:
-	thermal_zone_device_unregister(pci_info->tzone);
+	thermal_zone_unregister(pci_info->tzone);
 err_ret_mmio:
 	proc_thermal_mmio_remove(pdev, proc_priv);
 err_ret_thermal:
@@ -306,7 +306,7 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 	devm_free_irq(&pdev->dev, pdev->irq, pci_info);
 	pci_free_irq_vectors(pdev);
 
-	thermal_zone_device_unregister(pci_info->tzone);
+	thermal_zone_unregister(pci_info->tzone);
 	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
 	if (!pci_info->no_legacy)
 		proc_thermal_remove(proc_priv);
diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..eedf9a2913ce 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -153,7 +153,7 @@ static const struct pmic_thermal_data bxtwc_thermal_data = {
 static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 {
 	struct platform_device *pdev = data;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct pmic_thermal_data *td;
 	struct intel_soc_pmic *pmic;
 	struct regmap *regmap;
@@ -194,7 +194,7 @@ static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 
 			tzd = thermal_zone_get_zone_by_name(td->maps[i].handle);
 			if (!IS_ERR(tzd))
-				thermal_zone_device_update(tzd,
+				thermal_zone_update(tzd,
 						THERMAL_EVENT_UNSPECIFIED);
 
 			/* Clear the appropriate irq */
diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 101d7e791a13..358d3232109b 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -406,7 +406,7 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 {
 	acpi_status status;
 	acpi_handle dummy;
-	struct thermal_zone_device *thermal;
+	struct thermal_zone *thermal;
 	int result;
 
 	result = acpi_bus_get_private_data(handle, (void **)&thermal);
diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 527c91f5960b..596949da0e7e 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -81,7 +81,7 @@ struct pch_thermal_device {
 	void __iomem *hw_base;
 	const struct pch_dev_ops *ops;
 	struct pci_dev *pdev;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	int crt_trip_id;
 	unsigned long crt_temp;
 	int hot_trip_id;
@@ -286,14 +286,14 @@ static const struct pch_dev_ops pch_dev_ops_wpt = {
 	.resume = pch_wpt_resume,
 };
 
-static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
+static int pch_thermal_get_temp(struct thermal_zone *tzd, int *temp)
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
 
 	return	ptd->ops->get_temp(ptd, temp);
 }
 
-static int pch_get_trip_type(struct thermal_zone_device *tzd, int trip,
+static int pch_get_trip_type(struct thermal_zone *tzd, int trip,
 			     enum thermal_trip_type *type)
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
@@ -310,7 +310,7 @@ static int pch_get_trip_type(struct thermal_zone_device *tzd, int trip,
 	return 0;
 }
 
-static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *temp)
+static int pch_get_trip_temp(struct thermal_zone *tzd, int trip, int *temp)
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
 
@@ -326,12 +326,12 @@ static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *tem
 	return 0;
 }
 
-static void pch_critical(struct thermal_zone_device *tzd)
+static void pch_critical(struct thermal_zone *tzd)
 {
 	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
 }
 
-static struct thermal_zone_device_ops tzd_ops = {
+static struct thermal_zone_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
 	.get_trip_type = pch_get_trip_type,
 	.get_trip_temp = pch_get_trip_temp,
@@ -418,7 +418,7 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_cleanup;
 
-	ptd->tzd = thermal_zone_device_register(bi->name, nr_trips, 0, ptd,
+	ptd->tzd = thermal_zone_register(bi->name, nr_trips, 0, ptd,
 						&tzd_ops, NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
@@ -426,14 +426,14 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 		err = PTR_ERR(ptd->tzd);
 		goto error_cleanup;
 	}
-	err = thermal_zone_device_enable(ptd->tzd);
+	err = thermal_zone_enable(ptd->tzd);
 	if (err)
 		goto err_unregister;
 
 	return 0;
 
 err_unregister:
-	thermal_zone_device_unregister(ptd->tzd);
+	thermal_zone_unregister(ptd->tzd);
 error_cleanup:
 	iounmap(ptd->hw_base);
 error_release:
@@ -448,7 +448,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 {
 	struct pch_thermal_device *ptd = pci_get_drvdata(pdev);
 
-	thermal_zone_device_unregister(ptd->tzd);
+	thermal_zone_unregister(ptd->tzd);
 	iounmap(ptd->hw_base);
 	pci_set_drvdata(pdev, NULL);
 	pci_release_regions(pdev);
diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 3eafc6b0e6c3..ad992fabb6ba 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -103,7 +103,7 @@ struct soc_sensor_entry {
 	bool locked;
 	u32 store_ptps;
 	u32 store_dts_enable;
-	struct thermal_zone_device *tzone;
+	struct thermal_zone *tzone;
 };
 
 static struct soc_sensor_entry *soc_dts;
@@ -115,7 +115,7 @@ MODULE_PARM_DESC(polling_delay,
 
 static DEFINE_MUTEX(dts_update_mutex);
 
-static int soc_dts_enable(struct thermal_zone_device *tzd)
+static int soc_dts_enable(struct thermal_zone *tzd)
 {
 	u32 out;
 	struct soc_sensor_entry *aux_entry = tzd->devdata;
@@ -143,7 +143,7 @@ static int soc_dts_enable(struct thermal_zone_device *tzd)
 	return ret;
 }
 
-static int soc_dts_disable(struct thermal_zone_device *tzd)
+static int soc_dts_disable(struct thermal_zone *tzd)
 {
 	u32 out;
 	struct soc_sensor_entry *aux_entry = tzd->devdata;
@@ -197,13 +197,13 @@ static int _get_trip_temp(int trip, int *temp)
 	return 0;
 }
 
-static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
+static inline int sys_get_trip_temp(struct thermal_zone *tzd,
 				int trip, int *temp)
 {
 	return _get_trip_temp(trip, temp);
 }
 
-static inline int sys_get_crit_temp(struct thermal_zone_device *tzd, int *temp)
+static inline int sys_get_crit_temp(struct thermal_zone *tzd, int *temp)
 {
 	return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
 }
@@ -256,13 +256,13 @@ static int update_trip_temp(struct soc_sensor_entry *aux_entry,
 	return ret;
 }
 
-static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
+static inline int sys_set_trip_temp(struct thermal_zone *tzd, int trip,
 				int temp)
 {
 	return update_trip_temp(tzd->devdata, trip, temp);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal,
+static int sys_get_trip_type(struct thermal_zone *thermal,
 		int trip, enum thermal_trip_type *type)
 {
 	if (trip)
@@ -273,7 +273,7 @@ static int sys_get_trip_type(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int sys_get_curr_temp(struct thermal_zone_device *tzd,
+static int sys_get_curr_temp(struct thermal_zone *tzd,
 				int *temp)
 {
 	u32 out;
@@ -298,7 +298,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 	return 0;
 }
 
-static int sys_change_mode(struct thermal_zone_device *tzd,
+static int sys_change_mode(struct thermal_zone *tzd,
 			   enum thermal_device_mode mode)
 {
 	int ret;
@@ -313,7 +313,7 @@ static int sys_change_mode(struct thermal_zone_device *tzd,
 	return ret;
 }
 
-static struct thermal_zone_device_ops tzone_ops = {
+static struct thermal_zone_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
@@ -336,7 +336,7 @@ static void free_soc_dts(struct soc_sensor_entry *aux_entry)
 				       aux_entry->store_ptps);
 			mutex_unlock(&dts_update_mutex);
 		}
-		thermal_zone_device_unregister(aux_entry->tzone);
+		thermal_zone_unregister(aux_entry->tzone);
 		kfree(aux_entry);
 	}
 }
@@ -385,7 +385,7 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 			goto err_ret;
 	}
 
-	aux_entry->tzone = thermal_zone_device_register("quark_dts",
+	aux_entry->tzone = thermal_zone_register("quark_dts",
 			QRK_MAX_DTS_TRIPS,
 			wr_mask,
 			aux_entry, &tzone_ops, NULL, 0, polling_delay);
@@ -394,14 +394,14 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 		goto err_ret;
 	}
 
-	err = thermal_zone_device_enable(aux_entry->tzone);
+	err = thermal_zone_enable(aux_entry->tzone);
 	if (err)
 		goto err_aux_status;
 
 	return aux_entry;
 
 err_aux_status:
-	thermal_zone_device_unregister(aux_entry->tzone);
+	thermal_zone_unregister(aux_entry->tzone);
 err_ret:
 	kfree(aux_entry);
 	return ERR_PTR(err);
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 342b0bb5a56d..c395bafd4fef 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -71,7 +71,7 @@ static int get_tj_max(u32 *tj_max)
 	return err;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip,
+static int sys_get_trip_temp(struct thermal_zone *tzd, int trip,
 			     int *temp)
 {
 	int status;
@@ -190,7 +190,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 	return status;
 }
 
-static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
+static int sys_set_trip_temp(struct thermal_zone *tzd, int trip,
 			     int temp)
 {
 	struct intel_soc_dts_sensor_entry *dts = tzd->devdata;
@@ -208,7 +208,7 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 	return status;
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *tzd,
+static int sys_get_trip_type(struct thermal_zone *tzd,
 			     int trip, enum thermal_trip_type *type)
 {
 	struct intel_soc_dts_sensor_entry *dts;
@@ -220,7 +220,7 @@ static int sys_get_trip_type(struct thermal_zone_device *tzd,
 	return 0;
 }
 
-static int sys_get_curr_temp(struct thermal_zone_device *tzd,
+static int sys_get_curr_temp(struct thermal_zone *tzd,
 			     int *temp)
 {
 	int status;
@@ -243,7 +243,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 	return 0;
 }
 
-static struct thermal_zone_device_ops tzone_ops = {
+static struct thermal_zone_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
@@ -276,7 +276,7 @@ static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
 	if (dts) {
 		iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
 			       SOC_DTS_OFFSET_ENABLE, dts->store_status);
-		thermal_zone_device_unregister(dts->tzone);
+		thermal_zone_unregister(dts->tzone);
 	}
 }
 
@@ -320,7 +320,7 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 	dts->trip_mask = trip_mask;
 	dts->trip_count = trip_count;
 	snprintf(name, sizeof(name), "soc_dts%d", id);
-	dts->tzone = thermal_zone_device_register(name,
+	dts->tzone = thermal_zone_register(name,
 						  trip_count,
 						  trip_mask,
 						  dts, &tzone_ops,
@@ -329,7 +329,7 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 		ret = PTR_ERR(dts->tzone);
 		goto err_ret;
 	}
-	ret = thermal_zone_device_enable(dts->tzone);
+	ret = thermal_zone_enable(dts->tzone);
 	if (ret)
 		goto err_enable;
 
@@ -339,7 +339,7 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 
 	return 0;
 err_enable:
-	thermal_zone_device_unregister(dts->tzone);
+	thermal_zone_unregister(dts->tzone);
 err_ret:
 	return ret;
 }
@@ -391,7 +391,7 @@ void intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors *sensors)
 
 		for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 			pr_debug("TZD update for zone %d\n", i);
-			thermal_zone_device_update(sensors->soc_dts[i].tzone,
+			thermal_zone_update(sensors->soc_dts[i].tzone,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 	} else
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
index c54945748200..cbd2acb57747 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -28,7 +28,7 @@ struct intel_soc_dts_sensor_entry {
 	u32 trip_mask;
 	u32 trip_count;
 	enum thermal_trip_type trip_types[2];
-	struct thermal_zone_device *tzone;
+	struct thermal_zone *tzone;
 	struct intel_soc_dts_sensors *sensors;
 };
 
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 4d8edc61a78b..418e99a0f999 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -52,7 +52,7 @@ struct zone_device {
 	u32				msr_pkg_therm_low;
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
-	struct thermal_zone_device	*tzone;
+	struct thermal_zone	*tzone;
 	struct cpumask			cpumask;
 };
 
@@ -123,7 +123,7 @@ static int get_tj_max(int cpu, u32 *tj_max)
 	return val ? 0 : -EINVAL;
 }
 
-static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
+static int sys_get_curr_temp(struct thermal_zone *tzd, int *temp)
 {
 	struct zone_device *zonedev = tzd->devdata;
 	u32 eax, edx;
@@ -138,7 +138,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return -EINVAL;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
+static int sys_get_trip_temp(struct thermal_zone *tzd,
 			     int trip, int *temp)
 {
 	struct zone_device *zonedev = tzd->devdata;
@@ -173,7 +173,7 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 }
 
 static int
-sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
+sys_set_trip_temp(struct thermal_zone *tzd, int trip, int temp)
 {
 	struct zone_device *zonedev = tzd->devdata;
 	u32 l, h, mask, shift, intr;
@@ -212,7 +212,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 			l, h);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
+static int sys_get_trip_type(struct thermal_zone *thermal, int trip,
 			     enum thermal_trip_type *type)
 {
 	*type = THERMAL_TRIP_PASSIVE;
@@ -220,7 +220,7 @@ static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
 }
 
 /* Thermal zone callback registry */
-static struct thermal_zone_device_ops tzone_ops = {
+static struct thermal_zone_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
@@ -262,7 +262,7 @@ static inline void disable_pkg_thres_interrupt(void)
 
 static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 {
-	struct thermal_zone_device *tzone = NULL;
+	struct thermal_zone *tzone = NULL;
 	int cpu = smp_processor_id();
 	struct zone_device *zonedev;
 	u64 msr_val, wr_val;
@@ -294,7 +294,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	 * concurrent removal in the cpu offline callback.
 	 */
 	if (tzone)
-		thermal_zone_device_update(tzone, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_update(tzone, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_unlock(&thermal_zone_mutex);
 }
@@ -356,7 +356,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tj_max = tj_max;
-	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
+	zonedev->tzone = thermal_zone_register("x86_pkg_temp",
 			thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
@@ -365,9 +365,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 		kfree(zonedev);
 		return err;
 	}
-	err = thermal_zone_device_enable(zonedev->tzone);
+	err = thermal_zone_enable(zonedev->tzone);
 	if (err) {
-		thermal_zone_device_unregister(zonedev->tzone);
+		thermal_zone_unregister(zonedev->tzone);
 		kfree(zonedev);
 		return err;
 	}
@@ -399,7 +399,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * before doing further cleanups.
 	 */
 	if (lastcpu) {
-		struct thermal_zone_device *tzone = zonedev->tzone;
+		struct thermal_zone *tzone = zonedev->tzone;
 
 		/*
 		 * We must protect against a work function calling
@@ -411,7 +411,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 		zonedev->tzone = NULL;
 		mutex_unlock(&thermal_zone_mutex);
 
-		thermal_zone_device_unregister(tzone);
+		thermal_zone_unregister(tzone);
 	}
 
 	/* Protect against work and interrupts */
diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 35f41e8a0b75..4c35ae195941 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -81,7 +81,7 @@ struct k3_bandgap {
 
 /* common data structures */
 struct k3_thermal_data {
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct k3_bandgap *bgp;
 	int sensor_id;
 	u32 ctrl_offset;
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 7fb6e476c82a..e4133fb20f1b 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -23,7 +23,7 @@ struct kirkwood_thermal_priv {
 	void __iomem *sensor;
 };
 
-static int kirkwood_get_temp(struct thermal_zone_device *thermal,
+static int kirkwood_get_temp(struct thermal_zone *thermal,
 			  int *temp)
 {
 	unsigned long reg;
@@ -51,7 +51,7 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static struct thermal_zone_ops ops = {
 	.get_temp = kirkwood_get_temp,
 };
 
@@ -62,7 +62,7 @@ static const struct of_device_id kirkwood_thermal_id_table[] = {
 
 static int kirkwood_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *thermal = NULL;
+	struct thermal_zone *thermal = NULL;
 	struct kirkwood_thermal_priv *priv;
 	struct resource *res;
 	int ret;
@@ -76,16 +76,16 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
-	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
+	thermal = thermal_zone_register("kirkwood_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
 		return PTR_ERR(thermal);
 	}
-	ret = thermal_zone_device_enable(thermal);
+	ret = thermal_zone_enable(thermal);
 	if (ret) {
-		thermal_zone_device_unregister(thermal);
+		thermal_zone_unregister(thermal);
 		dev_err(&pdev->dev, "Failed to enable thermal zone device\n");
 		return ret;
 	}
@@ -97,10 +97,10 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 
 static int kirkwood_thermal_exit(struct platform_device *pdev)
 {
-	struct thermal_zone_device *kirkwood_thermal =
+	struct thermal_zone *kirkwood_thermal =
 		platform_get_drvdata(pdev);
 
-	thermal_zone_device_unregister(kirkwood_thermal);
+	thermal_zone_unregister(kirkwood_thermal);
 
 	return 0;
 }
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 82d06c7411eb..74aee45ad291 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -25,7 +25,7 @@
 struct max77620_therm_info {
 	struct device			*dev;
 	struct regmap			*rmap;
-	struct thermal_zone_device	*tz_device;
+	struct thermal_zone	*tz_device;
 	int				irq_tjalarm1;
 	int				irq_tjalarm2;
 };
@@ -79,7 +79,7 @@ static irqreturn_t max77620_thermal_irq(int irq, void *data)
 	else if (irq == mtherm->irq_tjalarm2)
 		dev_crit(mtherm->dev, "Junction Temp Alarm2(140C) occurred\n");
 
-	thermal_zone_device_update(mtherm->tz_device,
+	thermal_zone_update(mtherm->tz_device,
 				   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..79d592f3f60d 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -992,7 +992,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	struct mtk_thermal *mt;
 	struct resource *res;
 	u64 auxadc_phys_base, apmixed_phys_base;
-	struct thermal_zone_device *tzdev;
+	struct thermal_zone *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 824671cf494a..dccfcd90525c 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -113,7 +113,7 @@ struct adc_tm5_channel {
 	unsigned int		hw_settle_time;
 	struct iio_channel	*iio;
 	struct adc_tm5_chip	*chip;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 };
 
 /**
@@ -212,7 +212,7 @@ static irqreturn_t adc_tm5_isr(int irq, void *data)
 			(ctl & ADC_TM5_M_HIGH_THR_INT_EN);
 
 		if (upper_set || lower_set)
-			thermal_zone_device_update(chip->channels[i].tzd,
+			thermal_zone_update(chip->channels[i].tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 	}
 
@@ -358,7 +358,7 @@ static struct thermal_zone_of_device_ops adc_tm5_ops = {
 static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 {
 	unsigned int i;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 
 	for (i = 0; i < adc_tm->nchannels; i++) {
 		adc_tm->channels[i].chip = adc_tm;
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 7419e196dbb0..3c8b1d6b049c 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -70,7 +70,7 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 struct qpnp_tm_chip {
 	struct regmap			*map;
 	struct device			*dev;
-	struct thermal_zone_device	*tz_dev;
+	struct thermal_zone	*tz_dev;
 	unsigned int			subtype;
 	long				temp;
 	unsigned int			thresh;
@@ -291,7 +291,7 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
 
-	thermal_zone_device_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
@@ -463,7 +463,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	thermal_zone_device_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 154d3cb19c88..cb7ffd363ce4 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -446,7 +446,7 @@ static irqreturn_t tsens_critical_irq_thread(int irq, void *data)
  * @data: tsens controller private data
  *
  * Check all sensors to find ones that violated their threshold limits. If the
- * temperature is still outside the limits, call thermal_zone_device_update() to
+ * temperature is still outside the limits, call thermal_zone_update() to
  * update the thresholds, else re-enable the interrupts.
  *
  * The level-triggered interrupt might deassert if the temperature returned to
@@ -512,7 +512,7 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 		if (trigger) {
 			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
 				hw_id, __func__, temp);
-			thermal_zone_device_update(s->tzd,
+			thermal_zone_update(s->tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 		} else {
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
@@ -1049,7 +1049,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 static int tsens_register(struct tsens_priv *priv)
 {
 	int i, ret;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 1471a2c00f15..a4e52916f666 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -49,7 +49,7 @@ enum tsens_irq_type {
  */
 struct tsens_sensor {
 	struct tsens_priv		*priv;
-	struct thermal_zone_device	*tzd;
+	struct thermal_zone	*tzd;
 	int				offset;
 	unsigned int			hw_id;
 	int				slope;
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..16f0a275d351 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -140,7 +140,7 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 	}
 
 	for (id = 0; id < SITES_MAX; id++) {
-		struct thermal_zone_device *tzd;
+		struct thermal_zone *tzd;
 		struct qoriq_sensor *sensor = &qdata->sensor[id];
 		int ret;
 
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 43eb25b167bc..0b03c2d48495 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -79,7 +79,7 @@ struct equation_coefs {
 
 struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
-	struct thermal_zone_device *zone;
+	struct thermal_zone *zone;
 	struct equation_coefs coef;
 	int tj_t;
 	int thcode[3];
@@ -240,7 +240,7 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
 		if (status)
-			thermal_zone_device_update(priv->tscs[i]->zone,
+			thermal_zone_update(priv->tscs[i]->zone,
 						   THERMAL_EVENT_UNSPECIFIED);
 	}
 
@@ -415,7 +415,7 @@ static int rcar_gen3_thermal_remove(struct platform_device *pdev)
 
 static void rcar_gen3_hwmon_action(void *data)
 {
-	struct thermal_zone_device *zone = data;
+	struct thermal_zone *zone = data;
 
 	thermal_remove_hwmon_sysfs(zone);
 }
@@ -454,7 +454,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const int *ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
-	struct thermal_zone_device *zone;
+	struct thermal_zone *zone;
 	unsigned int i;
 	int ret;
 
@@ -552,7 +552,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
-		struct thermal_zone_device *zone = tsc->zone;
+		struct thermal_zone *zone = tsc->zone;
 
 		priv->thermal_init(tsc);
 		if (zone->ops->set_trips)
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b49f04daaf47..ea296b0b02f3 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -89,7 +89,7 @@ static const struct rcar_thermal_chip rcar_gen3_thermal = {
 struct rcar_thermal_priv {
 	void __iomem *base;
 	struct rcar_thermal_common *common;
-	struct thermal_zone_device *zone;
+	struct thermal_zone *zone;
 	const struct rcar_thermal_chip *chip;
 	struct delayed_work work;
 	struct mutex lock;
@@ -278,14 +278,14 @@ static int rcar_thermal_of_get_temp(void *data, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
+static int rcar_thermal_get_temp(struct thermal_zone *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
 
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
+static int rcar_thermal_get_trip_type(struct thermal_zone *zone,
 				      int trip, enum thermal_trip_type *type)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
@@ -304,7 +304,7 @@ static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
+static int rcar_thermal_get_trip_temp(struct thermal_zone *zone,
 				      int trip, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
@@ -327,7 +327,7 @@ static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops = {
 	.get_temp	= rcar_thermal_of_get_temp,
 };
 
-static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
+static struct thermal_zone_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 	.get_trip_type	= rcar_thermal_get_trip_type,
 	.get_trip_temp	= rcar_thermal_get_trip_temp,
@@ -367,7 +367,7 @@ static void rcar_thermal_work(struct work_struct *work)
 
 	rcar_thermal_irq_enable(priv);
 
-	thermal_zone_device_update(priv->zone, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(priv->zone, THERMAL_EVENT_UNSPECIFIED);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
@@ -431,7 +431,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 		if (priv->chip->use_of_thermal)
 			thermal_remove_hwmon_sysfs(priv->zone);
 		else
-			thermal_zone_device_unregister(priv->zone);
+			thermal_zone_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
@@ -531,15 +531,15 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
-			priv->zone = thermal_zone_device_register(
+			priv->zone = thermal_zone_register(
 						"rcar_thermal",
 						1, 0, priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
 
-			ret = thermal_zone_device_enable(priv->zone);
+			ret = thermal_zone_enable(priv->zone);
 			if (ret) {
-				thermal_zone_device_unregister(priv->zone);
+				thermal_zone_unregister(priv->zone);
 				priv->zone = ERR_PTR(ret);
 			}
 		}
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index dc3a9c276a09..b7ef7fc928fb 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -133,7 +133,7 @@ struct rockchip_tsadc_chip {
  */
 struct rockchip_thermal_sensor {
 	struct rockchip_thermal_data *thermal;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	int id;
 };
 
@@ -1187,12 +1187,12 @@ MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
 static void
 rockchip_thermal_toggle_sensor(struct rockchip_thermal_sensor *sensor, bool on)
 {
-	struct thermal_zone_device *tzd = sensor->tzd;
+	struct thermal_zone *tzd = sensor->tzd;
 
 	if (on)
-		thermal_zone_device_enable(tzd);
+		thermal_zone_enable(tzd);
 	else
-		thermal_zone_device_disable(tzd);
+		thermal_zone_disable(tzd);
 }
 
 static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
@@ -1205,7 +1205,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	thermal->chip->irq_ack(thermal->regs);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		thermal_zone_device_update(thermal->sensors[i].tzd,
+		thermal_zone_update(thermal->sensors[i].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 7a9cdc1f37ca..d8ca75585697 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -55,7 +55,7 @@
 struct rzg2l_thermal_priv {
 	struct device *dev;
 	void __iomem *base;
-	struct thermal_zone_device *zone;
+	struct thermal_zone *zone;
 	struct reset_control *rstc;
 	u32 calib0, calib1;
 };
@@ -156,7 +156,7 @@ static int rzg2l_thermal_remove(struct platform_device *pdev)
 
 static int rzg2l_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *zone;
+	struct thermal_zone *zone;
 	struct rzg2l_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	int ret;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f4ab4c5b4b62..02ba99395cd1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -162,7 +162,7 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
- * @tzd: pointer to thermal_zone_device structure
+ * @tzd: pointer to thermal_zone structure
  * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
  * @tmu_set_trip_temp: SoC specific method to set trip (rising threshold)
@@ -190,7 +190,7 @@ struct exynos_tmu_data {
 	u8 gain;
 	u8 reference_voltage;
 	struct regulator *regulator;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	unsigned int ntrip;
 	bool enabled;
 
@@ -259,7 +259,7 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tzd = data->tzd;
+	struct thermal_zone *tzd = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tzd);
 	unsigned int status;
@@ -561,7 +561,7 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_zone *tz = data->tzd;
 	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
@@ -591,7 +591,7 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_zone *tz = data->tzd;
 	unsigned int con, interrupt_en = 0, pd_det_en, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
@@ -622,7 +622,7 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_zone *tz = data->tzd;
 	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
@@ -778,7 +778,7 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
-	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
@@ -1136,7 +1136,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 static int exynos_tmu_remove(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tzd = data->tzd;
+	struct thermal_zone *tzd = data->tzd;
 
 	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
 	exynos_tmu_control(pdev, false);
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index ee33ed692e4f..0f4492ab927c 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -28,7 +28,7 @@ struct spear_thermal_dev {
 	unsigned int flags;
 };
 
-static inline int thermal_get_temp(struct thermal_zone_device *thermal,
+static inline int thermal_get_temp(struct thermal_zone *thermal,
 				int *temp)
 {
 	struct spear_thermal_dev *stdev = thermal->devdata;
@@ -41,13 +41,13 @@ static inline int thermal_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static struct thermal_zone_ops ops = {
 	.get_temp = thermal_get_temp,
 };
 
 static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
-	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
+	struct thermal_zone *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 
@@ -63,7 +63,7 @@ static int __maybe_unused spear_thermal_suspend(struct device *dev)
 
 static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
-	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
+	struct thermal_zone *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 	int ret = 0;
@@ -88,7 +88,7 @@ static SIMPLE_DEV_PM_OPS(spear_thermal_pm_ops, spear_thermal_suspend,
 
 static int spear_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *spear_thermal = NULL;
+	struct thermal_zone *spear_thermal = NULL;
 	struct spear_thermal_dev *stdev;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
@@ -124,14 +124,14 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	stdev->flags = val;
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
-	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
+	spear_thermal = thermal_zone_register("spear_thermal", 0, 0,
 				stdev, &ops, NULL, 0, 0);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
 		goto disable_clk;
 	}
-	ret = thermal_zone_device_enable(spear_thermal);
+	ret = thermal_zone_enable(spear_thermal);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot enable thermal zone\n");
 		goto unregister_tzd;
@@ -145,7 +145,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_tzd:
-	thermal_zone_device_unregister(spear_thermal);
+	thermal_zone_unregister(spear_thermal);
 disable_clk:
 	clk_disable(stdev->clk);
 
@@ -155,10 +155,10 @@ static int spear_thermal_probe(struct platform_device *pdev)
 static int spear_thermal_exit(struct platform_device *pdev)
 {
 	unsigned int actual_mask = 0;
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone *spear_thermal = platform_get_drvdata(pdev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 
-	thermal_zone_device_unregister(spear_thermal);
+	thermal_zone_unregister(spear_thermal);
 
 	/* Disable SPEAr Thermal Sensor */
 	actual_mask = readl_relaxed(stdev->thermal_base);
diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index fff80fc18002..345e7ee973e8 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -73,7 +73,7 @@
 #define SPRD_THM_MAX_SENSOR		8
 
 struct sprd_thermal_sensor {
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct sprd_thermal_data *data;
 	struct device *dev;
 	int cal_slope;
@@ -320,12 +320,12 @@ static void sprd_thm_para_config(struct sprd_thermal_data *thm)
 
 static void sprd_thm_toggle_sensor(struct sprd_thermal_sensor *sen, bool on)
 {
-	struct thermal_zone_device *tzd = sen->tzd;
+	struct thermal_zone *tzd = sen->tzd;
 
 	if (on)
-		thermal_zone_device_enable(tzd);
+		thermal_zone_enable(tzd);
 	else
-		thermal_zone_device_disable(tzd);
+		thermal_zone_disable(tzd);
 }
 
 static int sprd_thm_probe(struct platform_device *pdev)
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 1276b95604fe..97f2d8c3493a 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -106,7 +106,7 @@ static int st_thermal_calibration(struct st_thermal_sensor *sensor)
 }
 
 /* Callback to get temperature from HW*/
-static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
+static int st_thermal_get_temp(struct thermal_zone *th, int *temperature)
 {
 	struct st_thermal_sensor *sensor = th->devdata;
 	struct device *dev = sensor->dev;
@@ -134,7 +134,7 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 	return 0;
 }
 
-static int st_thermal_get_trip_type(struct thermal_zone_device *th,
+static int st_thermal_get_trip_type(struct thermal_zone *th,
 				int trip, enum thermal_trip_type *type)
 {
 	struct st_thermal_sensor *sensor = th->devdata;
@@ -152,7 +152,7 @@ static int st_thermal_get_trip_type(struct thermal_zone_device *th,
 	return 0;
 }
 
-static int st_thermal_get_trip_temp(struct thermal_zone_device *th,
+static int st_thermal_get_trip_temp(struct thermal_zone *th,
 				    int trip, int *temp)
 {
 	struct st_thermal_sensor *sensor = th->devdata;
@@ -170,7 +170,7 @@ static int st_thermal_get_trip_temp(struct thermal_zone_device *th,
 	return 0;
 }
 
-static struct thermal_zone_device_ops st_tz_ops = {
+static struct thermal_zone_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
 	.get_trip_type	= st_thermal_get_trip_type,
 	.get_trip_temp	= st_thermal_get_trip_temp,
@@ -239,14 +239,14 @@ int st_thermal_register(struct platform_device *pdev,
 	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
 
 	sensor->thermal_dev =
-		thermal_zone_device_register(dev_name(dev), 1, 0, sensor,
+		thermal_zone_register(dev_name(dev), 1, 0, sensor,
 					     &st_tz_ops, NULL, 0, polling_delay);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");
 		ret = PTR_ERR(sensor->thermal_dev);
 		goto sensor_off;
 	}
-	ret = thermal_zone_device_enable(sensor->thermal_dev);
+	ret = thermal_zone_enable(sensor->thermal_dev);
 	if (ret)
 		goto tzd_unregister;
 
@@ -255,7 +255,7 @@ int st_thermal_register(struct platform_device *pdev,
 	return 0;
 
 tzd_unregister:
-	thermal_zone_device_unregister(sensor->thermal_dev);
+	thermal_zone_unregister(sensor->thermal_dev);
 sensor_off:
 	st_thermal_sensor_off(sensor);
 
@@ -268,7 +268,7 @@ int st_thermal_unregister(struct platform_device *pdev)
 	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	st_thermal_sensor_off(sensor);
-	thermal_zone_device_unregister(sensor->thermal_dev);
+	thermal_zone_unregister(sensor->thermal_dev);
 
 	return 0;
 }
diff --git a/drivers/thermal/st/st_thermal.h b/drivers/thermal/st/st_thermal.h
index d661b2f2ef29..7023b2d29601 100644
--- a/drivers/thermal/st/st_thermal.h
+++ b/drivers/thermal/st/st_thermal.h
@@ -77,7 +77,7 @@ struct st_thermal_compat_data {
 
 struct st_thermal_sensor {
 	struct device *dev;
-	struct thermal_zone_device *thermal_dev;
+	struct thermal_zone *thermal_dev;
 	const struct st_thermal_sensor_ops *ops;
 	const struct st_thermal_compat_data *cdata;
 	struct clk *clk;
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index d68596c40be9..b69c4347b24e 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -38,7 +38,7 @@ static irqreturn_t st_mmap_thermal_trip_handler(int irq, void *sdata)
 {
 	struct st_thermal_sensor *sensor = sdata;
 
-	thermal_zone_device_update(sensor->thermal_dev,
+	thermal_zone_update(sensor->thermal_dev,
 				   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 5fd3fb8912a6..47d6021a1ea0 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -89,7 +89,7 @@
 
 struct stm_thermal_sensor {
 	struct device *dev;
-	struct thermal_zone_device *th_dev;
+	struct thermal_zone *th_dev;
 	enum thermal_device_mode mode;
 	struct clk *clk;
 	unsigned int low_temp_enabled;
@@ -129,7 +129,7 @@ static irqreturn_t stm_thermal_irq_handler(int irq, void *sdata)
 	dev_dbg(sensor->dev, "sr:%d\n",
 		readl_relaxed(sensor->base + DTS_SR_OFFSET));
 
-	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
 
 	stm_enable_irq(sensor);
 
@@ -464,7 +464,7 @@ static int stm_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
 	stm_enable_irq(sensor);
 
 	return 0;
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23cbb671..c75e6a45a9e7 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -60,7 +60,7 @@
 
 struct tsensor {
 	struct ths_device		*tmdev;
-	struct thermal_zone_device	*tzd;
+	struct thermal_zone	*tzd;
 	int				id;
 };
 
@@ -190,7 +190,7 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	int i;
 
 	for_each_set_bit(i, &irq_bitmap, tmdev->chip->sensor_num) {
-		thermal_zone_device_update(tmdev->sensor[i].tzd,
+		thermal_zone_update(tmdev->sensor[i].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 	}
 
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 210325f92559..43435e3892dd 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -301,7 +301,7 @@ struct tegra_thermctl_zone {
 	void __iomem *reg;
 	struct device *dev;
 	struct tegra_soctherm *ts;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	const struct tegra_tsensor_group *sg;
 };
 
@@ -338,7 +338,7 @@ struct tegra_soctherm {
 	int edp_irq;
 
 	u32 *calib;
-	struct thermal_zone_device **thermctl_tzs;
+	struct thermal_zone **thermctl_tzs;
 	struct tegra_soctherm_soc *soc;
 
 	struct soctherm_throt_cfg throt_cfgs[THROTTLE_SIZE];
@@ -585,7 +585,7 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 {
 	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
+	struct thermal_zone *tz = zone->tz;
 	struct tegra_soctherm *ts = zone->ts;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
@@ -637,7 +637,7 @@ static int tegra_thermctl_get_trend(void *data, int trip,
 				    enum thermal_trend *trend)
 {
 	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
+	struct thermal_zone *tz = zone->tz;
 	int trip_temp, temp, last_temp, ret;
 
 	if (!tz)
@@ -720,7 +720,7 @@ static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
+static int get_hot_temp(struct thermal_zone *tz, int *trip, int *temp)
 {
 	int ntrips, i, ret;
 	enum thermal_trip_type type;
@@ -749,7 +749,7 @@ static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
  * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
  * @dev: struct device * of the SOC_THERM instance
  * @sg: pointer to the sensor group to set the thermtrip temperature for
- * @tz: struct thermal_zone_device *
+ * @tz: struct thermal_zone *
  *
  * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
  * "THROTTLE" trip points , using "thermtrips", "critical" or "hot"
@@ -771,7 +771,7 @@ static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
  */
 static int tegra_soctherm_set_hwtrips(struct device *dev,
 				      const struct tegra_tsensor_group *sg,
-				      struct thermal_zone_device *tz)
+				      struct thermal_zone *tz)
 {
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	struct soctherm_throt_cfg *stc;
@@ -871,7 +871,7 @@ static irqreturn_t soctherm_thermal_isr(int irq, void *dev_id)
 static irqreturn_t soctherm_thermal_isr_thread(int irq, void *dev_id)
 {
 	struct tegra_soctherm *ts = dev_id;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	u32 st, ex = 0, cp = 0, gp = 0, pl = 0, me = 0;
 
 	st = readl(ts->regs + THERMCTL_INTR_STATUS);
@@ -896,25 +896,25 @@ static irqreturn_t soctherm_thermal_isr_thread(int irq, void *dev_id)
 
 		if (cp) {
 			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_CPU];
-			thermal_zone_device_update(tz,
+			thermal_zone_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 
 		if (gp) {
 			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_GPU];
-			thermal_zone_device_update(tz,
+			thermal_zone_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 
 		if (pl) {
 			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_PLLX];
-			thermal_zone_device_update(tz,
+			thermal_zone_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 
 		if (me) {
 			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_MEM];
-			thermal_zone_device_update(tz,
+			thermal_zone_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 	}
@@ -2116,7 +2116,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct tegra_soctherm *tegra;
-	struct thermal_zone_device *z;
+	struct thermal_zone *z;
 	struct tsensor_shared_calib shared_calib;
 	struct tegra_soctherm_soc *soc;
 	unsigned int i;
@@ -2294,7 +2294,7 @@ static int __maybe_unused soctherm_resume(struct device *dev)
 	soctherm_init(pdev);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
-		struct thermal_zone_device *tz;
+		struct thermal_zone *tz;
 
 		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
 		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 5affc3d196be..db65d92f7b28 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -18,7 +18,7 @@
 
 struct tegra_bpmp_thermal_zone {
 	struct tegra_bpmp_thermal *tegra;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct work_struct tz_device_update_work;
 	unsigned int idx;
 };
@@ -95,7 +95,7 @@ static void tz_device_update_work_fn(struct work_struct *work)
 	zone = container_of(work, struct tegra_bpmp_thermal_zone,
 			    tz_device_update_work);
 
-	thermal_zone_device_update(zone->tzd, THERMAL_TRIP_VIOLATED);
+	thermal_zone_update(zone->tzd, THERMAL_TRIP_VIOLATED);
 }
 
 static void bpmp_mrq_thermal(unsigned int mrq, struct tegra_bpmp_channel *ch,
@@ -166,7 +166,7 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(pdev->dev.parent);
 	struct tegra_bpmp_thermal *tegra;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	unsigned int i, max_num_zones;
 	int err;
 
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 9b6b693cbcf8..80053571c53a 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -75,7 +75,7 @@ struct tegra_tsensor_channel {
 	void __iomem *regs;
 	unsigned int id;
 	struct tegra_tsensor *ts;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 };
 
 struct tegra_tsensor {
@@ -261,7 +261,7 @@ tegra_tsensor_handle_channel_interrupt(const struct tegra_tsensor *ts,
 	if (!FIELD_GET(TSENSOR_SENSOR0_STATUS0_INTR, val))
 		return false;
 
-	thermal_zone_device_update(tsc->tzd, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(tsc->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	return true;
 }
@@ -282,14 +282,14 @@ static int tegra_tsensor_disable_hw_channel(const struct tegra_tsensor *ts,
 					    unsigned int id)
 {
 	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
-	struct thermal_zone_device *tzd = tsc->tzd;
+	struct thermal_zone *tzd = tsc->tzd;
 	u32 val;
 	int err;
 
 	if (!tzd)
 		goto stop_channel;
 
-	err = thermal_zone_device_disable(tzd);
+	err = thermal_zone_disable(tzd);
 	if (err) {
 		dev_err(ts->dev, "ch%u: failed to disable zone: %d\n", id, err);
 		return err;
@@ -304,7 +304,7 @@ static int tegra_tsensor_disable_hw_channel(const struct tegra_tsensor *ts,
 	return 0;
 }
 
-static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
+static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone *tzd,
 					       int *hot_trip, int *crit_trip)
 {
 	unsigned int i;
@@ -347,7 +347,7 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 					   unsigned int id)
 {
 	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
-	struct thermal_zone_device *tzd = tsc->tzd;
+	struct thermal_zone *tzd = tsc->tzd;
 	int err, hot_trip = 0, crit_trip = 0;
 	u32 val;
 
@@ -408,7 +408,7 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 
 	mutex_unlock(&tzd->lock);
 
-	err = thermal_zone_device_enable(tzd);
+	err = thermal_zone_enable(tzd);
 	if (err) {
 		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
 		return err;
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73665c3ccfe0..92a5c57fae7d 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -15,7 +15,7 @@
 
 struct gadc_thermal_info {
 	struct device *dev;
-	struct thermal_zone_device *tz_dev;
+	struct thermal_zone *tz_dev;
 	struct iio_channel *channel;
 	s32 *lookup_table;
 	int nlookup_table;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 82654dc8382b..64f736b9e877 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -64,13 +64,13 @@ static struct thermal_governor *__find_governor(const char *name)
 
 /**
  * bind_previous_governor() - bind the previous governor of the thermal zone
- * @tz:		a valid pointer to a struct thermal_zone_device
+ * @tz:		a valid pointer to a struct thermal_zone
  * @failed_gov_name:	the name of the governor that failed to register
  *
  * Register the previous governor of the thermal zone after a new
  * governor has failed to be bound.
  */
-static void bind_previous_governor(struct thermal_zone_device *tz,
+static void bind_previous_governor(struct thermal_zone *tz,
 				   const char *failed_gov_name)
 {
 	if (tz->governor && tz->governor->bind_to_tz) {
@@ -85,14 +85,14 @@ static void bind_previous_governor(struct thermal_zone_device *tz,
 
 /**
  * thermal_set_governor() - Switch to another governor
- * @tz:		a valid pointer to a struct thermal_zone_device
+ * @tz:		a valid pointer to a struct thermal_zone
  * @new_gov:	pointer to the new governor
  *
  * Change the governor of thermal zone @tz.
  *
  * Return: 0 on success, an error if the new governor's bind_to_tz() failed.
  */
-static int thermal_set_governor(struct thermal_zone_device *tz,
+static int thermal_set_governor(struct thermal_zone *tz,
 				struct thermal_governor *new_gov)
 {
 	int ret = 0;
@@ -118,7 +118,7 @@ int thermal_register_governor(struct thermal_governor *governor)
 {
 	int err;
 	const char *name;
-	struct thermal_zone_device *pos;
+	struct thermal_zone *pos;
 
 	if (!governor)
 		return -EINVAL;
@@ -170,7 +170,7 @@ int thermal_register_governor(struct thermal_governor *governor)
 
 void thermal_unregister_governor(struct thermal_governor *governor)
 {
-	struct thermal_zone_device *pos;
+	struct thermal_zone *pos;
 
 	if (!governor)
 		return;
@@ -194,7 +194,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 	mutex_unlock(&thermal_governor_lock);
 }
 
-int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
+int thermal_zone_set_policy(struct thermal_zone *tz,
 				   char *policy)
 {
 	struct thermal_governor *gov;
@@ -278,14 +278,14 @@ static int __init thermal_register_governors(void)
  * Zone update section: main control loop applied to each zone while monitoring
  *
  * in polling mode. The monitoring is done using a workqueue.
- * Same update may be done on a zone by calling thermal_zone_device_update().
+ * Same update may be done on a zone by calling thermal_zone_update().
  *
  * An update means:
  * - Non-critical trips will invoke the governor responsible for that zone;
  * - Hot trips will produce a notification to userspace;
  * - Critical trip point will cause a system shutdown.
  */
-static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
+static void thermal_zone_set_polling(struct thermal_zone *tz,
 					    unsigned long delay)
 {
 	if (delay)
@@ -295,12 +295,12 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 		cancel_delayed_work(&tz->poll_queue);
 }
 
-static inline bool should_stop_polling(struct thermal_zone_device *tz)
+static inline bool should_stop_polling(struct thermal_zone *tz)
 {
-	return !thermal_zone_device_is_enabled(tz);
+	return !thermal_zone_is_enabled(tz);
 }
 
-static void monitor_thermal_zone(struct thermal_zone_device *tz)
+static void monitor_thermal_zone(struct thermal_zone *tz)
 {
 	bool stop;
 
@@ -309,22 +309,22 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_lock(&tz->lock);
 
 	if (!stop && tz->passive)
-		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
+		thermal_zone_set_polling(tz, tz->passive_delay_jiffies);
 	else if (!stop && tz->polling_delay_jiffies)
-		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
+		thermal_zone_set_polling(tz, tz->polling_delay_jiffies);
 	else
-		thermal_zone_device_set_polling(tz, 0);
+		thermal_zone_set_polling(tz, 0);
 
 	mutex_unlock(&tz->lock);
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
+static void handle_non_critical_trips(struct thermal_zone *tz, int trip)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
 }
 
-void thermal_zone_device_critical(struct thermal_zone_device *tz)
+void thermal_zone_critical(struct thermal_zone *tz)
 {
 	/*
 	 * poweroff_delay_ms must be a carefully profiled positive value.
@@ -337,9 +337,9 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 
 	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
 }
-EXPORT_SYMBOL(thermal_zone_device_critical);
+EXPORT_SYMBOL(thermal_zone_critical);
 
-static void handle_critical_trips(struct thermal_zone_device *tz,
+static void handle_critical_trips(struct thermal_zone *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
 	int trip_temp;
@@ -358,7 +358,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->critical(tz);
 }
 
-static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
+static void handle_thermal_trip(struct thermal_zone *tz, int trip)
 {
 	enum thermal_trip_type type;
 	int trip_temp, hyst = 0;
@@ -394,7 +394,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	monitor_thermal_zone(tz);
 }
 
-static void update_temperature(struct thermal_zone_device *tz)
+static void update_temperature(struct thermal_zone *tz)
 {
 	int temp, ret;
 
@@ -417,7 +417,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 	thermal_genl_sampling_temp(tz->id, temp);
 }
 
-static void thermal_zone_device_init(struct thermal_zone_device *tz)
+static void thermal_zone_init(struct thermal_zone *tz)
 {
 	struct thermal_instance *pos;
 	tz->temperature = THERMAL_TEMP_INVALID;
@@ -427,7 +427,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
+static int thermal_zone_set_mode(struct thermal_zone *tz,
 					enum thermal_device_mode mode)
 {
 	int ret = 0;
@@ -449,7 +449,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	mutex_unlock(&tz->lock);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
@@ -459,19 +459,19 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	return ret;
 }
 
-int thermal_zone_device_enable(struct thermal_zone_device *tz)
+int thermal_zone_enable(struct thermal_zone *tz)
 {
-	return thermal_zone_device_set_mode(tz, THERMAL_DEVICE_ENABLED);
+	return thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_enable);
+EXPORT_SYMBOL_GPL(thermal_zone_enable);
 
-int thermal_zone_device_disable(struct thermal_zone_device *tz)
+int thermal_zone_disable(struct thermal_zone *tz)
 {
-	return thermal_zone_device_set_mode(tz, THERMAL_DEVICE_DISABLED);
+	return thermal_zone_set_mode(tz, THERMAL_DEVICE_DISABLED);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
+EXPORT_SYMBOL_GPL(thermal_zone_disable);
 
-int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
+int thermal_zone_is_enabled(struct thermal_zone *tz)
 {
 	enum thermal_device_mode mode;
 
@@ -484,7 +484,7 @@ int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 	return mode == THERMAL_DEVICE_ENABLED;
 }
 
-void thermal_zone_device_update(struct thermal_zone_device *tz,
+void thermal_zone_update(struct thermal_zone *tz,
 				enum thermal_notify_event event)
 {
 	int count;
@@ -508,14 +508,14 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_update);
+EXPORT_SYMBOL_GPL(thermal_zone_update);
 
-static void thermal_zone_device_check(struct work_struct *work)
+static void thermal_zone_check(struct work_struct *work)
 {
-	struct thermal_zone_device *tz = container_of(work, struct
-						      thermal_zone_device,
+	struct thermal_zone *tz = container_of(work, struct
+						      thermal_zone,
 						      poll_queue.work);
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
@@ -552,10 +552,10 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 	return ret;
 }
 
-int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+int for_each_thermal_zone(int (*cb)(struct thermal_zone *, void *),
 			  void *data)
 {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	int ret = 0;
 
 	mutex_lock(&thermal_list_lock);
@@ -569,9 +569,9 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 	return ret;
 }
 
-struct thermal_zone_device *thermal_zone_get_by_id(int id)
+struct thermal_zone *thermal_zone_get_by_id(int id)
 {
-	struct thermal_zone_device *tz, *match = NULL;
+	struct thermal_zone *tz, *match = NULL;
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(tz, &thermal_tz_list, node) {
@@ -597,7 +597,7 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
 
 /**
  * thermal_zone_bind_cooling_device() - bind a cooling device to a thermal zone
- * @tz:		pointer to struct thermal_zone_device
+ * @tz:		pointer to struct thermal_zone
  * @trip:	indicates which trip point the cooling devices is
  *		associated with in this thermal zone.
  * @cdev:	pointer to struct thermal_cooling_device
@@ -617,7 +617,7 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
+int thermal_zone_bind_cooling_device(struct thermal_zone *tz,
 				     int trip,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
@@ -625,7 +625,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 {
 	struct thermal_instance *dev;
 	struct thermal_instance *pos;
-	struct thermal_zone_device *pos1;
+	struct thermal_zone *pos1;
 	struct thermal_cooling_device *pos2;
 	unsigned long max_state;
 	int result, ret;
@@ -731,7 +731,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
 /**
  * thermal_zone_unbind_cooling_device() - unbind a cooling device from a
  *					  thermal zone.
- * @tz:		pointer to a struct thermal_zone_device.
+ * @tz:		pointer to a struct thermal_zone.
  * @trip:	indicates which trip point the cooling devices is
  *		associated with in this thermal zone.
  * @cdev:	pointer to a struct thermal_cooling_device.
@@ -742,7 +742,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
+int thermal_zone_unbind_cooling_device(struct thermal_zone *tz,
 				       int trip,
 				       struct thermal_cooling_device *cdev)
 {
@@ -776,7 +776,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
 
 static void thermal_release(struct device *dev)
 {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct thermal_cooling_device *cdev;
 
 	if (!strncmp(dev_name(dev), "thermal_zone",
@@ -797,14 +797,14 @@ static struct class thermal_class = {
 };
 
 static inline
-void print_bind_err_msg(struct thermal_zone_device *tz,
+void print_bind_err_msg(struct thermal_zone *tz,
 			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
 		tz->type, cdev->type, ret);
 }
 
-static void __bind(struct thermal_zone_device *tz, int mask,
+static void __bind(struct thermal_zone *tz, int mask,
 		   struct thermal_cooling_device *cdev,
 		   unsigned long *limits,
 		   unsigned int weight)
@@ -834,7 +834,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 {
 	int i, ret;
 	const struct thermal_zone_params *tzp;
-	struct thermal_zone_device *pos = NULL;
+	struct thermal_zone *pos = NULL;
 
 	mutex_lock(&thermal_list_lock);
 
@@ -890,7 +890,7 @@ __thermal_cooling_device_register(struct device_node *np,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos = NULL;
+	struct thermal_zone *pos = NULL;
 	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -940,7 +940,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
-			thermal_zone_device_update(pos,
+			thermal_zone_update(pos,
 						   THERMAL_EVENT_UNSPECIFIED);
 	mutex_unlock(&thermal_list_lock);
 
@@ -1051,7 +1051,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
 
-static void __unbind(struct thermal_zone_device *tz, int mask,
+static void __unbind(struct thermal_zone *tz, int mask,
 		     struct thermal_cooling_device *cdev)
 {
 	int i;
@@ -1072,7 +1072,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 {
 	int i;
 	const struct thermal_zone_params *tzp;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct thermal_cooling_device *pos = NULL;
 
 	if (!cdev)
@@ -1118,7 +1118,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-static void bind_tz(struct thermal_zone_device *tz)
+static void bind_tz(struct thermal_zone *tz)
 {
 	int i, ret;
 	struct thermal_cooling_device *pos = NULL;
@@ -1159,7 +1159,7 @@ static void bind_tz(struct thermal_zone_device *tz)
 }
 
 /**
- * thermal_zone_device_register() - register a new thermal zone device
+ * thermal_zone_register() - register a new thermal zone device
  * @type:	the thermal zone device type
  * @trips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
@@ -1175,20 +1175,20 @@ static void bind_tz(struct thermal_zone_device *tz)
  * This interface function adds a new thermal zone device (sensor) to
  * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
  * thermal cooling devices registered at the same time.
- * thermal_zone_device_unregister() must be called when the device is no
+ * thermal_zone_unregister() must be called when the device is no
  * longer needed. The passive cooling depends on the .get_trend() return value.
  *
- * Return: a pointer to the created struct thermal_zone_device or an
+ * Return: a pointer to the created struct thermal_zone or an
  * in case of error, an ERR_PTR. Caller must check return value with
  * IS_ERR*() helpers.
  */
-struct thermal_zone_device *
-thermal_zone_device_register(const char *type, int trips, int mask,
-			     void *devdata, struct thermal_zone_device_ops *ops,
+struct thermal_zone *
+thermal_zone_register(const char *type, int trips, int mask,
+			     void *devdata, struct thermal_zone_ops *ops,
 			     struct thermal_zone_params *tzp, int passive_delay,
 			     int polling_delay)
 {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	enum thermal_trip_type trip_type;
 	int trip_temp;
 	int id;
@@ -1241,7 +1241,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		goto remove_id;
 
 	if (!ops->critical)
-		ops->critical = thermal_zone_device_critical;
+		ops->critical = thermal_zone_critical;
 
 	tz->ops = ops;
 	tz->tzp = tzp;
@@ -1301,12 +1301,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	/* Bind cooling devices for this zone */
 	bind_tz(tz);
 
-	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
+	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_check);
 
-	thermal_zone_device_init(tz);
+	thermal_zone_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	thermal_notify_tz_create(tz->id, tz->type);
 
@@ -1323,18 +1323,18 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	kfree(tz);
 	return ERR_PTR(result);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_register);
+EXPORT_SYMBOL_GPL(thermal_zone_register);
 
 /**
- * thermal_zone_device_unregister - removes the registered thermal zone device
+ * thermal_zone_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
  */
-void thermal_zone_device_unregister(struct thermal_zone_device *tz)
+void thermal_zone_unregister(struct thermal_zone *tz)
 {
 	int i, tz_id;
 	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos = NULL;
+	struct thermal_zone *pos = NULL;
 
 	if (!tz)
 		return;
@@ -1385,7 +1385,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_notify_tz_delete(tz_id);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
+EXPORT_SYMBOL_GPL(thermal_zone_unregister);
 
 /**
  * thermal_zone_get_zone_by_name() - search for a zone and returns its ref
@@ -1397,9 +1397,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
  * matching name equals to @name, an ERR_PTR otherwise (-EINVAL for invalid
  * paramenters, -ENODEV for not found and -EEXIST for multiple matches).
  */
-struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
+struct thermal_zone *thermal_zone_get_zone_by_name(const char *name)
 {
-	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-EINVAL);
+	struct thermal_zone *pos = NULL, *ref = ERR_PTR(-EINVAL);
 	unsigned int found = 0;
 
 	if (!name)
@@ -1428,7 +1428,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
@@ -1441,11 +1441,11 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
-			if (!thermal_zone_device_is_enabled(tz))
+			if (!thermal_zone_is_enabled(tz))
 				continue;
 
-			thermal_zone_device_init(tz);
-			thermal_zone_device_update(tz,
+			thermal_zone_init(tz);
+			thermal_zone_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
 		break;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..a1e4e000f461 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -43,7 +43,7 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
-int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+int for_each_thermal_zone(int (*cb)(struct thermal_zone *, void *),
 			  void *);
 
 int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
@@ -52,7 +52,7 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
-struct thermal_zone_device *thermal_zone_get_by_id(int id);
+struct thermal_zone *thermal_zone_get_by_id(int id);
 
 struct thermal_attr {
 	struct device_attribute attr;
@@ -82,10 +82,10 @@ struct thermal_trip {
 	enum thermal_trip_type type;
 };
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip);
+int get_tz_trend(struct thermal_zone *tz, int trip);
 
 struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
+get_thermal_instance(struct thermal_zone *tz,
 		     struct thermal_cooling_device *cdev,
 		     int trip);
 
@@ -97,7 +97,7 @@ get_thermal_instance(struct thermal_zone_device *tz,
 struct thermal_instance {
 	int id;
 	char name[THERMAL_NAME_LENGTH];
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct thermal_cooling_device *cdev;
 	int trip;
 	bool initialized;
@@ -114,23 +114,23 @@ struct thermal_instance {
 };
 
 #define to_thermal_zone(_dev) \
-	container_of(_dev, struct thermal_zone_device, device)
+	container_of(_dev, struct thermal_zone, device)
 
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
+int thermal_zone_set_policy(struct thermal_zone *, char *);
 int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
-void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_zone_set_trips(struct thermal_zone *tz);
 void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
-int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
-void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
+int thermal_zone_create_device_groups(struct thermal_zone *, int);
+void thermal_zone_destroy_device_groups(struct thermal_zone *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
 void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
 /* used only at binding time */
@@ -151,28 +151,28 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
 int of_parse_thermal_zones(void);
-int of_thermal_get_ntrips(struct thermal_zone_device *);
-bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
+int of_thermal_get_ntrips(struct thermal_zone *);
+bool of_thermal_is_trip_valid(struct thermal_zone *, int);
 const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *);
+of_thermal_get_trip_points(struct thermal_zone *);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
-static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
+static inline int of_thermal_get_ntrips(struct thermal_zone *tz)
 {
 	return 0;
 }
-static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
+static inline bool of_thermal_is_trip_valid(struct thermal_zone *tz,
 					    int trip)
 {
 	return false;
 }
 static inline const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
+of_thermal_get_trip_points(struct thermal_zone *tz)
 {
 	return NULL;
 }
 #endif
 
-int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
+int thermal_zone_is_enabled(struct thermal_zone *tz);
 
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..841cb3f43036 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -23,7 +23,7 @@
 
 #include "thermal_core.h"
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip)
+int get_tz_trend(struct thermal_zone *tz, int trip)
 {
 	enum thermal_trend trend;
 
@@ -42,7 +42,7 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
+get_thermal_instance(struct thermal_zone *tz,
 		     struct thermal_cooling_device *cdev, int trip)
 {
 	struct thermal_instance *pos = NULL;
@@ -67,7 +67,7 @@ EXPORT_SYMBOL(get_thermal_instance);
 
 /**
  * thermal_zone_get_temp() - returns the temperature of a thermal zone
- * @tz: a valid pointer to a struct thermal_zone_device
+ * @tz: a valid pointer to a struct thermal_zone
  * @temp: a valid pointer to where to store the resulting temperature.
  *
  * When a valid thermal zone reference is passed, it will fetch its
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(get_thermal_instance);
  *
  * Return: On success returns 0, an error code otherwise
  */
-int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+int thermal_zone_get_temp(struct thermal_zone *tz, int *temp)
 {
 	int ret = -EINVAL;
 	int count;
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
  *
  * It does not return a value
  */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+void thermal_zone_set_trips(struct thermal_zone *tz)
 {
 	int low = -INT_MAX;
 	int high = INT_MAX;
@@ -165,7 +165,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 	/*
 	 * Set a temperature window. When this window is left the driver
-	 * must inform the thermal core via thermal_zone_device_update.
+	 * must inform the thermal core via thermal_zone_update.
 	 */
 	ret = tz->ops->set_trips(tz, low, high);
 	if (ret)
@@ -237,7 +237,7 @@ EXPORT_SYMBOL(thermal_cdev_update);
  * Return: If the thermal zone device has a slope attribute, return it, else
  * return 1.
  */
-int thermal_zone_get_slope(struct thermal_zone_device *tz)
+int thermal_zone_get_slope(struct thermal_zone *tz)
 {
 	if (tz && tz->tzp)
 		return tz->tzp->slope;
@@ -252,7 +252,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
  * Return: If the thermal zone device has a offset attribute, return it, else
  * return 0.
  */
-int thermal_zone_get_offset(struct thermal_zone_device *tz)
+int thermal_zone_get_offset(struct thermal_zone *tz)
 {
 	if (tz && tz->tzp)
 		return tz->tzp->offset;
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index ad03262cca56..bdf5639fe214 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -36,7 +36,7 @@ struct thermal_hwmon_attr {
 /* one temperature input for each thermal zone */
 struct thermal_hwmon_temp {
 	struct list_head hwmon_node;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
 	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
 };
@@ -55,7 +55,7 @@ temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct thermal_hwmon_temp *temp
 			= container_of(hwmon_attr, struct thermal_hwmon_temp,
 				       temp_input);
-	struct thermal_zone_device *tz = temp->tz;
+	struct thermal_zone *tz = temp->tz;
 
 	ret = thermal_zone_get_temp(tz, &temperature);
 
@@ -73,7 +73,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct thermal_hwmon_temp *temp
 			= container_of(hwmon_attr, struct thermal_hwmon_temp,
 				       temp_crit);
-	struct thermal_zone_device *tz = temp->tz;
+	struct thermal_zone *tz = temp->tz;
 	int temperature;
 	int ret;
 
@@ -86,7 +86,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 
 static struct thermal_hwmon_device *
-thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
+thermal_hwmon_lookup_by_type(const struct thermal_zone *tz)
 {
 	struct thermal_hwmon_device *hwmon;
 	char type[THERMAL_NAME_LENGTH];
@@ -108,7 +108,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 /* Find the temperature input matching a given thermal zone */
 static struct thermal_hwmon_temp *
 thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
-			  const struct thermal_zone_device *tz)
+			  const struct thermal_zone *tz)
 {
 	struct thermal_hwmon_temp *temp;
 
@@ -123,13 +123,13 @@ thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
 	return NULL;
 }
 
-static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *tz)
+static bool thermal_zone_crit_temp_valid(struct thermal_zone *tz)
 {
 	int temp;
 	return tz->ops->get_crit_temp && !tz->ops->get_crit_temp(tz, &temp);
 }
 
-int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+int thermal_add_hwmon_sysfs(struct thermal_zone *tz)
 {
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_temp *temp;
@@ -212,7 +212,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(thermal_add_hwmon_sysfs);
 
-void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
+void thermal_remove_hwmon_sysfs(struct thermal_zone *tz)
 {
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_temp *temp;
@@ -252,12 +252,12 @@ EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
 
 static void devm_thermal_hwmon_release(struct device *dev, void *res)
 {
-	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
+	thermal_remove_hwmon_sysfs(*(struct thermal_zone **)res);
 }
 
-int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone *tz)
 {
-	struct thermal_zone_device **ptr;
+	struct thermal_zone **ptr;
 	int ret;
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index 1a9d65f6a6a8..ba368a5c012e 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -16,24 +16,24 @@
 #include <linux/thermal.h>
 
 #ifdef CONFIG_THERMAL_HWMON
-int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
-int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
-void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
+int thermal_add_hwmon_sysfs(struct thermal_zone *tz);
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone *tz);
+void thermal_remove_hwmon_sysfs(struct thermal_zone *tz);
 #else
 static inline int
-thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+thermal_add_hwmon_sysfs(struct thermal_zone *tz)
 {
 	return 0;
 }
 
 static inline int
-devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+devm_thermal_add_hwmon_sysfs(struct thermal_zone *tz)
 {
 	return 0;
 }
 
 static inline void
-thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
+thermal_remove_hwmon_sysfs(struct thermal_zone *tz)
 {
 }
 #endif
diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 360b0dfdc3b0..d7730a328cf3 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -44,7 +44,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 	struct thermal_mmio *sensor;
 	int (*sensor_init_func)(struct platform_device *pdev,
 				struct thermal_mmio *sensor);
-	struct thermal_zone_device *thermal_zone;
+	struct thermal_zone *thermal_zone;
 	int ret;
 	int temperature;
 
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 32fea5174cc0..88c28c5205b8 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -411,7 +411,7 @@ EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
 
 /*************************** Command encoding ********************************/
 
-static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
+static int __thermal_genl_cmd_tz_get_id(struct thermal_zone *tz,
 					void *data)
 {
 	struct sk_buff *msg = data;
@@ -450,7 +450,7 @@ static int thermal_genl_cmd_tz_get_id(struct param *p)
 static int thermal_genl_cmd_tz_get_trip(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	struct nlattr *start_trip;
 	int i, id;
 
@@ -501,7 +501,7 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 static int thermal_genl_cmd_tz_get_temp(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	int temp, ret, id;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
@@ -527,7 +527,7 @@ static int thermal_genl_cmd_tz_get_temp(struct param *p)
 static int thermal_genl_cmd_tz_get_gov(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
-	struct thermal_zone_device *tz;
+	struct thermal_zone *tz;
 	int id, ret = 0;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9233f7e74454..f29d4f99522a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -84,7 +84,7 @@ struct __thermal_zone {
 
 /***   DT thermal zone device callbacks   ***/
 
-static int of_thermal_get_temp(struct thermal_zone_device *tz,
+static int of_thermal_get_temp(struct thermal_zone *tz,
 			       int *temp)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -95,7 +95,7 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 	return data->ops->get_temp(data->sensor_data, temp);
 }
 
-static int of_thermal_set_trips(struct thermal_zone_device *tz,
+static int of_thermal_set_trips(struct thermal_zone *tz,
 				int low, int high)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -116,7 +116,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
  *
  * Return: number of available trip points, -ENODEV when data not available
  */
-int of_thermal_get_ntrips(struct thermal_zone_device *tz)
+int of_thermal_get_ntrips(struct thermal_zone *tz)
 {
 	struct __thermal_zone *data = tz->devdata;
 
@@ -137,7 +137,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
  *
  * Return: true if trip point is valid, false otherwise
  */
-bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
+bool of_thermal_is_trip_valid(struct thermal_zone *tz, int trip)
 {
 	struct __thermal_zone *data = tz->devdata;
 
@@ -159,7 +159,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
  * Return: pointer to trip points table, NULL otherwise
  */
 const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
+of_thermal_get_trip_points(struct thermal_zone *tz)
 {
 	struct __thermal_zone *data = tz->devdata;
 
@@ -181,7 +181,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
  *
  * Return: zero on success, error code otherwise
  */
-static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
+static int of_thermal_set_emul_temp(struct thermal_zone *tz,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -192,7 +192,7 @@ static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
 	return data->ops->set_emul_temp(data->sensor_data, temp);
 }
 
-static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
+static int of_thermal_get_trend(struct thermal_zone *tz, int trip,
 				enum thermal_trend *trend)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -203,7 +203,7 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 	return data->ops->get_trend(data->sensor_data, trip, trend);
 }
 
-static int of_thermal_bind(struct thermal_zone_device *thermal,
+static int of_thermal_bind(struct thermal_zone *thermal,
 			   struct thermal_cooling_device *cdev)
 {
 	struct __thermal_zone *data = thermal->devdata;
@@ -238,7 +238,7 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int of_thermal_unbind(struct thermal_zone_device *thermal,
+static int of_thermal_unbind(struct thermal_zone *thermal,
 			     struct thermal_cooling_device *cdev)
 {
 	struct __thermal_zone *data = thermal->devdata;
@@ -270,7 +270,7 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
+static int of_thermal_get_trip_type(struct thermal_zone *tz, int trip,
 				    enum thermal_trip_type *type)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -283,7 +283,7 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
+static int of_thermal_get_trip_temp(struct thermal_zone *tz, int trip,
 				    int *temp)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -296,7 +296,7 @@ static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
+static int of_thermal_set_trip_temp(struct thermal_zone *tz, int trip,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -318,7 +318,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
+static int of_thermal_get_trip_hyst(struct thermal_zone *tz, int trip,
 				    int *hyst)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -331,7 +331,7 @@ static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
+static int of_thermal_set_trip_hyst(struct thermal_zone *tz, int trip,
 				    int hyst)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -345,7 +345,7 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
+static int of_thermal_get_crit_temp(struct thermal_zone *tz,
 				    int *temp)
 {
 	struct __thermal_zone *data = tz->devdata;
@@ -360,7 +360,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 	return -EINVAL;
 }
 
-static struct thermal_zone_device_ops of_thermal_ops = {
+static struct thermal_zone_ops of_thermal_ops = {
 	.get_trip_type = of_thermal_get_trip_type,
 	.get_trip_temp = of_thermal_get_trip_temp,
 	.set_trip_temp = of_thermal_set_trip_temp,
@@ -374,12 +374,12 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 
 /***   sensor API   ***/
 
-static struct thermal_zone_device *
+static struct thermal_zone *
 thermal_zone_of_add_sensor(struct device_node *zone,
 			   struct device_node *sensor, void *data,
 			   const struct thermal_zone_of_device_ops *ops)
 {
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct __thermal_zone *tz;
 
 	tzd = thermal_zone_get_zone_by_name(zone->name);
@@ -485,16 +485,16 @@ EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
  * 02 - There must be a way to match the sensor with all thermal zones
  * that refer to it.
  *
- * Return: On success returns a valid struct thermal_zone_device,
+ * Return: On success returns a valid struct thermal_zone,
  * otherwise, it returns a corresponding ERR_PTR(). Caller must
  * check the return value with help of IS_ERR() helper.
  */
-struct thermal_zone_device *
+struct thermal_zone *
 thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
 {
 	struct device_node *np, *child, *sensor_np;
-	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
+	struct thermal_zone *tzd = ERR_PTR(-ENODEV);
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
@@ -519,7 +519,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
 			if (!IS_ERR(tzd))
-				thermal_zone_device_enable(tzd);
+				thermal_zone_enable(tzd);
 
 			of_node_put(child);
 			goto exit;
@@ -537,7 +537,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_register);
  * thermal_zone_of_sensor_unregister - unregisters a sensor from a DT thermal zone
  * @dev: a valid struct device pointer of a sensor device. Must contain
  *       a valid .of_node, for the sensor node.
- * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
+ * @tzd: a pointer to struct thermal_zone where the sensor is registered.
  *
  * This function removes the sensor callbacks and private data from the
  * thermal zone device registered with thermal_zone_of_sensor_register()
@@ -549,7 +549,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_register);
  *
  */
 void thermal_zone_of_sensor_unregister(struct device *dev,
-				       struct thermal_zone_device *tzd)
+				       struct thermal_zone *tzd)
 {
 	struct __thermal_zone *tz;
 
@@ -563,7 +563,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 		return;
 
 	/* stop temperature polling */
-	thermal_zone_device_disable(tzd);
+	thermal_zone_disable(tzd);
 
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
@@ -579,13 +579,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_unregister);
 static void devm_thermal_zone_of_sensor_release(struct device *dev, void *res)
 {
 	thermal_zone_of_sensor_unregister(dev,
-					  *(struct thermal_zone_device **)res);
+					  *(struct thermal_zone **)res);
 }
 
 static int devm_thermal_zone_of_sensor_match(struct device *dev, void *res,
 					     void *data)
 {
-	struct thermal_zone_device **r = res;
+	struct thermal_zone **r = res;
 
 	if (WARN_ON(!r || !*r))
 		return 0;
@@ -606,17 +606,17 @@ static int devm_thermal_zone_of_sensor_match(struct device *dev, void *res,
  *
  * Refer thermal_zone_of_sensor_register() for more details.
  *
- * Return: On success returns a valid struct thermal_zone_device,
+ * Return: On success returns a valid struct thermal_zone,
  * otherwise, it returns a corresponding ERR_PTR(). Caller must
  * check the return value with help of IS_ERR() helper.
- * Registered thermal_zone_device device will automatically be
+ * Registered thermal_zone device will automatically be
  * released when device is unbounded.
  */
-struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
+struct thermal_zone *devm_thermal_zone_of_sensor_register(
 	struct device *dev, int sensor_id,
 	void *data, const struct thermal_zone_of_device_ops *ops)
 {
-	struct thermal_zone_device **ptr, *tzd;
+	struct thermal_zone **ptr, *tzd;
 
 	ptr = devres_alloc(devm_thermal_zone_of_sensor_release, sizeof(*ptr),
 			   GFP_KERNEL);
@@ -640,7 +640,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_register);
  * devm_thermal_zone_of_sensor_unregister - Resource managed version of
  *				thermal_zone_of_sensor_unregister().
  * @dev: Device for which which resource was allocated.
- * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
+ * @tzd: a pointer to struct thermal_zone where the sensor is registered.
  *
  * This function removes the sensor callbacks and private data from the
  * thermal zone device registered with devm_thermal_zone_of_sensor_register()
@@ -650,7 +650,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_register);
  * management code will ensure that the resource is freed.
  */
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-					    struct thermal_zone_device *tzd)
+					    struct thermal_zone *tzd)
 {
 	WARN_ON(devres_release(dev, devm_thermal_zone_of_sensor_release,
 			       devm_thermal_zone_of_sensor_match, tzd));
@@ -1016,13 +1016,13 @@ static __init void of_thermal_destroy_zones(void)
 	}
 
 	for_each_available_child_of_node(np, child) {
-		struct thermal_zone_device *zone;
+		struct thermal_zone *zone;
 
 		zone = thermal_zone_get_zone_by_name(child->name);
 		if (IS_ERR(zone))
 			continue;
 
-		thermal_zone_device_unregister(zone);
+		thermal_zone_unregister(zone);
 		kfree(zone->tzp);
 		kfree(zone->ops);
 		of_thermal_free_zone(zone->devdata);
@@ -1046,7 +1046,7 @@ int __init of_parse_thermal_zones(void)
 {
 	struct device_node *np, *child;
 	struct __thermal_zone *tz;
-	struct thermal_zone_device_ops *ops;
+	struct thermal_zone_ops *ops;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
@@ -1055,7 +1055,7 @@ int __init of_parse_thermal_zones(void)
 	}
 
 	for_each_available_child_of_node(np, child) {
-		struct thermal_zone_device *zone;
+		struct thermal_zone *zone;
 		struct thermal_zone_params *tzp;
 		int i, mask = 0;
 		u32 prop;
@@ -1091,7 +1091,7 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_device_register(child->name, tz->ntrips,
+		zone = thermal_zone_register(child->name, tz->ntrips,
 						    mask, tz,
 						    ops, tzp,
 						    tz->passive_delay,
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..083578e736cc 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -26,7 +26,7 @@
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 
 	return sprintf(buf, "%s\n", tz->type);
 }
@@ -34,7 +34,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *buf)
 static ssize_t
 temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int temperature, ret;
 
 	ret = thermal_zone_get_temp(tz, &temperature);
@@ -48,8 +48,8 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int enabled = thermal_zone_device_is_enabled(tz);
+	struct thermal_zone *tz = to_thermal_zone(dev);
+	int enabled = thermal_zone_is_enabled(tz);
 
 	return sprintf(buf, "%s\n", enabled ? "enabled" : "disabled");
 }
@@ -58,13 +58,13 @@ static ssize_t
 mode_store(struct device *dev, struct device_attribute *attr,
 	   const char *buf, size_t count)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int result;
 
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = thermal_zone_device_enable(tz);
+		result = thermal_zone_enable(tz);
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = thermal_zone_device_disable(tz);
+		result = thermal_zone_disable(tz);
 	else
 		result = -EINVAL;
 
@@ -78,7 +78,7 @@ static ssize_t
 trip_point_type_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	enum thermal_trip_type type;
 	int trip, result;
 
@@ -110,7 +110,7 @@ static ssize_t
 trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int trip, ret;
 	int temperature, hyst = 0;
 	enum thermal_trip_type type;
@@ -140,7 +140,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 
 	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return count;
 }
@@ -149,7 +149,7 @@ static ssize_t
 trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int trip, ret;
 	int temperature;
 
@@ -171,7 +171,7 @@ static ssize_t
 trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int trip, ret;
 	int temperature;
 
@@ -201,7 +201,7 @@ static ssize_t
 trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int trip, ret;
 	int temperature;
 
@@ -220,13 +220,13 @@ static ssize_t
 policy_store(struct device *dev, struct device_attribute *attr,
 	     const char *buf, size_t count)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	char name[THERMAL_NAME_LENGTH];
 	int ret;
 
 	snprintf(name, sizeof(name), "%s", buf);
 
-	ret = thermal_zone_device_set_policy(tz, name);
+	ret = thermal_zone_set_policy(tz, name);
 	if (!ret)
 		ret = count;
 
@@ -236,7 +236,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
 static ssize_t
 policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 
 	return sprintf(buf, "%s\n", tz->governor->name);
 }
@@ -253,7 +253,7 @@ static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	int ret = 0;
 	int temperature;
 
@@ -269,7 +269,7 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return ret ? ret : count;
 }
@@ -280,7 +280,7 @@ static ssize_t
 sustainable_power_show(struct device *dev, struct device_attribute *devattr,
 		       char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 
 	if (tz->tzp)
 		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
@@ -292,7 +292,7 @@ static ssize_t
 sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone *tz = to_thermal_zone(dev);
 	u32 sustainable_power;
 
 	if (!tz->tzp)
@@ -311,7 +311,7 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	name##_show(struct device *dev, struct device_attribute *devattr, \
 		char *buf)						\
 	{								\
-	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
+	struct thermal_zone *tz = to_thermal_zone(dev);		\
 									\
 	if (tz->tzp)							\
 		return sprintf(buf, "%d\n", tz->tzp->name);		\
@@ -323,7 +323,7 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	name##_store(struct device *dev, struct device_attribute *devattr, \
 		const char *buf, size_t count)				\
 	{								\
-		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
+		struct thermal_zone *tz = to_thermal_zone(dev);	\
 		s32 value;						\
 									\
 		if (!tz->tzp)						\
@@ -406,11 +406,11 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
  * @mask:	Writeable trip point bitmap.
  *
  * helper function to instantiate sysfs entries for every trip
- * point and its properties of a struct thermal_zone_device.
+ * point and its properties of a struct thermal_zone.
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
+static int create_trip_attrs(struct thermal_zone *tz, int mask)
 {
 	struct attribute **attrs;
 	int indx;
@@ -512,7 +512,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
  *
  * helper function to free resources allocated by create_trip_attrs()
  */
-static void destroy_trip_attrs(struct thermal_zone_device *tz)
+static void destroy_trip_attrs(struct thermal_zone *tz)
 {
 	if (!tz)
 		return;
@@ -524,7 +524,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
+int thermal_zone_create_device_groups(struct thermal_zone *tz,
 				      int mask)
 {
 	const struct attribute_group **groups;
@@ -556,7 +556,7 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 	return 0;
 }
 
-void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
+void thermal_zone_destroy_device_groups(struct thermal_zone *tz)
 {
 	if (!tz)
 		return;
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 703039d8b937..f6fae083fe1a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -26,8 +26,8 @@
 /* common data structures */
 struct ti_thermal_data {
 	struct cpufreq_policy *policy;
-	struct thermal_zone_device *ti_thermal;
-	struct thermal_zone_device *pcb_tz;
+	struct thermal_zone *ti_thermal;
+	struct thermal_zone *pcb_tz;
 	struct thermal_cooling_device *cool_dev;
 	struct ti_bandgap *bgp;
 	enum thermal_device_mode mode;
@@ -41,7 +41,7 @@ static void ti_thermal_work(struct work_struct *work)
 	struct ti_thermal_data *data = container_of(work,
 					struct ti_thermal_data, thermal_wq);
 
-	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
 
 	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
 		data->ti_thermal->type);
@@ -67,7 +67,7 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 /* Get temperature callback function for thermal zone */
 static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 {
-	struct thermal_zone_device *pcb_tz = NULL;
+	struct thermal_zone *pcb_tz = NULL;
 	struct ti_thermal_data *data = devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
@@ -196,7 +196,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
-			thermal_zone_device_unregister(data->ti_thermal);
+			thermal_zone_unregister(data->ti_thermal);
 	}
 
 	return 0;
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4cae5561a2a3..09ae546d33af 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -84,7 +84,7 @@ struct uniphier_tm_dev {
 	struct regmap *regmap;
 	struct device *dev;
 	bool alert_en[ALERT_CH_NUM];
-	struct thermal_zone_device *tz_dev;
+	struct thermal_zone *tz_dev;
 	const struct uniphier_tm_soc_data *data;
 };
 
@@ -237,7 +237,7 @@ static irqreturn_t uniphier_tm_alarm_irq_thread(int irq, void *_tdev)
 {
 	struct uniphier_tm_dev *tdev = _tdev;
 
-	thermal_zone_device_update(tdev->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_update(tdev->tz_dev, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 45e228b353ea..12ba78bce30a 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -222,7 +222,7 @@ struct charger_manager {
 	struct charger_desc *desc;
 
 #ifdef CONFIG_THERMAL
-	struct thermal_zone_device *tzd_batt;
+	struct thermal_zone *tzd_batt;
 #endif
 	bool charger_enabled;
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cb380c1d9459..a7e782261d9e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -302,7 +302,7 @@ struct power_supply {
 	bool removing;
 	atomic_t use_cnt;
 #ifdef CONFIG_THERMAL
-	struct thermal_zone_device *tzd;
+	struct thermal_zone *tzd;
 	struct thermal_cooling_device *tcd;
 #endif
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c314893970b3..c599b7f8c9c5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -31,7 +31,7 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
-struct thermal_zone_device;
+struct thermal_zone;
 struct thermal_cooling_device;
 struct thermal_instance;
 struct thermal_attr;
@@ -57,27 +57,27 @@ enum thermal_notify_event {
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
 };
 
-struct thermal_zone_device_ops {
-	int (*bind) (struct thermal_zone_device *,
+struct thermal_zone_ops {
+	int (*bind) (struct thermal_zone *,
 		     struct thermal_cooling_device *);
-	int (*unbind) (struct thermal_zone_device *,
+	int (*unbind) (struct thermal_zone *,
 		       struct thermal_cooling_device *);
-	int (*get_temp) (struct thermal_zone_device *, int *);
-	int (*set_trips) (struct thermal_zone_device *, int, int);
-	int (*change_mode) (struct thermal_zone_device *,
+	int (*get_temp) (struct thermal_zone *, int *);
+	int (*set_trips) (struct thermal_zone *, int, int);
+	int (*change_mode) (struct thermal_zone *,
 		enum thermal_device_mode);
-	int (*get_trip_type) (struct thermal_zone_device *, int,
+	int (*get_trip_type) (struct thermal_zone *, int,
 		enum thermal_trip_type *);
-	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
-	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
-	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
-	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
-	int (*get_crit_temp) (struct thermal_zone_device *, int *);
-	int (*set_emul_temp) (struct thermal_zone_device *, int);
-	int (*get_trend) (struct thermal_zone_device *, int,
+	int (*get_trip_temp) (struct thermal_zone *, int, int *);
+	int (*set_trip_temp) (struct thermal_zone *, int, int);
+	int (*get_trip_hyst) (struct thermal_zone *, int, int *);
+	int (*set_trip_hyst) (struct thermal_zone *, int, int);
+	int (*get_crit_temp) (struct thermal_zone *, int *);
+	int (*set_emul_temp) (struct thermal_zone *, int);
+	int (*get_trend) (struct thermal_zone *, int,
 			  enum thermal_trend *);
-	void (*hot)(struct thermal_zone_device *);
-	void (*critical)(struct thermal_zone_device *);
+	void (*hot)(struct thermal_zone *);
+	void (*critical)(struct thermal_zone *);
 };
 
 struct thermal_cooling_device_ops {
@@ -104,7 +104,7 @@ struct thermal_cooling_device {
 };
 
 /**
- * struct thermal_zone_device - structure for a thermal zone
+ * struct thermal_zone - structure for a thermal zone
  * @id:		unique id number for each thermal zone
  * @type:	the thermal zone device type
  * @device:	&struct device for this thermal zone
@@ -130,8 +130,8 @@ struct thermal_cooling_device {
 			trip point.
  * @prev_high_trip:	the above current temperature if you've crossed a
 			passive trip point.
- * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
- * @ops:	operations this &thermal_zone_device supports
+ * @need_update:	if equals 1, thermal_zone_update needs to be invoked.
+ * @ops:	operations this &thermal_zone supports
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
  * @governor_data:	private pointer for governor data
@@ -143,7 +143,7 @@ struct thermal_cooling_device {
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
  */
-struct thermal_zone_device {
+struct thermal_zone {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
@@ -164,7 +164,7 @@ struct thermal_zone_device {
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-	struct thermal_zone_device_ops *ops;
+	struct thermal_zone_ops *ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
@@ -190,9 +190,9 @@ struct thermal_zone_device {
  */
 struct thermal_governor {
 	char name[THERMAL_NAME_LENGTH];
-	int (*bind_to_tz)(struct thermal_zone_device *tz);
-	void (*unbind_from_tz)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	int (*bind_to_tz)(struct thermal_zone *tz);
+	void (*unbind_from_tz)(struct thermal_zone *tz);
+	int (*throttle)(struct thermal_zone *tz, int trip);
 	struct list_head	governor_list;
 };
 
@@ -227,7 +227,7 @@ struct thermal_bind_params {
 	 * on all trips.
 	 */
 	unsigned long *binding_limits;
-	int (*match) (struct thermal_zone_device *tz,
+	int (*match) (struct thermal_zone *tz,
 			struct thermal_cooling_device *cdev);
 };
 
@@ -294,7 +294,7 @@ struct thermal_zone_params {
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
  * @set_trips: a pointer to a function that sets a temperature window. When
  *	       this window is left the driver must inform the thermal core via
- *	       thermal_zone_device_update.
+ *	       thermal_zone_update.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
  * @set_trip_temp: a pointer to a function that sets the trip temperature on
@@ -313,16 +313,16 @@ struct thermal_zone_of_device_ops {
 int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 				  struct device_node *sensor_np,
 				  u32 *id);
-struct thermal_zone_device *
+struct thermal_zone *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops);
 void thermal_zone_of_sensor_unregister(struct device *dev,
-				       struct thermal_zone_device *tz);
-struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
+				       struct thermal_zone *tz);
+struct thermal_zone *devm_thermal_zone_of_sensor_register(
 		struct device *dev, int id, void *data,
 		const struct thermal_zone_of_device_ops *ops);
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-					    struct thermal_zone_device *tz);
+					    struct thermal_zone *tz);
 #else
 
 static inline int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
@@ -331,7 +331,7 @@ static inline int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 {
 	return -ENOENT;
 }
-static inline struct thermal_zone_device *
+static inline struct thermal_zone *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
 {
@@ -340,11 +340,11 @@ thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 
 static inline
 void thermal_zone_of_sensor_unregister(struct device *dev,
-				       struct thermal_zone_device *tz)
+				       struct thermal_zone *tz)
 {
 }
 
-static inline struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
+static inline struct thermal_zone *devm_thermal_zone_of_sensor_register(
 		struct device *dev, int id, void *data,
 		const struct thermal_zone_of_device_ops *ops)
 {
@@ -353,25 +353,25 @@ static inline struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
 
 static inline
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-					    struct thermal_zone_device *tz)
+					    struct thermal_zone *tz)
 {
 }
 
 #endif
 
 #ifdef CONFIG_THERMAL
-struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
-		void *, struct thermal_zone_device_ops *,
+struct thermal_zone *thermal_zone_register(const char *, int, int,
+		void *, struct thermal_zone_ops *,
 		struct thermal_zone_params *, int, int);
-void thermal_zone_device_unregister(struct thermal_zone_device *);
+void thermal_zone_unregister(struct thermal_zone *);
 
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
+int thermal_zone_bind_cooling_device(struct thermal_zone *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
 				     unsigned int);
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
+int thermal_zone_unbind_cooling_device(struct thermal_zone *, int,
 				       struct thermal_cooling_device *);
-void thermal_zone_device_update(struct thermal_zone_device *,
+void thermal_zone_update(struct thermal_zone *,
 				enum thermal_notify_event);
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
@@ -385,23 +385,23 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 				char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
-struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
-int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
-int thermal_zone_get_slope(struct thermal_zone_device *tz);
-int thermal_zone_get_offset(struct thermal_zone_device *tz);
-
-int thermal_zone_device_enable(struct thermal_zone_device *tz);
-int thermal_zone_device_disable(struct thermal_zone_device *tz);
-void thermal_zone_device_critical(struct thermal_zone_device *tz);
+struct thermal_zone *thermal_zone_get_zone_by_name(const char *name);
+int thermal_zone_get_temp(struct thermal_zone *tz, int *temp);
+int thermal_zone_get_slope(struct thermal_zone *tz);
+int thermal_zone_get_offset(struct thermal_zone *tz);
+
+int thermal_zone_enable(struct thermal_zone *tz);
+int thermal_zone_disable(struct thermal_zone *tz);
+void thermal_zone_critical(struct thermal_zone *tz);
 #else
-static inline struct thermal_zone_device *thermal_zone_device_register(
+static inline struct thermal_zone *thermal_zone_register(
 	const char *type, int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
+	struct thermal_zone_ops *ops,
 	struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
-static inline void thermal_zone_device_unregister(
-	struct thermal_zone_device *tz)
+static inline void thermal_zone_unregister(
+	struct thermal_zone *tz)
 { }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
@@ -423,23 +423,23 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
 { }
-static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
+static inline struct thermal_zone *thermal_zone_get_zone_by_name(
 		const char *name)
 { return ERR_PTR(-ENODEV); }
 static inline int thermal_zone_get_temp(
-		struct thermal_zone_device *tz, int *temp)
+		struct thermal_zone *tz, int *temp)
 { return -ENODEV; }
 static inline int thermal_zone_get_slope(
-		struct thermal_zone_device *tz)
+		struct thermal_zone *tz)
 { return -ENODEV; }
 static inline int thermal_zone_get_offset(
-		struct thermal_zone_device *tz)
+		struct thermal_zone *tz)
 { return -ENODEV; }
 
-static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+static inline int thermal_zone_enable(struct thermal_zone *tz)
 { return -ENODEV; }
 
-static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
+static inline int thermal_zone_disable(struct thermal_zone *tz)
 { return -ENODEV; }
 #endif /* CONFIG_THERMAL */
 
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 8a5f04888abd..fc3d9186f904 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -23,7 +23,7 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
 
 TRACE_EVENT(thermal_temperature,
 
-	TP_PROTO(struct thermal_zone_device *tz),
+	TP_PROTO(struct thermal_zone *tz),
 
 	TP_ARGS(tz),
 
@@ -67,7 +67,7 @@ TRACE_EVENT(cdev_update,
 
 TRACE_EVENT(thermal_zone_trip,
 
-	TP_PROTO(struct thermal_zone_device *tz, int trip,
+	TP_PROTO(struct thermal_zone *tz, int trip,
 		enum thermal_trip_type trip_type),
 
 	TP_ARGS(tz, trip, trip_type),
diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
index 1c8fb95544f9..fd900832d256 100644
--- a/include/trace/events/thermal_power_allocator.h
+++ b/include/trace/events/thermal_power_allocator.h
@@ -8,7 +8,7 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(thermal_power_allocator,
-	TP_PROTO(struct thermal_zone_device *tz, u32 *req_power,
+	TP_PROTO(struct thermal_zone *tz, u32 *req_power,
 		 u32 total_req_power, u32 *granted_power,
 		 u32 total_granted_power, size_t num_actors,
 		 u32 power_range, u32 max_allocatable_power,
@@ -56,7 +56,7 @@ TRACE_EVENT(thermal_power_allocator,
 );
 
 TRACE_EVENT(thermal_power_allocator_pid,
-	TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
+	TP_PROTO(struct thermal_zone *tz, s32 err, s32 err_integral,
 		 s64 p, s64 i, s64 d, s32 output),
 	TP_ARGS(tz, err, err_integral, p, i, d, output),
 	TP_STRUCT__entry(
-- 
2.25.1

