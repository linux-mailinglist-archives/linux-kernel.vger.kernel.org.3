Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1954613D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348498AbiFJJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344597AbiFJJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:14:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114032347E7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:13:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so35737291lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VipGKvXmUzgI6wJOysxL1F9dkG1/NuBz0MgOH/2bwo=;
        b=NI1xIb4p+Kuo4svIALZlUuUWPvEId3obWV5uxmZXp3br8+icFzeYMXjlPsoFDcgK6b
         vkhTj4w+X88o5OJeoH9Yu7vc1p7hd2OAxUtTA3PVMs4NJ+3JQOIulMowXJRV/PsYKv8t
         UkvSpJOIv1p5Ow6buIr3w52zIFsBqjrZUzhxh0CgxDrhYOm9NOlbBMTVLPIqQhtDojOL
         06EHHKKktqCCS9AFI6BcZO4LHorX+nulCIZyQg0GCisNWT4VXjJlfiyTkwSoIZc+Ckyl
         kQTc0orWtxWGWMcBX/bL6Pg5trJh9QsLP3ePW/S8jsR3TMni8x4isVGgCYmB5XW+jUzz
         7I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VipGKvXmUzgI6wJOysxL1F9dkG1/NuBz0MgOH/2bwo=;
        b=m/TOyvHr0DyJhTYnrJJPlybcbNoPGsksGZzdYkQHcKq2llmrk5i9nJqHTFQUE3Z3MB
         pRPdnIKydaIlFbR312i7WEV1aWgMqpiHDPTB+sOEnjAfaEMAcBx3aFf/cswuJ9u8ylZi
         eiqp0MufozA2h5Mc6bVjFAwDNxkcEdeRdEucU7GDN4tnXPAqvHzLd4dp90BN0RffU0o6
         QV8jFBfT61hjBCaw2ONaGrIrZwcQOy2dNW7ho2SI7rZ3DSi5+Lhxzsl9fu4fAeiUGzMF
         qROENXnBZaovKsncSE1/nlUCaTCsFlbxisPu/OWJp8JGIICydUVE8c2VR6zzj+VzIpdB
         Z2lw==
X-Gm-Message-State: AOAM5327OWvTCmHrtnjXGV9ilf+Otzloo60JSZggUeeIJxnbU1HrW66R
        YoZ9CL7nTaBvPBJUjrPPCue91g/11tlFkeIFw2lpdA==
X-Google-Smtp-Source: ABdhPJwlJie0xOQwkJFFI0BY/K9Wo2joeS73jBLG246kddoVd2AGfBb3all9yD8VgJC9MfW6Q420dakMuiCWd4mzrTo=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr27214759lfb.376.1654852426922; Fri, 10
 Jun 2022 02:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-8-elver@google.com>
 <CACT4Y+bGPLampPm7JHJeXeK_CwQ2_=3mRktPCh7T9r3y8r02hw@mail.gmail.com> <CANpmjNNwOOYxOXLixrUD25YoszYcy7SRwXMMfrj5zZvrETkp0g@mail.gmail.com>
In-Reply-To: <CANpmjNNwOOYxOXLixrUD25YoszYcy7SRwXMMfrj5zZvrETkp0g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 11:13:35 +0200
Message-ID: <CACT4Y+aJkk6BPYTT6abbem5Fx+9REuWDh8vjqg2HMSLr0MwAVg@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 10:25, Marco Elver <elver@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 17:00, 'Dmitry Vyukov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> > >
> > > Running the perf benchmark with (note: more aggressive parameters vs.
> > > preceding changes, but same host with 256 CPUs):
> > >
> > >  | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
> > >  | # Running 'breakpoint/thread' benchmark:
> > >  | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
> > >  |      Total time: 1.953 [sec]
> > >  |
> > >  |       38.146289 usecs/op
> > >  |     4882.725000 usecs/op/cpu
> > >
> > >     16.29%  [kernel]       [k] rhashtable_jhash2
> > >     16.19%  [kernel]       [k] osq_lock
> > >     14.22%  [kernel]       [k] queued_spin_lock_slowpath
> > >      8.58%  [kernel]       [k] task_bp_pinned
> > >      8.30%  [kernel]       [k] mutex_spin_on_owner
> > >      4.03%  [kernel]       [k] smp_cfm_core_cond
> > >      2.97%  [kernel]       [k] toggle_bp_slot
> > >      2.94%  [kernel]       [k] bcmp
> > >
> > > We can see that a majority of the time is now spent hashing task
> > > pointers to index into task_bps_ht in task_bp_pinned().
> > >
> > > However, if task_bp_pinned()'s computation is independent of any CPU,
> > > i.e. always `iter->cpu < 0`, the result for each invocation will be
> > > identical. With increasing CPU-count, this problem worsens.
> > >
> > > Instead, identify if every call to task_bp_pinned() is CPU-independent,
> > > and cache the result. Use the cached result instead of a call to
> > > task_bp_pinned(), now __task_bp_pinned(), with task_bp_pinned() deciding
> > > if the cached result can be used.
> > >
> > > After this optimization:
> > >
> > >     21.96%  [kernel]       [k] queued_spin_lock_slowpath
> > >     16.39%  [kernel]       [k] osq_lock
> > >      9.82%  [kernel]       [k] toggle_bp_slot
> > >      9.81%  [kernel]       [k] find_next_bit
> > >      4.93%  [kernel]       [k] mutex_spin_on_owner
> > >      4.71%  [kernel]       [k] smp_cfm_core_cond
> > >      4.30%  [kernel]       [k] __reserve_bp_slot
> > >      2.65%  [kernel]       [k] cpumask_next
> > >
> > > Showing that the time spent hashing keys has become insignificant.
> > >
> > > With the given benchmark parameters, however, we see no statistically
> > > significant improvement in performance on the test system with 256 CPUs.
> > > This is very likely due to the benchmark parameters being too aggressive
> > > and contention elsewhere becoming dominant.
> > >
> > > Indeed, when using the less aggressive parameters from the preceding
> > > changes, we now observe:
> > >
> > >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> > >  | # Running 'breakpoint/thread' benchmark:
> > >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> > >  |      Total time: 0.071 [sec]
> > >  |
> > >  |       37.134896 usecs/op
> > >  |     2376.633333 usecs/op/cpu
> > >
> > > Which is an improvement of 12% compared to without this optimization
> > > (baseline is 42 usecs/op). This is now only 5% slower than the
> > > theoretical ideal (constraints disabled), and 18% slower than no
> > > breakpoints at all.
> > >
> > > [ While we're here, swap task_bp_pinned()'s bp and cpu arguments to be
> > >   more consistent with other functions (which have bp first, before the
> > >   cpu argument). ]
> >
> > There are 3 main cases:
> > 1. Per-cpu bp.
>
> Yes, CPU-target breakpoint on just 1 CPU.
>
> > 2. Per-task and per-cpu bp.
>
> Task-target breakpoint but pinned to 1 CPU.
>
> > 3. Per-task bp (on all cpus)
>
> Task-target breakpoint that can run on all CPUs.
>
> > right?
> >
> > For case 1 we still seem to do lots of unnecessary work in
> > fetch_bp_busy_slots() by iterating over all CPUs. We are going to bump
> > only the CPU's cpu_pinned, so that's the only CPU we need to
> > fetch/check.
>
> It'll just do 1 iteration, because cpumask_of_bp() will return a mask
> with just the event's target CPU in it.

You are right. I missed the use of cpumask_of_bp().

> > For case 2 we also do lots of unnecessary work, again we also need to
> > check only 1 CPU (don't need cached_tbp_pinned). Also don't need to do
> > atomic_dec/inc on all other CPUs (they dec/inc the same variable).
>
> Same as above, just 1 iteration because cpumask_of_bp() does the right
> thing. cached_tbp_pinned may still be used if all existing task
> breakpoints are CPU-independent (i.e. cpu==-1; granted, doing
> task_bp_pinned() once or twice probably is irrelevant in this case).
>
> > Case 3 is the only one when we need to check all CPUs and
> > cached_tbp_pinned may be useful.
> > But I wonder if we could instead add a per-task
> > has_per_cpu_breakpoints flag. Then if the flag is set, we check all
> > CPUs as we do now (don't need cached_tbp_pinned). And if it's not set,
> > then we could optimize the code even more by making it O(1) instead of
> > O(N).
>
> > Namely, we add global tsk_pinned for tasks that don't have
> > per-cpu breakpoints, and we update only that tsk_pinned instead of
> > iterating over all CPUs.
>
> That seems reasonable.
>
> > I think this will require adding cpu_pinned as well (similar to
> > tsk_pinned but aggregated over all CPUs).
>
> > Then the fast path capacity check can become just:
> >
> > if (bp->hw.target && !bp->hw.target->has_per_cpu_breakpoints && bp->cpu < 0) {
> >   if (max_cpu_bp_pinned(type) + task_bp_pinned(-1 /*cpu*/, bp, type) +
> > hw_breakpoint_weight(bp) > nr_slots[type])
> >     return -ENOSPC;
> > }
> >
> > Does it make any sense?
>
> Yes, I think this might work. I'll see if I can make it work.

Actually!
This is somewhat orthogonal to the optimizations you are doing, but
the most interesting case for us is inherited events. And it seems
that an inherited event can't possibly overflow the capacity.
Inherited events are a subset of the parent events and all parent
events have already passed validation and the child can't have its own
new events when inherited events are created.
So couldn't we somehow detect that reserve_bp_slot() is called from
inherit_event() and skip fetch_bp_busy_slots() altogether? Maybe that
can be detected by looking at bp->attr.inherit and presence of parent
context? Capacity validation may be kept as a debug-only check.
