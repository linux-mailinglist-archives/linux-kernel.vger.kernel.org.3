Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C154E94F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378049AbiFPS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377835AbiFPSZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060550E25
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403946; x=1686939946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJMGLf5g2N85lwf5XqTA9CkBEII67eDfoYqIrmf84Ew=;
  b=UntkYaLpSaF8dlnSWiHXCBUXrPnfJxvwmGVrxldfiGoFWfZnBCsD/1Zx
   OE10I/HyVSDK+5T+Qz8RVPqqaiTBLXmPifs/dgAAq3tmzCjLcn8W0q5vq
   OVo9KWt+95O/dIjGITKQDDsgWZtDTpVNqT5vW5STmzuHCSe6uk4hV84O0
   XvCGPS2xL7OPSgze5vIUQOjzaZVua7xh8HdcWZqFMF66R9Yk7p2e3swVV
   0VYrh06XdaK+ppSO+k2dYLCj//QkPbe155BbgI8peVrzSt326u3geAa1w
   jY9lzUvd7AXOwf24V+ivQ1kiPTeCzCfmLxLEnKGR+/ArlXy7RtkD5+rFf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259173787"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259173787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912277244"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2022 11:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E36D30C; Thu, 16 Jun 2022 21:25:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/9] mfd: intel_soc_pmic_crc: Convert to use i2c_get/set_clientdata()
Date:   Thu, 16 Jun 2022 21:25:19 +0300
Message-Id: <20220616182524.7956-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the specific helpers for I2C device to set and get its driver data.
Convert driver to use them instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 187a4ede1148..165f686132f6 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -181,7 +181,7 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	if (!pmic)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, pmic);
+	i2c_set_clientdata(i2c, pmic);
 
 	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
 	if (IS_ERR(pmic->regmap))
@@ -222,7 +222,7 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 
 static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
+	struct intel_soc_pmic *pmic = i2c_get_clientdata(i2c);
 
 	disable_irq(pmic->irq);
 
-- 
2.35.1

