Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1E58BCF3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiHGU4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHGU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 16:56:05 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF66561
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:56:03 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KnJYoMqN4sL0zKnJYoI6XJ; Sun, 07 Aug 2022 22:56:01 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Aug 2022 22:56:01 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-tegra@vger.kernel.org
Subject: [PATCH] soc/tegra: pmc: Use devm_clk_get_optional()
Date:   Sun,  7 Aug 2022 22:55:59 +0200
Message-Id: <4d2e518fc75dd3053ec4afcc36e13a0a6f75884e.1659905735.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.

While at it, use dev_err_probe() to further simplify the code. This is also
less verbose if clk_get() returns -EPROBE_DEFER.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/tegra/pmc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6a4b8f7e7948..016762f88fff 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2885,17 +2885,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		pmc->scratch = base;
 	}
 
-	pmc->clk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(pmc->clk)) {
-		err = PTR_ERR(pmc->clk);
-
-		if (err != -ENOENT) {
-			dev_err(&pdev->dev, "failed to get pclk: %d\n", err);
-			return err;
-		}
-
-		pmc->clk = NULL;
-	}
+	pmc->clk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(pmc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pmc->clk),
+				     "failed to get pclk\n");
 
 	/*
 	 * PMC should be last resort for restarting since it soft-resets
-- 
2.34.1

