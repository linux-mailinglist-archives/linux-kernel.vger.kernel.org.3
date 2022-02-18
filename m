Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98964BC145
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiBRUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:39:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiBRUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:39:35 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23ED3586B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645216758; x=1676752758;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=H9O75HQ59RnmWc33D0Go4uGSmp0WKp7BHbWrqK62HQg=;
  b=m1Ca9JSvshjAFuhg4LfEycizd1MdMgR9gRhpxxDKNOhlqedK11+PVDD9
   rlsdCGzD+AFJ7CV+60GjnDxIhErQ/AqL5dHlPGw3lky9D/Za2v9M6wrlX
   PASApsfUWSO6wE/ik3BygmMwP0r72Cvuao8ibbwRHsZOvngFnX4RMPcGl
   Fp8v0y3GrLWTjs+H7hcoDbDjHVmliPo92nmlOWA5XPrpk9s6jnaVQVWKV
   3/AXhwUX33wyJUP5qmoudaNCWo27Q46qUsG5Tu5kI2NydbJ5JkDIxcCOD
   HnSgWZ/lzmeFy1jh0JfeM+JbimQmQPvdk9ORExTI6ziYfl+uieNLkIT82
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="311957137"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="311957137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:39:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546470224"
Received: from jabonill-mobl1.amr.corp.intel.com (HELO [10.251.27.55]) ([10.251.27.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:38:17 -0800
Message-ID: <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
Date:   Fri, 18 Feb 2022 12:36:02 -0800
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
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
In-Reply-To: <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 08:16, Kirill A. Shutemov wrote:
> +#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> +u64 cc_get_mask(bool enc);
> +u64 cc_mkenc(u64 val);
> +u64 cc_mkdec(u64 val);
> +#else
> +#define cc_get_mask(enc)	0
> +#define cc_mkenc(val)		(val)
> +#define cc_mkdec(val)		(val)
> +#endif

Is there a reason the stubs as #defines?  Static inlines are preferred
for consistent type safety among other things.

It would also be nice to talk about the u64 type in the changelog.  If I
remember right, there was a reason you didn't want to have a pgprot_t
here.

...
> @@ -74,12 +72,52 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
>  
>  bool cc_platform_has(enum cc_attr attr)
>  {
> -	if (sme_me_mask)
> +	switch (cc_vendor) {
> +	case CC_VENDOR_AMD:
>  		return amd_cc_platform_has(attr);
> -
> -	if (hv_is_isolation_supported())
> +	case CC_VENDOR_INTEL:
> +		return intel_cc_platform_has(attr);
> +	case CC_VENDOR_HYPERV:
>  		return hyperv_cc_platform_has(attr);
> -
> -	return false;
> +	default:
> +		return false;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(cc_platform_has);

This patch is bordering on doing too many different things.  Adding the
CC_VENDOR_*'s in a separate patch probably would have been nice, for
instance.

This wasn't really broached at all in the changelog.

> +u64 cc_get_mask(bool enc)
> +{
> +	switch (cc_vendor) {
> +	case CC_VENDOR_AMD:
> +		return enc ? cc_mask : 0;
> +	default:
> +		return 0;
> +	}
> +}

I had to ask myself why you need all three of these functions.  It's
obvious _after_ reading the whole patch, but it left me wanting more in
the changelog about it.

> +u64 cc_mkenc(u64 val)
> +{
> +	switch (cc_vendor) {
> +	case CC_VENDOR_AMD:
> +		return val | cc_mask;
> +	default:
> +		return val;
> +	}
> +}
> +
> +u64 cc_mkdec(u64 val)
> +{
> +	switch (cc_vendor) {
> +	case CC_VENDOR_AMD:
> +		return val & ~cc_mask;
> +	default:
> +		return val;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cc_mkdec);
> +
> +__init void cc_init(enum cc_vendor vendor, u64 mask)
> +{
> +	cc_vendor = vendor;
> +	cc_mask = mask;
> +}
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 5a99f993e639..9af6be143998 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -33,6 +33,7 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
> +#include <asm/coco.h>
>  
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
>  		 */
>  		swiotlb_force = SWIOTLB_FORCE;
>  #endif
> +		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> +			cc_init(CC_VENDOR_HYPERV, 0);
>  	}
>  
>  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 3f0abb403340..fa758247ab57 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -44,6 +44,7 @@
>  #include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/cmdline.h>
> +#include <asm/coco.h>
>  
>  #include "mm_internal.h"
>  
> @@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
>  	} else {
>  		/* SEV state cannot be controlled by a command line option */
>  		sme_me_mask = me_mask;
> -		physical_mask &= ~sme_me_mask;
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -600,6 +600,8 @@ void __init sme_enable(struct boot_params *bp)
>  		sme_me_mask = 0;
>  	else
>  		sme_me_mask = active_by_default ? me_mask : 0;
> -
> +out:
>  	physical_mask &= ~sme_me_mask;
> +	if (sme_me_mask)
> +		cc_init(CC_VENDOR_AMD, sme_me_mask);
>  }

I don't think you need to mop it up here, but where does this leave
sme_me_mask?

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index b4072115c8ef..e79366b8a9da 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1999,8 +1999,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	memset(&cpa, 0, sizeof(cpa));
>  	cpa.vaddr = &addr;
>  	cpa.numpages = numpages;
> -	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
> -	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
> +	cpa.mask_set = __pgprot(cc_get_mask(enc));
> +	cpa.mask_clr = __pgprot(cc_get_mask(!enc));
>  	cpa.pgd = init_mm.pgd;
>  
>  	/* Must avoid aliasing mappings in the highmem code */

This actually ended up looking pretty nice.  It was a real mess along
the way, but this makes me think this is a _good_ solution.
