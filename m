Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43B4B3F20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiBNB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:58:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiBNB6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:58:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FB5418B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644803879; x=1676339879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GGPcPGkbkHt1Y4H+/VPbuoavbqaUa2IcnRax9XTlCs8=;
  b=gjYFHfhQa7kizjnKF2ymt4BdUKimqx1gJDzKaBj5fxL6uBSI9T5Uy8KU
   9ji/Bwa4VLXyQu7tqBulYo+o4zTQnkz5rOgIozxiHIqOhFMg9qsbr8/KP
   APAbILWPtniefZddr+gFOM7T9+8XuCpH2lbTcrOL3IZScRNErquollBTt
   4W+tlyIUCI0PxRu0oDXcndQsSeX4SXY5MhFbIWVNRG57vMHvMx/CIzSxy
   WMQxMRVBkVn+lWc6pXuPcFU9rb+aQPX8lfW94TIvwY+3GdhKwtVHpdXag
   Prj5pwmLvYSsbGm0ZMVIFdv8MQSfk+8EzYOcQ65IeBtPebhTopjyW/Z3U
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248823709"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="248823709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 17:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680137341"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 17:57:55 -0800
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 07/10] iommu: Use right way to retrieve iommu_ops
Date:   Mon, 14 Feb 2022 09:55:35 +0800
Message-Id: <20220214015538.2828933-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 7cf073c56036..d290d8be6133 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -833,8 +833,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
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
@@ -1252,10 +1254,10 @@ int iommu_page_response(struct device *dev,
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
@@ -1296,7 +1298,7 @@ int iommu_page_response(struct device *dev,
 			msg->pasid = 0;
 		}
 
-		ret = domain->ops->page_response(dev, evt, msg);
+		ret = ops->page_response(dev, evt, msg);
 		list_del(&evt->list);
 		kfree(evt);
 		break;
@@ -1759,10 +1761,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 
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
@@ -2020,7 +2022,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
 		return __iommu_attach_device(domain, dev);
-- 
2.25.1

