Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8054E948
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377204AbiFPSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiFPSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319C50456
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403932; x=1686939932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=paGa8Tg0cCU+errlVXIO7kI9hgtVHdESG8Z3bmC1BIE=;
  b=HeLg37oJDlj1/4ESkg/47OFQqYw0+CbW1l5ntmwesL48ytnGTDSIymP5
   plbpQlOZi5hs6LNqpyQSgQIKBQJUdoC8dUYaofGMWNEbJ+bGxvd2LcVSE
   rEF10teFGREnT6Rb0JaiLIa2fGaVnOroxdBiEMmkAxxNmbvpFDuIS6ZoC
   FWWnF8KRS+jaMU4byvcozkrOTU/RXSJMwE5icdtlFjIblbBh6PqSsk0Cj
   BCwgLXGUSsOAo/cnEsgcVH0ZSVGG6PzRRsK1wbeYh2UEtcoa2pN18YQgA
   PxnuW5Ep7mgrJMyPGHOGKVQxqsi/52lJ3sDDTyiapFWt/oH1BnA5FLnOX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280353751"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280353751"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="589759603"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 11:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1AA901C2; Thu, 16 Jun 2022 21:25:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/9] mfd: intel_soc_pmic_crc: Use devm_regmap_add_irq_chip()
Date:   Thu, 16 Jun 2022 21:25:18 +0300
Message-Id: <20220616182524.7956-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
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

Use devm_regmap_add_irq_chip() to simplify the code.

While at it, replace -1 magic parameter by PLATFORM_DEVID_NONE when
calling mfd_add_devices().

Note, the mfd_add_devices() left in non-devm variant here due to
potentially increased churn while wrapping pwm_remove_table().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index b5974dfcc603..187a4ede1148 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -189,10 +189,9 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 
 	pmic->irq = i2c->irq;
 
-	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
-				  config->irq_flags | IRQF_ONESHOT,
-				  0, config->irq_chip,
-				  &pmic->irq_chip_data);
+	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, pmic->irq,
+				       config->irq_flags | IRQF_ONESHOT,
+				       0, config->irq_chip, &pmic->irq_chip_data);
 	if (ret)
 		return ret;
 
@@ -207,25 +206,12 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
 				    DOMAIN_BUS_NEXUS);
 
-	ret = mfd_add_devices(dev, -1, config->cell_dev,
-			      config->n_cell_devs, NULL, 0,
-			      regmap_irq_get_domain(pmic->irq_chip_data));
-	if (ret)
-		goto err_del_irq_chip;
-
-	return 0;
-
-err_del_irq_chip:
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-	return ret;
+	return mfd_add_devices(dev, PLATFORM_DEVID_NONE, config->cell_dev, config->n_cell_devs,
+			       NULL, 0, regmap_irq_get_domain(pmic->irq_chip_data));
 }
 
 static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
-
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-
 	/* remove crc-pwm lookup table */
 	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
 
-- 
2.35.1

