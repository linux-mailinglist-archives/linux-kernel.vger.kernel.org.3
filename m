Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0E53C807
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiFCKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbiFCKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:00:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F378E3AA56;
        Fri,  3 Jun 2022 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654250408; x=1685786408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dmizgC/FFx3wjR+UyFpJTMRWLIYX1iNBjHo2LkhU22s=;
  b=HfSlYO3LXpZZu76GkNx7q2aB+ReIVi1Cv5zeVcvlD7LhWBpcCIlGBfI7
   JMbYDwtHqrMvcERDfVZ7jnB5OQsEv4yuY+OvLJ/ZqIlDD7JDS6ZLvDTh9
   75/DAYBWv1w3aOAlj+n0WP27msZLdxGokmkFCoihJf1bVUOwy5UrHJYn/
   DU16qU6KrNd4aODBqK9/L3MsZ03G+CGSJOmHcR6BU2cZuiEX7sd+R1564
   E3LKALyko1TNM0ykafVrHajUsfe2Rol9yGt8G6IPjEmH8MerxOub0rdtH
   eZwldr0D8EnRz035YJn6v2OEzKmk5F454xzWLSupOLe3pNvb7csOd+t2/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="263863063"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="263863063"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="721691989"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2022 03:00:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 12387F8; Fri,  3 Jun 2022 13:00:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/6] iio: adc: meson_saradc: Don't attach managed resource to IIO device object
Date:   Fri,  3 Jun 2022 12:59:59 +0300
Message-Id: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It feels wrong and actually inconsistent to attach managed resources
to the IIO device object, which is child of the physical device object.
The rest of the ->probe() calls do that against physical device.

Resolve this by reassigning managed resources to the physical device object.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new fix-patch
 drivers/iio/adc/meson_saradc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 62cc6fb0ef85..4fe6b997cd03 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -650,11 +650,11 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 				  void __iomem *base)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	struct clk_init_data init;
 	const char *clk_parents[1];
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
-				   dev_name(indio_dev->dev.parent));
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s#adc_div", dev_name(dev));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -670,13 +670,11 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	priv->clk_div.hw.init = &init;
 	priv->clk_div.flags = 0;
 
-	priv->adc_div_clk = devm_clk_register(&indio_dev->dev,
-					      &priv->clk_div.hw);
+	priv->adc_div_clk = devm_clk_register(dev, &priv->clk_div.hw);
 	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
 		return PTR_ERR(priv->adc_div_clk);
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
-				   dev_name(indio_dev->dev.parent));
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s#adc_en", dev_name(dev));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -690,7 +688,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	priv->clk_gate.bit_idx = __ffs(MESON_SAR_ADC_REG3_CLK_EN);
 	priv->clk_gate.hw.init = &init;
 
-	priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);
+	priv->adc_clk = devm_clk_register(dev, &priv->clk_gate.hw);
 	if (WARN_ON(IS_ERR(priv->adc_clk)))
 		return PTR_ERR(priv->adc_clk);
 
-- 
2.35.1

