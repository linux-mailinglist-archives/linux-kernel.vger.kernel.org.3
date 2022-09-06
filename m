Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D45AF542
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIFUED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiIFUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:03:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2C3A489;
        Tue,  6 Sep 2022 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494341; x=1694030341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3QJCpzgRCnUz4yyccAi/oO2t5HlZBvGdGKxNCfeQF40=;
  b=hq6VwI9QiNL0Dp37ogrSouHxApn4goAjx+gJyIlOJj9l/+8p4WzB2xn6
   laOKMKsk2XMfuK96symJEDL9TMdwDGSKgOBNCgmbmfdxQCPHeNDFuEP/1
   dfCbfsFW3PDXvGXsTgFtUzNlmAGs5FcmnJgo0GSaGqOSlwbC6xx2St1rm
   iACDIuqVuP4oE6XvQSpxH0eSk5nH1JR6kzOcIFzu8TJ5bXP+KIXmepUXM
   yF1WoidG5/Sj7XTdi14+RgKlffKhvxtYZGfUtxtbwr2ijN/qYZG7ilgMX
   yowZ7aVcEMofA7RJ8nEObyr82WSFqztSFgnb1P4QZU5d9uGpojqzCXXBs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279705038"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279705038"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="610070479"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2022 12:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 290E3363; Tue,  6 Sep 2022 22:57:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 6/9] pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue,  6 Sep 2022 22:57:32 +0300
Message-Id: <20220906195735.87361-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using these new macros allows the compiler to remove the unused dev_pm_ops
structure and related functions if !CONFIG_PM without the need to mark
the functions __maybe_unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index f3367e844e61..98413d364338 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -48,7 +48,6 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 }
 
-#ifdef CONFIG_PM
 static int pwm_lpss_runtime_suspend_pci(struct device *dev)
 {
 	/*
@@ -62,12 +61,11 @@ static int pwm_lpss_runtime_resume_pci(struct device *dev)
 {
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops pwm_lpss_pci_pm = {
-	SET_RUNTIME_PM_OPS(pwm_lpss_runtime_suspend_pci,
-			   pwm_lpss_runtime_resume_pci, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(pwm_lpss_pci_pm,
+				 pwm_lpss_runtime_suspend_pci,
+				 pwm_lpss_runtime_resume_pci,
+				 NULL);
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
@@ -89,7 +87,7 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
 	.driver = {
-		.pm = &pwm_lpss_pci_pm,
+		.pm = pm_ptr(&pwm_lpss_pci_pm),
 	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
-- 
2.35.1

