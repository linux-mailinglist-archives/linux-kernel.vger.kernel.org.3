Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72BB58AD1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiHEPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiHEPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:38:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9324F2E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:38:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a18-20020a05600c349200b003a30de68697so4159915wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lgimsPqam7+Sa77+tu4iuFhMijtMea69pSD3eiGHXzE=;
        b=O9zYQR032NwJdRPutt8I2o96IHDN7NW8EARKVm/xBo6VvUvxIGe4vbbH0OZMGv7klp
         pzI38Q/iQdEN0D+Tu4kSoYBUHk1gzk8ZKCywkoVxJ8+uDWNhvfWOfWbOS6Z+BFCf28B7
         1DVMHIG+i8sh5/LT3hiSmW//KQF11NXGkqApWRheUOWf7vWJ7BzYoaY1VHmgC81SYgZL
         eSTagqc39Yz2nX6Dgi1kgdiqG3WCw6t9o0FNeJQxjQADlPbrRCw3r85TIAAfHUDLpfZZ
         6X9+9NYquDQvnB4truodAn2anclJtrLZmGGj1eOJVaUQfjsAoWvwTcPD6XO/NejaRpZU
         AqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lgimsPqam7+Sa77+tu4iuFhMijtMea69pSD3eiGHXzE=;
        b=6X8c8QOsCIrc1FkwLtyaEA07C9N/Pk9gRe9ZZt7hQV6+aKTYJWMR5wdnOH5BLK4P1f
         HQ1lXS652sURYdehH09aNGNlfQTUAKBeJPbJl3Qjagigu4zORcLUaOGInxBsXxcoOBzD
         t3F7DSetwMiPKeKp7CC4RqA6CDlCnQB5lwcRKYkITTeNsASTxJx9l1Q7xUWhyeXr6EJX
         B3QCmMvE1dbsTlo1QIHZuErGwa8dAbH8J3Bb/i1U+ne3NcmtF7DFsvstwDRAcOZZA+WS
         rG+OX7tLkVURd5DGw0xhDe2zvVXdZGTC/KnvJw2BHyO0jFnzHbkW3xozGelom3tHOlxC
         s04A==
X-Gm-Message-State: ACgBeo1gYLe/cIdphGYX5UmoUw9MdHm+rptJ5AjBOpMxbO4MszuPea0Q
        3Bh+sO8t/LlKPJ8CbM9B/Y2wBA==
X-Google-Smtp-Source: AA6agR5Nv53KDQOvqh+4wURfJkqk6vMRuAiEMyXb8st+9yL05Ub0E4OSAi+g/6Ygzi6i40RoQC5w2A==
X-Received: by 2002:a05:600c:4153:b0:3a5:1ea9:2824 with SMTP id h19-20020a05600c415300b003a51ea92824mr2329740wmm.80.1659713931082;
        Fri, 05 Aug 2022 08:38:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002217540b222sm1721025wrq.58.2022.08.05.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:38:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 5/5] thermal/core: Move the mutex inside the thermal_zone_device_update() function
Date:   Fri,  5 Aug 2022 17:38:34 +0200
Message-Id: <20220805153834.2510142-5-daniel.lezcano@linaro.org>
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

All the different calls inside the thermal_zone_device_update()
function take the mutex.

The previous changes move the mutex out of the different functions,
like the throttling ops. Now that the mutexes are all at the same
level in the call stack for the thermal_zone_device_update() function,
they can be moved inside this one.

That has the benefit of:

1. Simplify the code by not having a plethora of places where the lock is taken

2. Probably closes more race windows because releasing the lock from
one line to another can give the opportunity to the thermal zone to change
its state in the meantime. For example, the thermal zone can be
enabled right after checking it is disabled.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    | 32 +++++--------
 drivers/thermal/thermal_core.h    |  2 +
 drivers/thermal/thermal_helpers.c | 75 ++++++++++++++++++-------------
 drivers/thermal/thermal_sysfs.c   |  6 ++-
 4 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9d554f97e081..60110ac53e23 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -297,24 +297,18 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	mutex_lock(&tz->lock);
-
 	if (tz->mode != THERMAL_DEVICE_ENABLED)
 		thermal_zone_device_set_polling(tz, 0);
 	else if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-
-	mutex_unlock(&tz->lock);
 }
 
 static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
-	mutex_lock(&tz->lock);
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
-	mutex_unlock(&tz->lock);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
@@ -382,7 +376,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
 
-	ret = thermal_zone_get_temp(tz, &temp);
+	ret = __thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		if (ret != -EAGAIN)
 			dev_warn(&tz->device,
@@ -391,10 +385,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 		return;
 	}
 
-	mutex_lock(&tz->lock);
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
-	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
 
@@ -457,15 +449,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 {
-	enum thermal_device_mode mode;
-
-	mutex_lock(&tz->lock);
-
-	mode = tz->mode;
+	lockdep_assert_held(&tz->lock);
 
-	mutex_unlock(&tz->lock);
-
-	return mode == THERMAL_DEVICE_ENABLED;
+	return tz->mode == THERMAL_DEVICE_ENABLED;
 }
 
 void thermal_zone_device_update(struct thermal_zone_device *tz,
@@ -473,9 +459,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	int count;
 
-	if (!thermal_zone_device_is_enabled(tz))
-		return;
-
 	if (atomic_read(&in_suspend))
 		return;
 
@@ -483,9 +466,14 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 		      "'get_temp' ops set\n", __func__))
 		return;
 
+	mutex_lock(&tz->lock);
+
+	if (!thermal_zone_device_is_enabled(tz))
+		goto out;
+
 	update_temperature(tz);
 
-	thermal_zone_set_trips(tz);
+	__thermal_zone_set_trips(tz);
 
 	tz->notify_event = event;
 
@@ -493,6 +481,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 		handle_thermal_trip(tz, count);
 
 	monitor_thermal_zone(tz);
+out:
+	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2241d2dce017..1571917bd3c8 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,6 +112,8 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void __thermal_zone_set_trips(struct thermal_zone_device *tz);
+int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 690890f054a3..702c70bdca48 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -64,27 +64,17 @@ get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
-/**
- * thermal_zone_get_temp() - returns the temperature of a thermal zone
- * @tz: a valid pointer to a struct thermal_zone_device
- * @temp: a valid pointer to where to store the resulting temperature.
- *
- * When a valid thermal zone reference is passed, it will fetch its
- * temperature and fill @temp.
- *
- * Return: On success returns 0, an error code otherwise
- */
-int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
 	int count;
 	int crit_temp = INT_MAX;
 	enum thermal_trip_type type;
 
+	lockdep_assert_held(&tz->lock);
+	
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		goto exit;
-
-	mutex_lock(&tz->lock);
+		return -EINVAL;
 
 	ret = tz->ops->get_temp(tz, temp);
 
@@ -107,35 +97,42 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			*temp = tz->emul_temperature;
 	}
 
-	mutex_unlock(&tz->lock);
-exit:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
 /**
- * thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
+ * thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
  *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
  *
- * It does not return a value
+ * Return: On success returns 0, an error code otherwise
  */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int ret;
+
+	mutex_lock(&tz->lock);
+	ret = __thermal_zone_get_temp(tz, temp);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
+
+void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	int low = -INT_MAX;
 	int high = INT_MAX;
 	int trip_temp, hysteresis;
 	int i, ret;
 
-	mutex_lock(&tz->lock);
-
+	lockdep_assert_held(&tz->lock);
+	
 	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
-		goto exit;
+		return;
 
 	for (i = 0; i < tz->num_trips; i++) {
 		int trip_low;
@@ -154,7 +151,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
-		goto exit;
+		return;
 
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
@@ -169,8 +166,24 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	ret = tz->ops->set_trips(tz, low, high);
 	if (ret)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
+}
 
-exit:
+/**
+ * thermal_zone_set_trips - Computes the next trip points for the driver
+ * @tz: a pointer to a thermal zone device structure
+ *
+ * The function computes the next temperature boundaries by browsing
+ * the trip points. The result is the closer low and high trip points
+ * to the current temperature. These values are passed to the backend
+ * driver to let it set its own notification mechanism (usually an
+ * interrupt).
+ *
+ * It does not return a value
+ */
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
+	__thermal_zone_set_trips(tz);
 	mutex_unlock(&tz->lock);
 }
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3c513561d346..f094f7cbc455 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -49,7 +49,11 @@ static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int enabled = thermal_zone_device_is_enabled(tz);
+	int enabled;
+
+	mutex_lock(&tz->lock);
+	enabled = thermal_zone_device_is_enabled(tz);
+	mutex_unlock(&tz->lock);
 
 	return sprintf(buf, "%s\n", enabled ? "enabled" : "disabled");
 }
-- 
2.25.1

