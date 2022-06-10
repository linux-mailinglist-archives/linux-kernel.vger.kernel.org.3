Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07BB545EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiFJI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347684AbiFJI1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:27:18 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FC49CA7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:25:37 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v140so1464092ybe.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLcNDbfanR+9OC/qj3TxYDSuqrtVsDPMKOVV+JQ2Ebk=;
        b=qYH3eZm3seThktIWCEgiuC5CXyWK/GsQmp6anI5aIb6WSFfjgrvJs4p7L3uEYPjzlO
         GkpRJ66GZKUGuLP+eVCYPdnQQ3mGQairHQPI2PQc1CH1h2wbBhNSPsStZaGA2/6tX3at
         D8KJUf05Z3XZyoX+vQ5pLBt3uaq7/Fy6rgwWGrqhUMyVOLJ7MN+2NVzUknbR9jsV4dbS
         Ex2rFoIyPAm1bbbPBZE2IOshCFVPOUCDXQn1JL5cFS6RedIbifXHNKbm8mXOOqP/BgB7
         Cn0NJz199Cds1Hu0PjRzH+OzsRVEpaKpNjt6r1pElqk4N6HD/j6TXSi1LE4VE8FLXAQ5
         MWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLcNDbfanR+9OC/qj3TxYDSuqrtVsDPMKOVV+JQ2Ebk=;
        b=pNhQGHzvGggvJDHIaQvRKwYllnR86hW73UfFjIgOqj16iAFVI+CFquX543SJc/hOUr
         fyoEaDBCoYbogeRZA29ZtXxUjpc/e2Sj/wAeocV1eSdJj/tPr7Bjek7YqTyVqRaHF24D
         oLQy6sT4oGuponzcOKy3Cl7mUexo1zxQnv2gstWn4lQDd88cfxQLQ943d/rfq5mSOvBg
         ObkRqKBJb1iRXYrTrQ9c9HqAZI6S60NRCqq6B+AzvLSacjfEPrLICZ6kaDykFGg7cJZb
         8xSxmIsp9H1iUB/4zi/10Cv5goakgvEOrOS5uBP05REurOB9dVUvg0P6TPQMbbZIbgq4
         wczA==
X-Gm-Message-State: AOAM530T+m8tFeQl7TOOpebA6i+8bqbopal56ZQbkO7FiY4H5Y/Jsv2J
        +gHizMf+kpJTzExzNhtDfuyoU6W8TaDE097XRlyGSw==
X-Google-Smtp-Source: ABdhPJydoxyoTdgF9ni8cdiFnXZkxJlGkObaA7hNXhDjoVc4B0iiziqKPPa6r/6uLoLWbaxJTW/jn03h0o1hIC06IXs=
X-Received: by 2002:a25:d054:0:b0:664:49cb:410 with SMTP id
 h81-20020a25d054000000b0066449cb0410mr4709163ybg.609.1654849536816; Fri, 10
 Jun 2022 01:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-8-elver@google.com>
 <CACT4Y+bGPLampPm7JHJeXeK_CwQ2_=3mRktPCh7T9r3y8r02hw@mail.gmail.com>
In-Reply-To: <CACT4Y+bGPLampPm7JHJeXeK_CwQ2_=3mRktPCh7T9r3y8r02hw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Jun 2022 10:25:00 +0200
Message-ID: <CANpmjNNwOOYxOXLixrUD25YoszYcy7SRwXMMfrj5zZvrETkp0g@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Thu, 9 Jun 2022 at 17:00, 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> >
> > Running the perf benchmark with (note: more aggressive parameters vs.
> > preceding changes, but same host with 256 CPUs):
> >
> >  | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
> >  | # Running 'breakpoint/thread' benchmark:
> >  | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
> >  |      Total time: 1.953 [sec]
> >  |
> >  |       38.146289 usecs/op
> >  |     4882.725000 usecs/op/cpu
> >
> >     16.29%  [kernel]       [k] rhashtable_jhash2
> >     16.19%  [kernel]       [k] osq_lock
> >     14.22%  [kernel]       [k] queued_spin_lock_slowpath
> >      8.58%  [kernel]       [k] task_bp_pinned
> >      8.30%  [kernel]       [k] mutex_spin_on_owner
> >      4.03%  [kernel]       [k] smp_cfm_core_cond
> >      2.97%  [kernel]       [k] toggle_bp_slot
> >      2.94%  [kernel]       [k] bcmp
> >
> > We can see that a majority of the time is now spent hashing task
> > pointers to index into task_bps_ht in task_bp_pinned().
> >
> > However, if task_bp_pinned()'s computation is independent of any CPU,
> > i.e. always `iter->cpu < 0`, the result for each invocation will be
> > identical. With increasing CPU-count, this problem worsens.
> >
> > Instead, identify if every call to task_bp_pinned() is CPU-independent,
> > and cache the result. Use the cached result instead of a call to
> > task_bp_pinned(), now __task_bp_pinned(), with task_bp_pinned() deciding
> > if the cached result can be used.
> >
> > After this optimization:
> >
> >     21.96%  [kernel]       [k] queued_spin_lock_slowpath
> >     16.39%  [kernel]       [k] osq_lock
> >      9.82%  [kernel]       [k] toggle_bp_slot
> >      9.81%  [kernel]       [k] find_next_bit
> >      4.93%  [kernel]       [k] mutex_spin_on_owner
> >      4.71%  [kernel]       [k] smp_cfm_core_cond
> >      4.30%  [kernel]       [k] __reserve_bp_slot
> >      2.65%  [kernel]       [k] cpumask_next
> >
> > Showing that the time spent hashing keys has become insignificant.
> >
> > With the given benchmark parameters, however, we see no statistically
> > significant improvement in performance on the test system with 256 CPUs.
> > This is very likely due to the benchmark parameters being too aggressive
> > and contention elsewhere becoming dominant.
> >
> > Indeed, when using the less aggressive parameters from the preceding
> > changes, we now observe:
> >
> >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> >  | # Running 'breakpoint/thread' benchmark:
> >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> >  |      Total time: 0.071 [sec]
> >  |
> >  |       37.134896 usecs/op
> >  |     2376.633333 usecs/op/cpu
> >
> > Which is an improvement of 12% compared to without this optimization
> > (baseline is 42 usecs/op). This is now only 5% slower than the
> > theoretical ideal (constraints disabled), and 18% slower than no
> > breakpoints at all.
> >
> > [ While we're here, swap task_bp_pinned()'s bp and cpu arguments to be
> >   more consistent with other functions (which have bp first, before the
> >   cpu argument). ]
>
> There are 3 main cases:
> 1. Per-cpu bp.

Yes, CPU-target breakpoint on just 1 CPU.

> 2. Per-task and per-cpu bp.

Task-target breakpoint but pinned to 1 CPU.

> 3. Per-task bp (on all cpus)

Task-target breakpoint that can run on all CPUs.

> right?
>
> For case 1 we still seem to do lots of unnecessary work in
> fetch_bp_busy_slots() by iterating over all CPUs. We are going to bump
> only the CPU's cpu_pinned, so that's the only CPU we need to
> fetch/check.

It'll just do 1 iteration, because cpumask_of_bp() will return a mask
with just the event's target CPU in it.

> For case 2 we also do lots of unnecessary work, again we also need to
> check only 1 CPU (don't need cached_tbp_pinned). Also don't need to do
> atomic_dec/inc on all other CPUs (they dec/inc the same variable).

Same as above, just 1 iteration because cpumask_of_bp() does the right
thing. cached_tbp_pinned may still be used if all existing task
breakpoints are CPU-independent (i.e. cpu==-1; granted, doing
task_bp_pinned() once or twice probably is irrelevant in this case).

> Case 3 is the only one when we need to check all CPUs and
> cached_tbp_pinned may be useful.
> But I wonder if we could instead add a per-task
> has_per_cpu_breakpoints flag. Then if the flag is set, we check all
> CPUs as we do now (don't need cached_tbp_pinned). And if it's not set,
> then we could optimize the code even more by making it O(1) instead of
> O(N).

> Namely, we add global tsk_pinned for tasks that don't have
> per-cpu breakpoints, and we update only that tsk_pinned instead of
> iterating over all CPUs.

That seems reasonable.

> I think this will require adding cpu_pinned as well (similar to
> tsk_pinned but aggregated over all CPUs).

> Then the fast path capacity check can become just:
>
> if (bp->hw.target && !bp->hw.target->has_per_cpu_breakpoints && bp->cpu < 0) {
>   if (max_cpu_bp_pinned(type) + task_bp_pinned(-1 /*cpu*/, bp, type) +
> hw_breakpoint_weight(bp) > nr_slots[type])
>     return -ENOSPC;
> }
>
> Does it make any sense?

Yes, I think this might work. I'll see if I can make it work.
