Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A24466688
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358977AbhLBPhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:37:18 -0500
Received: from 8bytes.org ([81.169.241.247]:37312 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347725AbhLBPhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:37:16 -0500
Received: from cap.home.8bytes.org (p5b006edb.dip0.t-ipconnect.de [91.0.110.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 16756DB4;
        Thu,  2 Dec 2021 16:33:51 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Date:   Thu,  2 Dec 2021 16:32:24 +0100
Message-Id: <20211202153226.22946-3-joro@8bytes.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202153226.22946-1-joro@8bytes.org>
References: <20211202153226.22946-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The AP bringup code uses the trampoline_pgd page-table, which
establishes global mappings in the user range of the address space.
Flush the global TLB entries after the indentity mappings are removed
so no stale entries remain in the TLB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/tlbflush.h |  5 +++++
 arch/x86/kernel/head64.c        |  2 ++
 arch/x86/kernel/head_64.S       | 19 ++++++++++++++++++-
 arch/x86/mm/tlb.c               |  8 ++------
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b587a9ee9cb2..98fa0a114074 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -261,4 +261,9 @@ extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 #endif /* !MODULE */
 
+static inline void __native_tlb_flush_global(unsigned long cr4)
+{
+	native_write_cr4(cr4 ^ X86_CR4_PGE);
+	native_write_cr4(cr4);
+}
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 3be9dd213dad..3890fe64ffff 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -485,6 +485,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* Kill off the identity-map trampoline */
 	reset_early_page_tables();
 
+	__native_tlb_flush_global(native_read_cr4());
+
 	clear_bss();
 
 	clear_page(init_top_pgt);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..9c63fc5988cd 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -166,9 +166,26 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	call	sev_verify_cbit
 	popq	%rsi
 
-	/* Switch to new page-table */
+	/*
+	 * Switch to new page-table
+	 *
+	 * For the boot CPU this switches to early_top_pgt which still has the
+	 * indentity mappings present. The secondary CPUs will switch to the
+	 * init_top_pgt here, away from the trampoline_pgd and unmap the
+	 * indentity mapped ranges.
+	 */
 	movq	%rax, %cr3
 
+	/*
+	 * Do a global TLB flush after the CR3 switch to make sure the TLB
+	 * entries from the identity mapping are flushed.
+	 */
+	movq	%cr4, %rcx
+	movq	%rcx, %rax
+	xorq	$X86_CR4_PGE, %rcx
+	movq	%rcx, %cr4
+	movq	%rax, %cr4
+
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 92bb03b9ceb5..a6cf56a14939 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1148,7 +1148,7 @@ void flush_tlb_one_user(unsigned long addr)
  */
 STATIC_NOPV void native_flush_tlb_global(void)
 {
-	unsigned long cr4, flags;
+	unsigned long flags;
 
 	if (static_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
@@ -1168,11 +1168,7 @@ STATIC_NOPV void native_flush_tlb_global(void)
 	 */
 	raw_local_irq_save(flags);
 
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	/* toggle PGE */
-	native_write_cr4(cr4 ^ X86_CR4_PGE);
-	/* write old PGE again and flush TLBs */
-	native_write_cr4(cr4);
+	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
 
 	raw_local_irq_restore(flags);
 }
-- 
2.34.0

