Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05E74A7964
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiBBU33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:29:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:1364 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbiBBU32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643833768; x=1675369768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cCD02Yx9Gu0a31iJjmnPVyynU/NEGUjd0OPG2bpWqPU=;
  b=S+AkB9J2mFo7DyJnALf4K2eghBlA6P4zgUhxO/Jlq7XgAzOb+Xc/WWVj
   E+L7uVuaDL+4d2EAXDa6OQ7bNN84P6NoxwuYWQ8BmlEys8xXD+cElQOSV
   TZkr0XAH67ihHt0O7266VlepB1UXOfUaKIYeEZUnX6uaEGRTO1EKkAIIq
   7+u6MUMBuYN88c5Dh8qYhNYBnUW8WkJSXrxotTkgJzfbLiV2gGK8dPZDa
   s8QHQ/xrLFsgaozDc3AhfWzZrhgVugOh/PRYB8pG3K+qOKIHzL11nFHka
   bCR98qwCOSyBXwLCYL6JiOKBNa9wXayszNtaUnNJLCL+HP4kuI0vxBNjl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311319842"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="311319842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="482984220"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 12:29:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20E903B7; Wed,  2 Feb 2022 22:29:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/1] iio: frequency: adf4350: Make use of device properties
Date:   Wed,  2 Feb 2022 22:29:36 +0200
Message-Id: <20220202202936.56475-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/frequency/adf4350.c | 103 +++++++++++++-------------------
 1 file changed, 42 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 3d9eba716b69..fe5435e76957 100644
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
+	if (deivice_property_read_bool(dev, "adi,phase-detector-polarity-positive-enable"))
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

