Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0CD4E1AA3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 08:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbiCTHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiCTHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 03:11:59 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587674EA36
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 00:10:36 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id VphwnDu6qAWDQVphwnHug1; Sun, 20 Mar 2022 08:10:34 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 20 Mar 2022 08:10:34 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: samsung: exynos5422-dmc: Avoid some over memory allocation
Date:   Sun, 20 Mar 2022 08:10:30 +0100
Message-Id: <69d7e69346986e2fdb994d4382954c932f9f0993.1647760213.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dmc->counter' is a 'struct devfreq_event_dev **', so there is some
over memory allocation. 'counters_size' should be computed with
'sizeof(struct devfreq_event_dev *)'.

Use 'sizeof(*dmc->counter)' instead to fix it.

While at it, use devm_kcalloc() instead of devm_kzalloc()+open coded
multiplication.

Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_kmalloc_array() could also be used to save a few cycles because the
array is fully initialized a few lines below.
---
 drivers/memory/samsung/exynos5422-dmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 9c8318923ed0..4733e7898ffe 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1322,7 +1322,6 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
  */
 static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 {
-	int counters_size;
 	int ret, i;
 
 	dmc->num_counters = devfreq_event_get_edev_count(dmc->dev,
@@ -1332,8 +1331,8 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 		return dmc->num_counters;
 	}
 
-	counters_size = sizeof(struct devfreq_event_dev) * dmc->num_counters;
-	dmc->counter = devm_kzalloc(dmc->dev, counters_size, GFP_KERNEL);
+	dmc->counter = devm_kcalloc(dmc->dev, dmc->num_counters,
+				    sizeof(*dmc->counter), GFP_KERNEL);
 	if (!dmc->counter)
 		return -ENOMEM;
 
-- 
2.32.0

