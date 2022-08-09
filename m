Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D458E28E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiHIWFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiHIWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8C1E00D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso126578wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=Q10d+Kj+4+QxPnASk+OFQkMzHet7iJEXepHq9lMZ/GsOjz41BKrdhSTNwCO1ITIyGG
         Ue/MRMgPagk/uraL1/ICfJGRDzXV4JR70963kdB41Il1yEQ7dq/KS44IFgWwLfgaxDla
         RluTYe88k6LbQ7tvibgpSEsxkwQiyvYndL7PHn+QrLSeRIeyLg8rbXXcQJngEIWKMWXo
         lIIh/BO2YztdinupBHIFMte1EZ4Xj9FS5MVkDpoB7SBIDyhGapYV6o7bsAjppxQu6pZL
         4IJVGhg1X+5E5OGdBCM2aL1nJ9xetphQ/m9YcSwcMYJEb/t3d2URg77u1CyeiQRvM2cn
         IJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=hUMpZaOSmap3hQ+shynJMrph68r1viUVPgp3+EasRDgC97gTgYqiLz+cbuSiXEx1R/
         2Z2eKQa2w9GLyiD70EQyMSHQxWeWzphrKtix/ka9IPXObuBL+a94VoFHhpgw79lSieWj
         Ol2hpRU321GHYimVn6pTsZKSUDS7DnQSRKfQ+7lwfYTJEahruURK+LnO1y7FLGcxEbSa
         f4g3xtOqJohtRbUj+ot37LrVJhVU22fMpWBugtFzT5tr5wp3sV3s1lXq3B4OHp9IhoH5
         OSAiwqj3hWkEsO3f0T85IHEpr4m5jIYLYqNKVF1p13xiW0IrHFgOUjmkAdhDKbEql9i/
         qZGg==
X-Gm-Message-State: ACgBeo2qctQnifP83KhX3etBfh5xfrSLucK7FxLecDwte0lXTYFO58XJ
        okSMQSCFQhhnfEMQvdDyfVAD72xg/VDjaw==
X-Google-Smtp-Source: AA6agR5CO+KUXGsg/6WoplZ/mFRti+YTNqdCa1P1PXUwBEm6Au6L8KxbMD6+x5Sb8PTDWwU5FoVH9Q==
X-Received: by 2002:a05:600c:3b02:b0:3a5:2460:f059 with SMTP id m2-20020a05600c3b0200b003a52460f059mr266889wms.129.1660082698606;
        Tue, 09 Aug 2022 15:04:58 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:04:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 04/26] thermal/drivers/st: Use generic trip points
Date:   Wed, 10 Aug 2022 00:04:14 +0200
Message-Id: <20220809220436.711020-5-daniel.lezcano@linaro.org>
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

Convert to the generic trip points

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/st/st_thermal.c | 47 +++++----------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 1276b95604fe..c0d45cdd1c2f 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -134,48 +134,12 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 	return 0;
 }
 
-static int st_thermal_get_trip_type(struct thermal_zone_device *th,
-				int trip, enum thermal_trip_type *type)
-{
-	struct st_thermal_sensor *sensor = th->devdata;
-	struct device *dev = sensor->dev;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "invalid trip point\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int st_thermal_get_trip_temp(struct thermal_zone_device *th,
-				    int trip, int *temp)
-{
-	struct st_thermal_sensor *sensor = th->devdata;
-	struct device *dev = sensor->dev;
-
-	switch (trip) {
-	case 0:
-		*temp = mcelsius(sensor->cdata->crit_temp);
-		break;
-	default:
-		dev_err(dev, "Invalid trip point\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct thermal_zone_device_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
-	.get_trip_type	= st_thermal_get_trip_type,
-	.get_trip_temp	= st_thermal_get_trip_temp,
 };
 
+static struct thermal_trip trip;
+
 int st_thermal_register(struct platform_device *pdev,
 			const struct of_device_id *st_thermal_of_match)
 {
@@ -238,9 +202,12 @@ int st_thermal_register(struct platform_device *pdev,
 
 	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
 
+	trip.temperature = sensor->cdata->crit_temp;
+	trip.type = THERMAL_TRIP_CRITICAL;
+	
 	sensor->thermal_dev =
-		thermal_zone_device_register(dev_name(dev), 1, 0, sensor,
-					     &st_tz_ops, NULL, 0, polling_delay);
+		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, 0, sensor,
+							&st_tz_ops, NULL, 0, polling_delay);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");
 		ret = PTR_ERR(sensor->thermal_dev);
-- 
2.34.1

