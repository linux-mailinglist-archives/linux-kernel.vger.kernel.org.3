Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532C359F49E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiHXHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiHXHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:55:56 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C484EEA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:55:53 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QlEroa3jzPMmaQlEropAN6; Wed, 24 Aug 2022 09:55:50 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 09:55:50 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH] hwspinlock: sprd: Use devm_clk_get_enabled() helper
Date:   Wed, 24 Aug 2022 09:55:47 +0200
Message-Id: <f962d22bfdbd09133d8923152133eeff9213dcee.1661324434.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code, the error handling paths and avoid the need of
a dedicated function used with devm_add_action_or_reset().

Based on my test with allyesconfig, this reduces the .o size from:
   text	   data	    bss	    dec	    hex	filename
   3423	   1528	      0	   4951	   1357	drivers/hwspinlock/sprd_hwspinlock.o
down to:
   3025	   1392	      0	   4417	   1141	drivers/hwspinlock/sprd_hwspinlock.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1
---
 drivers/hwspinlock/sprd_hwspinlock.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index 22e2ffb91743..cb37706f61be 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -76,18 +76,11 @@ static const struct hwspinlock_ops sprd_hwspinlock_ops = {
 	.relax = sprd_hwspinlock_relax,
 };
 
-static void sprd_hwspinlock_disable(void *data)
-{
-	struct sprd_hwspinlock_dev *sprd_hwlock = data;
-
-	clk_disable_unprepare(sprd_hwlock->clk);
-}
-
 static int sprd_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct sprd_hwspinlock_dev *sprd_hwlock;
 	struct hwspinlock *lock;
-	int i, ret;
+	int i;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
@@ -102,24 +95,12 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	if (IS_ERR(sprd_hwlock->base))
 		return PTR_ERR(sprd_hwlock->base);
 
-	sprd_hwlock->clk = devm_clk_get(&pdev->dev, "enable");
+	sprd_hwlock->clk = devm_clk_get_enabled(&pdev->dev, "enable");
 	if (IS_ERR(sprd_hwlock->clk)) {
 		dev_err(&pdev->dev, "get hwspinlock clock failed!\n");
 		return PTR_ERR(sprd_hwlock->clk);
 	}
 
-	ret = clk_prepare_enable(sprd_hwlock->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev, sprd_hwspinlock_disable,
-				       sprd_hwlock);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to add hwspinlock disable action\n");
-		return ret;
-	}
-
 	/* set the hwspinlock to record user id to identify subsystems */
 	writel(HWSPINLOCK_USER_BITS, sprd_hwlock->base + HWSPINLOCK_RECCTRL);
 
-- 
2.34.1

