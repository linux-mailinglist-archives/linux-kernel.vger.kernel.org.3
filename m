Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22924D1065
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiCHGnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiCHGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:43:12 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA93CFE4;
        Mon,  7 Mar 2022 22:42:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6crQw4_1646721730;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V6crQw4_1646721730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 14:42:12 +0800
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com>
 <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
 <CABPqkBQTkfofi0-92iMRSfgZDHwCxpOD0GmhvAtOruhO=M1gKg@mail.gmail.com>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <17f24adb-c1af-8c51-d5a9-63b45a7bdcbd@linux.alibaba.com>
Date:   Tue, 8 Mar 2022 14:42:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBQTkfofi0-92iMRSfgZDHwCxpOD0GmhvAtOruhO=M1gKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/8 上午1:14, Stephane Eranian 写道:
> On Sun, Mar 6, 2022 at 6:36 AM Wen Yang <wenyang@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2022/3/4 下午11:39, Peter Zijlstra 写道:
>>> On Fri, Mar 04, 2022 at 07:03:51PM +0800, Wen Yang wrote:
>>>> this issue has been there for a long time, we could reproduce it as follows:
>>>
>>> What issue? You've not described an issue. So you cannot reference one.
>>>
>>
>> OK, thank you for your opinion. Let's explain it.
>>
>>
>>> This is still completely unreadable gibberish.
>>>
>>>> 1, run a script that periodically collects perf data, eg:
>>>> while true
>>>> do
>>>>       perf stat -e cache-misses,cache-misses,cache-misses -c 1 sleep 2
>>>>       perf stat -e cache-misses -c 1 sleep 2
>>>>       sleep 1
>>>> done
>>>>
>>>> 2, run another one to capture the ipc, eg:
>>>> perf stat -e cycles:d,instructions:d  -c 1 -i 1000
>>>
>>> <snip line noise>
>>>
>>>> the reason is that the nmi watchdog permanently consumes one fp
>>>> (*cycles*). therefore, when the above shell script obtains *cycles*
>>>> again, only one gp can be used, and its weight is 5.
>>>> but other events (like *cache-misses*) have a weight of 4,
>>>> so the counter used by *cycles* will often be taken away, as in
>>>> the raw data above:
>>>> [1]
>>>>     n_events = 3
>>>>     assign = {33, 1, 32, ...}
>>>> -->
>>>>     n_events = 6
>>>>     assign = {33, 3, 32, 0, 1, 2, ...}
>>>
>>> Again unreadable... what do any of those numbers mean?
>>>
>>
>> Scenario: a monitor program will monitor the CPI on a specific CPU in
>> pinned mode for a long time, such as the CPI in the original email:
>>       perf stat -e cycles:D,instructions:D  -C 1 -I 1000
>>
>> Perf here is just an example. Our monitor program will continuously read
>> the counter values of these perf events (cycles and instructions).
>>
>> However, it is found that CPI data will be abnormal periodically because
>> PMU counter conflicts. For example, scripts in e-mail will cause
>> interference:
>>       perf stat -e cache-misses,cache-misses,cache-misses -C 1 sleep 2
>>       perf stat -e cache-misses -C 1 sleep 2
>>
>>     n_events = 3
>>     assign = {33, 1, 32, ...}
>> -->
>>     n_events = 6
>>     assign = {33, 3, 32, 0, 1, 2, ...}
>>
>> They are some fields of cpu_hw_events structure.
>> int n_events; /* the # of events in the below arrays */
>> int assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
>> struct perf_event *event_list[X86_PMC_IDX_MAX]; /* in enabled order */
>>
>> 32: intel_pmc_idx_fixed_instructions
>> 33: intel_pmc_idx_fixed_cpu_cycles
>> 34: intel_pmc_idx_fixed_ref_cycles
>> 0,1,2,3: gp
>>
>>
>> n_events = 3
>> assign = {33, 1, 32, ...}
>> event_list = {0xffff88bf77b85000, 0xffff88b72db82000,
>> 0xffff88b72db85800, ...}
>>
>> —>
>> Indicates that there are 3 perf events on CPU 1, which occupy the
>> #fixed_cpu_cycles, #1 and #fixed_instruction counter one by one.
>> These 3 perf events are generated by the NMI watchdog and the script A:
>> perf stat -e cycles:D,instructions:D  -C 1 -I 1000
>>
>>
>> n_events = 6
>> assign = {33, 3, 32, 0, 1, 2, ...}
>> event_list = {0xffff88bf77b85000, 0xffff88b72db82000,
>> 0xffff88b72db85800, 0xffff88bf46c34000, 0xffff88bf46c35000,
>> 0xffff88bf46c30000,  ...}
>>
>> —>
>> Indicates that there are 6 perf events on CPU 1, which occupy the
>> #fixed_cpu_cycles, #3, #fixed_instruction, #0, #1 and #2 counter one by one.
>> These 6 perf events are generated by the NMI watchdog and the script A
>> and B:
>> perf stat -e cycles:D,instructions:D  -C 1 -I 1000
>> perf stat -e cache-misses,cache-misses,cache-misses -C 1 sleep 2
>>
>> 0xffff88bf77b85000:
>> The perf event generated by NMI watchdog, which has always occupied
>> #fixed_cpu_cycles
>>
>> 0xffff88b72db82000:
>> The perf event generated by the above script A (cycles:D), and the
>> counter it used changes from #1 to #3. We use perf event in pinned mode,
>> and then continuously read its value for a long time, but its PMU
>> counter changes, so the counter value will also jump.
>>
> What you are describing here is working as expected. Pinning an event DOES NOT
> mean pinning the event to a counter for the whole measurement. It
> means the event
> will always be measured on "a" counter. But that counter can change
> overtime. Moving
> the event to a different counter SHOULD NOT change its value assuming
> you use official
> API to read the counter, i.e., the read() syscall or rdpmc using the
> official guideline for it.
> 

Perhaps the following code could ensure that the pmu counter value is 
stable:


     /*
      * Careful: an NMI might modify the previous event value.
      *
      * Our tactic to handle this is to first atomically read and
      * exchange a new raw count - then add that new-prev delta
      * count to the generic event atomically:
      */
again:
     prev_raw_count = local64_read(&hwc->prev_count);
     rdpmcl(hwc->event_base_rdpmc, new_raw_count);

     if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
                     new_raw_count) != prev_raw_count)
         goto again;


It might be better if we could reduce the calls to goto again.


>>
>>
>> 0xffff88b72db85800:
>> The perf event generated by the above script A (instructions:D), which
>> has always occupied #fixed_instruction.
>>
>> 0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000:
>> Theses perf events are generated by the above script B.
>>
>>
>>>>
>>>> so it will cause unnecessary pmu_stop/start and also cause abnormal cpi.
>>>
>>> How?!?
>>>
>>
>> We may refer to the x86_pmu_enable function:
>> step1: save events moving to new counters
>> step2: reprogram moved events into new counters
>>
>> especially:
>>
>> static inline int match_prev_assignment(struct hw_perf_event *hwc,
>>                       struct cpu_hw_events *cpuc,
>>                       int i)
>> {
>>       return hwc->idx == cpuc->assign[i] &&
>>           hwc->last_cpu == smp_processor_id() &&
>>           hwc->last_tag == cpuc->tags[i];
>> }
>>
>>
>>
>>>> Cloud servers usually continuously monitor the cpi data of some important
>>>> services. This issue affects performance and misleads monitoring.
>>>>
>>>> The current event scheduling algorithm is more than 10 years old:
>>>> commit 1da53e023029 ("perf_events, x86: Improve x86 event scheduling")
>>>
>>> irrelevant
>>>
>>
>> commit 1da53e023029 ("perf_events, x86: Improve x86 event scheduling")
>>
>> This commit is the basis of the perf event scheduling algorithm we
>> currently use.
>> The reason why the counter above changed from #1 to #3 can be found from it:
>> The algorithm takes into account the list of counter constraints
>> for each event. It assigns events to counters from the most
>> constrained, i.e., works on only one counter, to the least
>> constrained, i.e., works on any counter.
>>
>> the nmi watchdog permanently consumes one fp (*cycles*).
>>    therefore, when the above shell script obtains *cycles:D*
>> again, it has to use a GP, and its weight is 5.
>> but other events (like *cache-misses*) have a weight of 4,
>> so the counter used by *cycles:D* will often be taken away.
>>
> And that 's normal. Measuring cycles on a generic counter or fixed
> counter does not
> change what is counted or the precision of it.
> 

Well, it's generally OK, although it wastes a valuable GP.
However, on the ECS clusters, there are various monitoring programs, and 
the PMU counters are not enough.
Our subsequent patch will be optimized as follows: all fixed perf events 
(such as cycles) will be read from the same PMU counter unless the 
sampling period is set.


>>
>> In addition, we also found that this problem may affect NMI watchdog in
>> the production cluster.
>> The NMI watchdog also uses a fixed counter in fixed mode. Usually, it is
>> The first element of the event_list array, so it usually takes
>> precedence and can get a fixed counter.
> 
> 
> Not true. The NMI watchdog does not request a fixed counter. There is
> no way to do this.
> It just lands on the fixed counter because the scheduling algorithm
> favors fixed counters whenever
> possible.
> 
>>
>> But if the administrator closes the watchdog first and then enables it,
>> it may be at the end of the event_list array, so its expected fixed
>> counter may be occupied by other perf event, and it can only use one GP.
>> In this way, there is a similar issue here: the PMU counter used by the
>> NMI watchdog may be disabled/enabled frequently and unnecessarily.
>>
> Yes, and I don't think this is a problem.
> You are trying to get counter guarantee but the interface DOES NOT
> give this to users
> and should not in my opinion.
> 

The existing code is already trying to reuse the previous PMU counters, 
such as:

     /*
      * fastpath, try to reuse previous register
      */
     for (i = 0; i < n; i++) {
         u64 mask;

         hwc = &cpuc->event_list[i]->hw;
         c = cpuc->event_constraint[i];

         /* never assigned */
         if (hwc->idx == -1)
             break;

         /* constraint still honored */
         if (!test_bit(hwc->idx, c->idxmsk))
             break;

         mask = BIT_ULL(hwc->idx);
         if (is_counter_pair(hwc))
             mask |= mask << 1;

         /* not already used */
         if (used_mask & mask)
             break;

         used_mask |= mask;

         if (assign)
             assign[i] = hwc->idx;
     }


But it only works when the perf events are reduced.

Now we want to extend this idea a bit. In the scenario of increasing 
perf events, we also try to reuse the previous PMU counters.
Finally, if this attempt fails, still go back to the original algorithm 
and reassign all PMU counters. eg:

  	/* slow path */
-	if (i != n)
-		unsched = _perf_assign_events(constraints, n,
-				wmin, wmax, gpmax, assign);
+	if (i != n) {
+		unsched = _perf_assign_events(constraints, n, wmin, wmax, gpmax,
+				msk_counters, msk_event, assign);
+		if (unsched)
+			unsched = _perf_assign_events(constraints, n, wmin, wmax, gpmax,
+					0, 0, assign);
+	}


Your guidance has been particularly helpful, and we look forward to 
your comments and input during this session.

Best wishes,
Wen


>>
>> Any advice or guidance on this would be appreciated.
>>
>> Best wishes,
>> Wen
>>
>>
>>>> we wish it could be optimized a bit.
>>>
>>> I wish for a unicorn ...
>>>
>>>> The fields msk_counters and msk_events are added to indicate currently
>>>> used counters and events so that the used ones can be skipped
>>>> in __perf_sched_find_counter and perf_sched_next_event functions to avoid
>>>> unnecessary pmu_stop/start.
>>>
>>> Still not sure what your actual problem is, nor what the actual proposal
>>> is.
>>>
>>> Why should I attempt to reverse engineer your code without basic
>>> understanding of what you're actually trying to achieve?
>>>
>>
>>
>>
