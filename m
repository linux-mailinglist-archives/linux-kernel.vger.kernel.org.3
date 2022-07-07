Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333D56ADDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiGGVpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiGGVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:45:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214C41BE81
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:45:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n185so11406315wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W1S2KUuL89TqEwWGa5XSTCs1irHk/zbJh1P5bOgERI=;
        b=SqSqUqxqAI2sKxZVos7Co4QzIGi1f3CN8/Y6ICAv4knomV9jJQ+MzuOIxv5yFphd6Z
         hyVG1GkLXnkb6p7FUiSyRiDJAX5WjvD8Qk7Vv/77onUSrQTovATWLOll74H8QT+5yxuH
         0lyhIrF9N8sG7KRuCeg22lCUNd1sZyjXQeJUtY+GyziIKL0FvTXbDICWaqPJ2YX3LMBG
         8P+iBRUe/2VNM3fhQDz0vjO42GAW8HzkntdIuIg+SGLjVsV3w4XKIysOySe/guQZzcTy
         xSxGBAFaCLVE9w4dg9MC/lvpVi6hcaKYyo+csv4Qr64RYF7r9WEpdI2bVfGzynLPREyu
         f1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W1S2KUuL89TqEwWGa5XSTCs1irHk/zbJh1P5bOgERI=;
        b=xEPKD41AEtohNkQrGU1hbnv4OoPd9X31am7YZeM+YUCcBWyXT7Yj/GEErR6ZfqpUgR
         A/ATTQOI0iUyKe83PaE52BsHeJLdgtc6jv47VBwD2eU05mqN0V9/Oji15AxUIULy/Gkp
         fyT09udvqoXKidvKQ/eJbAF+O+7F0kYKsMr1gTP+Nwj4CjIzrN/M01iIyPwtN7KcSzNb
         y2WIPbrKm48YsKuLBMW4Qu/PuoPB+foMfKvaLuBwMa5qDqhTSU+jrBfvs/7K9SKkZSbf
         j3HwMk7QYaYearDWh+PEQtCHB+ssfiVeadULKhrCKzdB4xTjfQhfzSBnvy5D9krfws2v
         d8SQ==
X-Gm-Message-State: AJIora8I9faHOxTgGSOXOb61UIHd6nWK3ra3RcrSWouMX/8c7o7PO5tC
        M15qnrVzfirfqprQKW3V4pSx9g==
X-Google-Smtp-Source: AGRyM1tjrqDfvJ3OwjEIeWBSGVWnPWDN8kNAeLrt3r/jFFBqrQI8dN8WlH1hLerJFhlzLAzX37zKaA==
X-Received: by 2002:a05:600c:35ca:b0:3a2:aee3:a8eb with SMTP id r10-20020a05600c35ca00b003a2aee3a8ebmr7139965wmq.86.1657230320619;
        Thu, 07 Jul 2022 14:45:20 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b0021d87798237sm2417439wrt.20.2022.07.07.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:45:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] thermal/core: Encapsulate the trip point crossed function
Date:   Thu,  7 Jul 2022 23:45:11 +0200
Message-Id: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The routine where the trip point crossed is detected is a strategic
place where different processing will happen. Encapsulate the code in
a function, so all specific actions related with a trip point crossed
can be grouped.

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

