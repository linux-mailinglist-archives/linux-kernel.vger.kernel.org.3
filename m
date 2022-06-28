Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75B55EDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiF1Tnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiF1TnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:43:25 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FD3BBFC;
        Tue, 28 Jun 2022 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444902; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veWSQADcvvHs7afr292zkvMDz4ajqpLReEoGQPfwNuE=;
        b=KzxMMmbDk94vl5TAQSLOUWkw191JtSMKgM0Z7ipsRLoyR/smPoWt8fC+9j0Uan012ufu/Y
        30pAU8MOHyWV4HNv3rLr0Q7Q1PexfKLGfpOJ5+KK39L08ass6OQtU/HxkJp0lXODI9NUqn
        q3+DyB0FdVBU1xbjqFSuVFWZbS7qakI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/8] watchdog: sama5d4_wdt: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:46 +0100
Message-Id: <20220628193449.160585-6-paul@crapouillou.net>
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

Use the new LATE_SYSTEM_SLEEP_PM_OPS() and pm_sleep_ptr() macros to
handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/watchdog/sama5d4_wdt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index ec20ad4e534f..aeee934ca51b 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -339,7 +339,6 @@ static const struct of_device_id sama5d4_wdt_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sama5d4_wdt_of_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int sama5d4_wdt_suspend_late(struct device *dev)
 {
 	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
@@ -366,18 +365,17 @@ static int sama5d4_wdt_resume_early(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sama5d4_wdt_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(sama5d4_wdt_suspend_late,
-			sama5d4_wdt_resume_early)
+	LATE_SYSTEM_SLEEP_PM_OPS(sama5d4_wdt_suspend_late,
+				 sama5d4_wdt_resume_early)
 };
 
 static struct platform_driver sama5d4_wdt_driver = {
 	.probe		= sama5d4_wdt_probe,
 	.driver		= {
 		.name	= "sama5d4_wdt",
-		.pm	= &sama5d4_wdt_pm_ops,
+		.pm	= pm_sleep_ptr(&sama5d4_wdt_pm_ops),
 		.of_match_table = sama5d4_wdt_of_match,
 	}
 };
-- 
2.35.1

