Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC434E3E94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiCVMgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiCVMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:36:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB36B25C7F;
        Tue, 22 Mar 2022 05:35:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CFCD23A;
        Tue, 22 Mar 2022 05:35:06 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EFF73F73B;
        Tue, 22 Mar 2022 05:35:05 -0700 (PDT)
Message-ID: <639c902b-535e-8627-de04-9bcbbdc98ed5@arm.com>
Date:   Tue, 22 Mar 2022 12:35:03 +0000
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
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VhzwMri1Lz5mtO5um3-tT9=GUpGN3cHJhkW5TTsbOKbgQ@mail.gmail.com>
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

On 22/03/2022 11:38, Mike Leach wrote:
> HI Suzuki,
> 
> On Tue, 22 Mar 2022 at 10:43, Suzuki Kuruppassery Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> + Cc: James Clark
>>
>> Hi Mike,
>>
>> On 08/03/2022 20:49, Mike Leach wrote:
>>> The current method for allocating trace source ID values to sources is
>>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
>>> The STM is allocated ID 0x1.
>>>
>>> This fixed algorithm is used in both the CoreSight driver code, and by
>>> perf when writing the trace metadata in the AUXTRACE_INFO record.
>>>
>>> The method needs replacing as currently:-
>>> 1. It is inefficient in using available IDs.
>>> 2. Does not scale to larger systems with many cores and the algorithm
>>> has no limits so will generate invalid trace IDs for cpu number > 44.
>>
>> Thanks for addressing this issue.
>>
>>>
>>> Additionally requirements to allocate additional system IDs on some
>>> systems have been seen.
>>>
>>> This patch set  introduces an API that allows the allocation of trace IDs
>>> in a dynamic manner.
>>>
>>> Architecturally reserved IDs are never allocated, and the system is
>>> limited to allocating only valid IDs.
>>>
>>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
>>> the new API.
>>>
>>> perf handling is changed so that the ID associated with the CPU is read
>>> from sysfs. The ID allocator is notified when perf events start and stop
>>> so CPU based IDs are kept constant throughout any perf session.
>>>
>>> For the ETMx.x devices IDs are allocated on certain events
>>> a) When using sysfs, an ID will be allocated on hardware enable, and freed
>>> when the sysfs reset is written.
>>> b) When using perf, ID is allocated on hardware enable, and freed on
>>> hardware disable.
>>>
>>> For both cases the ID is allocated when sysfs is read to get the current
>>> trace ID. This ensures that consistent decode metadata can be extracted
>>> from the system where this read occurs before device enable.
>>
>>
>>>
>>> Note: This patchset breaks backward compatibility for perf record.
>>> Because the method for generating the AUXTRACE_INFO meta data has
>>> changed, using an older perf record will result in metadata that
>>> does not match the trace IDs used in the recorded trace data.
>>> This mismatch will cause subsequent decode to fail. Older versions of
>>> perf will still be able to decode data generated by the updated system.
>>
>> I have some concerns over this and the future plans for the dynamic
>> allocation per sink. i.e., we are breaking/modifying the perf now to
>> accommodate the dynamic nature of the trace id of a given CPU/ETM.
> 
> I don't beleive we have a choice for this - we cannot retain what is
> an essentially broken allocation mechanism.
> 

I completely agree and I am happy with the current step by step approach
of moving to a dynamic allocation scheme. Apologies, this wasn't 
conveyed appropriately.

>> The proposed approach of exposing this via sysfs may (am not sure if
>> this would be the case) break for the trace-id per sink change, as a
>> sink could assign different trace-id for a CPU depending.
>>
> 
> If a path exists between a CPU and a sink - the current framework as
> far as I can tell would not allow for a new path to be set up between
> the cpu and another sink.

e.g, if we have concurrent perf sessions, in the future with sink  based
allocation :

perf record -e cs_etm/@sink1/... payload1
perf record -e cs_etm/@sink2/... payload2
perf record -e cs_etm// ...      payload3

The trace id allocated for first session for CPU0 *could* be different
from that of the second or the third. And it may be tricky to guarantee
that the traceids may be unique across the sinks for a given CPU.

Please note that the different perf sessions may be executing on
different CPUs at the same time as long as they go to different sinks.
So, reading the sysfs could only give out a single traceid, which may
or may not be the correct one for a given "perf".

> 
> However, if we allow multiple paths per CPU, the implementation does
> both allocate on read and allocate on enable. Both API functions take
> a input of a trace ID allocation structure. At present this is global,
> but if we need to introduce per sink allocation, then the mechanisms
> for sink / ID table management will have to ensure that the correct
> table is provided for the sink at the end of the path in each case.
> Thus the API still works as long as you get the sink ID table
> management correct. That is why it was designed to take the TraceID
> tables as input to all the functions - it is independent of any per
> sink management that might come later.
> 
> My view is that any multi-sink system is likely to be multi-socket as
> well - where different trace infrastructures exist per socket but need
> to be handled by a single software infrastructure.
> 
>> So, instead if we make the trace-id available in the perf (say, an new
>> record format, PERF_RECORD_CS_ETM_TRACEID ?) record, we can rely on the
>> new packet for the trace-id, irrespective of how that is allocated and
>> remove the locking/linking of the trace-id with that of the sysfs.
> 
> The issue here is how to we transmit the information from the driver
> to the perf executable?

Yes, exactly.

> Even with a new record that problem still exists. The current perf
> solves this problem by using the same static algorithm that the driver
> uses - so no actual communication is necessary. A similar method is
> used to synthesize the value of the etm control register. The command
> line options are interpreted by perf, then the same data is passed to
> the driver from perf through the event structures and reinterpreted -
> hopefully in the same way. All the other values in the perf records
> are read directly from sysfs.

Yes, correct. Now, the trace-id is something that could change per 
session and with the move to sink based allocation, this could break.
So,
> 
> 
>> This
>> is not something that exists today. (Ideally it would have been nice to
>> have some additional fields in RECORD_AUXINFO, but we don't. Instead of
>> breaking/extending that, we could add a new RECORD).
>>
> 
> The trace ID is currently part of RECORD_AUXTRACE_INFO is it not? And
> we have extended this in the past for the additional requirements for
> ETE - i.e. an additional ID register - read from sysfs, along with a
> version number for the record.

Sorry, I meant the RECORD_AUX (which perf gets emitted for each session
of the ETM, with the offset/size and flags).

There are:

RECORD_AUXINFO -> perf created statically.
RECORD_AUX     -> emitted for each "run" of ETM, offset, size, flags
RECORD_AUXTRACE -> actual hw trace

I see that there is already something that we could use;


  /*
   * Data written to the AUX area by hardware due to aux_output, may need
   * to be matched to the event by an architecture-specific hardware ID.
   * This records the hardware ID, but requires sample_id to provide the
   * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
   * records from multiple events.
   *
   * struct {
   *     struct perf_event_header        header;
   *     u64                             hw_id;
   *     struct sample_id                sample_id;
   * };
   */
  PERF_RECORD_AUX_OUTPUT_HW_ID           = 21,

My suggestion is to emit a record say :

PERF_RECORD_AUX_OUTPUT_HW_ID for each CPU/ETM for a perf session. And 
have the perf report construct the TraceID map for each ETM at decode
from the PERF_RECORD_AUX_OUTPUT_HW_ID records. That way it is future
proof for the "perf" userspace to find the trace-id for a given ETM
rather than reading the sysfs which could be problematic.

Suzuki


> 
> Regards
> 
> Mike
> 
>> I believe the packet may need to be generated only once for a session
>> and that will also allow the flexibility of moving trace-id allocation
>> around (to a sink in the future).
>>
>> Thoughts ?
>>
>> Kind regards
>> Suzuki
>>
>>
>>>
>>>
>>> Applies to coresight/next [b54f53bc11a5]
>>> Tested on DB410c
>>>
>>> Mike Leach (10):
>>>     coresight: trace-id: Add API to dynamically assign trace ID values
>>>     coresight: trace-id: Set up source trace ID map for system
>>>     coresight: stm: Update STM driver to use Trace ID api
>>>     coresight: etm4x: Use trace ID API to dynamically allocate trace ID
>>>     coresight: etm3x: Use trace ID API to allocate IDs
>>>     coresight: perf: traceid: Add perf notifiers for trace ID
>>>     perf: cs-etm: Update event to read trace ID from sysfs
>>>     coresight: Remove legacy Trace ID allocation mechanism
>>>     coresight: etmX.X: stm: Remove unused legacy source trace ID ops
>>>     coresight: trace-id: Add debug & test macros to trace id allocation
>>>
>>>    drivers/hwtracing/coresight/Makefile          |   2 +-
>>>    drivers/hwtracing/coresight/coresight-core.c  |  64 ++---
>>>    .../hwtracing/coresight/coresight-etm-perf.c  |  16 +-
>>>    drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
>>>    .../coresight/coresight-etm3x-core.c          |  93 ++++---
>>>    .../coresight/coresight-etm3x-sysfs.c         |  28 +-
>>>    .../coresight/coresight-etm4x-core.c          |  63 ++++-
>>>    .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
>>>    drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
>>>    drivers/hwtracing/coresight/coresight-priv.h  |   1 +
>>>    drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
>>>    .../hwtracing/coresight/coresight-trace-id.c  | 255 ++++++++++++++++++
>>>    .../hwtracing/coresight/coresight-trace-id.h  |  69 +++++
>>>    include/linux/coresight-pmu.h                 |  12 -
>>>    include/linux/coresight.h                     |   3 -
>>>    tools/perf/arch/arm/util/cs-etm.c             |  12 +-
>>>    16 files changed, 530 insertions(+), 175 deletions(-)
>>>    create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
>>>    create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
>>>
>>
> 
> 

