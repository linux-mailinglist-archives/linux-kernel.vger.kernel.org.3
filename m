Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB158E2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiHIWHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiHIWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C011A38
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q30so15718924wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mcqvl7P2tMp4cqPIcszOgPsr8Wnw9dXPIC7QNOz6O1k=;
        b=rxs/j6Ljj8ksqZlbC1OXmElheN+CD/HJDdaVUj7PCZMQthx1c4YA04gd5tmlApW7zo
         Yd8Z2FyWM79/A7lEgTA3wNeJT1VCATFBMN+YYY9lo/PFIdfhCrMHbfLMA8K7FKzYz614
         SbGrciKxomvM4vDJiapLS+eyEqGwFwkiWKp037oVIyvwZI10N8OuugwCDptt4+cg8/PW
         d9GjQAcjFAwRVxIfa1mUA80sM97utX0C6oTuOZvq14owAIRbSnObl+6hRhjgJQPG4Fm8
         3RoHVxPj+pU+pUIDdsGNtOU4LpG5mqShOm0kVIHjcdhkZKK530p6mrmLwWP72f5OUYjw
         4p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mcqvl7P2tMp4cqPIcszOgPsr8Wnw9dXPIC7QNOz6O1k=;
        b=zkjMY7q/o+UEUea6q/ERjrcXoR/l0bAo6GHi1WOkBvpbbvO2nMPnH6XOQCjES/ngn8
         5S96G2FWe7fvOR7PyswDbB6RcSup8InHqt3yI2pbsKauy0CNnvvwo9ceGCmvVdnJ25gY
         dR1m8SUmfhh+EgNYO0CkEIS1Tyco7GRLkNGeddTKcV3vpc+bzlMoCWRCI/G5B274bkOZ
         kovCPrWW6umyyfTjfw6NGna5y1SMiKemin9i5Z/zAi0uLFdgQPTDehXd8taqXYm+1AKB
         pkz0WAkjJgEFTEPtWbsjgchDULarOsu040fIL9K5rvchxuHFfAlQlit+nJQGLM+iS2GI
         Dn7Q==
X-Gm-Message-State: ACgBeo2886ucNG3YTEPlxMDul8gN1o+ZwuHKVufO7FNmHaMrgmIQaK+4
        9doRl8eo0TlmV4FiM1p2iw41hA==
X-Google-Smtp-Source: AA6agR4CIQYSMIXd3v7taFCva4wBjJNAsuhGFodu7kMgNZ2iX2ej1pAoGMZreaLYcxRxEio3bAXxRA==
X-Received: by 2002:a05:6000:1f1d:b0:221:6c4c:4995 with SMTP id bv29-20020a0560001f1d00b002216c4c4995mr13971265wrb.675.1660082722036;
        Tue, 09 Aug 2022 15:05:22 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 19/26] thermal/core/of: Remove of_thermal_is_trip_valid()
Date:   Wed, 10 Aug 2022 00:04:29 +0200
Message-Id: <20220809220436.711020-20-daniel.lezcano@linaro.org>
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
index d1208b196b21..ded7ea2fc794 100644
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
2.34.1

