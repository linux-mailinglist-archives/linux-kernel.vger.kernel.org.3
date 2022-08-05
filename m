Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0C58AD1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiHEPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbiHEPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:38:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952E24BCA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:38:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so4139371wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QbP1CQ2OLF0bQuXpLH2jFFQL9/YSjb7PHhFwyob8Fo4=;
        b=z36qiBVG4vFuawViw3ZQATfX0PpGW7/s4nfkCOT7qhETFDOpdfU71DBijBjEJRIi3n
         M6Bcme2R0/ooDP8z63GV/snYpXuX+cswNMqo9vuPKrit4f/IxQACiF44pXiACYfPbROu
         UbN++L87vHLuJQLovqwjlql8Z0weA4fWT+5EoNu6dH2cvVJp9QGWBKn/wV8+LtlxNVDG
         a7IWzAP1i761s7RgfAs5S0zQSYHLXHsUB/3l8rEGtJ9oCRXvyfSmvC8WjoPrgIJKlRIF
         CCYBTigvHSAtCSDcF914WS1I1GT3VREiKCmGCRpY99kgGrYyKD1gaBeRgKgLuxSe0GRc
         eimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QbP1CQ2OLF0bQuXpLH2jFFQL9/YSjb7PHhFwyob8Fo4=;
        b=auYAdKNtWUDPfDWMo3wahnwUGhQwFXHfw/lCll0Ol7FxeZF4wigWUz1nF0kn51ihKH
         g5+hkMJfwMObfb0S8jGrAIiy1IsLuG3M0egGc2DNZJb/j+x0eiz3y2M1H5txXSN1aAPq
         Dy368vHqRpQMlwqRasRo4seaDqhQXl/8veSuPvEmvTHAY4d1VVDxR3pY5VE0o6ysuc6n
         VXtQyKopCT//VgZt7a5+sUo2JY6H+Q1+oVKaa/Fsw3UshTaYblGtOzlOHZJaZOhTk2ZM
         HEfl52ae+KzGaaOyxhiScMHNxav9ZxcagYRePGaekSUlEERfXcD7o8Y4jDXh83JBb8il
         vMXA==
X-Gm-Message-State: ACgBeo1sm2/bHnYvkb51SSDVRCthkI5jXa3xHDCorTfxJ+0NbSgGvBmL
        /LGmM6SGiYTCRXfU58AsfAlIMA==
X-Google-Smtp-Source: AA6agR7pGdNaLkbadQF7fzFpgQUmEhgMiAcG1S/YAt5J2ERgYi5eijiRPzHa+LtPcc2uUvziv7EXEw==
X-Received: by 2002:a05:600c:58e:b0:3a5:2c3:5e17 with SMTP id o14-20020a05600c058e00b003a502c35e17mr8078047wmd.200.1659713929361;
        Fri, 05 Aug 2022 08:38:49 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002217540b222sm1721025wrq.58.2022.08.05.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:38:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 4/5] thermal/core: Move the thermal zone lock out of the governors
Date:   Fri,  5 Aug 2022 17:38:33 +0200
Message-Id: <20220805153834.2510142-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the governors throttling ops are taking/releasing the lock at the
beginning and the end of the function.

We can move the mutex to the throttling call site instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       |  4 +---
 drivers/thermal/gov_fair_share.c      |  4 +---
 drivers/thermal/gov_power_allocator.c | 16 ++++++----------
 drivers/thermal/gov_step_wise.c       |  4 +---
 drivers/thermal/thermal_core.c        |  2 ++
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index f0bff2e0475b..a08bbe33be96 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -96,15 +96,13 @@ static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	thermal_zone_trip_update(tz, trip);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 5d5ddd648cd2..a4ee4661e9cc 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -82,7 +82,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	int total_instance = 0;
 	int cur_trip_level = get_trip_level(tz);
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
@@ -112,8 +112,6 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		mutex_unlock(&cdev->lock);
 	}
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d3aca236e274..2d1aeaba38a8 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -697,19 +697,19 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
-	int ret = 0;
+	int ret;
 	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
 	bool update;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	/*
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
 	if (trip != params->trip_max_desired_temperature)
-		goto out;
+		return 0;
 
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
@@ -718,7 +718,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
-		goto out;
+		return 0;
 	}
 
 	tz->passive = 1;
@@ -729,14 +729,10 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		dev_warn(&tz->device,
 			 "Failed to get the maximum desired temperature: %d\n",
 			 ret);
-		goto out;
+		return ret;
 	}
 
-	ret = allocate_power(tz, control_temp);
-
-	mutex_unlock(&tz->lock);
-out:
-	return ret;
+	return allocate_power(tz, control_temp);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 597a0ebec7a4..cdd3354bc27f 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -160,15 +160,13 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	thermal_zone_trip_update(tz, trip);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d7029fd1c112..9d554f97e081 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -311,8 +311,10 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 
 static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
+	mutex_lock(&tz->lock);
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
+	mutex_unlock(&tz->lock);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
-- 
2.25.1

