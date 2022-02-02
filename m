Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1264A790C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347056AbiBBTzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:55:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:60938 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbiBBTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643831703; x=1675367703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y5ntJ5RdaDE7jrG5eEFatH115Trqmvs9XFLjUyDSvQY=;
  b=PS0+aWWROyEr2ESsuzzV68/x4x3mbryxV8ZCVPpew4KNTG4pQg0GXAcb
   setujrjeMOOLviGeuehlogOS1vfTp5FDFXqrN7l7KgbfBOVYh8zkh81Dv
   oVTq+mzsXoRkNmTqTq/+En/3pq8xly3HUoZ3/PdKbGPKN1WE4XE5p6KKH
   q9JaOtBDJgxUSPCS7FPVayMQWAqogmeVl4fW0Yc0ClxxNw3zTyWeWvZBS
   Y3tGeScoOLuvD71Spx9raJaVxP+koQX048YncVzPO9V6X7YTWjmZpBU5E
   7iRSpARJD6306mHh2NuQKngTayU6f0JS5g57yJpWDp+XeCwdPUtnWrBC8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245604632"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="245604632"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 11:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="583559701"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2022 11:55:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA1E93B7; Wed,  2 Feb 2022 21:55:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: multiplexer: Make use of device properties
Date:   Wed,  2 Feb 2022 21:55:11 +0200
Message-Id: <20220202195511.55987-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/multiplexer/iio-mux.c | 48 ++++++++++++++-----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

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

