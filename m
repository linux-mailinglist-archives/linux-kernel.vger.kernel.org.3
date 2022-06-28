Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C855EDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiF1TnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiF1Tmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:42:44 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F53B2BC;
        Tue, 28 Jun 2022 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444900; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GI374m8HDyCwdRV9NoEhzKp27nBp7VJRaI366errsU=;
        b=p7rTsOWcNTHZTUBI7z3YWWtV7ohh/U/HWHk17ujuwERuHi/S8y79XmvLRCPp4X0g3KIW7t
        G59QoOpMFS+Kv4D3x6t/MIm8veKuYGDqVqvzC5xsW8dLUX8xhPpUF1sHFQugpXfL4nT1MA
        XbQEX4Zx7cqYVgHw8unZAoq6JtO2P00=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/8] watchdog: mtk_wdt: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:44 +0100
Message-Id: <20220628193449.160585-4-paul@crapouillou.net>
In-Reply-To: <20220628193449.160585-1-paul@crapouillou.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
 drivers/watchdog/mtk_wdt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index f0d4e3cc7459..e97787536792 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -401,7 +401,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mtk_wdt_suspend(struct device *dev)
 {
 	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
@@ -423,7 +422,6 @@ static int mtk_wdt_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
@@ -437,16 +435,14 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 
-static const struct dev_pm_ops mtk_wdt_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
-				mtk_wdt_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(mtk_wdt_pm_ops,
+				mtk_wdt_suspend, mtk_wdt_resume);
 
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
 	.driver		= {
 		.name		= DRV_NAME,
-		.pm		= &mtk_wdt_pm_ops,
+		.pm		= pm_sleep_ptr(&mtk_wdt_pm_ops),
 		.of_match_table	= mtk_wdt_dt_ids,
 	},
 };
-- 
2.35.1

