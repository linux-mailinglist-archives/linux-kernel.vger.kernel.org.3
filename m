Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589985768AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiGOVJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGOVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:09:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC570E49
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r2so7331495wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxbEsFkRpuwGSHkFCYXm35Pz3gor1PXEdEjjZ4dDIso=;
        b=ECmqWgF0/iWw8OYnFSCpnZrLQzFvpZ5Wlcl8Qk4xM83h11NVTftDk+p8Mlq3jY/MyJ
         42oTvGWj10aYYQNuw+YtlAau9zvQuI0CRMe0jLmVk4CeyQgBCuc7UDrMjIGMl9WvkLqs
         u9BO3xzcLDJoyFV6dvjCTQU09yhh+vQoTuEd18/Y4pxcWJ6PxFjT+W1WhTmYaHR5c61t
         867vz+XfF4iEbP8YgZFSDFGzMjjj34jaKb0s41Yf+y54i38dafN3VN0BhW5oa8YmTD6L
         Des2VcZw8kC5oDAQySjKol5oMfJEddJldCRPz+4Rz9dlKnJtggvCix2mdT0CojHikeW+
         hvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxbEsFkRpuwGSHkFCYXm35Pz3gor1PXEdEjjZ4dDIso=;
        b=sRfyclBl9UFSLjOv0ieUkFB+oR60y5kfibI8QRo7dbx+5nr2v7aCx7sEBRVujEmd6f
         diaToY3qUHN1BVmE5LuwUOD4VOHcwAg1RIH6Ec9WLCH8pg/Y0v9soAv3WY/aXQnnXoOX
         mfhnDF9UDOiFSOhMlFojF1DvWdT6IPUhvHg67KE6RDTs/HL3qjIBYTDOG//u86WrAC5v
         mrD9V+d80BK6ZlvFi66nLIZQnygGn4NJRTB2FnmgkOwEj5zANoTuDxvPO+o9wxWAgYYK
         iuvZZSpV9b0y4aYbb97zuPJTFZB4VTFHkZjaB1IRje3ft0it72fWY4VKS4bpOa5G6Lum
         b1uA==
X-Gm-Message-State: AJIora87xpNLmax8paPgV26UsBVYCosuaL8i5dsqZHmgyZj1plRYQn3K
        ShQyecKlipsr+dh/UG4uOUMMDGzjhi0siw==
X-Google-Smtp-Source: AGRyM1tfI/a0XswTl9zWy7klWOZegxdyf+AgVvsQqVZ2RN6hG8W2eCK3caMais/j2oseH5w5i6M4xw==
X-Received: by 2002:a5d:64c7:0:b0:21d:a742:5e2c with SMTP id f7-20020a5d64c7000000b0021da7425e2cmr14376966wri.178.1657919355571;
        Fri, 15 Jul 2022 14:09:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b0021a56cda047sm4567752wrq.60.2022.07.15.14.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:09:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] thermal/core: Encapsulate the trip point crossed function
Date:   Fri, 15 Jul 2022 23:09:08 +0200
Message-Id: <20220715210911.714479-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine where the trip point crossed is detected is a strategic
place where different processing will happen. Encapsulate the code in
a function, so all specific actions related with a trip point crossed
can be grouped.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..d9f771b15ed8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -358,6 +358,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->critical(tz);
 }
 
+static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
+					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
+{
+	if (tz->last_temperature == THERMAL_TEMP_INVALID)
+		return;
+
+	if (tz->last_temperature < trip_temp &&
+	    tz->temperature >= trip_temp) {
+		thermal_notify_tz_trip_up(tz->id, trip,
+					  tz->temperature);
+	}
+
+	if (tz->last_temperature >= trip_temp &&
+	    tz->temperature < (trip_temp - trip_hyst)) {
+		thermal_notify_tz_trip_down(tz->id, trip,
+					    tz->temperature);
+	}
+}
+
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
@@ -372,16 +391,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->ops->get_trip_hyst)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
-	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip,
-						  tz->temperature);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip,
-						    tz->temperature);
-	}
+	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
-- 
2.25.1

