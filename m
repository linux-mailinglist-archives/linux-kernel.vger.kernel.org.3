Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382394A66C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiBAVDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242725AbiBAVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:02:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9987C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:02:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643749362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBIro1WYlSD1gdQJnUKgX5Gh9EUyB2GskeGsqM61Tik=;
        b=BkFLOjstTT7vGtvaNZo5nLL40O1xziil8jvg6X/KbHGbPGcaTdLF3NHuwk/SAm2M6XmhwD
        0DaorCmQpTsgeNQ1OTkYXt0+hToP5l4DNSQY9DhsgM+lfG6x9280up3I9ORkWHvn1eM0Ic
        pwRIZ3BLoQ1oL/rCCMiRM2qlJZ3E79/2lwUch+K2B5WV+CJl8YbBE0KlU0VOLyLzu0GdH6
        Z/Nncxma7LyZuPbSWnnahXhsyBBoYhEV9eo83LHsHnZv3kBGnLyI3C81QCGfk6vQ2pDt8q
        CUwxJ2THeAHLwAbUAzJQ/9sTKHQPJtOAWjzZF6FsM5B5kQEKRS53B5RxoxDNTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643749362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBIro1WYlSD1gdQJnUKgX5Gh9EUyB2GskeGsqM61Tik=;
        b=mFcTKPuJSjhxA7UIK0Z8geptjnC9FmUR0JXYackV12qCS6vLm3m8NX6x4XBFjCmWiKsB2v
        j7psXw2cW7MUrrCg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCHv2 04/29] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220124150215.36893-5-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-5-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 22:02:41 +0100
Message-ID: <877daez4em.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index df0fa695bb09..1da074123c16 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -68,6 +68,9 @@ static const __initconst struct idt_data early_idts[] = {
>  	 */
>  	INTG(X86_TRAP_PF,		asm_exc_page_fault),
>  #endif
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> +#endif
>  
> +bool tdx_get_ve_info(struct ve_info *ve)
> +{
> +	struct tdx_module_output out;
> +
> +	/*
> +	 * NMIs and machine checks are suppressed. Before this point any
> +	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
> +	 * additional #VEs are permitted (but it is expected not to
> +	 * happen unless kernel panics).

I really do not understand that comment. #NMI and #MC are suppressed
according to the above. How long are they suppressed and what's the
mechanism? Are they unblocked on return from __tdx_module_call() ?

What prevents a nested #VE? If it happens what makes it fatal? Is it
converted to a #DF or detected by software?

Also I do not understand that the last sentence tries to tell me. If the
suppression of #NMI and #MC is lifted on return from tdcall then both
can be delivered immediately afterwards, right?

I assume the additional #VE is triggered by software or a bug in the
kernel.

Confused.

> +	 */
> +	if (__tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out))
> +		return false;
> +
> +	ve->exit_reason = out.rcx;
> +	ve->exit_qual   = out.rdx;
> +	ve->gla         = out.r8;
> +	ve->gpa         = out.r9;
> +	ve->instr_len   = lower_32_bits(out.r10);
> +	ve->instr_info  = upper_32_bits(out.r10);
> +
> +	return true;
> +}
> +
> +/*
> + * Handle the user initiated #VE.
> + *
> + * For example, executing the CPUID instruction from user space
> + * is a valid case and hence the resulting #VE has to be handled.
> + *
> + * For dis-allowed or invalid #VE just return failure.
> + */
> +static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +	return false;
> +}
> +
> +/* Handle the kernel #VE */
> +static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +	return false;
> +}
> +
> +bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	bool ret;
> +
> +	if (user_mode(regs))
> +		ret = tdx_virt_exception_user(regs, ve);
> +	else
> +		ret = tdx_virt_exception_kernel(regs, ve);
> +
> +	/* After successful #VE handling, move the IP */
> +	if (ret)
> +		regs->ip += ve->instr_len;
> +
> +	return ret;
> +}
> +
>  bool is_tdx_guest(void)
>  {
>  	return tdx_guest_detected;
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c9d566dcf89a..428504535912 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -61,6 +61,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/vdso.h>
> +#include <asm/tdx.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -1212,6 +1213,115 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  	}
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +
> +#define VE_FAULT_STR "VE fault"
> +
> +static void ve_raise_fault(struct pt_regs *regs, long error_code)
> +{
> +	struct task_struct *tsk = current;
> +
> +	if (user_mode(regs)) {
> +		tsk->thread.error_code = error_code;
> +		tsk->thread.trap_nr = X86_TRAP_VE;
> +		show_signal(tsk, SIGSEGV, "", VE_FAULT_STR, regs, error_code);
> +		force_sig(SIGSEGV);
> +		return;
> +	}
> +
> +	/*
> +	 * Attempt to recover from #VE exception failure without
> +	 * triggering OOPS (useful for MSR read/write failures)
> +	 */
> +	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
> +		return;
> +
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_VE;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to trust the result
> +	 * from kprobe_running(), it should be non-preemptible.
> +	 */
> +	if (!preemptible() && kprobe_running() &&
> +	    kprobe_fault_handler(regs, X86_TRAP_VE))
> +		return;
> +
> +	/* Notify about #VE handling failure, useful for debugger hooks */
> +	if (notify_die(DIE_GPF, VE_FAULT_STR, regs, error_code,
> +		       X86_TRAP_VE, SIGSEGV) == NOTIFY_STOP)
> +		return;
> +
> +	/* Trigger OOPS and panic */
> +	die_addr(VE_FAULT_STR, regs, error_code, 0);

This is pretty much a copy of the #GP handling. So why not consolidating
this properly?

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -559,6 +559,36 @@ static bool fixup_iopl_exception(struct
 	return true;
 }
 
+static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr, long error_code,
+				    const char *str)
+{
+	if (fixup_exception(regs, trapnr, error_code, 0))
+		return true;
+
+	current->thread.error_code = error_code;
+	current->thread.trap_nr = trapnr;
+
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), we have to be non-preemptible.
+	 */
+	if (!preemptible() && kprobe_running() &&
+	    kprobe_fault_handler(regs, trapnr))
+		return true;
+
+	ret = notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV);
+	return ret == NOTIFY_STOP;
+}
+
+static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr, long error_code,
+				   const char *str)
+{
+	current->thread.error_code = error_code;
+	current->thread.trap_nr = trapnr;
+	show_signal(current, SIGSEGV, "", str, regs, error_code);
+	force_sig(SIGSEGV);
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -587,34 +617,14 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 		if (fixup_iopl_exception(regs))
 			goto exit;
 
-		tsk->thread.error_code = error_code;
-		tsk->thread.trap_nr = X86_TRAP_GP;
-
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
-		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
-		force_sig(SIGSEGV);
+		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
 
-	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-		goto exit;
-
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = X86_TRAP_GP;
-
-	/*
-	 * To be potentially processing a kprobe fault and to trust the result
-	 * from kprobe_running(), we have to be non-preemptible.
-	 */
-	if (!preemptible() &&
-	    kprobe_running() &&
-	    kprobe_fault_handler(regs, X86_TRAP_GP))
-		goto exit;
-
-	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
-	if (ret == NOTIFY_STOP)
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
 		goto exit;
 
 	if (error_code)

which makes this:

static void ve_raise_fault(struct pt_regs *regs, long error_code)
{
	if (user_mode(regs)) {
		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
		return;
	}

	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR)
        	return;

	die_addr(VE_FAULT_STR, regs, error_code, 0);
}

Hmm?

> +/*
> + * Virtualization Exceptions (#VE) are delivered to TDX guests due to
> + * specific guest actions which may happen in either user space or the
> + * kernel:
> + *
> + *  * Specific instructions (WBINVD, for example)
> + *  * Specific MSR accesses
> + *  * Specific CPUID leaf accesses
> + *  * Access to unmapped pages (EPT violation)
> + *
> + * In the settings that Linux will run in, virtualization exceptions are
> + * never generated on accesses to normal, TD-private memory that has been
> + * accepted.
> + *
> + * Syscall entry code has a critical window where the kernel stack is not
> + * yet set up. Any exception in this window leads to hard to debug issues
> + * and can be exploited for privilege escalation. Exceptions in the NMI
> + * entry code also cause issues. Returning from the exception handler with
> + * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> + *
> + * For these reasons, the kernel avoids #VEs during the syscall gap and
> + * the NMI entry code. Entry code paths do not access TD-shared memory,
> + * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> + * that might generate #VE.

How is that enforced or validated? What checks for a violation of that
assumption?

Thanks,

        tglx
