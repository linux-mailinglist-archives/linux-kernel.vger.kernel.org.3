Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6FC469CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhLFPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:24:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbhLFPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:14:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89AD8B8111E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89399C341C7;
        Mon,  6 Dec 2021 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803470;
        bh=PMuqe3y8e62TGMx9fT9SI7a0texE/fpdhxmGzV4QNBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adb9B8P7wG+P4wrqu85rqV3GqjOBN8bzPVgty4k6NmTXbBHxMV9CQaR3HT1c+L9g2
         FExw9UOrsJz9gL9MWTPkfliKJQyC51LMWZwCSR9eotpseIT6FS5mWeMPfXEPCDF/vx
         lrU75KGKtHjSuxYFJ2HPJeGOYH7U0CLMDKEL9o91BL3HuNa8opE42mj1moMN1x+FKR
         Y/cabVcsmWcODaqMCbcwXlKkPZ/dZ1Rg+iaXp/kjk/ojSFj9ZdXa6MIiAisYG2YW3l
         TxXVrHUHofZ1M4+dmn3inRZLcB3hEnuzX47njpV3XBW8tPrNeXS/VRPx1aOE6D/3hy
         10TMMYcFxfJMg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] riscv: mm: init: try best to use IS_ENABLED(CONFIG_64BIT) instead of #ifdef
Date:   Mon,  6 Dec 2021 23:03:50 +0800
Message-Id: <20211206150353.731-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206150353.731-1-jszhang@kernel.org>
References: <20211206150353.731-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try our best to replace the conditional compilation using
"#ifdef CONFIG_64BIT" by a check for "IS_ENABLED(CONFIG_64BIT)", to
simplify the code and to increase compile coverage.

Now we can also remove the __maybe_unused used in max_mapped_addr
declaration.

We also remove the BUG_ON check of mapping the last 4K bytes of the
addressable memory since this is always true for every kernel actually.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 745f26a3b02e..4edf5600bea9 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -102,10 +102,9 @@ static void __init print_vm_layout(void)
 		  (unsigned long)VMALLOC_END);
 	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
 		  (unsigned long)high_memory);
-#ifdef CONFIG_64BIT
-	print_mlm("kernel", (unsigned long)KERNEL_LINK_ADDR,
-		  (unsigned long)ADDRESS_SPACE_END);
-#endif
+	if (IS_ENABLED(CONFIG_64BIT))
+		print_mlm("kernel", (unsigned long)KERNEL_LINK_ADDR,
+			  (unsigned long)ADDRESS_SPACE_END);
 }
 #else
 static void print_vm_layout(void) { }
@@ -163,7 +162,7 @@ static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
-	phys_addr_t __maybe_unused max_mapped_addr;
+	phys_addr_t max_mapped_addr;
 	phys_addr_t phys_ram_end;
 
 #ifdef CONFIG_XIP_KERNEL
@@ -172,17 +171,16 @@ static void __init setup_bootmem(void)
 
 	memblock_enforce_memory_limit(memory_limit);
 
-	/*
-	 * Reserve from the start of the kernel to the end of the kernel
-	 */
-#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
 	/*
 	 * Make sure we align the reservation on PMD_SIZE since we will
 	 * map the kernel in the linear mapping as read-only: we do not want
 	 * any allocation to happen between _end and the next pmd aligned page.
 	 */
-	vmlinux_end = (vmlinux_end + PMD_SIZE - 1) & PMD_MASK;
-#endif
+	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+		vmlinux_end = (vmlinux_end + PMD_SIZE - 1) & PMD_MASK;
+	/*
+	 * Reserve from the start of the kernel to the end of the kernel
+	 */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 
@@ -190,7 +188,6 @@ static void __init setup_bootmem(void)
 #ifndef CONFIG_XIP_KERNEL
 	phys_ram_base = memblock_start_of_DRAM();
 #endif
-#ifndef CONFIG_64BIT
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
@@ -200,10 +197,11 @@ static void __init setup_bootmem(void)
 	 * address space is occupied by the kernel mapping then this check must
 	 * be done as soon as the kernel mapping base address is determined.
 	 */
-	max_mapped_addr = __pa(~(ulong)0);
-	if (max_mapped_addr == (phys_ram_end - 1))
-		memblock_set_current_limit(max_mapped_addr - 4096);
-#endif
+	if (!IS_ENABLED(CONFIG_64BIT)) {
+		max_mapped_addr = __pa(~(ulong)0);
+		if (max_mapped_addr == (phys_ram_end - 1))
+			memblock_set_current_limit(max_mapped_addr - 4096);
+	}
 
 	min_low_pfn = PFN_UP(phys_ram_base);
 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
@@ -616,14 +614,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
 	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
 
-#ifdef CONFIG_64BIT
-	/*
-	 * The last 4K bytes of the addressable memory can not be mapped because
-	 * of IS_ERR_VALUE macro.
-	 */
-	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
-#endif
-
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -735,10 +725,9 @@ static void __init setup_vm_final(void)
 		}
 	}
 
-#ifdef CONFIG_64BIT
 	/* Map the kernel */
-	create_kernel_page_table(swapper_pg_dir, false);
-#endif
+	if (IS_ENABLED(CONFIG_64BIT))
+		create_kernel_page_table(swapper_pg_dir, false);
 
 	/* Clear fixmap PTE and PMD mappings */
 	clear_fixmap(FIX_PTE);
-- 
2.34.1

