Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B009B55F112
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiF1WVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiF1WVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6AA3EF00
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454697; x=1687990697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Y7Sj01lJ1kC2q9PMAcD7kx3edHWeB9t+f+MHGuTfGE=;
  b=TYv6jXwZxCW0+jspCHKFa15sDa/IcLkeL9/NEzDrFrAPh2nio06pa+cg
   yceBgmizn4ygXjOU1KMqSXgsSvCPg56JY3cWPHBrgVftL3dYQIauLjGBR
   INOHkCYnWRW5VP7hRwZZsJV3i+Wd/365bfLFtNSvpyhVPzT06q1IwEtjm
   9DOdaaTw2mgBJuweNCIMBbCjOxEmr+6+ZxwvVgtv06W1/aa65Q4id6/PW
   66vYJZeU1CoW/kV2w6aZxS7/HYHDk/orEA33diThKecQV91iHU/5aM7r6
   GZxV4bAe8dfTC9/JNyD1VFLb3z4ec/6eFL2pVDAEJtx6r1rc4Zj2LJ+60
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="279407811"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="279407811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="693301198"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 15:17:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 066B1F1; Wed, 29 Jun 2022 01:17:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 05/11] mfd: intel_soc_pmic_bxtwc: Extend use of temporary variable for struct device
Date:   Wed, 29 Jun 2022 01:17:41 +0300
Message-Id: <20220628221747.33956-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 25ac2cf0ad37..bcecb3d75d5a 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -429,19 +429,17 @@ static int bxtwc_probe(struct platform_device *pdev)
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
 
@@ -451,18 +449,17 @@ static int bxtwc_probe(struct platform_device *pdev)
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
@@ -521,8 +518,8 @@ static int bxtwc_probe(struct platform_device *pdev)
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

