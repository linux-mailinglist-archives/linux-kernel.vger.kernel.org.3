Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D3A4C3519
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiBXSz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiBXSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:55:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EFE24CCE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645728895; x=1677264895;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=maTwcdC87fX3lmLSsjgS76Kko/CC89cO+10/za1K53s=;
  b=fGN0wx8cWz+iIJq0NnQkFoDI22gxAgBtbNO9z8I1G+0to4vHsymcsv6N
   8lFvdCIuxBPk2qmSKhPCm01sFW3fsl+ErB39SUMAmlcfXLFFFyQxzHSa3
   eYN9pJuLp2xBCGBOmQf372NHKNFlDTAII5GY7q2Zp9pIuLSxMkas1jXvg
   vyq8VFRvd6gBWjmmTsM44KpDJbVUwjnYOaq9IxiBJQvKmsl6SfizF3o63
   aSucOae8CYSawx7rL9xUz7a1votHO9zDQppba2Jm17gODq7208rD41lPp
   MQdOhJaHVLU12rM7qx7YodebJOHKNuFKJu6S3Jo9bBUssjh5elQMS1702
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251150246"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251150246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 10:52:29 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548888374"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 10:52:28 -0800
Message-ID: <67dfdb0c-c483-ec3c-4fb8-57086ffde9bf@intel.com>
Date:   Thu, 24 Feb 2022 10:52:23 -0800
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
 <20220224155630.52734-10-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 09/30] x86/tdx: Add MSR support for TDX guests
In-Reply-To: <20220224155630.52734-10-kirill.shutemov@linux.intel.com>
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
> Use hypercall to emulate MSR read/write for the TDX platform.
> 
> There are two viable approaches for doing MSRs in a TD guest:
> 
> 1. Execute the RDMSR/WRMSR instructions like most VMs and bare metal
>    do. Some will succeed, others will cause a #VE. All of those that
>    cause a #VE will be handled with a TDCALL.
> 2. Use paravirt infrastructure.  The paravirt hook has to keep a list
>    of which MSRs would cause a #VE and use a TDCALL.  All other MSRs
>    execute RDMSR/WRMSR instructions directly.
> 
> The second option can be ruled out because the list of MSRs was
> challenging to maintain. That leaves option #1 as the only viable
> solution for the minimal TDX support.
> 
> For performance-critical MSR writes (like TSC_DEADLINE), future patches
> will replace the WRMSR/#VE sequence with the direct TDCALL.

This will still leave us with a list of non-#VE-inducing MSRs.  That's
not great.  But, if we miss an MSR in the performance-critical list, the
result is a slow WRMSR->#VE.  If we miss an MSR in the paravirt
approach, we induce a fatal #VE.

Please add something to that effect if you revise this patch.

> RDMSR and WRMSR specification details can be found in
> Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
> Extensions (Intel TDX) specification, sec titled "TDG.VP.
> VMCALL<Instruction.RDMSR>" and "TDG.VP.VMCALL<Instruction.WRMSR>".
> 
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> index 0a2e6be0cdae..89992593a209 100644
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -116,6 +116,44 @@ void __cpuidle tdx_safe_halt(void)
>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
>  }
>  
> +static bool read_msr(struct pt_regs *regs)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = EXIT_REASON_MSR_READ,

Just a minor note: these "EXIT_REASON_FOO"'s in r11 are effectively
*the* hypercall being made, right?

The hypercall is being made in response to what would have otherwise
been a MSR read VMEXIT.  But, it's a *bit* goofy to see them here when
the TDX guest isn't doing any kind of VMEXIT.

I wish there were some clarity around it, but it's not a deal breaker.

> +		.r12 = regs->cx,
> +	};
> +
> +	/*
> +	 * Emulate the MSR read via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
> +	 */
> +	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
> +		return false;
> +
> +	regs->ax = lower_32_bits(args.r11);
> +	regs->dx = upper_32_bits(args.r11);
> +	return true;
> +}
> +
> +static bool write_msr(struct pt_regs *regs)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = EXIT_REASON_MSR_WRITE,
> +		.r12 = regs->cx,
> +		.r13 = (u64)regs->dx << 32 | regs->ax,
> +	};
> +
> +	/*
> +	 * Emulate the MSR write via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
> +	 */
> +	return !__tdx_hypercall(&args, 0);
> +}
> +
>  void tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -158,6 +196,10 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_HLT:
>  		return handle_halt();
> +	case EXIT_REASON_MSR_READ:
> +		return read_msr(regs);
> +	case EXIT_REASON_MSR_WRITE:
> +		return write_msr(regs);
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return false;

I still think it's annoying that all these WRMSR's are turned into #VE,
but this does seem like the best approach given the architecture that we
have.  Having the optimized ones seems like a good compromise.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
