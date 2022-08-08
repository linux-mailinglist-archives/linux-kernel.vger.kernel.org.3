Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57C58CCE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbiHHRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbiHHRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:42:47 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CFE116A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980502; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0q1o3KBhQ5MOOQZOY2QmugcO19dZJBIvTlnLlJG5KlM=;
        b=gpks2rpb90S3mLtn8MQn0ALlBxOSiy4cSMoGAXktbvzw6HY7U+RdlqbZ52aVm9CO4XPb7L
        OqJQczqagIXeG9a+P3d29J2NFtvnSOB6XngcqsI6LD96Oj6YFEKpxJlG7LjrX+xI2TNyqs
        xOB6M3ORoB0LKwLtGwuGMnAWj8c+/lE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 07/30] mfd: pcf50633: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:44 +0200
Message-Id: <20220808174107.38676-8-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
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

Use the new EXPORT_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/pcf50633-core.c       | 22 +---------------------
 drivers/mfd/pcf50633-irq.c        | 13 ++++++++-----
 include/linux/mfd/pcf50633/core.h |  6 ++----
 3 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index e9c565cf0f54..06d750d9a476 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -158,26 +158,6 @@ pcf50633_client_dev_register(struct pcf50633 *pcf, const char *name,
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pcf50633_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf50633 *pcf = i2c_get_clientdata(client);
-
-	return pcf50633_irq_suspend(pcf);
-}
-
-static int pcf50633_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf50633 *pcf = i2c_get_clientdata(client);
-
-	return pcf50633_irq_resume(pcf);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(pcf50633_pm, pcf50633_suspend, pcf50633_resume);
-
 static const struct regmap_config pcf50633_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -302,7 +282,7 @@ MODULE_DEVICE_TABLE(i2c, pcf50633_id_table);
 static struct i2c_driver pcf50633_driver = {
 	.driver = {
 		.name	= "pcf50633",
-		.pm	= &pcf50633_pm,
+		.pm	= pm_sleep_ptr(&pcf50633_pm),
 	},
 	.id_table = pcf50633_id_table,
 	.probe = pcf50633_probe,
diff --git a/drivers/mfd/pcf50633-irq.c b/drivers/mfd/pcf50633-irq.c
index 2096afb0ce9b..e85af7f1cb0b 100644
--- a/drivers/mfd/pcf50633-irq.c
+++ b/drivers/mfd/pcf50633-irq.c
@@ -7,6 +7,7 @@
  * All rights reserved.
  */
 
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
@@ -218,10 +219,10 @@ static irqreturn_t pcf50633_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_PM
-
-int pcf50633_irq_suspend(struct pcf50633 *pcf)
+static int pcf50633_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf50633 *pcf = i2c_get_clientdata(client);
 	int ret;
 	int i;
 	u8 res[5];
@@ -257,8 +258,10 @@ int pcf50633_irq_suspend(struct pcf50633 *pcf)
 	return ret;
 }
 
-int pcf50633_irq_resume(struct pcf50633 *pcf)
+static int pcf50633_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf50633 *pcf = i2c_get_clientdata(client);
 	int ret;
 
 	/* Write the saved mask registers */
@@ -273,7 +276,7 @@ int pcf50633_irq_resume(struct pcf50633 *pcf)
 	return ret;
 }
 
-#endif
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(pcf50633_pm, pcf50633_suspend, pcf50633_resume);
 
 int pcf50633_irq_init(struct pcf50633 *pcf, int irq)
 {
diff --git a/include/linux/mfd/pcf50633/core.h b/include/linux/mfd/pcf50633/core.h
index 3f752dc62a6c..539f27f8bd89 100644
--- a/include/linux/mfd/pcf50633/core.h
+++ b/include/linux/mfd/pcf50633/core.h
@@ -13,6 +13,7 @@
 #include <linux/workqueue.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/pm.h>
 #include <linux/power_supply.h>
 #include <linux/mfd/pcf50633/backlight.h>
 
@@ -226,9 +227,6 @@ static inline struct pcf50633 *dev_to_pcf50633(struct device *dev)
 
 int pcf50633_irq_init(struct pcf50633 *pcf, int irq);
 void pcf50633_irq_free(struct pcf50633 *pcf);
-#ifdef CONFIG_PM
-int pcf50633_irq_suspend(struct pcf50633 *pcf);
-int pcf50633_irq_resume(struct pcf50633 *pcf);
-#endif
+extern const struct dev_pm_ops pcf50633_pm;
 
 #endif
-- 
2.35.1

