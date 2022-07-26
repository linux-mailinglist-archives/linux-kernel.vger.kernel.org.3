Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCCD581488
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiGZNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGZNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:53:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7726A248DC;
        Tue, 26 Jul 2022 06:53:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1D51FB;
        Tue, 26 Jul 2022 06:53:28 -0700 (PDT)
Received: from [10.57.41.166] (unknown [10.57.41.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22AB3F70D;
        Tue, 26 Jul 2022 06:53:25 -0700 (PDT)
Message-ID: <9a84d943-6c78-799b-98a9-4a9c02773fa3@arm.com>
Date:   Tue, 26 Jul 2022 14:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/13] coresight: Add new API to allocate trace source
 ID values
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Al Grant <Al.Grant@arm.com>
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <0b493b49-2657-ad5d-465e-d80b62820613@arm.com>
 <CAJ9a7VhXMn+DJ+qgeYRbqgGDm3jV_xNeBGKP=q7eiSe03_7eJw@mail.gmail.com>
 <393c8470-6538-cebe-1c49-cf22ac51e3c5@arm.com>
 <CAJ9a7VicZW0z9fgMObmRKGeNOiW=cjDKG1GHwh3_nLuLd87G-g@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7VicZW0z9fgMObmRKGeNOiW=cjDKG1GHwh3_nLuLd87G-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2022 09:19, Mike Leach wrote:
> Hi James
> 
> On Fri, 22 Jul 2022 at 13:10, James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 21/07/2022 14:54, Mike Leach wrote:
>>> Hi James,
>>>
>>> Thanks for looking at this.
>>>
>>> On Thu, 21 Jul 2022 at 11:27, James Clark <james.clark@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 04/07/2022 09:11, Mike Leach wrote:
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
>>>>>
>>>>> Additionally requirements to allocate additional system IDs on some
>>>>> systems have been seen.
>>>>>
>>>>> This patch set  introduces an API that allows the allocation of trace IDs
>>>>> in a dynamic manner.
>>>>
>>>> I've tested this with various commands like with per-thread mode, attaching,
>>>> running the tests and also Carsten's new tests. Apart from the possible
>>>> backwards compatibility issue and the minor code comments it looks good to
>>>> me.
>>>>
>>>
>>> I've looked at the backwards compatibility issue. At present with the
>>> current set
>>> (K = kernel drivers, P-rec = perf record, P-rep = perf report)
>>> ::
>>>
>>> K-v1-ids  + P-rec-v1-ids => P-rep-v1 (OK)  P-rep-v2 (OK)
>>> K-v1-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (fail)
>>> K-v2-ids  + P-rec-v1-ids => P-rep-v1 (fail)  P-rep-v2 (fail)
>>> K-v2-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
>>>
>>> So, with a P-rec generating v2 metadata, P rep will cleanly error out.
>>> Where the Kernel ID version and the perf report ID version differ,
>>> even the P rep v2 will fail, due to the IDs being different in the
>>> file and actual drivers. These fails will simply look like no data
>>> present.
>>>
>>> There are two possible fixes that improve this:-
>>> A) if the v2 kernel uses a sysfs flag to indicate new ID usage, then
>>> if this is missing the new perf record can degrade to using the old
>>> algorithm to put IDs directly into metadata as it assumes it is
>>> running on a v1 kernel.
>>> This fixes things then for the P-rep v2 that can look for this & we
>>> know there will be no incoming ID packets.
>>> B) P-rep v2 can look for new packets irrespective of incoming metadata
>>> version, and if it sees them, override them
>>>
>>> Compatibility matrix then looks like::
>>> K-v1-ids  + P-rec-v1-ids => P-rep-v1 (OK)  P-rep-v2 (OK)
>>> K-v1-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
>>> K-v2-ids  + P-rec-v1-ids => P-rep-v1 (fail)  P-rep-v2 (OK)
>>> K-v2-ids  + P-rec-v2-ids => P-rep-v1 (error message)  P-rep-v2 (OK)
>>>
>>> There is no solution to using an old version of perf record on a new
>>> kernel and getting the old version of perf report to correctly decode
>>> the file.
>>>
>>
>> We had a discussion about this last point on the Friday AutoFDO call.
> 
> Sorry I missed that - I was on holiday.
>

I think I didn't realise it at the time but I was thinking of two
separate requirements relating to this, rather than one. So I will
list them here first to avoid confusion:

 1. New perfs fall back to the legacy ID mappings if they don't see
    any HW_IDs.

    This is to support the AutoFDO workflow when using new (fixed) perfs
    on old kernels. This only affects the Perf side changes in this
    patch, not any of the kernel changes.

 2. Wherever possible (absent of any reserved ID clashes or CPUs > 47),
    the new driver continues to use the old static ID allocation.

    This is to support not making any changes to simpleperf (or any
    other tools if they exist) until there is an actual need to. As you
    say, this is only a temporary measure. This requirement can also be
    dropped if we make the simpleperf changes at the same time as these
    driver updates. But it would buy some time. But we can't fix any
    tools that we don't know about.

There is no requirement to support old perfs on new kernels as far as I
can see.

>> Do you think it's possible to keep the old static ID allocations if
>> num_possible_cpus() < Max Trace ID? This is especially important for
>> simple perf because Android doesn't even have the more than 128 CPUs
>> issue, so technically shouldn't have to have any changes made to it.
>>
> 
> If android never runs high core count hardware, then that could work.
> The actual CPU limit is in fact 47, after which point the static
> algorithm fails.
> 
> The question arises what do the kernel drivers do then?
> 
> The old perf -record will not realise things are about to go wrong,
> and continue to blindly allocate incorrect trace IDs.
> Realistically the new drivers will then switch to use the previously
> unused IDs, whereby they will mismatch with the blindly allocated perf
> IDs and the old perf decode process will silently fail to decode any
> data with IDs that do not match.
>

Do you mean this situation occurs if there are more than 47 cores?
I think it's fine for things to go wrong in this case because it's
already broken. Regardless of whether the perf and kernel versions match
or don't match.

The user would have to upgrade both parts in that case no matter what
we do.

> If we also removed the metadata version update that goes alongside the
> ID changes, then old perf-reports would continue to try to decode
> newer files - again silently failing once the static algorithm has
> failed.

That's true, but I don't think we need to drop the metaversion update.
There's no requirement for an old perf-report to open new files, so we
can still make this change.

> Legacy ID allocation support must be added as a kernel CONFIG option -
> so that it is up front an obvious to users what is being selected. And
> we can output appropriate error messages.
> 
> This would be a temporary solution at best as there are upcoming
> issues that will need attention:-
> 1 ) We need to deal with the fact that customers are adding new CS
> compatible hardware to their systems, some of which they have
> hardcoded trace IDs. These hardware allocations will become
> reservations in the dynamic allocator, with no guarantee they will not
> clash with the static algorithm.
> 

Maybe instead of the temporary solution we can just make the change to
simpleperf at the same time. The only reason to do this would be to buy
some time or make the transition period smoother.

But does it need to be a CONFIG option if it only happens when CPUs < 47
or if there is a clash? We can still output the AUX_OUTPUT_HW_ID, but
use the old ID allocation scheme. So it would appear to be the new
scheme for anyone looking for HW_IDs, but is also compatible with old
simpleperf until there is a clash.

> 2) There may be a point in the future where we need to use per Sink ID
> allocation.
> 
> 3) We have an outstanding perf issue with ETE + TRBE which never use
> trace IDs - at present decode works here because all the ETE
> capabilities on the current systems are identical. Once that changes,
> perf will need updating to look at the trace metadata on a CPU number
> basis, not on a trace ID basis.

That's true, I have this one on my list but didn't get to it yet.

> 
> 4) Future architecture updates will render newer trace un-decodable by
> old perf versions.
> 
> The question here is why would Android build an up to date kernel
> version with the updated CoreSight drivers, but insist on using an
> outdated perf / simpleperf version?

I suppose I was thinking that it might be convenient to not have to make
any changes to simpleperf because it will always run on low core counts.
But with the other issues about clashes, it looks like changing it is
unavoidable.

But for the opposite (old kernel, new perf), supporting that should be
pretty easy and the reason for using that combo is to get a perf with
decode fixes and run it somewhere that the kernel can't be easily updated.

James

> 
> Regards
> 
> Mike
> 
> 
>> Making the dynamic traceID allocation use the same IDs as before
>> whenever possible should allow both old Perf and simpleperf to open
>> the file as before and ignore the AUX_OUTPUT_HW_ID packets.
>>
>> James
>>
>>> Thoughts?
>>>
>>> Mike
>>>
>>>>>
>>>>> Architecturally reserved IDs are never allocated, and the system is
>>>>> limited to allocating only valid IDs.
>>>>>
>>>>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
>>>>> the new API.
>>>>>
>>>>> For the ETMx.x devices IDs are allocated on certain events
>>>>> a) When using sysfs, an ID will be allocated on hardware enable, or a read of
>>>>> sysfs TRCTRACEID register and freed when the sysfs reset is written.
>>>>>
>>>>> b) When using perf, ID is allocated on hardware enable, and freed on
>>>>> hardware disable. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
>>>>> The ID allocator is notified when perf sessions start and stop
>>>>> so CPU based IDs are kept constant throughout any perf session.
>>>>>
>>>>>
>>>>> Note: This patchset breaks backward compatibility for perf record and
>>>>> perf report.
>>>>>
>>>>> Because the method for generating the AUXTRACE_INFO meta data has
>>>>> changed, using an older perf record will result in metadata that
>>>>> does not match the trace IDs used in the recorded trace data.
>>>>> This mismatch will cause subsequent decode to fail.
>>>>>
>>>>> The version of the AUXTRACE_INFO has been updated to reflect the fact that
>>>>> the trace source IDs are no longer present in the metadata. This will
>>>>> mean older versions of perf report cannot decode the file.
>>>>>
>>>>> Applies to coresight/next [c06475910b52]
>>>>> Tested on DB410c
>>>>>
>>>>> Changes since v1:
>>>>> (after feedback & discussion with Mathieu & Suzuki).
>>>>>
>>>>> 1) API has changed. The global trace ID map is managed internally, so it
>>>>> is no longer passed in to the API functions.
>>>>>
>>>>> 2) perf record does not use sysfs to find the trace IDs. These are now
>>>>> output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
>>>>> have been updated accordingly to generate and handle these events.
>>>>>
>>>>> Mike Leach (13):
>>>>>   coresight: trace-id: Add API to dynamically assign Trace ID values
>>>>>   coresight: trace-id: update CoreSight core to use Trace ID API
>>>>>   coresight: stm: Update STM driver to use Trace ID API
>>>>>   coresight: etm4x: Update ETM4 driver to use Trace ID API
>>>>>   coresight: etm3x: Update ETM3 driver to use Trace ID API
>>>>>   coresight: etmX.X: stm: Remove unused legacy source Trace ID ops
>>>>>   coresight: perf: traceid: Add perf notifiers for Trace ID
>>>>>   perf: cs-etm: Move mapping of Trace ID and cpu into helper function
>>>>>   perf: cs-etm: Update record event to use new Trace ID protocol
>>>>>   kernel: events: Export perf_report_aux_output_id()
>>>>>   perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
>>>>>   coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
>>>>>   coresight: trace-id: Add debug & test macros to Trace ID allocation
>>>>>
>>>>>  drivers/hwtracing/coresight/Makefile          |   2 +-
>>>>>  drivers/hwtracing/coresight/coresight-core.c  |  49 +---
>>>>>  .../hwtracing/coresight/coresight-etm-perf.c  |  17 ++
>>>>>  drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
>>>>>  .../coresight/coresight-etm3x-core.c          |  85 +++---
>>>>>  .../coresight/coresight-etm3x-sysfs.c         |  28 +-
>>>>>  .../coresight/coresight-etm4x-core.c          |  65 ++++-
>>>>>  .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
>>>>>  drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
>>>>>  drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
>>>>>  .../hwtracing/coresight/coresight-trace-id.c  | 263 ++++++++++++++++++
>>>>>  .../hwtracing/coresight/coresight-trace-id.h  |  65 +++++
>>>>>  include/linux/coresight-pmu.h                 |  31 ++-
>>>>>  include/linux/coresight.h                     |   3 -
>>>>>  kernel/events/core.c                          |   1 +
>>>>>  tools/include/linux/coresight-pmu.h           |  31 ++-
>>>>>  tools/perf/arch/arm/util/cs-etm.c             |  21 +-
>>>>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   9 +
>>>>>  tools/perf/util/cs-etm.c                      | 220 +++++++++++++--
>>>>>  tools/perf/util/cs-etm.h                      |  14 +-
>>>>>  20 files changed, 784 insertions(+), 207 deletions(-)
>>>>>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
>>>>>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
>>>>>
>>>
>>>
>>>
> 
> 
> 
