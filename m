Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7555F160
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiF1WVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiF1WV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517583EF27
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454700; x=1687990700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wwhn1mmwOqrLKB18Ehs898zvgZ734NiGBT9pQl5s9Ag=;
  b=b/Y6PTHdBF4QzxlwhHDgiPE22C+S6xaiqk2kirGh3bzwjNHBKpcvZyGK
   7NUvMdaxDL1RyPct2pLaRhjDVXTPzwJ2ErIsxFXr1tX+tPU+qWawIREc9
   9xx/pgkOimWyMGJUnYKL/4S/qp7PhPZpSzGQOUzJPrDDRJ+ufnoeH5XNx
   qog+03XAU4FFwucyTbLyJY8YvGnpSB2G8tooDSf3LA8diBJpbqNavxNb0
   jtNTSwkC63MsbvqE4E8CWM386LgbyHHGPfsaRcc1oWa+adH6iB7WSpd8D
   9N09HETnJnGUXeJnkrgbR13GkWIUPJBkjy4da8qtr8m9bVfqqrwSjFyOp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270625376"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270625376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917349911"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 15:17:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EEF7A109; Wed, 29 Jun 2022 01:17:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 03/11] mfd: intel_soc_pmic_bxtwc: Convert to use platform_get/set_drvdata()
Date:   Wed, 29 Jun 2022 01:17:39 +0300
Message-Id: <20220628221747.33956-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the specific helpers for platform device to set and get
its driver data. Convert driver to use them instead of open coded
variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index d43cd18f5189..540bb31128c0 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -457,7 +457,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	pmic->irq = ret;
 
-	dev_set_drvdata(&pdev->dev, pmic);
+	platform_set_drvdata(pdev, pmic);
 	pmic->dev = &pdev->dev;
 
 	pmic->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
@@ -574,7 +574,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 
 static void bxtwc_shutdown(struct platform_device *pdev)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
+	struct intel_soc_pmic *pmic = platform_get_drvdata(pdev);
 
 	disable_irq(pmic->irq);
 }
-- 
2.35.1

