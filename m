Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5086846D542
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhLHOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:11:52 -0500
Received: from foss.arm.com ([217.140.110.172]:60830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235006AbhLHOLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:11:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A5CD6E;
        Wed,  8 Dec 2021 06:08:11 -0800 (PST)
Received: from [10.57.34.62] (unknown [10.57.34.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3763B3F73B;
        Wed,  8 Dec 2021 06:08:08 -0800 (PST)
Subject: Re: [PATCH] perf cs-etm: Remove duplicate and incorrect aux size
 checks
To:     Leo Yan <leo.yan@linaro.org>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211208115435.610101-1-james.clark@arm.com>
 <20211208131753.GC273781@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com>
Date:   Wed, 8 Dec 2021 14:08:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208131753.GC273781@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/12/2021 13:17, Leo Yan wrote:
> Hi James,
> 
> On Wed, Dec 08, 2021 at 11:54:35AM +0000, James Clark wrote:
>> There are two checks, one is for size when running without admin, but
>> this one is covered by the driver and reported on in more detail here
>> (builtin-record.c):
>>
>>   pr_err("Permission error mapping pages.\n"
>>          "Consider increasing "
>>          "/proc/sys/kernel/perf_event_mlock_kb,\n"
>>          "or try again with a smaller value of -m/--mmap_pages.\n"
>>          "(current value: %u,%u)\n",
> 
> I looked into the kernel code and found:
> 
>   sysctl_perf_event_mlock = 512 + (PAGE_SIZE / 1024);  // 512KB + 1 page
> 
> If the system have multiple cores, let's say 8 cores, then kernel even
> can relax the limitaion with:
> 
>   user_lock_limit *= num_online_cpus();
> 
> So means the memory lock limitation is:
> 
>   (512KB + 1 page) * 8 = 4MB + 8 pages.
> 
> Seems to me, it's much relax than the user space's limitaion 128KB.
> And let's imagine for Arm server, the permitted buffer size can be a
> huge value (e.g. for a system with 128 cores).
> 
> Could you confirm if this is right?

Yes that seems to be the case. And the commit message for that addition
states the reasoning:

  perf_counter: Increase mmap limit
  
  In a default 'perf top' run the tool will create a counter for
  each online CPU. With enough CPUs this will eventually exhaust
  the default limit.

  So scale it up with the number of online CPUs.

To me that makes sense. Normally the memory installed also scales with the
number of cores.

Are you saying that we should look into modifying that scaling factor in
perf_mmap()? Or that we should still add something to userspace for
coresight to limit user supplied buffer sizes?

I think it makes sense to allow the user to specify any value that will work,
it's up to them.

James

> 
> Thanks,
> Leo
> 
>> This had the effect of artificially limiting the aux buffer size to a
>> value smaller than what was allowed because perf_event_mlock_kb wasn't
>> taken into account.
>>
>> The second is to check for a power of two, but this is covered here
>> (evlist.c):
>>
>>   pr_info("rounding mmap pages size to %s (%lu pages)\n",
>>           buf, pages);
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm/util/cs-etm.c | 19 -------------------
>>  1 file changed, 19 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index 293a23bf8be3..8a3d54a86c9c 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -407,25 +407,6 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>  
>>  	}
>>  
>> -	/* Validate auxtrace_mmap_pages provided by user */
>> -	if (opts->auxtrace_mmap_pages) {
>> -		unsigned int max_page = (KiB(128) / page_size);
>> -		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
>> -
>> -		if (!privileged &&
>> -		    opts->auxtrace_mmap_pages > max_page) {
>> -			opts->auxtrace_mmap_pages = max_page;
>> -			pr_err("auxtrace too big, truncating to %d\n",
>> -			       max_page);
>> -		}
>> -
>> -		if (!is_power_of_2(sz)) {
>> -			pr_err("Invalid mmap size for %s: must be a power of 2\n",
>> -			       CORESIGHT_ETM_PMU_NAME);
>> -			return -EINVAL;
>> -		}
>> -	}
>> -
>>  	if (opts->auxtrace_snapshot_mode)
>>  		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
>>  			  opts->auxtrace_snapshot_size);
>> -- 
>> 2.28.0
>>
