Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19F454E874
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377652AbiFPRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377645AbiFPRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:12:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA68E20182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655399570; x=1686935570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1u8OGEVRRnz2sJkebIyb/m4gWyjRqqV3cKCIjIyr6EM=;
  b=mzUKYq5CXYrVF1XpuDoGMuRaI33Oyz4v2arO0DzJjpNLqKIl4CHkP7WD
   8kqR7ICxuF/aBdSo5dfjQImWTunKPhZSdlLnpFTW1O4tix+hrrrq1RjNx
   Dv/3e7qcreJ5qX+djEUUrcCqLg7TlmPq3m76lbgOS0StvGOK4VwSxHJgN
   sKP5awGrQgxg/FYzCvgLOsiwJBhU9GhgYL9CAkTmxU5fnwLV1AGDrT492
   NS1uvCIuuXjSZVxBnrILDG5NhXxSZwZX+vus/xxcvSNGfGUm6BWcOmQfl
   nKxdUTeAG2mzqYCYS8sGOxdf9ASv/mQBpAEBNFJg8eUuhieXlO1zyPiv7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278096269"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="278096269"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 10:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="675109828"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2022 10:12:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D665109; Thu, 16 Jun 2022 20:12:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/1] mfd: intel_soc_pmic_chtdc_ti: Switch from __maybe_unused to pm_sleep_ptr() etc
Date:   Thu, 16 Jun 2022 20:12:34 +0300
Message-Id: <20220616171234.43729-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

