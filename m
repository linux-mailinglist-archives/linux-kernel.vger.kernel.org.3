Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C146C56CF27
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiGJMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiGJMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88681145A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so1612821wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMovIUMU9IB4F56zxQvm9VYr7WFPPP8mufoJe3SI6xw=;
        b=JKIgwceJ17zdG5NJAvOUZ2YHaz79yM3RULs4bXVPMv4BmM6sp9TcFiXJoX4Kryv7Hq
         fYxdeG0SocJKVKSpz3Xj2d4cfuPX2tvdZZx2hG4RyB85hBppeK4p4fBjGz4+6s7+RLe6
         n4Ccv8u2fWT59YLG2cLYNoc57VfxPbyyuD5cfBO6zBQN4tkV7U2kA83dc2OoMSdnbqXA
         tW0cwcw4GNylZOcVucPcU9StTH6TcAKO42tiA/oY7P0l7/K2MKVmB0Qx3ReUvJFvN6tK
         HAEI4f770m4DxUXhEUbRAL27QPXhAEF9RQnHXkkdz3IfIVJil1LW4QOLn+m6nrjb9DtV
         j7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMovIUMU9IB4F56zxQvm9VYr7WFPPP8mufoJe3SI6xw=;
        b=UkjHBxlmoNxR3doLuGP8l4sLtPRk59wdKEYA/vaM6pXI8q3TUrdjaybc+EIQkkhUqa
         kmcwcc4jjcCdseyaQDJ/kzj8xup2Vp9+vWTj7H0uWApVNXBW/QELFy+px0aCqNjCyh+Z
         5oxxqHLe3O91BlR0Aviz7P29qlpGMswbOn9YVlXdEdPD2buzcoALK6ZwSr6c5jka0hlK
         7p7OMr/8y+bC2fmywhMtU77u3uaYmJHRWTJfUJGjxHnF7bO/F38Lbgx8h3lmYJ642Ex1
         z/M78uWxQTAoFX+ibCM8Esb0njM06i9CMDSRTLd5aVBJvtWxKReIzxIBjdfo4r+HD9TD
         /S0w==
X-Gm-Message-State: AJIora8q1+cAMt1XotccA3ZjG689WCQYVS8fYEHgiUMBbPIQUNe63yCK
        Ap/Q21nX+5BkRKgfr7CebYZ/0Q==
X-Google-Smtp-Source: AGRyM1slDJXVc+SVSYNpyfvlyEWaa57gj+z1rQ1DxY7hOVLPpLWmg6eehIMp17JzKfDRogoWraDLWg==
X-Received: by 2002:a7b:c381:0:b0:3a2:aef9:8df4 with SMTP id s1-20020a7bc381000000b003a2aef98df4mr10622445wmj.7.1657456537255;
        Sun, 10 Jul 2022 05:35:37 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 12/12] thermal/of: Initialize trip points separately
Date:   Sun, 10 Jul 2022 14:35:12 +0200
Message-Id: <20220710123512.1714714-14-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self contain the trip initialization from the device tree in a single
function for the sake of making the code flow more clear.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 102 ++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 601552c55d0b..0693edc00f60 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -118,7 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
  */
 int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
-	return tz->ntrips;
+	return tz->num_trips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
 
@@ -134,7 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
  */
 bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 {
-	if (trip >= tz->ntrips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return false;
 
 	return true;
@@ -269,7 +269,7 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
 static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 				    enum thermal_trip_type *type)
 {
-	if (trip >= tz->ntrips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return -EDOM;
 
 	*type = tz->trips[trip].type;
@@ -280,7 +280,7 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int *temp)
 {
-	if (trip >= tz->ntrips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return -EDOM;
 
 	*temp = tz->trips[trip].temperature;
@@ -293,7 +293,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (trip >= tz->ntrips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return -EDOM;
 
 	if (data->ops && data->ops->set_trip_temp) {
@@ -313,7 +313,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int *hyst)
 {
-	if (trip >= tz->ntrips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return -EDOM;
 
 	*hyst = tz->trips[trip].hysteresis;
@@ -324,7 +324,7 @@ static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-	if (trip >= tz->ntrips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return -EDOM;
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
@@ -338,7 +338,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 {
 	int i;
 
-	for (i = 0; i < tz->ntrips; i++)
+	for (i = 0; i < tz->num_trips; i++)
 		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
 			*temp = tz->trips[i].temperature;
 			return 0;
@@ -693,7 +693,8 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
  *
  * Return: 0 on success, proper error code otherwise
  */
-static int thermal_of_populate_bind_params(struct device_node *np,
+static int thermal_of_populate_bind_params(struct device_node *tz_np,
+					   struct device_node *np,
 					   struct __thermal_bind_params *__tbp)
 {
 	struct of_phandle_args cooling_spec;
@@ -715,7 +716,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		return -ENODEV;
 	}
 
-	trip_id = of_find_trip_id(np, trip);
+	trip_id = of_find_trip_id(tz_np, trip);
 	if (trip_id < 0) {
 		ret = trip_id;
 		goto end;
@@ -849,6 +850,53 @@ static int thermal_of_populate_trip(struct device_node *np,
 	return 0;
 }
 
+static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
+{
+	struct thermal_trip *tt;
+	struct device_node *trips, *trip;
+	int ret, count;
+
+	trips = of_get_child_by_name(np, "trips");
+	if (!trips) {
+		pr_err("Failed to find 'trips' node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	count = of_get_child_count(trips);
+	if (!count) {
+		pr_err("No trip point defined\n");
+		ret = -EINVAL;
+		goto out_of_node_put;
+	}
+
+	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
+	if (!tt) {
+		ret = -ENOMEM;
+		goto out_of_node_put;
+	}
+
+	*ntrips = count;
+
+	count = 0;
+	for_each_child_of_node(trips, trip) {
+		ret = thermal_of_populate_trip(trip, &tt[count++]);
+		if (ret)
+			goto out_kfree;
+	}
+
+	of_node_put(trips);
+	
+	return tt;
+	
+out_kfree:
+	kfree(tt);
+	*ntrips = 0;
+out_of_node_put:
+	of_node_put(trips);
+
+	return ERR_PTR(ret);
+}
+
 /**
  * thermal_of_build_thermal_zone - parse and fill one thermal zone data
  * @np: DT node containing a thermal zone node
@@ -867,7 +915,6 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
-	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -909,28 +956,10 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 		tz->offset = 0;
 	}
 
-	/* trips */
-	trips = of_get_child_by_name(np, "trips");
-
-	/* No trips provided */
-	if (!trips)
+	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
+	if (IS_ERR(tz->trips)) {
+		ret = PTR_ERR(tz->trips);
 		goto finish;
-
-	tz->ntrips = of_get_child_count(trips);
-	if (tz->ntrips == 0) /* must have at least one child */
-		goto finish;
-
-	tz->trips = kcalloc(tz->ntrips, sizeof(*tz->trips), GFP_KERNEL);
-	if (!tz->trips) {
-		ret = -ENOMEM;
-		goto free_tz;
-	}
-
-	i = 0;
-	for_each_child_of_node(trips, gchild) {
-		ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
-		if (ret)
-			goto free_trips;
 	}
 
 	/* cooling-maps */
@@ -952,13 +981,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
-		if (ret)
+		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
+		if (ret) {
+			of_node_put(gchild);
 			goto free_tbps;
+		}
 	}
 
 finish:
-	of_node_put(trips);
 	of_node_put(child);
 
 	return tz;
@@ -977,8 +1007,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	kfree(tz->tbps);
 free_trips:
 	kfree(tz->trips);
-	of_node_put(trips);
-	of_node_put(gchild);
 free_tz:
 	kfree(tz);
 	of_node_put(child);
-- 
2.25.1

