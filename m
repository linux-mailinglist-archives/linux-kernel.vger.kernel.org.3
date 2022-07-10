Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66656D1A5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiGJV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGJV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686111707A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v14so4766957wra.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3V7lM+PKZJPdGAry6EvNSx9MSPO4LjJsX3vGmcJ/BA=;
        b=yxc/oK5aCS5ms9I4RGzuBdlDYggoOliY1mPDU5jGMNF+Dh5GD0GI9yiVq3ABuGHmiV
         nXUrW7TnrhbILY2eDD1HNzbE6hA5CeZanwEpTTAK0tUI9Je9/1acxJBcublaoGRM7u2v
         YVkJ5kGZQ5dRt9qhoFjH1JEfUelWCO7nMJAHzT+jMdLr4TAQzt1j07Dn4lMGV0FgWe92
         I380FR3XUSXrIo17u2ZJv4mrm/r0F4vODAwe16HfthyjX/u6QRfRasP8bv38K0K+s7hj
         Xl3umzSOtQHX33AR3ZwHOu2JWWXyRsgrOWD2qoeebdFqUoDT6Uxuc8eF4hlkfEznhktk
         IHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3V7lM+PKZJPdGAry6EvNSx9MSPO4LjJsX3vGmcJ/BA=;
        b=Tw0virTUjfFktI1BrPwUk6EDeI/RNdGF2a803BoB5F16ibvdVsRLhCWh5fdWZi98l2
         3vzB5sIf/xMu1u49ft2NGiIg58Q/7RZ94UGQNu0TuYGcH0wsCjTyigtM19+PpV02E4pX
         +rzCnCUyQf2SZWP7mlq6eyF75EykuxsCfOGCqsbyPTg1aJgMmgwLHnxKGRFIR8vQhMHm
         g6TUgDu9tSqSme+y+OFl5Svzy1n0Akv+g90hA465vVGaWQCNJJMkwzjNgeO7V2+BFaoT
         I2BhZUI0Vip7uFk9MnIjUu2zjZcD6RlIjYk795WEiatW4nshARKmTzxbDSXjqIwBnnTP
         6chw==
X-Gm-Message-State: AJIora9mSscVNtDwNQfFvVz/uv8k/HF4rtdm0b/On8LMlTOTa868d0ts
        10KvDBi4/I91r58P2FT8lcZDgw==
X-Google-Smtp-Source: AGRyM1s2ZmJIzs6aaXoZTMV85jwGiiSQla4rOuyky0RhtFtwMDQH+ChBIvuZQm2m6YWb4dYKfZRzQA==
X-Received: by 2002:a05:6000:1d1:b0:21d:6673:9894 with SMTP id t17-20020a05600001d100b0021d66739894mr13927211wrx.640.1657488326338;
        Sun, 10 Jul 2022 14:25:26 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v1 31/33] thermal/drivers/samsung: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:21 +0200
Message-Id: <20220710212423.681301-32-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f4ab4c5b4b62..2bd7b3b57b28 100644
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
+static int exynos_tmu_set_emulation(struct thermal_zone *tz, int temp)
 	{ return -EINVAL; }
 #endif /* CONFIG_THERMAL_EMULATION */
 
@@ -997,7 +997,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops exynos_sensor_ops = {
+static struct thermal_zone_device_ops exynos_sensor_ops = {
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
@@ -1118,7 +1118,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	return 0;
 
 err_thermal:
-	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
+	thermal_of_zone_unregister(data->tzd);
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk:
@@ -1138,7 +1138,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
+	thermal_of_zone_unregister(tzd);
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-- 
2.25.1

