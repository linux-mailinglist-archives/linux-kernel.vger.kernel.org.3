Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E159F4C4ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiBYTb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:31:24 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B141D0365
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645817451; x=1677353451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eSGW2s8PYnkBw6oqwH9GaI0esxFTjo1HeCAQwqxJa4=;
  b=GxtCILqvBTZ5r4ils4qE9tGC6FwDOWAoLbGTMhYh/u8Pqpv/J2dLlb0J
   h5bOYf1piwc8dRUyVBVrLeAcuVEBB2gBVUwVpgTTDzfLP7ooT1NJUz1BU
   ZGCqWBjeqxk/taRWuScJ7TBCaYFLO6xLfS28fOEAHVU+G79zQzhDt8Zcx
   agSUkafkUn6VNgVbDUkrE53fwbNN1DDM26UBE7C/7N/gK3GkdY2a0NNJw
   +qilU3QrV/K52P7gkZlZNVCIDV5S2WXODVtnBzGTfNFnA809VcfHE4sna
   OD5xbnfVhg5UfmzWxdareGMiTZtoMzBQj6mbTyby7Xl9k6MHcHCFirzST
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313284511"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="313284511"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 11:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="592584070"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2022 11:30:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9387E94; Fri, 25 Feb 2022 21:30:59 +0200 (EET)
Date:   Fri, 25 Feb 2022 22:30:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCHv4 07/30] x86/traps: Add #VE support for TDX guest
Message-ID: <20220225193059.6zn6owzpbggxfqqv@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-8-kirill.shutemov@linux.intel.com>
 <c6ad42a0-ab19-befd-5760-2bcc992df732@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ad42a0-ab19-befd-5760-2bcc992df732@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:36:02AM -0800, Dave Hansen wrote:
> On 2/24/22 07:56, Kirill A. Shutemov wrote:
> > Virtualization Exceptions (#VE) are delivered to TDX guests due to
> > specific guest actions which may happen in either user space or the
> > kernel:
> > 
> >  * Specific instructions (WBINVD, for example)
> >  * Specific MSR accesses
> >  * Specific CPUID leaf accesses
> >  * Access to unmapped pages (EPT violation)
> 
> Considering that you're talking partly about userspace, it would be nice
> to talk about what "unmapped" really means here.

I'm not sure what you want to see here. Doesn't EPT violation describe it?

It can happen to userspace too, but we don't expect it to be use used and
SIGSEGV the process if it happens.

> > In the settings that Linux will run in, virtualization exceptions are
> > never generated on accesses to normal, TD-private memory that has been
> > accepted.
> 
> This is getting into nit territory.  But, at this point a normal reader
> has no idea what "accepted" memory is.

I will add: "(prepared to be used in the TD)". Okay?

> > @@ -58,6 +59,65 @@ static void get_info(void)
> >  	td_info.attributes = out.rdx;
> >  }
> >  
> > +void tdx_get_ve_info(struct ve_info *ve)
> > +{
> > +	struct tdx_module_output out;
> > +
> > +	/*
> > +	 * Retrieve the #VE info from the TDX module, which also clears the "#VE
> > +	 * valid" flag.  This must be done before anything else as any #VE that
> > +	 * occurs while the valid flag is set, i.e. before the previous #VE info
> > +	 * was consumed, is morphed to a #DF by the TDX module. 
> 
> 
> That's a really weird sentence.  It doesn't really parse for me.  It
> might be the misplaced comma after "consumed,".
> 
> For what it's worth, I think "i.e." and "e.g." have been over used in
> the TDX text (sorry Sean).  They lead to really weird sentence structure.
> 
> 								 Note, the TDX
> > +	 * module also treats virtual NMIs as inhibited if the #VE valid flag is
> > +	 * set, e.g. so that NMI=>#VE will not result in a #DF.
> > +	 */
> 
> Are we missing anything valuable if we just trim the comment down to
> something like:
> 
> 	/*
> 	 * Called during #VE handling to retrieve the #VE info from the
> 	 * TDX module.
>  	 *
> 	 * This should called done early in #VE handling.  A "nested"
> 	 * #VE which occurs before this will raise a #DF and is not
> 	 * recoverable.
> 	 */

This variant of the comment lost information about #VE-valid flag and
doesn't describe how NMI is inhibited.

Sean proposed this wording as reply to Thomas' questions:

http://lore.kernel.org/r/YfmlnJ6LS935AMS4@google.com

Do we need to keep the info?

> For what it's worth, I don't think we care who "morphs" things.  We just
> care about the fallout.
> 
> > +	tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
> 
> How about a one-liner below here:
> 
> 	/* Interrupts and NMIs can be delivered again. */
> 
> > +	ve->exit_reason = out.rcx;
> > +	ve->exit_qual   = out.rdx;
> > +	ve->gla         = out.r8;
> > +	ve->gpa         = out.r9;
> > +	ve->instr_len   = lower_32_bits(out.r10);
> > +	ve->instr_info  = upper_32_bits(out.r10);
> > +}
> > +
> > +/*
> > + * Handle the user initiated #VE.
> > + *
> > + * For example, executing the CPUID instruction from user space
> > + * is a valid case and hence the resulting #VE has to be handled.
> > + *
> > + * For dis-allowed or invalid #VE just return failure.
> > + */
> 
> This is just insane to have in the series at this point.  It says that
> the "#VE has to be handled" and then doesn't handle it!

I can't see why it's a big deal, but okay.

> > +static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> > +	return false;
> > +}
> > +
> > +/* Handle the kernel #VE */
> > +static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> > +	return false;
> > +}
> > +
> > +bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	bool ret;
> > +
> > +	if (user_mode(regs))
> > +		ret = virt_exception_user(regs, ve);
> > +	else
> > +		ret = virt_exception_kernel(regs, ve);
> > +
> > +	/* After successful #VE handling, move the IP */
> > +	if (ret)
> > +		regs->ip += ve->instr_len;
> > +
> > +	return ret;
> > +}
> 
> At this point in the series, these three functions can be distilled down to:
> 
> bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
> {
> 	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> 
> 	return false;
> }

I will do as you want, but I don't feel it is right.

The patch adds a little more infrastructure that makes following patches
cleaner.


> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +
> > +#define VE_FAULT_STR "VE fault"
> > +
> > +static void ve_raise_fault(struct pt_regs *regs, long error_code)
> > +{
> > +	if (user_mode(regs)) {
> > +		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
> > +		return;
> > +	}
> > +
> > +	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
> > +		return;
> > +
> > +	die_addr(VE_FAULT_STR, regs, error_code, 0);
> > +}
> > +
> > +/*
> > + * Virtualization Exceptions (#VE) are delivered to TDX guests due to
> > + * specific guest actions which may happen in either user space or the
> > + * kernel:
> > + *
> > + *  * Specific instructions (WBINVD, for example)
> > + *  * Specific MSR accesses
> > + *  * Specific CPUID leaf accesses
> > + *  * Access to unmapped pages (EPT violation)
> > + *
> > + * In the settings that Linux will run in, virtualization exceptions are
> > + * never generated on accesses to normal, TD-private memory that has been
> > + * accepted.
> 
> This actually makes a lot more sense as a code comment than changelog.
> It would be really nice to circle back here and actually refer to the
> functions that accept memory.

We don't have such functions at this point in the patchset. Do you want
the comment to be updated once we get them introduced?
> 
> > + * Syscall entry code has a critical window where the kernel stack is not
> > + * yet set up. Any exception in this window leads to hard to debug issues
> > + * and can be exploited for privilege escalation. Exceptions in the NMI
> > + * entry code also cause issues. Returning from the exception handler with
> > + * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> > + *
> > + * For these reasons, the kernel avoids #VEs during the syscall gap and
> > + * the NMI entry code. Entry code paths do not access TD-shared memory,
> > + * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> > + * that might generate #VE. VMM can remove memory from TD at any point,
> > + * but access to unaccepted (or missing) private memory leads to VM
> > + * termination, not to #VE.
> > + *
> > + * Similarly to page faults and breakpoints, #VEs are allowed in NMI
> > + * handlers once the kernel is ready to deal with nested NMIs.
> > + *
> > + * During #VE delivery, all interrupts, including NMIs, are blocked until
> > + * TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
> > + * the VE info.
> > + *
> > + * If a guest kernel action which would normally cause a #VE occurs in
> > + * the interrupt-disabled region before TDGETVEINFO, a #DF (fault
> > + * exception) is delivered to the guest which will result in an oops.
> > + */
> > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > +{
> > +	struct ve_info ve;
> > +
> > +	/*
> > +	 * NMIs/Machine-checks/Interrupts will be in a disabled state
> > +	 * till TDGETVEINFO TDCALL is executed. This ensures that VE
> > +	 * info cannot be overwritten by a nested #VE.
> > +	 */
> > +	tdx_get_ve_info(&ve);
> > +
> > +	cond_local_irq_enable(regs);
> > +
> > +	/*
> > +	 * If tdx_handle_virt_exception() could not process
> > +	 * it successfully, treat it as #GP(0) and handle it.
> > +	 */
> > +	if (!tdx_handle_virt_exception(regs, &ve))
> > +		ve_raise_fault(regs, 0);
> > +
> > +	cond_local_irq_disable(regs);
> > +}
> > +
> > +#endif
> > +
> >  #ifdef CONFIG_X86_32
> >  DEFINE_IDTENTRY_SW(iret_error)
> >  {
> 

-- 
 Kirill A. Shutemov
