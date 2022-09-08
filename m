Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA65B1FC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiIHN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiIHN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294EF6B99;
        Thu,  8 Sep 2022 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645408; x=1694181408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0M4rURxAQdIUswdrgfXetFrt5wcmcw5VSJDicfcomI=;
  b=LpijGDeIx1AsqsPaYHvkW9I/OzaoMFW02i7i72h3cmwPbBZ4sulqLXvp
   TEXFhUktvHPK4Qv/PkIWHc9QJRkquOM2WTnUM9CnnIK+9DBA3BxF+tRzU
   tl9buUrfcAel/hJgdYT1KYNX4ktI8+qIkO4DoijN/ZVqZu4ms2WeKq+iI
   TNx+R5bmE+VyoqRjxKNxwLNXHESXNTRhuPCbyPk5MriztmSuEncIr1BEG
   YkQnghVCyIKBqfcde++mNJCQMASQZEQNTIuAghpa//Y3ryqXg2BRSWJ+9
   uVmzDggfhTWmYRafY0etH98r3rBTx/wjXHIF6En0+09s/PMhuLUsH0bLm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="358906738"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="358906738"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943352125"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 06:56:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77F7145C; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 3/9] pwm: lpss: Move resource mapping to the glue drivers
Date:   Thu,  8 Sep 2022 16:56:52 +0300
Message-Id: <20220908135658.64463-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
index 65154c0abab1..7bbbb7a9b578 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -21,16 +21,19 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
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
index 74a296cb1af0..a20915459809 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -243,7 +243,7 @@ static const struct pwm_ops pwm_lpss_ops = {
 	.owner = THIS_MODULE,
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
@@ -258,10 +258,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
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
index 9ea5b145a353..c344921b2cab 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -38,7 +38,7 @@ extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
 #endif	/* __PWM_LPSS_H */
-- 
2.35.1

