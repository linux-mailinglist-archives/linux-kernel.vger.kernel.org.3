Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB658ACCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbiHEO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiHEO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9466A48F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so3576640wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DG+K25Dz9R34xfN5Ar0nLGWWJfDYYYS3htf7yb1wx+8=;
        b=oBDUr0R8/1lvoCmy4GqKH15o2VrHjasQtT4ti/HoiKbtkyVUHY+Y2f4/ANmh2I1JB6
         i10cMYDReAzyHSD6+IR+iO6sgBdyX5C5ROQ0VWCnqKYKDk+kPhy9keHkTqWCLOWVTRWa
         eOR2oM0jRXxAG2khP7O+l/vxjaU2rMMVg9et+RYrKOreC0BzuD7SjeYD8w8j2WE3sM5Z
         nmi+DAu4rNuToA6QXd5hK8reOGQTBakdKcoo5FsmHwlEQmwKw9UtAnAhjoPl0JOZNI9J
         D0IYfUfCU1FIuff8BkUek0JjddYX0N8oMNSIHojOkSnl99NOZxWYQZb3pATyNaWp5tw2
         nXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DG+K25Dz9R34xfN5Ar0nLGWWJfDYYYS3htf7yb1wx+8=;
        b=Y37SoRf4ZW54QxAZBF2xUiDjD2nVoKZiwszwPEa/6YOE2bWPmwyOi7443elxUh/cVk
         0vj4YFxs8wiBb095gO7PolItuOLBtmK6w9+iGeysjTb3d+/hxbSGto8PsVdheG5VY9Pj
         yXBhK4hjkfw2vYauTmDDy5CoAr9c4/NsKVdxWx2El5BE+2ZXy1vipHQwxopNB18dmKMB
         oLAfYCWx9UPlh9VZhzjpaU9VpyA9PmDhfNZ+UkyzifeukxV059bJ5fDW2lWzmojTcFGX
         oQ5qAhohOIPteqdeVP4PtW2c2ou+9IyLVszcXIl4/CsP98vj5Hbl2iHcBFdCd5/tW3zZ
         phyA==
X-Gm-Message-State: ACgBeo0/CulhAIatDqQIpWLzpxBqN91xDVQMOmDwsRIlqA84QPq3ksfy
        Nz7GOpPlzjlWkFXQZb4pBq297Q==
X-Google-Smtp-Source: AA6agR6BTlR50DdMZ7FX3cLnpFq9tLDWFgmqAjnzRAQp5JOaXwtDZUdGknaS4k4gKzjfocQ62MNAqQ==
X-Received: by 2002:a05:6000:1092:b0:21f:13e7:3cc with SMTP id y18-20020a056000109200b0021f13e703ccmr4875923wrw.671.1659711490692;
        Fri, 05 Aug 2022 07:58:10 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 19/26] thermal/core/of: Remove of_thermal_is_trip_valid()
Date:   Fri,  5 Aug 2022 16:57:22 +0200
Message-Id: <20220805145729.2491611-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
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

There is no benefit with the of_thermal_is_trip_valid() function as it
does the check the thermal_zone_get_trip() is already doing for the
sake of getting the trip point.

As all the calls have been replaced by thermal_zone_get_trip(), there
is no more users of of_thermal_is_trip_valid().

Remove the function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 10 ----------
 drivers/thermal/thermal_of.c   | 19 -------------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ed60b3be9082..b66e12f49042 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -142,16 +142,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #endif /* CONFIG_THERMAL_STATISTICS */
 
 /* device tree support */
-#ifdef CONFIG_THERMAL_OF
-bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-#else
-static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
-					    int trip)
-{
-	return false;
-}
-#endif
-
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
 
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index f935bc157f89..afc17712efc7 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,25 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_is_trip_valid - function to check if trip point is valid
- *
- * @tz:	pointer to a thermal zone
- * @trip:	trip point to evaluate
- *
- * This function is responsible for checking if passed trip point is valid
- *
- * Return: true if trip point is valid, false otherwise
- */
-bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.25.1

