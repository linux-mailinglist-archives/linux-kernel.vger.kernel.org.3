Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF57519E28
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiEDLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348906AbiEDLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:39:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEBA2B25F;
        Wed,  4 May 2022 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651664163; x=1683200163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7C3kW2JgC07k1KkETjGbC4cqsYvXG7ExF22Q6uzU8/8=;
  b=hfcRgGaX7yB1tzrXLJUVtschoxAvk352KvkEMsZfudEJaReDjYveIYr+
   MUllQps/aHsc/wH9yj7MQunXqm0VplTioOI3JaocK2Zl3rN7a1elF6Wx7
   lSzl0PNY5jJdJbRuu5y+S03h94Oz5nZqOpobYjZ28CwavxpPsrjVuyE/H
   ZkOvb1bdc+sNS1nlUYMNhEc/aAM62Uu9eJaIstdAOlllD14zMIzAg4sg0
   zZrAsIJsvx/V5VFBfS7OKhSrWlSsReRHDQtWrts5rf7dHgL8jaB29sp5W
   kKp6DBA1lQHOWiyg80KtOOybovjrRkDrZ5SMHFX2ORj+jQHmnuAqC/TB/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267620629"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="267620629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 04:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="516988540"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2022 04:36:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F132A2E4; Wed,  4 May 2022 14:36:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: proximity: srf04: Make use of device properties
Date:   Wed,  4 May 2022 14:35:57 +0300
Message-Id: <20220504113557.59048-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/iio/proximity/srf04.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 4e6286765f01..05015351a34a 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -37,9 +37,8 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/sched.h>
@@ -261,7 +260,7 @@ static int srf04_probe(struct platform_device *pdev)
 
 	data = iio_priv(indio_dev);
 	data->dev = dev;
-	data->cfg = of_match_device(of_srf04_match, dev)->data;
+	data->cfg = device_get_match_data(dev);
 
 	mutex_init(&data->lock);
 	init_completion(&data->rising);
@@ -289,10 +288,8 @@ static int srf04_probe(struct platform_device *pdev)
 		return PTR_ERR(data->gpiod_power);
 	}
 	if (data->gpiod_power) {
-
-		if (of_property_read_u32(dev->of_node, "startup-time-ms",
-						&data->startup_time_ms))
-			data->startup_time_ms = 100;
+		data->startup_time_ms = 100;
+		device_property_read_u32(dev, "startup-time-ms", &data->startup_time_ms);
 		dev_dbg(dev, "using power gpio: startup-time-ms=%d\n",
 							data->startup_time_ms);
 	}
-- 
2.35.1

