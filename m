Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AED4CBC9B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiCCLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiCCLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685F1795F4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IohWcADSyrLcY0xycx9rxyokf4tptimeZa99EzTF0HM=; b=KVDgAyfls0U/n/Nq/uB/oWtdW4
        5C4GMSf3gW00sCXHjZ5JqQnlfB1p+O7GyfTALLs3KvCU4q7WV6KP7ZDMZneonXbqJx5sL+7PSw9qE
        +nBNoRCMUBHn96A2F7bzlrGLTX9JF+vT2rs+RvDZYfKNSWPh2vkxn636x8LtJpTmEfVwoe9sgqsOP
        rOnyr+lu5R11ne42EjpDF4ak2spwIHzgym29e37EY5QosdaJpw8IKZp0xtPJ+Oa4Bs78sXxXX/jBv
        G1s6pTg+UIx5RoPnBu1aj7EaDvnNF2R0Jfx3aW0Lg4WFLU8B7pvOqtvvCXstDer1uR3Y+7ov8yhTi
        h5lAqj9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeg-00BaGn-D8; Thu, 03 Mar 2022 11:29:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCD9D300813;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3897F3001BA99; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.496708326@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v3 09/39] x86/entry,xen: Early rewrite of restore_regs_and_return_to_kernel()
References: <20220303112321.422525803@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By doing an early rewrite of 'jmp native_iret` in
restore_regs_and_return_to_kernel() we can get rid of the last
INTERRUPT_RETURN user and paravirt_iret.

Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S             |   11 ++++++++---
 arch/x86/include/asm/irqflags.h       |    5 -----
 arch/x86/include/asm/paravirt_types.h |    1 -
 arch/x86/kernel/head_64.S             |    3 ++-
 arch/x86/kernel/paravirt.c            |    4 ----
 arch/x86/xen/enlighten_pv.c           |    7 ++++++-
 arch/x86/xen/xen-asm.S                |    1 +
 7 files changed, 17 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -609,7 +609,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 	/* Restore RDI. */
 	popq	%rdi
 	swapgs
-	jmp	native_iret
+	jmp	.Lnative_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
@@ -626,9 +626,14 @@ SYM_INNER_LABEL(restore_regs_and_return_
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
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -141,13 +141,8 @@ static __always_inline void arch_local_i
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
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -272,7 +272,6 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
-extern void (*paravirt_iret)(void);
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
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
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -132,8 +132,6 @@ void paravirt_set_sched_clock(u64 (*func
 }
 
 /* These are in entry.S */
-extern void native_iret(void);
-
 static struct resource reserve_ioports = {
 	.start = 0,
 	.end = IO_SPACE_LIMIT,
@@ -397,8 +395,6 @@ struct paravirt_patch_template pv_ops =
 
 #ifdef CONFIG_PARAVIRT_XXL
 NOKPROBE_SYMBOL(native_load_idt);
-
-void (*paravirt_iret)(void) = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1177,6 +1177,8 @@ static void __init xen_domu_set_legacy_f
 	x86_platform.legacy.rtc = 0;
 }
 
+extern void early_xen_iret_patch(void);
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(void)
 {
@@ -1187,6 +1189,10 @@ asmlinkage __visible void __init xen_sta
 	if (!xen_start_info)
 		return;
 
+	__text_gen_insn(&early_xen_iret_patch,
+			JMP32_INSN_OPCODE, &early_xen_iret_patch, &xen_iret,
+			JMP32_INSN_SIZE);
+
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
 
@@ -1195,7 +1201,6 @@ asmlinkage __visible void __init xen_sta
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
 	pv_ops.cpu = xen_cpu_ops.cpu;
-	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
 	/*
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -189,6 +189,7 @@ hypercall_iret = hypercall_page + __HYPE
  */
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)


