Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454C53B7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiFBLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiFBLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:42:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949765D3;
        Thu,  2 Jun 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654170163; x=1685706163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oIz/mvMCV+BGSqUcB6eZa50Ln+1c3te5NV7Zv6a5Yeg=;
  b=DwFbVff7SdCDlWC8/Gwd2llmlIdS01PvotgOVyvbJWNmCpm9MMS5Kzfy
   sWi4o5oLSWryBucvds+lYDwp1N4pozQh0m6ahcc9etkGR8BHrRRRSRvq7
   pT7vy3iJJagXuM4QcRZcxVL9ekQc/PUuOp6Wto1+tqfmrLuaaCNS8coMV
   5wQE/XlpalnXgiobBki3CMM7KuWqwizsdvuaYi4BAIE2N7pk+4pRQ5rYS
   qUAQtKri+8Ev9qH+19kYLnhb+DOFfrG/h8qFU4n6D1wqnGcR5X6OUElEA
   BHXE2Us2+Jvo2/q0yRXJP6ehWEoDs0Eq1ySxX4gbXtyayxiyvaXp+wIUk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="362293255"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="362293255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="721269396"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2022 04:42:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BEFD8F8; Thu,  2 Jun 2022 14:42:42 +0300 (EEST)
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
Subject: [PATCH v2 1/3] iio: adc: meson_saradc: Convert to use dev_err_probe()
Date:   Thu,  2 Jun 2022 14:42:39 +0300
Message-Id: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
v2: split long line (Martin)
 drivers/iio/adc/meson_saradc.c | 52 +++++++++++++---------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 62cc6fb0ef85..a2e83eca03e8 100644
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
@@ -717,30 +718,23 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
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
@@ -765,6 +759,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 static int meson_sar_adc_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int regval, i, ret;
 
 	/*
@@ -888,18 +883,12 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
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
@@ -1186,24 +1175,21 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
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

