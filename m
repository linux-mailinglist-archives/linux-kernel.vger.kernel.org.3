Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97FC4D2268
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350209AbiCHUSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350234AbiCHUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:18:07 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643D396A7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646770630; x=1678306630;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/2f3buvdzZ489CYmd0UNhrqGKDYP6fbJVlqrizvPDSU=;
  b=QeQLRn19iBlEwl6zVi4JrkFnsBIfenPZu6A5Dnpsh/5HSGrGCF6slGaD
   17Bjo4tbLQGNFWuDQJLM3pcmOb1AtEeUAhqRwEQcmicwP88dkLDlM7vBd
   0L5GYw/JsoL7MVMhPf/D/5CBgoOymeTRaTjDEuOQJiiZDBuOTOxoTXAip
   8PsNSsNRgtRGnj7Dv2GgrQlnl0TiQiw/hl6Qb++Y5tGCcU/7OKiF63Tg9
   LlAleNjqB57W7I/unGgGIfIddJnPP9mvAI//60J/nai4SxkCEL84ojdYz
   zS1dNhQUtRsuk+ZrOrJjVBdUmw/Eg6eZiLML8+KkGS/BUsN+BMkhdG0f9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315518997"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="315518997"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:17:09 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547391400"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:17:07 -0800
Message-ID: <e39f4ae8-b75d-6b84-1971-d9e27199877e@intel.com>
Date:   Tue, 8 Mar 2022 12:17:01 -0800
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
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-5-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 04/30] x86/tdx: Extend the confidential computing API to
 support TDX guests
In-Reply-To: <20220302142806.51844-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
...
> Like AMD SME/SEV, TDX uses a bit in the page table entry to indicate
> encryption status of the page, but the polarity of the mask is
> opposite to AMD: if the bit is set the page is accessible to VMM.

I'd much rather this be in a code comment next to the weird-looking code
than in the changelog.

> Details about which bit in the page table entry to be used to indicate
> shared/private state can be determined by using the TDINFO TDCALL.

s/can be/are/

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig     |  1 +
>  arch/x86/coco/core.c |  4 ++++
>  arch/x86/coco/tdx.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c346d66b51fc..93e67842e369 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>  	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>  	depends on X86_64 && CPU_SUP_INTEL
>  	depends on X86_X2APIC
> +	select ARCH_HAS_CC_PLATFORM
>  	help
>  	  Support running as a guest under Intel TDX.  Without this support,
>  	  the guest kernel can not boot or run under TDX.
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index fc1365dd927e..9113baebbfd2 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -90,6 +90,8 @@ u64 cc_mkenc(u64 val)
>  	switch (vendor) {
>  	case CC_VENDOR_AMD:
>  		return val | cc_mask;
> +	case CC_VENDOR_INTEL:
> +		return val & ~cc_mask;
>  	default:
>  		return val;
>  	}
> @@ -100,6 +102,8 @@ u64 cc_mkdec(u64 val)
>  	switch (vendor) {
>  	case CC_VENDOR_AMD:
>  		return val & ~cc_mask;
> +	case CC_VENDOR_INTEL:
> +		return val | cc_mask;
>  	default:
>  		return val;
>  	}
> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> index 17365fd40ba2..912ef12e434e 100644
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -5,8 +5,12 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
>  
>  #include <linux/cpufeature.h>
> +#include <asm/coco.h>
>  #include <asm/tdx.h>
>  
> +/* TDX module Call Leaf IDs */
> +#define TDX_GET_INFO			1
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -25,8 +29,32 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>  	return __tdx_hypercall(&args, 0);
>  }
>  
> +static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> +				   struct tdx_module_output *out)
> +{
> +	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
> +		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
> +}

I really think we need to document the panic()s that we add.  It might
mean duplicating a wee bit of the text from the SEAMCALL/TDCALL
assembly, but I think it's worth it so that folks don't think this is an
over-eager panic().
