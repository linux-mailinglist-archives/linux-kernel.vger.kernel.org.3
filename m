Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA234E380D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiCVEpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiCVEo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:44:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AF70936
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B358CE0B22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8E0C340EC;
        Tue, 22 Mar 2022 04:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647924206;
        bh=ML/szU6I61ZPF0+phKwmVPit7UhMxQVw9B82pDw3soU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ofIufpjbMwTyGQoULbko+6OuDBS2w7zy8VSlKC6ydcvcU1MCgczQn3ugoeitf+KGn
         detrTlizm4bVybaJMrVvs4Uo2blzrjlVEzSBuYj8gtuu33H6kCLuAWoqx9223evuow
         OrKON2me5eds3WkSyxthimliRwqthxutcbSKkpbKqgJ2EkV+1WLoDwAWJ/p14aHFRK
         aKmPm/J3C3wRmeo9rRtBrHxAHArvgvwa7K8w57mkNAwNrGhDW9xozIJU+U66WoLPxw
         y+H9vk2LVe+mRZZUy32O5mjvxehWf8/x3RTK5Rn6ooieCmAc9OjfYOtKmoe4aND6K6
         Et3E/1YQXwWhA==
Date:   Tue, 22 Mar 2022 13:43:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 29/45] x86/ibt: Annotate text references
Message-Id: <20220322134320.1feda670153a7132f78ea417@kernel.org>
In-Reply-To: <20220308154318.877758523@infradead.org>
References: <20220308153011.021123062@infradead.org>
        <20220308154318.877758523@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022 16:30:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Annotate away some of the generic code references. This is things
> where we take the address of a symbol for exception handling or return
> addresses (eg. context switch).

Ah, I got it. I need this annotate lines for rethook too.

Thank you,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S            |    6 ++++++
>  arch/x86/entry/entry_64_compat.S     |    1 +
>  arch/x86/kernel/alternative.c        |   10 ++++++++--
>  arch/x86/kernel/head_64.S            |    4 ++++
>  arch/x86/kernel/kprobes/core.c       |    1 +
>  arch/x86/kernel/relocate_kernel_64.S |    2 ++
>  arch/x86/lib/error-inject.c          |    2 ++
>  arch/x86/lib/retpoline.S             |    1 +
>  8 files changed, 25 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -277,6 +277,7 @@ SYM_FUNC_END(__switch_to_asm)
>  .pushsection .text, "ax"
>  SYM_CODE_START(ret_from_fork)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR // copy_thread
>  	movq	%rax, %rdi
>  	call	schedule_tail			/* rdi: 'prev' task parameter */
>  
> @@ -569,6 +570,7 @@ SYM_CODE_END(\asmsym)
>  	.align 16
>  	.globl __irqentry_text_end
>  __irqentry_text_end:
> +	ANNOTATE_NOENDBR
>  
>  SYM_CODE_START_LOCAL(common_interrupt_return)
>  SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
> @@ -650,6 +652,7 @@ SYM_INNER_LABEL(early_xen_iret_patch, SY
>  #endif
>  
>  SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
> +	ANNOTATE_NOENDBR // exc_double_fault
>  	/*
>  	 * This may fault.  Non-paranoid faults on return to userspace are
>  	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
> @@ -744,6 +747,7 @@ SYM_FUNC_START(asm_load_gs_index)
>  	FRAME_BEGIN
>  	swapgs
>  .Lgs_change:
> +	ANNOTATE_NOENDBR // error_entry
>  	movl	%edi, %gs
>  2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
>  	swapgs
> @@ -1322,6 +1326,7 @@ SYM_CODE_START(asm_exc_nmi)
>  #endif
>  
>  repeat_nmi:
> +	ANNOTATE_NOENDBR // this code
>  	/*
>  	 * If there was a nested NMI, the first NMI's iret will return
>  	 * here. But NMIs are still enabled and we can take another
> @@ -1350,6 +1355,7 @@ SYM_CODE_START(asm_exc_nmi)
>  	.endr
>  	subq	$(5*8), %rsp
>  end_repeat_nmi:
> +	ANNOTATE_NOENDBR // this code
>  
>  	/*
>  	 * Everything below this point can be preempted by a nested NMI.
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -148,6 +148,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
>  	popfq
>  	jmp	.Lsysenter_flags_fixed
>  SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
> +	ANNOTATE_NOENDBR // is_sysenter_singlestep
>  SYM_CODE_END(entry_SYSENTER_compat)
>  
>  /*
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -713,6 +713,7 @@ asm (
>  "	.pushsection	.init.text, \"ax\", @progbits\n"
>  "	.type		int3_magic, @function\n"
>  "int3_magic:\n"
> +	ANNOTATE_NOENDBR
>  "	movl	$1, (%" _ASM_ARG1 ")\n"
>  	ASM_RET
>  "	.size		int3_magic, .-int3_magic\n"
> @@ -724,16 +725,19 @@ extern void int3_selftest_ip(void); /* d
>  static int __init
>  int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
>  {
> +	unsigned long selftest = (unsigned long)&int3_selftest_ip;
>  	struct die_args *args = data;
>  	struct pt_regs *regs = args->regs;
>  
> +	OPTIMIZER_HIDE_VAR(selftest);
> +
>  	if (!regs || user_mode(regs))
>  		return NOTIFY_DONE;
>  
>  	if (val != DIE_INT3)
>  		return NOTIFY_DONE;
>  
> -	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
> +	if (regs->ip - INT3_INSN_SIZE != selftest)
>  		return NOTIFY_DONE;
>  
>  	int3_emulate_call(regs, (unsigned long)&int3_magic);
> @@ -757,7 +761,9 @@ static void __init int3_selftest(void)
>  	 * then trigger the INT3, padded with NOPs to match a CALL instruction
>  	 * length.
>  	 */
> -	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
> +	asm volatile ("int3_selftest_ip:\n\t"
> +		      ANNOTATE_NOENDBR
> +		      "    int3; nop; nop; nop; nop\n\t"
>  		      : ASM_CALL_CONSTRAINT
>  		      : __ASM_SEL_RAW(a, D) (&val)
>  		      : "memory");
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -99,6 +99,7 @@ SYM_CODE_END(startup_64)
>  
>  SYM_CODE_START(secondary_startup_64)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR
>  	/*
>  	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
>  	 * and someone has loaded a mapped page table.
> @@ -127,6 +128,7 @@ SYM_CODE_START(secondary_startup_64)
>  	 */
>  SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR
>  
>  	/*
>  	 * Retrieve the modifier (SME encryption mask if SME is active) to be
> @@ -192,6 +194,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>  	jmp	*%rax
>  1:
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR // above
>  
>  	/*
>  	 * We must switch to a new descriptor in kernel space for the GDT
> @@ -299,6 +302,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>  	pushq	%rax		# target address in negative space
>  	lretq
>  .Lafter_lret:
> +	ANNOTATE_NOENDBR
>  SYM_CODE_END(secondary_startup_64)
>  
>  #include "verify_cpu.S"
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1033,6 +1033,7 @@ asm(
>  	".type __kretprobe_trampoline, @function\n"
>  	"__kretprobe_trampoline:\n"
>  #ifdef CONFIG_X86_64
> +	ANNOTATE_NOENDBR
>  	/* Push a fake return address to tell the unwinder it's a kretprobe. */
>  	"	pushq $__kretprobe_trampoline\n"
>  	UNWIND_HINT_FUNC
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -42,6 +42,7 @@
>  	.code64
>  SYM_CODE_START_NOALIGN(relocate_kernel)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR
>  	/*
>  	 * %rdi indirection_page
>  	 * %rsi page_list
> @@ -223,6 +224,7 @@ SYM_CODE_END(identity_mapped)
>  
>  SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR // RET target, above
>  	movq	RSP(%r8), %rsp
>  	movq	CR4(%r8), %rax
>  	movq	%rax, %cr4
> --- a/arch/x86/lib/error-inject.c
> +++ b/arch/x86/lib/error-inject.c
> @@ -3,6 +3,7 @@
>  #include <linux/linkage.h>
>  #include <linux/error-injection.h>
>  #include <linux/kprobes.h>
> +#include <linux/objtool.h>
>  
>  asmlinkage void just_return_func(void);
>  
> @@ -11,6 +12,7 @@ asm(
>  	".type just_return_func, @function\n"
>  	".globl just_return_func\n"
>  	"just_return_func:\n"
> +		ANNOTATE_NOENDBR
>  		ASM_RET
>  	".size just_return_func, .-just_return_func\n"
>  );
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -55,6 +55,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
>  
>  	.align RETPOLINE_THUNK_SIZE
>  SYM_CODE_START(__x86_indirect_thunk_array)
> +	ANNOTATE_NOENDBR // apply_retpolines
>  
>  #define GEN(reg) THUNK reg
>  #include <asm/GEN-for-each-reg.h>
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
