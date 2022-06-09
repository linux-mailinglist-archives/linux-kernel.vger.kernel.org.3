Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9731B54500D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiFIPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiFIPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:00:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B99184925
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:00:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c2so18993181lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsfmNOfUlC+V3z4AhfvGEnurL/kWR5dN7NT7SPzXTek=;
        b=kICnwHg+tz0bV++tkQVcLGjsGWQePp6LuSl2JUV4C9/W95LIKwfa7N3u9q2g2fl23W
         vHbKn2zHQfkDmXqsPE9qAzcelTKIzlluT+9gFneFOewqU/bOHdbN9+805Q2+6ZIrl6PI
         9maDGv7jeD+IslHkyjBNiJ9Va2xTyb58RSYv0R0TLgvUI6FExJsynWzDjLY32ChbG+XV
         X6w6jpfDF32hlHkzmTcv6rIMRDoqzXo58qI/oN5Q7y5D58RMbeQN8xkeJV/L6g2zo22q
         8uvG8OFYQbHpIMmFCCkOr7NPz6rlEKx+1SZwpiPy+qlJ14jWLbd5Lf6thEcU10OoSwT9
         9ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsfmNOfUlC+V3z4AhfvGEnurL/kWR5dN7NT7SPzXTek=;
        b=jlXADCIY7TpZWHfnIbQTHfA2eSqO+BK2LGDM9ZaD1YjRQCvgXgvoQORNf8qL/8mxZK
         ljnWGUTCcVXKArzvYWlKwfo64Q7EutdnwNPXD69jPuehYdPpQy8LX+hT/mQQzwskttBC
         LbL1ienlfpEOrqHL4nS5rZ9cDN/XfJ98UK9hKxU3Gpe+9MWGklaBY51x5pBVJe/ejn86
         QIBlUmhLzNK/MB6qZbcBKs613feO0jvXxFdzdtcf2CKtJnoDGjEdWbl1Xvq3UDp6skBW
         rx001oHYq7LgsEIAbSlPtMpqJD1Ofj9uDS9tJyad2CpcrmcCgldL/AOeHkTzfJp5oArS
         mUkw==
X-Gm-Message-State: AOAM533xQ9/qIevtqFXRjX6pifr6nZKF5yIS0bll4NXO2tirQgIHMUe6
        OldhEfXgEvQ4OBaC9cbqGIHojBCYQ9BxqoMUnv4vHw==
X-Google-Smtp-Source: ABdhPJzCyhTAPCSGKsOEYllZmziNv8gM2S20pugkFptHOcy8BZaQJMKZRhF14tbm0E7D62SPU0gO0ononF6at0D43lE=
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id
 y19-20020a0565123f1300b00464f55f7806mr25654590lfa.598.1654786834533; Thu, 09
 Jun 2022 08:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-8-elver@google.com>
In-Reply-To: <20220609113046.780504-8-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 17:00:22 +0200
Message-ID: <CACT4Y+bGPLampPm7JHJeXeK_CwQ2_=3mRktPCh7T9r3y8r02hw@mail.gmail.com>
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

On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
>
> Running the perf benchmark with (note: more aggressive parameters vs.
> preceding changes, but same host with 256 CPUs):
>
>  | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
>  |      Total time: 1.953 [sec]
>  |
>  |       38.146289 usecs/op
>  |     4882.725000 usecs/op/cpu
>
>     16.29%  [kernel]       [k] rhashtable_jhash2
>     16.19%  [kernel]       [k] osq_lock
>     14.22%  [kernel]       [k] queued_spin_lock_slowpath
>      8.58%  [kernel]       [k] task_bp_pinned
>      8.30%  [kernel]       [k] mutex_spin_on_owner
>      4.03%  [kernel]       [k] smp_cfm_core_cond
>      2.97%  [kernel]       [k] toggle_bp_slot
>      2.94%  [kernel]       [k] bcmp
>
> We can see that a majority of the time is now spent hashing task
> pointers to index into task_bps_ht in task_bp_pinned().
>
> However, if task_bp_pinned()'s computation is independent of any CPU,
> i.e. always `iter->cpu < 0`, the result for each invocation will be
> identical. With increasing CPU-count, this problem worsens.
>
> Instead, identify if every call to task_bp_pinned() is CPU-independent,
> and cache the result. Use the cached result instead of a call to
> task_bp_pinned(), now __task_bp_pinned(), with task_bp_pinned() deciding
> if the cached result can be used.
>
> After this optimization:
>
>     21.96%  [kernel]       [k] queued_spin_lock_slowpath
>     16.39%  [kernel]       [k] osq_lock
>      9.82%  [kernel]       [k] toggle_bp_slot
>      9.81%  [kernel]       [k] find_next_bit
>      4.93%  [kernel]       [k] mutex_spin_on_owner
>      4.71%  [kernel]       [k] smp_cfm_core_cond
>      4.30%  [kernel]       [k] __reserve_bp_slot
>      2.65%  [kernel]       [k] cpumask_next
>
> Showing that the time spent hashing keys has become insignificant.
>
> With the given benchmark parameters, however, we see no statistically
> significant improvement in performance on the test system with 256 CPUs.
> This is very likely due to the benchmark parameters being too aggressive
> and contention elsewhere becoming dominant.
>
> Indeed, when using the less aggressive parameters from the preceding
> changes, we now observe:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 0.071 [sec]
>  |
>  |       37.134896 usecs/op
>  |     2376.633333 usecs/op/cpu
>
> Which is an improvement of 12% compared to without this optimization
> (baseline is 42 usecs/op). This is now only 5% slower than the
> theoretical ideal (constraints disabled), and 18% slower than no
> breakpoints at all.
>
> [ While we're here, swap task_bp_pinned()'s bp and cpu arguments to be
>   more consistent with other functions (which have bp first, before the
>   cpu argument). ]

There are 3 main cases:
1. Per-cpu bp.
2. Per-task and per-cpu bp.
3. Per-task bp (on all cpus)
right?

For case 1 we still seem to do lots of unnecessary work in
fetch_bp_busy_slots() by iterating over all CPUs. We are going to bump
only the CPU's cpu_pinned, so that's the only CPU we need to
fetch/check.

For case 2 we also do lots of unnecessary work, again we also need to
check only 1 CPU (don't need cached_tbp_pinned). Also don't need to do
atomic_dec/inc on all other CPUs (they dec/inc the same variable).

Case 3 is the only one when we need to check all CPUs and
cached_tbp_pinned may be useful.
But I wonder if we could instead add a per-task
has_per_cpu_breakpoints flag. Then if the flag is set, we check all
CPUs as we do now (don't need cached_tbp_pinned). And if it's not set,
then we could optimize the code even more by making it O(1) instead of
O(N). Namely, we add global tsk_pinned for tasks that don't have
per-cpu breakpoints, and we update only that tsk_pinned instead of
iterating over all CPUs.
I think this will require adding cpu_pinned as well (similar to
tsk_pinned but aggregated over all CPUs).
Then the fast path capacity check can become just:

if (bp->hw.target && !bp->hw.target->has_per_cpu_breakpoints && bp->cpu < 0) {
  if (max_cpu_bp_pinned(type) + task_bp_pinned(-1 /*cpu*/, bp, type) +
hw_breakpoint_weight(bp) > nr_slots[type])
    return -ENOSPC;
}

Does it make any sense?
