Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA57550F1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiDZHOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbiDZHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:14:25 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E4E43917D;
        Tue, 26 Apr 2022 00:11:18 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:50678.1670155976
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 1EA862800A8;
        Tue, 26 Apr 2022 15:10:59 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id c6be7f13ea814490a6f255094222d8e3 for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 15:11:17 CST
X-Transaction-ID: c6be7f13ea814490a6f255094222d8e3
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v4 4/4] watchdog: iTCO_wdg: Make code more clearly with macro definition
Date:   Tue, 26 Apr 2022 15:10:29 +0800
Message-Id: <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/iTCO_wdt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3f2f4343644f..8d24cf4f4ca3 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -635,22 +635,18 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
 
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
 
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

