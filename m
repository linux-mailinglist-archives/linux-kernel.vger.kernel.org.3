Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64756CBBE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGIWdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGIWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:33:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154842AE0A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so2592086wrd.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SD0RKMK5Q3Q8sjw2sPd6eKcyMSLlIgckhKohOzGFpgA=;
        b=ZIEO3IlRH+KuDYcW/Ly7aWJaqzvxd7fr87WmVORkAzuJrzb8VlXQFc9y8lxe0Owago
         l6h9PXfHbnkJeQ5GJY/VOYE0Z+Zaf/55a/0LpHoiNruO8Ozj9pcvAeE7FhEVLMUxdnY4
         PST+FyaLCcSdf4wt2lCAQPbdSW1Af+j2HKhx6unTWSj8KD5jzSmryYTI+3iNG4L5yHmo
         E2zwey00IJt1LMCOwMMUJUxNTuBKamMZo1Dj73scyIVGt7S2f7VYoC8vYnLpfCf3mkNo
         HmC6fgGex/sK9LbfplxQAOxwSCKDrb4CqkzD3I9Fo6QnZvQFLwp76WSC8suZFFTB98AC
         QVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SD0RKMK5Q3Q8sjw2sPd6eKcyMSLlIgckhKohOzGFpgA=;
        b=E3eW2YCDWSbVQf3FdUYqb9oBxnYWyc2IIE2Ey5SkdmFOSGncsGjy0ls6A/YX5qsc7h
         rvA3/29m/1O66VJSAo8KKhWv3XGdaXMgo7ShTqZ0MD7ag51lf8yeUnkayg96emi3Tjag
         V2MPd+hgnd9ZMKGrG8CSwBEBn33mf0truqhfZAZtcW+tuxS1bYL48WnTtSViW1dZjRxl
         pjRnkmvjaihax9taNHWBvFwlQ3QbC1uuzCKgsm/4pQd+PW4Kug4MBzrPfq45s0L3wZCS
         cCViiykzJQn3C2iXNHSf9N9cYn/ftbHo/ip0lSiWfNDhdNTkUB7Ysnzk3a/h4rh1GiRL
         YZXg==
X-Gm-Message-State: AJIora85j0dFOallWMXg8hJsd3+JIlsy1Kyq30sA4TvWNe0PYJiPaSKP
        xKctAmoTPQZ4hFgZDcvS5NEHQg==
X-Google-Smtp-Source: AGRyM1vJiqJOq6HGvrFV4Tks9HUdABrK9yN85JtvQWBxd2IQheikTmMizAs21z53u8Eac7clIJj/Sw==
X-Received: by 2002:a05:6000:1549:b0:21b:c7fb:9dd0 with SMTP id 9-20020a056000154900b0021bc7fb9dd0mr9117346wry.446.1657405979536;
        Sat, 09 Jul 2022 15:32:59 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 12/12] thermal/of: Initialize trip points separately
Date:   Sun, 10 Jul 2022 00:32:29 +0200
Message-Id: <20220709223229.1619339-13-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/thermal_of.c | 101 ++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 601552c55d0b..40fd7260b2ad 100644
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
@@ -977,7 +1007,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	kfree(tz->tbps);
 free_trips:
 	kfree(tz->trips);
-	of_node_put(trips);
 	of_node_put(gchild);
 free_tz:
 	kfree(tz);
-- 
2.25.1

