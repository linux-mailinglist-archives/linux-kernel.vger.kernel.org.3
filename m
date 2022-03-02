Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3398D4CA9C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbiCBQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCBQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:01:19 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1552E2E;
        Wed,  2 Mar 2022 08:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236836; x=1677772836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IlGvGhlzZw5Rk1Dvudqx76u6Ai1Xc9o+P12hHfydFOc=;
  b=kNVXChhv8tp52f/nuckMlqUcAtR14F9YctgibfjqfpkPn8c2kqa1B/SS
   SJDkIV301ojYGRvT5Mqt/TNGRQj3bdIkneWb8hsM9M/k3mZvoT0IK2qu7
   aTaTgLYYNUWLUWkX/O1mLHUdiZ0Hs+BBrvdO1Xpo0IPwycHjDNopmoRka
   xQ7dkytFFX+unxYSj4IyUI/xlkOAnpXrMCcR/X4pyxK+r7r/eo4d9n09A
   t92dwVvt9sy6Z2qyhg1+FC3X/JvSlWIJnKTmjjtB9v6lYWLl2H/HR8D2q
   /z6vOhFzWvf8IJFtyyAWFO/00aJ4bheJt131NfbKRDE3pImBYnVUYqjV6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="314153580"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="314153580"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="778915064"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2022 08:00:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD08B183; Wed,  2 Mar 2022 18:00:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/1] iio: multiplexer: Make use of device properties
Date:   Wed,  2 Mar 2022 18:00:25 +0200
Message-Id: <20220302160025.54348-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
v3: split variable definitions on 1 per line basis (Peter), fixed typo (Jonathan)
 drivers/iio/multiplexer/Kconfig   |  1 -
 drivers/iio/multiplexer/iio-mux.c | 49 +++++++++++++++----------------
 2 files changed, 23 insertions(+), 27 deletions(-)

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
index f422d44377df..93558fddfa9b 100644
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
@@ -324,37 +325,21 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
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
+	int all_children;
+	int children;
 	u32 state;
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
@@ -366,9 +351,21 @@ static int mux_probe(struct platform_device *pdev)
 		sizeof_ext_info *= sizeof(*mux->ext_info);
 	}
 
+	all_children = device_property_string_array_count(dev, "channels");
+	if (all_children < 0)
+		return all_children;
+
+	labels = devm_kmalloc_array(dev, all_children, sizeof(*labels), GFP_KERNEL);
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
@@ -395,7 +392,7 @@ static int mux_probe(struct platform_device *pdev)
 	mux->cached_state = -1;
 
 	mux->delay_us = 0;
-	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
+	device_property_read_u32(dev, "settle-time-us", &mux->delay_us);
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &mux_info;
@@ -426,11 +423,11 @@ static int mux_probe(struct platform_device *pdev)
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

