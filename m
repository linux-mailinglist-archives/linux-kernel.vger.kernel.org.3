Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39DD56C021
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiGHScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiGHSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:32:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E9722F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:32:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q9so31620135wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ5izpsJYDjolez1JjolokdZgMS5APgPK6AXFM/yUtk=;
        b=ATpB/XjbRHEUp6X0XLL7UmTz6sr8zW8pgXZ2Ds/d820Hf6ksIr3fhWzCV40cke5UZm
         WoLxsWWxUrCclT7H6Zo4cmic1Z0fALbmvflIwiQiao/yMRawfjvMC0gCtUR0cgd+SJCn
         bm/jk3PQBtZnkgzsaTj2qlAO2OeJjxKlhSmRpR1Zl+cYbsDv2lar4G18Wr4jtOdk03HV
         aNyRwyNqykmwoy4/GTvwnB6CjP8iOWqPjmqDkXT6JsfgtwTYeQfVm8S6SR8l0x77wI6I
         T796uEAbtq9NRfMOc4dztQx0VCCGPMxs0gR7nNnckU8HcZCsqHe0rUe9Ex9h+qsWKZpl
         wzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ5izpsJYDjolez1JjolokdZgMS5APgPK6AXFM/yUtk=;
        b=X/8F0KecmuelY9lFK46PhwnPVXTyIdOaD6C6I5O6nnSGPfCipfXoUMItY3tuITX2gG
         836dv/mbMmsBHU6t+wxD2u1ELd32lc5PhT2uD0N3RFpRP/Yhq8kIjexhllviXFIV+KDk
         OU/cm+lAVi/6ypCuKfaXmpE0d5W2ftVXN5mBbgRYRxSl1VLjzDkWUfhvMrl23NK5KGNe
         k2XxP8TLxRGVyHrQA1aaWoJwJRzW4BhLvzEvERoJh7CYsLy2RJ9S74uvz22s2mV2RMlo
         nE3rF/9s36f41FddmGhqFyixV5VkUD71oJ8AW3PYttXXOU0RAGO1hFkKEHTJmSqu7yPQ
         LwNA==
X-Gm-Message-State: AJIora+PBJUN08CkD3b12dqKfiq9o3VTF2YcGvCw1WWS+KXmsRrrNww7
        ONMhsemTvM/IBsgeqc7neBlzIw==
X-Google-Smtp-Source: AGRyM1ueLiPnRiMss6SWC/rk7k95ovhmqrNmZUy38BSo3+d0I+qvAxBSYnynz6s0J7fANQ8c8fMQWA==
X-Received: by 2002:adf:f1d1:0:b0:21d:7f88:d638 with SMTP id z17-20020adff1d1000000b0021d7f88d638mr4719493wro.586.1657305142513;
        Fri, 08 Jul 2022 11:32:22 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0021d887f9468sm4292073wrn.25.2022.07.08.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:32:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 3/3] thermal/core: Fix thermal trip cross point
Date:   Fri,  8 Jul 2022 20:32:09 +0200
Message-Id: <20220708183210.1334839-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
V2:
   - As spotted by Zhang Rui, the trip cross notification does not
  work if the temperature drops and crosses two trip points in the
  same update interval. In order to fix that, we browse the trip point
  in the ascending order when the temperature trend is raising,
  otherwise in the descending order.
---
 drivers/thermal/thermal_core.c | 46 +++++++++++++++++++++++++---------
 include/linux/thermal.h        |  2 ++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f66036b3daae..89926e029378 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -357,19 +357,35 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
 					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
 {
+	int trip_low_temp = trip_temp - trip_hyst;
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
+	    trip != tz->prev_trip) {
+		thermal_notify_tz_trip_up(tz->id, trip, tz->temperature);
+		tz->prev_trip = trip;
+	} else if (tz->last_temperature >= trip_low_temp && tz->temperature < trip_low_temp &&
+		   trip == tz->prev_trip) {
+		thermal_notify_tz_trip_down(tz->id, trip, tz->temperature);
+		tz->prev_trip = trip - 1;
 	}
 }
 
@@ -427,6 +443,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
 	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->prev_trip = -1;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
@@ -511,8 +528,13 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for (count = 0; count < tz->trips; count++)
-		handle_thermal_trip(tz, count);
+	if (tz->last_temperature <= tz->temperature) {
+		for (count = 0; count < tz->trips; count++)
+			handle_thermal_trip(tz, count);
+	} else {
+		for (count = tz->prev_trip; count >= 0; count--)
+			handle_thermal_trip(tz, count);
+	}
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 231bac2768fb..5b3bfb902d10 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -124,6 +124,7 @@ struct thermal_cooling_device {
  * @last_temperature:	previous temperature read
  * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
  * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
+ * @prev_trip:		previous trip point the thermal zone was, -1 if below all of them
  * @prev_low_trip:	the low current temperature if you've crossed a passive
 			trip point.
  * @prev_high_trip:	the above current temperature if you've crossed a
@@ -159,6 +160,7 @@ struct thermal_zone_device {
 	int last_temperature;
 	int emul_temperature;
 	int passive;
+	int prev_trip;
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-- 
2.25.1

