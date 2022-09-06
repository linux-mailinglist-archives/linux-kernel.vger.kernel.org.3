Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B95AF1C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiIFRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiIFRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:01:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CE95AE6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:48:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so8443995wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kNTESOeVOVH9BHNMsa7BlHA2jeppHM3L2UNE800z/X4=;
        b=T/MiZX+s52gnVr1Qtivo5WE2IHoCStCwlt9AgGfbSquQ1ErxcOGXn5eUa/PRZimxpx
         x2ey6PBEXkC6K0FQP0SchxWsOyZ+UkWpEIL+7JQ7rb/2KX+8k209BiujtG4fJMrXlAY4
         yOGuY1hzvKsI1P+j9EETkPGcmkPNBoSHTFI0a7mKKG3Ba20M171pHm4b1IVTz2kyMl1n
         prlRNByKHxsYjwKiOcuw+6462rkUPuwhiLbhDv4iaGZoDQBQz45OM0d8yeWb4hgOmW30
         m/Lh8fXaFbrhNm2jTWTcv3227Y9gPm3HrAdGifBoiBaC1JeqpG0uknsZxWDFJLMzJwcq
         gHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kNTESOeVOVH9BHNMsa7BlHA2jeppHM3L2UNE800z/X4=;
        b=Xil7g/wR5xM/bZEhBhG2Y/sM6ejdT5kxBKTp7zjZzvbwFdDxt7X2sk0VWAUrAy4pdF
         0w8ltq6Q+tW/Kk0SjqITU84wJW3MkF0PFE5nf3AQ4CI9wmdlgL0zPKF0mEAe3pPaUFX5
         NBqPojNtqeTL69VKwwunGSnkSZOps+2SRI8j9UHmqbMCzod5XbGdoceE4/0C3j79KLkh
         STEG3RH+bPofj6kwyhHGxMC3YYnT/38mryYPw6KIovimoMm/wgn6dakflEQuec0IIMOp
         oDWIU6tEAEU2DUrRb+xKlUg6KPOPmjcVF3BO1r2pTCS0W+K4aixTl1w7gCBWWWidVVIm
         fjMg==
X-Gm-Message-State: ACgBeo0P5bYvxIDh2h8D9+vasmZcFwvaqq0pqdllLg6ynOTpjcmdbrCz
        WzaQWZvWeIpK6xEl6IEFD+jDTQ==
X-Google-Smtp-Source: AA6agR7fexFPp/KtQLXMbVzbtku8KIH4pfBqYbxr50g74IjIv1DzKpyZcAEN5f8957Ep4F5BPyttMA==
X-Received: by 2002:a05:600c:198f:b0:3a6:2482:b2be with SMTP id t15-20020a05600c198f00b003a62482b2bemr14574196wmq.110.1662482889185;
        Tue, 06 Sep 2022 09:48:09 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:48:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 25/30] thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:15 +0200
Message-Id: <20220906164720.330701-26-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
 drivers/thermal/da9062-thermal.c | 52 +++++---------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 180edec34e07..1e163e90d6b6 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -120,44 +120,6 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
-					int trip,
-					enum thermal_trip_type *type)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_HOT;
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
-					int trip,
-					int *temp)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*temp = DA9062_MILLI_CELSIUS(125);
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 				   int *temp)
 {
@@ -172,8 +134,10 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 
 static struct thermal_zone_device_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
-	.get_trip_type	= da9062_thermal_get_trip_type,
-	.get_trip_temp	= da9062_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .temperature = DA9062_MILLI_CELSIUS(125), .type = THERMAL_TRIP_HOT },
 };
 
 static const struct da9062_thermal_config da9062_config = {
@@ -228,10 +192,10 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register(thermal->config->name,
-					1, 0, thermal,
-					&da9062_thermal_ops, NULL, pp_tmp,
-					0);
+	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
+								trips, ARRAY_SIZE(trips), 0, thermal,
+								&da9062_thermal_ops, NULL, pp_tmp,
+								0);
 	if (IS_ERR(thermal->zone)) {
 		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
 		ret = PTR_ERR(thermal->zone);
-- 
2.34.1

