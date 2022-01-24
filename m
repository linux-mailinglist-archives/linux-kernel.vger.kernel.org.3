Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C5497934
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbiAXHNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:13:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:53096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241701AbiAXHNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643008386; x=1674544386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYj5cRwNq3dJ5zWbW8PEqiQcWKVTSz7wIWzDVfJw1lM=;
  b=eYkx77dasw0AvIPwVRoubTzGHn+fQRFzRmQc/rU7V6dYnsldYgLq3T8K
   WneuYP3JmCrnyV6zdhkb9dOwC76F967VolRlNA0yyMrMfMb6XXzmwRu0Z
   3k8jCzpljnwJRVd1XeVmQg2zHuYazuoPYe/yYNYU5lGps/FO/n9kli5hy
   jA8m7CVTIzjO4hJ2/33e75UGH0XcoOCmcL/LgxPPAAaWWqNZAUDJflaYr
   Nq0oMkCgtgY5fBwStmOLJ6lAiVooj1bzrnPMufzVJFxU2iueW7JLUgYs6
   CbpHnhFQzsTK11kKd+jQvwchVkC+241q6PCuTgw9YrUVXlklcgcUGGpjZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244814268"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244814268"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 23:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627387829"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:52 -0800
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
Subject: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Date:   Mon, 24 Jan 2022 15:11:02 +0800
Message-Id: <20220124071103.2097118-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a domain specific callback set, domain_ops, for vendor iommu driver
to provide domain specific operations. Move domain-specific callbacks
from iommu_ops to the domain_ops and hook them when a domain is allocated.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 93 ++++++++++++---------
 drivers/iommu/amd/iommu.c                   | 21 +++--
 drivers/iommu/apple-dart.c                  | 24 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 23 +++--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 17 ++--
 drivers/iommu/exynos-iommu.c                | 17 ++--
 drivers/iommu/fsl_pamu_domain.c             | 13 ++-
 drivers/iommu/intel/iommu.c                 | 25 ++++--
 drivers/iommu/iommu.c                       | 15 ++--
 drivers/iommu/ipmmu-vmsa.c                  | 21 +++--
 drivers/iommu/msm_iommu.c                   | 17 ++--
 drivers/iommu/mtk_iommu.c                   | 24 ++++--
 drivers/iommu/mtk_iommu_v1.c                | 19 +++--
 drivers/iommu/omap-iommu.c                  | 15 ++--
 drivers/iommu/rockchip-iommu.c              | 17 ++--
 drivers/iommu/s390-iommu.c                  | 15 ++--
 drivers/iommu/sprd-iommu.c                  | 19 +++--
 drivers/iommu/sun50i-iommu.c                | 18 ++--
 drivers/iommu/tegra-gart.c                  | 15 ++--
 drivers/iommu/tegra-smmu.c                  | 16 ++--
 drivers/iommu/virtio-iommu.c                | 18 ++--
 22 files changed, 305 insertions(+), 179 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 111b3e9c79bb..33c5c0e5c465 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -88,7 +88,7 @@ struct iommu_domain_geometry {
 
 struct iommu_domain {
 	unsigned type;
-	const struct iommu_ops *ops;
+	const struct domain_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
 	void *handler_token;
@@ -192,26 +192,11 @@ struct iommu_iotlb_gather {
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
  * @domain_alloc: allocate iommu domain
- * @domain_free: free iommu domain
- * @attach_dev: attach device to an iommu domain
- * @detach_dev: detach device from an iommu domain
- * @map: map a physically contiguous memory region to an iommu domain
- * @map_pages: map a physically contiguous set of pages of the same size to
- *             an iommu domain.
- * @unmap: unmap a physically contiguous memory region from an iommu domain
- * @unmap_pages: unmap a number of pages of the same size from an iommu domain
- * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
- * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
- * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
- *            queue
- * @iova_to_phys: translate iova to physical address
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
  * @device_group: find iommu group for a particular device
- * @enable_nesting: Enable nesting
- * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -237,33 +222,11 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-	void (*domain_free)(struct iommu_domain *);
 
-	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
-	int (*map)(struct iommu_domain *domain, unsigned long iova,
-		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
-	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
-			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			 int prot, gfp_t gfp, size_t *mapped);
-	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
-	size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long iova,
-			      size_t pgsize, size_t pgcount,
-			      struct iommu_iotlb_gather *iotlb_gather);
-	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
-			       size_t size);
-	void (*iotlb_sync)(struct iommu_domain *domain,
-			   struct iommu_iotlb_gather *iotlb_gather);
-	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
-	int (*enable_nesting)(struct iommu_domain *domain);
-	int (*set_pgtable_quirks)(struct iommu_domain *domain,
-				  unsigned long quirks);
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
@@ -296,6 +259,60 @@ struct iommu_ops {
 	struct module *owner;
 };
 
+/**
+ * struct domain_ops - per-domain ops
+ * @attach_dev: attach an iommu domain to a device
+ * @detach_dev: detach an iommu domain from a device
+ * @map: map a physically contiguous memory region to an iommu domain
+ * @map_pages: map a physically contiguous set of pages of the same size to
+ *             an iommu domain.
+ * @unmap: unmap a physically contiguous memory region from an iommu domain
+ * @unmap_pages: unmap a number of pages of the same size from an iommu domain
+ * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
+ * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
+ * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
+ *            queue
+ * @iova_to_phys: translate iova to physical address
+ * @enable_nesting: Enable nesting
+ * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
+ * @release: Release the domain after use.
+ */
+struct domain_ops {
+	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
+	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+
+	int (*map)(struct iommu_domain *domain, unsigned long iova,
+		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped);
+	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
+			size_t size, struct iommu_iotlb_gather *iotlb_gather);
+	size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *iotlb_gather);
+
+	void (*flush_iotlb_all)(struct iommu_domain *domain);
+	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
+			       size_t size);
+	void (*iotlb_sync)(struct iommu_domain *domain,
+			   struct iommu_iotlb_gather *iotlb_gather);
+
+	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
+
+	int (*enable_nesting)(struct iommu_domain *domain);
+	int (*set_pgtable_quirks)(struct iommu_domain *domain,
+				  unsigned long quirks);
+
+	void (*release)(struct iommu_domain *domain);
+};
+
+static inline void iommu_domain_set_ops(struct iommu_domain *domain,
+					const struct domain_ops *ops)
+{
+	domain->ops = ops;
+}
+
 /**
  * struct iommu_device - IOMMU core representation of one IOMMU hardware
  *			 instance
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 461f1844ed1f..1d25dc2e0de9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -74,6 +74,7 @@ LIST_HEAD(acpihid_map);
  * if iommu=pt passed on kernel cmd line.
  */
 const struct iommu_ops amd_iommu_ops;
+static const struct domain_ops amd_domain_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -1977,6 +1978,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = ~0ULL;
 	domain->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&domain->domain, &amd_domain_ops);
 
 	return &domain->domain;
 }
@@ -2269,13 +2271,6 @@ static int amd_iommu_def_domain_type(struct device *dev)
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
-	.domain_free  = amd_iommu_domain_free,
-	.attach_dev = amd_iommu_attach_device,
-	.detach_dev = amd_iommu_detach_device,
-	.map = amd_iommu_map,
-	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-	.unmap = amd_iommu_unmap,
-	.iova_to_phys = amd_iommu_iova_to_phys,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
 	.probe_finalize = amd_iommu_probe_finalize,
@@ -2284,9 +2279,19 @@ const struct iommu_ops amd_iommu_ops = {
 	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.def_domain_type = amd_iommu_def_domain_type,
+};
+
+static const struct domain_ops amd_domain_ops = {
+	.attach_dev = amd_iommu_attach_device,
+	.detach_dev = amd_iommu_detach_device,
+	.map = amd_iommu_map,
+	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
+	.unmap = amd_iommu_unmap,
+	.iova_to_phys = amd_iommu_iova_to_phys,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_sync = amd_iommu_iotlb_sync,
-	.def_domain_type = amd_iommu_def_domain_type,
+	.release = amd_iommu_domain_free,
 };
 
 /*****************************************************************************
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 565ef5598811..bf40970ec977 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -185,6 +185,7 @@ struct apple_dart_master_cfg {
 
 static struct platform_driver apple_dart_driver;
 static const struct iommu_ops apple_dart_iommu_ops;
+static const struct domain_ops apple_dart_domain_ops;
 
 static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 {
@@ -589,6 +590,8 @@ static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
 	if (type == IOMMU_DOMAIN_IDENTITY || type == IOMMU_DOMAIN_BLOCKED)
 		dart_domain->finalized = true;
 
+	iommu_domain_set_ops(&dart_domain->domain, &apple_dart_domain_ops);
+
 	return &dart_domain->domain;
 }
 
@@ -765,15 +768,6 @@ static void apple_dart_get_resv_regions(struct device *dev,
 
 static const struct iommu_ops apple_dart_iommu_ops = {
 	.domain_alloc = apple_dart_domain_alloc,
-	.domain_free = apple_dart_domain_free,
-	.attach_dev = apple_dart_attach_dev,
-	.detach_dev = apple_dart_detach_dev,
-	.map_pages = apple_dart_map_pages,
-	.unmap_pages = apple_dart_unmap_pages,
-	.flush_iotlb_all = apple_dart_flush_iotlb_all,
-	.iotlb_sync = apple_dart_iotlb_sync,
-	.iotlb_sync_map = apple_dart_iotlb_sync_map,
-	.iova_to_phys = apple_dart_iova_to_phys,
 	.probe_device = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
 	.device_group = apple_dart_device_group,
@@ -784,6 +778,18 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
 };
 
+static const struct domain_ops apple_dart_domain_ops = {
+	.attach_dev = apple_dart_attach_dev,
+	.detach_dev = apple_dart_detach_dev,
+	.map_pages = apple_dart_map_pages,
+	.unmap_pages = apple_dart_unmap_pages,
+	.flush_iotlb_all = apple_dart_flush_iotlb_all,
+	.iotlb_sync = apple_dart_iotlb_sync,
+	.iotlb_sync_map = apple_dart_iotlb_sync_map,
+	.iova_to_phys = apple_dart_iova_to_phys,
+	.release = apple_dart_domain_free,
+};
+
 static irqreturn_t apple_dart_irq(int irq, void *dev)
 {
 	struct apple_dart *dart = dev;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6dc6d8b6b368..4461f7d35625 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1981,6 +1981,8 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 	.tlb_add_page	= arm_smmu_tlb_inv_page_nosync,
 };
 
+static const struct domain_ops arm_smmu_domain_ops;
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)
 {
@@ -2017,6 +2019,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
+	iommu_domain_set_ops(&smmu_domain->domain, &arm_smmu_domain_ops);
 
 	return &smmu_domain->domain;
 }
@@ -2841,17 +2844,9 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
-	.domain_free		= arm_smmu_domain_free,
-	.attach_dev		= arm_smmu_attach_dev,
-	.map_pages		= arm_smmu_map_pages,
-	.unmap_pages		= arm_smmu_unmap_pages,
-	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
-	.iotlb_sync		= arm_smmu_iotlb_sync,
-	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.enable_nesting		= arm_smmu_enable_nesting,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
@@ -2867,6 +2862,17 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 };
 
+static const struct domain_ops arm_smmu_domain_ops = {
+	.attach_dev		= arm_smmu_attach_dev,
+	.map_pages		= arm_smmu_map_pages,
+	.unmap_pages		= arm_smmu_unmap_pages,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
+	.iova_to_phys		= arm_smmu_iova_to_phys,
+	.enable_nesting		= arm_smmu_enable_nesting,
+	.release		= arm_smmu_domain_free,
+};
+
 /* Probing and initialisation functions */
 static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   struct arm_smmu_queue *q,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4bc75c4ce402..b59c7a0df781 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -91,6 +91,7 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 
 static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
+static const struct domain_ops arm_smmu_domain_ops;
 
 #ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
 static int arm_smmu_bus_init(struct iommu_ops *ops);
@@ -888,6 +889,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
+	iommu_domain_set_ops(&smmu_domain->domain, &arm_smmu_domain_ops);
 
 	return &smmu_domain->domain;
 }
@@ -1583,19 +1585,10 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
-	.domain_free		= arm_smmu_domain_free,
-	.attach_dev		= arm_smmu_attach_dev,
-	.map_pages		= arm_smmu_map_pages,
-	.unmap_pages		= arm_smmu_unmap_pages,
-	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
-	.iotlb_sync		= arm_smmu_iotlb_sync,
-	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.enable_nesting		= arm_smmu_enable_nesting,
-	.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
@@ -1604,6 +1597,18 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 };
 
+static const struct domain_ops arm_smmu_domain_ops = {
+	.attach_dev		= arm_smmu_attach_dev,
+	.map_pages		= arm_smmu_map_pages,
+	.unmap_pages		= arm_smmu_unmap_pages,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
+	.iova_to_phys		= arm_smmu_iova_to_phys,
+	.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
+	.enable_nesting		= arm_smmu_enable_nesting,
+	.release		= arm_smmu_domain_free,
+};
+
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int i;
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b91874cb6cf3..4469e4758dbb 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -78,6 +78,7 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
 }
 
 static const struct iommu_ops qcom_iommu_ops;
+static const struct domain_ops qcom_domain_ops;
 
 static struct qcom_iommu_dev * to_iommu(struct device *dev)
 {
@@ -336,6 +337,7 @@ static struct iommu_domain *qcom_iommu_domain_alloc(unsigned type)
 
 	mutex_init(&qcom_domain->init_mutex);
 	spin_lock_init(&qcom_domain->pgtbl_lock);
+	iommu_domain_set_ops(&qcom_domain->domain, &qcom_domain_ops);
 
 	return &qcom_domain->domain;
 }
@@ -590,7 +592,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 static const struct iommu_ops qcom_iommu_ops = {
 	.capable	= qcom_iommu_capable,
 	.domain_alloc	= qcom_iommu_domain_alloc,
-	.domain_free	= qcom_iommu_domain_free,
+	.probe_device	= qcom_iommu_probe_device,
+	.release_device	= qcom_iommu_release_device,
+	.device_group	= generic_device_group,
+	.of_xlate	= qcom_iommu_of_xlate,
+	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
+};
+
+static const struct domain_ops qcom_domain_ops = {
 	.attach_dev	= qcom_iommu_attach_dev,
 	.detach_dev	= qcom_iommu_detach_dev,
 	.map		= qcom_iommu_map,
@@ -598,11 +607,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 	.iotlb_sync	= qcom_iommu_iotlb_sync,
 	.iova_to_phys	= qcom_iommu_iova_to_phys,
-	.probe_device	= qcom_iommu_probe_device,
-	.release_device	= qcom_iommu_release_device,
-	.device_group	= generic_device_group,
-	.of_xlate	= qcom_iommu_of_xlate,
-	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
+	.release	= qcom_iommu_domain_free,
 };
 
 static int qcom_iommu_sec_ptbl_init(struct device *dev)
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 939ffa768986..b69e8b52f3c4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -563,6 +563,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 }
 
 static const struct iommu_ops exynos_iommu_ops;
+static const struct domain_ops exynos_domain_ops;
 
 static int exynos_sysmmu_probe(struct platform_device *pdev)
 {
@@ -767,6 +768,7 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = ~0UL;
 	domain->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&domain->domain, &exynos_domain_ops);
 
 	return &domain->domain;
 
@@ -1309,12 +1311,6 @@ static int exynos_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
-	.domain_free = exynos_iommu_domain_free,
-	.attach_dev = exynos_iommu_attach_device,
-	.detach_dev = exynos_iommu_detach_device,
-	.map = exynos_iommu_map,
-	.unmap = exynos_iommu_unmap,
-	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.device_group = generic_device_group,
 	.probe_device = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
@@ -1322,6 +1318,15 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.of_xlate = exynos_iommu_of_xlate,
 };
 
+static const struct domain_ops exynos_domain_ops = {
+	.attach_dev = exynos_iommu_attach_device,
+	.detach_dev = exynos_iommu_detach_device,
+	.map = exynos_iommu_map,
+	.unmap = exynos_iommu_unmap,
+	.iova_to_phys = exynos_iommu_iova_to_phys,
+	.release = exynos_iommu_domain_free,
+};
+
 static int __init exynos_iommu_init(void)
 {
 	struct device_node *np;
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index a47f47307109..0caae87d1471 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -20,6 +20,7 @@ static DEFINE_SPINLOCK(iommu_lock);
 static struct kmem_cache *fsl_pamu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 static DEFINE_SPINLOCK(device_domain_lock);
+static const struct domain_ops fsl_pamu_domain_ops;
 
 struct iommu_device pamu_iommu;	/* IOMMU core code handle */
 
@@ -210,6 +211,7 @@ static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
 	dma_domain->iommu_domain. geometry.aperture_start = 0;
 	dma_domain->iommu_domain.geometry.aperture_end = (1ULL << 36) - 1;
 	dma_domain->iommu_domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&dma_domain->iommu_domain, &fsl_pamu_domain_ops);
 
 	return &dma_domain->iommu_domain;
 }
@@ -453,15 +455,18 @@ static void fsl_pamu_release_device(struct device *dev)
 static const struct iommu_ops fsl_pamu_ops = {
 	.capable	= fsl_pamu_capable,
 	.domain_alloc	= fsl_pamu_domain_alloc,
-	.domain_free    = fsl_pamu_domain_free,
-	.attach_dev	= fsl_pamu_attach_device,
-	.detach_dev	= fsl_pamu_detach_device,
-	.iova_to_phys	= fsl_pamu_iova_to_phys,
 	.probe_device	= fsl_pamu_probe_device,
 	.release_device	= fsl_pamu_release_device,
 	.device_group   = fsl_pamu_device_group,
 };
 
+static const struct domain_ops fsl_pamu_domain_ops = {
+	.attach_dev	= fsl_pamu_attach_device,
+	.detach_dev	= fsl_pamu_detach_device,
+	.iova_to_phys	= fsl_pamu_iova_to_phys,
+	.release	= fsl_pamu_domain_free,
+};
+
 int __init pamu_domain_init(void)
 {
 	int ret = 0;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2b5f4e57a8bb..1a5ea7c23e4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -385,6 +385,7 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 }
 
 const struct iommu_ops intel_iommu_ops;
+static const struct domain_ops intel_domain_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
@@ -2772,6 +2773,8 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 	}
 
+	iommu_domain_set_ops(&si_domain->domain, &intel_domain_ops);
+
 	if (hw)
 		return 0;
 
@@ -4586,6 +4589,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.aperture_end   =
 				__DOMAIN_MAX_ADDR(dmar_domain->gaw);
 		domain->geometry.force_aperture = true;
+		iommu_domain_set_ops(domain, &intel_domain_ops);
 
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
@@ -5093,15 +5097,6 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
-	.domain_free		= intel_iommu_domain_free,
-	.attach_dev		= intel_iommu_attach_device,
-	.detach_dev		= intel_iommu_detach_device,
-	.map_pages		= intel_iommu_map_pages,
-	.unmap_pages		= intel_iommu_unmap_pages,
-	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-	.flush_iotlb_all        = intel_flush_iotlb_all,
-	.iotlb_sync		= intel_iommu_tlb_sync,
-	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
@@ -5121,6 +5116,18 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 };
 
+static const struct domain_ops intel_domain_ops = {
+	.attach_dev		= intel_iommu_attach_device,
+	.detach_dev		= intel_iommu_detach_device,
+	.map_pages		= intel_iommu_map_pages,
+	.unmap_pages		= intel_iommu_unmap_pages,
+	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
+	.flush_iotlb_all        = intel_flush_iotlb_all,
+	.iotlb_sync		= intel_iommu_tlb_sync,
+	.iova_to_phys		= intel_iommu_iova_to_phys,
+	.release		= intel_iommu_domain_free,
+};
+
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
 	if (risky_device(dev))
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6631e2ea44df..b44e5ab12b8a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1954,7 +1954,6 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	if (!domain)
 		return NULL;
 
-	domain->ops  = bus->iommu_ops;
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
@@ -1975,7 +1974,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	iommu_put_dma_cookie(domain);
-	domain->ops->domain_free(domain);
+	domain->ops->release(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
@@ -2248,7 +2247,7 @@ static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			     phys_addr_t paddr, size_t size, int prot,
 			     gfp_t gfp, size_t *mapped)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct domain_ops *ops = domain->ops;
 	size_t pgsize, count;
 	int ret;
 
@@ -2271,7 +2270,7 @@ static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct domain_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 	size_t orig_size = size;
@@ -2331,7 +2330,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
 		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct domain_ops *ops = domain->ops;
 	int ret;
 
 	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
@@ -2360,7 +2359,7 @@ static size_t __iommu_unmap_pages(struct iommu_domain *domain,
 				  unsigned long iova, size_t size,
 				  struct iommu_iotlb_gather *iotlb_gather)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct domain_ops *ops = domain->ops;
 	size_t pgsize, count;
 
 	pgsize = iommu_pgsize(domain, iova, iova, size, &count);
@@ -2373,7 +2372,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 			    unsigned long iova, size_t size,
 			    struct iommu_iotlb_gather *iotlb_gather)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct domain_ops *ops = domain->ops;
 	size_t unmapped_page, unmapped = 0;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
@@ -2449,7 +2448,7 @@ static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		struct scatterlist *sg, unsigned int nents, int prot,
 		gfp_t gfp)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct domain_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
 	unsigned int i = 0;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ca752bdc710f..6b92130181c3 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -566,6 +566,7 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 /* -----------------------------------------------------------------------------
  * IOMMU Operations
  */
+static const struct domain_ops ipmmu_domain_ops;
 
 static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 {
@@ -579,6 +580,7 @@ static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&domain->mutex);
+	iommu_domain_set_ops(&domain->io_domain, &ipmmu_domain_ops);
 
 	return &domain->io_domain;
 }
@@ -868,14 +870,6 @@ static struct iommu_group *ipmmu_find_group(struct device *dev)
 
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
-	.domain_free = ipmmu_domain_free,
-	.attach_dev = ipmmu_attach_device,
-	.detach_dev = ipmmu_detach_device,
-	.map = ipmmu_map,
-	.unmap = ipmmu_unmap,
-	.flush_iotlb_all = ipmmu_flush_iotlb_all,
-	.iotlb_sync = ipmmu_iotlb_sync,
-	.iova_to_phys = ipmmu_iova_to_phys,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
@@ -885,6 +879,17 @@ static const struct iommu_ops ipmmu_ops = {
 	.of_xlate = ipmmu_of_xlate,
 };
 
+static const struct domain_ops ipmmu_domain_ops = {
+	.attach_dev = ipmmu_attach_device,
+	.detach_dev = ipmmu_detach_device,
+	.map = ipmmu_map,
+	.unmap = ipmmu_unmap,
+	.flush_iotlb_all = ipmmu_flush_iotlb_all,
+	.iotlb_sync = ipmmu_iotlb_sync,
+	.iova_to_phys = ipmmu_iova_to_phys,
+	.release = ipmmu_domain_free,
+};
+
 /* -----------------------------------------------------------------------------
  * Probe/remove and init
  */
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..757e46c84044 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -36,6 +36,7 @@ __asm__ __volatile__ (							\
 static DEFINE_SPINLOCK(msm_iommu_lock);
 static LIST_HEAD(qcom_iommu_devices);
 static struct iommu_ops msm_iommu_ops;
+static const struct domain_ops msm_domain_ops;
 
 struct msm_priv {
 	struct list_head list_attached;
@@ -318,6 +319,7 @@ static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
 	priv->domain.geometry.aperture_start = 0;
 	priv->domain.geometry.aperture_end   = (1ULL << 32) - 1;
 	priv->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&priv->domain, &msm_domain_ops);
 
 	return &priv->domain;
 
@@ -674,7 +676,14 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 static struct iommu_ops msm_iommu_ops = {
 	.capable = msm_iommu_capable,
 	.domain_alloc = msm_iommu_domain_alloc,
-	.domain_free = msm_iommu_domain_free,
+	.probe_device = msm_iommu_probe_device,
+	.release_device = msm_iommu_release_device,
+	.device_group = generic_device_group,
+	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
+	.of_xlate = qcom_iommu_of_xlate,
+};
+
+static const struct domain_ops msm_domain_ops = {
 	.attach_dev = msm_iommu_attach_dev,
 	.detach_dev = msm_iommu_detach_dev,
 	.map = msm_iommu_map,
@@ -688,11 +697,7 @@ static struct iommu_ops msm_iommu_ops = {
 	.iotlb_sync = NULL,
 	.iotlb_sync_map = msm_iommu_sync_map,
 	.iova_to_phys = msm_iommu_iova_to_phys,
-	.probe_device = msm_iommu_probe_device,
-	.release_device = msm_iommu_release_device,
-	.device_group = generic_device_group,
-	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
-	.of_xlate = qcom_iommu_of_xlate,
+	.release = msm_iommu_domain_free,
 };
 
 static int msm_iommu_probe(struct platform_device *pdev)
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..45c05899cfd9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -131,6 +131,7 @@ struct mtk_iommu_domain {
 };
 
 static const struct iommu_ops mtk_iommu_ops;
+static const struct domain_ops mtk_domain_ops;
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
 
@@ -440,6 +441,8 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (!dom)
 		return NULL;
 
+	iommu_domain_set_ops(&dom->domain, &mtk_domain_ops);
+
 	return &dom->domain;
 }
 
@@ -658,15 +661,6 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 
 static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
-	.domain_free	= mtk_iommu_domain_free,
-	.attach_dev	= mtk_iommu_attach_device,
-	.detach_dev	= mtk_iommu_detach_device,
-	.map		= mtk_iommu_map,
-	.unmap		= mtk_iommu_unmap,
-	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
-	.iotlb_sync	= mtk_iommu_iotlb_sync,
-	.iotlb_sync_map	= mtk_iommu_sync_map,
-	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.probe_device	= mtk_iommu_probe_device,
 	.release_device	= mtk_iommu_release_device,
 	.device_group	= mtk_iommu_device_group,
@@ -677,6 +671,18 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct domain_ops mtk_domain_ops = {
+	.attach_dev	= mtk_iommu_attach_device,
+	.detach_dev	= mtk_iommu_detach_device,
+	.map		= mtk_iommu_map,
+	.unmap		= mtk_iommu_unmap,
+	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
+	.iotlb_sync	= mtk_iommu_iotlb_sync,
+	.iotlb_sync_map	= mtk_iommu_sync_map,
+	.iova_to_phys	= mtk_iommu_iova_to_phys,
+	.release	= mtk_iommu_domain_free,
+};
+
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 {
 	u32 regval;
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index be22fcf988ce..10a9d6be42ff 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -87,6 +87,8 @@
  */
 #define M2701_IOMMU_PGT_SIZE			SZ_4M
 
+static const struct domain_ops mtk_domain_ops;
+
 struct mtk_iommu_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 	struct iommu_domain		domain;
@@ -246,6 +248,8 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (!dom)
 		return NULL;
 
+	iommu_domain_set_ops(&dom->domain, &mtk_domain_ops);
+
 	return &dom->domain;
 }
 
@@ -514,12 +518,6 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
-	.domain_free	= mtk_iommu_domain_free,
-	.attach_dev	= mtk_iommu_attach_device,
-	.detach_dev	= mtk_iommu_detach_device,
-	.map		= mtk_iommu_map,
-	.unmap		= mtk_iommu_unmap,
-	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.probe_device	= mtk_iommu_probe_device,
 	.probe_finalize = mtk_iommu_probe_finalize,
 	.release_device	= mtk_iommu_release_device,
@@ -529,6 +527,15 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner          = THIS_MODULE,
 };
 
+static const struct domain_ops mtk_domain_ops = {
+	.attach_dev	= mtk_iommu_attach_device,
+	.detach_dev	= mtk_iommu_detach_device,
+	.map		= mtk_iommu_map,
+	.unmap		= mtk_iommu_unmap,
+	.iova_to_phys	= mtk_iommu_iova_to_phys,
+	.release	= mtk_iommu_domain_free,
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..ecd9cb589a31 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -33,6 +33,7 @@
 #include "omap-iommu.h"
 
 static const struct iommu_ops omap_iommu_ops;
+static const struct domain_ops omap_domain_ops;
 
 #define to_iommu(dev)	((struct omap_iommu *)dev_get_drvdata(dev))
 
@@ -1582,6 +1583,7 @@ static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 	omap_domain->domain.geometry.aperture_start = 0;
 	omap_domain->domain.geometry.aperture_end   = (1ULL << 32) - 1;
 	omap_domain->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&omap_domain->domain, &omap_domain_ops);
 
 	return &omap_domain->domain;
 }
@@ -1734,16 +1736,19 @@ static struct iommu_group *omap_iommu_device_group(struct device *dev)
 
 static const struct iommu_ops omap_iommu_ops = {
 	.domain_alloc	= omap_iommu_domain_alloc,
-	.domain_free	= omap_iommu_domain_free,
+	.probe_device	= omap_iommu_probe_device,
+	.release_device	= omap_iommu_release_device,
+	.device_group	= omap_iommu_device_group,
+	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
+};
+
+static const struct domain_ops omap_domain_ops = {
 	.attach_dev	= omap_iommu_attach_dev,
 	.detach_dev	= omap_iommu_detach_dev,
 	.map		= omap_iommu_map,
 	.unmap		= omap_iommu_unmap,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
-	.probe_device	= omap_iommu_probe_device,
-	.release_device	= omap_iommu_release_device,
-	.device_group	= omap_iommu_device_group,
-	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
+	.release	= omap_iommu_domain_free,
 };
 
 static int __init omap_iommu_init(void)
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 7f23ad61c094..0261c044ded1 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -124,6 +124,7 @@ struct rk_iommudata {
 
 static struct device *dma_dev;
 static const struct rk_iommu_ops *rk_ops;
+static const struct domain_ops rk_domain_ops;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
@@ -1096,6 +1097,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	rk_domain->domain.geometry.aperture_start = 0;
 	rk_domain->domain.geometry.aperture_end   = DMA_BIT_MASK(32);
 	rk_domain->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&rk_domain->domain, &rk_domain_ops);
 
 	return &rk_domain->domain;
 
@@ -1187,19 +1189,22 @@ static int rk_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops rk_iommu_ops = {
 	.domain_alloc = rk_iommu_domain_alloc,
-	.domain_free = rk_iommu_domain_free,
-	.attach_dev = rk_iommu_attach_device,
-	.detach_dev = rk_iommu_detach_device,
-	.map = rk_iommu_map,
-	.unmap = rk_iommu_unmap,
 	.probe_device = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
-	.iova_to_phys = rk_iommu_iova_to_phys,
 	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 };
 
+static const struct domain_ops rk_domain_ops = {
+	.attach_dev = rk_iommu_attach_device,
+	.detach_dev = rk_iommu_detach_device,
+	.map = rk_iommu_map,
+	.unmap = rk_iommu_unmap,
+	.iova_to_phys = rk_iommu_iova_to_phys,
+	.release = rk_iommu_domain_free,
+};
+
 static int rk_iommu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 50860ebdd087..70011eedef7c 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -20,6 +20,7 @@
 #define S390_IOMMU_PGSIZES	(~0xFFFUL)
 
 static const struct iommu_ops s390_iommu_ops;
+static const struct domain_ops s390_domain_ops;
 
 struct s390_domain {
 	struct iommu_domain	domain;
@@ -71,6 +72,7 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 	spin_lock_init(&s390_domain->dma_table_lock);
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD(&s390_domain->devices);
+	iommu_domain_set_ops(&s390_domain->domain, &s390_domain_ops);
 
 	return &s390_domain->domain;
 }
@@ -363,16 +365,19 @@ void zpci_destroy_iommu(struct zpci_dev *zdev)
 static const struct iommu_ops s390_iommu_ops = {
 	.capable = s390_iommu_capable,
 	.domain_alloc = s390_domain_alloc,
-	.domain_free = s390_domain_free,
+	.probe_device = s390_iommu_probe_device,
+	.release_device = s390_iommu_release_device,
+	.device_group = generic_device_group,
+	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+};
+
+static const struct domain_ops s390_domain_ops = {
 	.attach_dev = s390_iommu_attach_device,
 	.detach_dev = s390_iommu_detach_device,
 	.map = s390_iommu_map,
 	.unmap = s390_iommu_unmap,
 	.iova_to_phys = s390_iommu_iova_to_phys,
-	.probe_device = s390_iommu_probe_device,
-	.release_device = s390_iommu_release_device,
-	.device_group = generic_device_group,
-	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.release = s390_domain_free,
 };
 
 static int __init s390_iommu_init(void)
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 27ac818b0354..9fee9eafbff8 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -81,6 +81,7 @@ struct sprd_iommu_domain {
 };
 
 static const struct iommu_ops sprd_iommu_ops;
+static const struct domain_ops sprd_domain_ops;
 
 static struct sprd_iommu_domain *to_sprd_domain(struct iommu_domain *dom)
 {
@@ -147,6 +148,7 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = SZ_256M - 1;
+	iommu_domain_set_ops(&dom->domain, &sprd_domain_ops);
 
 	return &dom->domain;
 }
@@ -416,7 +418,15 @@ static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
 static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc	= sprd_iommu_domain_alloc,
-	.domain_free	= sprd_iommu_domain_free,
+	.probe_device	= sprd_iommu_probe_device,
+	.release_device	= sprd_iommu_release_device,
+	.device_group	= sprd_iommu_device_group,
+	.of_xlate	= sprd_iommu_of_xlate,
+	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
+	.owner		= THIS_MODULE,
+};
+
+static const struct domain_ops sprd_domain_ops = {
 	.attach_dev	= sprd_iommu_attach_device,
 	.detach_dev	= sprd_iommu_detach_device,
 	.map		= sprd_iommu_map,
@@ -424,12 +434,7 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.iotlb_sync_map	= sprd_iommu_sync_map,
 	.iotlb_sync	= sprd_iommu_sync,
 	.iova_to_phys	= sprd_iommu_iova_to_phys,
-	.probe_device	= sprd_iommu_probe_device,
-	.release_device	= sprd_iommu_release_device,
-	.device_group	= sprd_iommu_device_group,
-	.of_xlate	= sprd_iommu_of_xlate,
-	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
-	.owner		= THIS_MODULE,
+	.release	= sprd_iommu_domain_free,
 };
 
 static const struct of_device_id sprd_iommu_of_match[] = {
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 92997021e188..7b5617695183 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -596,6 +596,8 @@ static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
 		sun50i_iova_get_page_offset(iova);
 }
 
+static const struct domain_ops sun50i_domain_ops;
+
 static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 {
 	struct sun50i_iommu_domain *sun50i_domain;
@@ -619,6 +621,7 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 	sun50i_domain->domain.geometry.aperture_start = 0;
 	sun50i_domain->domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	sun50i_domain->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&sun50i_domain->domain, &sun50i_domain_ops);
 
 	return &sun50i_domain->domain;
 
@@ -760,19 +763,22 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
-	.attach_dev	= sun50i_iommu_attach_device,
-	.detach_dev	= sun50i_iommu_detach_device,
 	.device_group	= sun50i_iommu_device_group,
 	.domain_alloc	= sun50i_iommu_domain_alloc,
-	.domain_free	= sun50i_iommu_domain_free,
+	.of_xlate	= sun50i_iommu_of_xlate,
+	.probe_device	= sun50i_iommu_probe_device,
+	.release_device	= sun50i_iommu_release_device,
+};
+
+static const struct domain_ops sun50i_domain_ops = {
+	.attach_dev	= sun50i_iommu_attach_device,
+	.detach_dev	= sun50i_iommu_detach_device,
 	.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 	.iotlb_sync	= sun50i_iommu_iotlb_sync,
 	.iova_to_phys	= sun50i_iommu_iova_to_phys,
 	.map		= sun50i_iommu_map,
-	.of_xlate	= sun50i_iommu_of_xlate,
-	.probe_device	= sun50i_iommu_probe_device,
-	.release_device	= sun50i_iommu_release_device,
 	.unmap		= sun50i_iommu_unmap,
+	.release	= sun50i_iommu_domain_free,
 };
 
 static void sun50i_iommu_report_fault(struct sun50i_iommu *iommu,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 6a358f92c7e5..cada6934c664 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -49,6 +49,7 @@ struct gart_device {
 static struct gart_device *gart_handle; /* unique for a system */
 
 static bool gart_debug;
+static const struct domain_ops gart_domain_ops;
 
 /*
  * Any interaction between any block on PPSB and a block on APB or AHB
@@ -153,6 +154,7 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 		domain->geometry.aperture_start = gart_handle->iovmm_base;
 		domain->geometry.aperture_end = gart_handle->iovmm_end - 1;
 		domain->geometry.force_aperture = true;
+		iommu_domain_set_ops(domain, &gart_domain_ops);
 	}
 
 	return domain;
@@ -278,19 +280,22 @@ static void gart_iommu_sync(struct iommu_domain *domain,
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
-	.domain_free	= gart_iommu_domain_free,
-	.attach_dev	= gart_iommu_attach_dev,
-	.detach_dev	= gart_iommu_detach_dev,
 	.probe_device	= gart_iommu_probe_device,
 	.release_device	= gart_iommu_release_device,
 	.device_group	= generic_device_group,
+	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
+};
+
+static const struct domain_ops gart_domain_ops = {
+	.attach_dev	= gart_iommu_attach_dev,
+	.detach_dev	= gart_iommu_detach_dev,
 	.map		= gart_iommu_map,
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
-	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
-	.of_xlate	= gart_iommu_of_xlate,
 	.iotlb_sync_map	= gart_iommu_sync_map,
 	.iotlb_sync	= gart_iommu_sync,
+	.release	= gart_iommu_domain_free,
 };
 
 int tegra_gart_suspend(struct gart_device *gart)
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e900e3c46903..e9ea0454ba9d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -62,6 +62,8 @@ struct tegra_smmu_as {
 	u32 attr;
 };
 
+static const struct domain_ops tegra_smmu_domain_ops;
+
 static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
 {
 	return container_of(dom, struct tegra_smmu_as, domain);
@@ -317,6 +319,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
 	as->domain.geometry.force_aperture = true;
+	iommu_domain_set_ops(&as->domain, &tegra_smmu_domain_ops);
 
 	return &as->domain;
 }
@@ -969,17 +972,20 @@ static int tegra_smmu_of_xlate(struct device *dev,
 static const struct iommu_ops tegra_smmu_ops = {
 	.capable = tegra_smmu_capable,
 	.domain_alloc = tegra_smmu_domain_alloc,
-	.domain_free = tegra_smmu_domain_free,
-	.attach_dev = tegra_smmu_attach_dev,
-	.detach_dev = tegra_smmu_detach_dev,
 	.probe_device = tegra_smmu_probe_device,
 	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
+	.of_xlate = tegra_smmu_of_xlate,
+	.pgsize_bitmap = SZ_4K,
+};
+
+static const struct domain_ops tegra_smmu_domain_ops = {
+	.attach_dev = tegra_smmu_attach_dev,
+	.detach_dev = tegra_smmu_detach_dev,
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
-	.of_xlate = tegra_smmu_of_xlate,
-	.pgsize_bitmap = SZ_4K,
+	.release = tegra_smmu_domain_free,
 };
 
 static void tegra_smmu_ahb_enable(void)
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f2aa34f57454..538409592c6a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -98,6 +98,8 @@ struct viommu_event {
 	};
 };
 
+static const struct domain_ops viommu_domain_ops;
+
 #define to_viommu_domain(domain)	\
 	container_of(domain, struct viommu_domain, domain)
 
@@ -652,6 +654,7 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	mutex_init(&vdomain->mutex);
 	spin_lock_init(&vdomain->mappings_lock);
 	vdomain->mappings = RB_ROOT_CACHED;
+	iommu_domain_set_ops(&vdomain->domain, &viommu_domain_ops);
 
 	return &vdomain->domain;
 }
@@ -1008,12 +1011,6 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
 static struct iommu_ops viommu_ops = {
 	.domain_alloc		= viommu_domain_alloc,
-	.domain_free		= viommu_domain_free,
-	.attach_dev		= viommu_attach_dev,
-	.map			= viommu_map,
-	.unmap			= viommu_unmap,
-	.iova_to_phys		= viommu_iova_to_phys,
-	.iotlb_sync		= viommu_iotlb_sync,
 	.probe_device		= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
@@ -1024,6 +1021,15 @@ static struct iommu_ops viommu_ops = {
 	.owner			= THIS_MODULE,
 };
 
+static const struct domain_ops viommu_domain_ops = {
+	.attach_dev		= viommu_attach_dev,
+	.map			= viommu_map,
+	.unmap			= viommu_unmap,
+	.iova_to_phys		= viommu_iova_to_phys,
+	.iotlb_sync		= viommu_iotlb_sync,
+	.release		= viommu_domain_free,
+};
+
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
-- 
2.25.1

