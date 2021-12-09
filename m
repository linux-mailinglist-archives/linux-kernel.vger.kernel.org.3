Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E982346E9C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhLIOUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:21 -0500
Received: from foss.arm.com ([217.140.110.172]:57318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238463AbhLIOUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0521FB;
        Thu,  9 Dec 2021 06:16:46 -0800 (PST)
Received: from [10.57.33.188] (unknown [10.57.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48F843F73B;
        Thu,  9 Dec 2021 06:16:44 -0800 (PST)
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
 <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com>
 <20211209134413.GA622826@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <6a7fd600-91f3-5feb-d21f-ec7cb704f84c@arm.com>
Date:   Thu, 9 Dec 2021 14:16:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211209134413.GA622826@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2021 13:44, Leo Yan wrote:
> On Wed, Dec 08, 2021 at 02:08:04PM +0000, James Clark wrote:
>> On 08/12/2021 13:17, Leo Yan wrote:
>>> Hi James,
>>>
>>> On Wed, Dec 08, 2021 at 11:54:35AM +0000, James Clark wrote:
>>>> There are two checks, one is for size when running without admin, but
>>>> this one is covered by the driver and reported on in more detail here
>>>> (builtin-record.c):
>>>>
>>>>   pr_err("Permission error mapping pages.\n"
>>>>          "Consider increasing "
>>>>          "/proc/sys/kernel/perf_event_mlock_kb,\n"
>>>>          "or try again with a smaller value of -m/--mmap_pages.\n"
>>>>          "(current value: %u,%u)\n",
>>>
>>> I looked into the kernel code and found:
>>>
>>>   sysctl_perf_event_mlock = 512 + (PAGE_SIZE / 1024);  // 512KB + 1 page
>>>
>>> If the system have multiple cores, let's say 8 cores, then kernel even
>>> can relax the limitaion with:
>>>
>>>   user_lock_limit *= num_online_cpus();
>>>
>>> So means the memory lock limitation is:
>>>
>>>   (512KB + 1 page) * 8 = 4MB + 8 pages.
>>>
>>> Seems to me, it's much relax than the user space's limitaion 128KB.
>>> And let's imagine for Arm server, the permitted buffer size can be a
>>> huge value (e.g. for a system with 128 cores).
>>>
>>> Could you confirm if this is right?
>>
>> Yes that seems to be the case. And the commit message for that addition
>> states the reasoning:
>>
>>   perf_counter: Increase mmap limit
>>   
>>   In a default 'perf top' run the tool will create a counter for
>>   each online CPU. With enough CPUs this will eventually exhaust
>>   the default limit.
>>
>>   So scale it up with the number of online CPUs.
>>
>> To me that makes sense. Normally the memory installed also scales with the
>> number of cores.
>>
>> Are you saying that we should look into modifying that scaling factor in
>> perf_mmap()? Or that we should still add something to userspace for
>> coresight to limit user supplied buffer sizes?
> 
> I don't think we should modify the scaling factor in perf_mmap(), the
> logic is not only used by AUX buffer, it's shared by normal event
> ring buffer.
> 
>> I think it makes sense to allow the user to specify any value that will work,
>> it's up to them.
> 
> Understand, I verified this patch with below steps:
> 
> root@debian:~# echo 0 > /proc/sys/kernel/perf_event_paranoid
> 
> leoy@debian:~$ perf record -e cs_etm// -m 4M,8M -o perf_test.data -- sleep 1
> Permission error mapping pages.
> Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
> or try again with a smaller value of -m/--mmap_pages.
> (current value: 1024,2048)
> 
> leoy@debian:~$ perf record -e cs_etm// -m 4M,4M -o perf_test.data -- sleep 1
> Couldn't synthesize bpf events.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.607 MB perf_test.data ]
> 
> So this patch looks good for me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
Thanks Leo!
