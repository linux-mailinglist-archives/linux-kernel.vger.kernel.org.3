Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5EB539888
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347915AbiEaVSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242111AbiEaVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:18:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1AF5E175;
        Tue, 31 May 2022 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654031924; x=1685567924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=95N/U1wc3ENWDPrktkKLJxWiCnlTcRmWQDNgyhivVEs=;
  b=ffxQ02M9MnQBz4gAndxIdZGv7mon5kA1ELqOHrE0K26298hX4Ba0RTCj
   GjrAAbBEsjiscoMkgrmOUodZNVArSO5Y7u95lv8kBATkq7yAoc7IjCs19
   amw1LBQAGMKSLZ4hBkO40RTLgK9LoW4syLMU4MODNcEYg3OeGXv3bEdRX
   phtVd18nSdlSPRCJQyFKT656SylSiyJxEJ43Rj0lWklC993ETOwMpltlr
   mdwbcL2Y/KBvdfuxpq6a2vmRpcGyE11LNfKYpssT/Gbr0ZjR8jptscJe2
   KUUhGP8MMoUs09s+aj8Y6u8QhcNeaHLMLd6/o9l7eeMptYfpuBGelexZ1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255258212"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255258212"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 14:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="823454439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2022 14:18:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E369B18B; Wed,  1 Jun 2022 00:18:43 +0300 (EEST)
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
Subject: [PATCH v1 1/3] iio: adc: meson_saradc: Convert to use dev_err_probe()
Date:   Wed,  1 Jun 2022 00:18:40 +0300
Message-Id: <20220531211842.71998-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/meson_saradc.c | 51 ++++++++++++----------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 62cc6fb0ef85..c2abbfc1396c 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -701,6 +701,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	u8 *buf, trimming_bits, trimming_mask, upper_adc_val;
+	struct device *dev = indio_dev->dev.parent;
 	struct nvmem_cell *temperature_calib;
 	size_t read_len;
 	int ret;
@@ -717,30 +718,22 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
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
+		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap), "failed to get amlogic,hhi-sysctrl regmap\n");
 
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
@@ -765,6 +758,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 static int meson_sar_adc_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int regval, i, ret;
 
 	/*
@@ -888,18 +882,12 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
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
@@ -1186,24 +1174,21 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
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

