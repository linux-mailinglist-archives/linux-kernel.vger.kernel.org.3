Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7761659F57A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiHXImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiHXImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:42:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28BC2DA80
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:42:33 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Qly3o30vrTLjwQly3oELfj; Wed, 24 Aug 2022 10:42:31 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 10:42:31 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Paul Cercueil <paul@crapouillou.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mips@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: jz4740: Use devm_clk_get_enabled() helper
Date:   Wed, 24 Aug 2022 10:42:29 +0200
Message-Id: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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


As a side effect, some error messages are not logged anymore, so also use
dev_err_probe() instead of dev_err() in case of error.
At least the error code will be logged (and -EPROBE_DEFER will be filtered)

Based on my test with allyesconfig, this reduces the .o size from:
   text	   data	    bss	    dec	    hex	filename
   9025	   2488	    128	  11641	   2d79	drivers/rtc/rtc-jz4740.o
down to:
   8267	   2080	    128	  10475	   28eb	drivers/rtc/rtc-jz4740.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1

Some recent changed use "rtc: ingenic". This looks odd to me, so turn back
to "rtc: jz4740"
---
 drivers/rtc/rtc-jz4740.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 6e51df72fd65..c383719292c7 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -257,11 +257,6 @@ static void jz4740_rtc_power_off(void)
 	kernel_halt();
 }
 
-static void jz4740_rtc_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *)ID_JZ4740 },
 	{ .compatible = "ingenic,jz4760-rtc", .data = (void *)ID_JZ4760 },
@@ -329,23 +324,9 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
-	clk = devm_clk_get(dev, "rtc");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "Failed to get RTC clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clock\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev, jz4740_rtc_clk_disable, clk);
-	if (ret) {
-		dev_err(dev, "Failed to register devm action\n");
-		return ret;
-	}
+	clk = devm_clk_get_enabled(dev, "rtc");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get RTC clock\n");
 
 	spin_lock_init(&rtc->lock);
 
-- 
2.34.1

