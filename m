Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED955F10B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiF1WWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiF1WVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A203F30D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454702; x=1687990702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVm7d+GzAJ2HCILsAaW3XjBI/RpLsOVXiPXLQJl7IbM=;
  b=KKsO+q3GieE7GdgDNJo/Z2PHRNBrmlz7xRSeJYVxuHrXvhcS6e2kxBD3
   rq10ZZ0OzLIXF9e6OYG6dJJppI3qrglPaTZdOXKSSJ9dmPrN1GkQ370+I
   3Zpg2EMZlkJ6Yej74fcOg83RtMQ/nmt9xvjdZG29J8/IgSr1/6UwDOv0s
   UYR/pETrVd6ss/z6wmw4T9vy3HT2jWlrGiUnLXXY61CuEZqrE31nPWWyZ
   rDL4F8WGo6mO7n8VeLyF0irjc9sDD+GVetRlInse9+8k5hAYdyk30931q
   UbwA1rixucFXX50CVsmJuRC6AtZa/sRsXt9oiJw3t33u7CpIT7yh63JJ8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270625380"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270625380"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917349917"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 15:17:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1036B3EE; Wed, 29 Jun 2022 01:17:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 06/11] mfd: intel_soc_pmic_bxtwc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Wed, 29 Jun 2022 01:17:42 +0300
Message-Id: <20220628221747.33956-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index bcecb3d75d5a..7c3ce440c826 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -542,7 +542,6 @@ static void bxtwc_shutdown(struct platform_device *pdev)
 	disable_irq(pmic->irq);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bxtwc_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
@@ -559,8 +558,8 @@ static int bxtwc_resume(struct device *dev)
 	enable_irq(pmic->irq);
 	return 0;
 }
-#endif
-static SIMPLE_DEV_PM_OPS(bxtwc_pm_ops, bxtwc_suspend, bxtwc_resume);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(bxtwc_pm_ops, bxtwc_suspend, bxtwc_resume);
 
 static const struct acpi_device_id bxtwc_acpi_ids[] = {
 	{ "INT34D3", },
@@ -573,7 +572,7 @@ static struct platform_driver bxtwc_driver = {
 	.shutdown = bxtwc_shutdown,
 	.driver	= {
 		.name	= "BXTWC PMIC",
-		.pm     = &bxtwc_pm_ops,
+		.pm     = pm_sleep_ptr(&bxtwc_pm_ops),
 		.acpi_match_table = ACPI_PTR(bxtwc_acpi_ids),
 		.dev_groups = bxtwc_groups,
 	},
-- 
2.35.1

