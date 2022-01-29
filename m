Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE614A2A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiA2AWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:22:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:13091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344582AbiA2AWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643415765; x=1674951765;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=O9hLRdvQKwbgTPGcBnE52dgCeqbt88V4t/hdx7kDnbo=;
  b=Phw7LL8+6Y5MrHrM9bCBzSX4SDvSybjWBSL2jJjqMDHu+OiGLqDSTUPn
   cYbCmr7SyKA7Zu9MdZVr41lypj1KW7zu4JAUi0RSEetPosqbgzekzuH20
   +mFsFhuw2/XD6Wmqbv5QlPyC/5mKrez9q/YdEOvvCLQHKZW5sMfg6/Am2
   VgcJRaeKW2JWrlFfrcs+vsGgrN9T46TYCpkFagHLkRPpBnVaN7VA9QG76
   F2WsG8zSBIx+3ejy02mkeFfIx9rqqGgKJEpFGoqTOdPgkrXlBoMpY2zzY
   5P7fWzrQugVCRKR85x0L7gLPayTwLJ+FPSLctNa2gYEmwHlG02MzC1Pa2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247171217"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247171217"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:22:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697264118"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:22:45 -0800
Message-ID: <3b1ba2fe-5f69-ee2f-ea08-f0b5d145696d@intel.com>
Date:   Fri, 28 Jan 2022 16:22:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-16-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 15/44] x86/pkeys: Preserve the PKS MSR on context
 switch
In-Reply-To: <20220127175505.851391-16-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The PKS MSR (PKRS) is defined as a per-logical-processor register.  This

s/defined as//

> isolates memory access by logical CPU.  

This second sentence is a bit confusing to me.  I *think* you're trying
to say that PKRS only affects accesses from one logical CPU.  But, it
just comes out strangely.  I think I'd just axe the sentence.

> Unfortunately, the MSR is not
> managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
> context switch.
> 
> Define pks_saved_pkrs in struct thread_struct.  Initialize all tasks,
> including the init_task, with the PKS_INIT_VALUE when created.  Restore
> the CPU's MSR to the saved task value on schedule in.
> 
> pks_write_current() is added to ensures non-supervisor pkey

				  ^ ensure

...
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 2c5f12ae7d04..3530a0e50b4f 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_PROCESSOR_H
>  #define _ASM_X86_PROCESSOR_H
>  
> +#include <linux/pks-keys.h>
> +
>  #include <asm/processor-flags.h>
>  
>  /* Forward declaration, a strange C thing */
> @@ -502,6 +504,12 @@ struct thread_struct {
>  	unsigned long		cr2;
>  	unsigned long		trap_nr;
>  	unsigned long		error_code;
> +
> +#ifdef	CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> +	/* Saved Protection key register for supervisor mappings */
> +	u32			pks_saved_pkrs;
> +#endif

There are a bunch of other "saved" registers in thread_struct.  They all
just have their register name, including pkru.

Can you just stick this next to 'pkru' and call it plain old 'pkrs'?
That will probably even take up less space than this since the two
32-bit values can be packed together.

>  #ifdef CONFIG_VM86
>  	/* Virtual 86 mode info */
>  	struct vm86		*vm86;
> @@ -769,7 +777,14 @@ static inline void spin_lock_prefetch(const void *x)
>  #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>  
>  #else
> -#define INIT_THREAD { }
> +
> +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> +#define INIT_THREAD  {					\
> +	.pks_saved_pkrs = PKS_INIT_VALUE,		\
> +}
> +#else
> +#define INIT_THREAD  { }
> +#endif
>  
>  extern unsigned long KSTK_ESP(struct task_struct *task);
>  
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 3402edec236c..81fc0b638308 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -59,6 +59,7 @@
>  /* Not included via unistd.h */
>  #include <asm/unistd_32_ia32.h>
>  #endif
> +#include <asm/pks.h>
>  
>  #include "process.h"
>  
> @@ -657,6 +658,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in();
>  
> +	pks_write_current();
> +
>  	return prev_p;
>  }

At least for pkru and fsgsbase, these have the form:

	x86_<register>_load();

Should this be

	x86_pkrs_load();

and be located next to:

	x86_pkru_load()?

> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index 3dce99ef4127..6d94dfc9a219 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -242,6 +242,19 @@ static inline void pks_write_pkrs(u32 new_pkrs)
>  	}
>  }
>  
> +/**
> + * pks_write_current() - Write the current thread's saved PKRS value
> + *
> + * Context: must be called with preemption disabled
> + */
> +void pks_write_current(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return;
> +
> +	pks_write_pkrs(current->thread.pks_saved_pkrs);
> +}
> +
>  /*
>   * PKS is independent of PKU and either or both may be supported on a CPU.
>   *

