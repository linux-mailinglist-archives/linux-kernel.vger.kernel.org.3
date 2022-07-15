Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8225768AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiGOVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiGOVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:09:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC6110554
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r2so7331562wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuR49etHrCUC4nyK2G7BLQAMCLtkwxAEZTehEbHHsZ8=;
        b=vrTYMEyO0VU2Ius0MQsOmHiv+LMWF2wbXfb4qzWDHIDvVx/y3DSrb1ngD2MbWv8khD
         3ZDDnGtdvMKq3bkdW2EWM7QXuGg5o3Q64e2ejCzlNJDDsiSFiD2qBTnHBocnecHPbpzJ
         KzHdRroE00f4WBJ0KjQQMs0RhoAlYt6vaXts3b+SLVbu9EWFmoS/7LtkE8M+rjgGqwMJ
         6V12K8wba4wASUUF/ecMtxwilXHmm2SSin+y4A3h7n54sX7oJDIS5lal14Q9ixnBfVXf
         fgCCVgFwDA8fDurCl1rGMl3XStfkmRT/VltNbTp7/rdgTVkkXFG5zAbnTvdqAewygSNS
         xQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuR49etHrCUC4nyK2G7BLQAMCLtkwxAEZTehEbHHsZ8=;
        b=Mt8YaxAURduB+u3zXCWYxyvmT6OCrJaXL2iY3fRNSwUMYOh9JN1bEQpHCqA5pWUObs
         iAnpzZbuVrDUSir2Ydskw/hEVX+kYD1YLj4J4u7KX1Dj3wrrhx3VQ6Nv6hdapKFW1VGS
         OSbX2TdjEBWuqAxRBnVCsgm36nyTo7OPB+t8iS3pqje+EHPC91g/WcOh0acbB0cUrO/X
         dT2VpTvJiFlWHFho5mjxpHLj1YWM6+EsJZ3WXXHgUesJVy4O5MtfA6BSn5FT9tQFfXPD
         lNY2thZNi4xxzhi6Eo2mJ9AGR6C30NS9gdyYYO1cpS2qTvXuPlrPnPeZv4DMUsrpYXOC
         2NKg==
X-Gm-Message-State: AJIora+qjcGC60kSBbY+FHxjaiM0cjKsY5pkiT7KsUI8oa4e9V+z3fIx
        cODDyX/1d+ge9D4UMjwTRphwFw==
X-Google-Smtp-Source: AGRyM1tDsHvcoC8bUH++rJtR85y2lhI21/AEsXL5BW92qh3m2/p9Cnovv9+bj/VcddLcShI0vlNdrQ==
X-Received: by 2002:a5d:47a1:0:b0:21d:a4c6:352b with SMTP id 1-20020a5d47a1000000b0021da4c6352bmr13789167wrb.365.1657919357055;
        Fri, 15 Jul 2022 14:09:17 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b0021a56cda047sm4567752wrq.60.2022.07.15.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:09:16 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] thermal/core: Avoid calling ->get_trip_temp() unnecessarily
Date:   Fri, 15 Jul 2022 23:09:09 +0200
Message-Id: <20220715210911.714479-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715210911.714479-1-daniel.lezcano@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
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

As the trip temperature is already available when calling the function
handle_critical_trips(), pass it as a parameter instead of having this
function calling the ops again to retrieve the same data.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  v3:
   - Massaged the patch title and the description
---
 drivers/thermal/thermal_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9f771b15ed8..f66036b3daae 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
-				  int trip, enum thermal_trip_type trip_type)
+				  int trip, int trip_temp, enum thermal_trip_type trip_type)
 {
-	int trip_temp;
-
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
@@ -394,7 +390,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip, type);
+		handle_critical_trips(tz, trip, trip_temp, type);
 	else
 		handle_non_critical_trips(tz, trip);
 	/*
-- 
2.25.1

