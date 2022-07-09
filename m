Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2556CBC7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGIWde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGIWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:33:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FF1759B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f2so2604011wrr.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOV3jBcg82SkJlwYwOt/rJO7ag2lj0Zbffx6z7DzHn0=;
        b=zK9PlRT+MmTJG8PsfD4SBWj1MISwo8yjXhL1qjJfd8tNkY+cFxFn+ZrZzgPB2yld/B
         dzrteJUD1f072pBJ+qCQros0ZRYAdZAuEsMYBUvHTNGwyEgH64Gww7LgurlbfgtYPsAW
         o+/S0rZXmq4e/caWfQi6s227mfDjD/GJZV24SOgIJ/Q476MZSgMkpCom4HYbWYRukVf3
         1g9kKq/8NyHdBohUT87vAvs95LerVG9KWedslFDwLRn4oE9NONqwlXHHgP4ZwiyjDSsX
         AGtXPNEeD1fMkG5w4wLkOC1eonfcwwyf/I3e/wS0vBuSJR5fMyo3sGg5oUQrMdFRkmFb
         9miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOV3jBcg82SkJlwYwOt/rJO7ag2lj0Zbffx6z7DzHn0=;
        b=mHxR+rAosIeqq3AOjYUL5ip6QlcjReNK7HahHRNW90UFmhzQaIHuaTWbodHlIQvuBf
         Bm1Uojd9u9+NGiwwpUi2o7ctSeUdNcw4lXZX3vUTKVtBzRRUh2+fgiiwwgeKTEnlBuBq
         fzEHgw+6l4deSkqDZcX4t4l82sEw6H9Uyfm73Hqwy0OVVPbsYml2+SjGGrkWotnp3EyV
         4nURbyAu8EUOQ83Nk/FmPOJgX09X4v4IrLkNLmoUOQlLokdDnYQiT+Wlpy2goiybMgsK
         3Ddm1PbBTErZekCamyZULp6U32LqWHwITcgQfeu932yf/QWttJe/ss2ZJ6BVm/c0jkRx
         bUPg==
X-Gm-Message-State: AJIora+FM0XHrB+BC7J614/5Q1QcB1udkOcyqJtzoU2IUrhgJZ9jrvVH
        TyJx+fZOUi9xwvKnC39ZBwdXEg==
X-Google-Smtp-Source: AGRyM1sKxwEX8OhydrMs9D6/2l/kCVSrOoNaz0Cv+wxzwUCjev1kZxTM6Z4FKZlOqAQbrQ4ttCKoKA==
X-Received: by 2002:adf:ce0c:0:b0:21d:929e:1522 with SMTP id p12-20020adfce0c000000b0021d929e1522mr7402087wrn.126.1657405978483;
        Sat, 09 Jul 2022 15:32:58 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 11/12] thermal/of: Use thermal trips stored in the thermal zone
Date:   Sun, 10 Jul 2022 00:32:28 +0200
Message-Id: <20220709223229.1619339-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
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

