Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7F4B0018
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiBIWXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:23:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiBIWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:23:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA2C1DF838
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644445399; x=1675981399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIePjzTSWyUPsafB4+fq9WhRU47FretkSOf/I7YT+30=;
  b=K6d4dAYMY/BxNICrWDtlMbHs5YExxJfQ4OnVAK3+xWXjGo/23u16WAjj
   bUsaKbiix8YGW3TuhTAxopl/YNYp54An04f3snlvbh0tR53nXP4/bfIST
   NLemHO/i+tQP44hozMjsOgm2MJDOW/OS7B7/h2M0AJtwDIS3e9UXfn36/
   QR8pdJTZt2IDGVxUgydsxi0yuCInu9H5ljX2/6gilI+GOUifXUh8nC9H0
   oosq4DqxhSyy5WkiodF8RSc6qwCEXKuymx0l6yrQbfORNOoPrzh2pldMn
   SSgWiSGN/zwvNvbpzmxIAHwoUc5byagSGmUwKpcRHg3CiwpeU4Or8/WtN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232918671"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="232918671"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="500160486"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2022 14:23:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E9C8B107; Thu, 10 Feb 2022 00:23:27 +0200 (EET)
Date:   Thu, 10 Feb 2022 01:23:27 +0300
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
Message-ID: <20220209222327.5c2gv5owhhgzg2rs@black.fi.intel.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
 <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
 <875ypxur1n.ffs@tglx>
 <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
 <YgGioxo4hnJBJUgT@google.com>
 <20220209143407.by4s2h4zybfbvlhv@black.fi.intel.com>
 <YgQCgCx0R+RvFkyE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgQCgCx0R+RvFkyE@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 06:05:52PM +0000, Sean Christopherson wrote:
> On Wed, Feb 09, 2022, Kirill A. Shutemov wrote:
> > On Mon, Feb 07, 2022 at 10:52:19PM +0000, Sean Christopherson wrote:
> > .Lskip_sti:
> > 	tdcall
> > 
> > 	/*
> > 	 * TDVMCALL leaf does not suppose to fail. If it fails something
> > 	 * is horribly wrong with TDX module. Stop the world.
> > 	 */
> > 	test %rax, %rax
> > 	je .Lsuccess
> > 	ud2
> 
> If the ud2 or call to an external "do panic" helper is out-of-line, then the happy
> path avoids a taken branch.  Not a big deal, but it's also trivial to do.

Something like this?

I assume FRAME_END is irrelevent after UD2.

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
	 * For the idle loop STI needs to be called directly before the TDCALL
	 * that enters idle (EXIT_REASON_HLT case). STI instruction enables
	 * interrupts only one instruction later. If there is a window between
	 * STI and the instruction that emulates the HALT state, there is a
	 * chance for interrupts to happen in this window, which can delay the
	 * HLT operation indefinitely. Since this is the not the desired
	 * result, conditionally call STI before TDCALL.
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
	testq %rax, %rax
	jne .Lpanic

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
	 * Zero out registers exposed to the VMM to avoid speculative execution
	 * with VMM-controlled values. This needs to include all registers
	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
	 * context will be restored.
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
.Lpanic:
	ud2
SYM_FUNC_END(__tdx_hypercall)
-- 
 Kirill A. Shutemov
