Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9673B478A82
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhLQL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:57:26 -0500
Received: from foss.arm.com ([217.140.110.172]:56626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhLQL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:57:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 770BE1435;
        Fri, 17 Dec 2021 03:57:24 -0800 (PST)
Received: from [10.57.7.47] (unknown [10.57.7.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67473F5A1;
        Fri, 17 Dec 2021 03:57:21 -0800 (PST)
Subject: Re: [PATCH v4 6/6] perf tools: determine if LR is the return address
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211215151139.40854-1-german.gomez@arm.com>
 <20211215151139.40854-7-german.gomez@arm.com> <YboY541H4dVJDjyp@FVFF77S0Q05N>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <154f4a3b-d575-b1ab-cb78-8275aac61eac@arm.com>
Date:   Fri, 17 Dec 2021 11:57:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YboY541H4dVJDjyp@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your review comments

On 15/12/2021 16:33, Mark Rutland wrote:
> Hi,
>
> On Wed, Dec 15, 2021 at 03:11:38PM +0000, German Gomez wrote:
>> From: Alexandre Truong <alexandre.truong@arm.com>
>>
>> On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
>> use dwarf unwind info to check if the link register is the return
>> address in order to inject it to the frame pointer stack.
> This series looks good overall, but as a general note the commit messages are a
> bit hard to read because they jump into implementation details of the patch
> (i.e. the change the patch makes) before explaining the problem (i.e. what the
> patch is trying to solve).
>
> It would be nice to have a short introduction, e.g.

Thanks for the suggestion! I'll run through the logs to see if I can
improve them.

>
>   When unwinding using frame pointers on arm64, the return address of the
>   current leaf function may be missed. The return address of a leaf function
>   may live in the LR and/or a frame record (and the location can change within
>   a function), so it is necessary to use DWARF to identify where to look for
>   the return address at any given point during a function.
>
>   For example:
>
>   unsigned long foo(unsigned long i)
>   {
>           i += 2;
> 	  i += 5;
>   }
>
>   ... could be compiled as:
>
>   foo:
>   	// return addr in LR
>   	add	x0, x0, #2
> 	// return addr in LR
> 	stp	x29, x30, [SP, #-16]!
> 	// return addr in LR
> 	mov	x29, sp
> 	// return addr in LR *and* frame record
> 	add	x0, x0, #5
> 	// return addr in LR *and* frame record
> 	ldp	x29, x30, [sp], #16
> 	// return addr in LR
> 	ret
>
>> Write the following application:
>>
>> 	int a = 10;
>>
>> 	void f2(void)
>> 	{
>> 		for (int i = 0; i < 1000000; i++)
>> 			a *= a;
>> 	}
>>
>> 	void f1()
>> 	{
>> 		for (int i = 0; i < 10; i++)
>> 			f2();
>> 	}
>>
>> 	int main(void)
>> 	{
>> 		f1();
>> 		return 0;
>> 	}
>>
>> with the following compilation flags:
>>         gcc -fno-omit-frame-pointer -fno-inline -O2
>>
>> The compiler omits the frame pointer for f2 on arm. This is a problem
>> with any leaf call, for example an application with many different
>> calls to malloc() would always omit the calling frame, even if it
>> can be determined.
> I think the wording here is slightly misleading. For f2, the compiler *doesn't
> create a frame record*, but the frame pointer (to the caller's frame record)
> remains and is not omitted.
>
> Also, I think it's woth noting (as per the example I gave above) this applies
> to *any* function which is the current leaf function, regardless of whether
> that function creates a frame record at some point. For example, if `f1` is
> interrupted before it creates its own frame record (or after it destroys the
> frame record), the FP will point at the record created by `main` (containing
> the caller of main), and `main` itself will be missing from the unwind as it
> will only exist in the LR.

I see! I hadn't considered this. I guess it's not as likely to happen
but it's worth noting indeed.

>
>> 	./perf record --call-graph fp ./a.out
>> 	./perf report
>>
>> currently gives the following stack:
>>
>> 0xffffea52f361
>> _start
>> __libc_start_main
>> main
>> f2
>>
>> After this change, perf report correctly shows f1() calling f2(),
>> even though it was missing from the frame pointer unwind:
>>
>> 	./perf report
>>
>> 0xffffea52f361
>> _start
>> __libc_start_main
>> main
>> f1
>> f2
>>
>> Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> ---
>>  tools/perf/util/Build                         |  1 +
>>  .../util/arm64-frame-pointer-unwind-support.c | 63 +++++++++++++++++++
>>  .../util/arm64-frame-pointer-unwind-support.h | 10 +++
>>  tools/perf/util/machine.c                     | 19 ++++--
>>  tools/perf/util/machine.h                     |  1 +
>>  5 files changed, 89 insertions(+), 5 deletions(-)
>>  create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.c
>>  create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.h
>>
>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>> index 2e5bfbb69960..03d4c647bd86 100644
>> --- a/tools/perf/util/Build
>> +++ b/tools/perf/util/Build
>> @@ -1,3 +1,4 @@
>> +perf-y += arm64-frame-pointer-unwind-support.o
>>  perf-y += annotate.o
>>  perf-y += block-info.o
>>  perf-y += block-range.o
>> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
>> new file mode 100644
>> index 000000000000..4f5ecf51ed38
>> --- /dev/null
>> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "arm64-frame-pointer-unwind-support.h"
>> +#include "callchain.h"
>> +#include "event.h"
>> +#include "perf_regs.h" // SMPL_REG_MASK
>> +#include "unwind.h"
>> +
>> +#define perf_event_arm_regs perf_event_arm64_regs
>> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
>> +#undef perf_event_arm_regs
>> +
>> +struct entries {
>> +	u64 stack[2];
>> +	size_t length;
>> +};
>> +
>> +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
>> +{
>> +	return callchain_param.record_mode == CALLCHAIN_FP && sample->user_regs.regs
>> +		&& sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_LR);
>> +}
>> +
>> +static int add_entry(struct unwind_entry *entry, void *arg)
>> +{
>> +	struct entries *entries = arg;
>> +
>> +	entries->stack[entries->length++] = entry->ip;
>> +	return 0;
>> +}
>> +
>> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int usr_idx)
>> +{
>> +	int ret;
>> +	struct entries entries = {};
>> +	struct regs_dump old_regs = sample->user_regs;
>> +
>> +	if (!get_leaf_frame_caller_enabled(sample))
>> +		return 0;
>> +
>> +	/*
>> +	 * If PC and SP are not recorded, get the value of PC from the stack
>> +	 * and set its mask. SP is not used when doing the unwinding but it
>> +	 * still needs to be set to prevent failures.
>> +	 */
> To prevent failures where? Is this something libunwind requires?

Admittedly I haven't look very deep into libunwind, but SP seems to go
ignored when getting the last 2 entries only, so here we set it to any
value.

Thanks,
German
