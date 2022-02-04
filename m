Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C314A932C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 05:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357004AbiBDE5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 23:57:03 -0500
Received: from foss.arm.com ([217.140.110.172]:42680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235508AbiBDE5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:57:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 203EE1435;
        Thu,  3 Feb 2022 20:57:02 -0800 (PST)
Received: from [10.163.45.195] (unknown [10.163.45.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5BA53F774;
        Thu,  3 Feb 2022 20:56:57 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/2] perf: Add more generic branch types
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-2-git-send-email-anshuman.khandual@arm.com>
 <YfpxzKa7JSlimA1i@FVFF77S0Q05N>
Message-ID: <aee1d90d-7778-2f1c-9484-584fa3c57159@arm.com>
Date:   Fri, 4 Feb 2022 10:26:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfpxzKa7JSlimA1i@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/22 5:28 PM, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Fri, Jan 28, 2022 at 11:14:12AM +0530, Anshuman Khandual wrote:
>> This expands generic branch type classification by adding some more entries
>> , that can still be represented with the existing 4 bit 'type' field. While

    ^
>> here this also updates the x86 implementation with these new branch types.
> 
> It looks like there's some whitespace damage here.

Are you referring the above ? I will have a look.

> 
>>From a quick scan of the below, I think the "exception return" and "IRQ
> exception" types are somewhat generic, and could be added now (aside from any
> bikeshedding over names), but:
> 
> * For IRQ vs FIQ, we might just want to have a top-level "asynchronous
>   exception" type, and then further divide that with a separate field. That way
>   it's easier to extend in future if new exceptions are added.

Okay. But that might lead to a hierarchical bit fields design where as the
current one is just linear.

> 
> * I don't think the debug state entry/exits make sense as generic branch types,

From BRBE perspective, a branch is any control flow change including exception
level change, debug enter, debug exit etc. If exception and its return can be
classified as 'branches' why not debug state change ? Are there no similar
debug states transition on other platforms ?

>   since those are somewhat specific to the ARM architecutre, and it might make
>   sense to define generic PERF_BR_ARCH* definitions instead.

Makes sense but corresponding bit field layout change in branch_sample_type
will remain a challenge.

> 
> * Given the next patch extends the field, and therei are potential ABI problems
>   with that, we might need to reserve a value for ABI extensibility purposes,
>   and I suspect we need to do that *first*. More comments on the subsequent
>   patch.

Sure, understood.

>  
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/x86/events/intel/lbr.c           | 4 ++--
>>  include/uapi/linux/perf_event.h       | 5 +++++
>>  tools/include/uapi/linux/perf_event.h | 5 +++++
>>  tools/perf/util/branch.c              | 7 ++++++-
>>  4 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 8043213b75a5..9f86fac8c6a5 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1336,10 +1336,10 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
>>  	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
>>  	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
>>  	PERF_BR_UNKNOWN,	/* X86_BR_INT */
>> -	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
>> +	PERF_BR_EXPT_RET,	/* X86_BR_IRET */
>>  	PERF_BR_COND,		/* X86_BR_JCC */
>>  	PERF_BR_UNCOND,		/* X86_BR_JMP */
>> -	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
>> +	PERF_BR_IRQ,		/* X86_BR_IRQ */
>>  	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
>>  	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
>>  	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
> 
> This presumably changes the values reported to userspace, so the commit message
> should mention that and explain why that is not a problem.

Okay.

> 
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 1b65042ab1db..b91d0f575d0c 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -251,6 +251,11 @@ enum {
>>  	PERF_BR_SYSRET		= 8,	/* syscall return */
>>  	PERF_BR_COND_CALL	= 9,	/* conditional function call */
>>  	PERF_BR_COND_RET	= 10,	/* conditional function return */
>> +	PERF_BR_EXPT_RET	= 11,	/* exception return */
> 
> We don't use 'EXPT' anywhere else, so it might be better to just use 'ERET'.
> IIUC that's the naming the x86 FRED stuff is going to use anyhow.

Sure, will change.

> 
>> +	PERF_BR_IRQ		= 12,	/* irq */
> 
> This looks somewhat generic, so adding it now makes sense to me, but ...
> 
>> +	PERF_BR_FIQ		= 13,	/* fiq */
> 
> ... this is arguably just a idfferent class of interrupt from the PoV of Linux,
> and the naming is ARM-specific, so I don't think this makes sense to add *now*.

I assume 'now' --> without ABI extension.

> As above, maybe it would be better to have a generic "aynchronous exception" or
> "interrupt" type, and a separate field to distinguish specific types of those.
> 
>> +	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
>> +	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
> 
> For the benefit of those not familiar with the ARM architecture, "debug halt"
> and "debug exit" usually refer to "debug state", which is what an external
> (e.g. JTAG) debugger uses rather than the usual self-hosted debug stuff that
> Linux uses.
> 
> Given that, I'm not sure these are very generic, and I suspect it would be
> better to have more generic PERF_BR_ARCH_* entries for things like this.

Sure, will try and come up with something similar.

> 
> Thanks,
> Mark.
> 
>>  	PERF_BR_MAX,
>>  };
>>  
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 4cd39aaccbe7..1882054e8684 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -251,6 +251,11 @@ enum {
>>  	PERF_BR_SYSRET		= 8,	/* syscall return */
>>  	PERF_BR_COND_CALL	= 9,	/* conditional function call */
>>  	PERF_BR_COND_RET	= 10,	/* conditional function return */
>> +	PERF_BR_EXPT_RET	= 11,	/* exception return */
>> +	PERF_BR_IRQ		= 12,	/* irq */
>> +	PERF_BR_FIQ		= 13,	/* fiq */
>> +	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
>> +	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
>>  	PERF_BR_MAX,
>>  };
>>  
>> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
>> index 2285b1eb3128..74e5e67b1779 100644
>> --- a/tools/perf/util/branch.c
>> +++ b/tools/perf/util/branch.c
>> @@ -49,7 +49,12 @@ const char *branch_type_name(int type)
>>  		"SYSCALL",
>>  		"SYSRET",
>>  		"COND_CALL",
>> -		"COND_RET"
>> +		"COND_RET",
>> +		"EXPT_RET",
>> +		"IRQ",
>> +		"FIQ",
>> +		"DEBUG_HALT",
>> +		"DEBUG_EXIT"
>>  	};
>>  
>>  	if (type >= 0 && type < PERF_BR_MAX)
>> -- 
>> 2.25.1
>>
