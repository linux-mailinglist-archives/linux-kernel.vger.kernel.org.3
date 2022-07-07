Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE00C56ADDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiGGVpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiGGVp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:45:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1004D1FCE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:45:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n10so2784270wrc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgPd6GhWpNC2cJZPhZQU4S/SGf/TiSE8ghvP1JzSEEE=;
        b=rUk2SFd6lgY+oU7z75O1tJexnI7cA7wY1b+2/TI/oXFupPTOjP8K9ik04VMR3s1jKj
         kNxHmu39aYokuBGF2gqJ7WfsBRuezAYVAYuQNAy2+FBCug/TRSwdeRLoxnnKYQC34omK
         s2uBdfp/MhbVzqt/H9l4L8SRe3gIauZ+nh79wfWw6ZvnWxzYBLxvPevhjlmDZuzl3lsN
         nBTrd8e1zdmTDbTKondAnQbnLqgFwR7T6oxZqqZYZWE526Urd0/Stf8SldE88CRiR78V
         iPRgB5cL62wxQh4tQHa9bhmXCOEZA/nWIcO65JM9Od1kKhzrnVStSZSK9cR2gXpDpMIh
         XeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgPd6GhWpNC2cJZPhZQU4S/SGf/TiSE8ghvP1JzSEEE=;
        b=zKv2NbgekjX+Vny5dzoMFtOlO2ZvPAnXh4fhjkKulNk0T7z5bL4XJmWkpmT6VGiaER
         gWpiikoOgFxOp6MZOeUgT4SRua1vI4ai5d5LQerqsPFq8j0of6LmzP7OlxkRDerCnHLU
         XddvQbtL2bi5G/bnJSBUb6WYsBqpipm0j4ix5cmLsYr0/MdKk/VkkDEMTK8etTx5DwEc
         68MTYW6nXbl33ptBVZ/yNPQ80chBElJXXkzvdemrBCNC8LnOxKVKOlUWkprvAMmqzlM8
         BTYarUJNgp/fNt+q15D7jqbwG0ShyyM5cvJ68azm6WdAaQYjcXShHQQrGczpHfxt3eK7
         s7kw==
X-Gm-Message-State: AJIora/Ys/Tcp/WNApzgPclUKESjO7sw3WS6/6VCOHd6DiG8/yu+WFHa
        0Phq1lBjJmuOAw2TRaLhYcXuxw==
X-Google-Smtp-Source: AGRyM1uTqzpkOCHuNbnuQeY/tdZWD6SZrX4x0gfwprILsh3oft9iYU5lLF/2S98mPgXAKuYMc02oPQ==
X-Received: by 2002:adf:dc09:0:b0:218:5f6a:f5db with SMTP id t9-20020adfdc09000000b002185f6af5dbmr14400wri.480.1657230323385;
        Thu, 07 Jul 2022 14:45:23 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b0021d87798237sm2417439wrt.20.2022.07.07.14.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:45:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] thermal/core: Fix thermal trip cross point
Date:   Thu,  7 Jul 2022 23:45:13 +0200
Message-Id: <20220707214513.1133506-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
References: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
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
information about the previous trip.

As a sidenote, the thermal_zone_device structure has already the
prev_trip_low and prev_trip_high information which are used by the
thermal_zone_set_trips() function. This one can be changed to be
triggered by the trip temperature crossing function, which makes more
sense, and the two fields will disappear.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 32 ++++++++++++++++++++++----------
 include/linux/thermal.h        |  2 ++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f66036b3daae..92bc9ddb6904 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -357,19 +357,30 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
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
+	 */
+	if (tz->last_temperature < trip_temp && tz->temperature >= trip_temp &&
+	    trip != tz->prev_trip) {
+		thermal_notify_tz_trip_up(tz->id, trip, tz->temperature);
+		tz->prev_trip = trip;
+		
+	} else if (tz->last_temperature >= trip_low_temp && tz->temperature < trip_low_temp &&
+	    trip == tz->prev_trip) {
+		thermal_notify_tz_trip_down(tz->id, trip, tz->temperature);
+		tz->prev_trip = trip - 1;
 	}
 }
 
@@ -427,6 +438,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
 	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->prev_trip = -1;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
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

