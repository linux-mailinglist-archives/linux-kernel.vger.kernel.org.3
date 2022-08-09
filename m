Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E158E2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiHIWHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHIWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD411156
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z12so15742428wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Eqqwo4NRGb/R9bBoEOfjhue5dvKyh7+jYOQsxqGgIDw=;
        b=gCX6A2tx7o8NoFJY2E6BFuOaDPkRZwyhkEfIyzPPhPe6lRI9IZzhsZ0yjdsYp3OVSq
         5iSeA+QXTmivT41Dujg6xQV4mLFQ4GzUEAttOI/uC/rQveyMZcv62dpPUp6SrYfaX1xw
         S1dSgVfZFLq8I0oqnP/zcoPtUZBf+tjbNo60ZHPTwf7ZleExN6R/4YALIVzpe3Npsc4G
         2JtcI5Z6UDBOFpsSIt9S59Hl4geGSWgiIahnGIoKIB1fi7wdmvEDwLfzB80E3mqvWaMv
         m10dh/QBC6IpXHGfsmnHJI69XMayMWwaiYDVJS3l18fUj6hXXuT7ruff03yeN9fIf4JU
         u54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Eqqwo4NRGb/R9bBoEOfjhue5dvKyh7+jYOQsxqGgIDw=;
        b=sZNG8prwNUUjP6gq+TNjh5Mu8OaouMgcPQLIxx778l5032mXWb7n6MZKvk1vMkR/nQ
         VJYgG0V+yova4U/XV1LkwH8+hcxQ8rmPB4zCIpiyEz4UlAZSCHI7dRLE8za3q4ttFadD
         5jmnVqqWSk102CQ+YId4F+rJKHKtAHDL+3/miaschL0cWWSH12gOOien1BRZGQsUIUUe
         OfxUVdTHFmSHyaWE6GGW5ZxXZOO2oCWDLclIlPXeMxv8oNhs/en5djz3C958LDfZNcpe
         lBKhdJq0M5QHSzuuNMSmVZjCI0nqT5UKvFW7Nn/heHdNN+wDqHOW53NGicS25PmxpwS7
         Dw1Q==
X-Gm-Message-State: ACgBeo2j7Gr1U7t7xEpGCC8FatJ1vXEJHJB2PKD+Gb1ra5iFMF3z475q
        /rbBCf4F+bBbK71cseYZQclMv8LSuggf6g==
X-Google-Smtp-Source: AA6agR5t39ShUXBViJRY98DvS3gz7FR80LPQwM0SjLsaErfQPdkRWDe+jlNV6zsYijg5Idwf3HUs4Q==
X-Received: by 2002:a05:6000:1d89:b0:21d:5655:eb72 with SMTP id bk9-20020a0560001d8900b0021d5655eb72mr15507896wrb.110.1660082725010;
        Tue, 09 Aug 2022 15:05:25 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 21/26] thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:31 +0200
Message-Id: <20220809220436.711020-22-daniel.lezcano@linaro.org>
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
2.34.1

