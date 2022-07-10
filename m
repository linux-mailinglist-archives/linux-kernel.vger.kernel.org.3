Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535DE56CF22
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGJMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGJMf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270A11156
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p4so1669585wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOV3jBcg82SkJlwYwOt/rJO7ag2lj0Zbffx6z7DzHn0=;
        b=GlWxOymnKUTWYKcO5EKHUZoe6f7tMxw/PFOOLAd9i23TL4YVvGMyjmPQ619roa/tLO
         PmKq9buzU1CFpD9KR/ZWjzTjHkF0V7tUEHDko8aTnfbw4Ku6nfERlwD0GM1Qyv04FOF/
         MRzJifeIwq/DeMj7cCv1wBrTikhkhchMfnUKixnRiAwA7Y7wohO9wTC1gqnBVEVBbgzN
         vEbBAkGpjyTAqk0FqUBVGrh+HT6AP0YYAI0D5JRUf+QWYHhjsIYZVQgdxB/PA7uHcwaO
         WnbjvbT0xlyrrsk+qdgSV/S/XmMD5g1VUhmALlFMm8h6fTgVQKqz9Faluu+cMaE/LRPv
         d6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOV3jBcg82SkJlwYwOt/rJO7ag2lj0Zbffx6z7DzHn0=;
        b=8QZkOfXNfkM3l4UrgLyyVYLX7HtUCDByT72Il+bIqPPjtEMfSocKkx7hJMJ7WxxJe3
         NaRzYtfWKd51PsbgS2wUf9VMKAMNQ0D5TRMyzeW1O0XIWPUC6chk7qkG9lZZuEbnh4TG
         INikQDwbioSVPYDYgwi6lcD+UN17bTtyN3cIlt4vzXhTzGCFLwz7A9YvLNhWg+R4O3z9
         C6cvsJOt0g2QOkDCi95TfteIM2YgKeokuD8aleRuzAu8MUwJ0OjKm3eCXBHUZ7nnDBcY
         GS7oidxULeBcvvpOjZxVkb5LeS8sHABHVW2cSmgQCsQQhUHSO+zfZOlvGRdw+VBhZHrs
         /+uA==
X-Gm-Message-State: AJIora+0wWu7UvRNQEc/u3d4qFM7YqHGbDv5H7SI5MrM1XUH4csAkVUn
        vIEmRIoUigmkPOPKC39IZafygw==
X-Google-Smtp-Source: AGRyM1vc4Ap92ThwhdsU24BHeRV5vu6gEn7so/V6hNX1a8ltazDAwhNfpNCM5ft932XtN5VblpQing==
X-Received: by 2002:a7b:c401:0:b0:3a2:ca58:85bc with SMTP id k1-20020a7bc401000000b003a2ca5885bcmr10613647wmi.156.1657456536246;
        Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 11/12] thermal/of: Use thermal trips stored in the thermal zone
Date:   Sun, 10 Jul 2022 14:35:11 +0200
Message-Id: <20220710123512.1714714-13-daniel.lezcano@linexp.org>
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

Now that we have the thermal trip stored in the thermal zone in a
generic way, we can rely on them and remove one indirection we found
in the thermal_of code and do one more step forward the removal of the
duplicated structures.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index e187461dd396..601552c55d0b 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
  */
 int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	return data->ntrips;
+	return tz->ntrips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
 
@@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
  */
 bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data || trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return false;
 
 	return true;
@@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *tz)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data)
-		return NULL;
-
-	return data->trips;
+	return tz->trips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
@@ -281,12 +269,10 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
 static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 				    enum thermal_trip_type *type)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*type = data->trips[trip].type;
+	*type = tz->trips[trip].type;
 
 	return 0;
 }
@@ -294,12 +280,10 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int *temp)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*temp = data->trips[trip].temperature;
+	*temp = tz->trips[trip].temperature;
 
 	return 0;
 }
@@ -309,7 +293,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
 	if (data->ops && data->ops->set_trip_temp) {
@@ -321,7 +305,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	}
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
-	data->trips[trip].temperature = temp;
+	tz->trips[trip].temperature = temp;
 
 	return 0;
 }
@@ -329,12 +313,10 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int *hyst)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*hyst = data->trips[trip].hysteresis;
+	*hyst = tz->trips[trip].hysteresis;
 
 	return 0;
 }
@@ -342,13 +324,11 @@ static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
-	data->trips[trip].hysteresis = hyst;
+	tz->trips[trip].hysteresis = hyst;
 
 	return 0;
 }
@@ -356,12 +336,11 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
-	struct __thermal_zone *data = tz->devdata;
 	int i;
 
-	for (i = 0; i < data->ntrips; i++)
-		if (data->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = data->trips[i].temperature;
+	for (i = 0; i < tz->ntrips; i++)
+		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
+			*temp = tz->trips[i].temperature;
 			return 0;
 		}
 
-- 
2.25.1

