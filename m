Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A84FFDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiDMSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiDMSgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:36:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22585FB7;
        Wed, 13 Apr 2022 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649874867; x=1681410867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tqdiP8eymdT01+dQE/j7jvUQJEU8T8q8nv/Aq0uBY14=;
  b=l2R/al7JYG3FFmVSi2U5OlgT7niZlGgAoUKv3RzjCK6wDXFHWa1LzHiJ
   83UA7I+V4JxBsOQOWiu+J9VpvIu5aRVciqdkLKSnwbiXr4pwZ/FKpoSVI
   bIaP0ryS70LTzBRRD4GD8sj6QcV+vk/SvQNCM0LcuRNecowy7NCKZLsym
   JqDWOXOqU37PWJ3jhERVEJtZfJsjmjIUg5fqDsTm6JXF9cJR9OyZM97ow
   J8dOa0Oa+oAAVzS3iAwAACAYPFlCwyHAUcLhZsyzk3sYSORzNWORsrgIs
   HdPu0l0jjIiDDchEQpIkdej34W38P+b6oWO689TJ5gdPqSdk66vhZ0L5r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244631163"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244631163"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="611995131"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2022 11:34:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C947012C; Wed, 13 Apr 2022 21:34:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: proximity: ping: Replace OF specific code by device_get_match_data()
Date:   Wed, 13 Apr 2022 21:34:21 +0300
Message-Id: <20220413183421.20427-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling the OF specific API, use device_get_match_data().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/ping.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 24a97d41e115..d56e037378de 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -29,9 +29,8 @@
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
@@ -288,7 +287,7 @@ static int ping_probe(struct platform_device *pdev)
 
 	data = iio_priv(indio_dev);
 	data->dev = dev;
-	data->cfg = of_device_get_match_data(dev);
+	data->cfg = device_get_match_data(dev);
 
 	mutex_init(&data->lock);
 	init_completion(&data->rising);
-- 
2.35.1

