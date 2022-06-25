Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58655AA38
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiFYM4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiFYM4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:56:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194F1836D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161799; x=1687697799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+eKVLki0k2+PcRtiticRVEegZCy1+dcpXflxu/S09o=;
  b=iQDEeE7r4JUDz/IC1XGuVchgmLeoxNX0P23srY2VHG6LuUh8wEgU6r16
   syEaIrM9iexU8iw0FNuhTA9CnBjoaijQDkzE79L0KzIP6mf7m7Fm9g5Tc
   tJf02Wr3cS5vB58pV6m+i7703sKSpE7dFpyS4P3abC6qBiMf+8VTy7j4q
   LjzBqoqg2yN8H3Jc52854UGgQa+wGt1HPtIBcytmCvxNP6XCcleYAllLz
   xY9zpORIH5poI2fqcojyUMEErCVBU2fLwu+geD3fduAIBJrfEzOmlrOYt
   67vhN/MYC1+W1Klx+Ro21h/StQepSLkrweuTBjm2KdlLo0jVW8MfNJfOv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278727971"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="278727971"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890367"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:36 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 3/6] iommu/vt-d: Refactor iommu information of each domain
Date:   Sat, 25 Jun 2022 20:52:01 +0800
Message-Id: <20220625125204.2199437-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DMA domain is attached to a device, it needs to allocate a domain
ID from its IOMMU. Currently, the domain ID information is stored in two
static arrays embedded in the domain structure. This can lead to memory
waste when the driver is running on a small platform.

This optimizes these static arrays by replacing them with an xarray and
consuming memory on demand.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  27 +++++---
 drivers/iommu/intel/iommu.c | 123 ++++++++++++++++++++----------------
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/svm.c   |   2 +-
 4 files changed, 90 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 56e0d8cd2102..56c3d1a9e155 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -21,6 +21,7 @@
 #include <linux/dmar.h>
 #include <linux/ioasid.h>
 #include <linux/bitfield.h>
+#include <linux/xarray.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -524,17 +525,15 @@ struct context_entry {
  */
 #define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
 
+struct iommu_domain_info {
+	struct intel_iommu *iommu;
+	unsigned int refcnt;
+	u16 did;
+};
+
 struct dmar_domain {
 	int	nid;			/* node id */
-
-	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
-					/* Refcount of devices per iommu */
-
-
-	u16		iommu_did[DMAR_UNITS_SUPPORTED];
-					/* Domain ids per IOMMU. Use u16 since
-					 * domain ids are 16 bit wide according
-					 * to VT-d spec, section 9.3 */
+	struct xarray iommu_array;	/* Attached IOMMU array */
 
 	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
@@ -640,6 +639,16 @@ static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
 	return container_of(dom, struct dmar_domain, domain);
 }
 
+/* Retrieve the domain ID which has allocated to the domain */
+static inline u16
+domain_id_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
+{
+	struct iommu_domain_info *info =
+			xa_load(&domain->iommu_array, iommu->seq_id);
+
+	return info->did;
+}
+
 /*
  * 0: readable
  * 1: writable
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 781e060352e6..78b26fef685e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -254,10 +254,6 @@ static inline void context_clear_entry(struct context_entry *context)
 static struct dmar_domain *si_domain;
 static int hw_pass_through = 1;
 
-#define for_each_domain_iommu(idx, domain)			\
-	for (idx = 0; idx < g_num_of_iommus; idx++)		\
-		if (domain->iommu_refcnt[idx])
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -453,16 +449,16 @@ static inline bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 
 static void domain_update_iommu_coherency(struct dmar_domain *domain)
 {
+	struct iommu_domain_info *info;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	bool found = false;
-	int i;
+	unsigned long i;
 
 	domain->iommu_coherency = true;
-
-	for_each_domain_iommu(i, domain) {
+	xa_for_each(&domain->iommu_array, i, info) {
 		found = true;
-		if (!iommu_paging_structure_coherency(g_iommus[i])) {
+		if (!iommu_paging_structure_coherency(info->iommu)) {
 			domain->iommu_coherency = false;
 			break;
 		}
@@ -1495,7 +1491,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	unsigned int aligned_pages = __roundup_pow_of_two(pages);
 	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
-	u16 did = domain->iommu_did[iommu->seq_id];
+	u16 did = domain_id_iommu(domain, iommu);
 
 	BUG_ON(pages == 0);
 
@@ -1565,11 +1561,12 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	int idx;
+	struct iommu_domain_info *info;
+	unsigned long idx;
 
-	for_each_domain_iommu(idx, dmar_domain) {
-		struct intel_iommu *iommu = g_iommus[idx];
-		u16 did = dmar_domain->iommu_did[iommu->seq_id];
+	xa_for_each(&dmar_domain->iommu_array, idx, info) {
+		struct intel_iommu *iommu = info->iommu;
+		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (domain_use_first_level(dmar_domain))
 			qi_flush_piotlb(iommu, did, PASID_RID2PASID, 0, -1, 0);
@@ -1745,6 +1742,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	spin_lock_init(&domain->lock);
+	xa_init(&domain->iommu_array);
 
 	return domain;
 }
@@ -1752,45 +1750,64 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 static int domain_attach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
+	struct iommu_domain_info *info, *curr;
 	unsigned long ndomains;
-	int num, ret = 0;
+	int num, ret = -ENOSPC;
 
-	spin_lock(&iommu->lock);
-	domain->iommu_refcnt[iommu->seq_id] += 1;
-	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
-		ndomains = cap_ndoms(iommu->cap);
-		num      = find_first_zero_bit(iommu->domain_ids, ndomains);
-
-		if (num >= ndomains) {
-			pr_err("%s: No free domain ids\n", iommu->name);
-			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			ret = -ENOSPC;
-			goto out_unlock;
-		}
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
 
-		set_bit(num, iommu->domain_ids);
-		domain->iommu_did[iommu->seq_id] = num;
-		domain->nid			 = iommu->node;
-		domain_update_iommu_cap(domain);
+	spin_lock(&iommu->lock);
+	curr = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (curr) {
+		curr->refcnt++;
+		kfree(info);
+		goto success;
 	}
 
-out_unlock:
+	ndomains = cap_ndoms(iommu->cap);
+	num = find_first_zero_bit(iommu->domain_ids, ndomains);
+	if (num >= ndomains) {
+		pr_err("%s: No free domain ids\n", iommu->name);
+		goto err_unlock;
+	}
+
+	set_bit(num, iommu->domain_ids);
+	info->refcnt	= 1;
+	info->did	= num;
+	info->iommu	= iommu;
+	domain->nid	= iommu->node;
+	ret = xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
+			      info, GFP_ATOMIC));
+	if (ret)
+		goto err_clear;
+	domain_update_iommu_cap(domain);
+
+success:
+	spin_unlock(&iommu->lock);
+	return 0;
+
+err_clear:
+	clear_bit(info->did, iommu->domain_ids);
+err_unlock:
 	spin_unlock(&iommu->lock);
+	kfree(info);
 	return ret;
 }
 
 static void domain_detach_iommu(struct dmar_domain *domain,
 				struct intel_iommu *iommu)
 {
-	int num;
+	struct iommu_domain_info *info;
 
 	spin_lock(&iommu->lock);
-	domain->iommu_refcnt[iommu->seq_id] -= 1;
-	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
-		num = domain->iommu_did[iommu->seq_id];
-		clear_bit(num, iommu->domain_ids);
+	info = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (--info->refcnt == 0) {
+		clear_bit(info->did, iommu->domain_ids);
+		xa_erase(&domain->iommu_array, iommu->seq_id);
 		domain_update_iommu_cap(domain);
-		domain->iommu_did[iommu->seq_id] = 0;
+		kfree(info);
 	}
 	spin_unlock(&iommu->lock);
 }
@@ -1880,7 +1897,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 {
 	struct device_domain_info *info =
 			iommu_support_dev_iotlb(domain, iommu, bus, devfn);
-	u16 did = domain->iommu_did[iommu->seq_id];
+	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct context_entry *context;
 	int ret;
@@ -2130,8 +2147,9 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				 unsigned long end_pfn, int level)
 {
 	unsigned long lvl_pages = lvl_to_nr_pages(level);
+	struct iommu_domain_info *info;
 	struct dma_pte *pte = NULL;
-	int i;
+	unsigned long i;
 
 	while (start_pfn <= end_pfn) {
 		if (!pte)
@@ -2142,8 +2160,8 @@ static void switch_to_super_page(struct dmar_domain *domain,
 					       start_pfn + lvl_pages - 1,
 					       level + 1);
 
-			for_each_domain_iommu(i, domain)
-				iommu_flush_iotlb_psi(g_iommus[i], domain,
+			xa_for_each(&domain->iommu_array, i, info)
+				iommu_flush_iotlb_psi(info->iommu, domain,
 						      start_pfn, lvl_pages,
 						      0, 0);
 		}
@@ -2273,7 +2291,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		if (hw_pass_through && domain_type_is_si(info->domain))
 			did_old = FLPT_DEFAULT_DID;
 		else
-			did_old = info->domain->iommu_did[iommu->seq_id];
+			did_old = domain_id_iommu(info->domain, iommu);
 	} else {
 		did_old = context_domain_id(context);
 	}
@@ -2331,7 +2349,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 		flags |= PASID_FLAG_PAGE_SNOOP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
-					     domain->iommu_did[iommu->seq_id],
+					     domain_id_iommu(domain, iommu),
 					     flags);
 }
 
@@ -4369,15 +4387,16 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long iova_pfn = IOVA_PFN(gather->start);
 	size_t size = gather->end - gather->start;
+	struct iommu_domain_info *info;
 	unsigned long start_pfn;
 	unsigned long nrpages;
-	int iommu_id;
+	unsigned long i;
 
 	nrpages = aligned_nrpages(gather->start, size);
 	start_pfn = mm_to_dma_pfn(iova_pfn);
 
-	for_each_domain_iommu(iommu_id, dmar_domain)
-		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
+	xa_for_each(&dmar_domain->iommu_array, i, info)
+		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
 				      start_pfn, nrpages,
 				      list_empty(&gather->freelist), 0);
 
@@ -4622,7 +4641,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 		context[0].lo = ctx_lo;
 		wmb();
 		iommu->flush.flush_context(iommu,
-					   domain->iommu_did[iommu->seq_id],
+					   domain_id_iommu(domain, iommu),
 					   PCI_DEVID(info->bus, info->devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
@@ -4759,13 +4778,11 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long pages = aligned_nrpages(iova, size);
 	unsigned long pfn = iova >> VTD_PAGE_SHIFT;
-	struct intel_iommu *iommu;
-	int iommu_id;
+	struct iommu_domain_info *info;
+	unsigned long i;
 
-	for_each_domain_iommu(iommu_id, dmar_domain) {
-		iommu = g_iommus[iommu_id];
-		__mapping_notify_one(iommu, dmar_domain, pfn, pages);
-	}
+	xa_for_each(&dmar_domain->iommu_array, i, info)
+		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 }
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c30de2339de5..006026dc18d4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -626,7 +626,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	}
 
 	pgd_val = virt_to_phys(pgd);
-	did = domain->iommu_did[iommu->seq_id];
+	did = domain_id_iommu(domain, iommu);
 
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 64072e628bbd..8bcfb93dda56 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -541,7 +541,7 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 	domain = info->domain;
 	pdev = to_pci_dev(dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
-	did = domain->iommu_did[iommu->seq_id];
+	did = domain_id_iommu(domain, iommu);
 	qdep = pci_ats_queue_depth(pdev);
 
 	/*
-- 
2.25.1

