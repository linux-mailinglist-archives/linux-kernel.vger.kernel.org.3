Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3706F53B7F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiFBLmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiFBLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:42:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25D1C135;
        Thu,  2 Jun 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654170163; x=1685706163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r59DOTKfmbD3UfLH7+rNLfWtHDf0kEEy8/nDrqC2AX0=;
  b=hJ4mfmWekrwFSnqVR6CNr1JfDhYO1Lvdx3VOPX50pNnwMzLl7h5eg0s3
   5iQ2661ZjnrNy3ztGtwr9/eU9VSZBX34rLehndITUoCVfC66nHU9oIB+n
   a6gbsiEMaJU4jgtW9dly/9Ox5y7dAQHfBHm18iSD3/NOQzth4lcQjEAs0
   xAF2ilfe7mmjRqHpQNzWeZ8JUlJh8ZYTCPI3Uclyfjmo3R5fVV+7J1iL8
   o3GdU4TY+5LHUoflaqmBdTZ3lHnC2oY24x4xEbgUYCDEhs3OpjGMvEPkD
   t4v26g2U6zfxWphqlgtZCFOBJ9k78/xXHd33Dli+25Tor7DUnaMFcUvdP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301286236"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="301286236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="582056609"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2022 04:42:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDC1667; Thu,  2 Jun 2022 14:42:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 2/3] iio: adc: meson_saradc: Use devm_clk_get_optional()
Date:   Thu,  2 Jun 2022 14:42:40 +0300
Message-Id: <20220602114241.12601-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
References: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded variants of devm_clk_get_optional().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
v2: added tag (Martin)
 drivers/iio/adc/meson_saradc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index a2e83eca03e8..e0762103c869 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1225,23 +1225,13 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->core_clk),
 				     "failed to get core clk\n");
 
-	priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
-	if (IS_ERR(priv->adc_clk)) {
-		if (PTR_ERR(priv->adc_clk) == -ENOENT)
-			priv->adc_clk = NULL;
-		else
-			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_clk),
-					     "failed to get adc clk\n");
-	}
+	priv->adc_clk = devm_clk_get_optional(dev, "adc_clk");
+	if (IS_ERR(priv->adc_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->adc_clk), "failed to get adc clk\n");
 
-	priv->adc_sel_clk = devm_clk_get(&pdev->dev, "adc_sel");
-	if (IS_ERR(priv->adc_sel_clk)) {
-		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT)
-			priv->adc_sel_clk = NULL;
-		else
-			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_sel_clk),
-					     "failed to get adc_sel clk\n");
-	}
+	priv->adc_sel_clk = devm_clk_get_optional(dev, "adc_sel");
+	if (IS_ERR(priv->adc_sel_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->adc_sel_clk), "failed to get adc_sel clk\n");
 
 	/* on pre-GXBB SoCs the SAR ADC itself provides the ADC clock: */
 	if (!priv->adc_clk) {
-- 
2.35.1

