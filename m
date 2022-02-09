Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1FA4AF42A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiBIOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiBIOd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:33:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6079C06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644417239; x=1675953239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XwGUoEwrb8jCLGTN0rsgOh/vRx6cpRdg+g96p0PvPnU=;
  b=YNsV/rHIhFwTUX/HrWcFx2yLtU+6Q48Ecifa+48kbtYEuva6vAS84L9m
   gGDqsMx9tZklCOAxgEvFX7V0NZaL7wSmO8tk4oUBxrHs+0QXNebC9tSX+
   0KRGzxWN1hWrxmiiWnf74DLz3t7N/icYoIcDe++EjiLOBjqoBVatTWbCG
   Dx5MchUdQ9U37WYGPsUGOt1lScFupBY7y0FDRntNAUyCbHv7SK4gej6W6
   a7AnTJDpM0pQlm9nQXd/fbKaS/CAjxdCUaTMXt+LgzrGkmUkOJUxVTvXo
   RfhLTVKFUOIo6swwGi1bpd++PlA5p9SjO77nWCWTMrmLbl1pcrfE6vR0e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236621840"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="236621840"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="771357661"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2022 06:33:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CA7F450D; Wed,  9 Feb 2022 16:34:07 +0200 (EET)
Date:   Wed, 9 Feb 2022 17:34:07 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
Message-ID: <20220209143407.by4s2h4zybfbvlhv@black.fi.intel.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
 <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
 <875ypxur1n.ffs@tglx>
 <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
 <YgGioxo4hnJBJUgT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgGioxo4hnJBJUgT@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 10:52:19PM +0000, Sean Christopherson wrote:
> On Fri, Feb 04, 2022, Kirill A. Shutemov wrote:
> > > > Looks dubious to me, I donno. I worry about possible conflicts with the
> > > > spec in the future.
> > > 
> > > The spec should have a reserved space for such things :)
> 
> Heh, the problem is someone has to deal with munging the two things together.
> E.g. if there's a EXIT_REASON_SAFE_HLT then the hypervisor would need a handler
> that's identical to EXIT_REASON_HLT, except with guest.EFLAGS.IF forced to '1'.
> The guest gets the short end of the stick because EXIT_REASON_HLT is already an
> established VM-Exit reason.
> 
> > > But you might think about having a in/out struct similar to the module
> > > call or just an array of u64.
> > > 
> > > and the signature would become:
> > > 
> > > __tdx_hypercall(u64 op, u64 flags, struct inout *args)
> > > __tdx_hypercall(u64 op, u64 flags, u64 *args)
> > > 
> > > and have flag bits:
> > > 
> > >     HCALL_ISSUE_STI
> > >     HCALL_HAS_OUTPUT
> > > 
> > > Hmm?
> > 
> > We have two distinct cases: standard hypercalls (defined in GHCI) and KVM
> > hypercalls. In the first case R10 is 0 (indicating standard TDVMCALL) and
> > R11 defines the operation. For KVM hypercalls R10 encodes the operation
> > (KVM hypercalls indexed from 1) and R11 is the first argument. So we
> > cannot get away with simple "RDI is op" interface.
> > 
> > And we need to return two values: RAX indicates if TDCALL itself was
> > successful and R10 is result of the hypercall. So we cannot easily get
> > away without output struct. HCALL_HAS_OUTPUT is not needed.
> 
> But __tdx_hypercall() should never fail TDCALL.  The TDX spec even says:
> 
>   RAX TDCALL instruction return code. Always returns Intel TDX_SUCCESS (0).
> 
> IIRC, the original PoC went straight to a ud2 if tdcall failed.  Why not do
> something similar?  That would get rid of the bajillion instances of:
> 
> 	if (__tdx_hypercall(...))
> 		panic("Hypercall fn %llu failed (Buggy TDX module!)\n", fn);

Okay, below is my take on it. Boot tested.

I used UD2 as a way to deal with it-never-heppens condition. Not sure if
it the right way, but stack trace looks useful and I see it being used for
CONFIG_DEBUG_ENTRY.

Any comments?

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
 * RCX                 - BITMAP which controls which part of TD Guest GPR
 *                       is passed as-is to the VMM and back.
 * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
 *                       specification. Non zero value indicates vendor
 *                       specific ABI.
 * R11                 - VMCALL sub function number
 * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
 * R8-R9, R12-R15      - Same as above.
 *
 * Output Registers:
 *
 * RAX                 - TDCALL instruction status (Not related to hypercall
 *                        output).
 * R10                 - Hypercall output error code.
 * R11-R15             - Hypercall sub function specific output values.
 *
 *-------------------------------------------------------------------------
 *
 * __tdx_hypercall() function ABI:
 *
 * @args  (RDI)        - struct tdx_hypercall_args for input and output
 * @flags (RSI)        - TDX_HCALL_* flags
 *
 * On successful completion, return the hypercall error code.
 */
SYM_FUNC_START(__tdx_hypercall)
	FRAME_BEGIN

	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
	push %r15
	push %r14
	push %r13
	push %r12

	/* Mangle function call ABI into TDCALL ABI: */
	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
	xor %eax, %eax

	/* Copy hypercall registers from arg struct: */
	movq TDX_HYPERCALL_r10(%rdi), %r10
	movq TDX_HYPERCALL_r11(%rdi), %r11
	movq TDX_HYPERCALL_r12(%rdi), %r12
	movq TDX_HYPERCALL_r13(%rdi), %r13
	movq TDX_HYPERCALL_r14(%rdi), %r14
	movq TDX_HYPERCALL_r15(%rdi), %r15

	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx

	/*
	 * For the idle loop STI needs to be called directly before
	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
	 * instruction enables interrupts only one instruction later.
	 * If there is a window between STI and the instruction that
	 * emulates the HALT state, there is a chance for interrupts to
	 * happen in this window, which can delay the HLT operation
	 * indefinitely. Since this is the not the desired result,
	 * conditionally call STI before TDCALL.
	 */
	testq $TDX_HCALL_ISSUE_STI, %rsi
	jz .Lskip_sti
	sti
.Lskip_sti:
	tdcall

	/*
	 * TDVMCALL leaf does not suppose to fail. If it fails something
	 * is horribly wrong with TDX module. Stop the world.
	 */
	test %rax, %rax
	je .Lsuccess
	ud2
.Lsuccess:
	/* TDVMCALL leaf return code is in R10 */
	movq %r10, %rax

	/* Copy hypercall result registers to arg struct if needed */
	testq $TDX_HCALL_HAS_OUTPUT, %rsi
	jz .Lout

	movq %r10, TDX_HYPERCALL_r10(%rdi)
	movq %r11, TDX_HYPERCALL_r11(%rdi)
	movq %r12, TDX_HYPERCALL_r12(%rdi)
	movq %r13, TDX_HYPERCALL_r13(%rdi)
	movq %r14, TDX_HYPERCALL_r14(%rdi)
	movq %r15, TDX_HYPERCALL_r15(%rdi)
.Lout:
	/*
	 * Zero out registers exposed to the VMM to avoid
	 * speculative execution with VMM-controlled values.
	 * This needs to include all registers present in
	 * TDVMCALL_EXPOSE_REGS_MASK (except R12-R15).
	 * R12-R15 context will be restored.
	 */
	xor %r10d, %r10d
	xor %r11d, %r11d

	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
	pop %r12
	pop %r13
	pop %r14
	pop %r15

	FRAME_END

	retq
SYM_FUNC_END(__tdx_hypercall)
-- 
 Kirill A. Shutemov
