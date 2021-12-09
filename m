Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA846E231
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhLIF4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:56:02 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36593 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLIF4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:56:01 -0500
Received: by mail-lj1-f180.google.com with SMTP id i63so7322290lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 21:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpO2tXfUMmaqVQiNmiQh2gP6IdzAEJ4iuT0rTmJ6Zbc=;
        b=BnhKyu9JoLTRERzS3MOaEQu+fARnuUtX/TY2c99GKCbEZBjq4CEG3j26zx3WN1yki+
         KnGYgPdrugtFllUOylCv0eMx3tAJc2EpTdNP4sBmYpS2HP83fUpqozqBNalKvPBgBSny
         UO1udQAItIu7hRQ2/AaMRchXcL0xeR2QYnCsaZtefvbRxpUvm13GMS8RY8GawVffT9sK
         QEzhqIfAePZ6AvOm2NyRwmduORILHsnyF6/KgM4Mxf3jD/p/qqNcSjYBTRexsI244JEV
         50TGCiRJVvht41Y0lJB0D+xhdl1QuJ1AdyyR1KyN7QfQ4z3EbrylY9LOT9i+GhCvVSby
         s9mg==
X-Gm-Message-State: AOAM533/aMl7sscAidJr6y1OV4GrFbBa3mc4TYTlUZnfVdxB//SOGKvi
        FMPMftgZupeYcLhwX5/n2ouJq/Hp3tQJr4i3clc=
X-Google-Smtp-Source: ABdhPJyfOE7nmYK5cJDxMaz9sIXImoQXyMrFq0FU8xGzaLhjFbwKvJ8tUKcjt9hhHg7xkJl83w6hNTx1QwLZNg8LNdQ=
X-Received: by 2002:a2e:7305:: with SMTP id o5mr4204098ljc.180.1639029147021;
 Wed, 08 Dec 2021 21:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20211205224843.1503081-1-namhyung@kernel.org> <20211208232203.GC16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211208232203.GC16608@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 8 Dec 2021 21:52:16 -0800
Message-ID: <CAM9d7cizkX_oOj2UCWnbqS9P+VDW8NLxC7BE23xa4moJQS_+vg@mail.gmail.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events too
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Dec 8, 2021 at 3:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> > While commit f79256532682 ("perf/core: fix userpage->time_enabled of
> > inactive events") fixed this problem for user rdpmc usage,
>
> You're referring to 'this problem' before actually describing a problem :-(

Well, it's a problem of reporting incorrect 'enabled' time.
I'm sorry if it was not clear.

>
> Also, you now have me looking at that commit again, and I'm still hating
> it. Also, I'm again struggling to make sense of it; all except the very
> last hunk that is.
>
> So the whole, full-fat, mmap self-monitor thing looks like:
>
>
>         u32 seq, time_mult, time_shift, index, width = 64;
>         u64 count, enabled, running;
>         u64 cyc, time_offset, time_cycles = 0, time_mask = ~0ULL;
>         u64 quot, rem, delta;
>         s64 pmc = 0;
>
>         do {
>                 seq = pc->lock;
>                 barrier();
>
>                 enabled = pc->time_enabled;
>                 running = pc->time_running;
>
>                 if (pc->cap_user_time && enabled != running) {
>                         cyc = rdtsc();
>                         time_offset = pc->time_offset;
>                         time_mult   = pc->time_mult;
>                         time_shift  = pc->time_shift;
>                 }
>
>                 if (pc->cap_user_time_short) {
>                         time_cycles = pc->time_cycles;
>                         time_mask   = pc->time_mask;
>                 }
>
>                 index = pc->index;
>                 count = pc->offset;
>                 if (pc->cap_user_rdpmc && index) {
>                         width = pc->pmc_width;
>                         pmc = rdpmc(index - 1);
>                 }
>
>                 barrier();
>         } while (pc->lock != seq);
>
>         if (width < 64) {
>                 pmc <<= 64 - width;
>                 pmc >>= 64 - width;
>         }
>         count += pmc;
>
>         cyc = time_cycles + ((cyc - time_cycles) & time_mask);
>
>         quot = (cyc >> time_shift);
>         rem = cyc & ((1ULL < time_shift) - 1);
>         delta = time_offset + quot * time_mult +
>                 ((rem * time_mult) >> time_shift);
>
>         enabled += delta;
>         if (index)
>                 running += delta;
>
>         quot = count / running;
>         rem  = count % running;
>         count = quot * enabled + (rem * enabled) / running;
>
>
> Now, the thing that sticks out to me is that 'enabled' is
> unconditionally advanced. It *always* runs.
>
> So how can not updating ->time_enabled when the counter is INACTIVE due
> to rotation (which causes ->index == 0), cause enabled to not be
> up-to-date?

Hmm.. I don't get it.  In my understanding, that's the whole point
of the enabled time - tracking time it was not active due to the
multiplexing (rotation).  So that users might want to scale the
count based on the ratio of running vs enabled.

Do I miss something?

Thanks,
Namhyung


>
> Can we please figure that out so I can go revert all but the last hunk
> of that patch?
