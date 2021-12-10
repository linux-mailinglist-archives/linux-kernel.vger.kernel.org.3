Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839324703DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhLJPco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:32:44 -0500
Received: from foss.arm.com ([217.140.110.172]:43280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhLJPcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:32:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9343D106F;
        Fri, 10 Dec 2021 07:29:07 -0800 (PST)
Received: from [10.57.6.190] (unknown [10.57.6.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88E1A3F5A1;
        Fri, 10 Dec 2021 07:29:04 -0800 (PST)
Subject: Re: [PATCH v1 1/4] perf tools: Prevent out-of-bounds access to
 registers
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        kajoljain <kjain@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-2-german.gomez@arm.com>
 <6705021e-5b02-3323-7dbc-4b774f22a435@linux.ibm.com>
 <YbNYUC1poqzrWynP@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <42c6ea29-5904-bb8b-d9c6-a0516c3a564f@arm.com>
Date:   Fri, 10 Dec 2021 15:28:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbNYUC1poqzrWynP@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/2021 13:38, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 10, 2021 at 02:47:49PM +0530, kajoljain escreveu:
>>
>> On 12/1/21 6:03 PM, German Gomez wrote:
>>> The size of the cache of register values is arch-dependant
>>> (PERF_REGS_MAX). This has the potential of causing an out-of-bounds
>>> access in the function "perf_reg_value" if the local architecture
>>> contains less registers than the one the perf.data file was recorded on.
>>>
>>> Since the maximum number of registers is bound by the bitmask "u64
>>> cache_mask", and the size of the cache when running under x86 systems is
>>> 64 already, fix the size to 64 and add a range-check to the function
>>> "perf_reg_value" to prevent out-of-bounds access.
>>>
>> Patch looks good to me.
>>
>> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> Thanks, applied.
>
> - Arnaldo

Thanks Arnaldo, and the rest for the review.

I did send a v2 of this patch afterwards. The only difference was to
give credit to the reporter in the commit message with:

Reported-by: Alexandre Truong <alexandre.truong@arm.com>

Thanks,
German

>  
>> Thanks,
>> Kajol Jain
>>
>>> Signed-off-by: German Gomez <german.gomez@arm.com>
>>> ---
>>>  tools/perf/util/event.h     | 5 ++++-
>>>  tools/perf/util/perf_regs.c | 3 +++
>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
>>> index 95ffed663..c59331eea 100644
>>> --- a/tools/perf/util/event.h
>>> +++ b/tools/perf/util/event.h
>>> @@ -44,13 +44,16 @@ struct perf_event_attr;
>>>  /* perf sample has 16 bits size limit */
>>>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>>>  
>>> +/* number of register is bound by the number of bits in regs_dump::mask (64) */
>>> +#define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
>>> +
>>>  struct regs_dump {
>>>  	u64 abi;
>>>  	u64 mask;
>>>  	u64 *regs;
>>>  
>>>  	/* Cached values/mask filled by first register access. */
>>> -	u64 cache_regs[PERF_REGS_MAX];
>>> +	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
>>>  	u64 cache_mask;
>>>  };
>>>  
>>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>>> index 5ee47ae15..06a7461ba 100644
>>> --- a/tools/perf/util/perf_regs.c
>>> +++ b/tools/perf/util/perf_regs.c
>>> @@ -25,6 +25,9 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
>>>  	int i, idx = 0;
>>>  	u64 mask = regs->mask;
>>>  
>>> +	if ((u64)id >= PERF_SAMPLE_REGS_CACHE_SIZE)
>>> +		return -EINVAL;
>>> +
>>>  	if (regs->cache_mask & (1ULL << id))
>>>  		goto out;
>>>  
>>>
