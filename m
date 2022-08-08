Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544CD58CCF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbiHHRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbiHHRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:46:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519A2A9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980508; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nm3hS48ke9l6IizQfggjexVF2N4X4ZQswbOsOcQR18c=;
        b=ndX241lw+3mwUm/BWixhAzeXUaBmrRmvRlBKREEyk1S9Hr2pH8i9mJGXxQ12vMw+RhiXap
        DboZ42ocoL3gDU9MLUeyv1ngZTR87WPrt6gmg89VjeEfL8CAQoXfMcFO10GDey0PSHGEKi
        G05x+auvzUK2FewhjGXj2ZZrGm1978A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 30/30] mfd: intel-lpss: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:41:07 +0200
Message-Id: <20220808174107.38676-31-paul@crapouillou.net>
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

Use the new EXPORT_GPL_DEV_PM_OPS() and pm_sleep_ptr() / pm_ptr() macros
to handle the PM callbacks.

These macros allow the PM functions to be automatically dropped by the
compiler when CONFIG_SUSPEND is disabled, without having to use #ifdef
guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Note that instead of exporting two dev_pm_ops structures containing the
exact same data, one in intel-lpss-acpi.c and one in intel-lpss-pci.c,
we export one single dev_pm_ops structure from intel-lpss.c using the
EXPORT_GP_DEV_PM_OPS() macro, which is then referenced from the -acpi.c
and -pci.c files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/intel-lpss-acpi.c |  4 +---
 drivers/mfd/intel-lpss-pci.c  |  4 +---
 drivers/mfd/intel-lpss.c      | 15 +++++++++------
 drivers/mfd/intel-lpss.h      | 28 +---------------------------
 4 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index a143c8dca2d9..1d46a7aa1c61 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -203,15 +203,13 @@ static int intel_lpss_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static INTEL_LPSS_PM_OPS(intel_lpss_acpi_pm_ops);
-
 static struct platform_driver intel_lpss_acpi_driver = {
 	.probe = intel_lpss_acpi_probe,
 	.remove = intel_lpss_acpi_remove,
 	.driver = {
 		.name = "intel-lpss",
 		.acpi_match_table = intel_lpss_acpi_ids,
-		.pm = &intel_lpss_acpi_pm_ops,
+		.pm = pm_ptr(&intel_lpss_pm_ops),
 	},
 };
 
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index bb08b7a73fe1..25f34cf05432 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -71,8 +71,6 @@ static void intel_lpss_pci_remove(struct pci_dev *pdev)
 	intel_lpss_remove(&pdev->dev);
 }
 
-static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
-
 static const struct intel_lpss_platform_info spt_info = {
 	.clk_rate = 120000000,
 };
@@ -507,7 +505,7 @@ static struct pci_driver intel_lpss_pci_driver = {
 	.probe = intel_lpss_pci_probe,
 	.remove = intel_lpss_pci_remove,
 	.driver = {
-		.pm = &intel_lpss_pci_pm_ops,
+		.pm = pm_ptr(&intel_lpss_pm_ops),
 	},
 };
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index cfbee2cfba6b..9cdd0b52f8d8 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -468,7 +468,7 @@ static int resume_lpss_device(struct device *dev, void *data)
 	return 0;
 }
 
-int intel_lpss_prepare(struct device *dev)
+static int intel_lpss_prepare(struct device *dev)
 {
 	/*
 	 * Resume both child devices before entering system sleep. This
@@ -477,9 +477,8 @@ int intel_lpss_prepare(struct device *dev)
 	device_for_each_child_reverse(dev, NULL, resume_lpss_device);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_prepare);
 
-int intel_lpss_suspend(struct device *dev)
+static int intel_lpss_suspend(struct device *dev)
 {
 	struct intel_lpss *lpss = dev_get_drvdata(dev);
 	unsigned int i;
@@ -498,9 +497,8 @@ int intel_lpss_suspend(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_suspend);
 
-int intel_lpss_resume(struct device *dev)
+static int intel_lpss_resume(struct device *dev)
 {
 	struct intel_lpss *lpss = dev_get_drvdata(dev);
 	unsigned int i;
@@ -513,7 +511,12 @@ int intel_lpss_resume(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_resume);
+
+EXPORT_GPL_DEV_PM_OPS(intel_lpss_pm_ops) = {
+	.prepare = pm_sleep_ptr(intel_lpss_prepare),
+	LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
+	RUNTIME_PM_OPS(intel_lpss_suspend, intel_lpss_resume, NULL)
+};
 
 static int __init intel_lpss_init(void)
 {
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 062ce95b68b9..c1d72b117ed5 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -30,32 +30,6 @@ int intel_lpss_probe(struct device *dev,
 		     const struct intel_lpss_platform_info *info);
 void intel_lpss_remove(struct device *dev);
 
-#ifdef CONFIG_PM
-int intel_lpss_prepare(struct device *dev);
-int intel_lpss_suspend(struct device *dev);
-int intel_lpss_resume(struct device *dev);
-
-#ifdef CONFIG_PM_SLEEP
-#define INTEL_LPSS_SLEEP_PM_OPS			\
-	.prepare = intel_lpss_prepare,		\
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
-#else
-#define INTEL_LPSS_SLEEP_PM_OPS
-#endif
-
-#define INTEL_LPSS_RUNTIME_PM_OPS		\
-	.runtime_suspend = intel_lpss_suspend,	\
-	.runtime_resume = intel_lpss_resume,
-
-#else /* !CONFIG_PM */
-#define INTEL_LPSS_SLEEP_PM_OPS
-#define INTEL_LPSS_RUNTIME_PM_OPS
-#endif /* CONFIG_PM */
-
-#define INTEL_LPSS_PM_OPS(name)			\
-const struct dev_pm_ops name = {		\
-	INTEL_LPSS_SLEEP_PM_OPS			\
-	INTEL_LPSS_RUNTIME_PM_OPS		\
-}
+extern const struct dev_pm_ops intel_lpss_pm_ops;
 
 #endif /* __MFD_INTEL_LPSS_H */
-- 
2.35.1

