Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C58E2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiHIWHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiHIWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E99DFC6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so15764253wrf.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sBYa4Rhtbyvq+yIdiazGYXFIbq9Mwdu4iyysvjHUIN4=;
        b=mEX3xTvfFlN0NV1z/xNRux4lUTX5w7XjFn0/jm7NWAOE6isEbikoTlNpysc7AdceU8
         EcGs71KybDrzC7iHrsMpao2m8tNXmSE2GivlJJ3jAmblj9CpFyB26pkbdu6O3nG1qAV/
         YhlUlsG2MgRgHACjx3ZySwVBY2d4Kwky1mpbfU5l/86F0X/a+/uEMPg+GXL4Tcavyavn
         fZElqmE8FCRhbNrZap5z7e//BH0fj3kzuQ7ymUvK1DrwLV7CGaEogg1X7TwT0F3l3BrI
         UZQl1xVISD+dmfEnIdw9lajBsCvfKALErTBjvNzXHUW2I7HGRqS/012czxq/BHP/95Wy
         L0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sBYa4Rhtbyvq+yIdiazGYXFIbq9Mwdu4iyysvjHUIN4=;
        b=TzGce7dUgOVsPhFbF5M4LqR6jiV/AfbFOxMLQJvjUmaHi+n/sDHetX/nf6PYhiwwbv
         zr7RfSIHjREMT2TKTSJZV9XkOJyF0IjT5TD3t5XGa93q0VSkkvw+lJOzCWDqvHvzV3JW
         gzEKfv/6UZxZ2q0FUkq3M3ovOx8daiC+Dp32xKjlV0rwoCDQcP4LzXEnMq75TPyJogHj
         8kHtVYQd6udJp8xoiKQwYzr6/920B2tThdN2pGTDp4oQDDbMnhIuDKhiGFm07bQfe64M
         ieu0R+iC6B4oI7+mmgQJrF6azRkPrHk4dxDYQ/gnz+xnMrPUnFu+yHZp3FVCa7xf1iIB
         77bA==
X-Gm-Message-State: ACgBeo29BkDhlIcEk2wgDwKmUXOQVIIv7yrNxWWsC49c/eeV0QIYlMYQ
        pWuRHMHwasMOdpUnnsvPLk+/gA==
X-Google-Smtp-Source: AA6agR7xH6WppoqE1kaWBqcxMOWRBv4HmMyJqcF+ejWZ5KwQd7WWsQhSatAYRK+3Q08IiH3qghHtSg==
X-Received: by 2002:a05:6000:188a:b0:21f:c4c:8368 with SMTP id a10-20020a056000188a00b0021f0c4c8368mr15842851wri.299.1660082720826;
        Tue, 09 Aug 2022 15:05:20 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v2 18/26] thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by thermal_zone_get_trip()
Date:   Wed, 10 Aug 2022 00:04:28 +0200
Message-Id: <20220809220436.711020-19-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ac47c716c1f0..9def8c76ef9a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -552,13 +552,15 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_trip trip;
 	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
 		for (i = 0; i < data->ntrip; i++) {
-			if (!of_thermal_is_trip_valid(tz, i))
+
+			if (thermal_zone_get_trip(tz, i, &trip))
 				continue;
 
 			interrupt_en |=
@@ -582,13 +584,15 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_trip trip;
 	unsigned int con, interrupt_en = 0, pd_det_en, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
 		for (i = 0; i < data->ntrip; i++) {
-			if (!of_thermal_is_trip_valid(tz, i))
+
+			if (thermal_zone_get_trip(tz, i, &trip))
 				continue;
 
 			interrupt_en |=
@@ -613,13 +617,15 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_trip trip;
 	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
 		for (i = 0; i < data->ntrip; i++) {
-			if (!of_thermal_is_trip_valid(tz, i))
+
+			if (thermal_zone_get_trip(tz, i, &trip))
 				continue;
 
 			interrupt_en |=
-- 
2.34.1

