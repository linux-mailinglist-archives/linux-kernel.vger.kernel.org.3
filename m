Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7812D4C38EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiBXWn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiBXWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:43:58 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A061A9054
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645742607; x=1677278607;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=a2Tdn4lRIDl4oI14xpvHrr5pz9na4/D3/xxyJfuKJCg=;
  b=TDTNNqkgxS8r409GoSLOntZanssinLuDvBft8BVbjViJUhdc141rcGrj
   DO2Sa1XPRQtKhIH9qTnYpX7XUPZLy+DRWIP54ddf/CawO5CTRKv8w6mIX
   ERtowznR4NSoFoHklEuoqtsc+A7jBDVwkd9FU5JxCGnYd8I/65B62kDzq
   l8KD6l+1x/YuchmHmrKLWEZN7DLSJTq+HbFiNFdsNZgmPpMsdpi+MzHnB
   ESE/XRZCJ+Y2y5dcsXZvH5Q6m/29Ei5SX3EPmiMZ/Ek2E7zSNhtqZMi++
   U5820indeQNWJ/J3LN6rLHtHiqduCGR/0nCwxGZn/aMEWKIxNrsM2/dLm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252562590"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252562590"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 14:43:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639907019"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 14:43:26 -0800
Message-ID: <554143b6-36c6-d192-9662-1a5ac6dfa97f@intel.com>
Date:   Thu, 24 Feb 2022 14:43:21 -0800
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
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 17/30] x86/tdx: Add port I/O emulation
In-Reply-To: <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> TDX hypervisors cannot emulate instructions directly. This includes
> port I/O which is normally emulated in the hypervisor. All port I/O
> instructions inside TDX trigger the #VE exception in the guest and
> would be normally emulated there.
> 
> Use a hypercall to emulate port I/O. Extend the
> tdx_handle_virt_exception() and add support to handle the #VE due to
> port I/O instructions.
> 
> String I/O operations are not supported in TDX. Unroll them by declaring
> CC_ATTR_GUEST_UNROLL_STRING_IO confidential computing attribute.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/core.c |  7 +++++-
>  arch/x86/coco/tdx.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index 9113baebbfd2..5615b75e6fc6 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -18,7 +18,12 @@ static u64 cc_mask __ro_after_init;
>  
>  static bool intel_cc_platform_has(enum cc_attr attr)
>  {
> -	return false;
> +	switch (attr) {
> +	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> +		return true;
> +	default:
> +		return false;
> +	}
>  }
>  
>  /*
> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> index 15519e498679..2e342760b1d2 100644
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -19,6 +19,12 @@
>  #define EPT_READ	0
>  #define EPT_WRITE	1
>  
> +/* See Exit Qualification for I/O Instructions in VMX documentation */
> +#define VE_IS_IO_IN(e)		((e) & BIT(3))
> +#define VE_GET_IO_SIZE(e)	(((e) & GENMASK(2, 0)) + 1)
> +#define VE_GET_PORT_NUM(e)	((e) >> 16)
> +#define VE_IS_IO_STRING(e)	((e) & BIT(4))
> +
>  static struct {
>  	unsigned int gpa_width;
>  	unsigned long attributes;
> @@ -292,6 +298,52 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	return true;
>  }
>  
> +/*
> + * Emulate I/O using hypercall.
> + *
> + * Assumes the IO instruction was using ax, which is enforced
> + * by the standard io.h macros.
> + *
> + * Return True on success or False on failure.
> + */
> +static bool handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = EXIT_REASON_IO_INSTRUCTION,
> +	};
> +	int size, port;
> +	u64 mask;
> +	bool in, ret;
> +
> +	if (VE_IS_IO_STRING(exit_qual))
> +		return false;
> +
> +	in   = VE_IS_IO_IN(exit_qual);
> +	size = VE_GET_IO_SIZE(exit_qual);
> +	port = VE_GET_PORT_NUM(exit_qual);
> +	mask = GENMASK(BITS_PER_BYTE * size, 0);
> +
> +	args.r12 = size;
> +	args.r13 = !in;
> +	args.r14 = port;
> +	args.r15 = in ? 0 : regs->ax;
> +
> +	/*
> +	 * Emulate the I/O read/write via hypercall. More info about
> +	 * ABI can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.IO>".
> +	 */
> +	ret = !__tdx_hypercall(&args, in ? TDX_HCALL_HAS_OUTPUT : 0);
> +	if (!ret || !in)
> +		return ret;
> +
> +	regs->ax &= ~mask;
> +	regs->ax |= ret ? args.r11 & mask : UINT_MAX;
> +
> +	return ret;
> +}


I can't help but think this would be more clear if the in and !in sideds
were separated:

	if (!in) {
		args.r15 = regs->ax;
		ret = !__tdx_hypercall(&args, 0);
	} else {
		args.r15 = 0;
		ret = !__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
		regs->ax &= ~mask;
		if (ret)
			regs->ax |= args.r11 & mask
		else
			regs->ax |= UINT_MAX;
	}

	return ret;

The ->ax mangling also needs a comment.  It looks like it's trying to
inject -1 when there's a failure.  Even if the roots of this are in the
TDX spec(s), it would be nice to express the intent of this code.

I also really dislike using 'ret' as a bool return type.  Wouldn't this
be about a billion times clearer if 'ret' was renamed to 'success'?

Right now, this code is effectively doing:

	if (!ret)
		return error;

Which is actually functionally correct here.  All other int-typed 'ret'
code in the kernel do this:

	if (ret)
		return error;

which would be functionally _wrong_.  Can you please take mercy on my
little brain an at least make the code look different if it behaves the
opposite from the same literal code in other spots in the kernel?

Heck, even 'bool handled' would be pretty nice.

>  void tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -347,6 +399,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  		return handle_cpuid(regs);
>  	case EXIT_REASON_EPT_VIOLATION:
>  		return handle_mmio(regs, ve);
> +	case EXIT_REASON_IO_INSTRUCTION:
> +		return handle_io(regs, ve->exit_qual);
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return false;

