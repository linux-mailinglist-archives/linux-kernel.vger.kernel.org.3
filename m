Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AED585A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiG3Mua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3Mu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:50:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6994C10FD4;
        Sat, 30 Jul 2022 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659185427; x=1690721427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9N+Y0hwSBNvilXODigvbdDCkEB5+1QfNgg0yfN9wBLo=;
  b=hbNtEFeGlESUVRVUX7lc5Pvpbk1TjUIg4UIwE61W7NJChhC+W4y7DhqM
   qj84mWs/JfdFksbojjc+8Ma/gBrTOdeuNAFwsbv3y5gkZVzuVndxUx/jS
   P+g6mS3YMhU9z1ShRnseogiqpMOoHyGkyjFL5YYQE2gl29cnqVGjFgmB7
   P+rXEEU70XkkNi1Dj1C6A8O3G5dc7p8ZgnuxSJ07mkmG0T53cXgoXEafg
   kVyYDG1mNrNNZ0Z4dxqwgPwElMbBpRY25P/TKf3SJbN0m4DhgqAxyZj9E
   OX9BuwJp97FuvEey/n9RjcBvlkP1bIlEoGQ9WQIbzdhn4DG6mVTX6/FaJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287671346"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="287671346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 05:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="552016971"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2022 05:50:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7138FF1; Sat, 30 Jul 2022 15:50:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] hwmon: (iio_hwmon) Make use of device properties
Date:   Sat, 30 Jul 2022 15:50:24 +0300
Message-Id: <20220730125024.87764-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

