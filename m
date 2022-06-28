Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E382255EDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiF1ToP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiF1Tns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:43:48 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5E3FD90;
        Tue, 28 Jun 2022 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444904; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZFWrplxgeK81PZ17A7+6OYx0jA+Vvk198LQfz5y7DU=;
        b=raa6QRnLYnT1wKKeL7INXr9bc1nzAQ84Zi8arVzIFwuknxM1FFvMHH+HVftDjadIcg8Fv/
        0HgYV+OzNfYetIfLde9VtZq6xuDrQtnHFM5w4XTInQLfLO53yKKsl3gGvXHLBcZ0uTmjvf
        2a/Dfp+Vf2FDMR5qn+BLSsN8eAkBGqU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 8/8] watchdog: wdat_wdt: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:49 +0100
Message-Id: <20220628193449.160585-9-paul@crapouillou.net>
In-Reply-To: <20220628193449.160585-1-paul@crapouillou.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new NOIRQ_SYSTEM_SLEEP_PM_OPS() and pm_sleep_ptr() macros to
handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/wdat_wdt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index e6f95e99156d..aeadaa07c891 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -467,7 +467,6 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdat->wdd);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int wdat_wdt_suspend_noirq(struct device *dev)
 {
 	struct wdat_wdt *wdat = dev_get_drvdata(dev);
@@ -528,18 +527,16 @@ static int wdat_wdt_resume_noirq(struct device *dev)
 
 	return wdat_wdt_start(&wdat->wdd);
 }
-#endif
 
 static const struct dev_pm_ops wdat_wdt_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(wdat_wdt_suspend_noirq,
-				      wdat_wdt_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(wdat_wdt_suspend_noirq, wdat_wdt_resume_noirq)
 };
 
 static struct platform_driver wdat_wdt_driver = {
 	.probe = wdat_wdt_probe,
 	.driver = {
 		.name = "wdat_wdt",
-		.pm = &wdat_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&wdat_wdt_pm_ops),
 	},
 };
 
-- 
2.35.1

