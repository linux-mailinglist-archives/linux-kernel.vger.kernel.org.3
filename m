Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982A567211
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiGEPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiGEPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733918E13
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B2661A74
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E85DC341CF;
        Tue,  5 Jul 2022 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657033343;
        bh=FLTWAi3TQAiX2oOWQsTB0NHrQ7KBrxSjL3BiVo1EjqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VicSeAlmzqAkpitwkh62i3dP8Br6BtRNl9m7WTCpYnhiij8SF5l8FrnKK7ZT6UEFv
         aiMc5P5ePELQBKfrUvre+MjZdZ5ix4opfqiTjWZWxOX3eW5f2gmkFjlPL6V+ZgssCT
         d3BBRycBnoK2MDeQNdSQWAQ6b19dxraUfbR/j4LHYDJcv7Fmc43yaei4d3bVKDtSxd
         DIK9nwhignS8qinuL/jjOTObZIq9pgWt8oj1KVDGqp7mkcflA/AXwDepTLd3Fm6gpW
         eep3YstTCxLDEzoYSJl2dbb/nPJQZgyWUL3Ls6U5E0Q/qL+bhPUS00tBfumnAW9rS4
         2pQbtQ6gwyA0Q==
Date:   Tue, 5 Jul 2022 18:02:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        linux-mm@kvack.org, yaohongbo@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsRSajyMxahXe7ZS@kernel.org>
References: <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705121115.GB1012@willie-the-truck>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:11:16PM +0100, Will Deacon wrote:
> On Tue, Jul 05, 2022 at 08:07:07PM +0800, guanghui.fgh wrote:
> > 
> > 3.When rodata full is disabled, crashkernel also need protect(keep
> > arch_kexec_[un]protect_crashkres using).
> > I think crashkernel should't depend on radata full(Maybe other architecture
> > don't support radata full now).
> 
> I think this is going round in circles :/
> 
> As a first step, can we please leave the crashkernel mapped unless
> rodata=full? It should be a much simpler patch to write, review and maintain
> and it gives you the performance you want when crashkernel is being used.

As it seems I failed to communicate my thoughts about reusing the existing
unmap_hotplug_range() to remap the crash kernel, let's try a more formal
approach ;-)

This is what I came up with and it does not look too complex. There are a
couple of extra #ifdefs that can be removed if we toss some code around in
a preparation patch.

From 5adbfcbe370da0f09cd917e73aaac7ba8c6b45df Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Sat, 2 Jul 2022 23:57:53 +0800
Subject: [PATCH] arm64/mm: remap crash kernel with base pages even if
 rodata_full disabled

For server systems it is important to protect crash kernel memory for
post-mortem analysis. In order to protect this memory it should be mapped
at PTE level.

When CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled, usage of crash kernel
essentially forces mapping of the entire linear map with base pages even if
rodata_full is not set (commit 2687275a5843 ("arm64: Force
NO_BLOCK_MAPPINGS if crashkernel reservation is required")) and this causes
performance degradation.

To reduce the performance degradation, postpone reservation of the crash
kernel memory to bootmem_init() regardless of CONFIG_ZONE_DMA or
CONFIG_ZONE_DMA32 and enable remapping of the crash kernel memory at PTE
level.

Co-developed-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/mmu.h |  1 +
 arch/arm64/mm/init.c         |  8 +---
 arch/arm64/mm/mmu.c          | 91 +++++++++++++++++++-----------------
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 48f8466a4be9..f4eb2f61dd0d 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
+extern void remap_crashkernel(void);
 
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 339ee84e5a61..51f8329931f8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -190,6 +190,7 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
+	remap_crashkernel();
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
index 626ec32873c6..e0b5769bfc9f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -483,21 +483,6 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
-
-static int __init enable_crash_mem_map(char *arg)
-{
-	/*
-	 * Proper parameter parsing is done by reserve_crashkernel(). We only
-	 * need to know if the linear map has to avoid block mappings so that
-	 * the crashkernel reservations can be unmapped later.
-	 */
-	crash_mem_map = true;
-
-	return 0;
-}
-early_param("crashkernel", enable_crash_mem_map);
-
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -527,17 +512,6 @@ static void __init map_mem(pgd_t *pgdp)
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
@@ -570,19 +544,6 @@ static void __init map_mem(pgd_t *pgdp)
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
@@ -827,7 +788,7 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(pte));
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
+#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_KEXEC_CORE)
 static void free_hotplug_page_range(struct page *page, size_t size,
 				    struct vmem_altmap *altmap)
 {
@@ -839,6 +800,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 	}
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 static void free_hotplug_pgtable_page(struct page *page)
 {
 	free_hotplug_page_range(page, PAGE_SIZE, NULL);
@@ -862,6 +824,7 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 		return false;
 	return true;
 }
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 				    unsigned long end, bool free_mapped,
@@ -994,7 +957,9 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
+#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 				 unsigned long end, unsigned long floor,
 				 unsigned long ceiling)
@@ -1148,7 +1113,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 }
-#endif
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 #if !ARM64_KERNEL_USES_PMD_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -1213,7 +1178,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 	unmap_hotplug_range(start, end, true, altmap);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
 }
-#endif /* CONFIG_MEMORY_HOTPLUG */
+#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_KEXEC_CORE */
 
 static inline pud_t *fixmap_pud(unsigned long addr)
 {
@@ -1677,3 +1642,45 @@ static int __init prevent_bootmem_remove_init(void)
 }
 early_initcall(prevent_bootmem_remove_init);
 #endif
+
+void __init remap_crashkernel(void)
+{
+#ifdef CONFIG_KEXEC_CORE
+	phys_addr_t start, end, size;
+	phys_addr_t aligned_start, aligned_end;
+
+	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
+	    return;
+
+	if (!crashk_res.end)
+	    return;
+
+	start = crashk_res.start & PAGE_MASK;
+	end = PAGE_ALIGN(crashk_res.end);
+
+	aligned_start = ALIGN_DOWN(crashk_res.start, PUD_SIZE);
+	aligned_end = ALIGN(end, PUD_SIZE);
+
+	/* Clear PUDs containing crash kernel memory */
+	unmap_hotplug_range(__phys_to_virt(aligned_start),
+			    __phys_to_virt(aligned_end), false, NULL);
+
+	/* map area from PUD start to start of crash kernel with large pages */
+	size = start - aligned_start;
+	__create_pgd_mapping(swapper_pg_dir, aligned_start,
+			     __phys_to_virt(aligned_start),
+			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
+
+	/* map crash kernel memory with base pages */
+	size = end - start;
+	__create_pgd_mapping(swapper_pg_dir, start,  __phys_to_virt(start),
+			     size, PAGE_KERNEL, early_pgtable_alloc,
+			     NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS |
+			     NO_CONT_MAPPINGS);
+
+	/* map area from end of crash kernel to PUD end with large pages */
+	size = aligned_end - end;
+	__create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
+			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
+#endif
+}
-- 
2.35.3

 
> Will

-- 
Sincerely yours,
Mike.
