Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3B4E51DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiCWMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbiCWMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:10:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 690A75FBD;
        Wed, 23 Mar 2022 05:08:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DA521477;
        Wed, 23 Mar 2022 05:08:30 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D013E3F73B;
        Wed, 23 Mar 2022 05:08:27 -0700 (PDT)
Message-ID: <806411f4-d284-6734-52cc-3d922a4da5bb@arm.com>
Date:   Wed, 23 Mar 2022 12:08:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/10] coresight: Add new API to allocate trace source ID
 values
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        James Clark <James.Clark@arm.com>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <e890feb0-9f90-c0f2-e5f0-10ed5dbe6d81@arm.com>
 <CAJ9a7VhzwMri1Lz5mtO5um3-tT9=GUpGN3cHJhkW5TTsbOKbgQ@mail.gmail.com>
 <639c902b-535e-8627-de04-9bcbbdc98ed5@arm.com>
 <CAJ9a7VhyFj9vcUFjrwtqn47LbdqHp+gQCvtDBNX69-=Y5-2iag@mail.gmail.com>
 <17215ebc-dbf2-81ca-7ef4-b4ebc3cb9d28@arm.com>
 <CAJ9a7VjZm=QAKhPJwewO3i3Qyc3C-jbzJKSoCk+Gr+_FXGR9oQ@mail.gmail.com>
 <f9c3b007-fbbc-3c2e-2542-1c77eb061c2f@arm.com>
 <CAJ9a7VgOvAKQ2hPAptAYunX6zaaj76eOC26iouy7X0BeKXmWpw@mail.gmail.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VgOvAKQ2hPAptAYunX6zaaj76eOC26iouy7X0BeKXmWpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 23/03/2022 11:35, Mike Leach wrote:
> Hi Suzuki
> 
> On Wed, 23 Mar 2022 at 10:41, Suzuki Kuruppassery Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> Hi Mike
>>
>> On 23/03/2022 10:07, Mike Leach wrote:
>>> Hi Suzuki,
>>>
>>> On Tue, 22 Mar 2022 at 18:52, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> Hi Mike
>>>>
>>>> On 22/03/2022 14:27, Mike Leach wrote:
>>>>> Hi Suzuki
>>>>>
>>>>> On Tue, 22 Mar 2022 at 12:35, Suzuki Kuruppassery Poulose
>>>>> <suzuki.poulose@arm.com> wrote:
>>>>>>
>>>>>> On 22/03/2022 11:38, Mike Leach wrote:
>>>>>>> HI Suzuki,
>>>>>>>
>>>>>>> On Tue, 22 Mar 2022 at 10:43, Suzuki Kuruppassery Poulose
>>>>>>> <suzuki.poulose@arm.com> wrote:
>>>>>>>>
>>>>>>>> + Cc: James Clark
>>>>>>>>
>>>>>>>> Hi Mike,
>>>>>>>>
>>>>>>>> On 08/03/2022 20:49, Mike Leach wrote:
>>>>>>>>> The current method for allocating trace source ID values to sources is
>>>>>>>>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
>>>>>>>>> The STM is allocated ID 0x1.
>>>>>>>>>
>>>>>>>>> This fixed algorithm is used in both the CoreSight driver code, and by
>>>>>>>>> perf when writing the trace metadata in the AUXTRACE_INFO record.
>>>>>>>>>
>>>>>>>>> The method needs replacing as currently:-
>>>>>>>>> 1. It is inefficient in using available IDs.
>>>>>>>>> 2. Does not scale to larger systems with many cores and the algorithm
>>>>>>>>> has no limits so will generate invalid trace IDs for cpu number > 44.
>>>>>>>>
>>>>>>>> Thanks for addressing this issue.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Additionally requirements to allocate additional system IDs on some
>>>>>>>>> systems have been seen.
>>>>>>>>>
>>>>>>>>> This patch set  introduces an API that allows the allocation of trace IDs
>>>>>>>>> in a dynamic manner.
>>>>>>>>>
>>>>>>>>> Architecturally reserved IDs are never allocated, and the system is
>>>>>>>>> limited to allocating only valid IDs.
>>>>>>>>>
>>>>>>>>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
>>>>>>>>> the new API.
>>>>>>>>>
>>>>>>>>> perf handling is changed so that the ID associated with the CPU is read
>>>>>>>>> from sysfs. The ID allocator is notified when perf events start and stop
>>>>>>>>> so CPU based IDs are kept constant throughout any perf session.
>>>>>>>>>
>>>>>>>>> For the ETMx.x devices IDs are allocated on certain events
>>>>>>>>> a) When using sysfs, an ID will be allocated on hardware enable, and freed
>>>>>>>>> when the sysfs reset is written.
>>>>>>>>> b) When using perf, ID is allocated on hardware enable, and freed on
>>>>>>>>> hardware disable.
>>>>>>>>>
>>>>>>>>> For both cases the ID is allocated when sysfs is read to get the current
>>>>>>>>> trace ID. This ensures that consistent decode metadata can be extracted
>>>>>>>>> from the system where this read occurs before device enable.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Note: This patchset breaks backward compatibility for perf record.
>>>>>>>>> Because the method for generating the AUXTRACE_INFO meta data has
>>>>>>>>> changed, using an older perf record will result in metadata that
>>>>>>>>> does not match the trace IDs used in the recorded trace data.
>>>>>>>>> This mismatch will cause subsequent decode to fail. Older versions of
>>>>>>>>> perf will still be able to decode data generated by the updated system.
>>>>>>>>
>>>>>>>> I have some concerns over this and the future plans for the dynamic
>>>>>>>> allocation per sink. i.e., we are breaking/modifying the perf now to
>>>>>>>> accommodate the dynamic nature of the trace id of a given CPU/ETM.
>>>>>>>
>>>>>>> I don't beleive we have a choice for this - we cannot retain what is
>>>>>>> an essentially broken allocation mechanism.
>>>>>>>
>>>>>>
>>>>>> I completely agree and I am happy with the current step by step approach
>>>>>> of moving to a dynamic allocation scheme. Apologies, this wasn't
>>>>>> conveyed appropriately.
>>>>>>
>>>>>>>> The proposed approach of exposing this via sysfs may (am not sure if
>>>>>>>> this would be the case) break for the trace-id per sink change, as a
>>>>>>>> sink could assign different trace-id for a CPU depending.
>>>>>>>>
>>>>>>>
>>>>>>> If a path exists between a CPU and a sink - the current framework as
>>>>>>> far as I can tell would not allow for a new path to be set up between
>>>>>>> the cpu and another sink.
>>>>>>
>>>>>> e.g, if we have concurrent perf sessions, in the future with sink  based
>>>>>> allocation :
>>>>>>
>>>>>> perf record -e cs_etm/@sink1/... payload1
>>>>>> perf record -e cs_etm/@sink2/... payload2
>>>>>> perf record -e cs_etm// ...      payload3
>>>>>>
>>>>>> The trace id allocated for first session for CPU0 *could* be different
>>>>>> from that of the second or the third.
>>>>>
>>>>> If these sessions run concurrently then the same Trace ID will be used
>>>>> for CPU0 for all the sessions.
>>>>> We ensure this by notifications that a cs_etm session is starting and
>>>>> stopping - and keep a refcount.
>>>>
>>>> The scheme is fine now, with a global trace-id map. But with per-sink
>>>> allocation, this could cause problems.
>>>>
>>>> e.g., there could be a situation where:
>>>>
>>>> trace_id[CPU0][sink0] == trace_id[CPU1][sink1]
>>>>
>>>> So if we have a session where both CPU0 and CPU1 trace to a common sink,
>>>> we get the trace mixed with no way of splitting them. As the perf will
>>>> read the trace-id for CPU0 from that of sink0 and CPU1 from sink1.
>>>
>>> I think we need to consider the CoreSight hardware topology here.
>>>
>>> Any CPUx that can trace to a sink reachable by another CPUy must
>>> always get trace IDs from the same pool as CPUy.
>>>
>>> Consider the options for multi sink topologies:-
>>>
>>> CPU0->funnel0->ETF->ETR
>>> CPU1--+^
>>>
>>> Clearly - in-line sinks can never have simultaneous independent
>>> sessions - the session into ETR traces through ETF
>>>
>>> Now we could have replicators / programmable replicators -
>>>
>>> ATB->Prog replicator->ETR0
>>>                                    +->ETR1
>>>
>>> however programmable replicators use trace ID for filtering - this is
>>> effectively a single sink on the input, so once again the Trace IDs
>>> must come from the same pool.
>>>
>>> Now, we could have independent per cluster / socket topology
>>> Cluster 0
>>> CPU0->funnel0->ETF0->ETR0
>>> CPU1--+^
>>>
>>> Cluster 1
>>> CPU2->funnel1->ETF1->ETR1
>>> CPU3--+^
>>>
>>
>> What if the ETR was a common one ? i.e.
>>
>> Cluster0
>> CPU0 -> ETF0 .....
>>                      \
>> Cluster1            -- ETR0
>> CPU1 -> ETF1 ..... /
>>
>> And lets there are 3 perf sessions in parallel, started in the
>> order below
>>
>> perf record -e cs_etm/@etf0/ app1 # CPU0 gets a trace-id[etf0] -> 0x50
>> perf record -e cs_etm/@etf1/ app2 # CPU1 gets a trace-id[etf1] -> 0x50
>> perf record -e cs_etm/@etr/  app3 # CPU0 and CPU1 both use the existing
>> trace ids from the allocations.
>>
> 
> This could be treated as a single combined topology - as soon as any
> sink is reachable by CPU0 and CPU1 then we have to treat this as
> having a single pool of trace IDs and so CPU0 and CPU1 cannot have the
> same ID.

IIUC, that is indeed going to be much more complex than, allocating
trace-id per sink. Moreover, we are going to end up "enforcing" the
pool (with a global system wide ETR) restriction to a sink that is local
to a cluster for e.g. And thus could be back to square 1.

> Alternatively, once the allocation metadata is expanded to recognize
> trace ID pools - it is entirely possible to ensure that the CPU / ID
> fixing is done on a per pool basis.
> 
> One of the reasons we need to ensure that the CPU / ID allocation
> remains constant is that an event can be scheduled on a CPU multiple
> times for a single aux buffer - resulting in multiple trace blocks in
> the buffer / multiple buffers in the data file, so we cannot have the
> ID change mid buffer / file without significant changes to the decode
> process and tracking of CPU / ID changes on a intra buffer basis.

Correct, and we must not. My proposal is not to change the traceid of a 
CPU for a given "perf record". But, instead, since the sink for a CPU is
fixed for a given "perf record" and it can't change, we can allocate
a traceid map per sink, which will remain the same in a given record.

Cheers
Suzuki



> Mike
> 
>> So, when app3 threads are scheduled on CPU0 & CPU1, we get the trace in
>> ETR with the same trace-id of 0x50.
>>
>> Suzuki
> 
> 
> 

