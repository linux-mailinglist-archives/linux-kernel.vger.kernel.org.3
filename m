Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63658BB65
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiHGOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiHGOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:54:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C361BAE44
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883984; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0jy5GL2jcyHt/0fssuM/k0AGfDYo0++8BhJmUjKUqw=;
        b=W0OW4Y7Rq/zb41lyviUJVHp6eOn8he7byoIwKRvgzbY/vwA8uP2kvdolTc1BD70N1Bgo/K
        miJFfo0O34am+a6bFBVV9wmqzNap87T9GiQJSvqXwl0GoF6kYeTlp/zNGfeuID7xluaHOY
        CB8cmMryySVV3+aqAwZyA3v/Hq0E46Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 11/28] mfd: intel_soc_pmic: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:30 +0200
Message-Id: <20220807145247.46107-12-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-1-paul@crapouillou.net>
References: <20220807145247.46107-1-paul@crapouillou.net>
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

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +++----
 drivers/mfd/intel_soc_pmic_core.c  | 8 +++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index bc069c4daa60..7110d91f7ace 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -586,7 +586,6 @@ static void bxtwc_shutdown(struct platform_device *pdev)
 	disable_irq(pmic->irq);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bxtwc_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
@@ -603,8 +602,8 @@ static int bxtwc_resume(struct device *dev)
 	enable_irq(pmic->irq);
 	return 0;
 }
-#endif
-static SIMPLE_DEV_PM_OPS(bxtwc_pm_ops, bxtwc_suspend, bxtwc_resume);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(bxtwc_pm_ops, bxtwc_suspend, bxtwc_resume);
 
 static const struct acpi_device_id bxtwc_acpi_ids[] = {
 	{ "INT34D3", },
@@ -618,7 +617,7 @@ static struct platform_driver bxtwc_driver = {
 	.shutdown = bxtwc_shutdown,
 	.driver	= {
 		.name	= "BXTWC PMIC",
-		.pm     = &bxtwc_pm_ops,
+		.pm     = pm_sleep_ptr(&bxtwc_pm_ops),
 		.acpi_match_table = ACPI_PTR(bxtwc_acpi_ids),
 	},
 };
diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index 5e8c94e008ed..96303aa87bc1 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -104,7 +104,6 @@ static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 	return;
 }
 
-#if defined(CONFIG_PM_SLEEP)
 static int intel_soc_pmic_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
@@ -122,10 +121,9 @@ static int intel_soc_pmic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
-			 intel_soc_pmic_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
+				intel_soc_pmic_resume);
 
 static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
 	{ }
@@ -143,7 +141,7 @@ MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
 static struct i2c_driver intel_soc_pmic_i2c_driver = {
 	.driver = {
 		.name = "intel_soc_pmic_i2c",
-		.pm = &intel_soc_pmic_pm_ops,
+		.pm = pm_sleep_ptr(&intel_soc_pmic_pm_ops),
 		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
 	},
 	.probe = intel_soc_pmic_i2c_probe,
-- 
2.35.1

