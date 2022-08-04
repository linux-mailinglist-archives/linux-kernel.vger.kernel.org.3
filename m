Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2258A389
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiHDW4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiHDWyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:54:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690672EC7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:53:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v3so1429386wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xUX4AQdo9GYJmtYjB+hfDgjJZM4lq/oFDHVqWDRlU7w=;
        b=OsYA087HggoOVIxGhpRtZt/GnLwNF1z+Q+oLgZ4Ingx+0fIGANLidXptXIYeXAD3Es
         aJfk5G8kwhFZcgS2TBdK/STTqiPa+YngQnqqdpyr5wKstqckYS59KB7UuXoVLjVdAlt/
         0lm6Se/D3cpF50+Dgr8h5utAJTFsrZb/bMHlRCcAzQxUKnD9qLdYAerlaJfyuWWzfuVT
         PtQ2nPNxfz9oM4+04oYlUMs59E1ATmMKxWQosifIRLG8JNflzyMuMQTfxlsEiGUKko5h
         mlqnMXc5sbDH7hNG/EuYDJeDSLCoXeDjIqH3Stw16ApAs17RRPshOwLAjv8f6P20Pm8n
         hcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xUX4AQdo9GYJmtYjB+hfDgjJZM4lq/oFDHVqWDRlU7w=;
        b=X3lSVV/njwXZWYsZomPcFx7gG7g++9OTBzmKy3PKTC8X4TItqh/pLGq199lXFZItG5
         cuKpoTAWTE3mHpCsBv8iJnDWiOX9ADftQm5lHMrlma1LIFhyJSlik6dAFcwRdr/wA0dz
         72EmGN7XjHj8a6ojHXm9CA7k2Zxwf1Bf7zau9KawF3QtmjaYL1H1q++bBYlih+0UYM81
         CExn4TAK2vUnwOqV/sCHBYA/ztso2Z/cwpIPnhp3SJvxYThSAPjgRSxxEyyy/KDlURXy
         yFuw3BkGmcjr2LBLFUpZz7NjITWoMkFZp47vuwqkylkrjNhWCc4ocaoFBpmkPN+A50HP
         7l6Q==
X-Gm-Message-State: ACgBeo339al0CazDiLw0E/XHtVTvW9MNclgNMZ9WNTEZSZ2FmGYqLpOm
        BycfN+YmgjL/1PBHYOOyfsy9Kw==
X-Google-Smtp-Source: AA6agR4bSUevL2Ruhn1zVM5mgDq9+HwcUAW2lcA6dLdUlzLdc2PrF29c7CQETsT9jN0w2yGEJDO5ug==
X-Received: by 2002:a5d:560d:0:b0:21f:1619:ba0 with SMTP id l13-20020a5d560d000000b0021f16190ba0mr2586639wrv.318.1659653589491;
        Thu, 04 Aug 2022 15:53:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:53:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v5 31/33] thermal/drivers/samsung: Switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:47 +0200
Message-Id: <20220804224349.1926752-32-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f4ab4c5b4b62..51874d0a284c 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -650,9 +650,9 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
-static int exynos_get_temp(void *p, int *temp)
+static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct exynos_tmu_data *data = p;
+	struct exynos_tmu_data *data = tz->devdata;
 	int value, ret = 0;
 
 	if (!data || !data->tmu_read)
@@ -728,9 +728,9 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 	writel(val, data->base + emul_con);
 }
 
-static int exynos_tmu_set_emulation(void *drv_data, int temp)
+static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
 {
-	struct exynos_tmu_data *data = drv_data;
+	struct exynos_tmu_data *data = tz->devdata;
 	int ret = -EINVAL;
 
 	if (data->soc == SOC_ARCH_EXYNOS4210)
@@ -750,7 +750,7 @@ static int exynos_tmu_set_emulation(void *drv_data, int temp)
 }
 #else
 #define exynos4412_tmu_set_emulation NULL
-static int exynos_tmu_set_emulation(void *drv_data, int temp)
+static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
 	{ return -EINVAL; }
 #endif /* CONFIG_THERMAL_EMULATION */
 
@@ -997,7 +997,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops exynos_sensor_ops = {
+static const struct thermal_zone_device_ops exynos_sensor_ops = {
 	.get_temp = exynos_get_temp,
 	.set_emul_temp = exynos_tmu_set_emulation,
 };
@@ -1091,8 +1091,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	 * data->tzd must be registered before calling exynos_tmu_initialize(),
 	 * requesting irq and calling exynos_tmu_control().
 	 */
-	data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
-						    &exynos_sensor_ops);
+	data->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, data,
+						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
 		ret = PTR_ERR(data->tzd);
 		if (ret != -EPROBE_DEFER)
@@ -1104,21 +1104,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
-		goto err_thermal;
+		goto err_sclk;
 	}
 
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_thermal;
+		goto err_sclk;
 	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
 
-err_thermal:
-	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk:
@@ -1136,9 +1134,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 static int exynos_tmu_remove(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tzd = data->tzd;
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-- 
2.25.1

