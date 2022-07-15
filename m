Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA85768B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGOVJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiGOVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:09:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEECE71BFE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d16so8321263wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBjVlwEWddWqbpURHhNM+E5xvdeghhlzqBOLCULhmQI=;
        b=e+S3BjS1PpKKswxkGI0iY7c0b0IKGpkD/DW+G3E/R+nDJKFDxGYujI2jryqm4pXs05
         AD6t9NACr3CQZFw9nzkZgk/VNlYe9RYROB9Osq8LVylf1S8ra3H91gsTO6I3f70JKhwD
         3THBQeDdNE+nCVncBkzTPYdr9Kmab1jkIfPCmK5KNcc7de6UpWbayWGKher0vQoMLEa8
         2F1GPS+6za/UiSVPn+c4oe6o6pF98cQUifJqDYwIm2VaVz1X9EiAD6NfgvgSXkN8PVrE
         Qng3FU5exou1FoUeLfIAxp38tY1KnjQdde91hdT20wT+xeg6qMsemRXbos5S2jd2TINu
         2bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBjVlwEWddWqbpURHhNM+E5xvdeghhlzqBOLCULhmQI=;
        b=hMzDlIdK6DnBAQg5a27WU8FCRLT7wGrSaxZTPLqSKocIgI7r1bLIFNLd5fciuG0ce0
         xd0XMu76T4FVe1OQvmxVW4SW8VXn0XliLRbQzapOUPtcXUDYOWbAuVDAOj4+19nYYi61
         QqwxHznAfa75OowR4mOcGorqykpHcly2u+AcrwXFXHUbUQhkDh2n3adZjQRR8YvMisT+
         zIEVZXNENvnpmIwlM4zRMrAifeWN0FvF6Dr7OUI2vvYaxc/lgv7v9Tg2RnteCRLcSN4j
         QsUYJrGgkOHZLsG5ZS/0lNGYVdeJv8osPE+HDHShIn3NHDzyR6uIJ5FesKZtyj1gE6Nt
         4k1w==
X-Gm-Message-State: AJIora/0KjC1cC+dI5P5QQoDIa5ZLgiucg5EY5cA1Ug8EkElmZBdVogC
        3OfZqpQEa663bDsg/GfyuucSbg==
X-Google-Smtp-Source: AGRyM1tDc7pmR2AackU3bPHpp8kYvctzGvgmIQNpLv9oO+3tgwGp0K8GBsfnKkbGElv2cXlWsF7JBA==
X-Received: by 2002:a5d:5a99:0:b0:21d:cb28:7468 with SMTP id bp25-20020a5d5a99000000b0021dcb287468mr6316741wrb.289.1657919360359;
        Fri, 15 Jul 2022 14:09:20 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b0021a56cda047sm4567752wrq.60.2022.07.15.14.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:09:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] thermal/core: Fix thermal trip cross point
Date:   Fri, 15 Jul 2022 23:09:11 +0200
Message-Id: <20220715210911.714479-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715210911.714479-1-daniel.lezcano@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine doing trip point crossing the way up or down is actually
wrong.

A trip point is composed with a trip temperature and a hysteresis.

The trip temperature is used to detect when the trip point is crossed
the way up.

The trip temperature minus the hysteresis is used to detect when the
trip point is crossed the way down.

|-----------low--------high------------|
             |<--------->|
             |    hyst   |
             |           |
             |          -|--> crossed the way up
             |
         <---|-- crossed the way down

For that, there is a two point comparison: the current temperature and
the previous temperature.

The actual code assumes if the current temperature is greater than the
trip temperature and the previous temperature was lesser, then the
trip point is crossed the way up. That is true only if we crossed the
way down the low temperature boundary from the previous temperature or
if the hysteresis is zero. The temperature can decrease between the
low and high, so the trip point is not crossed the way down and then
increase again and cross the high temperature raising a new trip point
crossed detection which is incorrect. The same scenario happens when
crossing the way down.

The trip point crossing the way up and down must act as parenthesis, a
trip point down must close a trip point up. Today we have multiple
trip point up without the corresponding trip point down.

In order to fix that, we store the previous trip point which gives the
information about the previous trip and we change the trip point
browsing order depending on the temperature trend: in the ascending
order when the temperature trend is raising, otherwise in the
descending order.

As a sidenote, the thermal_zone_device structure has already the
prev_trip_low and prev_trip_high information which are used by the
thermal_zone_set_trips() function. This one can be changed to be
triggered by the trip temperature crossing function, which makes more
sense, and the two fields will disappear.

Tested on a rk3399-rock960 with thermal stress and 4 trip points. Also
tested with temperature emulation to create a temperature jump
directly to the second trip point.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
V3:

  - Use the ordered indexes introduced in the previous patch as the
    trip could be not ordered

V2:
  - As spotted by Zhang Rui, the trip cross notification does not
  work if the temperature drops and crosses two trip points in the
  same update interval. In order to fix that, we browse the trip point
  in the ascending order when the temperature trend is raising,
  otherwise in the descending order.
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 54 ++++++++++++++++++++++++----------
 include/linux/thermal.h        |  2 ++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f02f38b66445..a5c5f6f4e42b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -354,30 +354,48 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->critical(tz);
 }
 
-static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
+static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int index,
 					int trip_temp, int trip_hyst,
 					enum thermal_trip_type trip_type)
 {
+	int trip_low_temp = trip_temp - trip_hyst;
+	int trip = tz->trips_indexes[index];
+	
 	if (tz->last_temperature == THERMAL_TEMP_INVALID)
 		return;
 
-	if (tz->last_temperature < trip_temp &&
-	    tz->temperature >= trip_temp) {
-		thermal_notify_tz_trip_up(tz->id, trip,
-					  tz->temperature);
-	}
-
-	if (tz->last_temperature >= trip_temp &&
-	    tz->temperature < (trip_temp - trip_hyst)) {
-		thermal_notify_tz_trip_down(tz->id, trip,
-					    tz->temperature);
+	/*
+	 * Due to the hysteresis, a third information is needed to
+	 * detect when the temperature is wavering between the
+	 * trip_low_temp and the trip_temp. A trip point is crossed
+	 * the way up only if the temperature is above it while the
+	 * previous temperature was below *and* we crossed the
+	 * trip_temp_low before. The previous trip point give us the
+	 * previous trip point transition. The similar problem exists
+	 * when crossing the way down.
+	 *
+	 * Note the mechanism works only if the caller of the function
+	 * invoke the function with the trip point ascending or
+	 * descending regarding the temperature trend. A temperature
+	 * drop trend will browse the trip point in the descending
+	 * order
+	 */
+	if (tz->last_temperature < trip_temp && tz->temperature >= trip_temp &&
+	    index != tz->prev_index) {
+		thermal_notify_tz_trip_up(tz->id, trip, tz->temperature);
+		tz->prev_index = index;
+	} else if (tz->last_temperature >= trip_low_temp && tz->temperature < trip_low_temp &&
+		   index == tz->prev_index) {
+		thermal_notify_tz_trip_down(tz->id, trip, tz->temperature);
+		tz->prev_index--;
 	}
 }
 
-static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
+static void handle_thermal_trip(struct thermal_zone_device *tz, int index)
 {
 	enum thermal_trip_type type;
 	int trip_temp, hyst = 0;
+	int trip = tz->trips_indexes[index];
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
@@ -388,7 +406,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->ops->get_trip_hyst)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
-	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
+	handle_thermal_trip_crossed(tz, index, trip_temp, hyst, type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, trip_temp, type);
@@ -428,6 +446,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
 	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->prev_index = -1;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
@@ -512,8 +531,13 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for (count = 0; count < tz->trips; count++)
-		handle_thermal_trip(tz, count);
+	if (tz->last_temperature <=  tz->temperature) {
+		for (count = 0; count < tz->trips; count++)
+			handle_thermal_trip(tz, count);
+	} else {
+		for (count = tz->trips; count >= 0; count--)
+			handle_thermal_trip(tz, count);
+	}
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4c3b72536772..d512f21561f1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,6 +125,7 @@ struct thermal_cooling_device {
  * @last_temperature:	previous temperature read
  * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
  * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
+ * @prev_index:		previous index pointing to the trip point the thermal zone was
  * @prev_low_trip:	the low current temperature if you've crossed a passive
 			trip point.
  * @prev_high_trip:	the above current temperature if you've crossed a
@@ -161,6 +162,7 @@ struct thermal_zone_device {
 	int last_temperature;
 	int emul_temperature;
 	int passive;
+	int prev_index;
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-- 
2.25.1

