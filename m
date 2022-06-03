Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392E53C804
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbiFCKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbiFCKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:00:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6758A3AA52;
        Fri,  3 Jun 2022 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654250407; x=1685786407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUUAnsz891L4HajB6hTRr1b9rf9F2cTw/OEQJFCSjIs=;
  b=EZK9jfl5WoZxW1oQxqVdUShy2SUE9EelKoPWepQy2ddUKpEUQgvwhKuh
   9dj6ORnRxAq/nsx/NAUw4J4wnpRIDjNX3BDFboiASpvfcXLl9E6qT+mjY
   lUBPZf2W8uuEvrqFNlnWRkqpUUUTvqckIGlFniAOWVwmcR3BpW8WXRRbk
   EPtJCvD9k54qvscmct0Ob0Ep2g4V1gxaC0CyK8oBJDZkBas2Ttg21yNp2
   JfibvgVLyjAD7qluCFg4zhNKxC/Mb+FyO2SMMO8VR+uZDndCTI0GX8HdG
   M1Mvie/GuCax25RzkUHJyzDkwvHd/nZiDnahPdFCx0rh/4pTsN3Zf3n7+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256695930"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="256695930"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="668392749"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2022 03:00:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26C525D3; Fri,  3 Jun 2022 13:00:07 +0300 (EEST)
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
Subject: [PATCH v3 3/6] iio: adc: meson_saradc: Convert to use dev_err_probe()
Date:   Fri,  3 Jun 2022 13:00:01 +0300
Message-Id: <20220603100004.70336-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
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

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rebased on top of previous changes
 drivers/iio/adc/meson_saradc.c | 52 +++++++++++++---------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 658047370db0..0d9aef362c5d 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -698,6 +698,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	u8 *buf, trimming_bits, trimming_mask, upper_adc_val;
+	struct device *dev = indio_dev->dev.parent;
 	struct nvmem_cell *temperature_calib;
 	size_t read_len;
 	int ret;
@@ -714,30 +715,23 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		if (ret == -ENODEV)
 			return 0;
 
-		return dev_err_probe(indio_dev->dev.parent, ret,
-				     "failed to get temperature_calib cell\n");
+		return dev_err_probe(dev, ret, "failed to get temperature_calib cell\n");
 	}
 
 	priv->tsc_regmap =
 		syscon_regmap_lookup_by_phandle(indio_dev->dev.parent->of_node,
 						"amlogic,hhi-sysctrl");
-	if (IS_ERR(priv->tsc_regmap)) {
-		dev_err(indio_dev->dev.parent,
-			"failed to get amlogic,hhi-sysctrl regmap\n");
-		return PTR_ERR(priv->tsc_regmap);
-	}
+	if (IS_ERR(priv->tsc_regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
+				     "failed to get amlogic,hhi-sysctrl regmap\n");
 
 	read_len = MESON_SAR_ADC_EFUSE_BYTES;
 	buf = nvmem_cell_read(temperature_calib, &read_len);
-	if (IS_ERR(buf)) {
-		dev_err(indio_dev->dev.parent,
-			"failed to read temperature_calib cell\n");
-		return PTR_ERR(buf);
-	} else if (read_len != MESON_SAR_ADC_EFUSE_BYTES) {
+	if (IS_ERR(buf))
+		return dev_err_probe(dev, PTR_ERR(buf), "failed to read temperature_calib cell\n");
+	if (read_len != MESON_SAR_ADC_EFUSE_BYTES) {
 		kfree(buf);
-		dev_err(indio_dev->dev.parent,
-			"invalid read size of temperature_calib cell\n");
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "invalid read size of temperature_calib cell\n");
 	}
 
 	trimming_bits = priv->param->temperature_trimming_bits;
@@ -762,6 +756,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 static int meson_sar_adc_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int regval, i, ret;
 
 	/*
@@ -885,18 +880,12 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	}
 
 	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
-	if (ret) {
-		dev_err(indio_dev->dev.parent,
-			"failed to set adc parent to clkin\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set adc parent to clkin\n");
 
 	ret = clk_set_rate(priv->adc_clk, priv->param->clock_rate);
-	if (ret) {
-		dev_err(indio_dev->dev.parent,
-			"failed to set adc clock rate\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set adc clock rate\n");
 
 	return 0;
 }
@@ -1183,24 +1172,21 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 {
 	const struct meson_sar_adc_data *match_data;
 	struct meson_sar_adc_priv *priv;
+	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	void __iomem *base;
 	int irq, ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "failed allocating iio device\n");
 
 	priv = iio_priv(indio_dev);
 	init_completion(&priv->done);
 
 	match_data = of_device_get_match_data(&pdev->dev);
-	if (!match_data) {
-		dev_err(&pdev->dev, "failed to get match data\n");
-		return -ENODEV;
-	}
+	if (!match_data)
+		return dev_err_probe(dev, -ENODEV, "failed to get match data\n");
 
 	priv->param = match_data->param;
 
-- 
2.35.1

