Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4B586EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiHAQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiHAQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:47:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE95FF4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372474; x=1690908474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GLP49io1pzmQUn9VHWWPHuXHd9od2/sjs2BB4xjqYf8=;
  b=J/0LRypEvSzu4iX2e+AfxHSo/G4BCNGQbscsOX/bvglCPxfBRBSVxY4J
   2XoaqK6YTaAZWRohcttIDrZF6SJ7zOg30GUCFmxtefPZ4gDO/XZd6NAaZ
   JMxzyn30qhNKC7ITKa1O6AiC4zkPFkJex08aXwLevtICXJPZxpdo4hoSN
   iZNmO45NRW/F9GuFs7PA6U637EzN9fYN0HNc7OaefVYlXVQyWM+j7e/N5
   nUbZtjg6kod1z40jrookrFLFn03fUfa0yuL9Mf+oCyM6qfX4u1Td1N+r0
   3v7hzm0xxsliUcG9tYxUTy+liR5IWp3thJ3ePGu9ReqBpFCbAZ5ccpeYb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269574730"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="269574730"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="661226677"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 09:47:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 783B4F7; Mon,  1 Aug 2022 19:48:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
Date:   Mon,  1 Aug 2022 19:47:58 +0300
Message-Id: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
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

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device.
Instead, use the specific dev_fwnode() API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..31b5f4ceb2e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -173,7 +173,7 @@ int iommu_device_register(struct iommu_device *iommu,
 
 	iommu->ops = ops;
 	if (hwdev)
-		iommu->fwnode = hwdev->fwnode;
+		iommu->fwnode = dev_fwnode(hwdev);
 
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
-- 
2.35.1

