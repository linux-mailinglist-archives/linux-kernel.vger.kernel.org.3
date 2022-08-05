Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E658ACBD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbiHEO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241032AbiHEO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7166113
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv3so3543012wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Yosq6bk1KHjuPLLTagCwdDixZvCyUy9tf9EC98uzdoY=;
        b=g61M2nI4MW3BY2KzXjQ9Xu4ZtS1xfntiPVj2Za79gcRp5mTi6A3l+/fM0uJMIYsbEb
         vEyfL4p9pWhbBQJ1JS7H+GXqTzKYisoJrQhbQh2lqjHiA65KEK197gi5XuNHLcCEdQii
         FFu5KFhGE8xjXbIyovQe53i9QhQIa7zE8YePYA4ktl/+fRu9Q/sMM1M7H4X9EwTbHrah
         k5TQEF5OZhfq1ULGMgIwRh71yPl7vnAtEWCSdh2vLCZVkgxkCPCzJWvMWav2gjIpJA1e
         q9FNWDzrcky/aOLymL+0zSK529KyZK+TIR2mCLsPOjI6uGyo+BH7wDYr+crRr2zgwXDU
         yNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Yosq6bk1KHjuPLLTagCwdDixZvCyUy9tf9EC98uzdoY=;
        b=CZBLWfSrCVB0v+ExQ6Pj0YcNbMa1pw7IMvhdLFxjgvTPixhSRnrsRGG8ufeYm1LBWs
         Mcjy9LdvCf/KCsB2JTrKVBhEF5EleyTqlulVID9QEvzXRO1A34zWsAJCreQ777zqZv79
         dqz+NH7RU6QG5p+aRBW/WxYdSd2IS66vP4wETQP3AGwS5IjsY/gG2dC2opUFz7OMjrhn
         aB0BsBMRL4hFGveS2jjIx+6bbOTsZ9L2WXmkwQMOCUknIbnh4WpsR4H+IIhKZdSJPMTy
         QK+CDK3UgN1W8hxfGl2OQxZ5Iy0eIlAQyripjwNJimdW6rKVMGwOTnIE6SyozCCyIMgd
         z19Q==
X-Gm-Message-State: ACgBeo1N/wT3rCzgCu7mQsbu0tOWqVBVDTkM268NTx3bznRvSCA4tu4X
        ifBnkaOn6F9hljyxMxDQd0r/LA==
X-Google-Smtp-Source: AA6agR4Hmvll0cmg0okuHWG6GU4XzaIAGCE+u1/i4v9wDFqF69T06Pt3Lq3LX/Ds0zZvGque53q7rA==
X-Received: by 2002:a5d:595f:0:b0:220:619d:da07 with SMTP id e31-20020a5d595f000000b00220619dda07mr4566872wri.10.1659711479282;
        Fri, 05 Aug 2022 07:57:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:57:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 10/26] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:13 +0200
Message-Id: <20220805145729.2491611-11-daniel.lezcano@linaro.org>
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
 drivers/thermal/hisi_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index cc5da71b6f55..914dc73f4263 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -490,7 +490,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
-	const struct thermal_trip *trip;
+	struct thermal_trip trip;
 
 	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
 						    sensor->id, sensor,
@@ -503,11 +503,12 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	trip = of_thermal_get_trip_points(sensor->tzd);
+	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
 
-	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
-		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip[i].temperature;
+		thermal_zone_get_trip(sensor->tzd, i, &trip);
+
+		if (trip.type == THERMAL_TRIP_PASSIVE) {
+			sensor->thres_temp = trip.temperature;
 			break;
 		}
 	}
-- 
2.25.1

