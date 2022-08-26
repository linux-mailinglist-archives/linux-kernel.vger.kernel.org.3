Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52175A2D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiHZRgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:36:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B765264;
        Fri, 26 Aug 2022 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661535409; x=1693071409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=++DXFFrJGSZ2xO7uiorz/5BbjZWBr5qTgH2/DkE+Qw0=;
  b=Vey+StpzFClWkhYyYrXy/w74jG81aKXzH5CxxzgEPuiB4zxNGOliUtr5
   qz3GhY1NEgCSc9y4TePxuJ++tW0q9DNMTcXbHnty+Dl0xitgmdCtbdw5I
   c6y7lETy6ZTGtcHpTyQ/9WlPdvwyPuqTqYeuzfQoL8KMf1+mSowRAAE6D
   DB8lKOPHOooxWHn65qhW4eT1LoLdn8q52R7mdVSOzu1PdalKyQIBgDOJb
   F49D6isaGFqn7jONrfiUJbQysMSvRCS4kVtxEgAdf/T/LPc9POVLc6i0S
   uzPJV4hgmxFazewpWqQc9w4lpxJ3VQmWe5im+9t+xk42HplSEO3zYdjCy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281528705"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="281528705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938831105"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 10:36:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EEC8E19D; Fri, 26 Aug 2022 20:37:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/1] hwmon: (iio_hwmon) Make use of device properties
Date:   Fri, 26 Aug 2022 20:37:00 +0300
Message-Id: <20220826173700.17395-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: amended commit message (Guenter)
 drivers/hwmon/iio_hwmon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 580a7d125b88..3aa40893fc09 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -6,11 +6,13 @@
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+
 #include <linux/hwmon.h>
-#include <linux/of.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
@@ -149,8 +151,8 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	st->attr_group.attrs = st->attrs;
 	st->groups[0] = &st->attr_group;
 
-	if (dev->of_node) {
-		sname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
+	if (dev_fwnode(dev)) {
+		sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
 		if (!sname)
 			return -ENOMEM;
 		strreplace(sname, '-', '_');
-- 
2.35.1

