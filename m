Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5E154E83E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiFPQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiFPQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C553CFF7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398709; x=1686934709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kd1sPATLV8V7rJutIith2BBv0gO4IXVCokwG+gGWz14=;
  b=i3370S5hAzbgAPeaJy6oRchDyRVrGW9f8tRgK9bXelmo/ceRjDKu4MPF
   KScJ1mFp0oSRz1NY4ZPPNzGTn8GA8ilfMmXR98S8pqI2T/wfeH2mTwq7l
   UwI/NwNllRT/LkDmXFW9RruEeJh+ArxgLk797/lJDEutQnd6eDVAa/9A7
   5pf/4hUegP9OYMnZyb0jDXcbg36eX7NBI7sAS2Py+aSqCHU2/t7CtV+wY
   0fpZ8I5KXF2DPoWqiIweaF+k5yeEGmQ5lKUYWD7bYqxkmaPEPRqny7joP
   n1jdCD7MLTIZtfHVwXwV+xskZqU+VncHmvn3jll2FB5/RNkf0/DrX9dCX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280327616"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="280327616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="653235708"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2022 09:58:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 576F41C2; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 03/11] mfd: intel_soc_pmic_bxtwc: Convert to use platform_get/set_drvdata()
Date:   Thu, 16 Jun 2022 19:58:15 +0300
Message-Id: <20220616165823.4919-3-andriy.shevchenko@linux.intel.com>
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

We have the specific helpers for platform device to set and get
its driver data. Convert driver to use them instead of open coded
variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index fbf421d56a73..b240baeb0c94 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -459,7 +459,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	pmic->irq = ret;
 
-	dev_set_drvdata(&pdev->dev, pmic);
+	platform_set_drvdata(pdev, pmic);
 	pmic->dev = &pdev->dev;
 
 	pmic->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
@@ -576,7 +576,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 
 static void bxtwc_shutdown(struct platform_device *pdev)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
+	struct intel_soc_pmic *pmic = platform_get_drvdata(pdev);
 
 	disable_irq(pmic->irq);
 }
-- 
2.35.1

