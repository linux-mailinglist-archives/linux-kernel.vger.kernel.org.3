Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04FB52DCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiESSdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiESSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:33:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254646B3F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652985189; x=1684521189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n+Od0sKsKim5mCbJh1QOz6Wy+mmPXxlDGr1pz+MMTCk=;
  b=d8LWWgiJ1GmksEDPwWZOGHRCKgugpTYmW0cSiQ7ZOxwl5RbJyQuZOC8J
   G4QFg3UHggHO7LA7ThwNWRoWukK6RNGBXub81v01D6PDxGS4x0L/isWd0
   Uiv2zY5wuSNQyfxXLlkU2lo12Hk1yd66Ig7qrCtXWApruDMuAxTOWzNVW
   gdEaXEFlrJVHXJGmHHf4ze9+23cCs7qb0Ve2oKXzzpkCt11LGyUxMZUkW
   t/8SLkMOpjn+TRZCcTWE8pW6VXT7tK3jf3M5xddP9OOU0T/IPNFBiKlzY
   5sOC24uAWiwt3xBjIOhWTz7IEb8vq9mHjdgugwDWf18P6Lq8vAgJsVewP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252213648"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="252213648"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:33:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="606623284"
Received: from rlsharma-mobl.amr.corp.intel.com (HELO [10.212.180.228]) ([10.212.180.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:33:08 -0700
Message-ID: <a9a4ba2f-6cfa-c59f-3921-e94d5c9a6148@intel.com>
Date:   Thu, 19 May 2022 11:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
 <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
 <20220519180739.2xnq7mjpa6hzcbsn@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220519180739.2xnq7mjpa6hzcbsn@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 11:07, Kirill A. Shutemov wrote:
> On Tue, May 17, 2022 at 03:16:42PM -0700, Dave Hansen wrote:
>> See?  Now everybody that goes and writes a new #VE exception helper has
>> a chance of actually getting this right.  As it stands, if someone adds
>> one more of these, they'll probably get random behavior.  This way, they
>> actually have to choose.  They _might_ even go looking at the SDM.
> 
> Okay. See below. Does it match what you had in mind?

Looks close.

> BTW, I found a bug in tdx_early_handle_ve(). It didn't update RIP.
> I don't know how it happend. Maybe got lost on the way upstream.

Huh, so refactoring things instead of depending on magic hidden behavior
helps find bugs?  Interesting.  ;)

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 9955b5a89df8..d2635ac52d9b 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -123,7 +123,7 @@ static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
>  	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
>  }
>  
> -static bool handle_halt(void)
> +static int handle_halt(struct ve_info *ve)
>  {
>  	/*
>  	 * Since non safe halt is mainly used in CPU offlining
> @@ -134,9 +134,9 @@ static bool handle_halt(void)
>  	const bool do_sti = false;
>  
>  	if (__halt(irq_disabled, do_sti))
> -		return false;
> +		return -EIO;
>  
> -	return true;
> +	return ve->instr_len;
>  }

Ideally each of these would include a comment about why we can get the
isntruction length from ve_info.  That "why" is currently a bit weak,
but it's something like:

	/*
	 * In TDX guests, HLT is configured to cause exits.  Assume that
	 * the TDX module has provided the "VM-exit instruction length".
	 */

It would be nice to have some central discussion of this too to explain
that the TDX documentation is currently lacking here, but we don't need
to repeat that part in a comment 6 different times.

...
>  /* Handle the kernel #VE */
> -static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> +static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  {

/*
 * Handle kernel #VEs.  On success, returns the number of
 * bytes RIP should be incremented (>=0) or -errno on error.
 */

>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_HLT:
> -		return handle_halt();
> +		return handle_halt(ve);
>  	case EXIT_REASON_MSR_READ:
> -		return read_msr(regs);
> +		return read_msr(regs, ve);
>  	case EXIT_REASON_MSR_WRITE:
> -		return write_msr(regs);
> +		return write_msr(regs, ve);
>  	case EXIT_REASON_CPUID:
> -		return handle_cpuid(regs);
> +		return handle_cpuid(regs, ve);
>  	case EXIT_REASON_EPT_VIOLATION:
>  		return handle_mmio(regs, ve);
>  	case EXIT_REASON_IO_INSTRUCTION:
> -		return handle_io(regs, ve->exit_qual);
> +		return handle_io(regs, ve);
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> -		return false;
> +		return -EIO;
>  	}
>  }
>  
>  bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
>  {
> -	bool ret;
> +	int ret;

'ret' is usually used for return values of *this* function.

Let's give it a better name, please.

>  	if (user_mode(regs))
>  		ret = virt_exception_user(regs, ve);
>  	else
>  		ret = virt_exception_kernel(regs, ve);
>  
> +	if (ret < 0)
> +		return false;
> +
>  	/* After successful #VE handling, move the IP */
> -	if (ret)
> -		regs->ip += ve->instr_len;
> +	regs->ip += ret;
>  
> -	return ret;
> +	return true;
>  }
>  
>  static bool tdx_tlb_flush_required(bool private)

