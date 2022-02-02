Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6A4A6F49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbiBBK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:59:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:16595 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232455AbiBBK7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643799558; x=1675335558;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgdz1CELHul9hWTOOdWkJ3z8nWph75MMamb/biF65tk=;
  b=lbB0n3WS66R7cKuQ7w6jmJUIDHBBCWF2DmU3GglQQlOrwhveKdmL5FeS
   tyz0o9EuOkBgXR/TxO3M34sC5WVCfKx/0AImWl1L6Y5KgAxY6erVQYVAO
   ax08KXn21SthHyXTKvGcM+Q90Zv9hQYQAXdiQx4evRPfHdNxftiCW3yZG
   ztk/TZkLkb5s2M+epCzGsoB9io89OuxTbTL4E2g5HN59Ic1srexSLXmEP
   1ZaatSQrWbG2Di+LeTodiJpmChVeB/TJKWRlQ9r3us/LeGJxIZhN9LSrP
   sfzRhAehw07+l7OSfiBfK+wppluKfjc0CY6GkM6X5brbLjJ85jTYVGS2l
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247661512"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="247661512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:59:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="627030165"
Received: from alfische-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.84.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:59:12 -0800
Date:   Wed, 2 Feb 2022 23:59:10 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-Id: <20220202235910.c512857813ea5b14aa73267f@intel.com>
In-Reply-To: <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
        <87a6faz7cs.ffs@tglx>
        <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  /*
> diff --git a/arch/x86/kernel/tdxcall.S b/arch/x86/kernel/tdxcall.S
> new file mode 100644
> index 000000000000..ba5e8e35de36
> --- /dev/null
> +++ b/arch/x86/kernel/tdxcall.S
> @@ -0,0 +1,76 @@
> +#include <asm/asm-offsets.h>
> +
> +/*
> + * TDX guests use the TDCALL instruction to make requests to the
> + * TDX module and hypercalls to the VMM.
> + *
> + * TDX host user SEAMCALL instruction to make requests to TDX module.
> + *
> + * They are supported in Binutils >= 2.36.
> + */
> +#define tdcall		.byte 0x66,0x0f,0x01,0xcc
> +#define seamcall	.byte 0x66,0x0f,0x01,0xcf
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

Currently host seamcall also uses a data structure which has all possible input
registers as input argument, rather than having one argument for each register:

	struct seamcall_regs_in {
		u64 rcx;
		u64 rdx;
		u64 r8;
		u64 r9;
	};

Which way is better (above struct name can be changed of course)?

Or should we rename tdx_module_output to tdx_module_regs, and use it as both
input and output (similar to __tdx_hypercall())?

> +
> +	.if \host
> +	seamcall
> +	.else
> +	tdcall
> +	.endif
> +
> +	/*
> +	 * Fetch output pointer from stack to R12 (It is used
> +	 * as temporary storage)
> +	 */
> +	pop %r12

For host SEAMCALL, one additional check against VMfailInvalid needs to be
done after here.  This is because at host side, both P-SEAMLDR and TDX module
are expected to be loaded by UEFI (i.e. UEFI shell tool) before booting to the
kernel, therefore host kernel needs to detect whether them have been loaded, by
issuing SEAMCALL.

When SEAM software (P-SEAMLDR or TDX module) is not loaded, the SEAMCALL fails
with VMfailInvalid.  VMfailInvalid is indicated via a combination of RFLAGS
rather than using %rax.  In practice, RFLAGS.CF=1 can be used to check whether
VMfailInvalid happened, and we need to have something like below:

	/*
	 * SEAMCALL instruction is essentially a VMExit from VMX root
	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
	 * that the targeted SEAM firmware is not loaded or disabled,
	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
	 * changed in this case.
	 *
	 * Set %rax to VMFAILINVALID for VMfailInvalid.  This value
	 * will never be used as actual SEAMCALL error code.
	 */
	jnb     .Lno_vmfailinvalid
	mov     $(VMFAILINVALID), %rax
	jmp     .Lno_output_struct

.Lno_vmfailinvalid:

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
