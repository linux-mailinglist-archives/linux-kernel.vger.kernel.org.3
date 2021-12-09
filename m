Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A4346F608
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhLIVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:38:59 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44776 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:38:58 -0500
Received: by mail-lj1-f182.google.com with SMTP id 13so10954880ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5o60uPlMh9x9rL/ch8a5b+l+nPNHn/QhOTHrxdY54w=;
        b=f4oYLmb43bMWF/6Sv0fVa27IaSHQL0TQdgVjX5F9LeoxliQidj9lErGpeYl1vlWYF2
         ZzBq1pl15/jAQNylFeQ3srP4Mdu7OjKRAf9KWBa4Unb2yb9BWjidAYZ0L7tMhV9lujbF
         HTH/aYQ47GGOeMklVxeH7TH+nzQApXDGomHv+kdhCUiLTEVxSuEvbKlaQY9etGhxDUiu
         /GvNE+LFxr2PQWKBxDVjhehRVlkZYlcvpL1jeqCtBDdCXCcj14kCVSOF5LLwUXTiUrkl
         17JQjSX4nWhmiGnMAb77EKHRdH3i+goaLqwcEjTKzKGwoFDqUCj4NSFGGmHY4pLWnlt6
         LdpA==
X-Gm-Message-State: AOAM532JrncDUQZNyNWU7SqO+hrbSmTU9A1ZkS7FQwaa4uQzNDmcKa8E
        f0XbOJFHv/EhxDUoIQVnRlN2K88GwqaB2OafJHc=
X-Google-Smtp-Source: ABdhPJwXCN9vQTakxO/GvcP55yxF3t04jytCizMXLKjTEG0fCmRlCGdRpB+m/et0SNOgwi0uLh1kZK35L2ZffHvW0iU=
X-Received: by 2002:a2e:5450:: with SMTP id y16mr9110144ljd.241.1639085723807;
 Thu, 09 Dec 2021 13:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20211205224843.1503081-1-namhyung@kernel.org> <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
In-Reply-To: <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Dec 2021 13:35:11 -0800
Message-ID: <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 3:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
>
> > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > have a negative enabled time.  In fact, bperf keeps values returned by
> > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > accumulates delta between two calls.  When event->shadow_ctx_time is
> > not set, it'd return invalid enabled time which is bigger than normal.
>
> *that*, how does it happen that shadow_time isn't set? It should be last
> set when the event switches to INACTIVE, no?

As you can see, perf_event_set_state() doesn't set the shadow time.
It's called from event_sched_in() which might result in ACTIVE or
INACTIVE.  But the problem is that there's a case that event_sched_in
was not called at all - when group_can_go_on() returns false.

> At which point the logic in
> perf_event_read_local() should make @enabled move forward while @running
> stays put.

It's not about updating event->total_time_enabled, it only
afftects the returned value of @enabled.

I'd say the time calculation is broken so it'd break @running
as well.  But this case can only happen on INACTIVE -
otherwise it'd call event_sched_in() and update the shadow
time properly, so no issue there.  And then we can see
the broken value of enabled time only.

>
> Let me go rummage around a bit... either I'm missing something obvious
> or something's smelly.

Thank you for doing that!

Thanks,
Namhyung
