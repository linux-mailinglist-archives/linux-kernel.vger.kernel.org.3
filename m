Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5E4A86C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiBCOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:43:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:57977 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbiBCOn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899436; x=1675435436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rf7d7hjbBV4Euh2zuCrWyHzLrR1BEWDgHZf024fkBuY=;
  b=jjPNP0vuFjIQh5dKeEpS1qN1sGfttwJOEHiGhyMlugrxFnuLbrVDqlzN
   Xue24HRA/7vtyClTCsW2utGxMujalItvgTfvQXCzjkWoxp6V+ZwmmPv+8
   ELugdJzWQPpucPDM1SF9OjK1IfsjzGzlK3hmLFlVlf6kvqAhIG8wNcV1r
   fADrJz7SYgLfMEVKjZUQR2cRaRFFb9gfwTspk+obk/yZh45rBKOSY5qFA
   WowqeHyfdScA6UUdHC8+rlBVZPS75XBNlGd9gM6fvQThLlI7+FaHoQ6yT
   +4xn1LsY8MULTtZvuNWQy8lD9EeuE75VbRwGyWBKl+qDvn3NU5LjAKcvD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245749211"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="245749211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="566418939"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2022 06:43:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C0C6B204; Thu,  3 Feb 2022 16:44:03 +0200 (EET)
Date:   Thu, 3 Feb 2022 17:44:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kai Huang <kai.huang@linux.intel.com>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
 <87a6faz7cs.ffs@tglx>
 <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
 <20220202235910.c512857813ea5b14aa73267f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202235910.c512857813ea5b14aa73267f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 11:59:10PM +1300, Kai Huang wrote:
> 
> >  /*
> > diff --git a/arch/x86/kernel/tdxcall.S b/arch/x86/kernel/tdxcall.S
> > new file mode 100644
> > index 000000000000..ba5e8e35de36
> > --- /dev/null
> > +++ b/arch/x86/kernel/tdxcall.S
> > @@ -0,0 +1,76 @@
> > +#include <asm/asm-offsets.h>
> > +
> > +/*
> > + * TDX guests use the TDCALL instruction to make requests to the
> > + * TDX module and hypercalls to the VMM.
> > + *
> > + * TDX host user SEAMCALL instruction to make requests to TDX module.
> > + *
> > + * They are supported in Binutils >= 2.36.
> > + */
> > +#define tdcall		.byte 0x66,0x0f,0x01,0xcc
> > +#define seamcall	.byte 0x66,0x0f,0x01,0xcf
> > +
> > +.macro TDX_MODULE_CALL host:req
> > +	/*
> > +	 * R12 will be used as temporary storage for struct tdx_module_output
> > +	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
> > +	 * services supported by this function, it can be reused.
> > +	 */
> > +
> > +	/* Callee saved, so preserve it */
> > +	push %r12
> > +
> > +	/*
> > +	 * Push output pointer to stack.
> > +	 * After the operation, it will be fetched into R12 register.
> > +	 */
> > +	push %r9
> > +
> > +	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
> > +	/* Move Leaf ID to RAX */
> > +	mov %rdi, %rax
> > +	/* Move input 4 to R9 */
> > +	mov %r8,  %r9
> > +	/* Move input 3 to R8 */
> > +	mov %rcx, %r8
> > +	/* Move input 1 to RCX */
> > +	mov %rsi, %rcx
> > +	/* Leave input param 2 in RDX */
> 
> Currently host seamcall also uses a data structure which has all possible input
> registers as input argument, rather than having one argument for each register:
> 
> 	struct seamcall_regs_in {
> 		u64 rcx;
> 		u64 rdx;
> 		u64 r8;
> 		u64 r9;
> 	};
> 
> Which way is better (above struct name can be changed of course)?
> 
> Or should we rename tdx_module_output to tdx_module_regs, and use it as both
> input and output (similar to __tdx_hypercall())?

Unlike hypercall case, here we have more managable number of arguments.
I would rather keep input arguments outside of any structs. It is easier
for callers, IMO.

Any objections?

> > +
> > +	.if \host
> > +	seamcall
> > +	.else
> > +	tdcall
> > +	.endif
> > +
> > +	/*
> > +	 * Fetch output pointer from stack to R12 (It is used
> > +	 * as temporary storage)
> > +	 */
> > +	pop %r12
> 
> For host SEAMCALL, one additional check against VMfailInvalid needs to be
> done after here.  This is because at host side, both P-SEAMLDR and TDX module
> are expected to be loaded by UEFI (i.e. UEFI shell tool) before booting to the
> kernel, therefore host kernel needs to detect whether them have been loaded, by
> issuing SEAMCALL.
> 
> When SEAM software (P-SEAMLDR or TDX module) is not loaded, the SEAMCALL fails
> with VMfailInvalid.  VMfailInvalid is indicated via a combination of RFLAGS
> rather than using %rax.  In practice, RFLAGS.CF=1 can be used to check whether
> VMfailInvalid happened, and we need to have something like below:
> 
> 	/*
> 	 * SEAMCALL instruction is essentially a VMExit from VMX root
> 	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
> 	 * that the targeted SEAM firmware is not loaded or disabled,
> 	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
> 	 * changed in this case.
> 	 *
> 	 * Set %rax to VMFAILINVALID for VMfailInvalid.  This value
> 	 * will never be used as actual SEAMCALL error code.
> 	 */
> 	jnb     .Lno_vmfailinvalid
> 	mov     $(VMFAILINVALID), %rax
> 	jmp     .Lno_output_struct
> 
> .Lno_vmfailinvalid:

Okay, I will add it under .if \host.

But maybe use JNC instead of JNB? Since we check for CF flag,
Jump-if-Not-Carry sounds more reasonable than Jump-if-Not-Below.
Not-Below of what?

-- 
 Kirill A. Shutemov
