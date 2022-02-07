Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615FC4AB56F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiBGG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357935AbiBGGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C89C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216276; x=1675752276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pi6PX6+nntRtFkpNMkBJo/Y18uMshhZleGI117X8MhA=;
  b=O5/o6UUZ1rQTZptl81zHq2TH+bHrXRIVenAWbqQegf8I3XMhalv1ZvQ5
   rGWSnPDJHxfiYreIII8qYHFKr1P6hy4yb1XMbzGcz3TU1CmC6MRYXhKRh
   CiqHdoLxw3KUt/0VJrbTDH7weFOiS5T7/MH5IxIPIs/Y6flqFsqcJhDLi
   unyXZ3M9D28jBPmyGkz3nSu6F+928GlTxbJZ2iWl/oxlQOboLZzzkyYev
   ezMPXjbqzAHg/ZibrtmsvnF0LF9e/yHWm+YuoZ14FKKQb/KBOs9XK5KkU
   mBQEXCW0TyMXID1Wiy5Hd6NoPJOFAH2VuCenxJc1bVWaYxJjS5CEFKBFz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171217"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171217"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020346"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:28 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 10/10] iommu/vt-d: Some cleanups in iommu.c
Date:   Mon,  7 Feb 2022 14:41:42 +0800
Message-Id: <20220207064142.1092846-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary include files. Move macros and inline helpers to the
header file. Remove commented out code. Remove spaces before jump lables.
No intentional functionality changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h | 217 +++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c | 283 ++----------------------------------
 2 files changed, 233 insertions(+), 267 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2091576b5989..9de98fafd958 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -55,6 +55,101 @@
 #define CONTEXT_TT_PASS_THROUGH 2
 #define CONTEXT_PASIDE		BIT_ULL(3)
 
+#define ROOT_SIZE		VTD_PAGE_SIZE
+#define CONTEXT_SIZE		VTD_PAGE_SIZE
+
+#define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
+#define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
+#define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
+
+#define IOAPIC_RANGE_START	(0xfee00000)
+#define IOAPIC_RANGE_END	(0xfeefffff)
+
+#define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
+
+#define MAX_AGAW_WIDTH 64
+#define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
+
+#define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << ((gaw) - VTD_PAGE_SHIFT)) - 1)
+#define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << (gaw)) - 1)
+
+/*
+ * We limit DOMAIN_MAX_PFN to fit in an unsigned long, and DOMAIN_MAX_ADDR
+ * to match. That way, we can use 'unsigned long' for PFNs with impunity.
+ */
+#define DOMAIN_MAX_PFN(gaw)	((unsigned long) min_t(uint64_t, \
+				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
+
+#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
+
+/* page table handling */
+#define LEVEL_STRIDE		(9)
+#define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
+
+static inline int agaw_to_level(int agaw)
+{
+	return agaw + 2;
+}
+
+static inline int agaw_to_width(int agaw)
+{
+	return min_t(int, 30 + agaw * LEVEL_STRIDE, MAX_AGAW_WIDTH);
+}
+
+static inline int width_to_agaw(int width)
+{
+	return DIV_ROUND_UP(width - 30, LEVEL_STRIDE);
+}
+
+static inline unsigned int level_to_offset_bits(int level)
+{
+	return (level - 1) * LEVEL_STRIDE;
+}
+
+static inline int pfn_level_offset(u64 pfn, int level)
+{
+	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
+}
+
+static inline u64 level_mask(int level)
+{
+	return -1ULL << level_to_offset_bits(level);
+}
+
+static inline u64 level_size(int level)
+{
+	return 1ULL << level_to_offset_bits(level);
+}
+
+static inline u64 align_to_level(u64 pfn, int level)
+{
+	return (pfn + level_size(level) - 1) & level_mask(level);
+}
+
+static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
+{
+	return 1UL << min_t(int, (lvl - 1) * LEVEL_STRIDE, MAX_AGAW_PFN_WIDTH);
+}
+
+/*
+ * VT-d pages must always be _smaller_ than MM pages. Otherwise things
+ * are never going to work.
+ */
+static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
+{
+	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
+}
+
+static inline unsigned long page_to_dma_pfn(struct page *pg)
+{
+	return mm_to_dma_pfn(page_to_pfn(pg));
+}
+
+static inline unsigned long virt_to_dma_pfn(void *p)
+{
+	return page_to_dma_pfn(virt_to_page(p));
+}
+
 /*
  * Intel IOMMU register specification per version 1.0 public spec.
  */
@@ -516,6 +611,110 @@ struct context_entry {
 	u64 hi;
 };
 
+static inline void context_clear_pasid_enable(struct context_entry *context)
+{
+	context->lo &= ~(1ULL << 11);
+}
+
+static inline bool context_pasid_enabled(struct context_entry *context)
+{
+	return !!(context->lo & (1ULL << 11));
+}
+
+static inline void context_set_copied(struct context_entry *context)
+{
+	context->hi |= (1ull << 3);
+}
+
+static inline bool context_copied(struct context_entry *context)
+{
+	return !!(context->hi & (1ULL << 3));
+}
+
+static inline bool __context_present(struct context_entry *context)
+{
+	return (context->lo & 1);
+}
+
+static inline void context_set_present(struct context_entry *context)
+{
+	context->lo |= 1;
+}
+
+static inline void context_set_fault_enable(struct context_entry *context)
+{
+	context->lo &= (((u64)-1) << 2) | 1;
+}
+
+static inline void context_set_translation_type(struct context_entry *context,
+						unsigned long value)
+{
+	context->lo &= (((u64)-1) << 4) | 3;
+	context->lo |= (value & 3) << 2;
+}
+
+static inline void context_set_address_root(struct context_entry *context,
+					    unsigned long value)
+{
+	context->lo &= ~VTD_PAGE_MASK;
+	context->lo |= value & VTD_PAGE_MASK;
+}
+
+static inline void context_set_address_width(struct context_entry *context,
+					     unsigned long value)
+{
+	context->hi |= value & 7;
+}
+
+static inline void context_set_domain_id(struct context_entry *context,
+					 unsigned long value)
+{
+	context->hi |= (value & ((1 << 16) - 1)) << 8;
+}
+
+static inline int context_domain_id(struct context_entry *c)
+{
+	return((c->hi >> 8) & 0xffff);
+}
+
+static inline void context_clear_entry(struct context_entry *context)
+{
+	context->lo = 0;
+	context->hi = 0;
+}
+
+/*
+ * Set the RID_PASID field of a scalable mode context entry. The
+ * IOMMU hardware will use the PASID value set in this field for
+ * DMA translations of DMA requests without PASID.
+ */
+static inline void
+context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
+{
+	context->hi |= pasid & ((1 << 20) - 1);
+}
+
+/*
+ * Set the DTE(Device-TLB Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_set_sm_dte(struct context_entry *context)
+{
+	context->lo |= (1 << 2);
+}
+
+/*
+ * Set the PRE(Page Request Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_set_sm_pre(struct context_entry *context)
+{
+	context->lo |= (1 << 4);
+}
+
+/* Convert value to context PASID directory size field coding. */
+#define context_pdts(pds)	(((pds) & 0x7) << 9)
+
 /*
  * When VT-d works in the scalable mode, it allows DMA translation to
  * happen through either first level or second level page table. This
@@ -640,6 +839,24 @@ static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
 	return container_of(dom, struct dmar_domain, domain);
 }
 
+static inline int domain_type_is_si(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
+}
+
+static inline bool domain_use_first_level(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL;
+}
+
+static inline int domain_pfn_supported(struct dmar_domain *domain,
+				       unsigned long pfn)
+{
+	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
+
+	return !(addr_width < BITS_PER_LONG && pfn >> addr_width);
+}
+
 /*
  * 0: readable
  * 1: writable
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9a9f21fd268a..a5244be69c44 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -13,24 +13,9 @@
 #define pr_fmt(fmt)     "DMAR: " fmt
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
-#include <linux/init.h>
-#include <linux/bitmap.h>
-#include <linux/debugfs.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
-#include <linux/dmar.h>
-#include <linux/dma-map-ops.h>
-#include <linux/mempool.h>
 #include <linux/memory.h>
-#include <linux/cpu.h>
-#include <linux/timer.h>
-#include <linux/io.h>
-#include <linux/iova.h>
-#include <linux/iommu.h>
 #include <linux/dma-iommu.h>
 #include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
@@ -38,114 +23,14 @@
 #include <linux/tboot.h>
 #include <linux/dmi.h>
 #include <linux/pci-ats.h>
-#include <linux/memblock.h>
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
-#include <linux/numa.h>
-#include <asm/irq_remapping.h>
-#include <asm/cacheflush.h>
-#include <asm/iommu.h>
 
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
 #include "pasid.h"
 #include "cap_audit.h"
 
-#define ROOT_SIZE		VTD_PAGE_SIZE
-#define CONTEXT_SIZE		VTD_PAGE_SIZE
-
-#define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
-#define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
-#define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
-#define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
-
-#define IOAPIC_RANGE_START	(0xfee00000)
-#define IOAPIC_RANGE_END	(0xfeefffff)
-#define IOVA_START_ADDR		(0x1000)
-
-#define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
-
-#define MAX_AGAW_WIDTH 64
-#define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
-
-#define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << ((gaw) - VTD_PAGE_SHIFT)) - 1)
-#define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << (gaw)) - 1)
-
-/* We limit DOMAIN_MAX_PFN to fit in an unsigned long, and DOMAIN_MAX_ADDR
-   to match. That way, we can use 'unsigned long' for PFNs with impunity. */
-#define DOMAIN_MAX_PFN(gaw)	((unsigned long) min_t(uint64_t, \
-				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
-#define DOMAIN_MAX_ADDR(gaw)	(((uint64_t)__DOMAIN_MAX_PFN(gaw)) << VTD_PAGE_SHIFT)
-
-/* IO virtual address start page frame number */
-#define IOVA_START_PFN		(1)
-
-#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-
-/* page table handling */
-#define LEVEL_STRIDE		(9)
-#define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
-
-static inline int agaw_to_level(int agaw)
-{
-	return agaw + 2;
-}
-
-static inline int agaw_to_width(int agaw)
-{
-	return min_t(int, 30 + agaw * LEVEL_STRIDE, MAX_AGAW_WIDTH);
-}
-
-static inline int width_to_agaw(int width)
-{
-	return DIV_ROUND_UP(width - 30, LEVEL_STRIDE);
-}
-
-static inline unsigned int level_to_offset_bits(int level)
-{
-	return (level - 1) * LEVEL_STRIDE;
-}
-
-static inline int pfn_level_offset(u64 pfn, int level)
-{
-	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
-}
-
-static inline u64 level_mask(int level)
-{
-	return -1ULL << level_to_offset_bits(level);
-}
-
-static inline u64 level_size(int level)
-{
-	return 1ULL << level_to_offset_bits(level);
-}
-
-static inline u64 align_to_level(u64 pfn, int level)
-{
-	return (pfn + level_size(level) - 1) & level_mask(level);
-}
-
-static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
-{
-	return 1UL << min_t(int, (lvl - 1) * LEVEL_STRIDE, MAX_AGAW_PFN_WIDTH);
-}
-
-/* VT-d pages must always be _smaller_ than MM pages. Otherwise things
-   are never going to work. */
-static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
-{
-	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
-}
-static inline unsigned long page_to_dma_pfn(struct page *pg)
-{
-	return mm_to_dma_pfn(page_to_pfn(pg));
-}
-static inline unsigned long virt_to_dma_pfn(void *p)
-{
-	return page_to_dma_pfn(virt_to_page(p));
-}
-
 /* global iommu list, set NULL for ignored DMAR units */
 static struct intel_iommu **g_iommus;
 
@@ -186,31 +71,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 	return re->hi & VTD_PAGE_MASK;
 }
 
-static inline void context_clear_pasid_enable(struct context_entry *context)
-{
-	context->lo &= ~(1ULL << 11);
-}
-
-static inline bool context_pasid_enabled(struct context_entry *context)
-{
-	return !!(context->lo & (1ULL << 11));
-}
-
-static inline void context_set_copied(struct context_entry *context)
-{
-	context->hi |= (1ull << 3);
-}
-
-static inline bool context_copied(struct context_entry *context)
-{
-	return !!(context->hi & (1ULL << 3));
-}
-
-static inline bool __context_present(struct context_entry *context)
-{
-	return (context->lo & 1);
-}
-
 bool context_present(struct context_entry *context)
 {
 	return context_pasid_enabled(context) ?
@@ -218,53 +78,6 @@ bool context_present(struct context_entry *context)
 	     __context_present(context) && !context_copied(context);
 }
 
-static inline void context_set_present(struct context_entry *context)
-{
-	context->lo |= 1;
-}
-
-static inline void context_set_fault_enable(struct context_entry *context)
-{
-	context->lo &= (((u64)-1) << 2) | 1;
-}
-
-static inline void context_set_translation_type(struct context_entry *context,
-						unsigned long value)
-{
-	context->lo &= (((u64)-1) << 4) | 3;
-	context->lo |= (value & 3) << 2;
-}
-
-static inline void context_set_address_root(struct context_entry *context,
-					    unsigned long value)
-{
-	context->lo &= ~VTD_PAGE_MASK;
-	context->lo |= value & VTD_PAGE_MASK;
-}
-
-static inline void context_set_address_width(struct context_entry *context,
-					     unsigned long value)
-{
-	context->hi |= value & 7;
-}
-
-static inline void context_set_domain_id(struct context_entry *context,
-					 unsigned long value)
-{
-	context->hi |= (value & ((1 << 16) - 1)) << 8;
-}
-
-static inline int context_domain_id(struct context_entry *c)
-{
-	return((c->hi >> 8) & 0xffff);
-}
-
-static inline void context_clear_entry(struct context_entry *context)
-{
-	context->lo = 0;
-	context->hi = 0;
-}
-
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -281,13 +94,8 @@ static int hw_pass_through = 1;
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_exit(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
-static int intel_iommu_attach_device(struct iommu_domain *domain,
-				     struct device *dev);
-static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
-					    dma_addr_t iova);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -421,24 +229,6 @@ void free_pgtable_page(void *vaddr)
 	free_page((unsigned long)vaddr);
 }
 
-static inline int domain_type_is_si(struct dmar_domain *domain)
-{
-	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
-}
-
-static inline bool domain_use_first_level(struct dmar_domain *domain)
-{
-	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL;
-}
-
-static inline int domain_pfn_supported(struct dmar_domain *domain,
-				       unsigned long pfn)
-{
-	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
-
-	return !(addr_width < BITS_PER_LONG && pfn >> addr_width);
-}
-
 static int __iommu_calculate_agaw(struct intel_iommu *iommu, int max_gaw)
 {
 	unsigned long sagaw;
@@ -490,7 +280,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	return g_iommus[iommu_id];
 }
 
-static inline bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
+static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 {
 	return sm_supported(iommu) ?
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
@@ -820,7 +610,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 		}
 
 		if (pdev && drhd->include_all) {
-		got_pdev:
+got_pdev:
 			if (bus && devfn) {
 				*bus = pdev->bus->number;
 				*devfn = pdev->devfn;
@@ -829,7 +619,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 		}
 	}
 	iommu = NULL;
- out:
+out:
 	if (iommu_is_dummy(iommu, dev))
 		iommu = NULL;
 
@@ -1401,15 +1191,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 	default:
 		BUG();
 	}
-	/* Note: set drain read/write */
-#if 0
-	/*
-	 * This is probably to be super secure.. Looks like we can
-	 * ignore it without any impact.
-	 */
-	if (cap_read_drain(iommu->cap))
-		val |= DMA_TLB_READ_DRAIN;
-#endif
+
 	if (cap_write_drain(iommu->cap))
 		val |= DMA_TLB_WRITE_DRAIN;
 
@@ -1613,9 +1395,9 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 }
 
 /* Notification for newly created mappings */
-static inline void __mapping_notify_one(struct intel_iommu *iommu,
-					struct dmar_domain *domain,
-					unsigned long pfn, unsigned int pages)
+static void __mapping_notify_one(struct intel_iommu *iommu,
+				 struct dmar_domain *domain,
+				 unsigned long pfn, unsigned int pages)
 {
 	/*
 	 * It's a non-present to present mapping. Only flush if caching mode
@@ -1865,7 +1647,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 	}
 }
 
-static inline int guestwidth_to_adjustwidth(int gaw)
+static int guestwidth_to_adjustwidth(int gaw)
 {
 	int agaw;
 	int r = (gaw - 12) % 9;
@@ -1907,7 +1689,7 @@ static void domain_exit(struct dmar_domain *domain)
  * Value of X in the PDTS field of a scalable mode context entry
  * indicates PASID directory with 2^(X + 7) entries.
  */
-static inline unsigned long context_get_sm_pds(struct pasid_table *table)
+static unsigned long context_get_sm_pds(struct pasid_table *table)
 {
 	unsigned long pds, max_pde;
 
@@ -1919,38 +1701,6 @@ static inline unsigned long context_get_sm_pds(struct pasid_table *table)
 	return pds - 7;
 }
 
-/*
- * Set the RID_PASID field of a scalable mode context entry. The
- * IOMMU hardware will use the PASID value set in this field for
- * DMA translations of DMA requests without PASID.
- */
-static inline void
-context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
-{
-	context->hi |= pasid & ((1 << 20) - 1);
-}
-
-/*
- * Set the DTE(Device-TLB Enable) field of a scalable mode context
- * entry.
- */
-static inline void context_set_sm_dte(struct context_entry *context)
-{
-	context->lo |= (1 << 2);
-}
-
-/*
- * Set the PRE(Page Request Enable) field of a scalable mode context
- * entry.
- */
-static inline void context_set_sm_pre(struct context_entry *context)
-{
-	context->lo |= (1 << 4);
-}
-
-/* Convert value to context PASID directory size field coding. */
-#define context_pdts(pds)	(((pds) & 0x7) << 9)
-
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      struct pasid_table *table,
@@ -2164,18 +1914,17 @@ static int domain_context_mapped(struct device *dev)
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
-static inline unsigned long aligned_nrpages(unsigned long host_addr,
-					    size_t size)
+static unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
 {
 	host_addr &= ~PAGE_MASK;
 	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
 }
 
 /* Return largest possible superpage level for a given mapping */
-static inline int hardware_largepage_caps(struct dmar_domain *domain,
-					  unsigned long iov_pfn,
-					  unsigned long phy_pfn,
-					  unsigned long pages)
+static int hardware_largepage_caps(struct dmar_domain *domain,
+				   unsigned long iov_pfn,
+				   unsigned long phy_pfn,
+				   unsigned long pages)
 {
 	int support, level = 1;
 	unsigned long pfnmerge;
@@ -3650,7 +3399,7 @@ void intel_iommu_shutdown(void)
 	up_write(&dmar_global_lock);
 }
 
-static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
+static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
 {
 	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
 
@@ -3728,7 +3477,7 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static inline bool has_external_pci(void)
+static bool has_external_pci(void)
 {
 	struct pci_dev *pdev = NULL;
 
-- 
2.25.1

