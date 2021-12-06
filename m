Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7449469D86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386858AbhLFPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356251AbhLFPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:18:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13A2C08E840
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:11:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FFDA6133C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E6C341C1;
        Mon,  6 Dec 2021 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803477;
        bh=cID293rOgxjQk8NRLMzApK7etdJF34/NNMH4sm9IXMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWu8/JMImZoyUJs6SiSezgHt3fJjx8j+QwkTcrH+qv5XYo1Tp1aRa2ow/SGdQ1G26
         g+jHZ/q6QQjZPvvWbCUlBXjZ60egZbb4Yb2aXl3afUegX/qC7f7FNIFkn1M+KlHgIc
         I3ATyqm/DcCf0Y7ix4xEP8RvCZ0+SC+3MEMDwau2l9wuWrnWs7onUDHOGnhwv2r3GG
         Rj4qKGwov368I4/KNuAEeMHyfT+VnoPU4BRsRNFNW4IasebXlje/xdWOCxmoBj2f0T
         oHViHwfTSQ8KbBX8LtnbRG9H5uDrsAPHaOOKTSWUsyacvfh8zX+p95RzUHd/OfcdMT
         wCZpJ3H52p7UQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] riscv: mm: init: try best to remove #ifdef CONFIG_XIP_KERNEL usage
Date:   Mon,  6 Dec 2021 23:03:53 +0800
Message-Id: <20211206150353.731-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206150353.731-1-jszhang@kernel.org>
References: <20211206150353.731-1-jszhang@kernel.org>
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
and group first type usage cases into one.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5e979fe06054..a15640eeb334 100644
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

