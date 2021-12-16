Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D7476798
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhLPByk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:54:40 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33854 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhLPByj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:54:39 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDwCG514rzcbyy;
        Thu, 16 Dec 2021 09:54:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 09:54:30 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 09:54:30 +0800
Subject: Re: [PATCH v3] smp: Fix the comments of smp_call_function_many()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20211215122931.179-1-thunder.leizhen@huawei.com>
 <d07a3735-243a-535b-001a-c657f4305bf0@infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <714bf75a-7a2c-e01a-62b8-d83df0ff37a7@huawei.com>
Date:   Thu, 16 Dec 2021 09:54:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d07a3735-243a-535b-001a-c657f4305bf0@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/16 9:01, Randy Dunlap wrote:
> Hi,
> 
> On 12/15/21 04:29, Zhen Lei wrote:
>> As commit a32a4d8a815c ("smp: Run functions concurrently in
>> smp_call_function_many_cond()") itself says:
>>                   "Keep other smp_call_function_many() semantic as it is
>> today for backward compatibility: the called function is not executed in
>> this case locally."
>>
>> It's clear that, the function header comments of smp_call_function_many()
>> does not need to be changed.
>>
>> So move the comment about 'scf_flags' to smp_call_function_many_cond(),
>> and restore the original comments of smp_call_function_many(). The
>> comments have been simplified slightly to avoid duplication. And the
>> description of other parameters of smp_call_function_many_cond() is added.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/smp.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> v2 --> v3:
>> Add the descrition of other parameters of smp_call_function_many_cond().
> 
>           description
> 
> OK, this patch works (that is, scripts/kernel-doc does not complain).
> However:
> 
>>
>> v1 --> v2:
>> Delete some duplicate comments.
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index 01a7c1706a58b1d..46ef41d6b6f197e 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -853,14 +853,26 @@ int smp_call_function_any(const struct cpumask *mask,
>>  EXPORT_SYMBOL_GPL(smp_call_function_any);
>>  
>>  /*
>> - * Flags to be used as scf_flags argument of smp_call_function_many_cond().
>> - *
>>   * %SCF_WAIT:		Wait until function execution is completed
>>   * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
>>   */
>>  #define SCF_WAIT	(1U << 0)
>>  #define SCF_RUN_LOCAL	(1U << 1)
>>  
>> +/**
>> + * smp_call_function_many_cond(): Run a function on a set of CPUs.
> 
> The documented character to use after a function name is '-', not ':'. So
> 
>  * smp_call_function_many_cond() - Run a function on a set of CPUs

OK, I'll modify it, and change ":" to "-" for other functions in kernel/smp.c
with a new patch.

> 
> and
> 
>> + * @mask:	The set of cpus to run on (only runs on online subset).
>> + *		Whether to allow execution on the local CPU is also controlled
>> + *		by @scf_flags.
>> + * @func:	The function to run on all applicable CPUs.
>> + * @info:	An arbitrary pointer to pass to @func.
>> + * @scf_flags:	Bitmask that controls the operation. Such as SCF_WAIT,
>> + *		SCF_RUN_LOCAL.
>> + * @cond_func:	A callback function that is passed a cpu id and the info
>> + *		parameter. The function should return a blooean value
>> + *		indicating whether @func will be executed on the specified CPU.
>> + *		If @cond_func is NULL, that means unconditional, always true.
>> + */
>>  static void smp_call_function_many_cond(const struct cpumask *mask,
>>  					smp_call_func_t func, void *info,
>>  					unsigned int scf_flags,
>> @@ -972,14 +984,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>>  }
>>  
>>  /**
>> - * smp_call_function_many(): Run a function on a set of CPUs.
>> + * smp_call_function_many(): Run a function on a set of other CPUs.
> 
>  * smp_call_function_many() - Run a function on a set of other CPUs.
> 
> are preferable.
> 
>>   * @mask: The set of cpus to run on (only runs on online subset).
>>   * @func: The function to run. This must be fast and non-blocking.
>>   * @info: An arbitrary pointer to pass to the function.
>> - * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
>> - *        (atomically) until function has completed on other CPUs. If
>> - *        %SCF_RUN_LOCAL is set, the function will also be run locally
>> - *        if the local CPU is set in the @cpumask.
>> + * @wait: If true, wait (atomically) until function has completed
>> + *        on other CPUs.
>>   *
>>   * If @wait is true, then returns once @func has returned.
>>   *
>>
> 
> thanks.
> 
