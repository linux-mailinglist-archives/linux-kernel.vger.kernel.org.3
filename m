Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2687B58ACBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiHEO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbiHEO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC716611B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so4088030wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ig27WRkfztA7dqT0A9KX7uwx0v4kJP7JKwqv4NKg4G4=;
        b=WN+INDc+KXSjVG027ata+4qfVunryIEZU6sgh3iax/8D9/p2S9ztTZRMQ4etCKaxnt
         vUgz/8dusKxhBI9HwFhN/PcjjXREeiS8k5tPfljZLpeAJ0S+2XyXsKqfKgkg0iRsByN8
         B8xVyZHnuexjAehxQZ7BKes+eB+3LQiVQQaB2wplcEWVYLfCvCXsfI+Th5EiPw5Y+TCx
         sSH8N/xB/+s7FAxX5lb7U+jZ9ot78qPkX9lMKZDs1tXdCyNkfOnCRWoaYGIZMr2euZFh
         TySZYRhFEhEQIjS5H+nHRp3NdECfJ/496KkIdlSZ+s3YecaACOc1UIqT3bXR1WWZsmno
         WMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ig27WRkfztA7dqT0A9KX7uwx0v4kJP7JKwqv4NKg4G4=;
        b=Z/TjqwIfgHAWOw8+f9SXFT9llIsU/LuCEL0BKIpJ6TipNAgMFeDbghZgYT3Xb2BRNY
         NABLImd5c5MkhbJgVYG4A84Jf664aiYc1TDCvpVRJVAXHZIg2vEOm5v8drFrO5z4WVLp
         /VtxeRVfHQgrocehxfl7qqyzLDycKKs71cpJKfSN/WejPrgeck3hqTy9hiU7OuXUgFWT
         NUsN/mpL9ryCGL8JbWURy5zXqhnr7huUXWzbcYNC6+WC6hZPyaSxitB9bRHdHno3kI6J
         o59BnptNlQUXnRjg3bnRVa3/waEiVH83qND+1ZTY79IGwiD2m7otmJECNnX3fbGSQidl
         5f2w==
X-Gm-Message-State: ACgBeo2aTRGlaxfk0jOArgH/06bXFuOAPyCnxh9dMgJEH2nW7LaSHwWI
        OlzTXxe8UgtjH4wUYoHZjICeqQ==
X-Google-Smtp-Source: AA6agR4O1T7LTxjrOyXb06FtUVWTnJXQ5ps/gLDs0Xl/YCEB7dj1QGhOpBJJLpyUARnDYEE1ldkRBQ==
X-Received: by 2002:a05:600c:a02:b0:39c:97cc:82e3 with SMTP id z2-20020a05600c0a0200b0039c97cc82e3mr9770907wmp.97.1659711480499;
        Fri, 05 Aug 2022 07:58:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v1 11/26] thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:14 +0200
Message-Id: <20220805145729.2491611-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 39 +++++++++------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index be785ab37e53..127e8c90211c 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -263,17 +263,17 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
 	struct qpnp_tm_chip *chip = tz->devdata;
-	const struct thermal_trip *trip_points;
+	struct thermal_trip trip;
 	int ret;
 
-	trip_points = of_thermal_get_trip_points(chip->tz_dev);
-	if (!trip_points)
-		return -EINVAL;
+	ret = thermal_zone_get_trip(chip->tz_dev, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	if (trip_points[trip].type != THERMAL_TRIP_CRITICAL)
+	if (trip.type != THERMAL_TRIP_CRITICAL)
 		return 0;
 
 	mutex_lock(&chip->lock);
@@ -299,22 +299,17 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 
 static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
 {
-	int ntrips;
-	const struct thermal_trip *trips;
-	int i;
-
-	ntrips = of_thermal_get_ntrips(chip->tz_dev);
-	if (ntrips <= 0)
-		return THERMAL_TEMP_INVALID;
-
-	trips = of_thermal_get_trip_points(chip->tz_dev);
-	if (!trips)
-		return THERMAL_TEMP_INVALID;
-
-	for (i = 0; i < ntrips; i++) {
-		if (of_thermal_is_trip_valid(chip->tz_dev, i) &&
-		    trips[i].type == THERMAL_TRIP_CRITICAL)
-			return trips[i].temperature;
+	struct thermal_trip trip;
+	int i, ret;
+
+	for (i = 0; i < thermal_zone_get_num_trips(chip->tz_dev); i++) {
+
+		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
+		if (ret)
+			continue;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			return trip.temperature;
 	}
 
 	return THERMAL_TEMP_INVALID;
-- 
2.25.1

