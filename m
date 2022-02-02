Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD94A79B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbiBBUoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:44:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:7908 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347281AbiBBUoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643834658; x=1675370658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fFNtUdqOsUtHu8y7aR6loTIrfboofycBmVHXLPaBBIg=;
  b=drgv8DrDxECvhgxJrW/CZOzsMjqEsGTTalFJSOo5X1SqpIHdjgXmL66l
   kovlsE8AVhH7aA4m2DRzjfy+zBtIBEqC+pSl0xFi8Pwxoga1LHEwcCYnl
   kmceL1HrdBO4Br6n01gNCfux05GnZK/Nmed+VDNS2PD8IEBJtppOKRMI0
   FV8jJat3LEBxfKHPlJCuxrJzzYpdfYXum2czoJMjJkQurO29X1B0u5Pi4
   hOC2hi54ZPUUThKmcBmBmq0gyM5qMpBsApOMkRD8LtMssNvYtZ4g3yzlz
   cqJnPCCw0GpEOuCHyiGSgfbRijPRmcG6+Qc9AbnwC29ZAQSOvBHK32LfA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="246849795"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="246849795"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="497881216"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2022 12:44:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 661FB3B7; Wed,  2 Feb 2022 22:44:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/1] iio: multiplexer: Make use of device properties
Date:   Wed,  2 Feb 2022 22:44:27 +0200
Message-Id: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
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
v2: dropped depends on OF
 drivers/iio/multiplexer/Kconfig   |  1 -
 drivers/iio/multiplexer/iio-mux.c | 48 ++++++++++++++-----------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/multiplexer/Kconfig
index a1e1332d1206..928f424a1ed3 100644
--- a/drivers/iio/multiplexer/Kconfig
+++ b/drivers/iio/multiplexer/Kconfig
@@ -9,7 +9,6 @@ menu "Multiplexers"
 config IIO_MUX
 	tristate "IIO multiplexer driver"
 	select MULTIPLEXER
-	depends on OF || COMPILE_TEST
 	help
 	  Say yes here to build support for the IIO multiplexer.
 
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index f422d44377df..e6f0fef96494 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -10,11 +10,12 @@
 #include <linux/err.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mux/consumer.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 struct mux_ext_info_cache {
 	char *data;
@@ -324,37 +325,20 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
 	return 0;
 }
 
-/*
- * Same as of_property_for_each_string(), but also keeps track of the
- * index of each string.
- */
-#define of_property_for_each_string_index(np, propname, prop, s, i)	\
-	for (prop = of_find_property(np, propname, NULL),		\
-	     s = of_prop_next_string(prop, NULL),			\
-	     i = 0;							\
-	     s;								\
-	     s = of_prop_next_string(prop, s),				\
-	     i++)
-
 static int mux_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev;
 	struct iio_channel *parent;
 	struct mux *mux;
-	struct property *prop;
-	const char *label;
+	const char **labels;
 	u32 state;
+	int children, all_children;
 	int sizeof_ext_info;
-	int children;
 	int sizeof_priv;
 	int i;
 	int ret;
 
-	if (!np)
-		return -ENODEV;
-
 	parent = devm_iio_channel_get(dev, "parent");
 	if (IS_ERR(parent))
 		return dev_err_probe(dev, PTR_ERR(parent),
@@ -366,9 +350,21 @@ static int mux_probe(struct platform_device *pdev)
 		sizeof_ext_info *= sizeof(*mux->ext_info);
 	}
 
+	all_children = device_property_count_string_array(dev, "channels");
+	if (all_children < 0)
+		return all_children;
+
+	labels = devm_kmalloc_array(dev, all_children, sizeof(char *), GFP_KERNEL);
+	if (!labels)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(dev, "channels", labels, all_children);
+	if (ret < 0)
+		return ret;
+
 	children = 0;
-	of_property_for_each_string(np, "channels", prop, label) {
-		if (*label)
+	for (state = 0; state < all_children; state++) {
+		if (*labels[state])
 			children++;
 	}
 	if (children <= 0) {
@@ -395,7 +391,7 @@ static int mux_probe(struct platform_device *pdev)
 	mux->cached_state = -1;
 
 	mux->delay_us = 0;
-	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
+	device_property_read_u32(dev, "settle-time-us", &mux->delay_us);
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &mux_info;
@@ -426,11 +422,11 @@ static int mux_probe(struct platform_device *pdev)
 	}
 
 	i = 0;
-	of_property_for_each_string_index(np, "channels", prop, label, state) {
-		if (!*label)
+	for (state = 0; state < all_children; state++) {
+		if (!*labels[state])
 			continue;
 
-		ret = mux_configure_channel(dev, mux, state, label, i++);
+		ret = mux_configure_channel(dev, mux, state, labels[state], i++);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.34.1

