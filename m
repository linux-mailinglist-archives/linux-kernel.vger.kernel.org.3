Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCDD5785CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiGROuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiGROut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:50:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C706CE00C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:50:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so10006059wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cn3TgSP5aiTmcU023jjuDtoPr/sDYC9llPRhRIcuSNQ=;
        b=J4UuT1JSEzRi8CSx5a3btUkARmkINwON2hswFgyE9FKa6Mkqe35VAs/lX/6s2UVLw/
         YJVh/StXREGEQOYsePJ4KccPZEAuf83PT6Rp/98K5chE2/fjSvhJRMeTP8rG8zzyjeiy
         QQFghKbcDe+Relyc0inoxylwrlL3CMbzERLy2pgB24hkDwM+Lc9me2JF/TTCVGVfPq4P
         dkRu1ALj6RFSoj2vMH0g9O0KeP+UsSi6OMLbks49EAqsdkuNuc+S7gZDzjBZ9tsamMA6
         81IILAwRBSlFmsazGufmU1FecSEU1ZtY2QQGeWaA+yc3gSaZfcBBLbI+FAhVwCIYHR/R
         1ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cn3TgSP5aiTmcU023jjuDtoPr/sDYC9llPRhRIcuSNQ=;
        b=Nx4cK12tbMbB/H8oUcntlnz09Sc7J0a8l1dJLdhlkl+hNH7eQr83J6Zn9N91MfsjaL
         JHJMcVy57WCu5x+niD9UieEvrI96lmkuUscyOW72R8xNwMHWsfdFzVUnZTBJt7v/f1Ho
         99YelxcP0gvnLI7ajZBRe3fXaLv2vPPBHo0HXWXcSGmufJqCxSfbVpIVpitE2Gp3c6Q6
         I45EeGEvPJj/POTvAnOLu3xYH0/l5BpoDtD//G7wRX2o39D2EwN9ogdCIMGPCPa8tMb2
         1QdXXGTltwok3QvYADWJvOr3TQrzTCIPuFobzxGpKCwQSFsMEHsmJpebKTjsK5B9hPPK
         SzfQ==
X-Gm-Message-State: AJIora9Ge/9/Jn/0iuQTOMhTDPhi1Kc2dyM4sTRComKfuHAhpgWLtNsc
        MxLXGJv9DVX8FlmU08msMAMOtA==
X-Google-Smtp-Source: AGRyM1ssLsM9xoEZO3rTBHoMyli5V+AqoDfJ4wBzLNdRXvWcSdjHwF7OWR8zE2F6vEmWhC7RM5A3Zw==
X-Received: by 2002:a7b:ce8e:0:b0:3a3:1b01:8e7 with SMTP id q14-20020a7bce8e000000b003a31b0108e7mr5183073wmj.31.1658155845215;
        Mon, 18 Jul 2022 07:50:45 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a310631750sm11643715wmq.35.2022.07.18.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:50:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] thermal/core: Avoid calling ->get_trip_temp() unnecessarily
Date:   Mon, 18 Jul 2022 16:50:36 +0200
Message-Id: <20220718145038.1114379-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the trip temperature is already available when calling the function
handle_critical_trips(), pass it as a parameter instead of having this
function calling the ops again to retrieve the same data.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 v3:
   - Massaged the patch title and the description
---
 drivers/thermal/thermal_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fa5767c6d5f4..fc6ccc5edbfb 100644
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

