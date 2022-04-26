Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2079510BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355727AbiDZWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355689AbiDZWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1E289A8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so20519860wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGb/PghyfnVsqwJwviGzwvr95Mi6vW3yxA69Jls+3RM=;
        b=j/Z5rS9v7N18vfRM4FN3BKOCZJk907QaadhaQ3SyamQgNTCY35qicLhX/Xs2mWhDeJ
         EoMgr9m3365B26SZfcg9RrCy35LnfIN4PIqQ4xm4XxJY+fo9xeVGtlznAlImtb2wWL7J
         B83Bm1JB2034XpbxMcwt9sMgfGFirzQmaDTZjtdjN63Fwh2Lj4GI0/ZwmHXeofL3jMaA
         E04eCSKcqtsXPiV9LgK8YA6wEgd6o+mzRutp8TgRkRa0KYVHoV6N394oBLZcxLSTuSKs
         yr+JcGN+DxzQ+kVspcycdyIADstw1pB3R5C06AxsQP46byJG1sVyyS/+GF2tQhDs8M3S
         xUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGb/PghyfnVsqwJwviGzwvr95Mi6vW3yxA69Jls+3RM=;
        b=xrT5vOPrtSbCUbJNip5vSCgw2BqYUxKVgJbGuoQMMrvmn3yrnIXh469dSeINZF7pMi
         o2Uqs6Yk5TqzPofhl1shB2d69RGqQ4jXTYmn+3NqrZWdHXdwQoAI0Mpd3BcilzStIjDN
         qqXuoEOCgHEgRda5GPz2imRexjHTfQNWIrxz+hpCqS1658TTUDjrqfykOH2a5Fm2pIjj
         +k+/GY3+ujZVw0BKUPMMrKSKTwkLaQLD3uFXZMoszsQw/su1yL/exIjg3cO+RzoRdc3V
         1LoGP8tmvSTmceoIfc214mNmD7SyHlsMMnPPTszUZAe3gcTCETvKImPjqZvPwPog2lv/
         vPnA==
X-Gm-Message-State: AOAM533k3S+JRl9ZY1yZXOafHbyHqL/7jNHubiMP1XpOor0FRRowtF3m
        3o+hxAFjtwvf3ABWJ8OS1qyC/w==
X-Google-Smtp-Source: ABdhPJwoVDkQkM9LXc3pdLoQgpULWMLEHnsfC+hWODHW3qgIZu49dmBH7dJTb9nbEp9xFyhRccgiUw==
X-Received: by 2002:a5d:614c:0:b0:20a:e4cd:f7c2 with SMTP id y12-20020a5d614c000000b0020ae4cdf7c2mr4507457wrt.382.1651011337703;
        Tue, 26 Apr 2022 15:15:37 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] thermal/core: Add a thermal sensor structure in the thermal zone
Date:   Wed, 27 Apr 2022 00:15:11 +0200
Message-Id: <20220426221523.3056696-4-daniel.lezcano@linexp.org>
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

The thermal sensor ops is directly defined in the thermal zone but
still its data structuration makes the sensor ops and the thermal zone
too much interconnected for multiple sensors per thermal zone.

Create a dedicated structure for the thermal sensor to be included in
the thermal zone structure so these components are clearly separated.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c |  2 +-
 drivers/thermal/gov_bang_bang.c            |  6 +--
 drivers/thermal/gov_fair_share.c           |  6 +--
 drivers/thermal/gov_power_allocator.c      | 18 ++++----
 drivers/thermal/gov_step_wise.c            |  4 +-
 drivers/thermal/rcar_gen3_thermal.c        |  6 +--
 drivers/thermal/samsung/exynos_tmu.c       |  6 +--
 drivers/thermal/tegra/soctherm.c           | 10 ++---
 drivers/thermal/tegra/tegra30-tsensor.c    |  4 +-
 drivers/thermal/thermal_core.c             | 48 +++++++++++-----------
 drivers/thermal/thermal_helpers.c          | 22 +++++-----
 drivers/thermal/thermal_hwmon.c            |  4 +-
 drivers/thermal/thermal_netlink.c          |  8 ++--
 drivers/thermal/thermal_of.c               | 16 ++++----
 drivers/thermal/thermal_sysfs.c            | 40 +++++++++---------
 include/linux/thermal.h                    |  7 +++-
 16 files changed, 106 insertions(+), 101 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index b057d7a921da..9f274a017d32 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -232,7 +232,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		 * For now we deal only with critical, otherwise
 		 * would need to iterate
 		 */
-		err = tz->ops->get_trip_temp(tz, 0, &trip_temp);
+		err = tz->sensor.ops->get_trip_temp(tz, 0, &trip_temp);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index c899d16c23a0..02ef6a9b03eb 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -18,14 +18,14 @@ static void thermal_zone_trip_update(struct thermal_zone *tz, int trip)
 	int trip_temp, trip_hyst;
 	struct thermal_instance *instance;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	tz->sensor.ops->get_trip_temp(tz, trip, &trip_temp);
 
-	if (!tz->ops->get_trip_hyst) {
+	if (!tz->sensor.ops->get_trip_hyst) {
 		pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
 				"running with default hysteresis zero\n", tz->type);
 		trip_hyst = 0;
 	} else
-		tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
+		tz->sensor.ops->get_trip_hyst(tz, trip, &trip_hyst);
 
 	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
 				trip, trip_temp, tz->temperature,
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index b039df7ab506..3ce42a8e9dbd 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -25,11 +25,11 @@ static int get_trip_level(struct thermal_zone *tz)
 	int trip_temp;
 	enum thermal_trip_type trip_type;
 
-	if (tz->trips == 0 || !tz->ops->get_trip_temp)
+	if (tz->trips == 0 || !tz->sensor.ops->get_trip_temp)
 		return 0;
 
 	for (count = 0; count < tz->trips; count++) {
-		tz->ops->get_trip_temp(tz, count, &trip_temp);
+		tz->sensor.ops->get_trip_temp(tz, count, &trip_temp);
 		if (tz->temperature < trip_temp)
 			break;
 	}
@@ -39,7 +39,7 @@ static int get_trip_level(struct thermal_zone *tz)
 	 * point, in which case, trip_point = count - 1
 	 */
 	if (count > 0) {
-		tz->ops->get_trip_type(tz, count - 1, &trip_type);
+		tz->sensor.ops->get_trip_type(tz, count - 1, &trip_type);
 		trace_thermal_zone_trip(tz, count - 1, trip_type);
 	}
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index dbb4c263eaaf..448baaa642a5 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -130,7 +130,7 @@ static void estimate_pid_constants(struct thermal_zone *tz,
 	u32 temperature_threshold;
 	s32 k_i;
 
-	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
+	ret = tz->sensor.ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
 	if (ret)
 		switch_on_temp = 0;
 
@@ -531,7 +531,7 @@ static void get_governor_trips(struct thermal_zone *tz,
 		enum thermal_trip_type type;
 		int ret;
 
-		ret = tz->ops->get_trip_type(tz, i, &type);
+		ret = tz->sensor.ops->get_trip_type(tz, i, &type);
 		if (ret) {
 			dev_warn(&tz->device,
 				 "Failed to get trip point %d type: %d\n", i,
@@ -669,9 +669,9 @@ static int power_allocator_bind(struct thermal_zone *tz)
 	get_governor_trips(tz, params);
 
 	if (tz->trips > 0) {
-		ret = tz->ops->get_trip_temp(tz,
-					params->trip_max_desired_temperature,
-					&control_temp);
+		ret = tz->sensor.ops->get_trip_temp(tz,
+						    params->trip_max_desired_temperature,
+						    &control_temp);
 		if (!ret)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
@@ -719,8 +719,8 @@ static int power_allocator_throttle(struct thermal_zone *tz, int trip)
 	if (trip != params->trip_max_desired_temperature)
 		return 0;
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
-				     &switch_on_temp);
+	ret = tz->sensor.ops->get_trip_temp(tz, params->trip_switch_on,
+					    &switch_on_temp);
 	if (!ret && (tz->temperature < switch_on_temp)) {
 		update = (tz->last_temperature >= switch_on_temp);
 		tz->passive = 0;
@@ -731,8 +731,8 @@ static int power_allocator_throttle(struct thermal_zone *tz, int trip)
 
 	tz->passive = 1;
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_max_desired_temperature,
-				&control_temp);
+	ret = tz->sensor.ops->get_trip_temp(tz, params->trip_max_desired_temperature,
+					    &control_temp);
 	if (ret) {
 		dev_warn(&tz->device,
 			 "Failed to get the maximum desired temperature: %d\n",
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index de6997fba8eb..88bc16d69f98 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -122,8 +122,8 @@ static void thermal_zone_trip_update(struct thermal_zone *tz, int trip)
 	bool throttle = false;
 	int old_target;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-	tz->ops->get_trip_type(tz, trip, &trip_type);
+	tz->sensor.ops->get_trip_temp(tz, trip, &trip_temp);
+	tz->sensor.ops->get_trip_type(tz, trip, &trip_type);
 
 	trend = get_tz_trend(tz, trip);
 
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 0b03c2d48495..c2d71b1631b2 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -321,7 +321,7 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	if (tsc->zone->ops->set_trips)
+	if (tsc->zone->sensor.ops->set_trips)
 		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
 					IRQ_TEMPD1 | IRQ_TEMP2);
 
@@ -349,7 +349,7 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	if (tsc->zone->ops->set_trips)
+	if (tsc->zone->sensor.ops->set_trips)
 		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
 					IRQ_TEMPD1 | IRQ_TEMP2);
 
@@ -555,7 +555,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 		struct thermal_zone *zone = tsc->zone;
 
 		priv->thermal_init(tsc);
-		if (zone->ops->set_trips)
+		if (zone->sensor.ops->set_trips)
 			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
 						    zone->prev_high_trip);
 	}
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 02ba99395cd1..3260f0717299 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -272,7 +272,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	}
 
 	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
-		ret = tzd->ops->get_crit_temp(tzd, &temp);
+		ret = tzd->sensor.ops->get_crit_temp(tzd, &temp);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"No CRITICAL trip point defined in device tree!\n");
@@ -304,14 +304,14 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < ntrips; i++) {
 			/* Write temperature code for rising threshold */
-			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
+			ret = tzd->sensor.ops->get_trip_temp(tzd, i, &temp);
 			if (ret)
 				goto err;
 			temp /= MCELSIUS;
 			data->tmu_set_trip_temp(data, i, temp);
 
 			/* Write temperature code for falling threshold */
-			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			ret = tzd->sensor.ops->get_trip_hyst(tzd, i, &hyst);
 			if (ret)
 				goto err;
 			hyst /= MCELSIUS;
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 43435e3892dd..6d9dff7cedd1 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -595,7 +595,7 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	if (!tz)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_type(tz, trip, &type);
+	ret = tz->sensor.ops->get_trip_type(tz, trip, &type);
 	if (ret)
 		return ret;
 
@@ -643,7 +643,7 @@ static int tegra_thermctl_get_trend(void *data, int trip,
 	if (!tz)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
+	ret = tz->sensor.ops->get_trip_temp(zone->tz, trip, &trip_temp);
 	if (ret)
 		return ret;
 
@@ -730,11 +730,11 @@ static int get_hot_temp(struct thermal_zone *tz, int *trip, int *temp)
 		return -EINVAL;
 
 	for (i = 0; i < ntrips; i++) {
-		ret = tz->ops->get_trip_type(tz, i, &type);
+		ret = tz->sensor.ops->get_trip_type(tz, i, &type);
 		if (ret)
 			return -EINVAL;
 		if (type == THERMAL_TRIP_HOT) {
-			ret = tz->ops->get_trip_temp(tz, i, temp);
+			ret = tz->sensor.ops->get_trip_temp(tz, i, temp);
 			if (!ret)
 				*trip = i;
 
@@ -780,7 +780,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
 	if (min_low_temp == temperature)
-		if (tz->ops->get_crit_temp(tz, &temperature))
+		if (tz->sensor.ops->get_crit_temp(tz, &temperature))
 			temperature = max_high_temp;
 
 	ret = thermtrip_program(dev, sg, temperature);
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 80053571c53a..ad35a9694845 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -320,8 +320,8 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone *tzd,
 		enum thermal_trip_type type;
 		int trip_temp;
 
-		tzd->ops->get_trip_temp(tzd, i, &trip_temp);
-		tzd->ops->get_trip_type(tzd, i, &type);
+		tzd->sensor.ops->get_trip_temp(tzd, i, &trip_temp);
+		tzd->sensor.ops->get_trip_type(tzd, i, &type);
 
 		if (type == THERMAL_TRIP_HOT)
 			*hot_trip = trip_temp;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d0eef7297c99..b1d20c8ba3d1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -344,7 +344,7 @@ static void handle_critical_trips(struct thermal_zone *tz,
 {
 	int trip_temp;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	tz->sensor.ops->get_trip_temp(tz, trip, &trip_temp);
 
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
@@ -352,10 +352,10 @@ static void handle_critical_trips(struct thermal_zone *tz,
 
 	trace_thermal_zone_trip(tz, trip, trip_type);
 
-	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
-		tz->ops->hot(tz);
+	if (trip_type == THERMAL_TRIP_HOT && tz->sensor.ops->hot)
+		tz->sensor.ops->hot(tz);
 	else if (trip_type == THERMAL_TRIP_CRITICAL)
-		tz->ops->critical(tz);
+		tz->sensor.ops->critical(tz);
 }
 
 static void handle_thermal_trip(struct thermal_zone *tz, int trip)
@@ -367,10 +367,10 @@ static void handle_thermal_trip(struct thermal_zone *tz, int trip)
 	if (test_bit(trip, &tz->trips_disabled))
 		return;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-	tz->ops->get_trip_type(tz, trip, &type);
-	if (tz->ops->get_trip_hyst)
-		tz->ops->get_trip_hyst(tz, trip, &hyst);
+	tz->sensor.ops->get_trip_temp(tz, trip, &trip_temp);
+	tz->sensor.ops->get_trip_type(tz, trip, &type);
+	if (tz->sensor.ops->get_trip_hyst)
+		tz->sensor.ops->get_trip_hyst(tz, trip, &hyst);
 
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
 		if (tz->last_temperature < trip_temp &&
@@ -441,8 +441,8 @@ static int thermal_zone_set_mode(struct thermal_zone *tz,
 		return ret;
 	}
 
-	if (tz->ops->change_mode)
-		ret = tz->ops->change_mode(tz, mode);
+	if (tz->sensor.ops->change_mode)
+		ret = tz->sensor.ops->change_mode(tz, mode);
 
 	if (!ret)
 		tz->mode = mode;
@@ -495,7 +495,7 @@ void thermal_zone_update(struct thermal_zone *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
+	if (WARN_ONCE(!tz->sensor.ops->get_temp, "'%s' must not be called without "
 		      "'get_temp' ops set\n", __func__))
 		return;
 
@@ -839,11 +839,11 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	mutex_lock(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (!pos->tzp && !pos->ops->bind)
+		if (!pos->tzp && !pos->sensor.ops->bind)
 			continue;
 
-		if (pos->ops->bind) {
-			ret = pos->ops->bind(pos, cdev);
+		if (pos->sensor.ops->bind) {
+			ret = pos->sensor.ops->bind(pos, cdev);
 			if (ret)
 				print_bind_err_msg(pos, cdev, ret);
 			continue;
@@ -1091,8 +1091,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->ops->unbind) {
-			tz->ops->unbind(tz, cdev);
+		if (tz->sensor.ops->unbind) {
+			tz->sensor.ops->unbind(tz, cdev);
 			continue;
 		}
 
@@ -1124,15 +1124,15 @@ static void bind_tz(struct thermal_zone *tz)
 	struct thermal_cooling_device *pos = NULL;
 	const struct thermal_zone_params *tzp = tz->tzp;
 
-	if (!tzp && !tz->ops->bind)
+	if (!tzp && !tz->sensor.ops->bind)
 		return;
 
 	mutex_lock(&thermal_list_lock);
 
 	/* If there is ops->bind, try to use ops->bind */
-	if (tz->ops->bind) {
+	if (tz->sensor.ops->bind) {
 		list_for_each_entry(pos, &thermal_cdev_list, node) {
-			ret = tz->ops->bind(tz, pos);
+			ret = tz->sensor.ops->bind(tz, pos);
 			if (ret)
 				print_bind_err_msg(tz, pos, ret);
 		}
@@ -1243,7 +1243,7 @@ thermal_zone_register(const char *type, int trips, int mask,
 	if (!ops->critical)
 		ops->critical = thermal_zone_critical;
 
-	tz->ops = ops;
+	tz->sensor.ops = ops;
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
@@ -1266,8 +1266,8 @@ thermal_zone_register(const char *type, int trips, int mask,
 		goto release_device;
 
 	for (count = 0; count < trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
-		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
+		if (tz->sensor.ops->get_trip_type(tz, count, &trip_type) ||
+		    tz->sensor.ops->get_trip_temp(tz, count, &trip_temp) ||
 		    !trip_temp)
 			set_bit(count, &tz->trips_disabled);
 	}
@@ -1355,8 +1355,8 @@ void thermal_zone_unregister(struct thermal_zone *tz)
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node) {
-		if (tz->ops->unbind) {
-			tz->ops->unbind(tz, cdev);
+		if (tz->sensor.ops->unbind) {
+			tz->sensor.ops->unbind(tz, cdev);
 			continue;
 		}
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 841cb3f43036..41d6898ec5b3 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -27,8 +27,8 @@ int get_tz_trend(struct thermal_zone *tz, int trip)
 {
 	enum thermal_trend trend;
 
-	if (tz->emul_temperature || !tz->ops->get_trend ||
-	    tz->ops->get_trend(tz, trip, &trend)) {
+	if (tz->emul_temperature || !tz->sensor.ops->get_trend ||
+	    tz->sensor.ops->get_trend(tz, trip, &trend)) {
 		if (tz->temperature > tz->last_temperature)
 			trend = THERMAL_TREND_RAISING;
 		else if (tz->temperature < tz->last_temperature)
@@ -82,19 +82,19 @@ int thermal_zone_get_temp(struct thermal_zone *tz, int *temp)
 	int crit_temp = INT_MAX;
 	enum thermal_trip_type type;
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
+	if (!tz || IS_ERR(tz) || !tz->sensor.ops->get_temp)
 		goto exit;
 
 	mutex_lock(&tz->lock);
 
-	ret = tz->ops->get_temp(tz, temp);
+	ret = tz->sensor.ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
 		for (count = 0; count < tz->trips; count++) {
-			ret = tz->ops->get_trip_type(tz, count, &type);
+			ret = tz->sensor.ops->get_trip_type(tz, count, &type);
 			if (!ret && type == THERMAL_TRIP_CRITICAL) {
-				ret = tz->ops->get_trip_temp(tz, count,
-						&crit_temp);
+				ret = tz->sensor.ops->get_trip_temp(tz, count,
+								    &crit_temp);
 				break;
 			}
 		}
@@ -135,14 +135,14 @@ void thermal_zone_set_trips(struct thermal_zone *tz)
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
+	if (!tz->sensor.ops->set_trips || !tz->sensor.ops->get_trip_hyst)
 		goto exit;
 
 	for (i = 0; i < tz->trips; i++) {
 		int trip_low;
 
-		tz->ops->get_trip_temp(tz, i, &trip_temp);
-		tz->ops->get_trip_hyst(tz, i, &hysteresis);
+		tz->sensor.ops->get_trip_temp(tz, i, &trip_temp);
+		tz->sensor.ops->get_trip_hyst(tz, i, &hysteresis);
 
 		trip_low = trip_temp - hysteresis;
 
@@ -167,7 +167,7 @@ void thermal_zone_set_trips(struct thermal_zone *tz)
 	 * Set a temperature window. When this window is left the driver
 	 * must inform the thermal core via thermal_zone_update.
 	 */
-	ret = tz->ops->set_trips(tz, low, high);
+	ret = tz->sensor.ops->set_trips(tz, low, high);
 	if (ret)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index bdf5639fe214..c0900750735f 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -77,7 +77,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int temperature;
 	int ret;
 
-	ret = tz->ops->get_crit_temp(tz, &temperature);
+	ret = tz->sensor.ops->get_crit_temp(tz, &temperature);
 	if (ret)
 		return ret;
 
@@ -126,7 +126,7 @@ thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
 static bool thermal_zone_crit_temp_valid(struct thermal_zone *tz)
 {
 	int temp;
-	return tz->ops->get_crit_temp && !tz->ops->get_crit_temp(tz, &temp);
+	return tz->sensor.ops->get_crit_temp && !tz->sensor.ops->get_crit_temp(tz, &temp);
 }
 
 int thermal_add_hwmon_sysfs(struct thermal_zone *tz)
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 88c28c5205b8..0e95f113d525 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -474,10 +474,10 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 		enum thermal_trip_type type;
 		int temp, hyst = 0;
 
-		tz->ops->get_trip_type(tz, i, &type);
-		tz->ops->get_trip_temp(tz, i, &temp);
-		if (tz->ops->get_trip_hyst)
-			tz->ops->get_trip_hyst(tz, i, &hyst);
+		tz->sensor.ops->get_trip_type(tz, i, &type);
+		tz->sensor.ops->get_trip_temp(tz, i, &temp);
+		if (tz->sensor.ops->get_trip_hyst)
+			tz->sensor.ops->get_trip_hyst(tz, i, &hyst);
 
 		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 8d958bec69d9..932b6450eac4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -395,18 +395,18 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	tz->ops = ops;
 	tz->sensor_data = data;
 
-	tzd->ops->get_temp = of_thermal_get_temp;
-	tzd->ops->get_trend = of_thermal_get_trend;
+	tzd->sensor.ops->get_temp = of_thermal_get_temp;
+	tzd->sensor.ops->get_trend = of_thermal_get_trend;
 
 	/*
 	 * The thermal zone core will calculate the window if they have set the
 	 * optional set_trips pointer.
 	 */
 	if (ops->set_trips)
-		tzd->ops->set_trips = of_thermal_set_trips;
+		tzd->sensor.ops->set_trips = of_thermal_set_trips;
 
 	if (ops->set_emul_temp)
-		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
+		tzd->sensor.ops->set_emul_temp = of_thermal_set_emul_temp;
 
 	mutex_unlock(&tzd->lock);
 
@@ -566,9 +566,9 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	thermal_zone_disable(tzd);
 
 	mutex_lock(&tzd->lock);
-	tzd->ops->get_temp = NULL;
-	tzd->ops->get_trend = NULL;
-	tzd->ops->set_emul_temp = NULL;
+	tzd->sensor.ops->get_temp = NULL;
+	tzd->sensor.ops->get_trend = NULL;
+	tzd->sensor.ops->set_emul_temp = NULL;
 
 	tz->ops = NULL;
 	tz->sensor_data = NULL;
@@ -1024,7 +1024,7 @@ static __init void of_thermal_destroy_zones(void)
 
 		thermal_zone_unregister(zone);
 		kfree(zone->tzp);
-		kfree(zone->ops);
+		kfree(zone->sensor.ops);
 		of_thermal_free_zone(zone->devdata);
 	}
 	of_node_put(np);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 083578e736cc..33d8c9f47990 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -82,13 +82,13 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	enum thermal_trip_type type;
 	int trip, result;
 
-	if (!tz->ops->get_trip_type)
+	if (!tz->sensor.ops->get_trip_type)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
-	result = tz->ops->get_trip_type(tz, trip, &type);
+	result = tz->sensor.ops->get_trip_type(tz, trip, &type);
 	if (result)
 		return result;
 
@@ -115,7 +115,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	int temperature, hyst = 0;
 	enum thermal_trip_type type;
 
-	if (!tz->ops->set_trip_temp)
+	if (!tz->sensor.ops->set_trip_temp)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
@@ -124,17 +124,17 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	ret = tz->ops->set_trip_temp(tz, trip, temperature);
+	ret = tz->sensor.ops->set_trip_temp(tz, trip, temperature);
 	if (ret)
 		return ret;
 
-	if (tz->ops->get_trip_hyst) {
-		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
+	if (tz->sensor.ops->get_trip_hyst) {
+		ret = tz->sensor.ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
 			return ret;
 	}
 
-	ret = tz->ops->get_trip_type(tz, trip, &type);
+	ret = tz->sensor.ops->get_trip_type(tz, trip, &type);
 	if (ret)
 		return ret;
 
@@ -153,13 +153,13 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	int trip, ret;
 	int temperature;
 
-	if (!tz->ops->get_trip_temp)
+	if (!tz->sensor.ops->get_trip_temp)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	ret = tz->sensor.ops->get_trip_temp(tz, trip, &temperature);
 
 	if (ret)
 		return ret;
@@ -175,7 +175,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	int trip, ret;
 	int temperature;
 
-	if (!tz->ops->set_trip_hyst)
+	if (!tz->sensor.ops->set_trip_hyst)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
@@ -189,7 +189,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	 * here. The driver implementing 'set_trip_hyst' has to
 	 * take care of this.
 	 */
-	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+	ret = tz->sensor.ops->set_trip_hyst(tz, trip, temperature);
 
 	if (!ret)
 		thermal_zone_set_trips(tz);
@@ -205,13 +205,13 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	int trip, ret;
 	int temperature;
 
-	if (!tz->ops->get_trip_hyst)
+	if (!tz->sensor.ops->get_trip_hyst)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	ret = tz->sensor.ops->get_trip_hyst(tz, trip, &temperature);
 
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
@@ -260,12 +260,12 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	if (!tz->ops->set_emul_temp) {
+	if (!tz->sensor.ops->set_emul_temp) {
 		mutex_lock(&tz->lock);
 		tz->emul_temperature = temperature;
 		mutex_unlock(&tz->lock);
 	} else {
-		ret = tz->ops->set_emul_temp(tz, temperature);
+		ret = tz->sensor.ops->set_emul_temp(tz, temperature);
 	}
 
 	if (!ret)
@@ -431,7 +431,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
+	if (tz->sensor.ops->get_trip_hyst) {
 		tz->trip_hyst_attrs = kcalloc(tz->trips,
 					      sizeof(*tz->trip_hyst_attrs),
 					      GFP_KERNEL);
@@ -446,7 +446,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
+		if (tz->sensor.ops->get_trip_hyst)
 			kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
@@ -481,7 +481,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
 		attrs[indx + tz->trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
 		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
+		if (!tz->sensor.ops->get_trip_hyst)
 			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
@@ -491,7 +491,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
+		if (tz->sensor.ops->set_trip_hyst) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
@@ -519,7 +519,7 @@ static void destroy_trip_attrs(struct thermal_zone *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
+	if (tz->sensor.ops->get_trip_hyst)
 		kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 06b6b743d5c4..b3e8244af510 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -80,6 +80,11 @@ struct thermal_sensor_ops {
 	void (*critical)(struct thermal_zone *);
 };
 
+struct thermal_sensor {
+	struct thermal_sensor_ops *ops;
+	struct device *dev;
+};
+
 struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
@@ -164,7 +169,7 @@ struct thermal_zone {
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-	struct thermal_sensor_ops *ops;
+	struct thermal_sensor sensor;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
-- 
2.25.1

