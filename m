Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A4559F526
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiHXIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiHXIZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:25:18 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C55893203
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:25:17 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QlhJo5ZO7EkSDQlhKo6H5V; Wed, 24 Aug 2022 10:25:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 10:25:15 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: k3: Use devm_clk_get_enabled() helper
Date:   Wed, 24 Aug 2022 10:25:11 +0200
Message-Id: <601288834ab71c0fddde7eedd8cdb8001254ed7e.1661329498.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
   12843	   4804	     64	  17711	   452f	drivers/rtc/rtc-ti-k3.o
down to:
   12523	   4804	     64	  17391	   43ef	drivers/rtc/rtc-ti-k3.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1
---
 drivers/rtc/rtc-ti-k3.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
index 68e50c6a72f1..ba23163cc042 100644
--- a/drivers/rtc/rtc-ti-k3.c
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -515,21 +515,12 @@ static struct nvmem_config ti_k3_rtc_nvmem_config = {
 
 static int k3rtc_get_32kclk(struct device *dev, struct ti_k3_rtc *priv)
 {
-	int ret;
 	struct clk *clk;
 
-	clk = devm_clk_get(dev, "osc32k");
+	clk = devm_clk_get_enabled(dev, "osc32k");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, (void (*)(void *))clk_disable_unprepare, clk);
-	if (ret)
-		return ret;
-
 	priv->rate_32k = clk_get_rate(clk);
 
 	/* Make sure we are exact 32k clock. Else, try to compensate delay */
@@ -544,24 +535,19 @@ static int k3rtc_get_32kclk(struct device *dev, struct ti_k3_rtc *priv)
 	 */
 	priv->sync_timeout_us = (u32)(DIV_ROUND_UP_ULL(1000000, priv->rate_32k) * 4);
 
-	return ret;
+	return 0;
 }
 
 static int k3rtc_get_vbusclk(struct device *dev, struct ti_k3_rtc *priv)
 {
-	int ret;
 	struct clk *clk;
 
 	/* Note: VBUS isn't a context clock, it is needed for hardware operation */
-	clk = devm_clk_get(dev, "vbus");
+	clk = devm_clk_get_enabled(dev, "vbus");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, (void (*)(void *))clk_disable_unprepare, clk);
+	return 0;
 }
 
 static int ti_k3_rtc_probe(struct platform_device *pdev)
-- 
2.34.1

