Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6265846AB23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbhLFWBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:01:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbhLFWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:01:16 -0500
Date:   Mon, 06 Dec 2021 21:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638827866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTPdGZMD5UY1gbykrIkEd6xleaxmGhFRK/RKg3HBqJY=;
        b=FaWPlNSaxVLGFX1zt17yehuBzL4wd+4XNMyc6sckpZmA1OUz+f5sK3JY5ZL89N6vbgEZBX
        AZAP8C7sniuuF2uUSh8XbWAFO4K7guYkV5dVR8ORNLOmFZPvuNhSc2meR19zCwSQRvUZrp
        05xaHshwEP6PRoz/O04S1QkvsCWxnSz7GpEkNpOErDnih9/MppIv+Dg5HwTw3hmRhT7hV3
        /10yPjpjBLEaq/IedM2HOKQ9bwnlL4ttYisT5T3nIKGfYU48jZoytSSkxtoLr3H7R2kj7F
        WhWZt7uDheOvGIX0niDm5ztFkiKuTxMtm2FZ7AMxeZsHmknm3QrbPZBh2TPmrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638827866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTPdGZMD5UY1gbykrIkEd6xleaxmGhFRK/RKg3HBqJY=;
        b=C2STX/Fp5JoCyJq44sVNg7mREe7W9bWx01mpB8N2ZXIM4bYDBrSFxBCcefkAVUpD3O8/gn
        d3ldyDzGB8JeF8Dg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/64: Flush global TLB on boot and AP bringup
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211202153226.22946-3-joro@8bytes.org>
References: <20211202153226.22946-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <163882786538.11128.12165263540150571899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f154f290855b070cc94dd44ad253c0ef8a9337bb
Gitweb:        https://git.kernel.org/tip/f154f290855b070cc94dd44ad253c0ef8a9337bb
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 02 Dec 2021 16:32:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 06 Dec 2021 09:38:48 +01:00

x86/mm/64: Flush global TLB on boot and AP bringup

The AP bringup code uses the trampoline_pgd page-table which
establishes global mappings in the user range of the address space.
Flush the global TLB entries after the indentity mappings are removed so
no stale entries remain in the TLB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211202153226.22946-3-joro@8bytes.org
---
 arch/x86/include/asm/tlbflush.h |  5 +++++
 arch/x86/kernel/head64.c        |  2 ++
 arch/x86/kernel/head_64.S       | 19 ++++++++++++++++++-
 arch/x86/mm/tlb.c               |  8 ++------
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b587a9e..98fa0a1 100644
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
index fc5371a..75acb60 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -483,6 +483,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* Kill off the identity-map trampoline */
 	reset_early_page_tables();
 
+	__native_tlb_flush_global(native_read_cr4());
+
 	clear_bss();
 
 	clear_page(init_top_pgt);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd..9c63fc5 100644
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
index 59ba296..1e6513f 100644
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
