Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5646715E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349243AbhLCFOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:14:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48514 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349280AbhLCFOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:14:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C7CDB825B7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8FC53FD0;
        Fri,  3 Dec 2021 05:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508240;
        bh=j6qwodVLZiWt9IpyiJJj3SUWjAMFCthwug2fOloP0/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqTIyc9z96ALtOxRoJnCEOlxP/ZL6Xw7Hd/QCgWp405EdVaBoz5JiQiQ6i/vxp+Xj
         a3VtlCHlDgGwxs207HoKWG/Fc//q5xMzzCPzT2z0lKwKRPRyH4BHA+dGY6v389JdDr
         utTefIz+iBFD6vIUOvfWMvmojVZGvNcKYLBxzRZEg8nBlP1/43/7VdOqZ23BAyAxGL
         YP93jM4gn3zOfky/azAZ+8EClmQF7sSAdosN+8HIHIuxFP/NBAccQW+jojXMaf40Fa
         mqb/7Wrq0CyDbxfC2qOTKzDOTV8gyKuKOvtEB+tAp8e55VJ9qayW+H+pw87bKds3xk
         XfEUG0IFq3DNw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] riscv: mm: init: try best to remove #ifdef CONFIG_XIP_KERNEL usage
Date:   Fri,  3 Dec 2021 13:03:17 +0800
Message-Id: <20211203050317.2102-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203050317.2102-1-jszhang@kernel.org>
References: <20211203050317.2102-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the #ifdef CONFIG_XIP_KERNEL usage can be divided into the
following three types:

The first one is for functions/declarations only used in XIP case.

The second one is for XIP_FIXUP case. Something as below:
|foo_type foo;
|#ifdef CONFIG_XIP_KERNEL
|#define foo    (*(foo_type *)XIP_FIXUP(&foo))
|#endif

Usually, it's better to let the foo macro sit with the foo var
together. But if various foos are defined adjacently, we can
save some #ifdef CONFIG_XIP_KERNEL usage by grouping them together.

The third one is for different implementations for XIP, usually, this
is a #ifdef...#else...#endif case.

This patch moves the pt_ops macro to adjacent #ifdef CONFIG_XIP_KERNEL
and group first usage case into one.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4a9e3f429042..aeae7d6b2fee 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -40,10 +40,6 @@ EXPORT_SYMBOL(kernel_map);
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
-#ifdef CONFIG_XIP_KERNEL
-extern char _xiprom[], _exiprom[], __data_loc;
-#endif
-
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 							__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
@@ -227,10 +223,6 @@ static void __init setup_bootmem(void)
 #ifdef CONFIG_MMU
 static struct pt_alloc_ops pt_ops __initdata;
 
-#ifdef CONFIG_XIP_KERNEL
-#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
-#endif
-
 unsigned long riscv_pfn_base __ro_after_init;
 EXPORT_SYMBOL(riscv_pfn_base);
 
@@ -242,6 +234,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
+#define pt_ops			(*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
 #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
 #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
@@ -445,6 +438,8 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 }
 
 #ifdef CONFIG_XIP_KERNEL
+extern char _xiprom[], _exiprom[], __data_loc;
+
 /* called from head.S with MMU off */
 asmlinkage void __init __copy_data(void)
 {
-- 
2.34.1

