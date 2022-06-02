Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681E053B7FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiFBLmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiFBLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:42:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3B1EEE8;
        Thu,  2 Jun 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654170163; x=1685706163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxSg/zeqHqeKSH+c5lsz78IoUwxOmvrTiLmC8LlVeQc=;
  b=SbXg2E03GaFkD4aDv49AALrklZw6kfLyKK286pHenKFnklE/LQ0bJYvF
   FKWgTGSbjNLKx30RXKvWW1Qr3mtjIVxGL+YHMrxLF+ef9FG7QDRYTbvPt
   KjijUZRCaQ5jAMCe0ruBpTJrj0SLEiIr0G4izdpIzPiNgkJdxHqgyg69Y
   7JfxEwfxArVBECxwA60e+B3GXQrNn5aVqYAGt10BlkI3V2LpBxYt1dvkl
   qua7b5eitBMljqM+Zxp/RtmVW0TR8atZ9ghing/sR/kOaxdCfc2J2wfsG
   UCpjIusq4jI16ztFvqh50J8TD4psa2pAyYyHr4jHSraLKyUloGhB8oeMn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274722267"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="274722267"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="756949085"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2022 04:42:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7DE99A9; Thu,  2 Jun 2022 14:42:42 +0300 (EEST)
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
Subject: [PATCH v2 3/3] iio: adc: meson_saradc: Use temporary variable for struct device
Date:   Thu,  2 Jun 2022 14:42:41 +0300
Message-Id: <20220602114241.12601-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
References: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
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

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (LKP, Martin)

The Martin's idea about iio specific prints still can be discussed before
or after applying this, I have no preference. That said, this change can be
postponed.

 drivers/iio/adc/meson_saradc.c | 73 +++++++++++++++-------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e0762103c869..c66f1e978c3c 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -345,6 +345,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *idev = &indio_dev->dev;
 	int regval, fifo_chan, fifo_val, count;
 
 	if (!wait_for_completion_timeout(&priv->done,
@@ -353,16 +354,14 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 
 	count = meson_sar_adc_get_fifo_count(indio_dev);
 	if (count != 1) {
-		dev_err(&indio_dev->dev,
-			"ADC FIFO has %d element(s) instead of one\n", count);
+		dev_err(idev, "ADC FIFO has %d element(s) instead of one\n", count);
 		return -EINVAL;
 	}
 
 	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
 	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
 	if (fifo_chan != chan->address) {
-		dev_err(&indio_dev->dev,
-			"ADC FIFO entry belongs to channel %d instead of %lu\n",
+		dev_err(idev, "ADC FIFO entry belongs to channel %d instead of %lu\n",
 			fifo_chan, chan->address);
 		return -EINVAL;
 	}
@@ -550,6 +549,7 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 				    int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
 	if (chan->type == IIO_TEMP && !priv->temperature_sensor_calibrated)
@@ -573,8 +573,7 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 	meson_sar_adc_unlock(indio_dev);
 
 	if (ret) {
-		dev_warn(indio_dev->dev.parent,
-			 "failed to read sample for channel %lu: %d\n",
+		dev_warn(dev, "failed to read sample for channel %lu: %d\n",
 			 chan->address, ret);
 		return ret;
 	}
@@ -587,6 +586,7 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
 					   int *val, int *val2, long mask)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
 	switch (mask) {
@@ -603,9 +603,7 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
 		if (chan->type == IIO_VOLTAGE) {
 			ret = regulator_get_voltage(priv->vref);
 			if (ret < 0) {
-				dev_err(indio_dev->dev.parent,
-					"failed to get vref voltage: %d\n",
-					ret);
+				dev_err(dev, "failed to get vref voltage: %d\n", ret);
 				return ret;
 			}
 
@@ -650,11 +648,12 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 				  void __iomem *base)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *idev = &indio_dev->dev;
+	struct device *dev = idev->parent;
 	struct clk_init_data init;
 	const char *clk_parents[1];
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
-				   dev_name(indio_dev->dev.parent));
+	init.name = devm_kasprintf(idev, GFP_KERNEL, "%s#adc_div", dev_name(dev));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -670,13 +669,11 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	priv->clk_div.hw.init = &init;
 	priv->clk_div.flags = 0;
 
-	priv->adc_div_clk = devm_clk_register(&indio_dev->dev,
-					      &priv->clk_div.hw);
+	priv->adc_div_clk = devm_clk_register(idev, &priv->clk_div.hw);
 	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
 		return PTR_ERR(priv->adc_div_clk);
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
-				   dev_name(indio_dev->dev.parent));
+	init.name = devm_kasprintf(idev, GFP_KERNEL, "%s#adc_en", dev_name(dev));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -690,7 +687,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	priv->clk_gate.bit_idx = __ffs(MESON_SAR_ADC_REG3_CLK_EN);
 	priv->clk_gate.hw.init = &init;
 
-	priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);
+	priv->adc_clk = devm_clk_register(idev, &priv->clk_gate.hw);
 	if (WARN_ON(IS_ERR(priv->adc_clk)))
 		return PTR_ERR(priv->adc_clk);
 
@@ -706,8 +703,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 	size_t read_len;
 	int ret;
 
-	temperature_calib = devm_nvmem_cell_get(indio_dev->dev.parent,
-						"temperature_calib");
+	temperature_calib = devm_nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temperature_calib)) {
 		ret = PTR_ERR(temperature_calib);
 
@@ -721,9 +717,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret, "failed to get temperature_calib cell\n");
 	}
 
-	priv->tsc_regmap =
-		syscon_regmap_lookup_by_phandle(indio_dev->dev.parent->of_node,
-						"amlogic,hhi-sysctrl");
+	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
 	if (IS_ERR(priv->tsc_regmap))
 		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
 				     "failed to get amlogic,hhi-sysctrl regmap\n");
@@ -911,6 +905,7 @@ static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
 static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 	u32 regval;
 
@@ -920,14 +915,13 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 
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
 
@@ -945,7 +939,7 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 
 	ret = clk_prepare_enable(priv->adc_clk);
 	if (ret) {
-		dev_err(indio_dev->dev.parent, "failed to enable adc clk\n");
+		dev_err(dev, "failed to enable adc clk\n");
 		goto err_adc_clk;
 	}
 
@@ -1180,14 +1174,14 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
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
 
@@ -1201,29 +1195,25 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
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
@@ -1240,10 +1230,9 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	priv->vref = devm_regulator_get(&pdev->dev, "vref");
+	priv->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(priv->vref))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->vref),
-				     "failed to get vref regulator\n");
+		return dev_err_probe(dev, PTR_ERR(priv->vref), "failed to get vref regulator\n");
 
 	priv->calibscale = MILLION;
 
@@ -1273,7 +1262,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 
 	ret = meson_sar_adc_calib(indio_dev);
 	if (ret)
-		dev_warn(&pdev->dev, "calibration failed\n");
+		dev_warn(dev, "calibration failed\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.35.1

