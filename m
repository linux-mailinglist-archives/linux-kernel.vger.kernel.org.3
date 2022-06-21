Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC15534DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351895AbiFUOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351858AbiFUOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:48:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833325F97
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655822900; x=1687358900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kXsXy+L+MZcFKVnO0IGjZETpA6ssezwYIdKs+tLOkfg=;
  b=n/KEO5Dkv6BshHWvyLsLuU0fozs6WKaBe1RxiGzowQeKfJiASaCp+ceO
   abImAuloeZiCGsohQZSUuPWS5fO7Ir8115Tj7jiCBwD6E3UlHghVPHQ0s
   qdf6ieQfe9Mm9zVdE94Bkl7Nsh8BeCbP9LE226kGiiQs0yVdzplqU9rHF
   SOcfc5Fvbhwedq0OwgOnrKEsNkzFA95qfkatl/c8+uOm4Kdu9Y7cQzl+1
   bMZo9xtMp65R9VC5HXRSAUrY270HOO6bZditC07xTjZO3dPPuTrJj/lTh
   THr8iF0Mu1lgdKmlfsINoDamDfKgY56mpVgtdgV75qhQ9r9xrBUDTaNIy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305579753"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="305579753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643659279"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 07:48:16 -0700
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
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Date:   Tue, 21 Jun 2022 22:43:46 +0800
Message-Id: <20220621144353.17547-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sva iommu_domain represents a hardware pagetable that the IOMMU
hardware could use for SVA translation. This adds some infrastructure
to support SVA domain in the iommu common layer. It includes:

- Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
  type. The IOMMU drivers that support SVA should provide the sva
  domain specific iommu_domain_ops.
- Add a helper to allocate an SVA domain. The iommu_domain_free()
  is still used to free an SVA domain.
- Add helpers to attach an SVA domain to a device and the reverse
  operation.

Some buses, like PCI, route packets without considering the PASID value.
Thus a DMA target address with PASID might be treated as P2P if the
address falls into the MMIO BAR of other devices in the group. To make
things simple, the attach/detach interfaces only apply to devices
belonging to the singleton groups, and the singleton is immutable in
fabric i.e. not affected by hotplug.

The iommu_attach/detach_device_pasid() can be used for other purposes,
such as kernel DMA with pasid, mediation device, etc.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 45 ++++++++++++++++++++-
 drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3fbad42c0bf8..b8b6b8c5e20e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,8 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
+
 /*
  * This are the possible domain-types
  *
@@ -77,6 +79,8 @@ struct iommu_domain_geometry {
  *				  certain optimizations for these domains
  *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
  *				  invalidation.
+ *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process address
+ *				  spaces represented by mm_struct's.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
@@ -86,15 +90,23 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
-	iommu_fault_handler_t handler;
-	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	union {
+		struct {	/* IOMMU_DOMAIN_DMA */
+			iommu_fault_handler_t handler;
+			void *handler_token;
+		};
+		struct {	/* IOMMU_DOMAIN_SVA */
+			struct mm_struct *mm;
+		};
+	};
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -262,6 +274,8 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @block_dev_pasid: block pasid of device from using iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -282,6 +296,10 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+			     ioasid_t pasid);
+	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+				ioasid_t pasid);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -679,6 +697,12 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
+int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			      ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			       ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1052,6 +1076,23 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline struct iommu_domain *
+iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
+{
+	return NULL;
+}
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
index b5c32aab9686..8450f914cb2b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
+#include <linux/sched/mm.h>
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
@@ -39,6 +40,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -660,6 +662,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -1955,6 +1958,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		mmdrop(domain->mm);
 	iommu_put_dma_cookie(domain);
 	domain->ops->free(domain);
 }
@@ -3271,3 +3276,91 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return NULL;
+
+	domain->type = IOMMU_DOMAIN_SVA;
+	mmgrab(mm);
+	domain->mm = mm;
+
+	return domain;
+}
+
+static bool iommu_group_immutable_singleton(struct iommu_group *group,
+					    struct device *dev)
+{
+	int count;
+
+	mutex_lock(&group->mutex);
+	count = iommu_group_device_count(group);
+	mutex_unlock(&group->mutex);
+
+	if (count != 1)
+		return false;
+
+	/*
+	 * The PCI device could be considered to be fully isolated if all
+	 * devices on the path from the device to the host-PCI bridge are
+	 * protected from peer-to-peer DMA by ACS.
+	 */
+	if (dev_is_pci(dev))
+		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
+					    REQ_ACS_FLAGS);
+
+	/*
+	 * Otherwise, the device came from DT/ACPI, assume it is static and
+	 * then singleton can know from the device count in the group.
+	 */
+	return true;
+}
+
+int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			      ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -EBUSY;
+	void *curr;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	group = iommu_group_get(dev);
+	if (!group || !iommu_group_immutable_singleton(group, dev)) {
+		iommu_group_put(group);
+		return -EINVAL;
+	}
+
+	mutex_lock(&group->mutex);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr)
+		goto out_unlock;
+	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			       ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	domain->ops->block_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
-- 
2.25.1

