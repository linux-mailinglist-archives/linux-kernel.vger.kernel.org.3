Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7255D268
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbiF1HCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiF1HCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:02:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634C26AF3;
        Tue, 28 Jun 2022 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656399729; x=1687935729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VlDSeJT+Vd4Pw/ouEol7LnsTGtQxtAjTVsFDFR7asiI=;
  b=HgEIVWG8BI3QmyBTTG07a+DraYxPMEosaD3Z+yHQtf72tq0xglW1SbHW
   djvKROIbP6Ug+7M+gMtjkUorsVILZ64THTWqK9iu2dMbWF1Ym3sCRkrnn
   /QzDR5I36fP/LFkY8HApO77C4DrvABBJDPbbifSSAlyekAjm0rHBLO837
   ebfwUFberIoIASUKJDSAKo/dSBo8dhKYrmeds+spvEMHHIJrXdcAv8J6O
   kZ4xjUBireqBy6zDbAJ4byBfMv8/G3Zn+rzHvygGCrtPOsi1JhdyVPUsU
   hTkyQgkSiCStVOPZ0wKRBc2B06Z/XcGnJ//t59ZQgGG4iiyL3HNFRv7uJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279200541"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279200541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:02:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646782912"
Received: from spr.sh.intel.com ([10.239.53.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:01:54 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Chao Gao <chao.gao@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v1 3/3] swiotlb: Split up single swiotlb lock
Date:   Tue, 28 Jun 2022 15:01:34 +0800
Message-Id: <20220628070136.419163-4-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628070136.419163-1-chao.gao@intel.com>
References: <20220628070136.419163-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
signifiant lock contention on the swiotlb lock. We've seen 20+% CPU
time in locks in some extreme cases.

This patch splits the swiotlb into individual areas which have their
own lock. Each CPU tries to allocate in its own area first. Only if
that fails does it search other areas. On freeing the allocation is
freed into the area where the memory was originally allocated from.

To avoid doing a full modulo in the main path the number of swiotlb
areas is always rounded to the next power of two. I believe that's
not really needed anymore on modern CPUs (which have fast enough
dividers), but still a good idea on older parts.

The number of areas can be set using the swiotlb option. But to avoid
every user having to set this option set the default to the number of
available CPUs. Unfortunately on x86 swiotlb is initialized before
num_possible_cpus() is available, that is why it uses a custom hook
called from the early ACPI code.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
[ rebase and fix warnings of checkpatch.pl ]
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/kernel/acpi/boot.c                   |   4 +
 include/linux/swiotlb.h                       |  30 +++-
 kernel/dma/swiotlb.c                          | 168 ++++++++++++++++--
 4 files changed, 180 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..5d46271982d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5869,8 +5869,10 @@
 			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
 
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
-			Format: { <int> | force | noforce }
+			Format: { <int> [,<int>] | force | noforce }
 			<int> -- Number of I/O TLB slabs
+			<int> -- Second integer after comma. Number of swiotlb
+				 areas with their own lock. Must be power of 2.
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..f05e55b2d50c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -22,6 +22,7 @@
 #include <linux/efi-bgrt.h>
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
+#include <linux/swiotlb.h>
 
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
@@ -1131,6 +1132,9 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		return count;
 	}
 
+	/* This does not take overrides into consideration */
+	swiotlb_hint_cpus(max(count, x2count));
+
 	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
 					acpi_parse_x2apic_nmi, 0);
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 012a6fde873b..cf36c5cc7584 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -69,7 +69,25 @@ struct io_tlb_slot {
 };
 
 /**
- * struct io_tlb_mem - IO TLB Memory Pool Descriptor
+ * struct io_tlb_area - IO TLB memory area descriptor
+ *
+ * This is a single area with a single lock.
+ *
+ * @used:	The number of used IO TLB block.
+ * @list:	The free list describing the number of free entries available
+ *		from each index.
+ * @lock:	The lock to protect the above data structures in the map and
+ *		unmap calls.
+ */
+
+struct io_tlb_area {
+	unsigned long used;
+	struct list_head free_slots;
+	spinlock_t lock;
+};
+
+/**
+ * struct io_tlb_mem - io tlb memory pool descriptor
  *
  * @start:	The start address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
@@ -87,8 +105,6 @@ struct io_tlb_slot {
  * @index:	The index to start searching in the next round.
  * @orig_addr:	The original address corresponding to a mapped entry.
  * @alloc_size:	Size of the allocated buffer.
- * @lock:	The lock to protect the above data structures in the map and
- *		unmap calls.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
@@ -101,13 +117,11 @@ struct io_tlb_mem {
 	phys_addr_t end;
 	void *vaddr;
 	unsigned long nslabs;
-	unsigned long used;
-	struct list_head free_slots;
-	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
 	bool force_bounce;
 	bool for_alloc;
+	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
 	unsigned long *bitmap;
 };
@@ -133,6 +147,7 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
+void swiotlb_hint_cpus(int cpus);
 #else
 static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
 {
@@ -165,6 +180,9 @@ static inline bool is_swiotlb_active(struct device *dev)
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
+static inline void swiotlb_hint_cpus(int cpus)
+{
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2283f3a36f0d..a25e53e84b80 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -62,6 +62,8 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+#define NUM_AREAS_DEFAULT 1
+
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
@@ -71,14 +73,61 @@ phys_addr_t swiotlb_unencrypted_base;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 
+static __read_mostly unsigned int area_index_shift;
+static __read_mostly unsigned int area_bits;
+static __read_mostly int num_areas = NUM_AREAS_DEFAULT;
+
+static __init int setup_areas(int n)
+{
+	unsigned long nslabs;
+
+	if (n < 1 || !is_power_of_2(n) || n > default_nslabs) {
+		pr_err("swiotlb: Invalid areas parameter %d\n", n);
+		return -EINVAL;
+	}
+
+	/*
+	 * Round up number of slabs to the next power of 2.
+	 * The last area is going be smaller than the rest if default_nslabs is
+	 * not power of two.
+	 */
+	nslabs = roundup_pow_of_two(default_nslabs);
+
+	pr_info("swiotlb: Using %d areas\n", n);
+	num_areas = n;
+	area_index_shift = __fls(nslabs) - __fls(num_areas);
+	area_bits = __fls(n);
+	return 0;
+}
+
+/*
+ * Can be called from architecture specific code when swiotlb is set up before
+ * possible cpus are setup.
+ */
+
+void __init swiotlb_hint_cpus(int cpus)
+{
+	if (num_areas == NUM_AREAS_DEFAULT && cpus > 1) {
+		if (!is_power_of_2(cpus))
+			cpus = 1U << (__fls(cpus) + 1);
+		setup_areas(cpus);
+	}
+}
+
 static int __init
 setup_io_tlb_npages(char *str)
 {
+	int ret = 0;
+
 	if (isdigit(*str)) {
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
 	}
+	if (*str == ',')
+		++str;
+	if (isdigit(*str))
+		ret = setup_areas(simple_strtoul(str, &str, 0));
 	if (*str == ',')
 		++str;
 	if (!strcmp(str, "force"))
@@ -86,7 +135,7 @@ setup_io_tlb_npages(char *str)
 	else if (!strcmp(str, "noforce"))
 		swiotlb_force_disable = true;
 
-	return 0;
+	return ret;
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
@@ -114,6 +163,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 		return;
 	size = ALIGN(size, IO_TLB_SIZE);
 	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	setup_areas(num_areas);
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }
 
@@ -200,17 +250,21 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nslabs = nslabs;
 	mem->start = start;
 	mem->end = mem->start + bytes;
-	INIT_LIST_HEAD(&mem->free_slots);
 	mem->late_alloc = late_alloc;
 
 	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
-	spin_lock_init(&mem->lock);
+	for (i = 0; i < num_areas; i++) {
+		INIT_LIST_HEAD(&mem->areas[i].free_slots);
+		spin_lock_init(&mem->areas[i].lock);
+	}
 	for (i = 0; i < mem->nslabs; i++) {
+		int aindex = area_index_shift ? i >> area_index_shift : 0;
 		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
-		list_add_tail(&mem->slots[i].node, &mem->free_slots);
+		list_add_tail(&mem->slots[i].node,
+			      &mem->areas[aindex].free_slots);
 	}
 
 	/*
@@ -274,6 +328,10 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (!mem->slots)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
+	mem->areas = memblock_alloc(sizeof(struct io_tlb_area) * num_areas,
+				    SMP_CACHE_BYTES);
+	if (!mem->areas)
+		panic("Cannot allocate io_tlb_areas");
 
 	mem->bitmap = memblock_alloc(BITS_TO_BYTES(nslabs), SMP_CACHE_BYTES);
 	if (!mem->bitmap)
@@ -353,6 +411,12 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		return -ENOMEM;
 	}
 
+	mem->areas = kcalloc(num_areas, sizeof(struct io_tlb_area), GFP_KERNEL);
+	if (!mem->areas) {
+		free_pages((unsigned long)mem->slots, order);
+		return -ENOMEM;
+	}
+
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true);
@@ -380,9 +444,12 @@ void __init swiotlb_exit(void)
 
 	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
 	if (mem->late_alloc) {
+		kfree(mem->areas);
 		free_pages(tbl_vaddr, get_order(tbl_size));
 		free_pages((unsigned long)mem->slots, get_order(slots_size));
 	} else {
+		memblock_free_late(__pa(mem->areas),
+				   num_areas * sizeof(struct io_tlb_area));
 		memblock_free_late(mem->start, tbl_size);
 		memblock_free_late(__pa(mem->slots), slots_size);
 	}
@@ -485,14 +552,32 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
 	return nr_slots(boundary_mask + 1);
 }
 
+static inline unsigned long area_nslabs(struct io_tlb_mem *mem)
+{
+	return area_index_shift ? (1UL << area_index_shift) + 1 :
+			mem->nslabs;
+}
+
+static inline unsigned int area_start(int aindex)
+{
+	return aindex << area_index_shift;
+}
+
+static inline unsigned int area_end(struct io_tlb_mem *mem, int aindex)
+{
+	return area_start(aindex) + area_nslabs(mem);
+}
+
 /*
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
-			      size_t alloc_size, unsigned int alloc_align_mask)
+static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
+				 struct io_tlb_area *area,
+				 struct device *dev, phys_addr_t orig_addr,
+				 size_t alloc_size,
+				 unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_slot *slot, *tmp;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
@@ -511,11 +596,11 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	/* slots shouldn't cross one segment */
 	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
 
-	spin_lock_irqsave(&mem->lock, flags);
-	if (unlikely(nslots > mem->nslabs - mem->used))
+	spin_lock_irqsave(&area->lock, flags);
+	if (unlikely(nslots > area_nslabs(mem) - area->used))
 		goto not_found;
 
-	list_for_each_entry_safe(slot, tmp, &mem->free_slots, node) {
+	list_for_each_entry_safe(slot, tmp, &area->free_slots, node) {
 		index = slot - mem->slots;
 		slot_dma_addr = slot_addr(tbl_dma_addr, index);
 		if (orig_addr &&
@@ -550,7 +635,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	}
 
 not_found:
-	spin_unlock_irqrestore(&mem->lock, flags);
+	spin_unlock_irqrestore(&area->lock, flags);
 	return -1;
 
 found:
@@ -561,12 +646,43 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		list_del(&mem->slots[i].node);
 	}
 
-	mem->used += nslots;
+	area->used += nslots;
 
-	spin_unlock_irqrestore(&mem->lock, flags);
+	spin_unlock_irqrestore(&area->lock, flags);
 	return index;
 }
 
+static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
+			      size_t alloc_size, unsigned int alloc_align_mask)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	int start = raw_smp_processor_id() & ((1U << area_bits) - 1);
+	int i, index;
+
+	i = start;
+	do {
+		index = swiotlb_do_find_slots(mem, mem->areas + i,
+					      dev, orig_addr, alloc_size,
+					      alloc_align_mask);
+		if (index >= 0)
+			return index;
+		if (++i >= num_areas)
+			i = 0;
+	} while (i != start);
+	return -1;
+}
+
+/* Somewhat racy estimate */
+static unsigned long mem_used(struct io_tlb_mem *mem)
+{
+	int i;
+	unsigned long used = 0;
+
+	for (i = 0; i < num_areas; i++)
+		used += mem->areas[i].used;
+	return used;
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
@@ -596,7 +712,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem->used);
+				 alloc_size, mem->nslabs, mem_used(mem));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -626,9 +742,14 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
 	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
+	int aindex = area_index_shift ? index >> area_index_shift : 0;
+	struct io_tlb_area *area = mem->areas + aindex;
 	int i;
 
-	spin_lock_irqsave(&mem->lock, flags);
+	WARN_ON(aindex >= num_areas);
+
+	spin_lock_irqsave(&area->lock, flags);
+
 	/*
 	 * Return the slots to swiotlb, updating bitmap to indicate
 	 * corresponding entries are free.
@@ -637,11 +758,11 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
-		list_add(&mem->slots[i].node, &mem->free_slots);
+		list_add(&mem->slots[i].node, &area->free_slots);
 	}
 
-	mem->used -= nslots;
-	spin_unlock_irqrestore(&mem->lock, flags);
+	area->used -= nslots;
+	spin_unlock_irqrestore(&area->lock, flags);
 }
 
 /*
@@ -736,6 +857,15 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
+static int used_get(void *data, u64 *val)
+{
+	struct io_tlb_mem *mem = (struct io_tlb_mem *)data;
+	*val = mem_used(mem);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(used_fops, used_get, NULL, "%llu\n");
+
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
 {
@@ -744,7 +874,7 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 		return;
 
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
-	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem, &used_fops);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
2.25.1

