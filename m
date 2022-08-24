Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C959F4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiHXISk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiHXISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:18:33 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495D861D8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:18:31 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QlamoIOe1ez1rQlamoU0BV; Wed, 24 Aug 2022 10:18:29 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 10:18:29 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Date:   Wed, 24 Aug 2022 10:18:25 +0200
Message-Id: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
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

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code, the error handling paths and avoid the need of
a dedicated function used with devm_add_action_or_reset().

That said, mpfs_rtc_init_clk() is the same as devm_clk_get_enabled(), so
use this function directly instead.

This also fixes an (unlikely) unchecked devm_add_action_or_reset() error.

Based on my test with allyesconfig, this reduces the .o size from:
   text	   data	    bss	    dec	    hex	filename
   5330	   2208	      0	   7538	   1d72	drivers/rtc/rtc-mpfs.o
down to:
   5074	   2208	      0	   7282	   1c72	drivers/rtc/rtc-mpfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1
---
 drivers/rtc/rtc-mpfs.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
index 944ad1036516..2a479d44f198 100644
--- a/drivers/rtc/rtc-mpfs.c
+++ b/drivers/rtc/rtc-mpfs.c
@@ -193,23 +193,6 @@ static int mpfs_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static inline struct clk *mpfs_rtc_init_clk(struct device *dev)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = devm_clk_get(dev, "rtc");
-	if (IS_ERR(clk))
-		return clk;
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ERR_PTR(ret);
-
-	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
-	return clk;
-}
-
 static irqreturn_t mpfs_rtc_wakeup_irq_handler(int irq, void *dev)
 {
 	struct mpfs_rtc_dev *rtcdev = dev;
@@ -251,7 +234,7 @@ static int mpfs_rtc_probe(struct platform_device *pdev)
 	/* range is capped by alarm max, lower reg is 31:0 & upper is 10:0 */
 	rtcdev->rtc->range_max = GENMASK_ULL(42, 0);
 
-	clk = mpfs_rtc_init_clk(&pdev->dev);
+	clk = devm_clk_get_enabled(&pdev->dev, "rtc");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.34.1

