Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214752762C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiEOGm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiEOGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:42:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1E2DA93;
        Sat, 14 May 2022 23:42:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y41so11286373pfw.12;
        Sat, 14 May 2022 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4Q6w6yEvGwJK0TRipYAGtfiK43Dmnd3tJ7ygkkWia4=;
        b=IOLCGdIAmm3LunK3vBZkd/zL03BzIKvSMk+Utas+4Rbjc1kgqSnZVisi+yBAvrPSDX
         y/Rykv02QICz7x6MMGfUNDMjOAi4QyP4CLjK2VAtFwUkiLT3BX177/DXaBBSNwn+3pqJ
         /0ff8f8msGQ6Vt+K0aLeKn6GW8pHmSYYnpdjnAb62dJmQvKUMfH2MLQ535Rd7tTii5XG
         3BaPorgEEpb36Ei2LBex0KVE+uwJOOByOUuGpxiizr+744YJpAdXdIbAHw92oxLozHGE
         PhIFmkCTc9jLTwxecZUGpxlplo/YS2t1cDMhwxol4xU22WvCo5uuGreWf8bAEF0GIvfv
         gW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4Q6w6yEvGwJK0TRipYAGtfiK43Dmnd3tJ7ygkkWia4=;
        b=I/FCBW0FE+Y+f0smgt8SoGbvoVK2tnHR7KuHWuaMRa7C2RXGUkrHGn9jHF4Q4jbBeO
         C34ZFwZOiyOoy0sVDzKrYWl6ReNXGxC8dJ9/dkqHyOSSz/aLtIgBAoWrA5ZG8j5suH/Q
         Y9lYzQdHsEuNOwPU5IVPps0rIF8b2sFvbeqwqw6UEyrSKO0EGXTljsfK6KSLSAyUVJ6l
         vLCblO6aUX3oq9X5Xe2ETRxFzFccHHqHcQm3UYyICfiCD92e9CDGi6ILwv1wOuOzsYX/
         uLnowzHy/9yIUxIhqp3MyxlV8h8KMvsXQcutJdnlP1hdt4544bvlXzTCPsOlw8mqq3IZ
         dFzA==
X-Gm-Message-State: AOAM532Hr9HK0RZSlk7QERx5K3WMbtjD1/sf9qxKqkIBD/VFlsYYpp/Y
        5o+zrOmRyNhqKH4RxfAPlNg=
X-Google-Smtp-Source: ABdhPJzaWlQJYvbQ+EagfN3qdp16Rk+tbk02UoNETO2+CAcbdrv7RLtNe2Z7jSDRK6RLvZbVgRfX3A==
X-Received: by 2002:a62:1ad4:0:b0:510:c635:e516 with SMTP id a203-20020a621ad4000000b00510c635e516mr12359143pfa.42.1652596964160;
        Sat, 14 May 2022 23:42:44 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:42:43 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2 6/6] thermal: exynos: Add runtime power management for tmu
Date:   Sun, 15 May 2022 06:41:23 +0000
Message-Id: <20220515064126.1424-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515064126.1424-1-linux.amoon@gmail.com>
References: <20220515064126.1424-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime power management for exynos thermal driver.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: new patch in this series.
---
 drivers/thermal/samsung/exynos_tmu.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f8a527f19383..be9b98caf2ba 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include <dt-bindings/thermal/thermal_exynos.h>
 
@@ -1106,6 +1107,15 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_thermal;
 	}
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		goto disable_runtime_pm;
+
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
@@ -1113,11 +1123,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_thermal;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	exynos_tmu_control(pdev, true);
 	return 0;
 
 err_thermal:
 	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
+disable_runtime_pm:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 err_clk_sec:
 	clk_disable_unprepare(data->clk_sec);
 err_sclk:
@@ -1143,6 +1158,9 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->clk);
 	clk_disable_unprepare(data->clk_sec);
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
 
@@ -1151,18 +1169,25 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 static int __maybe_unused exynos_tmu_suspend(struct device *dev)
 {
-	exynos_tmu_control(to_platform_device(dev), false);
+	struct platform_device *pdev = to_platform_device(dev);
 
-	return 0;
+	exynos_tmu_control(pdev, false);
+
+	return pm_runtime_force_suspend(&pdev->dev);
 }
 
 static int __maybe_unused exynos_tmu_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
 	exynos_tmu_initialize(pdev);
 	exynos_tmu_control(pdev, true);
 
+	ret = pm_runtime_force_resume(&pdev->dev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.36.1

