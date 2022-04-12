Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D54FDC45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiDLKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbiDLKAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:00:53 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7C6D965
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:08:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V9twWp8_1649754476;
Received: from j66d16353.sqa.eu95.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0V9twWp8_1649754476)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Apr 2022 17:08:04 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
Subject: [PATCH RFC v1] arm64: mm: change mem_map to use block/section mapping with crashkernel
Date:   Tue, 12 Apr 2022 17:07:56 +0800
Message-Id: <1649754476-8713-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many changes and discussions:
commit 031495635b46
commit 1a8e1cef7603
commit 8424ecdde7df
commit 0a30c53573b0
commit 2687275a5843

When using DMA/DMA32 zone and crashkernel, disable rodata full and kfence,
mem_map will use non block/section mapping(for crashkernel requires to shrink
the region in page granularity). But it will degrade performance when doing
larging continuous mem access in kernel(memcpy/memmove, etc).

This patch firstly do block/section mapping at mem_map, reserve crashkernel
memory. And then walking pagetable to split block/section mapping
to non block/section mapping [only] for crashkernel mem. We will accelerate
mem access about 10-20% performance improvement, and reduce the cpu dTLB miss
conspicuously on some platform with this optimization.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 arch/arm64/include/asm/mmu.h |   1 +
 arch/arm64/mm/init.c         |   8 +-
 arch/arm64/mm/mmu.c          | 274 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 253 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 48f8466..df113cc 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -63,6 +63,7 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 extern void arm64_memblock_init(void);
 extern void paging_init(void);
 extern void bootmem_init(void);
+extern void mapping_crashkernel(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8ac25f1..02edd45 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -335,10 +335,6 @@ void __init arm64_memblock_init(void)
 	}
 
 	early_init_fdt_scan_reserved_mem();
-
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -385,8 +381,8 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
+	reserve_crashkernel();
+	mapping_crashkernel();
 
 	memblock_dump_all();
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32..0672afd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -498,6 +498,256 @@ static int __init enable_crash_mem_map(char *arg)
 }
 early_param("crashkernel", enable_crash_mem_map);
 
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
+
+static void init_crashkernel_pte(pmd_t *pmdp, unsigned long addr,
+				 unsigned long end,
+				 phys_addr_t phys, pgprot_t prot)
+{
+	pte_t *ptep;
+	ptep = pte_offset_kernel(pmdp, addr);
+	do {
+		set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
+		phys += PAGE_SIZE;
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+}
+
+static void alloc_crashkernel_cont_pte(pmd_t *pmdp, unsigned long addr,
+				       unsigned long end, phys_addr_t phys,
+				       pgprot_t prot,
+				       phys_addr_t (*pgtable_alloc)(int),
+				       int flags)
+{
+	unsigned long next;
+	pmd_t pmd = READ_ONCE(*pmdp);
+
+	BUG_ON(pmd_sect(pmd));
+	if (pmd_none(pmd)) {
+		pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
+		phys_addr_t pte_phys;
+
+		if (flags & NO_EXEC_MAPPINGS)
+			pmdval |= PMD_TABLE_PXN;
+		BUG_ON(!pgtable_alloc);
+		pte_phys = pgtable_alloc(PAGE_SHIFT);
+		__pmd_populate(pmdp, pte_phys, pmdval);
+		pmd = READ_ONCE(*pmdp);
+	}
+	BUG_ON(pmd_bad(pmd));
+
+	do {
+		pgprot_t __prot = prot;
+		next = pte_cont_addr_end(addr, end);
+		init_crashkernel_pte(pmdp, addr, next, phys, __prot);
+		phys += next - addr;
+	} while (addr = next, addr != end);
+}
+
+static void init_crashkernel_pmd(pud_t *pudp, unsigned long addr,
+				 unsigned long end, phys_addr_t phys,
+				 pgprot_t prot,
+				 phys_addr_t (*pgtable_alloc)(int), int flags)
+{
+	phys_addr_t map_offset;
+	unsigned long next;
+	pmd_t *pmdp;
+	pmdval_t pmdval;
+
+	pmdp = pmd_offset(pudp, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
+			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
+			pmd_clear(pmdp);
+			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
+			if (flags & NO_EXEC_MAPPINGS)
+				pmdval |= PMD_TABLE_PXN;
+			__pmd_populate(pmdp, pte_phys, pmdval);
+			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+			map_offset = addr - (addr & PMD_MASK);
+			if (map_offset)
+			    alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
+						phys - map_offset, prot,
+						pgtable_alloc, flags);
+
+			if (next < (addr & PMD_MASK) + PMD_SIZE)
+			    alloc_init_cont_pte(pmdp, next, (addr & PUD_MASK) +
+						PUD_SIZE, next - addr + phys,
+						prot, pgtable_alloc, flags);
+		}
+		alloc_crashkernel_cont_pte(pmdp, addr, next, phys, prot,
+					   pgtable_alloc, flags);
+		phys += next - addr;
+	} while (pmdp++, addr = next, addr != end);
+}
+
+static void alloc_crashkernel_cont_pmd(pud_t *pudp, unsigned long addr,
+				       unsigned long end, phys_addr_t phys,
+				       pgprot_t prot,
+				       phys_addr_t (*pgtable_alloc)(int),
+				       int flags)
+{
+	unsigned long next;
+	pud_t pud = READ_ONCE(*pudp);
+
+	/*
+	 * Check for initial section mappings in the pgd/pud.
+	 */
+	BUG_ON(pud_sect(pud));
+	if (pud_none(pud)) {
+		pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
+		phys_addr_t pmd_phys;
+
+		if (flags & NO_EXEC_MAPPINGS)
+			pudval |= PUD_TABLE_PXN;
+		BUG_ON(!pgtable_alloc);
+		pmd_phys = pgtable_alloc(PMD_SHIFT);
+		__pud_populate(pudp, pmd_phys, pudval);
+		pud = READ_ONCE(*pudp);
+	}
+	BUG_ON(pud_bad(pud));
+
+	do {
+		pgprot_t __prot = prot;
+		next = pmd_cont_addr_end(addr, end);
+		init_crashkernel_pmd(pudp, addr, next, phys, __prot,
+				     pgtable_alloc, flags);
+		phys += next - addr;
+	} while (addr = next, addr != end);
+}
+
+static void alloc_crashkernel_pud(pgd_t *pgdp, unsigned long addr,
+				  unsigned long end, phys_addr_t phys,
+				  pgprot_t prot,
+				  phys_addr_t (*pgtable_alloc)(int),
+				  int flags)
+{
+	phys_addr_t map_offset;
+	unsigned long next;
+	pud_t *pudp;
+	p4d_t *p4dp = p4d_offset(pgdp, addr);
+	p4d_t p4d = READ_ONCE(*p4dp);
+	pudval_t pudval;
+
+	if (p4d_none(p4d)) {
+		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN;
+		phys_addr_t pud_phys;
+
+		if (flags & NO_EXEC_MAPPINGS)
+			p4dval |= P4D_TABLE_PXN;
+		BUG_ON(!pgtable_alloc);
+		pud_phys = pgtable_alloc(PUD_SHIFT);
+		__p4d_populate(p4dp, pud_phys, p4dval);
+		p4d = READ_ONCE(*p4dp);
+	}
+	BUG_ON(p4d_bad(p4d));
+
+	/*
+	 * No need for locking during early boot. And it doesn't work as
+	 * expected with KASLR enabled.
+	 */
+	if (system_state != SYSTEM_BOOTING)
+		mutex_lock(&fixmap_lock);
+	pudp = pud_offset(p4dp, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (!pud_none(*pudp) && pud_sect(*pudp)) {
+			phys_addr_t pmd_phys = pgtable_alloc(PMD_SHIFT);
+			pud_clear(pudp);
+
+			pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
+			if (flags & NO_EXEC_MAPPINGS)
+				pudval |= PUD_TABLE_PXN;
+			__pud_populate(pudp, pmd_phys, pudval);
+			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+			map_offset = addr - (addr & PUD_MASK);
+			if (map_offset)
+			    alloc_init_cont_pmd(pudp, addr & PUD_MASK, addr,
+						phys - map_offset, prot,
+						pgtable_alloc, flags);
+
+			if (next < (addr & PUD_MASK) + PUD_SIZE)
+			    alloc_init_cont_pmd(pudp, next, (addr & PUD_MASK) +
+						PUD_SIZE, next - addr + phys,
+						prot, pgtable_alloc, flags);
+		}
+		alloc_crashkernel_cont_pmd(pudp, addr, next, phys, prot,
+					   pgtable_alloc, flags);
+		phys += next - addr;
+	} while (pudp++, addr = next, addr != end);
+
+	if (system_state != SYSTEM_BOOTING)
+		mutex_unlock(&fixmap_lock);
+}
+
+static void __create_crashkernel_mapping(pgd_t *pgdir, phys_addr_t phys,
+					 unsigned long virt, phys_addr_t size,
+					 pgprot_t prot,
+					 phys_addr_t (*pgtable_alloc)(int),
+					 int flags)
+{
+	unsigned long addr, end, next;
+	pgd_t *pgdp = pgd_offset_pgd(pgdir, virt);
+
+	/*
+	 * If the virtual and physical address don't have the same offset
+	 * within a page, we cannot map the region as the caller expects.
+	 */
+	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
+		return;
+
+	phys &= PAGE_MASK;
+	addr = virt & PAGE_MASK;
+	end = PAGE_ALIGN(virt + size);
+
+	do {
+		next = pgd_addr_end(addr, end);
+		alloc_crashkernel_pud(pgdp, addr, next, phys, prot,
+				      pgtable_alloc, flags);
+		phys += next - addr;
+	} while (pgdp++, addr = next, addr != end);
+}
+
+static void __init map_crashkernel(pgd_t *pgdp, phys_addr_t start,
+				   phys_addr_t end, pgprot_t prot, int flags)
+{
+	__create_crashkernel_mapping(pgdp, start, __phys_to_virt(start),
+				     end - start, prot,
+				     early_crashkernel_pgtable_alloc, flags);
+}
+
+void __init mapping_crashkernel(void)
+{
+	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
+	    return;
+
+	if (!crash_mem_map || !crashk_res.end)
+	    return;
+
+	map_crashkernel(swapper_pg_dir, crashk_res.start,
+			crashk_res.end + 1, PAGE_KERNEL,
+			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+}
+#else
+void __init mapping_crashkernel(void) {}
+#endif
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -527,17 +777,6 @@ static void __init map_mem(pgd_t *pgdp)
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
@@ -570,19 +809,6 @@ static void __init map_mem(pgd_t *pgdp)
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
-- 
1.8.3.1

