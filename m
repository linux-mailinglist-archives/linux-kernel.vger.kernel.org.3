Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2614A82CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbiBCLAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:00:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:16919 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235192AbiBCK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643885999; x=1675421999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9aJqvw8SN3hrJ1kfCpnrOtDl1FVBaSYTL4PXDTJCgEo=;
  b=kIhJ6l56UB86JXK4wrbh/NArnn9efCKXFPkHi28FDRXrF9YYC99noplr
   +tLLHYxL1FbX6YgAbjS524s9jhjmbscmbUYOXtWofMbADN6bjT1ARPaZY
   cDj2Px18MhAEEGvJCrRXw6Zk/t0eqPhq3hxEZ7HNmMiMF5MmXFBsGV5GK
   isEnCtQmMbIHugWiAWuDuz/Jnfy3J59w8BZNVtqBPeX48fnr7NA/6ZMXU
   3/yBfMC9+PFdupsr2zA65jvcBYxVLnhyVNLeKBn3w7YdJ2dWx/XtPSm6Z
   5icVrTE15+7iRs73sRVLJVpY++S8hJwRnAmFhZsva407tKqUwll+IFLiQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247886928"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="247886928"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="498100589"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2022 02:59:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BE2330A; Thu,  3 Feb 2022 13:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/1] iio: frequency: adf4350: Make use of device properties
Date:   Thu,  3 Feb 2022 13:00:06 +0200
Message-Id: <20220203110006.4291-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (lkp)
 drivers/iio/frequency/adf4350.c | 103 +++++++++++++-------------------
 1 file changed, 42 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 3d9eba716b69..9af20a51540d 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -7,17 +7,18 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/gcd.h>
 #include <linux/gpio/consumer.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
-#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -381,10 +382,8 @@ static const struct iio_info adf4350_info = {
 	.debugfs_reg_access = &adf4350_reg_access,
 };
 
-#ifdef CONFIG_OF
 static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 {
-	struct device_node *np = dev->of_node;
 	struct adf4350_platform_data *pdata;
 	unsigned int tmp;
 
@@ -392,101 +391,83 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 	if (!pdata)
 		return NULL;
 
-	snprintf(&pdata->name[0], SPI_NAME_SIZE - 1, "%pOFn", np);
+	snprintf(pdata->name, sizeof(pdata->name), "%pfw", dev_fwnode(dev));
 
 	tmp = 10000;
-	of_property_read_u32(np, "adi,channel-spacing", &tmp);
+	device_property_read_u32(dev, "adi,channel-spacing", &tmp);
 	pdata->channel_spacing = tmp;
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,power-up-frequency", &tmp);
+	device_property_read_u32(dev, "adi,power-up-frequency", &tmp);
 	pdata->power_up_frequency = tmp;
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,reference-div-factor", &tmp);
+	device_property_read_u32(dev, "adi,reference-div-factor", &tmp);
 	pdata->ref_div_factor = tmp;
 
-	pdata->ref_doubler_en = of_property_read_bool(np,
-			"adi,reference-doubler-enable");
-	pdata->ref_div2_en = of_property_read_bool(np,
-			"adi,reference-div2-enable");
+	pdata->ref_doubler_en = device_property_read_bool(dev, "adi,reference-doubler-enable");
+	pdata->ref_div2_en = device_property_read_bool(dev, "adi,reference-div2-enable");
 
 	/* r2_user_settings */
-	pdata->r2_user_settings = of_property_read_bool(np,
-			"adi,phase-detector-polarity-positive-enable") ?
-			ADF4350_REG2_PD_POLARITY_POS : 0;
-	pdata->r2_user_settings |= of_property_read_bool(np,
-			"adi,lock-detect-precision-6ns-enable") ?
-			ADF4350_REG2_LDP_6ns : 0;
-	pdata->r2_user_settings |= of_property_read_bool(np,
-			"adi,lock-detect-function-integer-n-enable") ?
-			ADF4350_REG2_LDF_INT_N : 0;
+	pdata->r2_user_settings = 0;
+	if (device_property_read_bool(dev, "adi,phase-detector-polarity-positive-enable"))
+		pdata->r2_user_settings |= ADF4350_REG2_PD_POLARITY_POS;
+	if (device_property_read_bool(dev, "adi,lock-detect-precision-6ns-enable"))
+		pdata->r2_user_settings |= ADF4350_REG2_LDP_6ns;
+	if (device_property_read_bool(dev, "adi,lock-detect-function-integer-n-enable"))
+		pdata->r2_user_settings |= ADF4350_REG2_LDF_INT_N;
 
 	tmp = 2500;
-	of_property_read_u32(np, "adi,charge-pump-current", &tmp);
+	device_property_read_u32(dev, "adi,charge-pump-current", &tmp);
 	pdata->r2_user_settings |= ADF4350_REG2_CHARGE_PUMP_CURR_uA(tmp);
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,muxout-select", &tmp);
+	device_property_read_u32(dev, "adi,muxout-select", &tmp);
 	pdata->r2_user_settings |= ADF4350_REG2_MUXOUT(tmp);
 
-	pdata->r2_user_settings |= of_property_read_bool(np,
-			"adi,low-spur-mode-enable") ?
-			ADF4350_REG2_NOISE_MODE(0x3) : 0;
+	if (device_property_read_bool(dev, "adi,low-spur-mode-enable"))
+		pdata->r2_user_settings |= ADF4350_REG2_NOISE_MODE(0x3);
 
 	/* r3_user_settings */
 
-	pdata->r3_user_settings = of_property_read_bool(np,
-			"adi,cycle-slip-reduction-enable") ?
-			ADF4350_REG3_12BIT_CSR_EN : 0;
-	pdata->r3_user_settings |= of_property_read_bool(np,
-			"adi,charge-cancellation-enable") ?
-			ADF4351_REG3_CHARGE_CANCELLATION_EN : 0;
-
-	pdata->r3_user_settings |= of_property_read_bool(np,
-			"adi,anti-backlash-3ns-enable") ?
-			ADF4351_REG3_ANTI_BACKLASH_3ns_EN : 0;
-	pdata->r3_user_settings |= of_property_read_bool(np,
-			"adi,band-select-clock-mode-high-enable") ?
-			ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH : 0;
+	pdata->r3_user_settings = 0;
+	if (device_property_read_bool(dev, "adi,cycle-slip-reduction-enable"))
+		pdata->r3_user_settings |= ADF4350_REG3_12BIT_CSR_EN;
+	if (device_property_read_bool(dev, "adi,charge-cancellation-enable"))
+		pdata->r3_user_settings |= ADF4351_REG3_CHARGE_CANCELLATION_EN;
+	if (device_property_read_bool(dev, "adi,anti-backlash-3ns-enable"))
+		pdata->r3_user_settings |= ADF4351_REG3_ANTI_BACKLASH_3ns_EN;
+	if (device_property_read_bool(dev, "adi,band-select-clock-mode-high-enable"))
+		pdata->r3_user_settings |= ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH;
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,12bit-clk-divider", &tmp);
+	device_property_read_u32(dev, "adi,12bit-clk-divider", &tmp);
 	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV(tmp);
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,clk-divider-mode", &tmp);
+	device_property_read_u32(dev, "adi,clk-divider-mode", &tmp);
 	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV_MODE(tmp);
 
 	/* r4_user_settings */
 
-	pdata->r4_user_settings = of_property_read_bool(np,
-			"adi,aux-output-enable") ?
-			ADF4350_REG4_AUX_OUTPUT_EN : 0;
-	pdata->r4_user_settings |= of_property_read_bool(np,
-			"adi,aux-output-fundamental-enable") ?
-			ADF4350_REG4_AUX_OUTPUT_FUND : 0;
-	pdata->r4_user_settings |= of_property_read_bool(np,
-			"adi,mute-till-lock-enable") ?
-			ADF4350_REG4_MUTE_TILL_LOCK_EN : 0;
+	pdata->r4_user_settings = 0;
+	if (device_property_read_bool(dev, "adi,aux-output-enable"))
+		pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_EN;
+	if (device_property_read_bool(dev, "adi,aux-output-fundamental-enable"))
+		pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_FUND;
+	if (device_property_read_bool(dev, "adi,mute-till-lock-enable"))
+		pdata->r4_user_settings |= ADF4350_REG4_MUTE_TILL_LOCK_EN;
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,output-power", &tmp);
+	device_property_read_u32(dev, "adi,output-power", &tmp);
 	pdata->r4_user_settings |= ADF4350_REG4_OUTPUT_PWR(tmp);
 
 	tmp = 0;
-	of_property_read_u32(np, "adi,aux-output-power", &tmp);
+	device_property_read_u32(dev, "adi,aux-output-power", &tmp);
 	pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_PWR(tmp);
 
 	return pdata;
 }
-#else
-static
-struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
-{
-	return NULL;
-}
-#endif
 
 static int adf4350_probe(struct spi_device *spi)
 {
@@ -496,7 +477,7 @@ static int adf4350_probe(struct spi_device *spi)
 	struct clk *clk = NULL;
 	int ret;
 
-	if (spi->dev.of_node) {
+	if (dev_fwnode(&spi->dev)) {
 		pdata = adf4350_parse_dt(&spi->dev);
 		if (pdata == NULL)
 			return -EINVAL;
@@ -625,7 +606,7 @@ MODULE_DEVICE_TABLE(spi, adf4350_id);
 static struct spi_driver adf4350_driver = {
 	.driver = {
 		.name	= "adf4350",
-		.of_match_table = of_match_ptr(adf4350_of_match),
+		.of_match_table = adf4350_of_match,
 	},
 	.probe		= adf4350_probe,
 	.remove		= adf4350_remove,
-- 
2.34.1

