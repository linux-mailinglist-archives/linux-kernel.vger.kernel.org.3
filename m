Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7E578230
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiGRMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiGRMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96325595
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147012; x=1689683012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X8yF1cDKRZPv2sLg2YUskLS+L4QfOlmqDEebGkDgjnc=;
  b=j0xLVeHXjGfM+5PRbv0ACk9fVaNVURDLdx5J/4SqGDhD6OlYJD4QAdjb
   W3YGuAqxKJvn4tD0qSodUthmTOZVVzZJ+flIb2EabYzlPK2UL/vn1aDnV
   lWJ/l2RRMSvTtm1M0RSpLGmj/tCcffjcirDjmUa+cnMMiX4OJpuBzg5pA
   b8BEJ2P6ylkigLbZNQ0FWc/idWv2GCdI74su7pEsWayxrLm6/MwBdKTmP
   FVL6mxSWmrrtPTjMpup8J9vUS3Ds2bBBCYWBBTvO7i7qBLEhajvmZnNcx
   ZM6qupX6IlKpOO/v7UQHXb0j1ZD0hOOSkKfuqHZplQD9E67beejz+GzC5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286947472"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="286947472"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="655255074"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2022 05:23:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3A7FE10E; Mon, 18 Jul 2022 15:23:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RESEND][PATCH v1 1/9] mfd: intel_soc_pmic_crc: Use devm_regmap_add_irq_chip()
Date:   Mon, 18 Jul 2022 15:23:20 +0300
Message-Id: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

