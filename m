Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D04D2A17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiCIH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiCIH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B201662D4;
        Tue,  8 Mar 2022 23:55:11 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFKzDXARKxt5SDno5l7pzVPbB0R1mhbhOaQaeTyCQIU=;
        b=ktveffk4VMd+hnZ91O+GXNh0xqMw180wBEuEJ+93A3IT16HOkGq1f1r6vKwTFbv5XuGDXd
        fqUxiIbiJJUCdHEA6GCn7ADSz2/ezpScWKp8SHT20nzf8wAXrHb5XWRrSsRxDREbeo6NuQ
        /Tcr4Ix5VPWoCxg1ungrkPXZdGk1LNakK3hSdhBSAAxNfXE3I72dgbSdWSafdpQHWtt71f
        uIDq676DRDDWofbStwlp0f8akACaXoRieGWkOT6qDJrfdPr/jWFICWPKE8YUxegZmtp63a
        I9Ma9Tczlam11delV19IPD9HnxAPHp5ldwQCsW3PY20QekPy8HMIPbI1rc27CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFKzDXARKxt5SDno5l7pzVPbB0R1mhbhOaQaeTyCQIU=;
        b=qXjm3I1nT6XZ2TofQiIZd4gCCwzW+5bDR3KJUnSwP17lerGhtLjRkPZUwpJ9/nX5eHRUYK
        4Pz+UZIKZwUCtqCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry,xen: Early rewrite of
 restore_regs_and_return_to_kernel()
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.815039833@infradead.org>
References: <20220308154317.815039833@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250844.16921.10829088739924341450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5b96185120bf588023760ac5bc9a0c96faf671e1
Gitweb:        https://git.kernel.org/tip/5b96185120bf588023760ac5bc9a0c96faf671e1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:29 +01:00

x86/entry,xen: Early rewrite of restore_regs_and_return_to_kernel()

By doing an early rewrite of 'jmp native_iret` in
restore_regs_and_return_to_kernel() we can get rid of the last
INTERRUPT_RETURN user and paravirt_iret.

Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.815039833@infradead.org
---
 arch/x86/entry/entry_64.S             | 11 ++++++++---
 arch/x86/include/asm/irqflags.h       |  5 -----
 arch/x86/include/asm/paravirt_types.h |  1 -
 arch/x86/kernel/head_64.S             |  3 ++-
 arch/x86/kernel/paravirt.c            |  4 ----
 arch/x86/xen/enlighten_pv.c           |  7 ++++++-
 arch/x86/xen/xen-asm.S                |  1 +
 7 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 22e4e9a..f731393 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -609,7 +609,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	swapgs
-	jmp	native_iret
+	jmp	.Lnative_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
@@ -626,9 +626,14 @@ SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
 	 * when returning from IPI handler.
 	 */
-	INTERRUPT_RETURN
+#ifdef CONFIG_XEN_PV
+SYM_INNER_LABEL(early_xen_iret_patch, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	.byte 0xe9
+	.long .Lnative_iret - (. + 4)
+#endif
 
-SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
+.Lnative_iret:
 	UNWIND_HINT_IRET_REGS
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8776139..111104d 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -141,13 +141,8 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
 #define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#define INTERRUPT_RETURN						\
-	ANNOTATE_RETPOLINE_SAFE;					\
-	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
-		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
 #define SWAPGS	swapgs
-#define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index a69012e..7cd2874 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -272,7 +272,6 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
-extern void (*paravirt_iret)(void);
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9c63fc5..023761c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -345,7 +345,6 @@ SYM_CODE_START_NOALIGN(vc_boot_ghcb)
 	/* Remove Error Code */
 	addq    $8, %rsp
 
-	/* Pure iret required here - don't use INTERRUPT_RETURN */
 	iretq
 SYM_CODE_END(vc_boot_ghcb)
 #endif
@@ -426,6 +425,8 @@ SYM_CODE_END(early_idt_handler_common)
  * early_idt_handler_array can't be used because it returns via the
  * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.
  *
+ * XXX it does, fix this.
+ *
  * This handler will end up in the .init.text section and not be
  * available to boot secondary CPUs.
  */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 06af2cf..6ecbbb0 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -132,8 +132,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 }
 
 /* These are in entry.S */
-extern void native_iret(void);
-
 static struct resource reserve_ioports = {
 	.start = 0,
 	.end = IO_SPACE_LIMIT,
@@ -397,8 +395,6 @@ struct paravirt_patch_template pv_ops = {
 
 #ifdef CONFIG_PARAVIRT_XXL
 NOKPROBE_SYMBOL(native_load_idt);
-
-void (*paravirt_iret)(void) = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index d47c3d1..3c7a55c 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1177,6 +1177,8 @@ static void __init xen_domu_set_legacy_features(void)
 	x86_platform.legacy.rtc = 0;
 }
 
+extern void early_xen_iret_patch(void);
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(void)
 {
@@ -1187,6 +1189,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	if (!xen_start_info)
 		return;
 
+	__text_gen_insn(&early_xen_iret_patch,
+			JMP32_INSN_OPCODE, &early_xen_iret_patch, &xen_iret,
+			JMP32_INSN_SIZE);
+
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
 
@@ -1195,7 +1201,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
 	pv_ops.cpu = xen_cpu_ops.cpu;
-	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
 	/*
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index e730e62..ee17b94 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -189,6 +189,7 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  */
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
