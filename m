Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0254E833
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiFPQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiFPQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052853EA83
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398709; x=1686934709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WyKLe8wMrYa0Tun5HkvsqWs58Xg5Hbtvc/VW/55cM2o=;
  b=Ct+4jwbsflchFiYbw2slKNsgg9FL5+0+otEMKaaJqkR9HXQs56VcQjy8
   KgsbXIcB5Go7zlhIHju813N55zw7OOK2hzEA0MhzxSCMaYzR5WwpdpXX4
   mb1vvFoNW4STf6/7fHNfNkwMctFk9GAQb6X2YRvtHAhxqJZJ3AS/uqXao
   k9xoemxb35bE4J8tYnLXHFJRnHehHOomUu8dt9dZf9TIkCuH9KlO+jmem
   kmcA65QhGioxnDWlPtO7HNSiplsN1pvisxkcJfHSiJQQivNrVy4lYTNe2
   LcIb9+zHRyxxKcCg7qb+5i8yD79y9TdMFOBCkaqdE8tL6cOIsjLfPsMtP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343254641"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="343254641"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="575338308"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2022 09:58:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E66767; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 02/11] mfd: intel_soc_pmic_bxtwc: Create sysfs attributes using core driver's facility
Date:   Thu, 16 Jun 2022 19:58:14 +0300
Message-Id: <20220616165823.4919-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
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

Driver core takes care of sysfs attributes. Use this facility instead of
doing it explicitly in ->probe() and ->remove().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 3148a319d467..fbf421d56a73 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -398,6 +398,11 @@ static const struct attribute_group bxtwc_group = {
 	.attrs = bxtwc_attrs,
 };
 
+static const struct attribute_group *bxtwc_groups[] = {
+	&bxtwc_group,
+	NULL
+};
+
 static const struct regmap_config bxtwc_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
@@ -557,12 +562,6 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &bxtwc_group);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to create sysfs group %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * There is known hw bug. Upon reset BIT 5 of register
 	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
@@ -570,15 +569,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 	 * have the software workaround here to unmaksed it in order to let
 	 * charger interrutp work.
 	 */
-	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1,
-				BXTWC_MIRQLVL1_MCHGR, 0);
-
-	return 0;
-}
-
-static int bxtwc_remove(struct platform_device *pdev)
-{
-	sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
+	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1, BXTWC_MIRQLVL1_MCHGR, 0);
 
 	return 0;
 }
@@ -618,12 +609,12 @@ MODULE_DEVICE_TABLE(acpi, bxtwc_acpi_ids);
 
 static struct platform_driver bxtwc_driver = {
 	.probe = bxtwc_probe,
-	.remove	= bxtwc_remove,
 	.shutdown = bxtwc_shutdown,
 	.driver	= {
 		.name	= "BXTWC PMIC",
 		.pm     = &bxtwc_pm_ops,
 		.acpi_match_table = ACPI_PTR(bxtwc_acpi_ids),
+		.dev_groups = bxtwc_groups,
 	},
 };
 
-- 
2.35.1

