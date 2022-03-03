Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E594CBC8F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiCCLbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiCCLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C5DE2CC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mpCjoADIoPnQgLGsaJ1Aaii2CbzOUFmAORvOCmgJocE=; b=KVgjcWcJRZa9JBusmK8swi8WN6
        BXVubhN+Y8kYpZt3+rXHFkNI0PIDySTO0pZ8ULLmUgR4r9MqzkWTykU2AOWTM7DTQb92mkVY+Fowv
        3dMeWHoPW2khMhSARC5sLWPMHESRbvcbE+7bvbp+p3J02MyXMntucpY+tACHq3BCFr5dycdvMn/4s
        ewd8yenWhuipRTpSiTS9BTU/jkvGzOHiTHn9B5oNg4Bko+MjtLULInFo62Du8l2UUcmfphNdZDPTZ
        QLJ2oOCULl49ZQEUK4ZhwkDdzdTrEop7/OgpVjiI8pMUfM3cAlFCtLACe+02QPpco/uf+Hk44qr0V
        uEzSI5Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeg-00EtpV-Dg; Thu, 03 Mar 2022 11:29:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1DBB300E6E;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3A9B73001EF46; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.557993225@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 10/39] x86/ibt,xen: Sprinkle the ENDBR
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

Even though Xen currently doesn't advertise IBT, prepare for when it
will eventually do so and sprinkle the ENDBR dust accordingly.

Even though most of the entry points are IRET like, the CPL0
Hypervisor can set WAIT-FOR-ENDBR and demand ENDBR at these sites.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S      |    1 +
 arch/x86/include/asm/segment.h |    2 +-
 arch/x86/kernel/head_64.S      |    1 +
 arch/x86/xen/enlighten_pv.c    |    3 +++
 arch/x86/xen/xen-asm.S         |    9 +++++++++
 arch/x86/xen/xen-head.S        |    8 ++++++--
 6 files changed, 21 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -809,6 +809,7 @@ SYM_CODE_END(exc_xen_hypervisor_callback
  */
 SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
 	jne	1f
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -283,7 +283,7 @@ static inline void vdso_read_cpunode(uns
  * pop %rcx; pop %r11; jmp early_idt_handler_array[i]; summing up to
  * max 8 bytes.
  */
-#define XEN_EARLY_IDT_HANDLER_SIZE 8
+#define XEN_EARLY_IDT_HANDLER_SIZE (8 + ENDBR_INSN_SIZE)
 
 #ifndef __ASSEMBLY__
 
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -383,6 +383,7 @@ SYM_CODE_START(early_idt_handler_array)
 	.endr
 	UNWIND_HINT_IRET_REGS offset=16
 SYM_CODE_END(early_idt_handler_array)
+	ANNOTATE_NOENDBR // early_idt_handler_array[NUM_EXCEPTION_VECTORS]
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -624,6 +624,9 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
 	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
+#ifdef CONFIG_X86_KERNEL_IBT
+	TRAP_ENTRY(exc_control_protection,		false ),
+#endif
 };
 
 static bool __ref get_trap_addr(void **addr, unsigned int ist)
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -122,6 +122,7 @@ SYM_FUNC_END(xen_read_cr2_direct);
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pop %rcx
 	pop %r11
 	jmp  \name
@@ -147,6 +148,9 @@ xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
+#ifdef CONFIG_X86_KERNEL_IBT
+xen_pv_trap asm_exc_control_protection
+#endif
 #ifdef CONFIG_X86_MCE
 xen_pv_trap asm_xenpv_exc_machine_check
 #endif /* CONFIG_X86_MCE */
@@ -162,6 +166,7 @@ SYM_CODE_START(xen_early_idt_handler_arr
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pop %rcx
 	pop %r11
 	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
@@ -231,6 +236,7 @@ SYM_CODE_END(xenpv_restore_regs_and_retu
 /* Normal 64-bit system call target */
 SYM_CODE_START(xen_syscall_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	popq %rcx
 	popq %r11
 
@@ -250,6 +256,7 @@ SYM_CODE_END(xen_syscall_target)
 /* 32-bit compat syscall target */
 SYM_CODE_START(xen_syscall32_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	popq %rcx
 	popq %r11
 
@@ -267,6 +274,7 @@ SYM_CODE_END(xen_syscall32_target)
 /* 32-bit compat sysenter target */
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
 	 * that we don't need to guard against single step exceptions here.
@@ -290,6 +298,7 @@ SYM_CODE_END(xen_sysenter_target)
 SYM_CODE_START(xen_syscall32_target)
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -25,8 +25,11 @@
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		RET
+		ANNOTATE_NOENDBR
+		/*
+		 * Xen will write the hypercall page, and sort out ENDBR.
+		 */
+		.skip 32, 0xcc
 	.endr
 
 #define HYPERCALL(n) \
@@ -74,6 +77,7 @@ SYM_CODE_END(startup_xen)
 .pushsection .text
 SYM_CODE_START(asm_cpu_bringup_and_idle)
 	UNWIND_HINT_EMPTY
+	ENDBR
 
 	call cpu_bringup_and_idle
 SYM_CODE_END(asm_cpu_bringup_and_idle)


