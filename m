Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB858AD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiHEPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiHEPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:38:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C539237F4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:38:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so1583708wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N6F1KWOnquRUouMVh2G6/70txn8l+RtXgOaeM52+cMU=;
        b=V2XfY7982nfVB9EPf9DcG6vgZp5KQoMpU91mPaqcS+EgJmGv7BXdpdU7PvOWsrQMZu
         Duf0uuqVQpOprvC+RUl+/z9hvlsZty5RyaOL+gQjIynYhJqrArH/Hb3DF+Jh1BhkR72I
         5dvJtxs0Xxo74w9qAB2iymM1uf/j5cB6xTLMziat5Ms+WEezdOamVqro1v3dT4Zgtxei
         qBUBVXxbZ1uY6o4/ONmlO8nEp9aVnhKmLDAebff3K2gswoALA6+HihaBF85aTkehxU0y
         rRufOHKpU/p8LN23eFpbxVeJcMpAQiHLGFdfTKRN6ohtjHsaxfWJEtyoP6jiVxbaeKPg
         EqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N6F1KWOnquRUouMVh2G6/70txn8l+RtXgOaeM52+cMU=;
        b=hVMlKcOokDYYa1dtBZbbk7XebrCmdsGqNQSoHiZ6LVmY5351gk6Mnk4MHhv4KrzoMH
         XzGHkSSGxla3zce0vWbJQ8RQVQ0RCpcbaCtnKzwt6I4N+tC6tH5DyCNlfKjF1XdFGykc
         mDfg8/+TcgEwVH88BUJoYAMCtVxkL0r5q1jKXHoGXF18Vv49xqpjBRqM4cAq+2d+KtkI
         Z32ZCTkWVgWj004awYIOz7wrsS9U3mqCM0NQlU8fNYpeKfvYqzcYWsXbqK6RdcoA8ux3
         bH0Je6Ky3KPD79yR8rr2ZE8JpKhyiELYBrotwteMI6lMutClV9uwFLyRNTAhLI+RtW32
         18uA==
X-Gm-Message-State: ACgBeo037Xqy62+2XdUkyfdjop4ZZ/LJl06JhqkB/TGEctGOcw0tbS82
        BLj4WbTKXelje+icmAQpZP1P2A==
X-Google-Smtp-Source: AA6agR7UD70typjSKOyMwB0tdF6biWcDynYwwuQQGpaeIGKp9oaEzgOTLqU7sBujDYIh1O48hFSdxA==
X-Received: by 2002:a05:600c:a146:b0:3a3:1e79:4446 with SMTP id ib6-20020a05600ca14600b003a31e794446mr5193441wmb.158.1659713927788;
        Fri, 05 Aug 2022 08:38:47 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002217540b222sm1721025wrq.58.2022.08.05.08.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:38:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 3/5] thermal/governors: Group the thermal zone lock inside the throttle function
Date:   Fri,  5 Aug 2022 17:38:32 +0200
Message-Id: <20220805153834.2510142-3-daniel.lezcano@linaro.org>
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

The thermal zone lock is taken in the different places in the
throttling path.

At the first glance it does not hurt to move them at the beginning and
the end of the 'throttle' function. That will allow a consolidation of
the lock in the next following changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       |  8 ++-----
 drivers/thermal/gov_fair_share.c      |  1 +
 drivers/thermal/gov_power_allocator.c | 34 ++++++++++++---------------
 drivers/thermal/gov_step_wise.c       |  8 ++-----
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c54296d..f0bff2e0475b 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -31,8 +31,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 				trip, trip_temp, tz->temperature,
 				trip_hyst);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -65,8 +63,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -100,10 +96,10 @@ static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	thermal_zone_trip_update(tz, trip);
-
 	mutex_lock(&tz->lock);
 
+	thermal_zone_trip_update(tz, trip);
+
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 6a2abcfc648f..5d5ddd648cd2 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -113,6 +113,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	}
 
 	mutex_unlock(&tz->lock);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1d5052470967..d3aca236e274 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -392,8 +392,6 @@ static int allocate_power(struct thermal_zone_device *tz,
 	int i, num_actors, total_weight, ret = 0;
 	int trip_max_desired_temperature = params->trip_max_desired_temperature;
 
-	mutex_lock(&tz->lock);
-
 	num_actors = 0;
 	total_weight = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
@@ -404,10 +402,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 		}
 	}
 
-	if (!num_actors) {
-		ret = -ENODEV;
-		goto unlock;
-	}
+	if (!num_actors)
+		return -ENODEV;
 
 	/*
 	 * We need to allocate five arrays of the same size:
@@ -421,10 +417,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
 	req_power = kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
-	if (!req_power) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!req_power)
+		return -ENOMEM;
 
 	max_power = &req_power[num_actors];
 	granted_power = &req_power[2 * num_actors];
@@ -496,8 +490,6 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      control_temp - tz->temperature);
 
 	kfree(req_power);
-unlock:
-	mutex_unlock(&tz->lock);
 
 	return ret;
 }
@@ -576,7 +568,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 	struct power_allocator_params *params = tz->governor_data;
 	u32 req_power;
 
-	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 
@@ -598,7 +589,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 
 		mutex_unlock(&instance->cdev->lock);
 	}
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -707,17 +697,19 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
-	int ret;
+	int ret = 0;
 	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
 	bool update;
 
+	mutex_lock(&tz->lock);
+
 	/*
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
 	if (trip != params->trip_max_desired_temperature)
-		return 0;
+		goto out;
 
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
@@ -726,7 +718,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
-		return 0;
+		goto out;
 	}
 
 	tz->passive = 1;
@@ -737,10 +729,14 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		dev_warn(&tz->device,
 			 "Failed to get the maximum desired temperature: %d\n",
 			 ret);
-		return ret;
+		goto out;
 	}
 
-	return allocate_power(tz, control_temp);
+	ret = allocate_power(tz, control_temp);
+
+	mutex_unlock(&tz->lock);
+out:
+	return ret;
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 9729b46d0258..597a0ebec7a4 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -117,8 +117,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
 				trip, trip_type, trip_temp, trend, throttle);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -145,8 +143,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -164,10 +160,10 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	thermal_zone_trip_update(tz, trip);
-
 	mutex_lock(&tz->lock);
 
+	thermal_zone_trip_update(tz, trip);
+
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-- 
2.25.1

