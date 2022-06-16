Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A213B54E945
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377172AbiFPSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiFPSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FA41F9D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403931; x=1686939931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xtsloODx2Xan8hpnAY3csMl8yBgnHRVt/uQ5mEbOaYY=;
  b=Gh6gg8rinaySWdbE4j9L3CLiow1x5qtKSXlZYICpyTviihE2kcl7wFO1
   vsDRe7x442MZok7eia5m6brvYKjMqE2S8DNdOIHt9rOHgbng3vepFQfoC
   +joeHMGMY//XbInLQa8oCFcSlkOMyVi5V6q3RUd8vCJLwHlEhTrLFqxYV
   SIN4wDSoq2SWYsjFbwbaGKXSz48Mimf2iBl6S2JeCwSu5+UfTcwJPxCoU
   5K8XlVK5p3f2C6MsSOrqbOW4FxF4aN0Glc4JKdky2u4Td2xucDpwQ7JkS
   zzUE+onP5vcJfM/GutOOIu1K6gVzL6Lci2R1v7E9pS3JpaRpolg6K+rd3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279378949"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279378949"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831678364"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 11:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3810E1D0; Thu, 16 Jun 2022 21:25:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 5/9] mfd: intel_soc_pmic_crc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Thu, 16 Jun 2022 21:25:20 +0300
Message-Id: <20220616182524.7956-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
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

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 165f686132f6..c034e226a0bb 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -229,7 +229,6 @@ static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 	return;
 }
 
-#if defined(CONFIG_PM_SLEEP)
 static int intel_soc_pmic_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
@@ -247,10 +246,8 @@ static int intel_soc_pmic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
-			 intel_soc_pmic_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(crystal_cove_pm_ops, intel_soc_pmic_suspend, intel_soc_pmic_resume);
 
 static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
 	{ }
@@ -268,7 +265,7 @@ MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
 static struct i2c_driver intel_soc_pmic_i2c_driver = {
 	.driver = {
 		.name = "intel_soc_pmic_i2c",
-		.pm = &intel_soc_pmic_pm_ops,
+		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
 		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
 	},
 	.probe = intel_soc_pmic_i2c_probe,
-- 
2.35.1

