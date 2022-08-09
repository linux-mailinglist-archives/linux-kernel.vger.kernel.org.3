Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2158E264
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiHIWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHIWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:04:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F15B862
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:04:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so15717966wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=faENzfdLEIc3OGEyTrIL1keHRAXh0simrj9p3sTfVj4=;
        b=vQha2B/RbJTWKUqLHpayEnyR1V5iOcpkdXlfRFYTl3NqCP5HHdD7hsCPi5K34owGY6
         vdonwUQL0BfWmp1uZBRxefZZ1HW8IsFIQDbdZvH3sxJaBh88I3Ly3qyl5QlTEuzHOnII
         lgjoR5nEN9YhzF1WR6AwH3rpuf99XQ6Ejei0vkpN0V73DzWF5fXKY6tc8GqRuDEjWuvA
         NqXv9qXsRtjCHHChk077EAIFD9k9DxwayYtc5X3kArEyXlP7M2mz4JN20YIfhz4f8aYR
         NxEmXL3ZKWdlAjzUErz/QaGjJq4gwN2atZnUpCITdufw+VJ0QCR47WHrwZnC0Gbaa9sY
         k3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=faENzfdLEIc3OGEyTrIL1keHRAXh0simrj9p3sTfVj4=;
        b=Gbzm48b6ai+dLW0l+MWVy+A5G9DlTJA3XixYLNqLHL9THh2G8IXlPHo25i+oFhBzHc
         F6T+0o74dCXh5NdoPLoPfNxurAYJf81kUVjKkokUVoK4Tjwim4mVYg+zJ331gV5qG+zL
         yDT4u5Gu5YVYefGo1PghSm85DC13FMjB3g8r7Hd9YY/AQPGSa9E89wq3GEI+ljK8VO2V
         fBdhlaYS+piYya0O1EJngkJ0W2a55iM0VI+pK8ljrQ54Tiz63PkYKLx2HyH9uWyGBdt2
         qjQV95VcpyYfhR7gnK/IA09WMG964oOF2ak9Np/70A9dgtV2aHjlLro4aw3OXj0Gdj4D
         FdYw==
X-Gm-Message-State: ACgBeo3jbVl37+Wu73cr2KcVZQocR0GPmgAUkTMwVIYgrYiYYkVR+tkr
        MXwjN77k4xuQbUf7OuNNzL6Zyw==
X-Google-Smtp-Source: AA6agR7H4dt/ZjseY2Pck65pRVm8zwgAliekIX9+pRzmTS+3xbSj3apLPy8MAqTSnGF2vRomKYGxwA==
X-Received: by 2002:a05:6000:1ac8:b0:220:6af3:935d with SMTP id i8-20020a0560001ac800b002206af3935dmr15260864wry.549.1660082696842;
        Tue, 09 Aug 2022 15:04:56 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:04:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 03/26] thermal/core/governors: Use thermal_zone_get_trip() instead of ops functions
Date:   Wed, 10 Aug 2022 00:04:13 +0200
Message-Id: <20220809220436.711020-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The governors are using the ops->get_trip_* functions, Replace these
calls with thermal_zone_get_trip().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       | 23 +++++-------
 drivers/thermal/gov_fair_share.c      | 18 ++++------
 drivers/thermal/gov_power_allocator.c | 51 ++++++++++++---------------
 drivers/thermal/gov_step_wise.c       | 22 ++++++------
 4 files changed, 47 insertions(+), 67 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c54296d..de59ea9e2f7b 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -13,28 +13,21 @@
 
 #include "thermal_core.h"
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
 {
-	int trip_temp, trip_hyst;
+	struct thermal_trip trip;
 	struct thermal_instance *instance;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
-	if (!tz->ops->get_trip_hyst) {
-		pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
-				"running with default hysteresis zero\n", tz->type);
-		trip_hyst = 0;
-	} else
-		tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
+	thermal_zone_get_trip(tz, trip_id, &trip);
 
 	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
-				trip, trip_temp, tz->temperature,
-				trip_hyst);
+				trip_id, trip.temperature, tz->temperature,
+				trip.hysteresis);
 
 	mutex_lock(&tz->lock);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
+		if (instance->trip != trip_id)
 			continue;
 
 		/* in case fan is in initial state, switch the fan off */
@@ -52,10 +45,10 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		 * enable fan when temperature exceeds trip_temp and disable
 		 * the fan in case it falls below trip_temp minus hysteresis
 		 */
-		if (instance->target == 0 && tz->temperature >= trip_temp)
+		if (instance->target == 0 && tz->temperature >= trip.temperature)
 			instance->target = 1;
 		else if (instance->target == 1 &&
-				tz->temperature <= trip_temp - trip_hyst)
+			 tz->temperature <= trip.temperature - trip.hysteresis)
 			instance->target = 0;
 
 		dev_dbg(&instance->cdev->device, "target=%d\n",
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 6a2abcfc648f..877d52605871 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -21,16 +21,12 @@
  */
 static int get_trip_level(struct thermal_zone_device *tz)
 {
-	int count = 0;
-	int trip_temp;
-	enum thermal_trip_type trip_type;
-
-	if (tz->num_trips == 0 || !tz->ops->get_trip_temp)
-		return 0;
+	struct thermal_trip trip;
+	int count;
 
 	for (count = 0; count < tz->num_trips; count++) {
-		tz->ops->get_trip_temp(tz, count, &trip_temp);
-		if (tz->temperature < trip_temp)
+		thermal_zone_get_trip(tz, count, &trip);
+		if (tz->temperature < trip.temperature)
 			break;
 	}
 
@@ -38,10 +34,8 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	 * count > 0 only if temperature is greater than first trip
 	 * point, in which case, trip_point = count - 1
 	 */
-	if (count > 0) {
-		tz->ops->get_trip_type(tz, count - 1, &trip_type);
-		trace_thermal_zone_trip(tz, count - 1, trip_type);
-	}
+	if (count > 0)
+		trace_thermal_zone_trip(tz, count - 1, trip.type);
 
 	return count;
 }
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1d5052470967..54ba05d532db 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -125,16 +125,15 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 				   u32 sustainable_power, int trip_switch_on,
 				   int control_temp)
 {
+	struct thermal_trip trip;
+	u32 temperature_threshold = control_temp;
 	int ret;
-	int switch_on_temp;
-	u32 temperature_threshold;
 	s32 k_i;
 
-	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
-	if (ret)
-		switch_on_temp = 0;
+	ret = thermal_zone_get_trip(tz, trip_switch_on, &trip);
+	if (!ret)
+		temperature_threshold -= trip.temperature;
 
-	temperature_threshold = control_temp - switch_on_temp;
 	/*
 	 * estimate_pid_constants() tries to find appropriate default
 	 * values for thermal zones that don't provide them. If a
@@ -528,10 +527,10 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 	last_passive = INVALID_TRIP;
 
 	for (i = 0; i < tz->num_trips; i++) {
-		enum thermal_trip_type type;
+		struct thermal_trip trip;
 		int ret;
 
-		ret = tz->ops->get_trip_type(tz, i, &type);
+		ret = thermal_zone_get_trip(tz, i, &trip);
 		if (ret) {
 			dev_warn(&tz->device,
 				 "Failed to get trip point %d type: %d\n", i,
@@ -539,14 +538,14 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 			continue;
 		}
 
-		if (type == THERMAL_TRIP_PASSIVE) {
+		if (trip.type == THERMAL_TRIP_PASSIVE) {
 			if (!found_first_passive) {
 				params->trip_switch_on = i;
 				found_first_passive = true;
 			} else  {
 				last_passive = i;
 			}
-		} else if (type == THERMAL_TRIP_ACTIVE) {
+		} else if (trip.type == THERMAL_TRIP_ACTIVE) {
 			last_active = i;
 		} else {
 			break;
@@ -643,7 +642,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 {
 	int ret;
 	struct power_allocator_params *params;
-	int control_temp;
+	struct thermal_trip trip;
 
 	ret = check_power_actors(tz);
 	if (ret)
@@ -669,13 +668,12 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	get_governor_trips(tz, params);
 
 	if (tz->num_trips > 0) {
-		ret = tz->ops->get_trip_temp(tz,
-					params->trip_max_desired_temperature,
-					&control_temp);
+		ret = thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
+					    &trip);
 		if (!ret)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
-					       control_temp);
+					       trip.temperature);
 	}
 
 	reset_pid_controller(params);
@@ -705,24 +703,23 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 	tz->governor_data = NULL;
 }
 
-static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
+static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 {
-	int ret;
-	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_trip trip;
+	int ret;
 	bool update;
 
 	/*
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
-	if (trip != params->trip_max_desired_temperature)
+	if (trip_id != params->trip_max_desired_temperature)
 		return 0;
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
-				     &switch_on_temp);
-	if (!ret && (tz->temperature < switch_on_temp)) {
-		update = (tz->last_temperature >= switch_on_temp);
+	ret = thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
+	if (!ret && (tz->temperature < trip.temperature)) {
+		update = (tz->last_temperature >= trip.temperature);
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
@@ -731,16 +728,14 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 
 	tz->passive = 1;
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_max_desired_temperature,
-				&control_temp);
+	ret = thermal_zone_get_trip(tz, params->trip_max_desired_temperature, &trip);
 	if (ret) {
-		dev_warn(&tz->device,
-			 "Failed to get the maximum desired temperature: %d\n",
+		dev_warn(&tz->device, "Failed to get the maximum desired temperature: %d\n",
 			 ret);
 		return ret;
 	}
 
-	return allocate_power(tz, control_temp);
+	return allocate_power(tz, trip.temperature);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 9729b46d0258..886016c7cd3d 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -95,32 +95,30 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 		tz->passive += value;
 }
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
 {
-	int trip_temp;
-	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
+	struct thermal_trip trip;
 	bool throttle = false;
 	int old_target;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-	tz->ops->get_trip_type(tz, trip, &trip_type);
+	thermal_zone_get_trip(tz, trip_id, &trip);
 
-	trend = get_tz_trend(tz, trip);
+	trend = get_tz_trend(tz, trip_id);
 
-	if (tz->temperature >= trip_temp) {
+	if (tz->temperature >= trip.temperature) {
 		throttle = true;
-		trace_thermal_zone_trip(tz, trip, trip_type);
+		trace_thermal_zone_trip(tz, trip_id, trip.type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-				trip, trip_type, trip_temp, trend, throttle);
+				trip_id, trip.type, trip.temperature, trend, throttle);
 
 	mutex_lock(&tz->lock);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
+		if (instance->trip != trip_id)
 			continue;
 
 		old_target = instance->target;
@@ -134,11 +132,11 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		/* Activate a passive thermal instance */
 		if (old_target == THERMAL_NO_TARGET &&
 			instance->target != THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, 1);
+			update_passive_instance(tz, trip.type, 1);
 		/* Deactivate a passive thermal instance */
 		else if (old_target != THERMAL_NO_TARGET &&
 			instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, -1);
+			update_passive_instance(tz, trip.type, -1);
 
 		instance->initialized = true;
 		mutex_lock(&instance->cdev->lock);
-- 
2.34.1

