Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350AE50EF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiDZDj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiDZDi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:38:56 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C11353A1AA;
        Mon, 25 Apr 2022 20:35:49 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:49938.983364622
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id E5F7A280029;
        Tue, 26 Apr 2022 11:35:47 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 10d57f2abc2e4ef58faa5f71ac2aa20b for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 11:35:48 CST
X-Transaction-ID: 10d57f2abc2e4ef58faa5f71ac2aa20b
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v3 4/4] watchdog: iTCO_wdg: Make code more clearly with macro definition
Date:   Tue, 26 Apr 2022 11:35:20 +0800
Message-Id: <1650944120-30954-5-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650944120-30954-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650944120-30954-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/iTCO_wdt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3f2f4343644f..f870cf08f143 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -596,7 +596,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
  * the watchdog cannot be pinged while in that state.  In ACPI sleep states the
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

