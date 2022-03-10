Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14FC4D538B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiCJVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbiCJVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:21:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF197340C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646947249; x=1678483249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GkefS9tKfG36UNYMqxOXQ4LmX3Ej+WznIlzayHQnEL8=;
  b=eKlaaHuVp+VGjadTf+4K90mePn6LVc2PumSV23YzFEm+HJMt4ECVMPlu
   wwLy3R/dxn9NSDLZOnnI1uJMpWBrPS0srZZUzGd1L2IqvzmQva1XfV+1T
   jMLnqn4PWySNJXMZaOFwhm6Kw1gVRoi1AJ58+sxVNuLSiily+Mdm2aDuk
   N/20fC7JYTi4OXr6knvLlI4yVABuLD2VbyGIdAtvM8XmVu/wUxn0hHbh3
   VP/BOIJjR2a5oojr59lMlpUELZCPwAtLYWtpP08qfUg8HFQQxZW0dXQK/
   Xq5DhT/rlVQFPNjIOU+zyARPrtu35D31D5CEUzxE2hTyMQfHPG1Ub2IJt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237555242"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237555242"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="496419886"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2022 13:20:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4E949107; Thu, 10 Mar 2022 23:20:59 +0200 (EET)
Date:   Fri, 11 Mar 2022 00:20:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220310212059.6abpmnsgodqqqnfm@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
 <YioZnTYahkoy2Mxz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YioZnTYahkoy2Mxz@zn.tnic>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 04:30:57PM +0100, Borislav Petkov wrote:
> On Wed, Mar 02, 2022 at 05:27:39PM +0300, Kirill A. Shutemov wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Guests communicate with VMMs with hypercalls. Historically, these
> > are implemented using instructions that are known to cause VMEXITs
> > like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
> > expose the guest state to the host. This prevents the old hypercall
> > mechanisms from working. So, to communicate with VMM, TDX
> > specification defines a new instruction called TDCALL.
> > 
> > In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> > layer -- TDX module -- facilitates secure communication between the host
> > and the guest. TDX module is loaded like a firmware into a special CPU
> > mode called SEAM. TDX guests communicate with the TDX module using the
> > TDCALL instruction.
> > 
> > A guest uses TDCALL to communicate with both the TDX module and VMM.
> > The value of the RAX register when executing the TDCALL instruction is
> > used to determine the TDCALL type. A variant of TDCALL used to communicate
> > with the VMM is called TDVMCALL.
> > 
> > Add generic interfaces to communicate with the TDX module and VMM
> > (using the TDCALL instruction).
> > 
> > __tdx_hypercall()    - Used by the guest to request services from the
> > 		       VMM (via TDVMCALL).
> > __tdx_module_call()  - Used to communicate with the TDX module (via
> > 		       TDCALL).
> 
> Ok, you need to fix this: this sounds to me like there are two insns:
> TDCALL and TDVMCALL. But there's only TDCALL.
> 
> And I'm not even clear on how the differentiation is done - I guess
> with %r11 which contains the VMCALL subfunction number in the
> __tdx_hypercall() case but I'm not sure.

TDVMCALL is a leaf of TDCALL. The leaf number is encoded in RAX: RAX==0 is
TDVMCALL.

I'm not completely sure what has to be fixed. Make it clear that TDVMCALL
is leaf of TDCALL? Something like this:

	__tdx_module_call()  - Used to communicate with the TDX module (via
			       TDCALL instruction).
	__tdx_hypercall()    - Used by the guest to request services from the
			       VMM (via TDVMCALL leaf of TDCALL).

?

> And when explaining this, pls put it in the comment over the function so
> that it is clear how the distinction is made.

But it's already there:

/*
 * __tdx_module_call()  - Used by TDX guests to request services from
 * the TDX module (does not include VMM services).
 *
 * Transforms function call register arguments into the TDCALL
 * register ABI.  After TDCALL operation, TDX module output is saved
 * in @out (if it is provided by the user)
 *
 ...
 */

and

/*
 * __tdx_hypercall() - Make hypercalls to a TDX VMM.
 *
 * Transforms values in  function call argument struct tdx_hypercall_args @args
 * into the TDCALL register ABI. After TDCALL operation, VMM output is saved
 * back in @args.
 *
 *-------------------------------------------------------------------------
 * TD VMCALL ABI:
 *-------------------------------------------------------------------------
 *
 * Input Registers:
 *
 * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
 .....
 */

Hm?

> > Also define an additional wrapper _tdx_hypercall(), which adds error
> > handling support for the TDCALL failure.
> > 
> > The __tdx_module_call() and __tdx_hypercall() helper functions are
> > implemented in assembly in a .S file.  The TDCALL ABI requires
> > shuffling arguments in and out of registers, which proved to be
> > awkward with inline assembly.
> > 
> > Just like syscalls, not all TDVMCALL use cases need to use the same
> > number of argument registers. The implementation here picks the current
> > worst-case scenario for TDCALL (4 registers). For TDCALLs with fewer
> > than 4 arguments, there will end up being a few superfluous (cheap)
> > instructions. But, this approach maximizes code reuse.
> > 
> > For registers used by the TDCALL instruction, please check TDX GHCI
> > specification, the section titled "TDCALL instruction" and "TDG.VP.VMCALL
> > Interface".
> > 
> > Based on previous patch by Sean Christopherson.
> > 
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/coco/Makefile        |   2 +-
> >  arch/x86/coco/tdcall.S        | 188 ++++++++++++++++++++++++++++++++++
> >  arch/x86/coco/tdx.c           |  18 ++++
> 
> Those should be
> 
> arch/x86/coco/tdx/tdcall.S
> arch/x86/coco/tdx/tdx.c
> 
> like we said:
> 
> "- confidential computing guest stuff: arch/x86/coco/{sev,tdx}"

Okay, will change. But it is not what we agreed about before:

https://lore.kernel.org/all/Yg5q742GsjCRHXZL@zn.tnic

> >  arch/x86/include/asm/tdx.h    |  27 +++++
> >  arch/x86/kernel/asm-offsets.c |  10 ++
> >  5 files changed, 244 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/x86/coco/tdcall.S
> 
> ...
> 
> > +SYM_FUNC_START(__tdx_hypercall)
> > +	FRAME_BEGIN
> > +
> > +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
> > +	push %r15
> > +	push %r14
> > +	push %r13
> > +	push %r12
> > +
> > +	/* Mangle function call ABI into TDCALL ABI: */
> > +	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
> > +	xor %eax, %eax
> > +
> > +	/* Copy hypercall registers from arg struct: */
> > +	movq TDX_HYPERCALL_r10(%rdi), %r10
> > +	movq TDX_HYPERCALL_r11(%rdi), %r11
> > +	movq TDX_HYPERCALL_r12(%rdi), %r12
> > +	movq TDX_HYPERCALL_r13(%rdi), %r13
> > +	movq TDX_HYPERCALL_r14(%rdi), %r14
> > +	movq TDX_HYPERCALL_r15(%rdi), %r15
> > +
> > +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> > +
> > +	tdcall
> > +
> > +	/*
> > +	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
> > +	 * something has gone horribly wrong with the TDX module.
> > +	 *
> > +	 * The return status of the hypercall operation is in a separate
> > +	 * register (in R10). Hypercall errors are a part of normal operation
> > +	 * and are handled by callers.
> > +	 */
> > +	testq %rax, %rax
> > +	jne .Lpanic
> 
> Hm, can this call a C function which does the panic so that a proper
> error message is dumped to the user so that at least she knows where the
> panic comes from?

Sure we can. But it would look somewhat clunky.
Wouldn't backtrace be enough for this (never to be seen) case?

So far the panic would look like this:

	invalid opcode: 0000 [#1] PREEMPT SMP
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc5-00181-geb9d1dde679a-dirty #1883
	RIP: 0010:__tdx_hypercall+0x6d/0x70
	Code: 00 00 74 17 4c 89 17 4c 89 5f 08 4c 89 67 10 4c 89 6f 18 4c 89 77 20 4c 89 7f 28 45 31 d2 45 31 db 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b 00 55 53 41 54 41 55 41 56 41 57 48 89 a7 98 1b 00 00 48 8b
	RSP: 0000:ffffffff82803e80 EFLAGS: 00010002
	RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000fc00
	RDX: ff11000004c3d448 RSI: 0000000000000002 RDI: ffffffff82803ea8
	RBP: ffffffff8283e840 R08: 0000000000000000 R09: 000000005eee98b1
	R10: 0000000000000000 R11: 000000000000000c R12: 0000000000000000
	R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
	FS:  0000000000000000(0000) GS:ff1100001c400000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ff1100001c9ff000 CR3: 0000000002834001 CR4: 0000000000771ef0
	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
	PKRU: 55555554
	Call Trace:
	 <TASK>
	 tdx_safe_halt+0x46/0x80
	 default_idle_call+0x4f/0x90
	 do_idle+0xeb/0x250
	 cpu_startup_entry+0x15/0x20
	 start_kernel+0x372/0x3d1
	 secondary_startup_64_no_verify+0xe5/0xeb
	 </TASK>

To me "invalid opcode" at "RIP: 0010:__tdx_hypercall+0x6d/0x70" is pretty
clear where it comes from, no?

> > +
> > +	/* TDVMCALL leaf return code is in R10 */
> > +	movq %r10, %rax
> > +
> > +	/* Copy hypercall result registers to arg struct if needed */
> > +	testq $TDX_HCALL_HAS_OUTPUT, %rsi
> > +	jz .Lout
> > +
> > +	movq %r10, TDX_HYPERCALL_r10(%rdi)
> > +	movq %r11, TDX_HYPERCALL_r11(%rdi)
> > +	movq %r12, TDX_HYPERCALL_r12(%rdi)
> > +	movq %r13, TDX_HYPERCALL_r13(%rdi)
> > +	movq %r14, TDX_HYPERCALL_r14(%rdi)
> > +	movq %r15, TDX_HYPERCALL_r15(%rdi)
> > +.Lout:
> > +	/*
> > +	 * Zero out registers exposed to the VMM to avoid speculative execution
> > +	 * with VMM-controlled values. This needs to include all registers
> > +	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
> > +	 * context will be restored.
> > +	 */
> > +	xor %r10d, %r10d
> > +	xor %r11d, %r11d
> > +
> > +	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> > +	pop %r12
> > +	pop %r13
> > +	pop %r14
> > +	pop %r15
> > +
> > +	FRAME_END
> > +
> > +	retq
> > +.Lpanic:
> > +	ud2
> > +SYM_FUNC_END(__tdx_hypercall)
> 
> ...
> 
> > diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> > index 7dca52f5cfc6..0b465e7d0a2f 100644
> > --- a/arch/x86/kernel/asm-offsets.c
> > +++ b/arch/x86/kernel/asm-offsets.c
> > @@ -74,6 +74,16 @@ static void __used common(void)
> >  	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
> >  	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
> >  
> > +#ifdef CONFIG_INTEL_TDX_GUEST
> 
> Those have ifdeffery around them - why don't the TDX_MODULE_* ones need
> it too?

I will drop the #ifdef. There's no harm in generating it for !TDX build.

> > +	BLANK();
> > +	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
> > +	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
> > +	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
> > +	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
> > +	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
> > +	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
> > +#endif
> > +
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
 Kirill A. Shutemov
