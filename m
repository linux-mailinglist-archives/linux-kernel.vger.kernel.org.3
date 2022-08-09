Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C192758E260
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiHIWFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiHIWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:04:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F2FD05
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:04:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv3so15738867wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RscIum3lwOQWXIrcp1oY+m6OrdEEekgn0AWhfm6yIUI=;
        b=K6F4dQEZJMYate5rS22n6XTtEL0i94DXlh3UVJpE7WqW1lvQP+cguYzWUU0CF9JC/1
         +JpT4FGmL2nD0Shk8s2U6C/vLP9TMQ7sEAyhiKXmuFFch9p2EB1INaP0jHc1sagsbNzq
         siNcowZXLP69RK+Ne+pP/FHN/R8TyHhydVDBe+/EhM4yYZgEv35nqnO1WTgKeKpCUCzc
         MTIuNF6b7VAeESXqwqjGdP2SDpK5BVyd8OMsQZFlyOpKE0Lxc2e37tlzS+BTMUCHONTY
         gbIuaDMm9qCupBgmrWCKSorFOrtoxlyQEQveODOil87ShCy8OXPF0OmAC4DZjKySf4yb
         DVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RscIum3lwOQWXIrcp1oY+m6OrdEEekgn0AWhfm6yIUI=;
        b=XDSADnpklsIGQ/pZN1xqGaLuR/ubVdzUx3UVLii2v2UmUfurTSeJJlIrM7idN9Z6Jk
         UJi35s5mVGjFksg0AoZOMhj4/nPh552PEtXeHFUrq3uVi8bOYN+hJVE9KRBv01Ar8M8r
         AB0jHdb6Xxiljl5m7nBcjbz4QYvk7tbGCWUxgKHnUlwJgcUm0ZT32xeVfUOO4sSd2c4T
         +TwID6dSVocnVHW1wbYLIXq1Qdga2ABwfa9NX+s9FdAmCbNyelAdAEqNk9AFTbdheUGR
         k/HsGabD7a8bIuZlF4XtDjUl6FpNkGfsycE4rpzaVbJsk2vgfMV/iInH3JgLcVHOyIQJ
         VaAQ==
X-Gm-Message-State: ACgBeo1+OqF1FfMMf6kiZxHOTbHFv+6vEhdtOcVwRsqOr25WiDez85Ym
        kI/ZlVYjhBSnjMQNFO7IdfPoeA==
X-Google-Smtp-Source: AA6agR4BYROaqB1HYsHe6kKmwpxlSBPXwDMMzJhkcbbaqKWJToljtQAjJvocPabq72DsluGZi7IBkQ==
X-Received: by 2002:a05:6000:1d89:b0:21d:5655:eb72 with SMTP id bk9-20020a0560001d8900b0021d5655eb72mr15507032wrb.110.1660082695518;
        Tue, 09 Aug 2022 15:04:55 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:04:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 02/26] thermal/sysfs: Do not make get_trip_hyst optional
Date:   Wed, 10 Aug 2022 00:04:12 +0200
Message-Id: <20220809220436.711020-3-daniel.lezcano@linaro.org>
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

The get_trip_hyst() ops is optional. It results all around the thermal
framework code a check against the ops pointer and different action
adding more complexity and making the code less readable and
understandable.

A zero hysteresis value is perfectly valid, so instead of adding more
circumvolutions in the code, create unconditionnaly the hysteresis and
use the thermal_zone_get_trip() function which returns a zero
hysteresis if the get_trip_hyst() is not defined.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2b53927f3263..bc3337826ae2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -420,23 +420,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-					      sizeof(*tz->trip_hyst_attrs),
-					      GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
+	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+				      sizeof(*tz->trip_hyst_attrs),
+				      GFP_KERNEL);
+	if (!tz->trip_hyst_attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		return -ENOMEM;
 	}
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
-			kfree(tz->trip_hyst_attrs);
+		kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
 
@@ -469,9 +466,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -508,8 +502,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.34.1

