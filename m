Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA215993F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbiHSEMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbiHSEMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BD0D41BD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7148C61538
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F9AC433B5;
        Fri, 19 Aug 2022 04:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660882348;
        bh=Alvns4dpbVoV7VohHSyYxFeYgoUid9EzSZfmT2izcoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C99RTrEyoqCLyTDVCqKkr2U2/6O+Gm+ZTiCS4iz71T9txXvKXALdZ+QkY7e7gis16
         ZPrkUuyKKRp+A9Xxc89yUSR8rIWnpy19eeFbxMsCZLamHyf7HL8VkOc3sgjcP113ag
         M53xCZHpvVblDmZaSbTgh8KJeisMJbGylmO5J9lUVC2wbwdn5Cg6UlC1n/mDLS0INr
         Czr9Nmt+1adrYhKWfEg7Ubw9CyIstkNx6rPePd+MELheuSjJ4jpVwKKAaU69Pm0i4E
         oxThwMWb99qbdimO2bC3xbf2a0lC3V3UFW8ujasyfhViK2SmBAeP7RxPTqEdu/QZRK
         1p4PItQ/aOVvA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/5] arm64/mm: remap crash kernel with base pages even if rodata_full disabled
Date:   Fri, 19 Aug 2022 07:11:55 +0300
Message-Id: <20220819041156.873873-5-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220819041156.873873-1-rppt@kernel.org>
References: <20220819041156.873873-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

For server systems it is important to protect crash kernel memory for
post-mortem analysis. In order to protect this memory it should be mapped
at PTE level.

When CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled, usage of crash kernel
essentially forces mapping of the entire linear map with base pages even if
rodata_full is not set (commit 2687275a5843 ("arm64: Force
NO_BLOCK_MAPPINGS if crashkernel reservation is required")) and this causes
performance degradation.

With ZONE_DMA/DMA32 enabled, the crash kernel memory is reserved after
the linear map is created, but before multiprocessing and multithreading
are enabled, so it is safe to remap the crash kernel memory with base
pages as long as the page table entries that would be changed do not map
the memory that might be accessed during the remapping.

To ensure there are no memory accesses in the range that will be
remapped, align crash memory reservation to PUD_SIZE boundaries, remap
the entire PUD-aligned area and than free the memory that was allocated
beyond the crash_size requested by the user.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/mmu.h      |  3 ++
 arch/arm64/kernel/machine_kexec.c |  6 +++
 arch/arm64/mm/init.c              | 65 +++++++++++++++++++++++++------
 arch/arm64/mm/mmu.c               | 40 ++++++++++++++++---
 4 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 48f8466a4be9..aba3c095272e 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -71,6 +71,9 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
+extern int remap_crashkernel(phys_addr_t start, phys_addr_t size,
+			     phys_addr_t aligned_size);
+extern bool crashkres_protection_possible;
 
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 19c2d487cb08..68295403aa40 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -272,6 +272,9 @@ void arch_kexec_protect_crashkres(void)
 {
 	int i;
 
+	if (!crashkres_protection_possible)
+		return;
+
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
@@ -282,6 +285,9 @@ void arch_kexec_unprotect_crashkres(void)
 {
 	int i;
 
+	if (!crashkres_protection_possible)
+		return;
+
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a6585d50a76c..d5d647aaf23b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -40,6 +40,7 @@
 #include <asm/memory.h>
 #include <asm/numa.h>
 #include <asm/sections.h>
+#include <asm/set_memory.h>
 #include <asm/setup.h>
 #include <linux/sizes.h>
 #include <asm/tlb.h>
@@ -70,19 +71,19 @@ EXPORT_SYMBOL(memstart_addr);
  * crash kernel memory which has a dependency on arm64_dma_phys_limit.
  * Reserving memory early for crash kernel allows linear creation of block
  * mappings (greater than page-granularity) for all the memory bank rangs.
- * In this scheme a comparatively quicker boot is observed.
+ * In this scheme a comparatively quicker boot is observed and overall
+ * memory access via the linear map is more efficient as there is less TLB
+ * pressure.
  *
  * If ZONE_DMA configs are defined, crash kernel memory reservation
  * is delayed until DMA zone memory range size initialization performed in
  * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
- * memory range to avoid overlap allocation.  So crash kernel memory boundaries
- * are not known when mapping all bank memory ranges, which otherwise means
- * not possible to exclude crash kernel range from creating block mappings
- * so page-granularity mappings are created for the entire memory range.
- * Hence a slightly slower boot is observed.
- *
- * Note: Page-granularity mappings are necessary for crash kernel memory
- * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
+ * memory range to avoid overlap allocation.  To keep block mappings in the
+ * linear map, the first reservation attempt tries to allocate PUD-aligned
+ * region so that it would be possible to remap crash kernel memory with
+ * base pages.  If there is not enough memory for such extended reservation,
+ * the exact amount of memory is reserved and crash kernel protection is
+ * disabled.
  */
 #if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
@@ -90,6 +91,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+bool __ro_after_init crashkres_protection_possible;
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
@@ -116,6 +119,43 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 	return 0;
 }
 
+static unsigned long long __init
+reserve_remap_crashkernel(unsigned long long crash_base,
+			  unsigned long long crash_size,
+			  unsigned long long crash_max)
+{
+	unsigned long long size;
+
+	/*
+	 * If linear map uses base pages or there is no ZONE_DMA/ZONE_DMA32
+	 * the crashk_res will be mapped with PTEs in mmu::map_mem()
+	 */
+	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE) ||
+	    !have_zone_dma()) {
+		crashkres_protection_possible = true;
+		return 0;
+	}
+
+	if (crash_base)
+		return 0;
+
+	size = ALIGN(crash_size, PUD_SIZE);
+
+	crash_base = memblock_phys_alloc_range(size, PUD_SIZE, 0, crash_max);
+	if (!crash_base)
+		return 0;
+
+	if (remap_crashkernel(crash_base, crash_size, size)) {
+		memblock_phys_free(crash_base, size);
+		return 0;
+	}
+
+	crashkres_protection_possible = true;
+	memblock_phys_free(crash_base + crash_size, size - crash_size);
+
+	return crash_base;
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -162,8 +202,11 @@ static void __init reserve_crashkernel(void)
 	if (crash_base)
 		crash_max = crash_base + crash_size;
 
-	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
+	crash_base = reserve_remap_crashkernel(crash_base, crash_size,
+					       crash_max);
+	if (!crash_base)
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       crash_base, crash_max);
 	if (!crash_base) {
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 92267e5e9b5f..83f2f18f7f34 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -547,10 +547,8 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map) {
-		if (have_zone_dma())
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
+	if (crash_mem_map && !have_zone_dma()) {
+		if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
 			    resource_size(&crashk_res));
 	}
@@ -875,7 +873,7 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(pte));
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
+#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_KEXEC_CORE)
 static void free_hotplug_page_range(struct page *page, size_t size,
 				    struct vmem_altmap *altmap)
 {
@@ -1018,7 +1016,9 @@ static void unmap_range(unsigned long addr, unsigned long end,
 		unmap_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
+#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_KEXEC_CORE  */
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 				  unsigned long floor, unsigned long ceiling,
 				  unsigned long mask)
@@ -1263,6 +1263,36 @@ void vmemmap_free(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+int __init remap_crashkernel(phys_addr_t start, phys_addr_t size,
+			     phys_addr_t aligned_size)
+{
+#ifdef CONFIG_KEXEC_CORE
+	phys_addr_t end = start + size;
+	phys_addr_t aligned_end = start + aligned_size;
+
+	if (!IS_ALIGNED(start, PUD_SIZE) || !IS_ALIGNED(aligned_end, PUD_SIZE))
+		return -EINVAL;
+
+	/* Clear PUDs containing crash kernel memory */
+	unmap_range(__phys_to_virt(start), __phys_to_virt(aligned_end),
+		    false, NULL);
+
+	/* map crash kernel memory with base pages */
+	__create_pgd_mapping(swapper_pg_dir, start,  __phys_to_virt(start),
+			     size, PAGE_KERNEL, early_pgtable_alloc,
+			     NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS |
+			     NO_CONT_MAPPINGS);
+
+	/* map area from end of crash kernel to PUD end with large pages */
+	size = aligned_end - end;
+	if (size)
+		__create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
+				     size, PAGE_KERNEL, early_pgtable_alloc, 0);
+#endif
+
+	return 0;
+}
+
 static inline pud_t *fixmap_pud(unsigned long addr)
 {
 	pgd_t *pgdp = pgd_offset_k(addr);
-- 
2.35.3

