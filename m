Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422FE55EDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiF1Tnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiF1Tm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:42:59 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9743F895;
        Tue, 28 Jun 2022 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444901; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGopMg7rrQDjhUvGbHD50XRWYmeZSip2Vhlfrfv9/RM=;
        b=XeE2AuIr+XIVkVMs8Gpx0JQCB1N3qu6Wm83uBYXDAj0lChptVLvJPQ1kJWOEpuDuPigYH9
        GFzCpmX6Sp7pREsl4WFwjmzSEOhaVIFd41/HX8cz4mci6R4m3jENeSr8sLxR4DSDXFHtLw
        pdYKQTXEBgA1HqE1Xxc4a2WVjRU3nOM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/8] watchdog: s3c2410_wdt: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:45 +0100
Message-Id: <20220628193449.160585-5-paul@crapouillou.net>
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/watchdog/s3c2410_wdt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 6db22f2e3a4f..95919392927f 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -845,8 +845,6 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
 	s3c2410wdt_stop(&wdt->wdt_device);
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int s3c2410wdt_suspend(struct device *dev)
 {
 	int ret;
@@ -885,10 +883,9 @@ static int s3c2410wdt_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops, s3c2410wdt_suspend,
-			s3c2410wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops,
+				s3c2410wdt_suspend, s3c2410wdt_resume);
 
 static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
@@ -897,7 +894,7 @@ static struct platform_driver s3c2410wdt_driver = {
 	.id_table	= s3c2410_wdt_ids,
 	.driver		= {
 		.name	= "s3c2410-wdt",
-		.pm	= &s3c2410wdt_pm_ops,
+		.pm	= pm_sleep_ptr(&s3c2410wdt_pm_ops),
 		.of_match_table	= of_match_ptr(s3c2410_wdt_match),
 	},
 };
-- 
2.35.1

