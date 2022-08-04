Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295858A29E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiHDVCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiHDVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:02:16 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637436FA06;
        Thu,  4 Aug 2022 14:02:14 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-10cf9f5b500so930115fac.2;
        Thu, 04 Aug 2022 14:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E5qgGrwnGKDu9LGh41bwLSLTPVsg0aXK1A6+RnujZQY=;
        b=LEj2HDSQRwySncU8E1bXZMU2wF6etsM0VLkMaFS6v1Ue/mXGS56XfByYux0LCclcgF
         vI8e6ze6BRe5ImqbzomMPchDnm+ke8j2/kGZMXrr1HZBEzUhWQUwk0tKCMb0/GGK4hok
         CtCVPWm1k+D3D3FY21iZNgGoHIxozyqE/UcPDB+VcBTzvS2Vl3GbJeswvAgnvVVwYTw+
         vYFh6B1bEVA4ly25hhzPuGIGLux2DktsodWCxgMyXHcz9qcKTWHdk/fvhlVmEE7fiy80
         7zi/bgI5oeVzFl+QOYLI2RQK2HOXGkiOug7MJCfRVOqNtdr2ofQZrC6br1LgPhYN8PgC
         C9lQ==
X-Gm-Message-State: ACgBeo1GXL2sIXyUrziMLqZsgsqrLoBXKi8nuW12FwY4t7XoCE5AQwLJ
        9cJTaHbepY4R3xjJsZoCOfOqzAI0uPMlXoZNk80=
X-Google-Smtp-Source: AA6agR7ylQHyJHpJ1q3LXoXcI8U1HifJQY3LZR7pIO5heZGskn2VJ8US78QikGbZKZh+gD4If/ZGAg14C7FNwROuayU=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr1782730oab.92.1659646933569; Thu, 04
 Aug 2022 14:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220721043644.153718-1-namhyung@kernel.org> <YupFEkzCDxpFUyeD@gmail.com>
 <CAM9d7cjhVwRhVTiJM6hX8Y75SGJhpwYgMtSc_9PB0tzysJjVgQ@mail.gmail.com> <YuuFWr2435kd0CYl@gmail.com>
In-Reply-To: <YuuFWr2435kd0CYl@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Aug 2022 14:02:02 -0700
Message-ID: <CAM9d7cjuo0Xeq8cLGZK+McTVzSOrK=ZWaBBpgHGosK0e5t0wcQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf lock: Add contention subcommand (v1)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 1:37 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Namhyung Kim <namhyung@kernel.org> wrote:
>
> > Hi Ingo,
> >
> > On Wed, Aug 3, 2022 at 2:51 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > > Hello,
> > > >
> > > > It's to add a new subcommand 'contention' (shortly 'con') to perf lock.
> > > >
> > > > The new subcommand is to handle the new lock:contention_{begin,end}
> > > > tracepoints and shows lock type and caller address like below:
> > > >
> > > >   $ perf lock contention
> > > >    contended   total wait     max wait     avg wait         type   caller
> > > >
> > > >          238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
> > > >            1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
> > > >           81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
> > > >            2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
> > > >           24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
> > > >            2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
> > > >            6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
> > > >            1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
> > > >            3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c
> > > >    ...
> > >
> > > Wouldn't it also be useful to display a lock contention percentage value,
> > > the ratio of fastpath vs. contended/wait events?
> > >
> > > That's usually the first-approximation metric to see how contended
> > > different locks are, and the average wait time quantifies it.
> >
> > Yeah, that'd be nice to have.  But it requires some action in the fast
> > path which I don't want because I'd like to use this in production.  So
> > these new tracepoints were added only in the slow path.
>
> Yeah. Might make sense to re-measure the impact of possibly doing that
> though: most of the locking fast-patch is out of line already and could be
> instrumented, with only a handful of inlined primitives -
> CONFIG_UNINLINE_SPIN_UNLOCK in particular.

I'll take a look and measure overhead with tracepoints in the fast path.

>
> How many additional inlined NOP sequences does this add in a defconfig
> kernel? How much is the bloat, and would it be acceptable for production
> kernels?

Last time I measured that it added around 1.3KB of code with the
tracepoints but they are all in the slow path.  So it'd be ok for production.

>
> The other question is to keep tracing overhead low in production systems.
>
> For that we'd have to implement some concept of 'sampling tracepoints',
> which generate only one event for every 128 fast path invocations or so,
> but stay out of the way & don't slow down the system otherwise.

Yeah, it looks like we can do it with perf tools using a custom period like
`-c 128` option.  But I'm not sure how it can deal with the slow path in
sync.  IOW the fast path and the slow path will fire separately.

>
> OTOH frequently used locking fastpaths are measured via regular PMU
> sampling based profiling already.

Sure.  Also note that the recent off-cpu profiling (perf record --off-cpu)
would be helpful to see impact of the sleeping locks.

>
> > Instead, I think we can display the ratio of (total) contended time vs.
> > wall clock time.  What do you think?
>
> That looks useful too - but also the time spent waiting/spinning in a
> thread vs. the time spent actually running and executing real stuff.
>
> That ratio could easily get over 100%, for wait-dominated workloads - so
> ordering by that ratio would highlight the tasks that make the least amount
> of real progress. Measuring the ratio based only on wall clock time would
> hide this aspect.

Do you talk about per-thread stats?  It has the -t/--threads option but it
doesn't work with this BPF program yet.  Will work on it.

By default it shows per-lock (well.. actually per-callstack) contention stat.
We use caller symbols because there're no symbols for locks in general.
It'd be nice if we could merge the stats for the same lock (class) from
different call stacks.

Thanks,
Namhyung
