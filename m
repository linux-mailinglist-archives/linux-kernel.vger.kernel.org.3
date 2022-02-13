Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84B4B3CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiBMRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiBMRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:55:17 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3361B5A5B4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:55:11 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JJ5WndLDvuvBOJJ5XnOK2P; Sun, 13 Feb 2022 18:55:09 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 18:55:09 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Support Opensource <support.opensource@diasemi.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: da9150-fg: Use devm_delayed_work_autocancel()
Date:   Sun, 13 Feb 2022 18:55:05 +0100
Message-Id: <c4cf74b56258c679f69bbc6350179b8b500f5800.1644774892.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver only uses managed resources, except for the delayed work, if
it is used.

Use devm_delayed_work_autocancel() to also manage the delayed work.
The error handling path of the probe and the remove function can both be
removed.

This saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/da9150-fg.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 6e367826aae9..e63fa62d1943 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -20,6 +20,7 @@
 #include <asm/div64.h>
 #include <linux/mfd/da9150/core.h>
 #include <linux/mfd/da9150/registers.h>
+#include <linux/devm-helpers.h>
 
 /* Core2Wire */
 #define DA9150_QIF_READ		(0x0 << 7)
@@ -506,7 +507,13 @@ static int da9150_fg_probe(struct platform_device *pdev)
 	 * work for reporting data updates.
 	 */
 	if (fg->interval) {
-		INIT_DELAYED_WORK(&fg->work, da9150_fg_work);
+		ret = devm_delayed_work_autocancel(dev, &fg->work,
+						   da9150_fg_work);
+		if (ret) {
+			dev_err(dev, "Failed to init work\n");
+			return ret;
+		}
+
 		schedule_delayed_work(&fg->work,
 				      msecs_to_jiffies(fg->interval));
 	}
@@ -515,34 +522,17 @@ static int da9150_fg_probe(struct platform_device *pdev)
 	irq = platform_get_irq_byname(pdev, "FG");
 	if (irq < 0) {
 		dev_err(dev, "Failed to get IRQ FG: %d\n", irq);
-		ret = irq;
-		goto irq_fail;
+		return irq;
 	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_fg_irq,
 					IRQF_ONESHOT, "FG", fg);
 	if (ret) {
 		dev_err(dev, "Failed to request IRQ %d: %d\n", irq, ret);
-		goto irq_fail;
+		return ret;
 	}
 
 	return 0;
-
-irq_fail:
-	if (fg->interval)
-		cancel_delayed_work(&fg->work);
-
-	return ret;
-}
-
-static int da9150_fg_remove(struct platform_device *pdev)
-{
-	struct da9150_fg *fg = platform_get_drvdata(pdev);
-
-	if (fg->interval)
-		cancel_delayed_work(&fg->work);
-
-	return 0;
 }
 
 static int da9150_fg_resume(struct platform_device *pdev)
@@ -564,7 +554,6 @@ static struct platform_driver da9150_fg_driver = {
 		.name = "da9150-fuel-gauge",
 	},
 	.probe = da9150_fg_probe,
-	.remove = da9150_fg_remove,
 	.resume = da9150_fg_resume,
 };
 
-- 
2.32.0

