Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC758ACCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiHEO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiHEO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B9E67C97
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv3so3543426wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Senc8bpNjiv83Sbz3Ca1I9tfQhgHt9JTuHoug+IBfXo=;
        b=moHlw3HcEE9qhKhd5l0MPTAYV+/77KzH8sE+lxJwQZPLGjNYnw9+84iUs/JMRtspEm
         wL/B82BFqVtsQ3vHsWZpXxEfzhVuOcJ39ScloM7igxYSqIgdhUGV64UMS2kg4a4jL6Xc
         3zL2fAM4wxCIw85++FnO2R6rdSVXKSKPe6mRTZrDd9lzxwBhX9PPaZZABTJpApK5/sKE
         fc/1foX84bh1bypRT5s+qEqfj+JUbdj310vCmWQ/SmkCuOEK+Nv4TOKHZbh345GR7TlO
         LtOelXk+bgqB0Wf9vk+XjELNPU7s+yAHYsYapioIsFNfCMS2sO/OdlIIiNKd54ODN1Ab
         Wv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Senc8bpNjiv83Sbz3Ca1I9tfQhgHt9JTuHoug+IBfXo=;
        b=Nl6QHlR9+tbdFDqsgtIfjlXVIeq1NU8lROtvjGhgMgkv9saw7xttBS0fEwt/GH1C9L
         8SDnERDCdmvAeCvom7HIGlzpxD1RY8aPIZEOYfhzr1oxfqRDDqngj/XgJ09FVvNLquG3
         sAn/q+JrCqNoctkZ0b4EgSZkR6nKa3vltx4jGLg5H4iRQlRcXD+hAX9Vb2UBTdOBro8x
         y33w/tsU0S7GRGyAMofUG0HZ/fehchs4V2EtD5HssgpzIIXFdcysHtH6y4iZ1Whi9C0b
         KyXRXlKbL63LgtPN+CuR4F79ykN2iVzRcmDlbcKzU30w3cMoVsAMjncYKPXo1STeRVnR
         iSMw==
X-Gm-Message-State: ACgBeo0sLbcieBXYsJAFcj7GOOH323KEsKlJXoVZKHZVdAgZcyM0lWeD
        plpigFyURbSQmDJTGZJhaT2bjw==
X-Google-Smtp-Source: AA6agR5qzfQGvCOups81CoASboT5Zqvrk2j8BNnjcWA/4F99rnYL77DEDfDN1p+olZ69a65WVTGA2Q==
X-Received: by 2002:a5d:6acb:0:b0:21e:efd7:c7be with SMTP id u11-20020a5d6acb000000b0021eefd7c7bemr4675463wrw.293.1659711487907;
        Fri, 05 Aug 2022 07:58:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 17/26] thermal/core/of: Remove of_thermal_get_ntrips()
Date:   Fri,  5 Aug 2022 16:57:20 +0200
Message-Id: <20220805145729.2491611-18-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 04565746afbf..ed60b3be9082 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -143,13 +143,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
-int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 #else
-static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return 0;
-}
 static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 					    int trip)
 {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index c675d6b72802..f935bc157f89 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,22 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_get_ntrips - function to export number of available trip
- *			   points.
- * @tz: pointer to a thermal zone
- *
- * This function is a globally visible wrapper to get number of trip points
- * stored in the local struct __thermal_zone
- *
- * Return: number of available trip points, -ENODEV when data not available
- */
-int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
-
 /**
  * of_thermal_is_trip_valid - function to check if trip point is valid
  *
-- 
2.25.1

