Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8950C4E464A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiCVSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCVSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:54:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 422E18CDB9;
        Tue, 22 Mar 2022 11:52:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7477152B;
        Tue, 22 Mar 2022 11:52:34 -0700 (PDT)
Received: from [10.57.73.89] (unknown [10.57.73.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242D13F66F;
        Tue, 22 Mar 2022 11:52:32 -0700 (PDT)
Message-ID: <17215ebc-dbf2-81ca-7ef4-b4ebc3cb9d28@arm.com>
Date:   Tue, 22 Mar 2022 18:52:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 00/10] coresight: Add new API to allocate trace source ID
 values
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
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VhyFj9vcUFjrwtqn47LbdqHp+gQCvtDBNX69-=Y5-2iag@mail.gmail.com>
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

On 22/03/2022 14:27, Mike Leach wrote:
> Hi Suzuki
> 
> On Tue, 22 Mar 2022 at 12:35, Suzuki Kuruppassery Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> On 22/03/2022 11:38, Mike Leach wrote:
>>> HI Suzuki,
>>>
>>> On Tue, 22 Mar 2022 at 10:43, Suzuki Kuruppassery Poulose
>>> <suzuki.poulose@arm.com> wrote:
>>>>
>>>> + Cc: James Clark
>>>>
>>>> Hi Mike,
>>>>
>>>> On 08/03/2022 20:49, Mike Leach wrote:
>>>>> The current method for allocating trace source ID values to sources is
>>>>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
>>>>> The STM is allocated ID 0x1.
>>>>>
>>>>> This fixed algorithm is used in both the CoreSight driver code, and by
>>>>> perf when writing the trace metadata in the AUXTRACE_INFO record.
>>>>>
>>>>> The method needs replacing as currently:-
>>>>> 1. It is inefficient in using available IDs.
>>>>> 2. Does not scale to larger systems with many cores and the algorithm
>>>>> has no limits so will generate invalid trace IDs for cpu number > 44.
>>>>
>>>> Thanks for addressing this issue.
>>>>
>>>>>
>>>>> Additionally requirements to allocate additional system IDs on some
>>>>> systems have been seen.
>>>>>
>>>>> This patch set  introduces an API that allows the allocation of trace IDs
>>>>> in a dynamic manner.
>>>>>
>>>>> Architecturally reserved IDs are never allocated, and the system is
>>>>> limited to allocating only valid IDs.
>>>>>
>>>>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
>>>>> the new API.
>>>>>
>>>>> perf handling is changed so that the ID associated with the CPU is read
>>>>> from sysfs. The ID allocator is notified when perf events start and stop
>>>>> so CPU based IDs are kept constant throughout any perf session.
>>>>>
>>>>> For the ETMx.x devices IDs are allocated on certain events
>>>>> a) When using sysfs, an ID will be allocated on hardware enable, and freed
>>>>> when the sysfs reset is written.
>>>>> b) When using perf, ID is allocated on hardware enable, and freed on
>>>>> hardware disable.
>>>>>
>>>>> For both cases the ID is allocated when sysfs is read to get the current
>>>>> trace ID. This ensures that consistent decode metadata can be extracted
>>>>> from the system where this read occurs before device enable.
>>>>
>>>>
>>>>>
>>>>> Note: This patchset breaks backward compatibility for perf record.
>>>>> Because the method for generating the AUXTRACE_INFO meta data has
>>>>> changed, using an older perf record will result in metadata that
>>>>> does not match the trace IDs used in the recorded trace data.
>>>>> This mismatch will cause subsequent decode to fail. Older versions of
>>>>> perf will still be able to decode data generated by the updated system.
>>>>
>>>> I have some concerns over this and the future plans for the dynamic
>>>> allocation per sink. i.e., we are breaking/modifying the perf now to
>>>> accommodate the dynamic nature of the trace id of a given CPU/ETM.
>>>
>>> I don't beleive we have a choice for this - we cannot retain what is
>>> an essentially broken allocation mechanism.
>>>
>>
>> I completely agree and I am happy with the current step by step approach
>> of moving to a dynamic allocation scheme. Apologies, this wasn't
>> conveyed appropriately.
>>
>>>> The proposed approach of exposing this via sysfs may (am not sure if
>>>> this would be the case) break for the trace-id per sink change, as a
>>>> sink could assign different trace-id for a CPU depending.
>>>>
>>>
>>> If a path exists between a CPU and a sink - the current framework as
>>> far as I can tell would not allow for a new path to be set up between
>>> the cpu and another sink.
>>
>> e.g, if we have concurrent perf sessions, in the future with sink  based
>> allocation :
>>
>> perf record -e cs_etm/@sink1/... payload1
>> perf record -e cs_etm/@sink2/... payload2
>> perf record -e cs_etm// ...      payload3
>>
>> The trace id allocated for first session for CPU0 *could* be different
>> from that of the second or the third.
> 
> If these sessions run concurrently then the same Trace ID will be used
> for CPU0 for all the sessions.
> We ensure this by notifications that a cs_etm session is starting and
> stopping - and keep a refcount.

The scheme is fine now, with a global trace-id map. But with per-sink
allocation, this could cause problems.

e.g., there could be a situation where:

trace_id[CPU0][sink0] == trace_id[CPU1][sink1]

So if we have a session where both CPU0 and CPU1 trace to a common sink,
we get the trace mixed with no way of splitting them. As the perf will
read the trace-id for CPU0 from that of sink0 and CPU1 from sink1.

So my point is, we are changing the ABI for perf to grab the TraceID
with your patches. And clearly this approach could break easily when
we extend to sink-based idmap. So, lets make the ABI change for perf
scalable and bullet proof (as far as we can) by exposing this
information via the perf RECORD. That way any future changes in the
scheme won't affect the perf as long as it has a reliable information
within each "record".


My point is, let us fix this once and for all, so that we don't
need to change this again. I understand this involves more work
in the perf tool. I believe that is for better

Thoughts ?

Suzuki
