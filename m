Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8415392F5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbiEaOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243973AbiEaOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:11:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4E64D14;
        Tue, 31 May 2022 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654006281; x=1685542281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yzu5FPYImu2WBpuvDEFFP5ixeektvOVGiblDrxZebqE=;
  b=bpiYKeI1o1a7ioMtIrASADagACAyp0yWbyOrGJYda66POPtDnAhKyTbq
   KbAVhfjQL+HAqLrx4y3w97EjOofRP2jy665JA1QvEBwkC0lOoCkxmEStr
   D8RPJNvjHGxKfKQDunSSGNzzOYo8tmHkcvz2BIB3UoCRGVa6Gz2ua+TLl
   YaN2f6pH4oX+IEkGJsgmHedyfmlfOp01VIO/PbgYMLgEQNqjRZMmlhD2D
   Isn4d8ufMFnQBIMBvILD613xMX/TlmVlBZmdzwA6RiId42ZIxiCgs2nRO
   eVNxIbOTjMomoRB6r9rdcLOdH2I5/DaSKh3jilEtdNOF/CXhizfza2gS0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257330307"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="257330307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="679593529"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2022 07:11:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A853D14F; Tue, 31 May 2022 17:11:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device properties
Date:   Tue, 31 May 2022 17:11:17 +0300
Message-Id: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 39 ++++++++++++------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 823c8e5f9809..e883f95f0cda 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -17,10 +17,11 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -1182,14 +1183,13 @@ static const struct of_device_id xadc_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 
-static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
-	unsigned int *conf, int irq)
+static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
 	const struct iio_chan_spec *channel_templates;
 	struct iio_chan_spec *channels, *chan;
-	struct device_node *chan_node, *child;
+	struct fwnode_handle *chan_node, *child;
 	unsigned int max_channels;
 	unsigned int num_channels;
 	const char *external_mux;
@@ -1200,7 +1200,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 
 	*conf = 0;
 
-	ret = of_property_read_string(np, "xlnx,external-mux", &external_mux);
+	ret = device_property_read_string(dev, "xlnx,external-mux", &external_mux);
 	if (ret < 0 || strcasecmp(external_mux, "none") == 0)
 		xadc->external_mux_mode = XADC_EXTERNAL_MUX_NONE;
 	else if (strcasecmp(external_mux, "single") == 0)
@@ -1211,8 +1211,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		return -EINVAL;
 
 	if (xadc->external_mux_mode != XADC_EXTERNAL_MUX_NONE) {
-		ret = of_property_read_u32(np, "xlnx,external-mux-channel",
-					&ext_mux_chan);
+		ret = device_property_read_u32(dev, "xlnx,external-mux-channel", &ext_mux_chan);
 		if (ret < 0)
 			return ret;
 
@@ -1247,19 +1246,19 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	num_channels = 9;
 	chan = &channels[9];
 
-	chan_node = of_get_child_by_name(np, "xlnx,channels");
+	chan_node = device_get_named_child_node(dev, "xlnx,channels");
 	if (chan_node) {
-		for_each_child_of_node(chan_node, child) {
+		fwnode_for_each_child_node(chan_node, child) {
 			if (num_channels >= max_channels) {
-				of_node_put(child);
+				fwnode_handle_put(child);
 				break;
 			}
 
-			ret = of_property_read_u32(child, "reg", &reg);
+			ret = fwnode_property_read_u32(child, "reg", &reg);
 			if (ret || reg > 16)
 				continue;
 
-			if (of_property_read_bool(child, "xlnx,bipolar"))
+			if (fwnode_property_read_bool(child, "xlnx,bipolar"))
 				chan->scan_type.sign = 's';
 
 			if (reg == 0) {
@@ -1273,7 +1272,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 			chan++;
 		}
 	}
-	of_node_put(chan_node);
+	fwnode_handle_put(chan_node);
 
 	/* No IRQ => no events */
 	if (irq <= 0) {
@@ -1316,7 +1315,6 @@ static void xadc_cancel_delayed_work(void *data)
 static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *id;
 	const struct xadc_ops *ops;
 	struct iio_dev *indio_dev;
 	unsigned int bipolar_mask;
@@ -1326,15 +1324,10 @@ static int xadc_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	if (!dev->of_node)
-		return -ENODEV;
-
-	id = of_match_node(xadc_of_match_table, dev->of_node);
-	if (!id)
+	ops = device_get_match_data(dev);
+	if (!ops)
 		return -EINVAL;
 
-	ops = id->data;
-
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0 &&
 	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
@@ -1345,7 +1338,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	xadc = iio_priv(indio_dev);
-	xadc->ops = id->data;
+	xadc->ops = ops;
 	init_completion(&xadc->completion);
 	mutex_init(&xadc->mutex);
 	spin_lock_init(&xadc->lock);
@@ -1359,7 +1352,7 @@ static int xadc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &xadc_info;
 
-	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0, irq);
+	ret = xadc_parse_dt(indio_dev, &conf0, irq);
 	if (ret)
 		return ret;
 
-- 
2.35.1

