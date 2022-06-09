Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF974544DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbiFINlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343895AbiFINll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:41:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494F20BE9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:41:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s10so1796554ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF28ZnQLVsGI2i7ul/dfgqup/8C1a0mc9TiBXmcosYU=;
        b=OAxGTJUe+XEVGmasomKjfTPF19BOrYj/fEHmMcR16tXmje2L2+5aMxRpp7TxlZz6+J
         yvlRV1lYkm0XlpTf4tltOaog/KE+I4t+0hk2WrYk3ACPv+Y7oF+vJN9L5yagoTRSCrS/
         rworsIcSpHAopjkAjIDAp6gLDlsgNfeV+NvL3Db5jTsQRr/8ODDXA4w0x3waW2l6VyvY
         QuVdTcP44qHWxvGI92Tw8KlDERHWKynUAg3xzD4PoY+1SZM+nkIHAMReHJqIYi8fyhAZ
         GYTE2tO9RGEqmtMrpDG8JYNiKjyopdZujiWnnYuw9ckMZ1u0SBLz5YG8HyowXxR6qw40
         Er/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF28ZnQLVsGI2i7ul/dfgqup/8C1a0mc9TiBXmcosYU=;
        b=TaMoN6WkbcnvWeuhXiN7xOv4BgdRWssX+MEsvK5cRXRJlwz8wN5p0xBceuaP5UirtM
         hRzkafuV6JatWjBP4tJeBMz6D3MNYztU4cB/XcuNnYNQZT0QanVc0Ji1V8n7BsmMRo7G
         JK76B5TaMw0pplMLAx77aPBp0aJZXFS3JfeagAAR5fiOiDbeVbcmhrRdZfX75vBXN9Ns
         ar0X6DczWVuRvwt96GQrnYWVlPnQOJ0FQndHd0HaHhCOvYVqSKBWqzTBxK9CG6wfF0LY
         fD4PkdyKiPVBzCkF4SJ14SSpytsVUKhI1h6ybWJgHeHkgie5X3bk5dcwHS1xl/TVe2qe
         ARgg==
X-Gm-Message-State: AOAM531SvI7nCA1Fk/sGLioRea/lwNXKH81GBRsRQ5Te5ZFsAlN473QW
        oHApojpdW5rubFYOvDTpexct8oTsYtAggbZy6WJupQ==
X-Google-Smtp-Source: ABdhPJxKwbLXuKSnIJ3Phiqmieh/Wr9lduzAjt/Ld23SCuasFCRov3KdDNmTk8meN2KOewMYkB2L7tKO5zGU0Tha5P4=
X-Received: by 2002:a2e:b0fc:0:b0:255:6f92:f9d4 with SMTP id
 h28-20020a2eb0fc000000b002556f92f9d4mr22136645ljl.92.1654782098160; Thu, 09
 Jun 2022 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-6-elver@google.com>
 <CACT4Y+Zd0Zd_66DZ-f2HG4tR6ZdraFe9b4iEBJmG9p72+7RMWQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Zd0Zd_66DZ-f2HG4tR6ZdraFe9b4iEBJmG9p72+7RMWQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 15:41:26 +0200
Message-ID: <CACT4Y+appPi5YAdKFB-2caO6xkg89FmV1_4532u7Jx_5CAX9xw@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 14:04, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> >
> > Flexible breakpoints have never been implemented, with
> > bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
> > bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
> > flexible count in fetch_bp_busy_slots().
> >
> > This again causes suboptimal code generation, when we always know that
> > `!!slots.flexible` will be 0.
> >
> > Just get rid of the flexible "placeholder" and remove all real code
> > related to it. Make a note in the comment related to the constraints
> > algorithm but don't remove them from the algorithm, so that if in future
> > flexible breakpoints need supporting, it should be trivial to revive
> > them (along with reverting this change).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Was added in 2009.
>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>
> > ---
> >  kernel/events/hw_breakpoint.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 5f40c8dfa042..afe0a6007e96 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -46,8 +46,6 @@ struct bp_cpuinfo {
> >  #else
> >         unsigned int    *tsk_pinned;
> >  #endif
> > -       /* Number of non-pinned cpu/task breakpoints in a cpu */
> > -       unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
> >  };
> >
> >  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> > @@ -71,7 +69,6 @@ static bool constraints_initialized __ro_after_init;
> >  /* Gather the number of total pinned and un-pinned bp in a cpuset */
> >  struct bp_busy_slots {

Do we also want to remove this struct altogether? Now it becomes just
an int counter.

> >         unsigned int pinned;
> > -       unsigned int flexible;
> >  };
> >
> >  /* Serialize accesses to the above constraints */
> > @@ -213,10 +210,6 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
> >
> >                 if (nr > slots->pinned)
> >                         slots->pinned = nr;
> > -
> > -               nr = info->flexible;
> > -               if (nr > slots->flexible)
> > -                       slots->flexible = nr;
> >         }
> >  }
> >
> > @@ -299,7 +292,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
> >  }
> >
> >  /*
> > - * Constraints to check before allowing this new breakpoint counter:
> > + * Constraints to check before allowing this new breakpoint counter. Note that
> > + * flexible breakpoints are currently unsupported -- see fetch_this_slot().
> >   *
> >   *  == Non-pinned counter == (Considered as pinned for now)
> >   *
> > @@ -366,7 +360,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
> >         fetch_this_slot(&slots, weight);
> >
> >         /* Flexible counters need to keep at least one slot */
> > -       if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
> > +       if (slots.pinned > hw_breakpoint_slots_cached(type))
> >                 return -ENOSPC;
> >
> >         ret = arch_reserve_bp_slot(bp);
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
