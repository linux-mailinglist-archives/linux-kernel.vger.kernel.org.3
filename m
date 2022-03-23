Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83E4E500A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiCWKJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiCWKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:09:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831D76662
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:07:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d7so1341435wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7WQJHKJhwB7rR++S1inqPsF0o2XGOtyaubpx04iro8=;
        b=ZIRWslzCqb7+4rHIY+FmR11GiDU62z/H7mV58XiZnoLAwK1U3d3OVg3gX/s7WFKSEC
         BTDsQITmI+FyvdWPxj5fr1LADnAdKm1gwadqts88bjhedeiVx3Afpur6VGXzuke/C0l5
         sgbNWZJIvOLG1kpWD+EHw6FWBo4ZFp3JXwSqN/+uUNUN3KFx0daz6yRuMgTgk16BNi3l
         7WQia5ndpsVgbi1tkZPzbtDdrBlyFcV+jo1wfCefsSW//D/zFg1j4hhAi3sW2Yr/2ZBf
         hjbJeg54EI/7ZybgAGMhmW9oYBDc5ba9UO57SeXkLKmpWUDAtqybxxbfcV3t+VnIqs78
         tgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7WQJHKJhwB7rR++S1inqPsF0o2XGOtyaubpx04iro8=;
        b=tGCqRUW9xKTNnrgvFOGYXKbq+B8f2VIfEM7LPtDChOrLuoTWlkpuXuaHCq2kNr7ADN
         hm9iwy/aCfUwWY0SW2bYx12m6GB4N6NWR/pi9OwmPLkqdgP+JAOAjvAqBxRV045Fc/5z
         A5UWSLut7fETS9Zs5bZmM9iiDucsFsi/3IPfac5YV7U1z452/cF9DA347OaSNoxtEHUS
         bzjiFqmpjRxXVTPXdIIfH3GpBOrbvFXGGwXaBEz1fBJiZuytHK+RCisVFR2vbkf0xVMg
         Lsbl4aGZvLwTfhXG9EwSZc94mpUxQiDqKEdpZvf8zhlk3LmSsq3C8IEBIfxxGXLXlIvf
         q1FQ==
X-Gm-Message-State: AOAM531Sw+WDOTcrPsm+yZjlpbiFc1Sez6acwEZFKF1AonhRxv6JSITE
        5BY1+ZAww3+MdurpQl7lD8xNFlpX0al5xnd6Wcy7hg==
X-Google-Smtp-Source: ABdhPJzkGCgR8ToYMOvLQPQrsw37alBoHFgg/BOdzHw1pXI5gYBIeCFigVtLOLN43oqR3PYP19ok/TQmP9VHwUAr7p8=
X-Received: by 2002:adf:f5c4:0:b0:205:2836:f1e5 with SMTP id
 k4-20020adff5c4000000b002052836f1e5mr6340011wrp.519.1648030061576; Wed, 23
 Mar 2022 03:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220308205000.27646-1-mike.leach@linaro.org> <e890feb0-9f90-c0f2-e5f0-10ed5dbe6d81@arm.com>
 <CAJ9a7VhzwMri1Lz5mtO5um3-tT9=GUpGN3cHJhkW5TTsbOKbgQ@mail.gmail.com>
 <639c902b-535e-8627-de04-9bcbbdc98ed5@arm.com> <CAJ9a7VhyFj9vcUFjrwtqn47LbdqHp+gQCvtDBNX69-=Y5-2iag@mail.gmail.com>
 <17215ebc-dbf2-81ca-7ef4-b4ebc3cb9d28@arm.com>
In-Reply-To: <17215ebc-dbf2-81ca-7ef4-b4ebc3cb9d28@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 23 Mar 2022 10:07:30 +0000
Message-ID: <CAJ9a7VjZm=QAKhPJwewO3i3Qyc3C-jbzJKSoCk+Gr+_FXGR9oQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] coresight: Add new API to allocate trace source ID values
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
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

Hi Suzuki,

On Tue, 22 Mar 2022 at 18:52, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 22/03/2022 14:27, Mike Leach wrote:
> > Hi Suzuki
> >
> > On Tue, 22 Mar 2022 at 12:35, Suzuki Kuruppassery Poulose
> > <suzuki.poulose@arm.com> wrote:
> >>
> >> On 22/03/2022 11:38, Mike Leach wrote:
> >>> HI Suzuki,
> >>>
> >>> On Tue, 22 Mar 2022 at 10:43, Suzuki Kuruppassery Poulose
> >>> <suzuki.poulose@arm.com> wrote:
> >>>>
> >>>> + Cc: James Clark
> >>>>
> >>>> Hi Mike,
> >>>>
> >>>> On 08/03/2022 20:49, Mike Leach wrote:
> >>>>> The current method for allocating trace source ID values to sources is
> >>>>> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> >>>>> The STM is allocated ID 0x1.
> >>>>>
> >>>>> This fixed algorithm is used in both the CoreSight driver code, and by
> >>>>> perf when writing the trace metadata in the AUXTRACE_INFO record.
> >>>>>
> >>>>> The method needs replacing as currently:-
> >>>>> 1. It is inefficient in using available IDs.
> >>>>> 2. Does not scale to larger systems with many cores and the algorithm
> >>>>> has no limits so will generate invalid trace IDs for cpu number > 44.
> >>>>
> >>>> Thanks for addressing this issue.
> >>>>
> >>>>>
> >>>>> Additionally requirements to allocate additional system IDs on some
> >>>>> systems have been seen.
> >>>>>
> >>>>> This patch set  introduces an API that allows the allocation of trace IDs
> >>>>> in a dynamic manner.
> >>>>>
> >>>>> Architecturally reserved IDs are never allocated, and the system is
> >>>>> limited to allocating only valid IDs.
> >>>>>
> >>>>> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> >>>>> the new API.
> >>>>>
> >>>>> perf handling is changed so that the ID associated with the CPU is read
> >>>>> from sysfs. The ID allocator is notified when perf events start and stop
> >>>>> so CPU based IDs are kept constant throughout any perf session.
> >>>>>
> >>>>> For the ETMx.x devices IDs are allocated on certain events
> >>>>> a) When using sysfs, an ID will be allocated on hardware enable, and freed
> >>>>> when the sysfs reset is written.
> >>>>> b) When using perf, ID is allocated on hardware enable, and freed on
> >>>>> hardware disable.
> >>>>>
> >>>>> For both cases the ID is allocated when sysfs is read to get the current
> >>>>> trace ID. This ensures that consistent decode metadata can be extracted
> >>>>> from the system where this read occurs before device enable.
> >>>>
> >>>>
> >>>>>
> >>>>> Note: This patchset breaks backward compatibility for perf record.
> >>>>> Because the method for generating the AUXTRACE_INFO meta data has
> >>>>> changed, using an older perf record will result in metadata that
> >>>>> does not match the trace IDs used in the recorded trace data.
> >>>>> This mismatch will cause subsequent decode to fail. Older versions of
> >>>>> perf will still be able to decode data generated by the updated system.
> >>>>
> >>>> I have some concerns over this and the future plans for the dynamic
> >>>> allocation per sink. i.e., we are breaking/modifying the perf now to
> >>>> accommodate the dynamic nature of the trace id of a given CPU/ETM.
> >>>
> >>> I don't beleive we have a choice for this - we cannot retain what is
> >>> an essentially broken allocation mechanism.
> >>>
> >>
> >> I completely agree and I am happy with the current step by step approach
> >> of moving to a dynamic allocation scheme. Apologies, this wasn't
> >> conveyed appropriately.
> >>
> >>>> The proposed approach of exposing this via sysfs may (am not sure if
> >>>> this would be the case) break for the trace-id per sink change, as a
> >>>> sink could assign different trace-id for a CPU depending.
> >>>>
> >>>
> >>> If a path exists between a CPU and a sink - the current framework as
> >>> far as I can tell would not allow for a new path to be set up between
> >>> the cpu and another sink.
> >>
> >> e.g, if we have concurrent perf sessions, in the future with sink  based
> >> allocation :
> >>
> >> perf record -e cs_etm/@sink1/... payload1
> >> perf record -e cs_etm/@sink2/... payload2
> >> perf record -e cs_etm// ...      payload3
> >>
> >> The trace id allocated for first session for CPU0 *could* be different
> >> from that of the second or the third.
> >
> > If these sessions run concurrently then the same Trace ID will be used
> > for CPU0 for all the sessions.
> > We ensure this by notifications that a cs_etm session is starting and
> > stopping - and keep a refcount.
>
> The scheme is fine now, with a global trace-id map. But with per-sink
> allocation, this could cause problems.
>
> e.g., there could be a situation where:
>
> trace_id[CPU0][sink0] == trace_id[CPU1][sink1]
>
> So if we have a session where both CPU0 and CPU1 trace to a common sink,
> we get the trace mixed with no way of splitting them. As the perf will
> read the trace-id for CPU0 from that of sink0 and CPU1 from sink1.

I think we need to consider the CoreSight hardware topology here.

Any CPUx that can trace to a sink reachable by another CPUy must
always get trace IDs from the same pool as CPUy.

Consider the options for multi sink topologies:-

CPU0->funnel0->ETF->ETR
CPU1--+^

Clearly - in-line sinks can never have simultaneous independent
sessions - the session into ETR traces through ETF

Now we could have replicators / programmable replicators -

ATB->Prog replicator->ETR0
                                 +->ETR1

however programmable replicators use trace ID for filtering - this is
effectively a single sink on the input, so once again the Trace IDs
must come from the same pool.

Now, we could have independent per cluster / socket topology
Cluster 0
CPU0->funnel0->ETF0->ETR0
CPU1--+^

Cluster 1
CPU2->funnel1->ETF1->ETR1
CPU3--+^

Here cluster 0 & 1 can have independent sets of trace IDs as their
respective cores can never trace to the same sink.

Finally we have the ETE+TRBE 1:1 type topologies. These could actually
not bother allocating any trace ID when in 1:1 mode, which should
probably be a follow on incremental addition to this initial set.

So, my conclusion when I was considering all this is that "per-sink"
trace Id allocation is in fact "per unique trace path set" allocation.



>
> So my point is, we are changing the ABI for perf to grab the TraceID
> with your patches. And clearly this approach could break easily when
> we extend to sink-based idmap. So, lets make the ABI change for perf
> scalable and bullet proof (as far as we can) by exposing this
> information via the perf RECORD. That way any future changes in the
> scheme won't affect the perf as long as it has a reliable information
> within each "record".
>
>
> My point is, let us fix this once and for all, so that we don't
> need to change this again. I understand this involves more work
> in the perf tool. I believe that is for better
>
> Thoughts ?
>

My preference is the incremental approach.
Fix the trace ID allocation issues that partners are having now, then
update to the perf record approach in a separate follow up patchset.
Then when we start to see systems that require it - update to using
the per-unique-path trace ID pools.

Regards

Mike

> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
