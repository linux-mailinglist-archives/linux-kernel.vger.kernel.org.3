Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEFC500EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbiDNNUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbiDNNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:18:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720C9398C;
        Thu, 14 Apr 2022 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649942164; x=1681478164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B+o87umAiGrvPlkkuSVZClpfPRHBEaTV6O93i92xP1Y=;
  b=b35o0HTrS7t0zEp0nGnfiAj2KP5A/nzVZWXgiEUO9wcLrynWEa20dfrq
   nioZay5/RSHIf2Q64YW1vGvwqid2vmmXcpa6Cba5BNiiF21bNIYrfpuQY
   6Js8aK7rNsyXibL3zJsJLmLYVowIO11B4AdEuAYUv7LZ6wShKHOx2IHL9
   CgG/y0A09TGOVCDR8414KPnBvPg7gevzcXp8weQ2krccevZ6UFSY0hYdf
   QGLF5nsTxTw6R4Ni58/A2WFseh1oqVCfMZOBKV3IqB2hY2HC5e4o3rcwl
   4acnCaeYWPCd/Oi7kMkljLfLfuQJU7dgDWMzjlypkCXoJyPTYMIxTNjvf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244811571"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="244811571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="656005392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2022 06:16:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AE43144; Thu, 14 Apr 2022 16:16:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 1/3] iio: imu: adis16480: Make use of device properties
Date:   Thu, 14 Apr 2022 16:15:57 +0300
Message-Id: <20220414131559.24694-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
v2: added tag (Nuno)
 drivers/iio/imu/adis16480.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 44bbe3d19907..68eed088cca6 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -7,14 +7,16 @@
 
 #include <linux/clk.h>
 #include <linux/bitfield.h>
-#include <linux/of_irq.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/math.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/lcm.h>
+#include <linux/property.h>
 #include <linux/swab.h>
 #include <linux/crc32.h>
 
@@ -1239,9 +1241,10 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
-static int adis16480_config_irq_pin(struct device_node *of_node,
-				    struct adis16480 *st)
+static int adis16480_config_irq_pin(struct adis16480 *st)
 {
+	struct device *dev = &st->adis.spi->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct irq_data *desc;
 	enum adis16480_int_pin pin;
 	unsigned int irq_type;
@@ -1267,7 +1270,7 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
 	 */
 	pin = ADIS16480_PIN_DIO1;
 	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
-		irq = of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
+		irq = fwnode_irq_get_byname(fwnode, adis16480_int_pin_names[i]);
 		if (irq > 0) {
 			pin = i;
 			break;
@@ -1295,15 +1298,15 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
 	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
-static int adis16480_of_get_ext_clk_pin(struct adis16480 *st,
-					struct device_node *of_node)
+static int adis16480_fw_get_ext_clk_pin(struct adis16480 *st)
 {
+	struct device *dev = &st->adis.spi->dev;
 	const char *ext_clk_pin;
 	enum adis16480_int_pin pin;
 	int i;
 
 	pin = ADIS16480_PIN_DIO2;
-	if (of_property_read_string(of_node, "adi,ext-clk-pin", &ext_clk_pin))
+	if (device_property_read_string(dev, "adi,ext-clk-pin", &ext_clk_pin))
 		goto clk_input_not_found;
 
 	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
@@ -1317,9 +1320,7 @@ static int adis16480_of_get_ext_clk_pin(struct adis16480 *st,
 	return pin;
 }
 
-static int adis16480_ext_clk_config(struct adis16480 *st,
-				    struct device_node *of_node,
-				    bool enable)
+static int adis16480_ext_clk_config(struct adis16480 *st, bool enable)
 {
 	unsigned int mode, mask;
 	enum adis16480_int_pin pin;
@@ -1330,7 +1331,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st,
 	if (ret)
 		return ret;
 
-	pin = adis16480_of_get_ext_clk_pin(st, of_node);
+	pin = adis16480_fw_get_ext_clk_pin(st);
 	/*
 	 * Each DIOx pin supports only one function at a time. When a single pin
 	 * has two assignments, the enable bit for a lower priority function
@@ -1438,7 +1439,7 @@ static int adis16480_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	ret = adis16480_config_irq_pin(st);
 	if (ret)
 		return ret;
 
@@ -1447,7 +1448,7 @@ static int adis16480_probe(struct spi_device *spi)
 		return ret;
 
 	if (!IS_ERR_OR_NULL(st->ext_clk)) {
-		ret = adis16480_ext_clk_config(st, spi->dev.of_node, true);
+		ret = adis16480_ext_clk_config(st, true);
 		if (ret)
 			return ret;
 
-- 
2.35.1

