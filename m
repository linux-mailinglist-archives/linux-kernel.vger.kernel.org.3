Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521AC475439
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbhLOIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:24:48 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16813 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhLOIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:24:47 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDSvP2ZMWz91l0;
        Wed, 15 Dec 2021 16:24:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 16:24:45 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 16:24:45 +0800
Subject: Re: [PATCH v2] smp: Fix the comments of smp_call_function_many()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20211214081100.126-1-thunder.leizhen@huawei.com>
 <dda484cf-d974-dba3-db54-4df470a1ff2e@infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8fae1b1f-9358-71e7-18fd-0ed434d5a7f4@huawei.com>
Date:   Wed, 15 Dec 2021 16:24:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <dda484cf-d974-dba3-db54-4df470a1ff2e@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/14 23:56, Randy Dunlap wrote:
> Hi,
> 
> On 12/14/21 00:10, Zhen Lei wrote:
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
>> and restore the original comments of smp_call_function_many().
>>
>> Finally, the comments have been simplified slightly to avoid duplication.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/smp.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> v1 --> v2:
>> Delete some duplicate comments.
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index 01a7c1706a58b1d..9cbe2509d1010ea 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -853,14 +853,17 @@ int smp_call_function_any(const struct cpumask *mask,
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
>> + * @scf_flags: Bitmask that controls the operation. Such as SCF_WAIT,
>> + *             SCF_RUN_LOCAL.
>> + */
>>  static void smp_call_function_many_cond(const struct cpumask *mask,
>>  					smp_call_func_t func, void *info,
>>  					unsigned int scf_flags,
>> @@ -972,14 +975,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>>  }
>>  
>>  /**
>> - * smp_call_function_many(): Run a function on a set of CPUs.
>> + * smp_call_function_many(): Run a function on a set of other CPUs.
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
> 
> After applying this patch, kernel-doc emits 4 warnings:
> 
> smp.c:871: warning: Function parameter or member 'mask' not described in 'smp_call_function_many_cond'
> smp.c:871: warning: Function parameter or member 'func' not described in 'smp_call_function_many_cond'
> smp.c:871: warning: Function parameter or member 'info' not described in 'smp_call_function_many_cond'
> smp.c:871: warning: Function parameter or member 'cond_func' not described in 'smp_call_function_many_cond'

OK, I will complete the comments in the next version. Thanks.


> 
> 
> thanks.
> 
