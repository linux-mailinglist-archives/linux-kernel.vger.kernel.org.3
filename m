Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33254E838
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiFPQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiFPQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058363EA9B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398708; x=1686934708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EjSoLutApiOR+f9e/jhmXXKKWXEemXiZeF3zc0lqGL0=;
  b=bVj6teIAmVfE4AiaVXzJujNX2rWmXpIH6S6o0nFcAEocZCMSavpLvukW
   6Hv4pyZEnEJc1Iplh4GqSvdlb7BgSXgcAAL3ZpYBJFvOh31Gv5uyKnpkt
   qGoAdPMKqBW8+g1MllnwCW4UMK8EKGckgVhrDhTVbZBCIUKfmhLZe+pG+
   UtjKXSbQLuT4IB4KTNxPEBcuQBMFEHjBWBJWJlbwZWJyaMEUAcwBNiNMD
   THIeJlvSJMJ9hTsNMcavprTYErFSrlTL9Yrcs6RW1MJJnOmvzY6uEkOhO
   LVvZcDRqVDj9uqHknV44ElX0V71O4ijAAFTRBbXMKuSYgQTLSDAOszbbd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279352784"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="279352784"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="583704657"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 09:58:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6DAD61D0; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 05/11] mfd: intel_soc_pmic_bxtwc: Extend use of temporary variable for struct device
Date:   Thu, 16 Jun 2022 19:58:17 +0300
Message-Id: <20220616165823.4919-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend use of temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 576fe55bd4d4..a211c70d532b 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -431,19 +431,17 @@ static int bxtwc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int ret;
-	acpi_handle handle;
 	acpi_status status;
 	unsigned long long hrv;
 	struct intel_soc_pmic *pmic;
 
-	handle = ACPI_HANDLE(&pdev->dev);
-	status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
+	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_HRV", NULL, &hrv);
 	if (ACPI_FAILURE(status))
 		return dev_err_probe(dev, -ENODEV, "Failed to get PMIC hardware revision\n");
 	if (hrv != BROXTON_PMIC_WC_HRV)
 		return dev_err_probe(dev, -ENODEV, "Invalid PMIC hardware revision: %llu\n", hrv);
 
-	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
+	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
 		return -ENOMEM;
 
@@ -453,18 +451,17 @@ static int bxtwc_probe(struct platform_device *pdev)
 	pmic->irq = ret;
 
 	platform_set_drvdata(pdev, pmic);
-	pmic->dev = &pdev->dev;
+	pmic->dev = dev;
 
-	pmic->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
+	pmic->scu = devm_intel_scu_ipc_dev_get(dev);
 	if (!pmic->scu)
 		return -EPROBE_DEFER;
 
-	pmic->regmap = devm_regmap_init(&pdev->dev, NULL, pmic,
-					&bxtwc_regmap_config);
+	pmic->regmap = devm_regmap_init(dev, NULL, pmic, &bxtwc_regmap_config);
 	if (IS_ERR(pmic->regmap))
 		return dev_err_probe(dev, PTR_ERR(pmic->regmap), "Failed to initialise regmap\n");
 
-	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
+	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, pmic->irq,
 				       IRQF_ONESHOT | IRQF_SHARED,
 				       0, &bxtwc_regmap_irq_chip,
 				       &pmic->irq_chip_data);
@@ -523,8 +520,8 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add CRIT IRQ chip\n");
 
-	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
-				   ARRAY_SIZE(bxt_wc_dev), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, bxt_wc_dev, ARRAY_SIZE(bxt_wc_dev),
+				   NULL, 0, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add devices\n");
 
-- 
2.35.1

