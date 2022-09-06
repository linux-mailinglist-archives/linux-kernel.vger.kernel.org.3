Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290C85AF18A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiIFRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiIFRAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:00:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9ADF1E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso7817476wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ffj/+IgRhlrRkOtYFWbfnlVsquqreXwCxJyvoKvBP5M=;
        b=W6OowTe7nX5Tu83zZ06/DlToCVod/nz1UmaXYt1n0TdoeHsLqBI4Dtsi4GhqPZP8GV
         f7AMVFRH25AMn8/j+KocZjyvK/QWuUsQQMlpFm2r7askDFLpphuYA2MskzfvLWHcmwTR
         IsLEE67H0SnejCnIXovCYTRmda0ZNSkek5LMMWHnR4+EOhGU6St7o15zAVWSNySEtu/k
         rSc3myDJaPxa5xJjmcADoTci5TJWlsqxdmHrRtd0Q2XX5hie1ZJkoZ4FcnjjcKrTGjxl
         qslGA5EYksVxR9ugcFenjaEkwCriSe2bNHkfoMo0tCftIlZ3Osk9uq3GuMuikmwF6hLf
         EasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ffj/+IgRhlrRkOtYFWbfnlVsquqreXwCxJyvoKvBP5M=;
        b=7gzAf8/7d77cslNgRA+f8PDfyoqLmMyn9WvkzpatS8d3we8dcRfoyfJUFUdg7YfyOK
         mBXWO/LJb8Nwt7c+8PGKx02qo3IOkg6Ft0IvOE+bywM2x8dBFSVBwLjYuPLR2z//ZCmh
         fD2Xg90gGIdiXfFPY4j3qiKp01YZ9MU30TYheYClHbmIWcA/BxEg+2rvoiTtsvaW14X/
         X/9WVQxoO/mBtxJFOIO9aVLTnYZcr1GlFux40m/NVWhjZAtt6EgtVdNgL51K1WT2DkX2
         iEqSaJcH/3EyXgzgrrgO/9Us0Z8as2Q9/FjD/H73UCblX56LM1nYULjnl9GIJ1l7yU2w
         PQHg==
X-Gm-Message-State: ACgBeo0QJ9N13rHom5qZaNFuf/kprrp0zs3Wqr5EIn0oKLP7NgONyI3B
        6iCkn30aufw0akxK5BG7eeONww==
X-Google-Smtp-Source: AA6agR6qJr5AYVHcV76y6t8qEWii+bNh4lhZPz7VLjl4bBuOCz5W0Lg7wxRDpy26vsY+GTX5K7BuGw==
X-Received: by 2002:a05:600c:35d0:b0:3a5:f7ee:82be with SMTP id r16-20020a05600c35d000b003a5f7ee82bemr14267865wmq.206.1662482867071;
        Tue, 06 Sep 2022 09:47:47 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v3 08/30] thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:46:58 +0200
Message-Id: <20220906164720.330701-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/samsung/exynos_tmu.c | 41 +++++++++++-----------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 51874d0a284c..0e33d32a9d2e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,16 +260,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tzd);
 	unsigned int status;
-	int ret = 0, temp, hyst;
-
-	if (!trips) {
-		dev_err(&pdev->dev,
-			"Cannot get trip points from device tree!\n");
-		return -ENODEV;
-	}
+	int ret = 0, temp;
 
 	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
 		ret = tzd->ops->get_crit_temp(tzd, &temp);
@@ -303,19 +295,16 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < ntrips; i++) {
-			/* Write temperature code for rising threshold */
-			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
-			if (ret)
-				goto err;
-			temp /= MCELSIUS;
-			data->tmu_set_trip_temp(data, i, temp);
 
-			/* Write temperature code for falling threshold */
-			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			struct thermal_trip trip;
+			
+			ret = thermal_zone_get_trip(tzd, i, &trip);
 			if (ret)
 				goto err;
-			hyst /= MCELSIUS;
-			data->tmu_set_trip_hyst(data, i, temp, hyst);
+
+			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
+			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
+						trip.hysteresis / MCELSIUS);
 		}
 
 		data->tmu_clear_irqs(data);
@@ -360,21 +349,23 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 }
 
 static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+					 int trip_id, u8 temp)
 {
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(data->tzd);
+	struct thermal_trip trip;
 	u8 ref, th_code;
 
-	ref = trips[0].temperature / MCELSIUS;
+	if (thermal_zone_get_trip(data->tzd, 0, &trip))
+		return;
 
-	if (trip == 0) {
+	ref = trip.temperature / MCELSIUS;
+	
+	if (trip_id == 0) {
 		th_code = temp_to_code(data, ref);
 		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 	}
 
 	temp -= ref;
-	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip * 4);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
 }
 
 /* failing thresholds are not supported on Exynos4210 */
-- 
2.34.1

