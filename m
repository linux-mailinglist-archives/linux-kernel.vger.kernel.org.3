Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC74E414A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiCVOaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiCVO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:29:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E98D43EE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:27:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i186so1857738wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9f0TeQ6yZAFGzea0RtOXntipniBxxOarBo+rA7J82A=;
        b=el9qFikTHfJ4iMSCscfM59NlgQ+obbhcel+MAPDMfXBDF/W2qLD76RcIb4Von9MriQ
         NPDKB5iyfnH8R0Y8y1kpW/pdos03iDq5uQQzM7x9alG0fpq4oHaj4iQJZd22uVM3KlKK
         7OLRxPISw0TdnH0F5QKlQ0YcPphmDH1erEXXw/+dXC/813i1y4N3Lht2y7OJ4jL6w9ak
         Ox1bVrNDIn8NhNMtLh5imEwJ3AWi1uoaMm6sYfKjyXm3RLhFS7qccg5+AbjBneUs8aEu
         YCJeWQ2rr+M02FINlakJDQXmvSnf3qtL2G5mLy05Rh0NUDPi9tZTvZwt3yEYDZRr8Gw0
         sLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9f0TeQ6yZAFGzea0RtOXntipniBxxOarBo+rA7J82A=;
        b=zbvBI7bn+wKCXtt6RCpj51/EK7H54AFdH0/VEEtkKGd/lv4zncdx8Ucb5EeP+kD0um
         /LEVRbIvuuID/PPFPUaTbMn1nzASvMdoasE8AMgdcb+oJ3/PZA57OTZWQBidlgKsxMy/
         SXGWbWMyE8gHB+4eofpXGtoxxRqB4gDz/K2QFLVQNkMIwA4hqT/y3W2wJRR4bbk3AX2x
         9x/jbsMfTBaAPKRSFG/7H8SaL1WJhA6PFdE/QQXw8L3aaa/IgYla9RFu6M5fNQ9PXduE
         jcCNfDQO8k+OFUqvxt0bIfkRmIipkoUlesdQgc21l7PjJ5ziJs3GUxgFaMjME3Vehi9X
         1C/A==
X-Gm-Message-State: AOAM530QuR/qjWNQTws4OF7cokBqYdkiW0zDbCFtw/0NkX1nMK5K5H/7
        g7xBe+nIGVVjCsEbTjHag1h2R2Lb846Z2aNNB8dGGQ==
X-Google-Smtp-Source: ABdhPJyneJ0JPc6pS2wSydvmze1a965gHrTmSm05X/5CanvzEpVGMAL4pj/luQgNq0JfzMr9E51J5/HyK/4uYexxMNo=
X-Received: by 2002:a05:600c:19ca:b0:38c:b84f:421a with SMTP id
 u10-20020a05600c19ca00b0038cb84f421amr3366695wmq.118.1647959254803; Tue, 22
 Mar 2022 07:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220308205000.27646-1-mike.leach@linaro.org> <e890feb0-9f90-c0f2-e5f0-10ed5dbe6d81@arm.com>
 <CAJ9a7VhzwMri1Lz5mtO5um3-tT9=GUpGN3cHJhkW5TTsbOKbgQ@mail.gmail.com> <639c902b-535e-8627-de04-9bcbbdc98ed5@arm.com>
In-Reply-To: <639c902b-535e-8627-de04-9bcbbdc98ed5@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 22 Mar 2022 14:27:25 +0000
Message-ID: <CAJ9a7VhyFj9vcUFjrwtqn47LbdqHp+gQCvtDBNX69-=Y5-2iag@mail.gmail.com>
Subject: Re: [PATCH 00/10] coresight: Add new API to allocate trace source ID values
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        James Clark <James.Clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On Tue, 22 Mar 2022 at 12:35, Suzuki Kuruppassery Poulose
<suzuki.poulose@arm.com> wrote:
>
> On 22/03/2022 11:38, Mike Leach wrote:
> > HI Suzuki,
> >
> > On Tue, 22 Mar 2022 at 10:43, Suzuki Kuruppassery Poulose
> > <suzuki.poulose@arm.com> wrote:
> >>
> >> + Cc: James Clark
> >>
> >> Hi Mike,
> >>
> >> On 08/03/2022 20:49, Mike Leach wrote:
> >>> The current method for allocating trace source ID values to sources is
> >>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> >>> The STM is allocated ID 0x1.
> >>>
> >>> This fixed algorithm is used in both the CoreSight driver code, and by
> >>> perf when writing the trace metadata in the AUXTRACE_INFO record.
> >>>
> >>> The method needs replacing as currently:-
> >>> 1. It is inefficient in using available IDs.
> >>> 2. Does not scale to larger systems with many cores and the algorithm
> >>> has no limits so will generate invalid trace IDs for cpu number > 44.
> >>
> >> Thanks for addressing this issue.
> >>
> >>>
> >>> Additionally requirements to allocate additional system IDs on some
> >>> systems have been seen.
> >>>
> >>> This patch set  introduces an API that allows the allocation of trace IDs
> >>> in a dynamic manner.
> >>>
> >>> Architecturally reserved IDs are never allocated, and the system is
> >>> limited to allocating only valid IDs.
> >>>
> >>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> >>> the new API.
> >>>
> >>> perf handling is changed so that the ID associated with the CPU is read
> >>> from sysfs. The ID allocator is notified when perf events start and stop
> >>> so CPU based IDs are kept constant throughout any perf session.
> >>>
> >>> For the ETMx.x devices IDs are allocated on certain events
> >>> a) When using sysfs, an ID will be allocated on hardware enable, and freed
> >>> when the sysfs reset is written.
> >>> b) When using perf, ID is allocated on hardware enable, and freed on
> >>> hardware disable.
> >>>
> >>> For both cases the ID is allocated when sysfs is read to get the current
> >>> trace ID. This ensures that consistent decode metadata can be extracted
> >>> from the system where this read occurs before device enable.
> >>
> >>
> >>>
> >>> Note: This patchset breaks backward compatibility for perf record.
> >>> Because the method for generating the AUXTRACE_INFO meta data has
> >>> changed, using an older perf record will result in metadata that
> >>> does not match the trace IDs used in the recorded trace data.
> >>> This mismatch will cause subsequent decode to fail. Older versions of
> >>> perf will still be able to decode data generated by the updated system.
> >>
> >> I have some concerns over this and the future plans for the dynamic
> >> allocation per sink. i.e., we are breaking/modifying the perf now to
> >> accommodate the dynamic nature of the trace id of a given CPU/ETM.
> >
> > I don't beleive we have a choice for this - we cannot retain what is
> > an essentially broken allocation mechanism.
> >
>
> I completely agree and I am happy with the current step by step approach
> of moving to a dynamic allocation scheme. Apologies, this wasn't
> conveyed appropriately.
>
> >> The proposed approach of exposing this via sysfs may (am not sure if
> >> this would be the case) break for the trace-id per sink change, as a
> >> sink could assign different trace-id for a CPU depending.
> >>
> >
> > If a path exists between a CPU and a sink - the current framework as
> > far as I can tell would not allow for a new path to be set up between
> > the cpu and another sink.
>
> e.g, if we have concurrent perf sessions, in the future with sink  based
> allocation :
>
> perf record -e cs_etm/@sink1/... payload1
> perf record -e cs_etm/@sink2/... payload2
> perf record -e cs_etm// ...      payload3
>
> The trace id allocated for first session for CPU0 *could* be different
> from that of the second or the third.

If these sessions run concurrently then the same Trace ID will be used
for CPU0 for all the sessions.
We ensure this by notifications that a cs_etm session is starting and
stopping - and keep a refcount.
Only when the perf session refcount hits zero can Trace IDs be
released and re-used. Otherwise the association between CPU x and
Trace ID y is maintained - the first session using CPU0 will assign
the ID, the last session to terminate will release the ID from CPU0
(and any other IDs that were allocated during the sessions).

> And it may be tricky to guarantee
> that the traceids may be unique across the sinks for a given CPU.
>




> Please note that the different perf sessions may be executing on
> different CPUs at the same time as long as they go to different sinks.
> So, reading the sysfs could only give out a single traceid, which may
> or may not be the correct one for a given "perf".

As above - reading the trace ID for a given CPU will work for
concurrent sessions.

>
> >
> > However, if we allow multiple paths per CPU, the implementation does
> > both allocate on read and allocate on enable. Both API functions take
> > a input of a trace ID allocation structure. At present this is global,
> > but if we need to introduce per sink allocation, then the mechanisms
> > for sink / ID table management will have to ensure that the correct
> > table is provided for the sink at the end of the path in each case.
> > Thus the API still works as long as you get the sink ID table
> > management correct. That is why it was designed to take the TraceID
> > tables as input to all the functions - it is independent of any per
> > sink management that might come later.
> >
> > My view is that any multi-sink system is likely to be multi-socket as
> > well - where different trace infrastructures exist per socket but need
> > to be handled by a single software infrastructure.
> >
> >> So, instead if we make the trace-id available in the perf (say, an new
> >> record format, PERF_RECORD_CS_ETM_TRACEID ?) record, we can rely on the
> >> new packet for the trace-id, irrespective of how that is allocated and
> >> remove the locking/linking of the trace-id with that of the sysfs.
> >
> > The issue here is how to we transmit the information from the driver
> > to the perf executable?
>
> Yes, exactly.
>
> > Even with a new record that problem still exists. The current perf
> > solves this problem by using the same static algorithm that the driver
> > uses - so no actual communication is necessary. A similar method is
> > used to synthesize the value of the etm control register. The command
> > line options are interpreted by perf, then the same data is passed to
> > the driver from perf through the event structures and reinterpreted -
> > hopefully in the same way. All the other values in the perf records
> > are read directly from sysfs.
>
> Yes, correct. Now, the trace-id is something that could change per
> session and with the move to sink based allocation, this could break.
> So,
> >
> >
> >> This
> >> is not something that exists today. (Ideally it would have been nice to
> >> have some additional fields in RECORD_AUXINFO, but we don't. Instead of
> >> breaking/extending that, we could add a new RECORD).
> >>
> >
> > The trace ID is currently part of RECORD_AUXTRACE_INFO is it not? And
> > we have extended this in the past for the additional requirements for
> > ETE - i.e. an additional ID register - read from sysfs, along with a
> > version number for the record.
>
> Sorry, I meant the RECORD_AUX (which perf gets emitted for each session
> of the ETM, with the offset/size and flags).
>
> There are:
>
> RECORD_AUXINFO -> perf created statically.
> RECORD_AUX     -> emitted for each "run" of ETM, offset, size, flags
> RECORD_AUXTRACE -> actual hw trace
>
> I see that there is already something that we could use;
>
>
>   /*
>    * Data written to the AUX area by hardware due to aux_output, may need
>    * to be matched to the event by an architecture-specific hardware ID.
>    * This records the hardware ID, but requires sample_id to provide the
>    * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
>    * records from multiple events.
>    *
>    * struct {
>    *     struct perf_event_header        header;
>    *     u64                             hw_id;
>    *     struct sample_id                sample_id;
>    * };
>    */
>   PERF_RECORD_AUX_OUTPUT_HW_ID           = 21,
>
> My suggestion is to emit a record say :
>
> PERF_RECORD_AUX_OUTPUT_HW_ID for each CPU/ETM for a perf session. And
> have the perf report construct the TraceID map for each ETM at decode
> from the PERF_RECORD_AUX_OUTPUT_HW_ID records. That way it is future
> proof for the "perf" userspace to find the trace-id for a given ETM
> rather than reading the sysfs which could be problematic.
>

I think this is an interesting idea - we would effectively drop the
use of the Trace ID in AUXINFO and replace it with this new record -
presumably emitted from somewhere in the etm driver.
It is still a compatibility breaking solution. In fact more so than
the current patch set. With the current patch set you need the driver
changes, and the kernel perf changes to generate a useable file that
will work with earlier versions of the userspace perf report.
With this change you need a change to the drivers, kernel perf and
userspace perf.

However - this is a perf only solution - it does not help when driving
trace from sysfs directly.

I think this could be done. But I think this is a separate task from
the current patch set - and could easily be added later if required.
It involves much more change to the user side of perf which are not
required at present.

Regards

Mike

> Suzuki
>
>
> >
> > Regards
> >
> > Mike
> >
> >> I believe the packet may need to be generated only once for a session
> >> and that will also allow the flexibility of moving trace-id allocation
> >> around (to a sink in the future).
> >>
> >> Thoughts ?
> >>
> >> Kind regards
> >> Suzuki
> >>
> >>
> >>>
> >>>
> >>> Applies to coresight/next [b54f53bc11a5]
> >>> Tested on DB410c
> >>>
> >>> Mike Leach (10):
> >>>     coresight: trace-id: Add API to dynamically assign trace ID values
> >>>     coresight: trace-id: Set up source trace ID map for system
> >>>     coresight: stm: Update STM driver to use Trace ID api
> >>>     coresight: etm4x: Use trace ID API to dynamically allocate trace ID
> >>>     coresight: etm3x: Use trace ID API to allocate IDs
> >>>     coresight: perf: traceid: Add perf notifiers for trace ID
> >>>     perf: cs-etm: Update event to read trace ID from sysfs
> >>>     coresight: Remove legacy Trace ID allocation mechanism
> >>>     coresight: etmX.X: stm: Remove unused legacy source trace ID ops
> >>>     coresight: trace-id: Add debug & test macros to trace id allocation
> >>>
> >>>    drivers/hwtracing/coresight/Makefile          |   2 +-
> >>>    drivers/hwtracing/coresight/coresight-core.c  |  64 ++---
> >>>    .../hwtracing/coresight/coresight-etm-perf.c  |  16 +-
> >>>    drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
> >>>    .../coresight/coresight-etm3x-core.c          |  93 ++++---
> >>>    .../coresight/coresight-etm3x-sysfs.c         |  28 +-
> >>>    .../coresight/coresight-etm4x-core.c          |  63 ++++-
> >>>    .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
> >>>    drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
> >>>    drivers/hwtracing/coresight/coresight-priv.h  |   1 +
> >>>    drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
> >>>    .../hwtracing/coresight/coresight-trace-id.c  | 255 ++++++++++++++++++
> >>>    .../hwtracing/coresight/coresight-trace-id.h  |  69 +++++
> >>>    include/linux/coresight-pmu.h                 |  12 -
> >>>    include/linux/coresight.h                     |   3 -
> >>>    tools/perf/arch/arm/util/cs-etm.c             |  12 +-
> >>>    16 files changed, 530 insertions(+), 175 deletions(-)
> >>>    create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >>>    create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >>>
> >>
> >
> >
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
