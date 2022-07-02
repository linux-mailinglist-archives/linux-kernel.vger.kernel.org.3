Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7156413B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGBP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:58:39 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE3BC04
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 08:58:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VI7A5qb_1656777474;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VI7A5qb_1656777474)
          by smtp.aliyun-inc.com;
          Sat, 02 Jul 2022 23:58:30 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com
Cc:     alikernel-developer@linux.alibaba.com
Subject: [PATCH v4] arm64: mm: fix linear mem mapping access performance degradation
Date:   Sat,  2 Jul 2022 23:57:53 +0800
Message-Id: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
(enable crashkernel, disable rodata full, disable kfence), the mem_map will
use non block/section mapping(for crashkernel requires to shrink the region
in page granularity). But it will degrade performance when doing larging
continuous mem access in kernel(memcpy/memmove, etc).

There are many changes and discussions:
commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones")
commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into
mem_init()")
commit 2687275a5843 ("arm64: Force NO_BLOCK_MAPPINGS if crashkernel
reservation is required")

This patch changes mem_map to use block/section mapping with crashkernel.
Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
mem_map, reserve crashkernel memory. And then walking pagetable to split
block/section mapping to non block/section mapping(normally 4K) [[[only]]]
for crashkernel mem. So the linear mem mapping use block/section mapping
as more as possible. We will reduce the cpu dTLB miss conspicuously, and
accelerate mem access about 10-20% performance improvement.

I have tested it with pft(Page Fault Test) and fio, obtained great
performace improvement.

For fio test:
1.prepare ramdisk
  modprobe -r brd
  modprobe brd rd_nr=1 rd_size=67108864
  dmsetup remove_all
  wipefs -a --force /dev/ram0
  mkfs -t ext4 -E lazy_itable_init=0,lazy_journal_init=0 -q -F /dev/ram0
  mkdir -p /fs/ram0
  mount -t ext4 /dev/ram0 /fs/ram0

2.prepare fio paremeter in x.fio file:
[global]
bs=4k
ioengine=psync
iodepth=128
size=32G
direct=1
invalidate=1
group_reporting
thread=1
rw=read
directory=/fs/ram0
numjobs=1

[task_0]
cpus_allowed=16
stonewall=1

3.run testcase:
perf stat -e dTLB-load-misses fio x.fio

4.contrast
------------------------
			without patch		with patch
fio READ		aggrb=1493.2MB/s	aggrb=1775.3MB/s
dTLB-load-misses	1,818,320,693		438,729,774
time elapsed(s)		70.500326434		62.877316408
user(s)			15.926332000		15.684721000
sys(s)			54.211939000		47.046165000

5.conclusion
Using this patch will reduce dTLB misses and improve performace greatly.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 arch/arm64/include/asm/mmu.h |   1 +
 arch/arm64/mm/init.c         |   8 +-
 arch/arm64/mm/mmu.c          | 176 +++++++++++++++++++++++++++++++------------
 3 files changed, 132 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 48f8466..1a46b81 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -63,6 +63,7 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 extern void arm64_memblock_init(void);
 extern void paging_init(void);
 extern void bootmem_init(void);
+extern void map_crashkernel(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 339ee84..241d27e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -190,6 +190,7 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
+	map_crashkernel();
 }
 
 /*
@@ -388,10 +389,6 @@ void __init arm64_memblock_init(void)
 	}
 
 	early_init_fdt_scan_reserved_mem();
-
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -438,8 +435,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
+	reserve_crashkernel();
 
 	memblock_dump_all();
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32..76a4ff0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -65,6 +65,10 @@
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
 static DEFINE_MUTEX(fixmap_lock);
+static void unmap_hotplug_range(unsigned long addr, unsigned long end,
+				bool free_mapped, struct vmem_altmap *altmap,
+				pgprot_t prot,
+				phys_addr_t (*pgtable_alloc)(int), int flags);
 
 void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
@@ -483,20 +487,49 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
+#ifdef CONFIG_KEXEC_CORE
+static phys_addr_t __init early_crashkernel_pgtable_alloc(int shift)
+{
+	phys_addr_t phys;
+	void *ptr;
+
+	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
+					 MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (!phys)
+		panic("Failed to allocate page table page\n");
+
+	ptr = (void *)__phys_to_virt(phys);
+	memset(ptr, 0, PAGE_SIZE);
+	return phys;
+}
 
-static int __init enable_crash_mem_map(char *arg)
+void __init map_crashkernel(void)
 {
-	/*
-	 * Proper parameter parsing is done by reserve_crashkernel(). We only
-	 * need to know if the linear map has to avoid block mappings so that
-	 * the crashkernel reservations can be unmapped later.
-	 */
-	crash_mem_map = true;
+	phys_addr_t start, end, size;
 
-	return 0;
+	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
+	    return;
+
+	if (!crashk_res.end)
+	    return;
+
+	start = crashk_res.start & PAGE_MASK;
+	end = PAGE_ALIGN(crashk_res.end);
+	size = end - start;
+
+	unmap_hotplug_range(__phys_to_virt(start), __phys_to_virt(end), false,
+			    NULL, PAGE_KERNEL, early_crashkernel_pgtable_alloc,
+			    NO_EXEC_MAPPINGS);
+	__create_pgd_mapping(swapper_pg_dir, crashk_res.start,
+			     __phys_to_virt(crashk_res.start),
+			     size, PAGE_KERNEL,
+			     early_crashkernel_pgtable_alloc,
+			     NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS |
+			     NO_CONT_MAPPINGS);
 }
-early_param("crashkernel", enable_crash_mem_map);
+#else
+void __init mapping_crashkernel(void) {}
+#endif
 
 static void __init map_mem(pgd_t *pgdp)
 {
@@ -527,17 +560,6 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
-#ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
-		    IS_ENABLED(CONFIG_ZONE_DMA32))
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
-	}
-#endif
-
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
@@ -570,19 +592,6 @@ static void __init map_mem(pgd_t *pgdp)
 	 * in page granularity and put back unused memory to buddy system
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
-#ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map &&
-	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
-	}
-#endif
 }
 
 void mark_rodata_ro(void)
@@ -827,7 +836,6 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(pte));
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 static void free_hotplug_page_range(struct page *page, size_t size,
 				    struct vmem_altmap *altmap)
 {
@@ -863,9 +871,25 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 	return true;
 }
 
+static void pte_clear_cont(pte_t *ptep)
+{
+	int i = 0;
+	pte_t pte = READ_ONCE(*ptep);
+	if (pte_none(pte) || !pte_cont(pte))
+		return;
+	ptep -= ((u64)ptep / sizeof(pte_t)) &
+		((1 << CONFIG_ARM64_CONT_PTE_SHIFT) - 1);
+	do {
+		pte = pte_mknoncont(READ_ONCE(*ptep));
+		set_pte(ptep, pte);
+	} while (++ptep, ++i < CONT_PTES);
+}
+
 static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
-				    struct vmem_altmap *altmap)
+				    struct vmem_altmap *altmap, pgprot_t prot,
+				    phys_addr_t (*pgtable_alloc)(int),
+				    int flags)
 {
 	pte_t *ptep, pte;
 
@@ -876,6 +900,8 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 			continue;
 
 		WARN_ON(!pte_present(pte));
+
+		pte_clear_cont(ptep);
 		pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 		if (free_mapped)
@@ -884,9 +910,26 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
+static void pmd_clear_cont(pmd_t *pmdp)
+{
+	int i = 0;
+	pmd_t pmd = READ_ONCE(*pmdp);
+	if (pmd_none(pmd) || !pmd_sect(pmd) || !pmd_cont(pmd))
+		return;
+	pmdp -= ((u64)pmdp / sizeof(pmd_t)) &
+		((1 << CONFIG_ARM64_CONT_PMD_SHIFT) - 1);
+	do {
+		pmd = READ_ONCE(*pmdp);
+		pmd = pte_pmd(pte_mknoncont(pmd_pte(pmd)));
+		set_pmd(pmdp, pmd);
+	} while (++pmdp, ++i < CONT_PMDS);
+}
+
 static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
-				    struct vmem_altmap *altmap)
+				    struct vmem_altmap *altmap, pgprot_t prot,
+				    phys_addr_t (*pgtable_alloc)(int),
+				    int flags)
 {
 	unsigned long next;
 	pmd_t *pmdp, pmd;
@@ -900,6 +943,8 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 
 		WARN_ON(!pmd_present(pmd));
 		if (pmd_sect(pmd)) {
+			//clear CONT flags
+			pmd_clear_cont(pmdp);
 			pmd_clear(pmdp);
 
 			/*
@@ -907,19 +952,36 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 			 * range is mapped with a single block entry.
 			 */
 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+			if (addr & ~PMD_MASK)
+				alloc_init_cont_pte(pmdp, addr & PMD_MASK,
+						    addr, __virt_to_phys(addr &
+						    PMD_MASK), prot,
+						    pgtable_alloc, flags);
+
+			if (next & ~PMD_MASK)
+				alloc_init_cont_pte(pmdp, next, ALIGN(next,
+						    PMD_SIZE),
+						    __virt_to_phys(next),
+						    prot, pgtable_alloc,
+						    flags);
+
 			if (free_mapped)
 				free_hotplug_page_range(pmd_page(pmd),
 							PMD_SIZE, altmap);
 			continue;
 		}
 		WARN_ON(!pmd_table(pmd));
-		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped, altmap);
+		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped, altmap,
+					prot, pgtable_alloc, flags);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
-				    struct vmem_altmap *altmap)
+				    struct vmem_altmap *altmap, pgprot_t prot,
+				    phys_addr_t (*pgtable_alloc)(int),
+				    int flags)
 {
 	unsigned long next;
 	pud_t *pudp, pud;
@@ -940,19 +1002,36 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 			 * range is mapped with a single block entry.
 			 */
 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+			if (addr & (~PUD_MASK))
+				alloc_init_cont_pmd(pudp, addr & PUD_MASK,
+						    addr, __virt_to_phys(addr &
+						    PUD_MASK), prot,
+						    pgtable_alloc, flags);
+
+			if (next & (~PUD_MASK))
+				alloc_init_cont_pmd(pudp, next,
+						    ALIGN(next, PUD_SIZE),
+						    __virt_to_phys(next),
+						    prot, pgtable_alloc,
+						    flags);
+
 			if (free_mapped)
 				free_hotplug_page_range(pud_page(pud),
 							PUD_SIZE, altmap);
 			continue;
 		}
 		WARN_ON(!pud_table(pud));
-		unmap_hotplug_pmd_range(pudp, addr, next, free_mapped, altmap);
+		unmap_hotplug_pmd_range(pudp, addr, next, free_mapped, altmap,
+					prot, pgtable_alloc, flags);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
-				    struct vmem_altmap *altmap)
+				    struct vmem_altmap *altmap, pgprot_t prot,
+				    phys_addr_t (*pgtable_alloc)(int),
+				    int flags)
 {
 	unsigned long next;
 	p4d_t *p4dp, p4d;
@@ -965,12 +1044,15 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 			continue;
 
 		WARN_ON(!p4d_present(p4d));
-		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
+		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap,
+					prot, pgtable_alloc, flags);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
-				bool free_mapped, struct vmem_altmap *altmap)
+				bool free_mapped, struct vmem_altmap *altmap,
+				pgprot_t prot,
+				phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pgd_t *pgdp, pgd;
@@ -991,7 +1073,8 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 			continue;
 
 		WARN_ON(!pgd_present(pgd));
-		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
+		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap,
+					prot, pgtable_alloc, flags);
 	} while (addr = next, addr < end);
 }
 
@@ -1148,7 +1231,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 }
-#endif
 
 #if !ARM64_KERNEL_USES_PMD_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -1210,7 +1292,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	unmap_hotplug_range(start, end, true, altmap);
+	unmap_hotplug_range(start, end, true, altmap, __pgprot(0), NULL, 0);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
@@ -1474,7 +1556,7 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	WARN_ON(pgdir != init_mm.pgd);
 	WARN_ON((start < PAGE_OFFSET) || (end > PAGE_END));
 
-	unmap_hotplug_range(start, end, false, NULL);
+	unmap_hotplug_range(start, end, false, NULL, __pgprot(0), NULL, 0);
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-- 
1.8.3.1

