Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B75096CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384375AbiDUF1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384357AbiDUF1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:27:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D497DFAF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650518658; x=1682054658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dD/iRv4YKvcUM4A7EpXodVuB+aCOAR9rbP/Lpb3e6Kg=;
  b=HgzhLOCyd9rH8dbqgjNMvewDTxntj5bZC2L7fX02kFWYcDx96D2zyWjL
   Qls7kEBCHuPpx1cFpdlXcSHkW4d4bwRwyvg/2gTGiD5gC4FsX5YVMJGVK
   /9x26p4HiGTKb3pPzMWm5+n0tdbLrUNf0vwGlfAnt6JXATHnKdvErLRnN
   A5/IjKfCYLN3SU+iayOl/r4uBTQSAi7YDf0PWZ6wiIEZRY+fEatNoHAz3
   fjDZBVnaFDG+aKcsxDwQc6kJkip7WDciQurQA5O2REFVKIYRUwfwjBDTA
   nT9cuAkwlxamG96bm6gPBRmXP0UNYveAEq1nKiIkaGv2ZpVXxI2b7Bbye
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246135624"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246135624"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 22:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="702944103"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 03/12] iommu: Add attach/detach_dev_pasid domain ops
Date:   Thu, 21 Apr 2022 13:21:12 +0800
Message-Id: <20220421052121.3464100-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

 - SVA (Shared Virtual Address)
 - kernel DMA with PASID
 - hardware-assist mediated device

This adds a pair of common domain ops for this purpose and adds helpers
to attach/detach a domain to/from a {device, PASID}. Some buses, like
PCI, route packets without considering the PASID value. Thus a DMA target
address with PASID might be treated as P2P if the address falls into the
MMIO BAR of other devices in the group. To make things simple, these
interfaces only apply to devices belonging to the singleton groups, and
the singleton is immutable in fabric i.e. not affected by hotplug.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 21 ++++++++++
 drivers/iommu/iommu.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36f43af0af53..fe7d9ee2bc2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -262,6 +262,8 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @attach_dev_pasid: attach an iommu domain to a pasid of device
+ * @detach_dev_pasid: detach an iommu domain from a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -279,6 +281,10 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*attach_dev_pasid)(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid);
+	void (*detach_dev_pasid)(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t pasid);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -672,6 +678,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1040,6 +1050,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
+					     struct device *dev, ioasid_t pasid)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece25854..c6fdc0067d76 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -38,6 +38,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -630,6 +631,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -3167,3 +3169,96 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
+{
+	return (pdev != opaque) ? -EEXIST : 0;
+}
+
+/*
+ * Use standard PCI bus topology, isolation features, and DMA
+ * alias quirks to check the immutable singleton attribute. If
+ * the device came from DT, assume it is static and then
+ * singleton can know from the device count in the group.
+ */
+static bool device_group_immutable_singleton(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	int count;
+
+	if (!group)
+		return false;
+
+	mutex_lock(&group->mutex);
+	count = iommu_group_device_count(group);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	if (count != 1)
+		return false;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		/*
+		 * The device could be considered to be fully isolated if
+		 * all devices on the path from the device to the host-PCI
+		 * bridge are protected from peer-to-peer DMA by ACS.
+		 */
+		if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
+			return false;
+
+		/* Filter out devices which has any alias device. */
+		if (pci_for_each_dma_alias(pdev, has_pci_alias, pdev))
+			return false;
+
+		return true;
+	}
+
+	/*
+	 * If the device came from DT, assume it is static and then
+	 * singleton can know from the device count in the group.
+	 */
+	return is_of_node(dev_fwnode(dev));
+}
+
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -EINVAL;
+	void *curr;
+
+	if (!domain->ops->attach_dev_pasid)
+		return -EINVAL;
+
+	if (!device_group_immutable_singleton(dev))
+		return -EINVAL;
+
+	group = iommu_group_get(dev);
+	mutex_lock(&group->mutex);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr)
+		goto out_unlock;
+	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	domain->ops->detach_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
-- 
2.25.1

