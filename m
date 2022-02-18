Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3A4BBE1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiBRRPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiBRRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D74BFD8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xe8Yq7uSNoxx1oASjlF/vfkWUBNudy4owiQXejR6V3s=; b=qlPj6ox8ENRsQIvQirF6ojafew
        /puqbSBWcPXQEPoAVZ5YCF4+WL93ebkbvHCBXEOumPnjqDod/vdjL0tJRWl7MCus5dfm8dTxNbZbT
        /SoZPYWfakNZC8Zj2h2wExkz5Ta6f2TKTTzLnysJmzMDV6HpcZJ4IW6iG4LQCgfq1j6k+lZ1nYlii
        5ee9A8l1WK+k2mGDkmc92t2UqRoI2wr67SHlTs/1FMfxztp8kf4SZfHmz8xkysoeB98zC5RZQ9c+l
        3N+PdxfmlWb6x2iYi50fCYitRTFvnnRaZswHIGG7kaQmvGqxdoxuZBDG7ny68f3CgYh1I6deiLwJG
        CPXaPlEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBe-GW; Fri, 18 Feb 2022 17:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC6723017B1;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 49F2E20A9E7CD; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.579455015@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 17/29] x86/ibt: Annotate text references
References: <20220218164902.008644515@infradead.org>
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

Annotate away some of the generic code references. This is things
where we take the address of a symbol for exception handling or return
addresses (eg. context switch).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S            |    9 +++++++++
 arch/x86/entry/entry_64_compat.S     |    1 +
 arch/x86/kernel/alternative.c        |    4 +++-
 arch/x86/kernel/head_64.S            |    4 ++++
 arch/x86/kernel/kprobes/core.c       |    1 +
 arch/x86/kernel/relocate_kernel_64.S |    2 ++
 arch/x86/lib/error-inject.c          |    1 +
 arch/x86/lib/retpoline.S             |    2 ++
 10 files changed, 33 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -278,6 +278,7 @@ SYM_FUNC_END(__switch_to_asm)
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // copy_thread
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -564,12 +565,16 @@ SYM_CODE_END(\asmsym)
 	.align 16
 	.globl __irqentry_text_start
 __irqentry_text_start:
+	ANNOTATE_NOENDBR // unwinders
+	ud2;
 
 #include <asm/idtentry.h>
 
 	.align 16
 	.globl __irqentry_text_end
 __irqentry_text_end:
+	ANNOTATE_NOENDBR
+	ud2;
 
 SYM_CODE_START_LOCAL(common_interrupt_return)
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
@@ -647,6 +652,7 @@ SYM_INNER_LABEL_ALIGN(native_iret, SYM_L
 #endif
 
 SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR // exc_double_fault
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
@@ -741,6 +747,7 @@ SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
 .Lgs_change:
+	ANNOTATE_NOENDBR // error_entry
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
 	swapgs
@@ -1318,6 +1325,7 @@ SYM_CODE_START(asm_exc_nmi)
 #endif
 
 repeat_nmi:
+	ANNOTATE_NOENDBR // this code
 	/*
 	 * If there was a nested NMI, the first NMI's iret will return
 	 * here. But NMIs are still enabled and we can take another
@@ -1346,6 +1354,7 @@ SYM_CODE_START(asm_exc_nmi)
 	.endr
 	subq	$(5*8), %rsp
 end_repeat_nmi:
+	ANNOTATE_NOENDBR // this code
 
 	/*
 	 * Everything below this point can be preempted by a nested NMI.
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -148,6 +148,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR // is_sysenter_singlestep
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -713,6 +713,7 @@ asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
 "	.type		int3_magic, @function\n"
 "int3_magic:\n"
+	ANNOTATE_NOENDBR
 "	movl	$1, (%" _ASM_ARG1 ")\n"
 	ASM_RET
 "	.size		int3_magic, .-int3_magic\n"
@@ -757,7 +758,8 @@ static void __init int3_selftest(void)
 	 * then trigger the INT3, padded with NOPs to match a CALL instruction
 	 * length.
 	 */
-	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
+	asm volatile (ANNOTATE_NOENDBR
+		      "1: int3; nop; nop; nop; nop\n\t"
 		      ".pushsection .init.data,\"aw\"\n\t"
 		      ".align " __ASM_SEL(4, 8) "\n\t"
 		      ".type int3_selftest_ip, @object\n\t"
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -100,6 +100,7 @@ SYM_CODE_END(startup_64)
 
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
@@ -128,6 +129,7 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
@@ -193,6 +195,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // above
 
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
@@ -300,6 +303,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	pushq	%rax		# target address in negative space
 	lretq
 .Lafter_lret:
+	ANNOTATE_NOENDBR
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1023,6 +1023,7 @@ asm(
 	".type __kretprobe_trampoline, @function\n"
 	"__kretprobe_trampoline:\n"
 #ifdef CONFIG_X86_64
+	ANNOTATE_NOENDBR
 	/* Push a fake return address to tell the unwinder it's a kretprobe. */
 	"	pushq $__kretprobe_trampoline\n"
 	UNWIND_HINT_FUNC
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -42,6 +42,7 @@
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
 	 * %rsi page_list
@@ -215,6 +216,7 @@ SYM_CODE_END(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // RET target, above
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -11,6 +11,7 @@ asm(
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
+		ANNOTATE_NOENDBR
 		ASM_RET
 	".size just_return_func, .-just_return_func\n"
 );
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -12,6 +12,8 @@
 
 	.section .text.__x86.indirect_thunk
 
+	ANNOTATE_NOENDBR // apply_retpolines
+
 .macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call    .Ldo_rop_\@


