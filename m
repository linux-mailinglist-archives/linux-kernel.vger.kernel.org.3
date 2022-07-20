Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3124257B978
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiGTPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiGTPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:22:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E325B057
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:22:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d8so6643988wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10mCB1p9QXZ5hMNLpf9Atm/lE/ONgYcPbZJGAy+BbTE=;
        b=q/XN4+moWU6pS26pJaG9um1OtEqOT7theGT9T2njWXp9STAdsitYpJ5YzAGp+8X285
         vjOcfnmzs6G8P1zgLbACgfOQurgR041A8KRww5yLazluRoQu2p1l3/VL69wLq+VAAJPc
         pWstZagMyvaVg6dKgXTVT9iC8iwgVNHhD5bwjtGjOH/BKZPfIC6wcll9KuNBL+j6uQdB
         YjpkPX2fKO0HPXMHQxcNQMmDSBcvjZ0kPY2gbB+LEb3y6nmPlBJ0Ki/hADZGlHEvnM/V
         sYZXVCx3MbGXBUXvDnWMV9Dpz14gPd/kKVuCZaQ7RSTBO/V/6NKcygwAnzWOMqAmXGuP
         LVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10mCB1p9QXZ5hMNLpf9Atm/lE/ONgYcPbZJGAy+BbTE=;
        b=atJgCEozSWTzPivGeOKlHnJvi4tfGMEzck08uqVj4aGUOYcF/jIQPIqPXi+zFhJw39
         mxyeWIqXmJ8vfGTMx/XW6MfLPodeBqarDuG0+QhJb55GDinCz+OGHxHk+Ana763p/UoV
         UXUSBOz6Xo+DlJXn7rK/Bx3tWzhd6MZPu7Q1vUZYsrTM3ja9WVYXC46a7TA8k7PatE4v
         wJasY/B7i2bH56qQxbkv/zieyMw6Ms/mo3IheGWDgOtjlaW4s2XNGgFnGtVVqCqSmWQg
         iGmbkGnbFFj674esN2G7XQGh6JsLUL7bIceud2EDfsNu4KbdO0wmZYlcn87TKkOgX2yD
         BHpA==
X-Gm-Message-State: AJIora/tkpMm7W/lsmjLJyCzQFm4UHW6sjm1BFRL9ZeIje4QLmb7wPQG
        sYsaDRU5i2bYvoketitP5Jlk+F6tK8oUBa3YVrtHgw==
X-Google-Smtp-Source: AGRyM1sZyA+O8GQAnPRNoGyzb+rUrnlyhsCr7vd7kTawL1/xfzhmiL/vjkD/Kiot4p8KNi5XZrNEnQyye57N26vhykc=
X-Received: by 2002:a5d:4d8e:0:b0:21d:68d4:56eb with SMTP id
 b14-20020a5d4d8e000000b0021d68d456ebmr30086604wru.40.1658330541254; Wed, 20
 Jul 2022 08:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-2-elver@google.com>
 <CACT4Y+aA7QkAsufv6EMQ1O8mZaVd-eNOqRrx2a7qvPR4Tt=izA@mail.gmail.com>
In-Reply-To: <CACT4Y+aA7QkAsufv6EMQ1O8mZaVd-eNOqRrx2a7qvPR4Tt=izA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:22:08 -0700
Message-ID: <CAP-5=fWKM09_cgOjEyDjLrs5KgvXv1vLbyBgTFAEV0Sr3f_3YA@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 8:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 4 Jul 2022 at 17:06, Marco Elver <elver@google.com> wrote:
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
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > v3:
> > * Don't use raw_smp_processor_id().
> >
> > v2:
> > * New patch.
> > ---
> >  kernel/events/Makefile             |   1 +
> >  kernel/events/hw_breakpoint_test.c | 323 +++++++++++++++++++++++++++++
> >  lib/Kconfig.debug                  |  10 +
> >  3 files changed, 334 insertions(+)
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
> > index 000000000000..433c5c45e2a5
> > --- /dev/null
> > +++ b/kernel/events/hw_breakpoint_test.c
> > @@ -0,0 +1,323 @@
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
> > +static int get_test_cpu(int num)
> > +{
> > +       int cpu;
> > +
> > +       WARN_ON(num < 0);
> > +
> > +       for_each_online_cpu(cpu) {
> > +               if (num-- <= 0)
> > +                       break;
> > +       }
> > +
> > +       return cpu;
> > +}
> > +
> > +/* ===== Test cases ===== */
> > +
> > +static void test_one_cpu(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       fill_bp_slots(test, &idx, get_test_cpu(0), NULL, 0);
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +}
> > +
> > +static void test_many_cpus(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +       int cpu;
> > +
> > +       /* Test that CPUs are independent. */
> > +       for_each_online_cpu(cpu) {
> > +               bool do_continue = fill_bp_slots(test, &idx, cpu, NULL, 0);
> > +
> > +               TEST_EXPECT_NOSPC(register_test_bp(cpu, NULL, idx));
> > +               if (!do_continue)
> > +                       break;
> > +       }
> > +}
> > +
> > +static void test_one_task_on_all_cpus(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       fill_bp_slots(test, &idx, -1, current, 0);
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +       /* Remove one and adding back CPU-target should work. */
> > +       unregister_test_bp(&test_bps[0]);
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(0), NULL);
> > +}
> > +
> > +static void test_two_tasks_on_all_cpus(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       /* Test that tasks are independent. */
> > +       fill_bp_slots(test, &idx, -1, current, 0);
> > +       fill_bp_slots(test, &idx, -1, get_other_task(test), 0);
> > +
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, get_other_task(test), idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), get_other_task(test), idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +       /* Remove one from first task and adding back CPU-target should not work. */
> > +       unregister_test_bp(&test_bps[0]);
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +}
> > +
> > +static void test_one_task_on_one_cpu(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       fill_bp_slots(test, &idx, get_test_cpu(0), current, 0);
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +       /*
> > +        * Remove one and adding back CPU-target should work; this case is
> > +        * special vs. above because the task's constraints are CPU-dependent.
> > +        */
> > +       unregister_test_bp(&test_bps[0]);
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(0), NULL);
> > +}
> > +
> > +static void test_one_task_mixed(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       TEST_REQUIRES_BP_SLOTS(test, 3);
> > +
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(0), current);
> > +       fill_bp_slots(test, &idx, -1, current, 1);
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +
> > +       /* Transition from CPU-dependent pinned count to CPU-independent. */
> > +       unregister_test_bp(&test_bps[0]);
> > +       unregister_test_bp(&test_bps[1]);
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(0), NULL);
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(0), NULL);
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +}
> > +
> > +static void test_two_tasks_on_one_cpu(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       fill_bp_slots(test, &idx, get_test_cpu(0), current, 0);
> > +       fill_bp_slots(test, &idx, get_test_cpu(0), get_other_task(test), 0);
> > +
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, get_other_task(test), idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), get_other_task(test), idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +       /* Can still create breakpoints on some other CPU. */
> > +       fill_bp_slots(test, &idx, get_test_cpu(1), NULL, 0);
> > +}
> > +
> > +static void test_two_tasks_on_one_all_cpus(struct kunit *test)
> > +{
> > +       int idx = 0;
> > +
> > +       fill_bp_slots(test, &idx, get_test_cpu(0), current, 0);
> > +       fill_bp_slots(test, &idx, -1, get_other_task(test), 0);
> > +
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, get_other_task(test), idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), get_other_task(test), idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +       /* Cannot create breakpoints on some other CPU either. */
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(1), NULL, idx));
> > +}
> > +
> > +static void test_task_on_all_and_one_cpu(struct kunit *test)
> > +{
> > +       int tsk_on_cpu_idx, cpu_idx;
> > +       int idx = 0;
> > +
> > +       TEST_REQUIRES_BP_SLOTS(test, 3);
> > +
> > +       fill_bp_slots(test, &idx, -1, current, 2);
> > +       /* Transitioning from only all CPU breakpoints to mixed. */
> > +       tsk_on_cpu_idx = idx;
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(0), current);
> > +       fill_one_bp_slot(test, &idx, -1, current);
> > +
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +
> > +       /* We should still be able to use up another CPU's slots. */
> > +       cpu_idx = idx;
> > +       fill_one_bp_slot(test, &idx, get_test_cpu(1), NULL);
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(1), NULL, idx));
> > +
> > +       /* Transitioning back to task target on all CPUs. */
> > +       unregister_test_bp(&test_bps[tsk_on_cpu_idx]);
> > +       /* Still have a CPU target breakpoint in get_test_cpu(1). */
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       /* Remove it and try again. */
> > +       unregister_test_bp(&test_bps[cpu_idx]);
> > +       fill_one_bp_slot(test, &idx, -1, current);
> > +
> > +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), current, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(0), NULL, idx));
> > +       TEST_EXPECT_NOSPC(register_test_bp(get_test_cpu(1), NULL, idx));
> > +}
> > +
> > +static struct kunit_case hw_breakpoint_test_cases[] = {
> > +       KUNIT_CASE(test_one_cpu),
> > +       KUNIT_CASE(test_many_cpus),
> > +       KUNIT_CASE(test_one_task_on_all_cpus),
> > +       KUNIT_CASE(test_two_tasks_on_all_cpus),
> > +       KUNIT_CASE(test_one_task_on_one_cpu),
> > +       KUNIT_CASE(test_one_task_mixed),
> > +       KUNIT_CASE(test_two_tasks_on_one_cpu),
> > +       KUNIT_CASE(test_two_tasks_on_one_all_cpus),
> > +       KUNIT_CASE(test_task_on_all_and_one_cpu),
> > +       {},
> > +};
> > +
> > +static int test_init(struct kunit *test)
> > +{
> > +       /* Most test cases want 2 distinct CPUs. */
> > +       return num_online_cpus() < 2 ? -EINVAL : 0;
> > +}
> > +
> > +static void test_exit(struct kunit *test)
> > +{
> > +       for (int i = 0; i < MAX_TEST_BREAKPOINTS; ++i) {
> > +               if (test_bps[i])
> > +                       unregister_test_bp(&test_bps[i]);
> > +       }
> > +
> > +       if (__other_task) {
> > +               kthread_stop(__other_task);
> > +               __other_task = NULL;
> > +       }
> > +}
> > +
> > +static struct kunit_suite hw_breakpoint_test_suite = {
> > +       .name = "hw_breakpoint",
> > +       .test_cases = hw_breakpoint_test_cases,
> > +       .init = test_init,
> > +       .exit = test_exit,
> > +};
> > +
> > +kunit_test_suites(&hw_breakpoint_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Marco Elver <elver@google.com>");
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2e24db4bff19..4c87a6edf046 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2513,6 +2513,16 @@ config STACKINIT_KUNIT_TEST
> >           CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
> >           or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
> >
> > +config HW_BREAKPOINT_KUNIT_TEST
> > +       bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
> > +       depends on HAVE_HW_BREAKPOINT
> > +       depends on KUNIT=y
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +         Tests for hw_breakpoint constraints accounting.
> > +
> > +         If unsure, say N.
> > +
> >  config TEST_UDELAY
> >         tristate "udelay test driver"
> >         help
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
