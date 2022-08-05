Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102058ACD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiHEO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiHEO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16D6D543
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so3521067wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PImRJTT8zs0oIpM2evdWHVSde+hTXl/M4vFOcqlQbmQ=;
        b=AqT1WgxHm8fBw9YYLR9Hlqe2zAKgmgWFxmR1J7NYMR9Zy74/c/k3G0UZA+uPSjNGL5
         aCkpzu/wLBRGitr5nPAb/RWb48VrD6U5bW4ZVadhD+4QzZQcGXNwP8CpcKGjazelJ0yd
         emzJ2gb28bcTDWLW03p9/7dvuDE6mf/hk54KcCVjy2ctiWpTIUqMQBs1cOOqRdXAjsol
         pZ0SLR4eEh5WHFT/B9ftuPbf3lwjWzp/zqKnx6g9SpWBxSFu8eZldRlmAJW+vWP7C6c0
         3yCndj1x98qCQ/XvT307fQEkAidVz5Rn1e+kl1vkzFkWn9S9+6ZPU71MhFBoUfJWgm4w
         2d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PImRJTT8zs0oIpM2evdWHVSde+hTXl/M4vFOcqlQbmQ=;
        b=izDMKx8vnWdkEmByJcrAyJgmn7KDpfZuF5TFtuOf/BKIw44pDDb2BkI2HU0LUvYgph
         KlCfjZrLStWAWktbmUDzEpjucx37x2F3sm9EZH3nnDCiNNBdt80J90uTTZ3kJ8jPkMgf
         eXPd8U0p4kYK1dEu2tzKFlZwvzqiAXzGA0FmHDIh+BcmrgRY9E8I04GHH8HfwyVvb+kS
         7tOjsBILrwUkPAcYBZZvHVBNjf+lR/6bST7QLQZBWWSevWoeK9oDNnSB+tM0AUBw3JnJ
         NN6HAMvtsCbYHXWZuOQlmbOEwKARucZ5pi5+XYzGkUkP7hRO39ayUBWY00SGV4Au2An7
         Eq0g==
X-Gm-Message-State: ACgBeo1Xk+dq+VqKGmIfbtbUqMv0e+shetBgnr4zcItJ4r48qppK/+EH
        qvBm4UGlep0Ok/CTZpKH/Pc3kw==
X-Google-Smtp-Source: AA6agR6UlwCu/D0lPBaupJTGeqKV3LwNn9dvU2lghGb4PjgBAeFOg6ik6VX4Gpue4J/T6g+M4iufXg==
X-Received: by 2002:a05:6000:511:b0:21e:503e:d964 with SMTP id a17-20020a056000051100b0021e503ed964mr4627748wrf.306.1659711494257;
        Fri, 05 Aug 2022 07:58:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 21/26] thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:24 +0200
Message-Id: <20220805145729.2491611-22-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
2.25.1

