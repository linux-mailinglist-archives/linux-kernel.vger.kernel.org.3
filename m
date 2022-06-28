Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406255E47E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbiF1N2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbiF1N1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D5F48
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:26:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g4so10651810ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1PdxBEhFalOAWbRKx82ZqW3VRMTFx8BscKp2q1d2zQ=;
        b=NSkLxKlthFbbgopUImR7ZEIlHMMGztOCr3eD8q6PfMTXQl90ybYLzrlC0esbBqD5A3
         1eYGscmtoONhp+O98Nmy0wRr5R452GQUTTxKa15lfN40VYs9hZSHzOY7Iw6NgdP/ATGC
         p5az4xcNgLdFIr/j7gTVQbnvxMeRoNuNLhXPDVCKwd2c9FpLL57NLN6U+SKVk8P5ZqmG
         z06IOUN+yKa/LsvLBZqxSsPsNh1+oLZiSmevfaZTY0zwZT3tVAPpA+XG4pxsyRuqFPe6
         RTtrf5yU6Jl1aPl5OV9wec7CYw4cmdy5iba0ki/sYJckiSZf80tgQm97CyTxyDK7H9mh
         FVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1PdxBEhFalOAWbRKx82ZqW3VRMTFx8BscKp2q1d2zQ=;
        b=mQEJ4mQiO7BrxIdBcBREUd/QXZIB6MZSy56sysSxrZhJbuCAs6GKR+n/Z+yDXygeCt
         TDey2OPh7mU6ffFV8WadFsYGWQFyH8AsUihHMukMyDG2Z3+kkT7TxihzjZmhSmx9S7xZ
         bGm2d55h8s79UYNL8DVY66icfQt/ntM/XO/WKt/U8i5LsbO1bUNhPpeTaFJB+DYMmaWI
         U6QQxyPz0GIadfTX8RpMU1lyMQEHhdF8+rHvBAj2x2nU9NM1szBpuVftmjgbgeg0gjDz
         qZV8xNr1n4xuxwaIlBYr29ywvj6lucUDC6mu+ifR5O2kZ2kYFzFbzIbVg7DvEVnuYspB
         LsYw==
X-Gm-Message-State: AJIora8USKztZv0TrgN+cXl0BCMHaqO7tNYRqEQ19Q22q/1t6f9OuR3x
        Clw/Dp78ePBBU8fOrO8kWZhRPLXoPJ4aXC1qV4LLew==
X-Google-Smtp-Source: AGRyM1uFLXgRLqXAUoOqJZMzCqxQhJrcnevmfJz6sq3en7AEn2uog+RxKnMuRlH/uclo0B3Xdh3mvjZbp0X+fsNH/8E=
X-Received: by 2002:a25:cc56:0:b0:66c:d0f6:2f0e with SMTP id
 l83-20020a25cc56000000b0066cd0f62f0emr11356145ybf.168.1656422805211; Tue, 28
 Jun 2022 06:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-2-elver@google.com>
 <CACT4Y+brMfpe1_T5eaki8YLRVeCsFqJ6WbUCAe2+ALNTT=By0w@mail.gmail.com>
In-Reply-To: <CACT4Y+brMfpe1_T5eaki8YLRVeCsFqJ6WbUCAe2+ALNTT=By0w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 15:26:09 +0200
Message-ID: <CANpmjNPYMSWOFa5mG9HZnjZUGg7DhGDcLN2dsATZFZh1y5C36Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 at 14:53, Dmitry Vyukov <dvyukov@google.com> wrote:
>
>  On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
> >
> > Add KUnit test for hw_breakpoint constraints accounting, with various
> > interesting mixes of breakpoint targets (some care was taken to catch
> > interesting corner cases via bug-injection).
> >
> > The test cannot be built as a module because it requires access to
> > hw_breakpoint_slots(), which is not inlinable or exported on all
> > architectures.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * New patch.
> > ---
> >  kernel/events/Makefile             |   1 +
> >  kernel/events/hw_breakpoint_test.c | 321 +++++++++++++++++++++++++++++
> >  lib/Kconfig.debug                  |  10 +
> >  3 files changed, 332 insertions(+)
> >  create mode 100644 kernel/events/hw_breakpoint_test.c
> >
> > diff --git a/kernel/events/Makefile b/kernel/events/Makefile
> > index 8591c180b52b..91a62f566743 100644
> > --- a/kernel/events/Makefile
> > +++ b/kernel/events/Makefile
> > @@ -2,4 +2,5 @@
> >  obj-y := core.o ring_buffer.o callchain.o
> >
> >  obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
> > +obj-$(CONFIG_HW_BREAKPOINT_KUNIT_TEST) += hw_breakpoint_test.o
> >  obj-$(CONFIG_UPROBES) += uprobes.o
> > diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> > new file mode 100644
> > index 000000000000..747a0249a606
> > --- /dev/null
> > +++ b/kernel/events/hw_breakpoint_test.c
> > @@ -0,0 +1,321 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for hw_breakpoint constraints accounting logic.
> > + *
> > + * Copyright (C) 2022, Google LLC.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/hw_breakpoint.h>
> > +#include <linux/kthread.h>
> > +#include <linux/perf_event.h>
> > +#include <asm/hw_breakpoint.h>
> > +
> > +#define TEST_REQUIRES_BP_SLOTS(test, slots)                                            \
> > +       do {                                                                            \
> > +               if ((slots) > get_test_bp_slots()) {                                    \
> > +                       kunit_skip((test), "Requires breakpoint slots: %d > %d", slots, \
> > +                                  get_test_bp_slots());                                \
> > +               }                                                                       \
> > +       } while (0)
> > +
> > +#define TEST_EXPECT_NOSPC(expr) KUNIT_EXPECT_EQ(test, -ENOSPC, PTR_ERR(expr))
> > +
> > +#define MAX_TEST_BREAKPOINTS 512
> > +
> > +static char break_vars[MAX_TEST_BREAKPOINTS];
> > +static struct perf_event *test_bps[MAX_TEST_BREAKPOINTS];
> > +static struct task_struct *__other_task;
> > +
> > +static struct perf_event *register_test_bp(int cpu, struct task_struct *tsk, int idx)
> > +{
> > +       struct perf_event_attr attr = {};
> > +
> > +       if (WARN_ON(idx < 0 || idx >= MAX_TEST_BREAKPOINTS))
> > +               return NULL;
> > +
> > +       hw_breakpoint_init(&attr);
> > +       attr.bp_addr = (unsigned long)&break_vars[idx];
> > +       attr.bp_len = HW_BREAKPOINT_LEN_1;
> > +       attr.bp_type = HW_BREAKPOINT_RW;
> > +       return perf_event_create_kernel_counter(&attr, cpu, tsk, NULL, NULL);
> > +}
> > +
> > +static void unregister_test_bp(struct perf_event **bp)
> > +{
> > +       if (WARN_ON(IS_ERR(*bp)))
> > +               return;
> > +       if (WARN_ON(!*bp))
> > +               return;
> > +       unregister_hw_breakpoint(*bp);
> > +       *bp = NULL;
> > +}
> > +
> > +static int get_test_bp_slots(void)
> > +{
> > +       static int slots;
>
> Why is this function needed? Is hw_breakpoint_slots() very slow?

It seems non-trivial on some architectures (e.g.
arch/arm64/kernel/hw_breakpoint.c). Also the reason why
hw_breakpoint.c itself caches it, so I decided to follow the same
because it's called very often in the tests.

> > +
> > +       if (!slots)
> > +               slots = hw_breakpoint_slots(TYPE_DATA);
> > +
> > +       return slots;
> > +}
> > +
> > +static void fill_one_bp_slot(struct kunit *test, int *id, int cpu, struct task_struct *tsk)
> > +{
> > +       struct perf_event *bp = register_test_bp(cpu, tsk, *id);
> > +
> > +       KUNIT_ASSERT_NOT_NULL(test, bp);
> > +       KUNIT_ASSERT_FALSE(test, IS_ERR(bp));
> > +       KUNIT_ASSERT_NULL(test, test_bps[*id]);
> > +       test_bps[(*id)++] = bp;
> > +}
> > +
> > +/*
> > + * Fills up the given @cpu/@tsk with breakpoints, only leaving @skip slots free.
> > + *
> > + * Returns true if this can be called again, continuing at @id.
> > + */
> > +static bool fill_bp_slots(struct kunit *test, int *id, int cpu, struct task_struct *tsk, int skip)
> > +{
> > +       for (int i = 0; i < get_test_bp_slots() - skip; ++i)
> > +               fill_one_bp_slot(test, id, cpu, tsk);
> > +
> > +       return *id + get_test_bp_slots() <= MAX_TEST_BREAKPOINTS;
> > +}
> > +
> > +static int dummy_kthread(void *arg)
> > +{
> > +       return 0;
> > +}
> > +
> > +static struct task_struct *get_other_task(struct kunit *test)
> > +{
> > +       struct task_struct *tsk;
> > +
> > +       if (__other_task)
> > +               return __other_task;
> > +
> > +       tsk = kthread_create(dummy_kthread, NULL, "hw_breakpoint_dummy_task");
> > +       KUNIT_ASSERT_FALSE(test, IS_ERR(tsk));
> > +       __other_task = tsk;
> > +       return __other_task;
> > +}
> > +
> > +static int get_other_cpu(void)
> > +{
> > +       int cpu;
> > +
> > +       for_each_online_cpu(cpu) {
> > +               if (cpu != raw_smp_processor_id())
>
> Are we guaranteed to not be rescheduled in the middle of a test?
> If not, can't get_other_cpu() return the same CPU that was returned by
> raw_smp_processor_id() earlier in the test?

Yes, good point. I think I'll change it to just not use
raw_smp_processor_id() and instead have get_test_cpu(int num) and it
tries to find the 'num' online CPU. In the tests I'll just use CPU
#num 0 and 1.
