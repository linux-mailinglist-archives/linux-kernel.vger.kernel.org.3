Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5A58E262
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiHIWFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHIWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:04:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF73F5A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:04:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so15786174wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=72yNggrXYncxa0ZMrFg4FnZQ/1fgWA3cdk/X57DF3Mg=;
        b=ne+KAmbCrpntUQWrPy3ItnvT2wGrtXto6IlRX9aP7igzhWJkf/cjjuR1Ye1TfX/djE
         P2FoUFozTSgbKnT14sJpT+gu43tmOFH9X4mtjuB8FlPSvdjzmOFxw5GaoGe2Aug4fJez
         HFxPou263xYQa83KH7EobLewrVO7FgNcRtUaYnq5Avwlzpw7QSDA3mUXgV/OOc/hPvn8
         pF6w8yQ9oJuN+YaATsPvKw+490q4M59+rzOUvD4Xbso5jV4iDTir6p2eSZKqWUSfMEaP
         mlpPC7ZObBTSXAODFkUUCDERyzwDod7aAS1qetdANknuSajaa/gY/jjRwnm04rY4+FJP
         PEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=72yNggrXYncxa0ZMrFg4FnZQ/1fgWA3cdk/X57DF3Mg=;
        b=N/bmYMuBkI0rE9/V9CgDBUHJoJsOHDwDp0+Bs1ckxsR4X4bS7P1lgFjKH0M5kdobMu
         v2d3IsY8CiAFtGFK9lFyjPT6nTW9ojPB9c77J5g8Yx1IhQQhbsDxSLZHnmT1kdKiDwQz
         WbDH6KMrB+9s0w/dymS59FjRV8LE1c5pnksH+xq8Y9wIXI2TrbQuXjsgqSyfkFjtKtyF
         yt6JqDcRWd1tGc4Wy7mNwox8/SxEZ74WAxq0a7EyZUkFW42SLIzupIKj3prEUwHkwOkB
         pyoTug2uJHnFYYHjSLkVCsvU44SPjOZPHC1NwtZTeHRwFgiTCRSA0cbpcDH02L55xyiI
         217Q==
X-Gm-Message-State: ACgBeo0gfeArTKpkFSxKPNU+At0el5S/OEvwXh3xbUOzbwksmZHfUY5y
        4a9vpzcNvxxsBGJmZVbw7fiRXg==
X-Google-Smtp-Source: AA6agR5BrLFUKPRiElxUcvEqU8+T6nZ6yLx5S7ZcG6zMUn6QiunFnprGxL0HgyAVNqDdLNk+2PlIKg==
X-Received: by 2002:adf:e0cb:0:b0:21e:9ed9:d862 with SMTP id m11-20020adfe0cb000000b0021e9ed9d862mr15484006wri.518.1660082694333;
        Tue, 09 Aug 2022 15:04:54 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:04:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 01/26] thermal/core: encapsulate ops->get_trip_* ops into a function
Date:   Wed, 10 Aug 2022 00:04:11 +0200
Message-Id: <20220809220436.711020-2-daniel.lezcano@linaro.org>
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

The thermal_zone_device_ops structure defines a set of ops family,
get_trip_temp(), get_trip_hyst(), get_trip_type(). Each of them is
returning a property of a trip point.

The result is the code is calling the ops everywhere to get a trip
point which is supposed to be defined in the backend driver. It is a
non-sense as a thermal trip can be generic and used by the backend
driver to declare its trip points.

Part of the thermal framework has been changed and all the OF thermal
drivers are using the same definition for the trip point and use a
thermal zone registration variant to pass those trip points which are
part of the thermal zone device structure.

Consequently, we can use a generic function to get the trip points
when they are stored in the thermal zone device structure.

This approach can be generalized to all the drivers and we can get rid
of the ops->get_trip_*. That will result to a much more simpler code
and make possible to rework how the thermal trip are handled in the
thermal core framework as discussed previously.

This change adds a function thermal_zone_get_trip() where we get the
thermal trip point structure which contains all the properties (type,
temp, hyst) instead of doing multiple calls to ops->get_trip_*.

That opens the door for trip point extension with more attributes. For
instance, replacing the trip points disabled bitmask with a 'disabled'
field in the structure.

Here we replace all the calls to ops->get_trip_* in the thermal core
code with a call to the thermal_zone_get_trip() function.

While at it, add the thermal_zone_get_num_trips() to encapsulate the
code more and reduce the grip with the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    | 69 ++++++++++++++++++++-----------
 drivers/thermal/thermal_core.h    |  8 ++++
 drivers/thermal/thermal_helpers.c | 28 ++++++-------
 drivers/thermal/thermal_netlink.c | 21 ++++------
 drivers/thermal/thermal_sysfs.c   | 66 ++++++++++++-----------------
 5 files changed, 103 insertions(+), 89 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 10c979dce512..5891b86758c1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -354,35 +354,31 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->critical(tz);
 }
 
-static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
+static void handle_thermal_trip(struct thermal_zone_device *tz, int trip_id)
 {
-	enum thermal_trip_type type;
-	int trip_temp, hyst = 0;
+	struct thermal_trip trip;
 
 	/* Ignore disabled trip points */
-	if (test_bit(trip, &tz->trips_disabled))
+	if (test_bit(trip_id, &tz->trips_disabled))
 		return;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-	tz->ops->get_trip_type(tz, trip, &type);
-	if (tz->ops->get_trip_hyst)
-		tz->ops->get_trip_hyst(tz, trip, &hyst);
+	thermal_zone_get_trip(tz, trip_id, &trip);
 
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip,
+		if (tz->last_temperature < trip.temperature &&
+		    tz->temperature >= trip.temperature)
+			thermal_notify_tz_trip_up(tz->id, trip_id,
 						  tz->temperature);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip,
+		if (tz->last_temperature >= trip.temperature &&
+		    tz->temperature < (trip.temperature - trip.hysteresis))
+			thermal_notify_tz_trip_down(tz->id, trip_id,
 						    tz->temperature);
 	}
 
-	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip, trip_temp, type);
+	if (trip.type == THERMAL_TRIP_CRITICAL || trip.type == THERMAL_TRIP_HOT)
+		handle_critical_trips(tz, trip_id, trip.temperature, trip.type);
 	else
-		handle_non_critical_trips(tz, trip);
+		handle_non_critical_trips(tz, trip_id);
 	/*
 	 * Alright, we handled this trip successfully.
 	 * So, start monitoring again.
@@ -1162,6 +1158,34 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 		*delay_jiffies = round_jiffies(*delay_jiffies);
 }
 
+int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
+			  struct thermal_trip *trip)
+{
+	int ret;
+
+	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
+		return -EINVAL;
+
+	if (tz->trips) {
+		*trip = tz->trips[trip_id];
+		return 0;
+	}
+
+	if (tz->ops->get_trip_hyst) {
+		ret = tz->ops->get_trip_hyst(tz, trip_id, &trip->hysteresis);
+		if (ret)
+			return ret;
+	} else trip->hysteresis = 0;
+
+	ret = tz->ops->get_trip_temp(tz, trip_id, &trip->temperature);
+	if (ret)
+		return ret;
+
+	return tz->ops->get_trip_type(tz, trip_id, &trip->type);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
+
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1194,8 +1218,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 					int polling_delay)
 {
 	struct thermal_zone_device *tz;
-	enum thermal_trip_type trip_type;
-	int trip_temp;
 	int id;
 	int result;
 	int count;
@@ -1222,7 +1244,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
+	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
 		return ERR_PTR(-EINVAL);
 
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
@@ -1272,9 +1294,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		goto release_device;
 
 	for (count = 0; count < num_trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
-		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
-		    !trip_temp)
+		struct thermal_trip trip;
+
+		result = thermal_zone_get_trip(tz, count, &trip);
+		if (result)
 			set_bit(count, &tz->trips_disabled);
 	}
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2241d2dce017..194e98a5b102 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -110,6 +110,14 @@ void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 
+int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
+			  struct thermal_trip *trip);
+
+static inline int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
+{
+	return tz->num_trips;
+}
+
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 690890f054a3..626a70d70567 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -79,7 +79,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	int ret = -EINVAL;
 	int count;
 	int crit_temp = INT_MAX;
-	enum thermal_trip_type type;
+	struct thermal_trip trip;
 
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
@@ -90,10 +90,9 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
 		for (count = 0; count < tz->num_trips; count++) {
-			ret = tz->ops->get_trip_type(tz, count, &type);
-			if (!ret && type == THERMAL_TRIP_CRITICAL) {
-				ret = tz->ops->get_trip_temp(tz, count,
-						&crit_temp);
+			ret = thermal_zone_get_trip(tz, count, &trip);
+			if (!ret && trip.type == THERMAL_TRIP_CRITICAL) {
+				crit_temp = trip.temperature;
 				break;
 			}
 		}
@@ -127,29 +126,30 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
  */
 void thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
-	int low = -INT_MAX;
-	int high = INT_MAX;
-	int trip_temp, hysteresis;
+	struct thermal_trip trip;
+	int low = -INT_MAX, high = INT_MAX;
 	int i, ret;
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
+	if (!tz->ops->set_trips)
 		goto exit;
 
 	for (i = 0; i < tz->num_trips; i++) {
 		int trip_low;
 
-		tz->ops->get_trip_temp(tz, i, &trip_temp);
-		tz->ops->get_trip_hyst(tz, i, &hysteresis);
+		ret = thermal_zone_get_trip(tz, i , &trip);
+		if (ret)
+			goto exit;
 
-		trip_low = trip_temp - hysteresis;
+		trip_low = trip.temperature - trip.hysteresis;
 
 		if (trip_low < tz->temperature && trip_low > low)
 			low = trip_low;
 
-		if (trip_temp > tz->temperature && trip_temp < high)
-			high = trip_temp;
+		if (trip.temperature > tz->temperature &&
+		    trip.temperature < high)
+			high = trip.temperature;
 	}
 
 	/* No need to change trip points */
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 050d243a5fa1..ce56d441c88c 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -452,7 +452,8 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 	struct sk_buff *msg = p->msg;
 	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
-	int i, id;
+	struct thermal_trip trip;
+	int ret, i, id;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
 		return -EINVAL;
@@ -471,18 +472,14 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 
 	for (i = 0; i < tz->num_trips; i++) {
 
-		enum thermal_trip_type type;
-		int temp, hyst = 0;
-
-		tz->ops->get_trip_type(tz, i, &type);
-		tz->ops->get_trip_temp(tz, i, &temp);
-		if (tz->ops->get_trip_hyst)
-			tz->ops->get_trip_hyst(tz, i, &hyst);
-
+		ret = thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			goto out_cancel_nest;
+		
 		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
-		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
-		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, temp) ||
-		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, hyst))
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip.type) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip.temperature) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip.hysteresis))
 			goto out_cancel_nest;
 	}
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3c513561d346..2b53927f3263 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -79,20 +79,17 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	enum thermal_trip_type type;
-	int trip, result;
+	struct thermal_trip trip;
+	int trip_id, result;
 
-	if (!tz->ops->get_trip_type)
-		return -EPERM;
-
-	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
-	result = tz->ops->get_trip_type(tz, trip, &type);
+	result = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (result)
 		return result;
 
-	switch (type) {
+	switch (trip.type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -111,37 +108,31 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip, ret;
-	int temperature, hyst = 0;
-	enum thermal_trip_type type;
+	struct thermal_trip trip;
+	int trip_id, ret;
 
 	if (!tz->ops->set_trip_temp && !tz->trips)
 		return -EPERM;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &temperature))
+	if (kstrtoint(buf, 10, &trip.temperature))
 		return -EINVAL;
 
-	ret = tz->ops->set_trip_temp(tz, trip, temperature);
+	ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
 	if (ret)
 		return ret;
 
 	if (tz->trips)
-		tz->trips[trip].temperature = temperature;
-
-	if (tz->ops->get_trip_hyst) {
-		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
-		if (ret)
-			return ret;
-	}
+		tz->trips[trip_id].temperature = trip.temperature;
 
-	ret = tz->ops->get_trip_type(tz, trip, &type);
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
+	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
+				      trip.temperature, trip.hysteresis);
 
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
@@ -153,21 +144,17 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip, ret;
-	int temperature;
-
-	if (!tz->ops->get_trip_temp)
-		return -EPERM;
+	struct thermal_trip trip;
+	int trip_id, ret;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
-
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", temperature);
+	return sprintf(buf, "%d\n", trip.temperature);
 }
 
 static ssize_t
@@ -205,18 +192,17 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip, ret;
-	int temperature;
+	struct thermal_trip trip;
+	int trip_id, ret;
 
-	if (!tz->ops->get_trip_hyst)
-		return -EPERM;
-
-	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	return ret ? ret : sprintf(buf, "%d\n", temperature);
+	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
 }
 
 static ssize_t
-- 
2.34.1

