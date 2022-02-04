Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024854A972A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357875AbiBDJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:51:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:62513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345599AbiBDJvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643968306; x=1675504306;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VpvsouKtfytZM1zm826Tw50a4we77vDGpg9yQSoAclw=;
  b=EFIFtkI6/fPWEyXvUx1jH0H6qHdLvqTbQSP6E9RycMMi+RasH70xFfAR
   ePoVNgEIU2zV1bmCNTYof7c3VS1gdZRfAmdoyhZEWvL5Q0PY7nkEOxCZv
   R+YezfxAKXhd0S2gRAWr+8R7pjhSlou+p5/dAvi/cZv6B4wnu6ZenCv6P
   xmm10AGiM96tF2RLZjtNMgabbkoRVgu/xtiGV8LA+yrDCwE4ZbCAO/AgI
   GIMNntQu8CqxP8OjzT/p9DhGsVgQNkfHopYpXpdGWL0oSqLjgcApVidPK
   pQJRT91hpxhqW/LvcAUzm2D7wyTuEX2uY4UviinK86YsPqyo5GMx2igBy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248290998"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248290998"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:51:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="483563833"
Received: from rkothand-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.86.47])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:51:40 -0800
Date:   Fri, 4 Feb 2022 22:51:38 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <aarcange@redhat.com>, <ak@linux.intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <hpa@zytor.com>,
        <jgross@suse.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <jpoimboe@redhat.com>, <knsathya@kernel.org>,
        <pbonzini@redhat.com>, <sdeep@vmware.com>, <seanjc@google.com>,
        <tony.luck@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-Id: <20220204225138.e76f6e98e0208d746606099d@intel.com>
In-Reply-To: <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
        <87a6faz7cs.ffs@tglx>
        <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
        <20220202235910.c512857813ea5b14aa73267f@intel.com>
        <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
        <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +.macro TDX_MODULE_CALL host:req
> +	/*
> +	 * R12 will be used as temporary storage for struct tdx_module_output
> +	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
> +	 * services supported by this function, it can be reused.
> +	 */
> +
> +	/* Callee saved, so preserve it */
> +	push %r12
> +
> +	/*
> +	 * Push output pointer to stack.
> +	 * After the operation, it will be fetched into R12 register.
> +	 */
> +	push %r9
> +
> +	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
> +	/* Move Leaf ID to RAX */
> +	mov %rdi, %rax
> +	/* Move input 4 to R9 */
> +	mov %r8,  %r9
> +	/* Move input 3 to R8 */
> +	mov %rcx, %r8
> +	/* Move input 1 to RCX */
> +	mov %rsi, %rcx
> +	/* Leave input param 2 in RDX */
> +
> +	.if \host
> +	seamcall
> +	/*
> +	 * SEAMCALL instruction is essentially a VMExit from VMX root
> +	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
> +	 * that the targeted SEAM firmware is not loaded or disabled,
> +	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
> +	 * changed in this case.
> +	 *
> +	 * Set %rax to TDX_SEAMCALL_VMFAILINVALID for VMfailInvalid.
> +	 * This value will never be used as actual SEAMCALL error code.
> +	 */
> +	jnc     .Lno_vmfailinvalid
> +	mov     $TDX_SEAMCALL_VMFAILINVALID, %rax
> +	jmp     .Lno_output_struct

If I read correctly, in case of VMfailInvalid, another "pop %r12" is needed
before jmp to .Lno_output_struct, otherwise it doesn't match the stack (pushed
twice).

However, since "test %rax, %rax" will also catch TDX_SEAMCALL_VMFAILINVALID, it
seems we can just delete above "jmp .Lno_output_struct"?

> +.Lno_vmfailinvalid:
> +	.else
> +	tdcall
> +	.endif
> +
> +	/*
> +	 * Fetch output pointer from stack to R12 (It is used
> +	 * as temporary storage)
> +	 */
> +	pop %r12
> +
> +	/* Check for success: 0 - Successful, otherwise failed */
> +	test %rax, %rax
> +	jnz .Lno_output_struct
> +
> +	/*
> +	 * Since this function can be initiated without an output pointer,
> +	 * check if caller provided an output struct before storing
> +	 * output registers.
> +	 */
> +	test %r12, %r12
> +	jz .Lno_output_struct
> +
> +	/* Copy result registers to output struct: */
> +	movq %rcx, TDX_MODULE_rcx(%r12)
> +	movq %rdx, TDX_MODULE_rdx(%r12)
> +	movq %r8,  TDX_MODULE_r8(%r12)
> +	movq %r9,  TDX_MODULE_r9(%r12)
> +	movq %r10, TDX_MODULE_r10(%r12)
> +	movq %r11, TDX_MODULE_r11(%r12)
> +
> +.Lno_output_struct:
> +	/* Restore the state of R12 register */
> +	pop %r12
> +.endm
> -- 
>  Kirill A. Shutemov
