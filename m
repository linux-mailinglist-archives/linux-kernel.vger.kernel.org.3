Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD345662AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGEFMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGEFMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:12:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8313D15
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656997923; x=1688533923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOuJcckSmEJG/2YCRrXp2jo9koUTopyV3uPrKxZRKYg=;
  b=iknNbGjFXoxfYWTTRDfKAqlPDLCAyoRCJKWRyMPxNQ9AOIpvXK9u6zPe
   slgsH76964OeI7CJ2ugN+qt5SDYkZGfSuk/+EwM9oYAxZWYasDOuI6kcg
   TufY5Jns7ql48MShiZn6ZachEOINr95pHSYI73Tb/98FmGLL1EFKnlrAx
   rvvUAn9n0oa4lqNBLtu0//qsn7iUMz8U65ZtE3IwjQekBh/iGFOgOX6NQ
   APulH21Pil/TvPeALb43zxYAXn6MHTXhSMn6kJoGJU+jfe6ALxiRPFd1D
   evDdr6021PhOkbH6H95c4GU9pJhfH3xvn7rbwkT337LeFH42BTu8UL/0G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="272029380"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="272029380"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542807370"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 22:11:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v10 02/12] iommu: Add max_pasids field in struct dev_iommu
Date:   Tue,  5 Jul 2022 13:07:00 +0800
Message-Id: <20220705050710.2887204-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use this field to save the number of PASIDs that a device is able to
consume. It is a generic attribute of a device and lifting it into the
per-device dev_iommu struct could help to avoid the boilerplate code
in various IOMMU drivers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h |  2 ++
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 03fbb1b71536..418a1914a041 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -364,6 +364,7 @@ struct iommu_fault_param {
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
+ * @max_pasids:  number of PASIDs this device can consume
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -375,6 +376,7 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	u32				max_pasids;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cdc86c39954e..0cb0750f61e8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -20,6 +20,7 @@
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
@@ -218,6 +219,24 @@ static void dev_iommu_free(struct device *dev)
 	kfree(param);
 }
 
+static u32 dev_iommu_get_max_pasids(struct device *dev)
+{
+	u32 max_pasids = 0, bits = 0;
+	int ret;
+
+	if (dev_is_pci(dev)) {
+		ret = pci_max_pasids(to_pci_dev(dev));
+		if (ret > 0)
+			max_pasids = ret;
+	} else {
+		ret = device_property_read_u32(dev, "pasid-num-bits", &bits);
+		if (!ret)
+			max_pasids = 1UL << bits;
+	}
+
+	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
@@ -243,6 +262,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	dev->iommu->iommu_dev = iommu_dev;
+	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
-- 
2.25.1

