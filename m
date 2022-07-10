Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8647656D1A6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiGJV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGJV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960F15FF5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z23-20020a7bc7d7000000b003a2e00222acso1117800wmk.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OG0J5UXur47VUkQJyMswMokKl0Ud/3VRKQ3CS1V7X0Y=;
        b=liiAN3xSPx3ND+hbz8Xf+UfC/kuiWklRynbKojZgrL1yTt06ctYmxYZHJ+vd1RmToi
         Gdkdn79fR/8yfBQuwjkxGdVvHMYQV3kGynnksuTYD1ZIBayjGfS91n7J5DQKSTcOwcNG
         +WU+QC3TyFpqGQ/zd1sBIacTEQVQoywPaie1C6ES+giNEEi73G0SBKBGmjVttIQL9cZe
         VQZh2j5K26aZlzxSiLF50lwEoeszx/aBXzPsj9Q0al5USJ7jvFe98g9xtn0QiP6v2v4I
         WV624/QfQJMIDRCvk6asiBx9XinQB9nHE72wjATfGrwKUkqDko0tyWiv9/XaeSpdIfl+
         GTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OG0J5UXur47VUkQJyMswMokKl0Ud/3VRKQ3CS1V7X0Y=;
        b=hyCgdBOz8rDJ7eQ6Y3JwhWVeg647mNpsvD+6T0JK7SYFW5WnvoEEVEoVmHuY1lk0WJ
         HFDclLQLrchw2bVDRdKRPcB/uTcUQ5dSxzrc8IVQ4q8axCReWda1fF0c5SGqMBcZFbTe
         6VbSY4Rs3FYkwAzMMuCWJ9G5nIP8bqUgJd3t3M2FVrQnkZKqYNcJ8/rCpkenRq5RxcJY
         vAS+tmdfwcDiODS4dQ1m5w2Mtp78RtAe/DzRONT061O3B4ElJundgN0TMfGyxEUAjLNt
         jSxlIspxk9ndUka5RR5hGqU35IrpJHRlp6F53e53s0FEAuTz6THEGmrp/b8PqES6ZGgu
         d1Mw==
X-Gm-Message-State: AJIora9YZFdC3YD+SgkGuKzXp17g1RuX35qC8iq2Levr49ZjKxkBk9De
        uaKQhiqCYZBvOO1bOcrrbSosmA==
X-Google-Smtp-Source: AGRyM1vMcDJfYD6KDwtKJIJibBcRMvnNOAQVeMgfH7jzNgMMPr6aYcq20t6rwPk360aQxiJiyq9q9Q==
X-Received: by 2002:a05:600c:4e8d:b0:3a1:2e4d:1dd2 with SMTP id f13-20020a05600c4e8d00b003a12e4d1dd2mr12452610wmq.85.1657488327448;
        Sun, 10 Jul 2022 14:25:27 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 32/33] thermal/core: Move set_trip_temp ops to the sysfs code
Date:   Sun, 10 Jul 2022 23:24:22 +0200
Message-Id: <20220710212423.681301-33-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the trip points can be set in the thermal zone structure, there
is no need of a specific OF function to do that. Move the code in the
place where it is generic, in the sysfs set_trip_temp storing
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c    | 23 -----------------------
 drivers/thermal/thermal_sysfs.c |  5 ++++-
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 60ce270f2add..5219d67ac045 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -288,28 +288,6 @@ static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int temp)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	if (data->ops && data->ops->set_trip_temp) {
-		int ret;
-
-		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
-		if (ret)
-			return ret;
-	}
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].temperature = temp;
-
-	return 0;
-}
-
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int *hyst)
 {
@@ -350,7 +328,6 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 static struct thermal_zone_device_ops of_thermal_ops = {
 	.get_trip_type = of_thermal_get_trip_type,
 	.get_trip_temp = of_thermal_get_trip_temp,
-	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
 	.set_trip_hyst = of_thermal_set_trip_hyst,
 	.get_crit_temp = of_thermal_get_crit_temp,
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5018459e8dd9..3c513561d346 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,7 +115,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	int temperature, hyst = 0;
 	enum thermal_trip_type type;
 
-	if (!tz->ops->set_trip_temp)
+	if (!tz->ops->set_trip_temp && !tz->trips)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
@@ -128,6 +128,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	if (tz->trips)
+		tz->trips[trip].temperature = temperature;
+
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-- 
2.25.1

