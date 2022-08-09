Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F43A58E2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiHIWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiHIWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5DF5A0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so13986844wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=Wy4maNlOnCV1LXAjXjAfVgIJ2ZxBRik+aPTBw/K+HrfLwGp7bIwu96onm/TUyySd58
         3gADwckPF/GySG3UWIOjJb5iy6MruNbzk4F3LBRJXKhP/cTA8mMEqiaNEXqHejpWrvZD
         m1oVrtsfRksdUdaNGoUetwOM3pimQA0PaaYNn71tSSNck8oFExv94ORHcxbm8ADxuhDr
         zsgXFh1y5Is4yeghoijjQesHHHLzxlBACVGIcwPB1n2hjbSTon2CwfNZfIug8G0os8AJ
         U5Fvxdq2XmpY2DxKAOCOv+Rsrnf5t6ky1/pkfxzZWIJgyP5dx6jttJubFml9szv9hJ3X
         cKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=OiJ9UfhXIrtD3070zy9xZhMMXYLcbaqKSE5N5oW7IdWpR4GNTDDPljikNZcdLjupCw
         AUBjw+bXqjEzPvx4iZo24fVhBpAe3rPc/+/gXHYmB+/9qbr6wW8IJZ48/Rc7YwRLwWpz
         xE5JCdkDl6m5NMhfwKPG7yDe3OLjiT4BesO9nVMKzfbzSvX5AFyNiv0WRF0Bj0mP7GVK
         kSDzhHImugUg++Zbayh8MH2YzlWgkcs0AfGJ3CwBdoNkzo7mcpHUzix3+qSH0EQBmvwz
         DIrJxkfRbHTTB8wJaK7yG2Kn2v6Clv8MimQSggR5+SOZmi7chnATmJdS+AHjZtUvZch+
         fzLQ==
X-Gm-Message-State: ACgBeo2f6bGfOAB0T8MmJYtU0XwWpkryCWtJbritCLwe8C0vewmYExqa
        WCsNvXykjbE8uWlAKYXbwc+Cxw==
X-Google-Smtp-Source: AA6agR5VK5Ea8Uy76QcOYiWMc4YQbWMKjaVVyuFIrJ1I1u6uPPVBuyWR3KlPWTHIFpLpmFRpzJfrfA==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id v18-20020a5d6b12000000b0021f1568c7e1mr15438289wrw.532.1660082714324;
        Tue, 09 Aug 2022 15:05:14 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 13/26] thermal/drivers/armada: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:23 +0200
Message-Id: <20220809220436.711020-14-daniel.lezcano@linaro.org>
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
 drivers/thermal/armada_thermal.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 52d63b3997fe..9444e5a22ca0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -785,33 +785,34 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
-	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
+	struct thermal_trip trip;
 	int ret;
 	int i;
 
-	if (!trips)
-		return -EINVAL;
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
-		if (trips[i].type == THERMAL_TRIP_CRITICAL)
-			break;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	if (i == of_thermal_get_ntrips(tz))
-		return -EINVAL;
+		ret = thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			return ret;
+		
+		if (trip.type != THERMAL_TRIP_CRITICAL) 
+			continue;
 
-	ret = armada_select_channel(priv, sensor_id);
-	if (ret)
-		return ret;
+		ret = armada_select_channel(priv, sensor_id);
+		if (ret)
+			return ret;
+		
+		armada_set_overheat_thresholds(priv, trip.temperature,
+					       trip.hysteresis);
+		priv->overheat_sensor = tz;
+		priv->interrupt_source = sensor_id;
 
-	armada_set_overheat_thresholds(priv,
-				       trips[i].temperature,
-				       trips[i].hysteresis);
-	priv->overheat_sensor = tz;
-	priv->interrupt_source = sensor_id;
+		armada_enable_overheat_interrupt(priv);
 
-	armada_enable_overheat_interrupt(priv);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int armada_thermal_probe(struct platform_device *pdev)
-- 
2.34.1

