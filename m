Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4F50F9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiDZKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348592AbiDZKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:13:24 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EC6229329;
        Tue, 26 Apr 2022 02:36:11 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:47276.50558092
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id D95CC2800ED;
        Tue, 26 Apr 2022 17:36:01 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id eb70397932ca461d80aeee08fb850ada for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 17:36:10 CST
X-Transaction-ID: eb70397932ca461d80aeee08fb850ada
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v5] watchdog: iTCO_wdg: Using existing macro define covers more scenarios
Date:   Tue, 26 Apr 2022 17:35:46 +0800
Message-Id: <1650965746-2685-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For power management, SET_NOIRQ_SYSTEM_SLEEP_PM_OPS defined for
CONFIG_PM_SLEEP, will point ->suspend_noirq, ->freeze_noirq and
->poweroff_noirq to the same function. Vice versa happens for
->resume_noirq, ->thaw_noirq and ->restore_noirq.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/iTCO_wdt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3f2f4343644f..34693f11385f 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -596,7 +596,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
  * the watchdog cannot be pinged while in that state.  In ACPI sleep states the
@@ -604,15 +603,15 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
  */
 
 #ifdef CONFIG_ACPI
-static inline bool need_suspend(void)
+static inline bool __maybe_unused need_suspend(void)
 {
 	return acpi_target_system_state() == ACPI_STATE_S0;
 }
 #else
-static inline bool need_suspend(void) { return true; }
+static inline bool __maybe_unused need_suspend(void) { return true; }
 #endif
 
-static int iTCO_wdt_suspend_noirq(struct device *dev)
+static int __maybe_unused iTCO_wdt_suspend_noirq(struct device *dev)
 {
 	struct iTCO_wdt_private *p = dev_get_drvdata(dev);
 	int ret = 0;
@@ -626,7 +625,7 @@ static int iTCO_wdt_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int iTCO_wdt_resume_noirq(struct device *dev)
+static int __maybe_unused iTCO_wdt_resume_noirq(struct device *dev)
 {
 	struct iTCO_wdt_private *p = dev_get_drvdata(dev);
 
@@ -637,20 +636,15 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops iTCO_wdt_pm = {
-	.suspend_noirq = iTCO_wdt_suspend_noirq,
-	.resume_noirq = iTCO_wdt_resume_noirq,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
+				      iTCO_wdt_resume_noirq)
 };
 
-#define ITCO_WDT_PM_OPS	(&iTCO_wdt_pm)
-#else
-#define ITCO_WDT_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
-
 static struct platform_driver iTCO_wdt_driver = {
 	.probe          = iTCO_wdt_probe,
 	.driver         = {
 		.name   = DRV_NAME,
-		.pm     = ITCO_WDT_PM_OPS,
+		.pm     = &iTCO_wdt_pm,
 	},
 };
 
-- 
2.23.0

