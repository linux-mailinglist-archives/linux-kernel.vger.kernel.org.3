Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C354F5AED02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbiIFODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiIFOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:00:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393483BE1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471850; x=1694007850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1u8OGEVRRnz2sJkebIyb/m4gWyjRqqV3cKCIjIyr6EM=;
  b=GV+FF9Yl1PALnOYFNXkAgs6LAbJReXbIt1Z+cGC3a+D885senWMbX7pZ
   vTt94xOxqkgUJtp3LDi05zG60azX5sJE3lRL3y/L1POMOp4mppJj93CPM
   xIUIGVC9J39L60mxd00+Q050KUmdNNJ1iCNuLhlZc3zudoAvdOPUz4rRV
   IYeTTRWs4tQHW4vYGGJSIXs3Bi/Om7ngLf9nype8WvIHoqRn5+SwngN8z
   JcVD5zfNIuWv+U7fhhuU5K4PUOltyhyaj/2jK8Tmbz+0RTcHHJM2FRKUW
   FcpglZEtFggZ1fMDUQLqW9GUtXttXPYnqi7OWajKG6FoUF1R+2S/7qReR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276332580"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276332580"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459444"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 06:42:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B29EF235; Tue,  6 Sep 2022 16:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>
Subject: [RESEND][PATCH v1 1/1] mfd: intel_soc_pmic_chtdc_ti: Switch from __maybe_unused to pm_sleep_ptr() etc
Date:   Tue,  6 Sep 2022 16:42:56 +0300
Message-Id: <20220906134256.14293-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less heavier for builds
than the use of __maybe_unused attributes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 1c7577b881ff..282b8fd08009 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -140,7 +140,7 @@ static void chtdc_ti_shutdown(struct i2c_client *i2c)
 	disable_irq(pmic->irq);
 }
 
-static int __maybe_unused chtdc_ti_suspend(struct device *dev)
+static int chtdc_ti_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
@@ -149,7 +149,7 @@ static int __maybe_unused chtdc_ti_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused chtdc_ti_resume(struct device *dev)
+static int chtdc_ti_resume(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
@@ -158,7 +158,7 @@ static int __maybe_unused chtdc_ti_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(chtdc_ti_pm_ops, chtdc_ti_suspend, chtdc_ti_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(chtdc_ti_pm_ops, chtdc_ti_suspend, chtdc_ti_resume);
 
 static const struct acpi_device_id chtdc_ti_acpi_ids[] = {
 	{ "INT33F5" },
@@ -169,7 +169,7 @@ MODULE_DEVICE_TABLE(acpi, chtdc_ti_acpi_ids);
 static struct i2c_driver chtdc_ti_i2c_driver = {
 	.driver = {
 		.name = "intel_soc_pmic_chtdc_ti",
-		.pm = &chtdc_ti_pm_ops,
+		.pm = pm_sleep_ptr(&chtdc_ti_pm_ops),
 		.acpi_match_table = chtdc_ti_acpi_ids,
 	},
 	.probe_new = chtdc_ti_probe,
-- 
2.35.1

