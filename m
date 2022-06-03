Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06FB53C80C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiFCKA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbiFCKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:00:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB93AA57;
        Fri,  3 Jun 2022 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654250408; x=1685786408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=elWO9ZPegpwhPxq94m/afl/cMMc8o9axWYz77GAUeQE=;
  b=GG4pKRMebYz77ZgDNyhKYzmep11kQn69YDPr0ZZtz3aGDrtFsPtB5yd2
   9S12HZth/G3RFd12Imy7HkpbS+asJjMAHjBwkJ/DnTuYifgXAoATGYWlr
   ev0nWxQUZIJM+tyUyu6Xp6sJmgvAu+Qn6ofceKA6Hsb9qhqey1V6FytBI
   eodRXdNmDfxAuIrWj4yxkAGBbCRmgpK1ciIVJC86mSb8UVXBWwtQy+rx/
   7UEQaS1cftvYvbr5zbJTmBAjjq/MpZau/vAwiRknlBEIj4ll8yLmk5V0e
   gncbYGa3jeQal4MVeVJ8cuVsDUBWx/6HSC0kQRq//nZR9Z6pRiZMh4SRN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="258289572"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="258289572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="582496029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2022 03:00:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3A4C89A9; Fri,  3 Jun 2022 13:00:07 +0300 (EEST)
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
Subject: [PATCH v3 5/6] iio: adc: meson_saradc: Use temporary variable for struct device
Date:   Fri,  3 Jun 2022 13:00:03 +0300
Message-Id: <20220603100004.70336-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rebased on top of previous changes

 drivers/iio/adc/meson_saradc.c | 53 ++++++++++++++--------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 337517a8e1ac..c100f933c12e 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -549,6 +549,7 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 				    int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
 	if (chan->type == IIO_TEMP && !priv->temperature_sensor_calibrated)
@@ -572,8 +573,7 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 	meson_sar_adc_unlock(indio_dev);
 
 	if (ret) {
-		dev_warn(indio_dev->dev.parent,
-			 "failed to read sample for channel %lu: %d\n",
+		dev_warn(dev, "failed to read sample for channel %lu: %d\n",
 			 chan->address, ret);
 		return ret;
 	}
@@ -586,6 +586,7 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
 					   int *val, int *val2, long mask)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
 	switch (mask) {
@@ -602,9 +603,7 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
 		if (chan->type == IIO_VOLTAGE) {
 			ret = regulator_get_voltage(priv->vref);
 			if (ret < 0) {
-				dev_err(indio_dev->dev.parent,
-					"failed to get vref voltage: %d\n",
-					ret);
+				dev_err(dev, "failed to get vref voltage: %d\n", ret);
 				return ret;
 			}
 
@@ -703,8 +702,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	size_t read_len;
 	int ret;
 
-	temperature_calib = devm_nvmem_cell_get(indio_dev->dev.parent,
-						"temperature_calib");
+	temperature_calib = devm_nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temperature_calib)) {
 		ret = PTR_ERR(temperature_calib);
 
@@ -718,9 +716,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret, "failed to get temperature_calib cell\n");
 	}
 
-	priv->tsc_regmap =
-		syscon_regmap_lookup_by_phandle(indio_dev->dev.parent->of_node,
-						"amlogic,hhi-sysctrl");
+	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
 	if (IS_ERR(priv->tsc_regmap))
 		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
 				     "failed to get amlogic,hhi-sysctrl regmap\n");
@@ -908,6 +904,7 @@ static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
 static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 	u32 regval;
 
@@ -917,14 +914,13 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 
 	ret = regulator_enable(priv->vref);
 	if (ret < 0) {
-		dev_err(indio_dev->dev.parent,
-			"failed to enable vref regulator\n");
+		dev_err(dev, "failed to enable vref regulator\n");
 		goto err_vref;
 	}
 
 	ret = clk_prepare_enable(priv->core_clk);
 	if (ret) {
-		dev_err(indio_dev->dev.parent, "failed to enable core clk\n");
+		dev_err(dev, "failed to enable core clk\n");
 		goto err_core_clk;
 	}
 
@@ -942,7 +938,7 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 
 	ret = clk_prepare_enable(priv->adc_clk);
 	if (ret) {
-		dev_err(indio_dev->dev.parent, "failed to enable adc clk\n");
+		dev_err(dev, "failed to enable adc clk\n");
 		goto err_adc_clk;
 	}
 
@@ -1177,14 +1173,14 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int irq, ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
 		return dev_err_probe(dev, -ENOMEM, "failed allocating iio device\n");
 
 	priv = iio_priv(indio_dev);
 	init_completion(&priv->done);
 
-	match_data = of_device_get_match_data(&pdev->dev);
+	match_data = of_device_get_match_data(dev);
 	if (!match_data)
 		return dev_err_probe(dev, -ENODEV, "failed to get match data\n");
 
@@ -1198,29 +1194,25 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					     priv->param->regmap_config);
+	priv->regmap = devm_regmap_init_mmio(dev, base, priv->param->regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq)
 		return -EINVAL;
 
-	ret = devm_request_irq(&pdev->dev, irq, meson_sar_adc_irq, IRQF_SHARED,
-			       dev_name(&pdev->dev), indio_dev);
+	ret = devm_request_irq(dev, irq, meson_sar_adc_irq, IRQF_SHARED, dev_name(dev), indio_dev);
 	if (ret)
 		return ret;
 
-	priv->clkin = devm_clk_get(&pdev->dev, "clkin");
+	priv->clkin = devm_clk_get(dev, "clkin");
 	if (IS_ERR(priv->clkin))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clkin),
-				     "failed to get clkin\n");
+		return dev_err_probe(dev, PTR_ERR(priv->clkin), "failed to get clkin\n");
 
-	priv->core_clk = devm_clk_get(&pdev->dev, "core");
+	priv->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(priv->core_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->core_clk),
-				     "failed to get core clk\n");
+		return dev_err_probe(dev, PTR_ERR(priv->core_clk), "failed to get core clk\n");
 
 	priv->adc_clk = devm_clk_get_optional(dev, "adc_clk");
 	if (IS_ERR(priv->adc_clk))
@@ -1237,10 +1229,9 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	priv->vref = devm_regulator_get(&pdev->dev, "vref");
+	priv->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(priv->vref))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->vref),
-				     "failed to get vref regulator\n");
+		return dev_err_probe(dev, PTR_ERR(priv->vref), "failed to get vref regulator\n");
 
 	priv->calibscale = MILLION;
 
@@ -1270,7 +1261,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 
 	ret = meson_sar_adc_calib(indio_dev);
 	if (ret)
-		dev_warn(&pdev->dev, "calibration failed\n");
+		dev_warn(dev, "calibration failed\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.35.1

