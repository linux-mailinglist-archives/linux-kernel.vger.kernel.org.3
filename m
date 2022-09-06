Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48D5AF1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiIFRB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiIFRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:00:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F472E6A8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay12so7204077wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XsxTgl9OJhYT/B2dXFDz/rl/9WpF5J4y9HKMzylFxc4=;
        b=PAWWdlymzjqyLPcoNRb1L6qlikcPu6u+TyZaT37Vl9cBK/SHvf1i2tmvu02d4qKZQ4
         DtMJ+EFOnxwRZeDWVzhNaXVacviBa7Dh+aUJ/PHrpFTFhr09NU6gT7pMUVWYDv4QqiPO
         V8SZe2MCkWIlf5UeVuB0MascbQvUmQUGNodMsWmHAa2da3tKiip/9bfm2w2jDOqRbia7
         vlsv2dOEMlV5ZShLdnDGKAJ7YTaFUBEVuJ37ZHxf5/dI/CUSSNuIK+Bi7abOpR6dokYR
         bqDazXzTJmx3z6oPNAPK/K/qDuEpXb3cSFbTglT7GYtHyrZxwehWrSw8QxpyDT871lvZ
         mqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XsxTgl9OJhYT/B2dXFDz/rl/9WpF5J4y9HKMzylFxc4=;
        b=lMaWkmWneQzeLgMPMdTBYsMtJ2oVUGkgf7ViW5wp9f5zKyuFxRxX+KBLpOIwB5iyKk
         yPhChZ/3Z6wGmjCfEqlvNxhzawNO7dkP5Q+/bETwifp+zvgyelEbC2aM+1jkcYeqtcN7
         jJJPPFo77YE4oy58jeA4GNfyetYAR37Bg386tcWGI6YVTA6F8YCUmHqlpQCRtnxv0C/0
         GYOPIvDC783tLW+61RwXPRueXFyEO93oYAXrs9U4oIw3DNAm5hHvInRlsyAVPfxexFvi
         YsEcqyU0UPn1B/yUyXJDONHgnAo+zp+u+4+F3qxuioJd1A41OtCKtB2QtlHG96MXRtUw
         fj/w==
X-Gm-Message-State: ACgBeo2fT0d6RHSD8l+WfwHbGxfS/a5RQYA9OgJVUgyecHa9i55giDg5
        Pqhnm3fC/EkwrwCai17tK57ZaMFVGZx0lg==
X-Google-Smtp-Source: AA6agR7TTFk3YgOPlL+9C6TUwAfwOlLFM0YXFCK/P5v+ajG82oXuLeZAdoIc3R5bilRxv5ibXcqU+g==
X-Received: by 2002:a05:600c:19d3:b0:3a8:46a0:149f with SMTP id u19-20020a05600c19d300b003a846a0149fmr14470152wmq.185.1662482871857;
        Tue, 06 Sep 2022 09:47:51 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v3 11/30] thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:01 +0200
Message-Id: <20220906164720.330701-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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

Replace a single call to thermal_zone_get_trip() to get a trip point
instead of calling the different ops->get_trip*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c        | 33 +++++++++++--------------
 drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++-------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 1efe470f31e9..96b541458ccd 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -582,23 +582,23 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 	return temp;
 }
 
-static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
 	struct tegra_thermctl_zone *zone = tz->devdata;
 	struct tegra_soctherm *ts = zone->ts;
+	struct thermal_trip trip;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
-	enum thermal_trip_type type;
 	int ret;
 
 	if (!tz)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_type(tz, trip, &type);
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	if (type == THERMAL_TRIP_CRITICAL) {
+	if (trip.type == THERMAL_TRIP_CRITICAL) {
 		/*
 		 * If thermtrips property is set in DT,
 		 * doesn't need to program critical type trip to HW,
@@ -609,7 +609,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 		else
 			return 0;
 
-	} else if (type == THERMAL_TRIP_HOT) {
+	} else if (trip.type == THERMAL_TRIP_HOT) {
 		int i;
 
 		for (i = 0; i < THROTTLE_SIZE; i++) {
@@ -620,7 +620,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 				continue;
 
 			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip))
+			if (get_thermal_instance(tz, cdev, trip_id))
 				stc = find_throttle_cfg_by_name(ts, cdev->type);
 			else
 				continue;
@@ -687,25 +687,20 @@ static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
+static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
 {
-	int ntrips, i, ret;
-	enum thermal_trip_type type;
+	int i, ret;
+	struct thermal_trip trip;
 
-	ntrips = of_thermal_get_ntrips(tz);
-	if (ntrips <= 0)
-		return -EINVAL;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	for (i = 0; i < ntrips; i++) {
-		ret = tz->ops->get_trip_type(tz, i, &type);
+		ret = thermal_zone_get_trip(tz, i, &trip);
 		if (ret)
 			return -EINVAL;
-		if (type == THERMAL_TRIP_HOT) {
-			ret = tz->ops->get_trip_temp(tz, i, temp);
-			if (!ret)
-				*trip = i;
 
-			return ret;
+		if (trip.type == THERMAL_TRIP_HOT) {
+			*trip_id = i;
+			return 0;	
 		}
 	}
 
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index c34501287e96..cbaad2245f1d 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -316,18 +316,17 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
 	*hot_trip  = 85000;
 	*crit_trip = 90000;
 
-	for (i = 0; i < tzd->num_trips; i++) {
-		enum thermal_trip_type type;
-		int trip_temp;
+	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
 
-		tzd->ops->get_trip_temp(tzd, i, &trip_temp);
-		tzd->ops->get_trip_type(tzd, i, &type);
+		struct thermal_trip trip;
 
-		if (type == THERMAL_TRIP_HOT)
-			*hot_trip = trip_temp;
+		thermal_zone_get_trip(tzd, i, &trip);
+		
+		if (trip.type == THERMAL_TRIP_HOT)
+			*hot_trip = trip.temperature;
 
-		if (type == THERMAL_TRIP_CRITICAL)
-			*crit_trip = trip_temp;
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			*crit_trip = trip.temperature;
 	}
 
 	/* clamp hardware trips to the calibration limits */
-- 
2.34.1

