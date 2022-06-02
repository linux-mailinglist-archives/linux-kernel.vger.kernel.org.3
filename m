Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF553B280
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiFBERh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiFBERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:17:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086ADDC;
        Wed,  1 Jun 2022 21:17:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q18so3493421pln.12;
        Wed, 01 Jun 2022 21:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5ebmhLj4oI6jokTJKCp02gLjiFucaCQB6mhTvl9VZk=;
        b=lc+QMzwx/hSroE/5ewbNS+MrrC4UlGexZ3gZVVEA5Rw2uEwRUd07rtwSSXExqvSRrp
         pDvxlgj+vZcGSPyw0CUmSNtY0LsaVJE14GYMqUFy+TZYo8x1e+i9n74A7VhkOmAyflfl
         SicOSt9go7MZr54zScf7EJdos+GpRjQk6fj9TTaLLvTdnEMPdmihoYArXVHsFgr4eaRY
         Hfl/hENlMF0qqvWzeF4f/JQT3zQ/aSTNV9X3emHRs0UtyvmALoPBa93gNFS9YKQSg/c4
         vqrg6uVrxrVMPkrTTGTB2738/uaM6awS8qj8yEn6ePcix82C41AnRRFbikZFpaWYms3x
         5iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5ebmhLj4oI6jokTJKCp02gLjiFucaCQB6mhTvl9VZk=;
        b=d9oMabqeYpx0f/YD8nvt7sOeYTOxdnH8nfqufWyntbhjbRid2Tkr3iCVEVaHPjn4f3
         oESbas1JP3eIuWZeJoLW7LVm9utQTeBLaeGKgw0kk+JAfTgTrDhzo8OxweJYJTBl1eFO
         807KoTzcTTXRlNYtXND0pE4Sr0W7oaDLSOo+e8eRoScO4pSuuK5QTSB2CUZWU5EGfPIE
         udwuvi5hL/aobo7mW7YRzBFegwklWkGapmrNdCv7+9n3zxYci65v/X8RBdLtRVAOeqQl
         u0XcKYx5dWB2eAwWJb8zuk588h49Qw6NkHYzFi0m61ddfWYqtAGn33/gAwhbjmjyE+1N
         4ULA==
X-Gm-Message-State: AOAM531iaApyDhDJIxZZ7O6decl2xZJUyKysjkh1mhYL9jOVZlAQbWfQ
        TONjbczcybY7iQzJO73fW+I=
X-Google-Smtp-Source: ABdhPJxgQcXunt99zIQQSrLS+7t55ND7PHrtpNaDCte4XXwrMQT84qOF1CiOW3GgkpS7w7P3OTEtOA==
X-Received: by 2002:a17:90b:17d0:b0:1e3:5324:c465 with SMTP id me16-20020a17090b17d000b001e35324c465mr3089557pjb.34.1654143450093;
        Wed, 01 Jun 2022 21:17:30 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id z6-20020a170903018600b001621a66b318sm2440131plg.130.2022.06.01.21.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 21:17:29 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH] memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_timings
Date:   Thu,  2 Jun 2022 08:17:21 +0400
Message-Id: <20220602041721.64348-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
This function doesn't call of_node_put() in some error paths.
To unify the structure, Add put_node label and goto it on errors.

Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 29 +++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 4733e7898ffe..c491cd549644 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1187,33 +1187,39 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 
 	dmc->timing_row = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
 					     sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_row)
-		return -ENOMEM;
+	if (!dmc->timing_row) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
 
 	dmc->timing_data = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
 					      sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_data)
-		return -ENOMEM;
+	if (!dmc->timing_data) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
 
 	dmc->timing_power = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
 					       sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_power)
-		return -ENOMEM;
+	if (!dmc->timing_power) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
 
 	dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dmc->dev,
 						 DDR_TYPE_LPDDR3,
 						 &dmc->timings_arr_size);
 	if (!dmc->timings) {
-		of_node_put(np_ddr);
 		dev_warn(dmc->dev, "could not get timings from DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_node;
 	}
 
 	dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dmc->dev);
 	if (!dmc->min_tck) {
-		of_node_put(np_ddr);
 		dev_warn(dmc->dev, "could not get tck from DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_node;
 	}
 
 	/* Sorted array of OPPs with frequency ascending */
@@ -1227,13 +1233,14 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 					     clk_period_ps);
 	}
 
-	of_node_put(np_ddr);
 
 	/* Take the highest frequency's timings as 'bypass' */
 	dmc->bypass_timing_row = dmc->timing_row[idx - 1];
 	dmc->bypass_timing_data = dmc->timing_data[idx - 1];
 	dmc->bypass_timing_power = dmc->timing_power[idx - 1];
 
+put_node:
+	of_node_put(np_ddr);
 	return ret;
 }
 
-- 
2.25.1

