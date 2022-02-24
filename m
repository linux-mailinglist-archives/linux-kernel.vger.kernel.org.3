Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AAA4C34D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiBXSgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiBXSgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:36:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944C23891E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645727768; x=1677263768;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=6PuI65FP0QBXguGkyBGxV1GDDvbru3iAPIL9PU340lw=;
  b=VYqiMg0cd8zRsRuHv66HHap3du8bgTJ8er5DRKyNZU+aJdXQWZIcVgTs
   kCWAxengCfj34a9MtoLHBYuwvpaMhtY0UhKiq2GniO+5l0NqFS0P4fmTI
   v46u5OdSFt2nn7dsfvPqylpCjGv1tKg33g5hW9llQOwqA6GOsr+YOU1Tm
   UfDw0mKiURLjEEf7htxaTiWoamnXMHBmwuMl3YtA6Gd1C4FsnRvUKNfLK
   4bbDVuZq2MHgGMR/cmvLJfgvMOYvc2FHzCANTkl7AQ5zaT0YUg8FZ3W2X
   iwcRuNDdHjelSiyGvJb8SaN+BK1UOXWBTbC+zMmsIJ8ALv2rXZzelcrqB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315536215"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315536215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 10:36:08 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548880175"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 10:36:07 -0800
Message-ID: <c6ad42a0-ab19-befd-5760-2bcc992df732@intel.com>
Date:   Thu, 24 Feb 2022 10:36:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-8-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220224155630.52734-8-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> Virtualization Exceptions (#VE) are delivered to TDX guests due to
> specific guest actions which may happen in either user space or the
> kernel:
> 
>  * Specific instructions (WBINVD, for example)
>  * Specific MSR accesses
>  * Specific CPUID leaf accesses
>  * Access to unmapped pages (EPT violation)

Considering that you're talking partly about userspace, it would be nice
to talk about what "unmapped" really means here.

> In the settings that Linux will run in, virtualization exceptions are
> never generated on accesses to normal, TD-private memory that has been
> accepted.

This is getting into nit territory.  But, at this point a normal reader
has no idea what "accepted" memory is.

> Syscall entry code has a critical window where the kernel stack is not
> yet set up. Any exception in this window leads to hard to debug issues
> and can be exploited for privilege escalation. Exceptions in the NMI
> entry code also cause issues. Returning from the exception handler with
> IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> 
> For these reasons, the kernel avoids #VEs during the syscall gap and
> the NMI entry code. Entry code paths do not access TD-shared memory,
> MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> that might generate #VE. VMM can remove memory from TD at any point,
> but access to unaccepted (or missing) private memory leads to VM
> termination, not to #VE.
> 
> Similarly to page faults and breakpoints, #VEs are allowed in NMI
> handlers once the kernel is ready to deal with nested NMIs.
> 
> During #VE delivery, all interrupts, including NMIs, are blocked until
> TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
> the VE info.
> 
> If a guest kernel action which would normally cause a #VE occurs in
> the interrupt-disabled region before TDGETVEINFO, a #DF (fault
> exception) is delivered to the guest which will result in an oops.
> 
> Add basic infrastructure to handle any #VE which occurs in the kernel
> or userspace. Later patches will add handling for specific #VE
> scenarios.
> 
> For now, convert unhandled #VE's (everything, until later in this
> series) so that they appear just like a #GP by calling the
> ve_raise_fault() directly. The ve_raise_fault() function is similar
> to #GP handler and is responsible for sending SIGSEGV to userspace
> and CPU die and notifying debuggers and other die chain users.
> 
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx.c             |  60 ++++++++++++++
>  arch/x86/include/asm/idtentry.h |   4 +
>  arch/x86/include/asm/tdx.h      |  21 +++++
>  arch/x86/kernel/idt.c           |   3 +
>  arch/x86/kernel/traps.c         | 138 ++++++++++++++++++++++++++------
>  5 files changed, 203 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> index 14c085930b5f..86a2f35e7308 100644
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -10,6 +10,7 @@
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
> +#define TDX_GET_VEINFO			3
>  
>  static struct {
>  	unsigned int gpa_width;
> @@ -58,6 +59,65 @@ static void get_info(void)
>  	td_info.attributes = out.rdx;
>  }
>  
> +void tdx_get_ve_info(struct ve_info *ve)
> +{
> +	struct tdx_module_output out;
> +
> +	/*
> +	 * Retrieve the #VE info from the TDX module, which also clears the "#VE
> +	 * valid" flag.  This must be done before anything else as any #VE that
> +	 * occurs while the valid flag is set, i.e. before the previous #VE info
> +	 * was consumed, is morphed to a #DF by the TDX module. 


That's a really weird sentence.  It doesn't really parse for me.  It
might be the misplaced comma after "consumed,".

For what it's worth, I think "i.e." and "e.g." have been over used in
the TDX text (sorry Sean).  They lead to really weird sentence structure.

								 Note, the TDX
> +	 * module also treats virtual NMIs as inhibited if the #VE valid flag is
> +	 * set, e.g. so that NMI=>#VE will not result in a #DF.
> +	 */

Are we missing anything valuable if we just trim the comment down to
something like:

	/*
	 * Called during #VE handling to retrieve the #VE info from the
	 * TDX module.
 	 *
	 * This should called done early in #VE handling.  A "nested"
	 * #VE which occurs before this will raise a #DF and is not
	 * recoverable.
	 */

For what it's worth, I don't think we care who "morphs" things.  We just
care about the fallout.

> +	tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);

How about a one-liner below here:

	/* Interrupts and NMIs can be delivered again. */

> +	ve->exit_reason = out.rcx;
> +	ve->exit_qual   = out.rdx;
> +	ve->gla         = out.r8;
> +	ve->gpa         = out.r9;
> +	ve->instr_len   = lower_32_bits(out.r10);
> +	ve->instr_info  = upper_32_bits(out.r10);
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

This is just insane to have in the series at this point.  It says that
the "#VE has to be handled" and then doesn't handle it!

> +static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +	return false;
> +}
> +
> +/* Handle the kernel #VE */
> +static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
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
> +		ret = virt_exception_user(regs, ve);
> +	else
> +		ret = virt_exception_kernel(regs, ve);
> +
> +	/* After successful #VE handling, move the IP */
> +	if (ret)
> +		regs->ip += ve->instr_len;
> +
> +	return ret;
> +}

At this point in the series, these three functions can be distilled down to:

bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
{
	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);

	return false;
}

>  void __init tdx_early_init(void)
>  {
>  	u32 eax, sig[3];
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 1345088e9902..8ccc81d653b3 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -625,6 +625,10 @@ DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
>  DECLARE_IDTENTRY_RAW(X86_TRAP_OTHER,	exc_xen_unknown_trap);
>  #endif
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +DECLARE_IDTENTRY(X86_TRAP_VE,		exc_virtualization_exception);
> +#endif
> +
>  /* Device interrupts common/spurious */
>  DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
>  #ifdef CONFIG_X86_LOCAL_APIC
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 557227e40da9..34cf998ad534 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -5,6 +5,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/init.h>
> +#include <asm/ptrace.h>
>  
>  #define TDX_CPUID_LEAF_ID	0x21
>  #define TDX_IDENT		"IntelTDX    "
> @@ -47,6 +48,22 @@ struct tdx_hypercall_args {
>  	u64 r15;
>  };
>  
> +/*
> + * Used by the #VE exception handler to gather the #VE exception
> + * info from the TDX module. This is a software only structure
> + * and not part of the TDX module/VMM ABI.
> + */
> +struct ve_info {
> +	u64 exit_reason;
> +	u64 exit_qual;
> +	/* Guest Linear (virtual) Address */
> +	u64 gla;
> +	/* Guest Physical (virtual) Address */
> +	u64 gpa;

"Physical (virtual) Address"?

> +	u32 instr_len;
> +	u32 instr_info;
> +};
> +
>  #ifdef CONFIG_INTEL_TDX_GUEST
>  
>  void __init tdx_early_init(void);
> @@ -58,6 +75,10 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>  /* Used to request services from the VMM */
>  u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
>  
> +void tdx_get_ve_info(struct ve_info *ve);
> +
> +bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };
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
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7ef00dee35be..b2510af38158 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -62,6 +62,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/vdso.h>
> +#include <asm/tdx.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -611,13 +612,43 @@ static bool try_fixup_enqcmd_gp(void)
>  #endif
>  }
>  
> +static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
> +				    unsigned long error_code, const char *str)
> +{
> +	int ret;
> +
> +	if (fixup_exception(regs, trapnr, error_code, 0))
> +		return true;
> +
> +	current->thread.error_code = error_code;
> +	current->thread.trap_nr = trapnr;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to trust the result
> +	 * from kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (!preemptible() && kprobe_running() &&
> +	    kprobe_fault_handler(regs, trapnr))
> +		return true;
> +
> +	ret = notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV);
> +	return ret == NOTIFY_STOP;
> +}
> +
> +static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
> +				   unsigned long error_code, const char *str)
> +{
> +	current->thread.error_code = error_code;
> +	current->thread.trap_nr = trapnr;
> +	show_signal(current, SIGSEGV, "", str, regs, error_code);
> +	force_sig(SIGSEGV);
> +}
> +
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
>  	enum kernel_gp_hint hint = GP_NO_HINT;
> -	struct task_struct *tsk;
>  	unsigned long gp_addr;
> -	int ret;
>  
>  	if (user_mode(regs) && try_fixup_enqcmd_gp())
>  		return;
> @@ -636,40 +667,21 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  		return;
>  	}
>  
> -	tsk = current;
> -
>  	if (user_mode(regs)) {
>  		if (fixup_iopl_exception(regs))
>  			goto exit;
>  
> -		tsk->thread.error_code = error_code;
> -		tsk->thread.trap_nr = X86_TRAP_GP;
> -
>  		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
>  			goto exit;
>  
> -		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
> -		force_sig(SIGSEGV);
> +		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
>  		goto exit;
>  	}
>  
>  	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
>  		goto exit;
>  
> -	tsk->thread.error_code = error_code;
> -	tsk->thread.trap_nr = X86_TRAP_GP;
> -
> -	/*
> -	 * To be potentially processing a kprobe fault and to trust the result
> -	 * from kprobe_running(), we have to be non-preemptible.
> -	 */
> -	if (!preemptible() &&
> -	    kprobe_running() &&
> -	    kprobe_fault_handler(regs, X86_TRAP_GP))
> -		goto exit;
> -
> -	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
> -	if (ret == NOTIFY_STOP)
> +	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
>  		goto exit;
>  
>  	if (error_code)
> @@ -1267,6 +1279,86 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  	}
>  }

I'm glad the exc_general_protection() code is getting refactored and not
copied.  That's nice.  The refactoring really needs to be in a separate
patch, though.

> +#ifdef CONFIG_INTEL_TDX_GUEST
> +
> +#define VE_FAULT_STR "VE fault"
> +
> +static void ve_raise_fault(struct pt_regs *regs, long error_code)
> +{
> +	if (user_mode(regs)) {
> +		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
> +		return;
> +	}
> +
> +	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
> +		return;
> +
> +	die_addr(VE_FAULT_STR, regs, error_code, 0);
> +}
> +
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

This actually makes a lot more sense as a code comment than changelog.
It would be really nice to circle back here and actually refer to the
functions that accept memory.

> + * Syscall entry code has a critical window where the kernel stack is not
> + * yet set up. Any exception in this window leads to hard to debug issues
> + * and can be exploited for privilege escalation. Exceptions in the NMI
> + * entry code also cause issues. Returning from the exception handler with
> + * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> + *
> + * For these reasons, the kernel avoids #VEs during the syscall gap and
> + * the NMI entry code. Entry code paths do not access TD-shared memory,
> + * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> + * that might generate #VE. VMM can remove memory from TD at any point,
> + * but access to unaccepted (or missing) private memory leads to VM
> + * termination, not to #VE.
> + *
> + * Similarly to page faults and breakpoints, #VEs are allowed in NMI
> + * handlers once the kernel is ready to deal with nested NMIs.
> + *
> + * During #VE delivery, all interrupts, including NMIs, are blocked until
> + * TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
> + * the VE info.
> + *
> + * If a guest kernel action which would normally cause a #VE occurs in
> + * the interrupt-disabled region before TDGETVEINFO, a #DF (fault
> + * exception) is delivered to the guest which will result in an oops.
> + */
> +DEFINE_IDTENTRY(exc_virtualization_exception)
> +{
> +	struct ve_info ve;
> +
> +	/*
> +	 * NMIs/Machine-checks/Interrupts will be in a disabled state
> +	 * till TDGETVEINFO TDCALL is executed. This ensures that VE
> +	 * info cannot be overwritten by a nested #VE.
> +	 */
> +	tdx_get_ve_info(&ve);
> +
> +	cond_local_irq_enable(regs);
> +
> +	/*
> +	 * If tdx_handle_virt_exception() could not process
> +	 * it successfully, treat it as #GP(0) and handle it.
> +	 */
> +	if (!tdx_handle_virt_exception(regs, &ve))
> +		ve_raise_fault(regs, 0);
> +
> +	cond_local_irq_disable(regs);
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_X86_32
>  DEFINE_IDTENTRY_SW(iret_error)
>  {

