Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C45785CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiGROu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiGROut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:50:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7F17AB4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:50:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so8020475wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k68R2/59EH+UP+DjwagqrQkr2q9+r1a26rRZqF6jhBY=;
        b=KX5y9B+zeDfHVsGiv04nVy4WsFEI1RzuFbOc7m7h2BT+9LDlbKuQcNE6qHoSx3LLYZ
         zlzXeZ712NSi0s1Fu3HhDcLloQ7Dxe8r57GaiBtA+iWOCl0lNDK55u/ZYoxUmM8KmLuv
         aRQaxk9wHUVLKtWQC/L7PmCYVgLxUWVUESW8g1JhBJfxOEzsstc46YcmVKt6hIxHDHf0
         jfdTKT4G48PfGTZas1jRzCR1C8Wcc3dQXdsNh1cmCDQK0d7h1srO6XB++swvjLQbT9K3
         jpe5253Z4LqgU+lEoPOIkevmAScwqMvH4eBA5/pDLmfR0BzJPSc5/okuC7oQ0JmtQPRj
         LCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k68R2/59EH+UP+DjwagqrQkr2q9+r1a26rRZqF6jhBY=;
        b=U6CL9KHmLEbWndBQasZKZwVEUIEz6d8azLfJU313YsYLbfrPEm0gKkmm3JMUiwsBdx
         vOXivFyfM0Ff4A3Y4cHj9YTM56OkDxZg+ZZlVX1+o/q3sU0j5abtAtkyxCAOXZ4qh3S3
         IGkPFxy9qDfXcdBJ2HAydqDWiZ3M2VjD+Yrjr9lqcHEQ3+g452cqeQ6ImTkE3ia+B+oH
         cUL9sIvqmRa7OEQ1qBv5u+MKHXD50sOn9FMnoc+BS7LKAHC2GAVWu6UO65Ky2iJ6LcQM
         dh3FP5UZ4EcSvgrVANDTVlVszqKIptgyj37G1kndL0T3BLLKxHQK8jlMX1bl1WzwqkcJ
         hgng==
X-Gm-Message-State: AJIora/5aBzlFqFYKwJ9DkVm+jHtnNa2IfILdcxNDiQPlnHsqi9GfUpV
        5qcYrv3Io73hqz1ywxd12eZjh7IjzSSm/w==
X-Google-Smtp-Source: AGRyM1utRo3CPBs4csmD1ivXKxT4n5LfelOi9cdYqfZAL3N74948kf0vEbZO1m006IK4JsXb3BWZ/w==
X-Received: by 2002:a05:600c:683:b0:3a2:fe34:3e1a with SMTP id a3-20020a05600c068300b003a2fe343e1amr25603120wmn.192.1658155846617;
        Mon, 18 Jul 2022 07:50:46 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a310631750sm11643715wmq.35.2022.07.18.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:50:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for the trip points
Date:   Mon, 18 Jul 2022 16:50:37 +0200
Message-Id: <20220718145038.1114379-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By convention the trips points are declared in the ascending
temperature order. However, no specification for the device tree, ACPI
or documentation tells the trip points must be ordered this way.

In the other hand, we need those to be ordered to browse them at the
thermal events. But if we assume they are ordered and change the code
based on this assumption, any platform with shuffled trip points
description will be broken (if they exist).

Instead of taking the risk of breaking the existing platforms, use an
array of temperature ordered trip identifiers and make it available
for the code needing to browse the trip points in an ordered way.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

V4:
  - Fix conflicts due to tz->trips renamed to tz->num_trips
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 63 +++++++++++++++++++++++++++-------
 include/linux/thermal.h        |  2 ++
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fc6ccc5edbfb..f274dc7d9c48 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -355,7 +355,8 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 }
 
 static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
-					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
+					int trip_temp, int trip_hyst,
+					enum thermal_trip_type trip_type)
 {
 	if (tz->last_temperature == THERMAL_TEMP_INVALID)
 		return;
@@ -1171,6 +1172,47 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 	if (delay_ms > 1000)
 		*delay_jiffies = round_jiffies(*delay_jiffies);
 }
+	
+static void sort_trips_indexes(struct thermal_zone_device *tz)
+{
+	int i, j;
+
+	for (i = 0; i < tz->num_trips; i++)
+		tz->trips_indexes[i] = i;
+ 
+	for (i = 0; i < tz->num_trips; i++) {
+
+		for (j = i + 1; j < tz->num_trips; j++) {
+			int t1, t2;
+
+			tz->ops->get_trip_temp(tz, tz->trips_indexes[i], &t1);
+			tz->ops->get_trip_temp(tz, tz->trips_indexes[j], &t2);
+
+			if (t1 > t2)
+				swap(tz->trips_indexes[i], tz->trips_indexes[j]);
+		}
+ 	}
+}
+
+static int thermal_zone_device_trip_init(struct thermal_zone_device *tz)
+{
+	enum thermal_trip_type trip_type;
+	int trip_temp, i;
+	
+	tz->trips_indexes = kzalloc(tz->num_trips * sizeof(int), GFP_KERNEL);
+	if (!tz->trips_indexes)
+		return -ENOMEM;
+
+	for (i = 0; i < tz->num_trips; i++) {
+		if (tz->ops->get_trip_type(tz, i, &trip_type) ||
+		    tz->ops->get_trip_temp(tz, i, &trip_temp) || !trip_temp)
+			set_bit(i, &tz->trips_disabled);
+	}
+
+	sort_trips_indexes(tz);
+
+	return 0;
+}
 
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
@@ -1204,11 +1246,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 					int polling_delay)
 {
 	struct thermal_zone_device *tz;
-	enum thermal_trip_type trip_type;
-	int trip_temp;
 	int id;
 	int result;
-	int count;
 	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
@@ -1281,12 +1320,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (result)
 		goto release_device;
 
-	for (count = 0; count < num_trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
-		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
-		    !trip_temp)
-			set_bit(count, &tz->trips_disabled);
-	}
+	result = thermal_zone_device_trip_init(tz);
+	if (result)
+		goto unregister;
 
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
@@ -1299,7 +1335,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	result = thermal_set_governor(tz, governor);
 	if (result) {
 		mutex_unlock(&thermal_governor_lock);
-		goto unregister;
+		goto kfree_indexes;
 	}
 
 	mutex_unlock(&thermal_governor_lock);
@@ -1307,7 +1343,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
 		if (result)
-			goto unregister;
+			goto kfree_indexes;
 	}
 
 	mutex_lock(&thermal_list_lock);
@@ -1328,6 +1364,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	return tz;
 
+kfree_indexes:
+	kfree(tz->trips_indexes);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1406,6 +1444,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
+	kfree(tz->trips_indexes);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1386c713885d..4e576184df49 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,6 +125,7 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
+ * @trips_indexes:	an array of sorted trip points indexes
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
@@ -166,6 +167,7 @@ struct thermal_zone_device {
 	void *devdata;
 	struct thermal_trip *trips;
 	int num_trips;
+	int *trips_indexes;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
-- 
2.25.1

