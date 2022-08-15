Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8BF5933BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiHOQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiHOQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:59:34 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D9275EF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:59:32 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NdQyoIwLGsfCINdQzoj4ur; Mon, 15 Aug 2022 18:59:25 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 18:59:25 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: mxc: Use devm_clk_get_enabled() helper
Date:   Mon, 15 Aug 2022 18:59:23 +0200
Message-Id: <1b5ad1877304b01ddbba73ca615274a52f781aa2.1660582728.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
   6705	   1968	      0	   8673	   21e1	drivers/rtc/rtc-mxc.o
down to:
   6212	   1968	      0	   8180	   1ff4	drivers/rtc/rtc-mxc.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1
---
 drivers/rtc/rtc-mxc.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 53d4e253e81f..762cf03345f1 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -291,14 +291,6 @@ static const struct rtc_class_ops mxc_rtc_ops = {
 	.alarm_irq_enable	= mxc_rtc_alarm_irq_enable,
 };
 
-static void mxc_rtc_action(void *p)
-{
-	struct rtc_plat_data *pdata = p;
-
-	clk_disable_unprepare(pdata->clk_ref);
-	clk_disable_unprepare(pdata->clk_ipg);
-}
-
 static int mxc_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
@@ -341,33 +333,18 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 		rtc->range_max = (1 << 16) * 86400ULL - 1;
 	}
 
-	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	pdata->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
 	if (IS_ERR(pdata->clk_ipg)) {
 		dev_err(&pdev->dev, "unable to get ipg clock!\n");
 		return PTR_ERR(pdata->clk_ipg);
 	}
 
-	ret = clk_prepare_enable(pdata->clk_ipg);
-	if (ret)
-		return ret;
-
-	pdata->clk_ref = devm_clk_get(&pdev->dev, "ref");
+	pdata->clk_ref = devm_clk_get_enabled(&pdev->dev, "ref");
 	if (IS_ERR(pdata->clk_ref)) {
-		clk_disable_unprepare(pdata->clk_ipg);
 		dev_err(&pdev->dev, "unable to get ref clock!\n");
 		return PTR_ERR(pdata->clk_ref);
 	}
 
-	ret = clk_prepare_enable(pdata->clk_ref);
-	if (ret) {
-		clk_disable_unprepare(pdata->clk_ipg);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev, mxc_rtc_action, pdata);
-	if (ret)
-		return ret;
-
 	rate = clk_get_rate(pdata->clk_ref);
 
 	if (rate == 32768)
-- 
2.34.1

