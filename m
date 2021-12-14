Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F95473D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLNHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:24:55 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29129 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhLNHYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:24:55 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JCqZC0kpnz1DJw6;
        Tue, 14 Dec 2021 15:21:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 15:24:53 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 15:24:52 +0800
Subject: Re: [PATCH] smp: Fix the comments of smp_call_function_many()
To:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20211213035755.73-1-thunder.leizhen@huawei.com>
 <4493a665-23f9-0a39-6d9a-ec3bb97e7015@intel.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2871cf9d-ed8d-975f-ba46-429f8fe8560e@huawei.com>
Date:   Tue, 14 Dec 2021 15:24:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4493a665-23f9-0a39-6d9a-ec3bb97e7015@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/14 2:05, Dave Hansen wrote:
> On 12/12/21 7:57 PM, Zhen Lei wrote:
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index 01a7c1706a58b1d..6ec884f41b7506d 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -861,6 +861,13 @@ EXPORT_SYMBOL_GPL(smp_call_function_any);
>>  #define SCF_WAIT	(1U << 0)
>>  #define SCF_RUN_LOCAL	(1U << 1)
>>  
>> +/**
>> + * smp_call_function_many_cond(): Run a function on a set of CPUs.
>> + * @scf_flags: Bitmask that controls the operation. If %SCF_WAIT is set,
>> + *        wait (atomically) until function has completed on other CPUs. If
>> + *        %SCF_RUN_LOCAL is set, the function will also be run locally
>> + *        if the local CPU is set in the @cpumask.
>> + */
> 
> Fixing up the smp_call_function_many() comment is a good idea.  But, the
> new smp_call_function_many_cond() comment duplicates these which are
> _just_ above it:

Yes, maybe we just need to list SCF_WAIT and SCF_RUN_LOCAL here.

> 
>> /*
>>  * Flags to be used as scf_flags argument of smp_call_function_many_cond().
>>  *
>>  * %SCF_WAIT:           Wait until function execution is completed
>>  * %SCF_RUN_LOCAL:      Run also locally if local cpu is set in cpumask
>>  */
>> #define SCF_WAIT        (1U << 0)
>> #define SCF_RUN_LOCAL   (1U << 1)
> 
> Could we comment the bits in one place?

Yes, I think we should delete the line "Flags to be used ..."

> .
> 
