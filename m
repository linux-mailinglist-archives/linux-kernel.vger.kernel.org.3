Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA4586F07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiHAQvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHAQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:51:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C4BF5C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372696; x=1690908696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+4xX1yVvA2wu0xZxhzDmYNktoQ+T+Qf9rMWkxS3Rkfs=;
  b=e6yQzbaN+WaY5q29iVEuI+7+GYA9x8DlVtCAaHpGqm439QMMPVpAsHCS
   MlFhAbu5wAX+mr2UHDo9/XHJ8etBYHAXVSxwTnSHUHjj7xSEKSKs8nB9I
   44JUVg7rWoTjYsp87dz4iYzxVK7oBKThSiOby1QrANar0MrhKLpwMIgp4
   TpM6Xdk+ZJvUW9mbNrRlwUbiqJDtrq0rpx5LkAb+6qW/U4QnOKIaBeupl
   Nqse+WoVlIMmLceKMtIQLhj2rSqn4+UegibXDkqsItSBzZFc9hORsl1GN
   gzQjeYa9pCzfGIPzP+TjSPEZWBLdXlJjmtWZs5Z1HOAT+QTkfFtLX/yoN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="286753155"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="286753155"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="577852276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2022 09:51:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77907F7; Mon,  1 Aug 2022 19:51:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct device
Date:   Mon,  1 Aug 2022 19:51:42 +0300
Message-Id: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device.
Instead, use the specific device_match_fwnode() API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..9fe723f55213 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -925,7 +925,7 @@ static struct virtio_driver virtio_iommu_drv;
 
 static int viommu_match_node(struct device *dev, const void *data)
 {
-	return dev->parent->fwnode == data;
+	return device_match_fwnode(dev->parent, data);
 }
 
 static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
-- 
2.35.1

