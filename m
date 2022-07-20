Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4657B984
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiGTPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiGTPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:23:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F45B786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:23:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv24so2732189wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOU8fNK31UdaRFTxZH7uUNE10MhT+gyU0GxNesrMTbk=;
        b=gJKMaw7OQwUE8Pl82nASUpBV4CsNQg2+F33xJj7v8amh288eCv9edv4bEuz5Ihf6zq
         Y1aZR7HfYF1dH9JYipjA7nh7IeXkWXwxfpZbzCLak3lfmkGNTBbq9zbzND9LvlhEJ0tw
         L7Cme0DFbAMsL+Km35Aq7T7mkyrZyjM3ejLCO1rACTQF2dGqR+2aT1yrne7DQtAZQ5nh
         l7FDfNdM+eaWlD01XQ3yzUFD91FtX5fidvr605rvCT2KxKPRdPBuQ9sjhmLrTbUrcs3f
         rgF+mmeeOlHYtIYYQyCKjUo0jSSu2lQOPc6mA6MlL03DQ9DndWc45505ylDGPpXPyp33
         GFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOU8fNK31UdaRFTxZH7uUNE10MhT+gyU0GxNesrMTbk=;
        b=AVqCfe+ZIZEIJ0Mk+NIuSt3xmJUGdQsqm18+MAb0dQ2xF5rlMPw+z/Ug/m5HPx4EtA
         4f5izu/igdz5LJM/H+h54zRyMzC3ZdGdScEFqFVzTdTsKhSqG39ESKL5z0hHm4WRSRV0
         R3GCze5/30gEwEnqheoKEobFMYYXnXfVKV7RzjiZKZ9LhaNEh/KGaYKiGg9teP4NLcjX
         eKOlo8D4D6zeABNDm5pwbjo9agvs8RJG7/z2Mw9juKXFWBQk7L9jqhTshjHmBJeKfj/Q
         +A9zqi0VFobwZ5QMdYYLrg8zNMFPP/00YGsCegaiMc50bJiuQ8oMZKuAVq0mZBe++MZH
         iIIQ==
X-Gm-Message-State: AJIora+FewDW++Xo5DAfInkdhOrCjLMWh+Z9KLAJOFoHOPEOucmFji3k
        5AVZF/Npy3nQqFRqr79hX/Ks9iayUsk34AWN+WCLow==
X-Google-Smtp-Source: AGRyM1tZmXjjuviW3um3Zs7KIJzIOIOdxEu1q/OkiLALO3+VsFJigpodFYG/Q1++/Z9jVmED5wEZC5v9q22r32zBYo8=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr30017427wrx.343.1658330588252; Wed, 20
 Jul 2022 08:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-3-elver@google.com>
 <CACT4Y+aYCkTWu+vBdX2d5GNB9z8oZ+8=a330sK9s18FS8t+6=Q@mail.gmail.com>
In-Reply-To: <CACT4Y+aYCkTWu+vBdX2d5GNB9z8oZ+8=a330sK9s18FS8t+6=Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:22:56 -0700
Message-ID: <CAP-5=fWBVm08LetcyRUh6MK+_gQmyJYxR2sfeZ8LvXfeeJs=zg@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] perf/hw_breakpoint: Provide hw_breakpoint_is_used()
 and use in test
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 8:10 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 4 Jul 2022 at 17:06, Marco Elver <elver@google.com> wrote:
> >
> > Provide hw_breakpoint_is_used() to check if breakpoints are in use on
> > the system.
> >
> > Use it in the KUnit test to verify the global state before and after a
> > test case.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > v3:
> > * New patch.
> > ---
> >  include/linux/hw_breakpoint.h      |  3 +++
> >  kernel/events/hw_breakpoint.c      | 29 +++++++++++++++++++++++++++++
> >  kernel/events/hw_breakpoint_test.c | 12 +++++++++++-
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > index 78dd7035d1e5..a3fb846705eb 100644
> > --- a/include/linux/hw_breakpoint.h
> > +++ b/include/linux/hw_breakpoint.h
> > @@ -74,6 +74,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
> >  extern int register_perf_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
> > +extern bool hw_breakpoint_is_used(void);
> >
> >  extern int dbg_reserve_bp_slot(struct perf_event *bp);
> >  extern int dbg_release_bp_slot(struct perf_event *bp);
> > @@ -121,6 +122,8 @@ register_perf_hw_breakpoint(struct perf_event *bp)  { return -ENOSYS; }
> >  static inline void unregister_hw_breakpoint(struct perf_event *bp)     { }
> >  static inline void
> >  unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)        { }
> > +static inline bool hw_breakpoint_is_used(void)         { return false; }
> > +
> >  static inline int
> >  reserve_bp_slot(struct perf_event *bp)                 {return -ENOSYS; }
> >  static inline void release_bp_slot(struct perf_event *bp)              { }
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index f32320ac02fd..fd5cd1f9e7fc 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -604,6 +604,35 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
> >
> > +/**
> > + * hw_breakpoint_is_used - check if breakpoints are currently used
> > + *
> > + * Returns: true if breakpoints are used, false otherwise.
> > + */
> > +bool hw_breakpoint_is_used(void)
> > +{
> > +       int cpu;
> > +
> > +       if (!constraints_initialized)
> > +               return false;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               for (int type = 0; type < TYPE_MAX; ++type) {
> > +                       struct bp_cpuinfo *info = get_bp_info(cpu, type);
> > +
> > +                       if (info->cpu_pinned)
> > +                               return true;
> > +
> > +                       for (int slot = 0; slot < nr_slots[type]; ++slot) {
> > +                               if (info->tsk_pinned[slot])
> > +                                       return true;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static struct notifier_block hw_breakpoint_exceptions_nb = {
> >         .notifier_call = hw_breakpoint_exceptions_notify,
> >         /* we need to be notified first */
> > diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> > index 433c5c45e2a5..5ced822df788 100644
> > --- a/kernel/events/hw_breakpoint_test.c
> > +++ b/kernel/events/hw_breakpoint_test.c
> > @@ -294,7 +294,14 @@ static struct kunit_case hw_breakpoint_test_cases[] = {
> >  static int test_init(struct kunit *test)
> >  {
> >         /* Most test cases want 2 distinct CPUs. */
> > -       return num_online_cpus() < 2 ? -EINVAL : 0;
> > +       if (num_online_cpus() < 2)
> > +               return -EINVAL;
> > +
> > +       /* Want the system to not use breakpoints elsewhere. */
> > +       if (hw_breakpoint_is_used())
> > +               return -EBUSY;
> > +
> > +       return 0;
> >  }
> >
> >  static void test_exit(struct kunit *test)
> > @@ -308,6 +315,9 @@ static void test_exit(struct kunit *test)
> >                 kthread_stop(__other_task);
> >                 __other_task = NULL;
> >         }
> > +
> > +       /* Verify that internal state agrees that no breakpoints are in use. */
> > +       KUNIT_EXPECT_FALSE(test, hw_breakpoint_is_used());
> >  }
> >
> >  static struct kunit_suite hw_breakpoint_test_suite = {
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
