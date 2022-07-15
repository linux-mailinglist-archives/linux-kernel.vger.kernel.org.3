Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61215768B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiGOVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiGOVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:09:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C271BCB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r2so7331633wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b68+VkE2RUgPNZUt8j2qwSumBu0/WI+4XHwjD20XVZo=;
        b=FjGKwMEwxuikEabAjOrG8kyXP5sCFAElt6LXQ/g1c6oZ6zNsjV+6obW4uNc+90rEZf
         L16OdBfikT6D18o3oE855q83+tYoR33TeQ9JRU/W0wbDs1iColkFnINh1dLaxAijLOzC
         oKsJWze8zV/pyOy4IcyJBy2DdrPT37VorByHE8o+UOedT4wPHMoI9R5FYZZGveYYRPLq
         3YQ6sPKUUn3srPli+bQCcHsfeCS2kCJ2R+dAQLeYC8AO2Y2vituKXFURpiyoq+J013IP
         2FGkLkemUoZR+YuGFAJW/EPf5vB6LwKtWkISnIXlkBIu0yvUl4QwGKTFjXRiLWZEIoD8
         kKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b68+VkE2RUgPNZUt8j2qwSumBu0/WI+4XHwjD20XVZo=;
        b=zPdvoTM+HbQuD1KNXN2J6Bi1Ub9/hOHExOExz6dvXwYDaUu1nWK8/aD+O5aJjNDb5T
         5KjY5d9BkzTYc8oHV6Qmi+GekbgYgLhkWNaY6JomsERYa/vbqsVlGJUB9aOSVeUuq56E
         PGn7Kd6mCQnwHANu/KtXNMZmCh+53+U41lOzTaNEzyTrh6xGs9c1eJkeohl9xX2PV25R
         Wtpdz5xkmgx4b9Il0MXB9GDeX0SCwosmUNkRPBkCp/4FE+EQ8YoHToJFYUP4KXQTzehz
         e+9EACsqjZN1nQHjH+5/CbOULGnjeiu+ZGDsp3SlRUA+WMk00Hrt23PsfH6C9d/64MHq
         6/oQ==
X-Gm-Message-State: AJIora9R1Q8xfctcH3iwWyvm9JXUDQr8hDY4XW1ZDGQr7c8lUn54i9zH
        VrUoOd+W6awZW+8SZyzIyfbdrQ==
X-Google-Smtp-Source: AGRyM1tTnLLXg5Xz3OFlTZ3Yn6BtoVIeItxO67MGpHo9HqZW3eEf4b9QWOzvydnBIRb9BkG4r+0L7g==
X-Received: by 2002:a05:6000:1789:b0:21d:7699:3322 with SMTP id e9-20020a056000178900b0021d76993322mr13817279wrg.121.1657919358726;
        Fri, 15 Jul 2022 14:09:18 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b0021a56cda047sm4567752wrq.60.2022.07.15.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:09:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for the trip points
Date:   Fri, 15 Jul 2022 23:09:10 +0200
Message-Id: <20220715210911.714479-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715210911.714479-1-daniel.lezcano@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/thermal_core.c | 62 +++++++++++++++++++++++++++-------
 include/linux/thermal.h        |  2 ++
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f66036b3daae..f02f38b66445 100644
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
@@ -1165,6 +1166,46 @@ static void bind_tz(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_list_lock);
 }
 
+static void sort_trips_indexes(struct thermal_zone_device *tz)
+{
+	int i, j;
+
+	for (i = 0; i < tz->trips; i++)
+		tz->trips_indexes[i] = i;
+ 
+	for (i = 0; i < tz->trips; i++) {
+		for (j = i + 1; j < tz->trips; j++) {
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
+	tz->trips_indexes = kzalloc(tz->trips * sizeof(int), GFP_KERNEL);
+	if (!tz->trips_indexes)
+		return -ENOMEM;
+
+	for (i = 0; i < tz->trips; i++) {
+		if (tz->ops->get_trip_type(tz, i, &trip_type) ||
+		    tz->ops->get_trip_temp(tz, i, &trip_temp) || !trip_temp)
+			set_bit(i, &tz->trips_disabled);
+	}
+
+	sort_trips_indexes(tz);
+
+	return 0;
+}
+
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1196,11 +1237,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
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
@@ -1272,12 +1310,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (result)
 		goto release_device;
 
-	for (count = 0; count < trips; count++) {
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
@@ -1290,7 +1325,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	result = thermal_set_governor(tz, governor);
 	if (result) {
 		mutex_unlock(&thermal_governor_lock);
-		goto unregister;
+		goto kfree_indexes;
 	}
 
 	mutex_unlock(&thermal_governor_lock);
@@ -1298,7 +1333,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
 		if (result)
-			goto unregister;
+			goto kfree_indexes;
 	}
 
 	mutex_lock(&thermal_list_lock);
@@ -1319,6 +1354,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	return tz;
 
+kfree_indexes:
+	kfree(tz->trips_indexes);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1387,6 +1424,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
+	kfree(tz->trips_indexes);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 231bac2768fb..4c3b72536772 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -112,6 +112,7 @@ struct thermal_cooling_device {
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
  * @trips:	number of trip points the thermal zone supports
+ * @trips_indexes:	an array of sorted trip points indexes
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
@@ -152,6 +153,7 @@ struct thermal_zone_device {
 	enum thermal_device_mode mode;
 	void *devdata;
 	int trips;
+	int *trips_indexes;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
-- 
2.25.1

