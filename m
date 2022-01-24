Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5749792C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiAXHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:12:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:53043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241687AbiAXHMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643008359; x=1674544359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvhQT86YAV498NgzLFxRM7beIxkVvuEtKKkuyU2Pf/M=;
  b=lfh+2/4ElMZodE6mAuFAWyXQf2H5nFVm7nrfgi32GND83QyJWZzH3RpK
   OJzFSEkHaXnALk+dXqyyCPNnurssUb/Udd5NNG2FddRHb798HtoDVPxNS
   j0lT6rzmPwza0W/pUQiL9jIUnDvHEngwKaRGJWE/wONuIgA2vhlGyFJE5
   pENE9FTjQsM1X93XB4gdCmeFYpJW6u2dW8tO1LB8HfUq4tW9IBCUrqOij
   d3Gd84PJYDU1evmZznfcTPYlaNABw5G55uDXpc/VDIGhbi2TZpvs6Kw0t
   w0Chc8Ohljw9tDkcQyDF1IyWjATMyF12yHOVmVUGVb7P4ZOMb5RZAq1cS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244814222"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244814222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 23:12:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627387783"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:34 -0800
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
Subject: [PATCH 3/7] iommu/vt-d: Remove aux-domain related callbacks
Date:   Mon, 24 Jan 2022 15:10:58 +0800
Message-Id: <20220124071103.2097118-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aux-domain related callbacks are not called in the tree. Remove them
to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h   |  17 --
 drivers/iommu/intel/debugfs.c |   3 +-
 drivers/iommu/intel/iommu.c   | 309 +---------------------------------
 3 files changed, 3 insertions(+), 326 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index beaacb589abd..5cfda90b2cca 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -542,7 +542,6 @@ struct dmar_domain {
 	u8 iommu_snooping: 1;		/* indicate snooping control feature */
 
 	struct list_head devices;	/* all devices' list */
-	struct list_head subdevices;	/* all subdevices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -557,11 +556,6 @@ struct dmar_domain {
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
 	u64		max_addr;	/* maximum mapped address */
 
-	u32		default_pasid;	/*
-					 * The default pasid used for non-SVM
-					 * traffic on mediated devices.
-					 */
-
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
@@ -614,21 +608,11 @@ struct intel_iommu {
 	void *perf_statistic;
 };
 
-/* Per subdevice private data */
-struct subdev_domain_info {
-	struct list_head link_phys;	/* link to phys device siblings */
-	struct list_head link_domain;	/* link to domain siblings */
-	struct device *pdev;		/* physical device derived from */
-	struct dmar_domain *domain;	/* aux-domain */
-	int users;			/* user count */
-};
-
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
 	struct list_head global; /* link to global list */
 	struct list_head table;	/* link to pasid table */
-	struct list_head subdevices; /* subdevices sibling */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
@@ -639,7 +623,6 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
-	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 62e23ff3c987..db7a0ca73626 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -351,8 +351,7 @@ static int show_device_domain_translation(struct device *dev, void *data)
 	if (!domain)
 		return 0;
 
-	seq_printf(m, "Device %s with pasid %d @0x%llx\n",
-		   dev_name(dev), domain->default_pasid,
+	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
 		   (u64)virt_to_phys(domain->pgd));
 	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4f9d95067c8f..2b5f4e57a8bb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1573,18 +1573,6 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 			break;
 		}
 
-	if (!has_iotlb_device) {
-		struct subdev_domain_info *sinfo;
-
-		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
-			info = get_domain_info(sinfo->pdev);
-			if (info && info->ats_enabled) {
-				has_iotlb_device = true;
-				break;
-			}
-		}
-	}
-
 	domain->has_iotlb_device = has_iotlb_device;
 }
 
@@ -1682,7 +1670,6 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 {
 	unsigned long flags;
 	struct device_domain_info *info;
-	struct subdev_domain_info *sinfo;
 
 	if (!domain->has_iotlb_device)
 		return;
@@ -1691,27 +1678,9 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
 
-	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
-		info = get_domain_info(sinfo->pdev);
-		__iommu_flush_dev_iotlb(info, addr, mask);
-	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static void domain_flush_piotlb(struct intel_iommu *iommu,
-				struct dmar_domain *domain,
-				u64 addr, unsigned long npages, bool ih)
-{
-	u16 did = domain->iommu_did[iommu->seq_id];
-
-	if (domain->default_pasid)
-		qi_flush_piotlb(iommu, did, domain->default_pasid,
-				addr, npages, ih);
-
-	if (!list_empty(&domain->devices))
-		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
-}
-
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1727,7 +1696,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain_use_first_level(domain)) {
-		domain_flush_piotlb(iommu, domain, addr, pages, ih);
+		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
 	} else {
 		/*
 		 * Fallback to domain selective flush if no PSI support or
@@ -1776,7 +1745,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = dmar_domain->iommu_did[iommu->seq_id];
 
 		if (domain_use_first_level(dmar_domain))
-			domain_flush_piotlb(iommu, dmar_domain, 0, -1, 0);
+			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1983,7 +1952,6 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
-	INIT_LIST_HEAD(&domain->subdevices);
 
 	return domain;
 }
@@ -2676,8 +2644,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
-	info->auxd_enabled = 0;
-	INIT_LIST_HEAD(&info->subdevices);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -4637,183 +4603,6 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
-/*
- * Check whether a @domain could be attached to the @dev through the
- * aux-domain attach/detach APIs.
- */
-static inline bool
-is_aux_domain(struct device *dev, struct iommu_domain *domain)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-
-	return info && info->auxd_enabled &&
-			domain->type == IOMMU_DOMAIN_UNMANAGED;
-}
-
-static inline struct subdev_domain_info *
-lookup_subdev_info(struct dmar_domain *domain, struct device *dev)
-{
-	struct subdev_domain_info *sinfo;
-
-	if (!list_empty(&domain->subdevices)) {
-		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
-			if (sinfo->pdev == dev)
-				return sinfo;
-		}
-	}
-
-	return NULL;
-}
-
-static int auxiliary_link_device(struct dmar_domain *domain,
-				 struct device *dev)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
-
-	assert_spin_locked(&device_domain_lock);
-	if (WARN_ON(!info))
-		return -EINVAL;
-
-	if (!sinfo) {
-		sinfo = kzalloc(sizeof(*sinfo), GFP_ATOMIC);
-		if (!sinfo)
-			return -ENOMEM;
-		sinfo->domain = domain;
-		sinfo->pdev = dev;
-		list_add(&sinfo->link_phys, &info->subdevices);
-		list_add(&sinfo->link_domain, &domain->subdevices);
-	}
-
-	return ++sinfo->users;
-}
-
-static int auxiliary_unlink_device(struct dmar_domain *domain,
-				   struct device *dev)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
-	int ret;
-
-	assert_spin_locked(&device_domain_lock);
-	if (WARN_ON(!info || !sinfo || sinfo->users <= 0))
-		return -EINVAL;
-
-	ret = --sinfo->users;
-	if (!ret) {
-		list_del(&sinfo->link_phys);
-		list_del(&sinfo->link_domain);
-		kfree(sinfo);
-	}
-
-	return ret;
-}
-
-static int aux_domain_add_dev(struct dmar_domain *domain,
-			      struct device *dev)
-{
-	int ret;
-	unsigned long flags;
-	struct intel_iommu *iommu;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return -ENODEV;
-
-	if (domain->default_pasid <= 0) {
-		u32 pasid;
-
-		/* No private data needed for the default pasid */
-		pasid = ioasid_alloc(NULL, PASID_MIN,
-				     pci_max_pasids(to_pci_dev(dev)) - 1,
-				     NULL);
-		if (pasid == INVALID_IOASID) {
-			pr_err("Can't allocate default pasid\n");
-			return -ENODEV;
-		}
-		domain->default_pasid = pasid;
-	}
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = auxiliary_link_device(domain, dev);
-	if (ret <= 0)
-		goto link_failed;
-
-	/*
-	 * Subdevices from the same physical device can be attached to the
-	 * same domain. For such cases, only the first subdevice attachment
-	 * needs to go through the full steps in this function. So if ret >
-	 * 1, just goto out.
-	 */
-	if (ret > 1)
-		goto out;
-
-	/*
-	 * iommu->lock must be held to attach domain to iommu and setup the
-	 * pasid entry for second level translation.
-	 */
-	spin_lock(&iommu->lock);
-	ret = domain_attach_iommu(domain, iommu);
-	if (ret)
-		goto attach_failed;
-
-	/* Setup the PASID entry for mediated devices: */
-	if (domain_use_first_level(domain))
-		ret = domain_setup_first_level(iommu, domain, dev,
-					       domain->default_pasid);
-	else
-		ret = intel_pasid_setup_second_level(iommu, domain, dev,
-						     domain->default_pasid);
-	if (ret)
-		goto table_failed;
-
-	spin_unlock(&iommu->lock);
-out:
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-
-table_failed:
-	domain_detach_iommu(domain, iommu);
-attach_failed:
-	spin_unlock(&iommu->lock);
-	auxiliary_unlink_device(domain, dev);
-link_failed:
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
-
-	return ret;
-}
-
-static void aux_domain_remove_dev(struct dmar_domain *domain,
-				  struct device *dev)
-{
-	struct device_domain_info *info;
-	struct intel_iommu *iommu;
-	unsigned long flags;
-
-	if (!is_aux_domain(dev, &domain->domain))
-		return;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
-	iommu = info->iommu;
-
-	if (!auxiliary_unlink_device(domain, dev)) {
-		spin_lock(&iommu->lock);
-		intel_pasid_tear_down_entry(iommu, dev,
-					    domain->default_pasid, false);
-		domain_detach_iommu(domain, iommu);
-		spin_unlock(&iommu->lock);
-	}
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
-}
-
 static int prepare_domain_attach_device(struct iommu_domain *domain,
 					struct device *dev)
 {
@@ -4866,9 +4655,6 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		return -EPERM;
 	}
 
-	if (is_aux_domain(dev, domain))
-		return -EPERM;
-
 	/* normally dev is not mapped */
 	if (unlikely(domain_context_mapped(dev))) {
 		struct dmar_domain *old_domain;
@@ -4885,33 +4671,12 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
-static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
-					 struct device *dev)
-{
-	int ret;
-
-	if (!is_aux_domain(dev, domain))
-		return -EPERM;
-
-	ret = prepare_domain_attach_device(domain, dev);
-	if (ret)
-		return ret;
-
-	return aux_domain_add_dev(to_dmar_domain(domain), dev);
-}
-
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
 	dmar_remove_one_dev_info(dev);
 }
 
-static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
-					  struct device *dev)
-{
-	aux_domain_remove_dev(to_dmar_domain(domain), dev);
-}
-
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot, gfp_t gfp)
@@ -5205,46 +4970,6 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-static int intel_iommu_enable_auxd(struct device *dev)
-{
-	struct device_domain_info *info;
-	struct intel_iommu *iommu;
-	unsigned long flags;
-	int ret;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu || dmar_disabled)
-		return -EINVAL;
-
-	if (!sm_supported(iommu) || !pasid_supported(iommu))
-		return -EINVAL;
-
-	ret = intel_iommu_enable_pasid(iommu, dev);
-	if (ret)
-		return -ENODEV;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
-	info->auxd_enabled = 1;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-}
-
-static int intel_iommu_disable_auxd(struct device *dev)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
-	if (!WARN_ON(!info))
-		info->auxd_enabled = 0;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-}
-
 static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
@@ -5301,9 +5026,6 @@ static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
-	case IOMMU_DEV_FEAT_AUX:
-		return intel_iommu_enable_auxd(dev);
-
 	case IOMMU_DEV_FEAT_IOPF:
 		return intel_iommu_enable_iopf(dev);
 
@@ -5319,9 +5041,6 @@ static int
 intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
-	case IOMMU_DEV_FEAT_AUX:
-		return intel_iommu_disable_auxd(dev);
-
 	case IOMMU_DEV_FEAT_IOPF:
 		return 0;
 
@@ -5333,26 +5052,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 	}
 }
 
-static bool
-intel_iommu_dev_feat_enabled(struct device *dev, enum iommu_dev_features feat)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-
-	if (feat == IOMMU_DEV_FEAT_AUX)
-		return scalable_mode_support() && info && info->auxd_enabled;
-
-	return false;
-}
-
-static int
-intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
-{
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-
-	return dmar_domain->default_pasid > 0 ?
-			dmar_domain->default_pasid : -EINVAL;
-}
-
 static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 					   struct device *dev)
 {
@@ -5397,9 +5096,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_free		= intel_iommu_domain_free,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
-	.aux_attach_dev		= intel_iommu_aux_attach_device,
-	.aux_detach_dev		= intel_iommu_aux_detach_device,
-	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map_pages		= intel_iommu_map_pages,
 	.unmap_pages		= intel_iommu_unmap_pages,
 	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
@@ -5412,7 +5108,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
-- 
2.25.1

