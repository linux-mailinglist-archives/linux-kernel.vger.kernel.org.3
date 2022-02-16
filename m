Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2104B7E38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiBPCzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:55:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbiBPCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:55:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42AFFBF1C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644980097; x=1676516097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uXrn14nMTQITQECZX3ONrx8+Lps8fl1/nT7YqPDyvjs=;
  b=BsUI4BPlz0pIa2L7jbpHfmoSMjgqisEzD9U76oXiMAkmp67nKuY0k7i8
   wOPzH5oYgi/l5nQJTbQPvJt0LBHHgU2ZtHUC/GXnsZenmwlWX26i1FoSI
   udW7U+CWMeI4FDEjDOrm6/+efvt2W5jE4/4LalJ3jSlKEIubIbuT2+hnu
   RyxwoN7AMB/MZ+mJQPesQnhEGOjZT/9pUjdsvrJdNmihCM3oQfSO9S7ID
   OUKDdBKiC/j9AM77kixWDb+/xgSadItV//Ajm2cwvvRiyKadR6WDetLNQ
   ZnsXOw1GEuolDSeKov84gLiqB8xWKZfHpCxTDPQ+QJvCPzNGYxNnp2aPm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="336940659"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="336940659"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681312533"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 18:54:53 -0800
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
Subject: [PATCH v4 7/9] iommu: Use right way to retrieve iommu_ops
Date:   Wed, 16 Feb 2022 10:52:47 +0800
Message-Id: <20220216025249.3459465-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
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
 include/linux/iommu.h | 11 ++++++++++
 drivers/iommu/iommu.c | 50 +++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ffa2e88f3d0..90f1b5e3809d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -381,6 +381,17 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
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
+	return dev->iommu->iommu_dev->ops;
+}
+
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
 #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7cf073c56036..7af0ee670deb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -323,13 +323,14 @@ int iommu_probe_device(struct device *dev)
 
 void iommu_release_device(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 
 	if (!dev->iommu)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	ops = dev_iommu_ops(dev);
 	ops->release_device(dev);
 
 	iommu_group_remove_device(dev);
@@ -833,8 +834,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
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
@@ -1252,10 +1255,10 @@ int iommu_page_response(struct device *dev,
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
@@ -1296,7 +1299,7 @@ int iommu_page_response(struct device *dev,
 			msg->pasid = 0;
 		}
 
-		ret = domain->ops->page_response(dev, evt, msg);
+		ret = ops->page_response(dev, evt, msg);
 		list_del(&evt->list);
 		kfree(evt);
 		break;
@@ -1521,7 +1524,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 static int iommu_get_def_domain_type(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
@@ -1580,7 +1583,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
  */
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -1588,9 +1591,6 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (group)
 		return group;
 
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		return ERR_PTR(-EINVAL);
@@ -1759,10 +1759,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 
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
@@ -2020,7 +2020,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
 		return __iommu_attach_device(domain, dev);
@@ -2579,17 +2579,17 @@ EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops && ops->get_resv_regions)
+	if (ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops && ops->put_resv_regions)
+	if (ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
 }
 
@@ -2794,9 +2794,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_bind)
+	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
 	group = iommu_group_get(dev);
@@ -2837,9 +2837,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_group *group;
 	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_unbind)
+	if (!ops->sva_unbind)
 		return;
 
 	group = iommu_group_get(dev);
@@ -2856,9 +2856,9 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
 u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
-	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
 
-	if (!ops || !ops->sva_get_pasid)
+	if (!ops->sva_get_pasid)
 		return IOMMU_PASID_INVALID;
 
 	return ops->sva_get_pasid(handle);
-- 
2.25.1

