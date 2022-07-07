Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2219156ADDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiGGVp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiGGVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:45:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAB91FCE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:45:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r14so22304447wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VMSNl4aXxj8gUfbW/Yo0+vXzMXAM2NkamvbFD7ALP70=;
        b=Kl52qJEdiALhhqnTNTN0eMxx7VJsUaaM04zyR0BWDJf7fBuqigHltRInhQgkgnJOZX
         pIVGJO7Rb8Pc/o92epk+YnVapuspmLSqlFiJCvu476z1zlrkZXyeZckti+86tMDfZ9Ja
         1ncOwJWyCtlmToGnowZYCKLlsZ4UEE1VL+fU57tGnW07/9qzlC4gyu56wh5vD/6NIEvW
         /LfXHhJQgpT9u5x5sU1Y3kcjNsyXV9AnOT+lx0SWCMU6I0dfBJQsMZNPO7/gAfKUxzgk
         W+v1Rsciu48jWGrgesS7Z+pCoQGAyqqN3+jDDt6N41mA+W2qubdJo0k35wJaHN9mq8t1
         pPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMSNl4aXxj8gUfbW/Yo0+vXzMXAM2NkamvbFD7ALP70=;
        b=hKo+rOsfbi7cMrvUYnLvFXLcf9PzYQWk8eZMEWTf36d29C98pDnyJLsjH6j1tAIKrY
         pRlabXmQtbNcXkg/g0eP1Xds3TSWw9+tL9A9NtYcJKGvwNsCrARQAnkfikMxYiyqAfGf
         rNXWcO91+L6wJg4QdNrQg5bbtNq5MWkIQDfgLj3g6YzeBHnspqwGlJ5q2dSRT+d43+fm
         06xcf9lEqoORIxDSdlxfPmrjDxw9wXYlQvtTsOJj+S5sw0zZjEK9I4pf6m72Qv12uRGc
         PxWE7a4jg75dn3d2CbOZrSdxT3voJLIA81AJPUPHZUm6FkHf9qT0nxHuskOuSwwcEA6C
         P+sQ==
X-Gm-Message-State: AJIora+6zkqNLX3r90+bS6DSxzoWf2xb1KYFJLh1Wz0D5JU5ersLf4fM
        1L1SZic2CYOrYPh/xKHiQkSdfg==
X-Google-Smtp-Source: AGRyM1vfjGmJa2TKGa1NYBlA4z9HK6Y3AfPmRdtufUCZ4qLbX4jWtbfaNv720SkcvTrXeq3j0+WJ1g==
X-Received: by 2002:a05:6000:2cb:b0:21d:7760:778c with SMTP id o11-20020a05600002cb00b0021d7760778cmr13961374wry.329.1657230322023;
        Thu, 07 Jul 2022 14:45:22 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b0021d87798237sm2417439wrt.20.2022.07.07.14.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:45:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] thermal/core: Passing a parameter instead of calling the function again
Date:   Thu,  7 Jul 2022 23:45:12 +0200
Message-Id: <20220707214513.1133506-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
References: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
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

As the trip temperature is already available when calling the
function, pass it as a parameter instead of having the function
calling the ops again to retrieve the same data.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

