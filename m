Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2A55EDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiF1Tn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiF1Tnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:43:39 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149BC28729;
        Tue, 28 Jun 2022 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444903; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m334sSm9fa2IjolH0EgWsZH3ydh3RdTsRkLAA2vFXqA=;
        b=dvLn7+cwPD8Mm8YtI0JbHYHZ1z3wwYLO6PWRTHrkaMgiuTnm37Duh9wVzRo5R0YvRqNwuH
        ltEtM8MayskURiJPqvN0wz14u14dtkG0hreGC27VIar8C+su5TXonsuWcWjraYfe5uIgGG
        cQdol4/X4Oh38wxJs5d2OtIBrmsrne8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/8] watchdog: st_lpc_wdt: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:47 +0100
Message-Id: <20220628193449.160585-7-paul@crapouillou.net>
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
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/watchdog/st_lpc_wdt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 14ab6559c748..39abecdb9dd1 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -248,7 +248,6 @@ static int st_wdog_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int st_wdog_suspend(struct device *dev)
 {
 	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
@@ -285,16 +284,14 @@ static int st_wdog_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(st_wdog_pm_ops,
-			 st_wdog_suspend,
-			 st_wdog_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(st_wdog_pm_ops,
+				st_wdog_suspend, st_wdog_resume);
 
 static struct platform_driver st_wdog_driver = {
 	.driver	= {
 		.name = "st-lpc-wdt",
-		.pm = &st_wdog_pm_ops,
+		.pm = pm_sleep_ptr(&st_wdog_pm_ops),
 		.of_match_table = st_wdog_match,
 	},
 	.probe = st_wdog_probe,
-- 
2.35.1

