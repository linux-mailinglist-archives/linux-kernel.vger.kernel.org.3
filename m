Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8103054EB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378712AbiFPU0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378602AbiFPU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:26:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA055C67B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:26:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u37so2438476pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnWdYySv2ElBW0uBlpDoztzyY1ZcO3tTNMTwxgds8HI=;
        b=GnUw6jIKy4VvUtAq6JRtA9tnJe2f9luRge04oe2c7BWHg2z+hxBLeGxTpo5UKooudC
         Spt5ziAKqtAQRNkf8CC4TNxZKN+emqORto/IDLLduVzH6ifZH/nRCFDTtoBtA6tqhZ3n
         OybU8GqnJ7ui2k2yjRWJGywen8bXJo99pybWGtUb33KuNybF1yr0CJCglkh+CU52NBAe
         j97wMsRB2ASdyFtx5zVYVM6rS7jRLACT7iuCver9VZotiUr6d2wxYMCeUhwwo5yJEA9X
         RzdjgHIqZNuws7JjYNBb+eheHkdw40mfMPLLY9B+EiQxx4CrPLOCsv26RtbO7/KCglhR
         gBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnWdYySv2ElBW0uBlpDoztzyY1ZcO3tTNMTwxgds8HI=;
        b=0l8Cl97z5dLEK8Gu9IBDATBs3cEx8MPjQvk/+kKKYp7UD3X7Cq9VPKD1if0q1j/cgf
         Tau/o5vA3rnjtMpa/7RtRhfIHTAzwrt8B0GFmaGLHMXRKLAL4tDn5o/Mir9CaYe6rYms
         iknTcfoQH5QPkjYYM3vNqmPGzkDuBdvUYi2RISjn4YadvpJIBAbMK076TeSiKraWBDqQ
         Jq742VDZMSDUn3fsGSUuooF68z9cOvtd09pQbVOQsXsVMtZ0lt0vWNy6FewyNr1XmmD5
         YH3AlJMRSzGEdJ8+anuDfsI5UbBqN16Q+tgX5uD/w11VnVT2nL1dVJNemEkmRU5EMEHT
         k+/g==
X-Gm-Message-State: AJIora8Zi52vN/b1yypGojm0IEp/c3cTZJLpZ2Qg2OQ0M6gW4htox5p6
        1T+QTEXWVW1XJ3JyBZpJ+evfVg==
X-Google-Smtp-Source: AGRyM1v6ATZDbmHo1v8ebjcpZanCb94Ax4IX7JfyHmqaHedp3fccRz2rZtv8sHSrbAmiYg4dYmQzPw==
X-Received: by 2002:a63:8ac2:0:b0:408:a936:8cc8 with SMTP id y185-20020a638ac2000000b00408a9368cc8mr6020293pgd.343.1655411161592;
        Thu, 16 Jun 2022 13:26:01 -0700 (PDT)
Received: from mai.imgcgcw.net ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id a5-20020aa79705000000b0051bb0be7109sm2182960pfg.78.2022.06.16.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:26:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
Date:   Thu, 16 Jun 2022 22:25:37 +0200
Message-Id: <20220616202537.303655-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616202537.303655-1-daniel.lezcano@linaro.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
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

The get_trend function relies on the interrupt to set the raising or
dropping trend. However the interpolated temperature is already giving
the temperature information to the thermal framework which is able to
deduce the trend.

Remove the trend code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 21d4d6e6409a..ed40cfd9ab7d 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -53,7 +53,6 @@ static const unsigned long db8500_thermal_points[] = {
 
 struct db8500_thermal_zone {
 	struct thermal_zone_device *tz;
-	enum thermal_trend trend;
 	unsigned long interpolated_temp;
 	unsigned int cur_index;
 };
@@ -73,24 +72,12 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-/* Callback to get temperature changing trend */
-static int db8500_thermal_get_trend(void *data, int trip, enum thermal_trend *trend)
-{
-	struct db8500_thermal_zone *th = data;
-
-	*trend = th->trend;
-
-	return 0;
-}
-
 static struct thermal_zone_of_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
-	.get_trend = db8500_thermal_get_trend,
 };
 
 static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
 					 unsigned int idx,
-					 enum thermal_trend trend,
 					 unsigned long next_low,
 					 unsigned long next_high)
 {
@@ -98,7 +85,6 @@ static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
 
 	th->cur_index = idx;
 	th->interpolated_temp = (next_low + next_high)/2;
-	th->trend = trend;
 
 	/*
 	 * The PRCMU accept absolute temperatures in celsius so divide
@@ -127,8 +113,7 @@ static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
 	}
 	idx -= 1;
 
-	db8500_thermal_update_config(th, idx, THERMAL_TREND_DROPPING,
-				     next_low, next_high);
+	db8500_thermal_update_config(th, idx, next_low, next_high);
 	dev_dbg(&th->tz->device,
 		"PRCMU set max %ld, min %ld\n", next_high, next_low);
 
@@ -149,8 +134,7 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 		next_low = db8500_thermal_points[idx];
 		idx += 1;
 
-		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
-					     next_low, next_high);
+		db8500_thermal_update_config(th, idx, next_low, next_high);
 
 		dev_dbg(&th->tz->device,
 			"PRCMU set max %ld, min %ld\n", next_high, next_low);
@@ -210,8 +194,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	dev_info(dev, "thermal zone sensor registered\n");
 
 	/* Start measuring at the lowest point */
-	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
-				     PRCMU_DEFAULT_LOW_TEMP,
+	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
 				     db8500_thermal_points[0]);
 
 	platform_set_drvdata(pdev, th);
@@ -232,8 +215,7 @@ static int db8500_thermal_resume(struct platform_device *pdev)
 	struct db8500_thermal_zone *th = platform_get_drvdata(pdev);
 
 	/* Resume and start measuring at the lowest point */
-	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
-				     PRCMU_DEFAULT_LOW_TEMP,
+	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
 				     db8500_thermal_points[0]);
 
 	return 0;
-- 
2.25.1

