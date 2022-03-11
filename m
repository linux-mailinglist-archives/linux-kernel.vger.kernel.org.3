Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743404D6929
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351158AbiCKTnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:43:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EC51A39CE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647027726; x=1678563726;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=mQiNdXMDSm6S2pRJONnpTeru2KszX9Gpzb6dViTFnCk=;
  b=dZPSAZMLEeZDXOK8xTUio//EH5Zn3J/OEszEIoSc94bjLNdk2+dD/VGM
   eFcNxS9b9ZtwvkCsYzVccQe0PcqFaoXmcI/2UK7AY7ceT8AzDruVZhaMu
   fYIFKEzQoUck5v0pd6JAo3Phh01aJqXnWLn8xZfmuLDwXiliaP4mBYUb2
   +oRJI30BX468sYvKHynuDNJdNe5xrxuOyXsqqpF4Vb4ftzyjIqJiQg1+g
   eCCbQfifX3se+Yu1uu8UW+2Hwv+79kIZbEuDwq4qyDtWN41vk20PxQFIN
   XdfRW/VexOaJQtS1S0zgltr58Vm5Pixuk8+Vn1gVdM508YeKLSbjW9v7R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="280386875"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="280386875"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 11:42:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="645033254"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 11:42:05 -0800
Message-ID: <a2a43395-b848-a4f9-4065-109387680701@intel.com>
Date:   Fri, 11 Mar 2022 11:41:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-3-namit@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
In-Reply-To: <20220311190749.338281-3-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 11:07, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> access_error() currently does not check for execution permission
> violation. As a result, spurious page-faults due to execution permission
> violation cause SIGSEGV.

This is a bit muddy on the problem statement.  I get that spurious
faults can theoretically cause this, but *do* they in practice on
current kernels?

> It appears not to be an issue so far, but the next patches avoid TLB
> flushes on permission promotion, which can lead to this scenario. nodejs
> for instance crashes when TLB flush is avoided on permission promotion.

By "it appears not to be an issue", do you mean that this suboptimal
behavior can not be triggered, period?  Or, it can be triggered but
folks seem not to care that it can be triggered?

I *think* these can be triggered today.  I think it takes two threads
that do something like:

	Thread 1			Thread 2
	========			========
	ptr = malloc();
	memcpy(ptr, &code, len);
	exec_now = 1;
					while (!exec_now);
					call(ptr);		
					// fault	
	mprotect(ptr, PROT_EXEC, len);
					// fault sees VM_EXEC


But that has a bug: exec_now is set before the mprotect().  It's not
sane code.

Can any sane code trigger this?

> Add a check to prevent access_error() from returning mistakenly that
> spurious page-faults due to instruction fetch are a reason for an access
> error.
> 
> It is assumed that error code bits of "instruction fetch" and "write" in
> the hardware error code are mutual exclusive, and the change assumes so.
> However, to be on the safe side, especially if hypervisors misbehave,
> assert this is the case and warn otherwise.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/mm/fault.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index d0074c6ed31a..ad0ef0a6087a 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1107,10 +1107,28 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>  				       (error_code & X86_PF_INSTR), foreign))
>  		return 1;
>  
> -	if (error_code & X86_PF_WRITE) {
> +	if (error_code & (X86_PF_WRITE | X86_PF_INSTR)) {
> +		/*
> +		 * CPUs are not expected to set the two error code bits
> +		 * together, but to ensure that hypervisors do not misbehave,
> +		 * run an additional sanity check.
> +		 */
> +		if ((error_code & (X86_PF_WRITE|X86_PF_INSTR)) ==
> +					(X86_PF_WRITE|X86_PF_INSTR)) {
> +			WARN_ON_ONCE(1);
> +			return 1;
> +		}

access_error() is only used on the do_user_addr_fault() side of things.
 Can we stick this check somewhere that also works for kernel address
faults?  This is a generic sanity check.  It can also be in a separate
patch.

Also, we should *probably* stop talking about CPUs here.  If there's
ever something wonky with error code bits, I'd put my money on a weird
hypervisor before any kind of CPU issue.

>  		/* write, present and write, not present: */
> -		if (unlikely(!(vma->vm_flags & VM_WRITE)))
> +		if ((error_code & X86_PF_WRITE) &&
> +		    unlikely(!(vma->vm_flags & VM_WRITE)))
> +			return 1;
> +
> +		/* exec, present and exec, not present: */
> +		if ((error_code & X86_PF_INSTR) &&
> +		    unlikely(!(vma->vm_flags & VM_EXEC)))
>  			return 1;
> +
>  		return 0;
>  	}

This is getting really ugly.  I think we've gone over this before, but
it escapes me.  Why do we need a common (X86_PF_WRITE | X86_PF_INSTR)
block of code?  Why can't we just add a simple X86_PF_INSN if() that
mirrors the current X86_PF_WRITE one?


        if (error_code & X86_PF_INSN) {
                /* present and not exec: */
                if (unlikely(!(vma->vm_flags & VM_EXEC)))
                        return 1;
                return 0;
        }


