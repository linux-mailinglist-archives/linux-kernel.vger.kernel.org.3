Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961894FF92C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiDMOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiDMOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:44:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF362133;
        Wed, 13 Apr 2022 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860907; x=1681396907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZyOgKZlsZeQb5OcaI5Of+KAELOgctouaHFIpyMPl0s=;
  b=FINQTlFyI8Z4vMXLDMR/sHdCROFM02jotxyE+76OcD79SudIya4wAHZR
   C7wf9D9tDpIB/QimX6uYw4xT6dFSquaTBAeUdEVpIAB1eNzLn2e4SQ6yr
   AUb9uBmHsedvBdSfVGdkMjPoPyoYe+NKtc0NNZHGABX6pVT4UYohgi48N
   jkvZ0y/54f5ZaIhhA2TxfFrsyOPvUzLJFtnKeTWUMRTi6YW8sFslQy59M
   tET1bz3JQPmMeu3ws0fXjuK/I+GRF21MQC1WXYcNehD7ghA5WLSJS0pwD
   1RAHlVka3vF0Baz9JkVl93FqBHXCTQjNHqo1AcD7Q+9T0ssva0JeTy733
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244571465"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244571465"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="552233091"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2022 07:41:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA4FF14F; Wed, 13 Apr 2022 17:41:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 2/3] iio: imu: adis16480: Use temporary variable for struct device
Date:   Wed, 13 Apr 2022 17:41:23 +0300
Message-Id: <20220413144124.72537-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/iio/imu/adis16480.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 68eed088cca6..287914016f28 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1121,6 +1121,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16480 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
+	struct device *dev = &adis->spi->dev;
 	int ret, bit, offset, i = 0;
 	__be16 *buffer;
 	u32 crc;
@@ -1132,7 +1133,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 		adis->tx[1] = 0;
 		ret = spi_write(adis->spi, adis->tx, 2);
 		if (ret) {
-			dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
+			dev_err(dev, "Failed to change device page: %d\n", ret);
 			adis_dev_unlock(adis);
 			goto irq_done;
 		}
@@ -1142,7 +1143,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 
 	ret = spi_sync(adis->spi, &adis->msg);
 	if (ret) {
-		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
+		dev_err(dev, "Failed to read data: %d\n", ret);
 		adis_dev_unlock(adis);
 		goto irq_done;
 	}
@@ -1170,14 +1171,14 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	}
 
 	if (offset == 4) {
-		dev_err(&adis->spi->dev, "Invalid burst data\n");
+		dev_err(dev, "Invalid burst data\n");
 		goto irq_done;
 	}
 
 	crc = be16_to_cpu(buffer[offset + 16]) << 16 | be16_to_cpu(buffer[offset + 15]);
 	valid = adis16480_validate_crc((u16 *)&buffer[offset], 15, crc);
 	if (!valid) {
-		dev_err(&adis->spi->dev, "Invalid crc\n");
+		dev_err(dev, "Invalid crc\n");
 		goto irq_done;
 	}
 
@@ -1216,12 +1217,12 @@ static const struct iio_info adis16480_info = {
 static int adis16480_stop_device(struct iio_dev *indio_dev)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
+	struct device *dev = &st->adis.spi->dev;
 	int ret;
 
 	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_SLP_CNT, BIT(9));
 	if (ret)
-		dev_err(&indio_dev->dev,
-			"Could not power down device: %d\n", ret);
+		dev_err(dev, "Could not power down device: %d\n", ret);
 
 	return ret;
 }
@@ -1253,7 +1254,7 @@ static int adis16480_config_irq_pin(struct adis16480 *st)
 
 	desc = irq_get_irq_data(st->adis.spi->irq);
 	if (!desc) {
-		dev_err(&st->adis.spi->dev, "Could not find IRQ %d\n", irq);
+		dev_err(dev, "Could not find IRQ %d\n", irq);
 		return -EINVAL;
 	}
 
@@ -1290,8 +1291,7 @@ static int adis16480_config_irq_pin(struct adis16480 *st)
 	} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {
 		val |= ADIS16480_DRDY_POL(0);
 	} else {
-		dev_err(&st->adis.spi->dev,
-			"Invalid interrupt type 0x%x specified\n", irq_type);
+		dev_err(dev, "Invalid interrupt type 0x%x specified\n", irq_type);
 		return -EINVAL;
 	}
 	/* Write the data ready configuration to the FNCTIO_CTRL register */
@@ -1315,13 +1315,13 @@ static int adis16480_fw_get_ext_clk_pin(struct adis16480 *st)
 	}
 
 clk_input_not_found:
-	dev_info(&st->adis.spi->dev,
-		"clk input line not specified, using DIO2\n");
+	dev_info(dev, "clk input line not specified, using DIO2\n");
 	return pin;
 }
 
 static int adis16480_ext_clk_config(struct adis16480 *st, bool enable)
 {
+	struct device *dev = &st->adis.spi->dev;
 	unsigned int mode, mask;
 	enum adis16480_int_pin pin;
 	uint16_t val;
@@ -1338,9 +1338,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st, bool enable)
 	 * automatically resets to zero (disabling the lower priority function).
 	 */
 	if (pin == ADIS16480_DRDY_SEL(val))
-		dev_warn(&st->adis.spi->dev,
-			"DIO%x pin supports only one function at a time\n",
-			pin + 1);
+		dev_warn(dev, "DIO%x pin supports only one function at a time\n", pin + 1);
 
 	mode = ADIS16480_SYNC_EN(enable) | ADIS16480_SYNC_SEL(pin);
 	mask = ADIS16480_SYNC_EN_MSK | ADIS16480_SYNC_SEL_MSK;
@@ -1362,27 +1360,29 @@ static int adis16480_ext_clk_config(struct adis16480 *st, bool enable)
 
 static int adis16480_get_ext_clocks(struct adis16480 *st)
 {
+	struct device *dev = &st->adis.spi->dev;
+
 	st->clk_mode = ADIS16480_CLK_INT;
-	st->ext_clk = devm_clk_get(&st->adis.spi->dev, "sync");
+	st->ext_clk = devm_clk_get(dev, "sync");
 	if (!IS_ERR_OR_NULL(st->ext_clk)) {
 		st->clk_mode = ADIS16480_CLK_SYNC;
 		return 0;
 	}
 
 	if (PTR_ERR(st->ext_clk) != -ENOENT) {
-		dev_err(&st->adis.spi->dev, "failed to get ext clk\n");
+		dev_err(dev, "failed to get ext clk\n");
 		return PTR_ERR(st->ext_clk);
 	}
 
 	if (st->chip_info->has_pps_clk_mode) {
-		st->ext_clk = devm_clk_get(&st->adis.spi->dev, "pps");
+		st->ext_clk = devm_clk_get(dev, "pps");
 		if (!IS_ERR_OR_NULL(st->ext_clk)) {
 			st->clk_mode = ADIS16480_CLK_PPS;
 			return 0;
 		}
 
 		if (PTR_ERR(st->ext_clk) != -ENOENT) {
-			dev_err(&st->adis.spi->dev, "failed to get ext clk\n");
+			dev_err(dev, "failed to get ext clk\n");
 			return PTR_ERR(st->ext_clk);
 		}
 	}
@@ -1405,11 +1405,12 @@ static int adis16480_probe(struct spi_device *spi)
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const struct adis_data *adis16480_data;
 	irq_handler_t trigger_handler = NULL;
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct adis16480 *st;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -1433,8 +1434,7 @@ static int adis16480_probe(struct spi_device *spi)
 		return ret;
 
 	if (st->chip_info->has_sleep_cnt) {
-		ret = devm_add_action_or_reset(&spi->dev, adis16480_stop,
-					       indio_dev);
+		ret = devm_add_action_or_reset(dev, adis16480_stop, indio_dev);
 		if (ret)
 			return ret;
 	}
@@ -1452,7 +1452,7 @@ static int adis16480_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
-		ret = devm_add_action_or_reset(&spi->dev, adis16480_clk_disable, st->ext_clk);
+		ret = devm_add_action_or_reset(dev, adis16480_clk_disable, st->ext_clk);
 		if (ret)
 			return ret;
 
@@ -1485,7 +1485,7 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.35.1

