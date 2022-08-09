Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010DF58E285
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiHIWGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHIWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77497DFC6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so15734090wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pEJ2fI5oyXSDkm4TFagk1yPb1z/Mu52z3/w3W5mIhos=;
        b=gukC8b/QtpzlyuOSf2HZMDcLd361sAiOCbFHcmG31rZ1AJIiFYQx3AYv9k4a07LNr4
         EwTzmCGB9dRv3vMSW38S4e+z5Im17IsXi+Hjnf7kTCkmGOBj8WskYC4n0+Gi2ok09oTy
         fcNSe/CzoW6WL+FvBvNhNYRjBhyK+tuoj5rWZAjSoK73NtrFSMGRYT71Gmbma1O8CfGS
         m/NMqCmpqmtyseKI/HKonGeZNhRzzAEqo0PNNhlKJv56s4rLaW46DCNbNJ0HfqnM698n
         TbW+VIuLFm2MgZyqEwN1an8ICRK+EFPMy277KAmgQTXvzOMD5OrAaOuQ0pzi5twYSM2/
         JYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pEJ2fI5oyXSDkm4TFagk1yPb1z/Mu52z3/w3W5mIhos=;
        b=m7ZOwWO5hDztORXVIjIsT2cmKyVTCW2KaDOrdkPjb/5IKQAasir4vR1SVPaTXMsCly
         tDK+16RpTLNIZyrWYEOcGaUcdmnT+eD2sKgUy/IvbpelEC5NjZ0h+NmGUnaw4hXn0LA+
         knsxNe1nBIuJ4GeSGcykyYKa2V5VIkhRQkLAGm1Z36vu+usYVw6IIJvo1qDxRGVvbr4g
         fFSUJZwcxYJdmCOVYfHaN7Zscp1mu8tpNk0S6k02NB9vv/17c74XoAp4uhI3XG9BVvfZ
         TnNs5phvd0pdBjqD1niveY1PqLn2hXybX10550lzMx/AkhAuhdiUDBynKJ57xVHgjd9s
         19oQ==
X-Gm-Message-State: ACgBeo1OrmhL+C1TN/GU1bSykwbVvaRmzYKyWobk1DUsYwhs7eW1XxDD
        C/xQbrMMwD3yDMBloRR/s2i6VQ==
X-Google-Smtp-Source: AA6agR42y1dsm01IqTnuE1ghurPV48QcVTLBaiYLz53iE4d+SEFarwylT/XtidEzeKRinG9/QyPYQA==
X-Received: by 2002:adf:fe81:0:b0:21a:3574:ec8e with SMTP id l1-20020adffe81000000b0021a3574ec8emr15996076wrr.410.1660082710038;
        Tue, 09 Aug 2022 15:05:10 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 10/26] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:20 +0200
Message-Id: <20220809220436.711020-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
2.34.1

