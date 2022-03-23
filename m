Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB634E53E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiCWOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbiCWOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:04:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E227EA36;
        Wed, 23 Mar 2022 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648044165; x=1679580165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4sgeijGceUMtFiNi8CbAsikud7SBu6t9v97p4z5Rf9E=;
  b=IQDPTna+wUsNikgKk2/ilBySVBpPbg1nC74xaqNKbfaQoyTRI1PUoitg
   K6nQvTFR2vIC762QsYP5Q6y27aGmjJXo1YLzrLVWKHQh6AmItO9OJYGPr
   oW51HOxW4cUnwq/NMtGzi1lBBccNKrO5YY0yJs455vHqdXK5irueCHhFN
   tzZtUdv3d9zSN/YbzdNkLOSKFUAkLz9rmzpRtyzIxfWM5BQCnJO+/SxeM
   U39nGGn+4qu9rnJ3nzkgiOnv22jDt/ds1yoavQo/DxFGqMdrTJ4oA47GH
   2808WWctg0kTy2Z7iI1Q4JpqhbEr3biTV/nU2Br0bF3t0wz/jvXIK6Puu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="238058428"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="238058428"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="515786170"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2022 07:01:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA9481D9; Wed, 23 Mar 2022 16:02:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/4] spidev: Do not use atomic bit operations when allocating minor
Date:   Wed, 23 Mar 2022 16:02:12 +0200
Message-Id: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use atomic bit operations when allocating a minor
number since it's done under a mutex. Moreover, one of the operations
that is in use is non-atomic anyway.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 53a551714265..daeaa4a30290 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -795,7 +795,7 @@ static int spidev_probe(struct spi_device *spi)
 		status = -ENODEV;
 	}
 	if (status == 0) {
-		set_bit(minor, minors);
+		__set_bit(minor, minors);
 		list_add(&spidev->device_entry, &device_list);
 	}
 	mutex_unlock(&device_list_lock);
@@ -823,7 +823,7 @@ static void spidev_remove(struct spi_device *spi)
 
 	list_del(&spidev->device_entry);
 	device_destroy(spidev_class, spidev->devt);
-	clear_bit(MINOR(spidev->devt), minors);
+	__clear_bit(MINOR(spidev->devt), minors);
 	if (spidev->users == 0)
 		kfree(spidev);
 	mutex_unlock(&device_list_lock);
-- 
2.35.1

