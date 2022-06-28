Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616055F127
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiF1WWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiF1WVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516813F8B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454714; x=1687990714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1VDD++BzUE1hzpUpZE2oQy01Deno21A1TOgoV00GTY=;
  b=V8+WikaI44us0bZGCieFKbweZe2ZpOaVN+ExNRyJiSf8DUk6XBZ7ND6P
   IIqbJGnTlUZtjFOwYGofIkOPR1HpFLqucVhTcYOmPphy+jvecm50a35sA
   VFaa7j8HQ+tV36+1Ay4ZhvrQQC9b8sZltZvs77kA0DRvMrD+x7pv/PEAX
   lJc6ZuRXYM3y0sXKjRTISKjCUzL7Lhd4erb/OtXY10d6VxVUQcL4LXw5Z
   lrgUuQWBLQczgNcGejpNEo4Lxb8y2jzuC2AvHzMuZu+CisMJka/9spRpX
   8gNQPabzXNXIfxVm1pGYucwtaR2TY0P3ZIx3DcaDMvn9mgd5lsQXi/s8U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280624292"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="280624292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="565215409"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2022 15:17:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0218414F; Wed, 29 Jun 2022 01:17:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 04/11] mfd: intel_soc_pmic_bxtwc: Use dev_err_probe()
Date:   Wed, 29 Jun 2022 01:17:40 +0300
Message-Id: <20220628221747.33956-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the mux error path a bit by using dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 86 +++++++++---------------------
 1 file changed, 26 insertions(+), 60 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 540bb31128c0..25ac2cf0ad37 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -417,12 +417,9 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
 	int irq;
 
 	irq = regmap_irq_get_virq(pdata, pirq);
-	if (irq < 0) {
-		dev_err(pmic->dev,
-			"Failed to get parent vIRQ(%d) for chip %s, ret:%d\n",
-			pirq, chip->name, irq);
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(pmic->dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
+				     pirq, chip->name);
 
 	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
 					0, chip, data);
@@ -430,6 +427,7 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
 
 static int bxtwc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	acpi_handle handle;
 	acpi_status status;
@@ -438,15 +436,10 @@ static int bxtwc_probe(struct platform_device *pdev)
 
 	handle = ACPI_HANDLE(&pdev->dev);
 	status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
-	if (ACPI_FAILURE(status)) {
-		dev_err(&pdev->dev, "Failed to get PMIC hardware revision\n");
-		return -ENODEV;
-	}
-	if (hrv != BROXTON_PMIC_WC_HRV) {
-		dev_err(&pdev->dev, "Invalid PMIC hardware revision: %llu\n",
-			hrv);
-		return -ENODEV;
-	}
+	if (ACPI_FAILURE(status))
+		return dev_err_probe(dev, -ENODEV, "Failed to get PMIC hardware revision\n");
+	if (hrv != BROXTON_PMIC_WC_HRV)
+		return dev_err_probe(dev, -ENODEV, "Invalid PMIC hardware revision: %llu\n", hrv);
 
 	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
@@ -466,40 +459,31 @@ static int bxtwc_probe(struct platform_device *pdev)
 
 	pmic->regmap = devm_regmap_init(&pdev->dev, NULL, pmic,
 					&bxtwc_regmap_config);
-	if (IS_ERR(pmic->regmap)) {
-		ret = PTR_ERR(pmic->regmap);
-		dev_err(&pdev->dev, "Failed to initialise regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(pmic->regmap))
+		return dev_err_probe(dev, PTR_ERR(pmic->regmap), "Failed to initialise regmap\n");
 
 	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
 				       IRQF_ONESHOT | IRQF_SHARED,
 				       0, &bxtwc_regmap_irq_chip,
 				       &pmic->irq_chip_data);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
 
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_PWRBTN_LVL1_IRQ,
 					 IRQF_ONESHOT,
 					 &bxtwc_regmap_irq_chip_pwrbtn,
 					 &pmic->irq_chip_data_pwrbtn);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add PWRBTN IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
 
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_TMU_LVL1_IRQ,
 					 IRQF_ONESHOT,
 					 &bxtwc_regmap_irq_chip_tmu,
 					 &pmic->irq_chip_data_tmu);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add TMU IRQ chip\n");
 
 	/* Add chained IRQ handler for BCU IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
@@ -507,12 +491,8 @@ static int bxtwc_probe(struct platform_device *pdev)
 					 IRQF_ONESHOT,
 					 &bxtwc_regmap_irq_chip_bcu,
 					 &pmic->irq_chip_data_bcu);
-
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add BUC IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add BUC IRQ chip\n");
 
 	/* Add chained IRQ handler for ADC IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
@@ -520,12 +500,8 @@ static int bxtwc_probe(struct platform_device *pdev)
 					 IRQF_ONESHOT,
 					 &bxtwc_regmap_irq_chip_adc,
 					 &pmic->irq_chip_data_adc);
-
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add ADC IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add ADC IRQ chip\n");
 
 	/* Add chained IRQ handler for CHGR IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
@@ -533,12 +509,8 @@ static int bxtwc_probe(struct platform_device *pdev)
 					 IRQF_ONESHOT,
 					 &bxtwc_regmap_irq_chip_chgr,
 					 &pmic->irq_chip_data_chgr);
-
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add CHGR IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add CHGR IRQ chip\n");
 
 	/* Add chained IRQ handler for CRIT IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
@@ -546,19 +518,13 @@ static int bxtwc_probe(struct platform_device *pdev)
 					 IRQF_ONESHOT,
 					 &bxtwc_regmap_irq_chip_crit,
 					 &pmic->irq_chip_data_crit);
-
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add CRIT IRQ chip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add CRIT IRQ chip\n");
 
 	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
 				   ARRAY_SIZE(bxt_wc_dev), NULL, 0, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add devices\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add devices\n");
 
 	/*
 	 * There is known hw bug. Upon reset BIT 5 of register
-- 
2.35.1

