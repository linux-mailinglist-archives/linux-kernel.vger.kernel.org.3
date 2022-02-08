Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315654ACE5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiBHBtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbiBHB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:27:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF8C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644283676; x=1675819676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+M2nqJCyyaVbz1uRhhgucV69W5qd5+vtTn3jt9YahY=;
  b=l06mALc9EpS+N+VrpiQNpRrtD9XbQHCoeUtgJ5VO2jSu/wPuhhM3PHMc
   A/bCQbyMwfAK/HUSXu2WH/o0Ye6Xtls3x66yI//RuAH22GS/rNud7v4TM
   3hyL3/V1a1NHfeV/8AmfqnSIbVdUy8Nw51NoQhVo3zAahD9YVzEeTrVwR
   0OKPkB4yMa5pt7/b2oEgUGXecMr9AN4LwM8jgZnFX8Cx28CZUU162kCa6
   LrUDQxs8OUAvn/pi7GaaXi7/vty2ZqVfiLUqSVpBtD3DOz/9azJrv68R/
   /m3ZfXKS2iTcWIo7BUbkFWlG1GUC5ZhmauxKXxfOtbynIAN+7HiJcGJ4R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236251986"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236251986"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677948849"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:27:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 07/10] iommu: Use right way to retrieve iommu_ops
Date:   Tue,  8 Feb 2022 09:25:56 +0800
Message-Id: <20220208012559.1121729-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
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

The common iommu_ops is hooked to both device and domain. When a helper
has both device and domain pointer, the way to get the iommu_ops looks
messy in iommu core. This sorts out the way to get iommu_ops. The device
related helpers go through device pointer, while the domain related ones
go through domain pointer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 14 ++++++++++++++
 drivers/iommu/iommu.c | 20 +++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ffa2e88f3d0..eb2684f95018 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -381,6 +381,20 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	/*
+	 * Assume that valid ops must be installed if iommu_probe_device()
+	 * has succeeded. The device ops are essentially for internal use
+	 * within the IOMMU subsystem itself, so we should be able to trust
+	 * ourselves not to misuse the helper.
+	 */
+	WARN_ON(!dev || !dev->iommu || !dev->iommu->iommu_dev ||
+		!dev->iommu->iommu_dev->ops);
+
+	return dev->iommu->iommu_dev->ops;
+}
+
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
 #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index df6bd1d58c74..de593a9cc09c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -828,8 +828,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	if (domain->ops->is_attach_deferred)
-		return domain->ops->is_attach_deferred(domain, dev);
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (ops->is_attach_deferred)
+		return ops->is_attach_deferred(domain, dev);
 
 	return false;
 }
@@ -1248,10 +1250,10 @@ int iommu_page_response(struct device *dev,
 	struct iommu_fault_event *evt;
 	struct iommu_fault_page_request *prm;
 	struct dev_iommu *param = dev->iommu;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (!domain || !domain->ops->page_response)
+	if (!ops->page_response)
 		return -ENODEV;
 
 	if (!param || !param->fault_param)
@@ -1292,7 +1294,7 @@ int iommu_page_response(struct device *dev,
 			msg->pasid = 0;
 		}
 
-		ret = domain->ops->page_response(dev, evt, msg);
+		ret = ops->page_response(dev, evt, msg);
 		list_del(&evt->list);
 		kfree(evt);
 		break;
@@ -1755,10 +1757,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
-	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (domain->ops->probe_finalize)
-		domain->ops->probe_finalize(dev);
+	if (ops->probe_finalize)
+		ops->probe_finalize(dev);
 
 	return 0;
 }
@@ -2016,7 +2018,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
 		return __iommu_attach_device(domain, dev);
-- 
2.25.1

