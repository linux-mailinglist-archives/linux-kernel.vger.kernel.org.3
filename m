Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0C46715B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbhLCFOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbhLCFOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:14:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A4C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 21:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB05B81C9D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFE0C53FC7;
        Fri,  3 Dec 2021 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508233;
        bh=GRUArS/X3eAh9AGo4JeyzRPeIZX+Cg5bYN3qsljQ9hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhGkOhGQd7bLfaV35RgDZP6VwmyrAy/yABZAM1nq71EohUpE0VWdDL9Zn9+4FV2P+
         nowc0UGeb32pfWjLEvInSGeCV8TKsvo+rAWKLtqbyS4m/hmEpJZckK3QZMo05t4rvU
         Eo3f9G76GEAUUDu3UbeDFbDp9vuZAqaS/Nyw2T9bhscvtXZD0XlWnSPx/g/Agou/Oy
         2304C6fYYxU2rp8C/d6OGW5i63nxjNTCwDw/1dzfIkfiwW7YEol9ext0fzVcWjJ32p
         lGMaoDBaZAO6esJX+VoyX3AjW8f9nM4xPhH7CbWc5BfKpHUcQ5FRLKbH2RF4ffjPFM
         SIWfvFSgc+Mag==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] riscv: mm: init: try best to IS_ENABLED(CONFIG_64BIT) instead of #ifdef
Date:   Fri,  3 Dec 2021 13:03:14 +0800
Message-Id: <20211203050317.2102-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203050317.2102-1-jszhang@kernel.org>
References: <20211203050317.2102-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try our best to replace the conditional compilation using
"#ifdef CONFIG_64BIT" by a check for "IS_ENABLED(CONFIG_64BIT)", to
simplify the code and to increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 745f26a3b02e..bd445ac778a8 100644
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
@@ -616,13 +614,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
 	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
 
-#ifdef CONFIG_64BIT
 	/*
 	 * The last 4K bytes of the addressable memory can not be mapped because
 	 * of IS_ERR_VALUE macro.
 	 */
-	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
-#endif
+	if (IS_ENABLED(CONFIG_64BIT))
+		BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
 
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
@@ -735,10 +732,9 @@ static void __init setup_vm_final(void)
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

