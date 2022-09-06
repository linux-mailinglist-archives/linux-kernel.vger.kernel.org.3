Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161CA5AF556
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiIFUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiIFUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:05:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C1BD175;
        Tue,  6 Sep 2022 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494450; x=1694030450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iq1Y9qzevbXHQV0PMTlCthi3beONg7fz4bV5MI/m6y4=;
  b=M6BXCBHbOGN3zvi9oLzQIhvP1A+S/3yxa/pNBXdjCXO4UpXTergRLhNu
   4YGwQm7HN8poLnMGnnBMWjvNGV+xEyNB6PtjXsdGVyeadBobmuvkN+A2p
   8X9TtkDX1nOeDxKmxN+S+XiIt82cdk16rvF7RELShgazO0CzON/4wdPg8
   lVlZGqkszBFZ/1KpSDYZE8QZblUN2hVUPJjMibGcMArXZ3eWXplmRmntO
   OjhfOXQI6r56U5Avbup/JEq7pnOQgZyJyX5vSyRgCKElddv28kwdv6Z/q
   dzb/Onk862EkWUoEPn+nJU4HYt4lV/tTIIJ/uWFn69mO+Kr8AmnRN3BBS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296692324"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296692324"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="717838948"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2022 12:57:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0EA4E238; Tue,  6 Sep 2022 22:57:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 3/9] pwm: lpss: Move resource mapping to the glue drivers
Date:   Tue,  6 Sep 2022 22:57:29 +0300
Message-Id: <20220906195735.87361-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move resource mapping to the glue drivers which helps
to transform pwm_lpss_probe() to pure library function
that may be used by others without need of specific
resource management.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 6 +++++-
 drivers/pwm/pwm-lpss-platform.c | 9 ++++++---
 drivers/pwm/pwm-lpss.c          | 7 ++-----
 drivers/pwm/pwm-lpss.h          | 2 +-
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 9f2c666b95ec..f3367e844e61 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -25,8 +25,12 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 	if (err < 0)
 		return err;
 
+	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (err)
+		return err;
+
 	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
+	lpwm = pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 96fde1b2b967..af57472f3ddc 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -20,16 +20,19 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	const struct pwm_lpss_boardinfo *info;
 	const struct acpi_device_id *id;
 	struct pwm_lpss_chip *lpwm;
-	struct resource *r;
+	void __iomem *base;
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
 	if (!id)
 		return -ENODEV;
 
 	info = (const struct pwm_lpss_boardinfo *)id->driver_data;
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	lpwm = pwm_lpss_probe(&pdev->dev, r, info);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	lpwm = pwm_lpss_probe(&pdev->dev, base, info);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index a82a57eb2482..44f9bb80611d 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -207,7 +207,7 @@ static const struct pwm_ops pwm_lpss_ops = {
 	.owner = THIS_MODULE,
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
@@ -222,10 +222,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	if (!lpwm)
 		return ERR_PTR(-ENOMEM);
 
-	lpwm->regs = devm_ioremap_resource(dev, r);
-	if (IS_ERR(lpwm->regs))
-		return ERR_CAST(lpwm->regs);
-
+	lpwm->regs = base;
 	lpwm->info = info;
 
 	c = lpwm->info->clk_rate;
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 3864f32c2487..5995b6b750a8 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -63,7 +63,7 @@ static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
 	.base_unit_bits = 22,
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
 #endif	/* __PWM_LPSS_H */
-- 
2.35.1

