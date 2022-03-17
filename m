Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C671F4DCC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiCQRfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiCQRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:34:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C43C6273
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647538422; x=1679074422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNwiwIUY0uAOV3LlaOV63of/vALR0LotvbEFYagaKRU=;
  b=T5sUuimysjPm7Mbh9IGyroP1gHVygtg0OnBLuydEJkfXCjyDtZPq3s47
   Nk8axG7OBT1Kldd8MZD2F5CjB2hOz0QnRqN3eZkOi6E25T84OrzWp7xL4
   uyl3/JFiSJkrPulpZENmX6lX02Xa39nbofqyhwZBhLIuhRphk3isfpOcY
   3Vp6QBl3C5LBxdQn8MMwo8nfIIRmi3DOMRpIPsaKLx3GkWG8xoqRxmNNz
   MsALceZhExLcOuYirtWkEFLJ9arkCSiM8M/52wMMpGUmFAtfCohpN1IWr
   6i3FJUJFSqJKiU1VBuNxUOF41PcQSMJhdaqWuzWB6S/bW7nHf+O/tICL/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256657534"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256657534"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="513506123"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2022 10:33:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DB654107; Thu, 17 Mar 2022 19:33:54 +0200 (EET)
Date:   Thu, 17 Mar 2022 20:33:54 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
Message-ID: <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d8t2ykp.ffs@tglx>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:48:54AM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> Hmm?

Does the changed version below address your concerns?

	void tdx_get_ve_info(struct ve_info *ve)
	{
		struct tdx_module_output out;

		/*
		 * Called during #VE handling to retrieve the #VE info from the
		 * TDX module.
		 *
		 * This has to be called early in #VE handling.  A "nested" #VE which
		 * occurs before this will raise a #DF and is not recoverable.
		 *
		 * The call retrieves the #VE info from the TDX module, which also
		 * clears the "#VE valid" flag. This must be done before anything else
		 * because any #VE that occurs while the valid flag is set will lead to
		 * #DF.
		 *
		 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
		 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
		 */
		tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);

		/* Transfer the output parameters */
		ve->exit_reason = out.rcx;
		ve->exit_qual   = out.rdx;
		ve->gla         = out.r8;
		ve->gpa         = out.r9;
		ve->instr_len   = lower_32_bits(out.r10);
		ve->instr_info  = upper_32_bits(out.r10);
	}

> > +/*
> > + * Virtualization Exceptions (#VE) are delivered to TDX guests due to
> > + * specific guest actions which may happen in either user space or the
> > + * kernel:
> > + *
> > + *  * Specific instructions (WBINVD, for example)
> > + *  * Specific MSR accesses
> > + *  * Specific CPUID leaf accesses
> > + *  * Access to specific guest physical addresses
> > + *
> > + * In the settings that Linux will run in, virtualization exceptions are
> > + * never generated on accesses to normal, TD-private memory that has been
> > + * accepted.
> > + *
> > + * Syscall entry code has a critical window where the kernel stack is not
> > + * yet set up. Any exception in this window leads to hard to debug issues
> > + * and can be exploited for privilege escalation. Exceptions in the NMI
> > + * entry code also cause issues. Returning from the exception handler with
> > + * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> > + *
> > + * For these reasons, the kernel avoids #VEs during the syscall gap and
> > + * the NMI entry code. Entry code paths do not access TD-shared memory,
> > + * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> > + * that might generate #VE.
> 
> I asked that before:
> 
>   "How is that enforced or validated? What checks for a violation of that
>    assumption?"
> 
> This is still exactly the same comment which is based on testing which
> did not yet explode in your face, right?

[ Disclaimer: I have limited understanding of the entry code complexity
  and may miss some crucial details. But I try my best. ]

Yes, it is the same comment, but it is based on code audit, not only on
testing.

I claim that kernel does not do anything that can possibly trigger #VE
where kernel cannot deal with it:

 - on syscall entry code before kernel stack is set up (few instructions
   in the beginning of entry_SYSCALL_64())

 - in NMI entry code (asm_exc_nmi()) before NMI nesting is safe:
   + for NMI from user mode, before switched to thread stack
   + for NMI from kernel, up to end_repead_nmi

After that points #VE is safe.

> So what's the point of this blurb? Create expectations which are not
> accountable?

I don't have such intentions.

> The point is that any #VE in such a code path is fatal and you better
> come up with some reasonable explanation why this is not the case in
> those code pathes and how a potential violation of that assumption might
> be detected especially in rarely used corner cases. If such a violation
> is not detectable by audit, CI, static code analysis or whatever then
> document the consequences instead of pretending that the problem does
> not exist and the kernel is perfect today and forever.

It is detectable by audit. The critical windows very limited and located
in the highly scrutinized entry code. But, yes, I cannot guarantee that
this code will be perfect forever.

Consequences of #VE in these critical windows are mentioned in the
comment:

	Any exception in this window leads to hard to debug issues and can
	be exploited for privilege escalation. 

I have hard time understanding what I has to change here. Do you want
details of audit to be documented? Make consequences of #VE at the wrong
point to be more prominent in the comment? 

-- 
 Kirill A. Shutemov
