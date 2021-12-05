Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D90468D61
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbhLEU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:59:53 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35782 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhLEU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:59:52 -0500
Received: by mail-lj1-f178.google.com with SMTP id l7so17182292lja.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 12:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LswMuAPPAcR79eTSLrpfGYTCkWF+UVGPcr+71MMBB4U=;
        b=gu/qvO/eWufPH1In7+9OA8njmz3NLStY+7Vlp7m92tnvd07WnQV93A4qpu/jLx3wIr
         kURmzaCv5qJbA3OuIChgXlMRWYAKGkmgO9fR24sus9lNIT6S7rBL4CLd2IhbHCOkdPq6
         5HsY+Aqggb5dCZKl8PY6vgQx42QLG7HJwAhzfa/VAK6WQEm+StIUcV7oQYMLjdE5XY6c
         4tJNJ0Hxs4DgKdm7mDSxEmzrXWvAnzFkuW3hFSn0Mqp6jT2OgOxemj3cpmJfg2e4m010
         mBBgrQVcLKp219byX/Sj9TUOyM47roBViHS1MykXFycwZy0Zdkse8rHohsoYMuSQIUPT
         7jiw==
X-Gm-Message-State: AOAM532kD/zFMQ7gj8z7Rg6nopn98fgLaqWatSqFjwntXKKCYyX0dALe
        stkk7bfOj8Id0kuMh1spE+PPtp66J7PcA1KZ6/Y=
X-Google-Smtp-Source: ABdhPJyoogqZ6JhkBTCGuCGA0ICxMe4rdBOncMtpJY8sCFZnBsCQcBSyMaiIuFDeryXPrEsIxoaZFpLQH/sESBbOqdk=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr30897905ljp.202.1638737783460;
 Sun, 05 Dec 2021 12:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20211201045807.1223200-1-namhyung@kernel.org> <20211205141558.GX16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211205141558.GX16608@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Dec 2021 12:56:14 -0800
Message-ID: <CAM9d7cigg3hUXfwWX6OnJDainQdsjU=okL+dG+qhPq3m3tWkDg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Set event shadow time for inactive events too
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
        Namhyung Kim <namhyung@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sun, Dec 5, 2021 at 6:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 30, 2021 at 08:58:07PM -0800, Namhyung Kim wrote:
> > From: Namhyung Kim <namhyung@google.com>
> >
> > While f79256532682 ("perf/core: fix userpage->time_enabled of inactive
> > events") fixed this problem for user rdpmc usage, bperf (perf stat
> > with BPF) still has the same problem that accessing inactive perf
> > events from BPF using bpf_perf_event_read_value().
> >
> > +static inline void group_update_event_time(struct perf_event *group_event)
> >  {
> > +     struct perf_event *event;
> > +     struct perf_event_context *ctx = group_event->ctx;
>
> :-( surely you're aware of the reverse xmas tree thing by now?

Will change the order.

>
> >
> > +     perf_event_update_time(group_event);
> > +     perf_set_shadow_time(group_event, ctx);
> >
> > +     for_each_sibling_event(event, group_event) {
> > +             perf_event_update_time(event);
> > +             perf_set_shadow_time(event, ctx);
> > +     }
> >
> > +     if (likely(!atomic_read(&group_event->mmap_count)))
> >               return;
> >
> > +     perf_event_update_userpage(group_event);
> > +
> >       for_each_sibling_event(event, group_event)
> > +             perf_event_update_userpage(event);
>
> How does it make sense to chase those pointers twice?

OK, then I think I can use the existing code to update
event time before checking the mmap count.

Thanks,
Namhyung

>
> >  }
