Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7814FFD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiDMSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiDMSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:04:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CED45041;
        Wed, 13 Apr 2022 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649872928; x=1681408928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Is//9I+IJBN+6h55CvIruWnY68fFcMmAMuL6L+0eWl4=;
  b=Zyyp+TzR8SHL32I+T/jiA5mU7+8kzY9FDq1+2BYyFJ7KYaBEWaQLpLUX
   79P6fKZBpRmOrQZ7zYF9VC9nEK4vBZszBUo80tUMYf/5Br6/rwsqn+dl2
   Q7hM8dfmxxlEzoYDp/o1pf9Itf+KbiaOOlxqx77YvbK73xWorwk8KrV3K
   0DOijh10ymLYi5FOOtDlpYbFnN2fvhONos8Vicsop2mpNqn7tySEGCNju
   PBWubL6I6dbyDsEolO2TA4J7AP0h1wESzCvEIeE2bnW73/Lfe/wfU5Yxe
   mb5snlw0Gubgpj4OKUBW4jJwHO5vKe6stEXzUYGtYShYh0T4ocQVUNrFT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262489091"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262489091"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="700344134"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2022 11:02:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1AAFE12C; Wed, 13 Apr 2022 21:02:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: core: Convert to use firmware node handle instead of OF node
Date:   Wed, 13 Apr 2022 21:02:02 +0300
Message-Id: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the IIO core to use firmware node handle instead of OF node.
This will allow to get label from firmware on non-OF systems.

Note, this doesn't change of_iio_*() APIs for now.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2f48e9a97274..ffbe76806e07 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1893,20 +1893,22 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	const char *label;
+	struct fwnode_handle *fwnode;
 	int ret;
 
 	if (!indio_dev->info)
 		return -EINVAL;
 
 	iio_dev_opaque->driver_module = this_mod;
-	/* If the calling driver did not initialize of_node, do it here */
-	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
-		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
 
-	label = of_get_property(indio_dev->dev.of_node, "label", NULL);
-	if (label)
-		indio_dev->label = label;
+	/* If the calling driver did not initialize firmware node, do it here */
+	if (dev_fwnode(&indio_dev->dev))
+		fwnode = dev_fwnode(&indio_dev->dev);
+	else
+		fwnode = dev_fwnode(indio_dev->dev.parent);
+	device_set_node(&indio_dev->dev, fwnode);
+
+	fwnode_property_read_string(fwnode, "label", &indio_dev->label);
 
 	ret = iio_check_unique_scan_index(indio_dev);
 	if (ret < 0)
-- 
2.35.1

