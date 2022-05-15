Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD83527620
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiEOGmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiEOGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:42:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BF21E2E;
        Sat, 14 May 2022 23:42:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ev18so940815pjb.4;
        Sat, 14 May 2022 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNX8IttIs7gPKZ/ZnlljxMvfqRG5qWD1gnAXVMMqp+0=;
        b=XEBWuyekW9Udsy/Vmpi4TY/XNvR6qWx5rXCSqsQu38ntjFvrZ7UBEto6MpPBdQJnzp
         H/QYIJJVqffc+impBIGZY/MgvA6BcxfpypE61Mv5qsOkhdyooPNwgtunUKmau/HX6NHB
         jlmk2eGVS+8L5jSUCeHPBenPyLuAWSCf5azOXgnp06e7zouH7VdOzz2MHJyrJbnkAEHs
         pKZtPck8GEuNzxbYjkerb3Y4Ob2PUYY3uBLf4/WDR5fHiVARgxItMmdrluI7oX0g8+Wy
         QGGGu4wbaA83ceJnAikUtq37nFoDIa9sRNceKxsp2XAzM5oTC9mCnlyesgVnHxR9FBKC
         AOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNX8IttIs7gPKZ/ZnlljxMvfqRG5qWD1gnAXVMMqp+0=;
        b=6U83q/tKBX4o5dqx9DtXcet6VeKNcd4cbJ+McZ2bc20OhgvbLh+klUGC9HERBV0xAs
         fIlhdASrNTZn/WqeFUe5iOTk1r18BuoMWtAaIhPK5Oy49jEF06dvYJPbtGVD6jkylAde
         P19fDs+lXcsuTx6HwyKSzZT9Dri98LS3EexGIHbk0f7qzBzwTvvoLxemqto272Bm9j22
         k6cS+VPDSK/PdJ6zMohvneNYvPDms+z8Ye9d7CPurwTtxWk9hnat4XvOdnPGhRzmQQEr
         r4fWiqb1nMJFacUo/bkv1AMrr/6cWQlHJhy6G79ieHCTQmgHZ9t6H7wVYlJfTQK4nVGc
         E9EQ==
X-Gm-Message-State: AOAM533PqLzu6b54oFkdDPuBvGUo+LBtNNcPwfUZSdTXf1buyGmdF4yE
        zhRZkFxTW/gKXoEj9sJSe0k=
X-Google-Smtp-Source: ABdhPJyT8+/XLu+q/7btdUnRMr1o9G/m+//8acAzxbS43SlpLD4HVZDMbTlxRTchAJLWw+4FK5O7pQ==
X-Received: by 2002:a17:90a:f2ce:b0:1d9:a18f:87f3 with SMTP id gt14-20020a17090af2ce00b001d9a18f87f3mr24550386pjb.213.1652596934488;
        Sat, 14 May 2022 23:42:14 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:42:14 -0700 (PDT)
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
Subject: [PATCHv2 2/6] thermal: exynos: Reorder the gpu clock initialization for exynos5420 SoC
Date:   Sun, 15 May 2022 06:41:19 +0000
Message-Id: <20220515064126.1424-3-linux.amoon@gmail.com>
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

Reorder the tmu_gpu clock initialization for exynos5422 SoC.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: split the changes and improve the commit messages
---
 drivers/thermal/samsung/exynos_tmu.c | 43 ++++++++++++++--------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 75b3afadb5be..1ef90dc52c08 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1044,42 +1044,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		ret = PTR_ERR(data->clk);
 		goto err_sensor;
-	}
-
-	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
-			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			ret = PTR_ERR(data->clk_sec);
-			goto err_sensor;
-		}
 	} else {
-		ret = clk_prepare_enable(data->clk_sec);
+		ret = clk_prepare_enable(data->clk);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
 			goto err_sensor;
 		}
 	}
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get clock\n");
-		goto err_clk_sec;
-	}
-
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
+			ret = PTR_ERR(data->clk_sec);
+			goto err_clk_apbif;
+		} else {
+			ret = clk_prepare_enable(data->clk_sec);
+			if (ret) {
+				dev_err(&pdev->dev, "Failed to get clock\n");
+				goto err_clk_apbif;
+			}
+		}
+		break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
 			ret = PTR_ERR(data->sclk);
-			goto err_clk;
+			goto err_clk_sec;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
 			if (ret) {
 				dev_err(&pdev->dev, "Failed to enable sclk\n");
-				goto err_clk;
+				goto err_clk_sec;
 			}
 		}
 		break;
@@ -1119,13 +1118,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 err_thermal:
 	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
-err_sclk:
-	clk_disable_unprepare(data->sclk);
-err_clk:
-	clk_disable_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_disable_unprepare(data->clk_sec);
+err_sclk:
+	clk_disable_unprepare(data->sclk);
+err_clk_apbif:
+	clk_disable_unprepare(data->clk);
 err_sensor:
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.36.1

