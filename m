Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8F55E3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbiF1Mxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbiF1Mxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:53:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64422E9F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:53:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a2so22129499lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ME9ogYLhPCZuFXLa1q13oIt/WDr6DICnKX+45BprLvQ=;
        b=O/eDFTpZBGvsxiXhm+rdXmX9EjlpV6zoT4RSdiYdgX4BlPP3BJYz1o3Kd7V3x2E9PS
         Ra/Z0HB82bpCEAMAmLMxi3tMC/F5nXeSpcQe4CeRTiuf2zQXeGpjmjQa0RQB8NH7W8q+
         eo5Xo9NN/TYsgx2IJ7+f/Yf1AMjQl6TltVnIKeSd0iWs50w9CTactRY6QDEZPS8hLxco
         rljnl8g+UkEBNOLI6KV5/xhgnPJZJKl2nE4hDC+/BxjhRC6edHmDYy0IJtJ2zN8VLCaw
         AxW9kxxB/xqdKMtw0UCjU8F2B3NysGTTT4fxCGJFf/T1kfJICkQwMi4Y/fEH4GYM+8/W
         JVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ME9ogYLhPCZuFXLa1q13oIt/WDr6DICnKX+45BprLvQ=;
        b=A5f+0Uj6eM1Bp37UTHWmiikdOvCFg3NQeEHqUkwn8B0O3Oriplcby3oWyxS00nUxqJ
         gcap/24C4cNWRwVfdvfEEh0FAlj8x0sKdMVjzCjKk2NvVeHuqJ8MkWZK59V9AEm8T70u
         J02QYwSTbn1VPSFFxXwvKO/4Js6YMXl5S7WoyO8qkNSV1DR84sbdApeHeYTSu7/YWJjz
         VVp1TDJTI9gR8nlRxvAPVdRKtPkScduimYG2VYTfPik3k8F5gbp2vP58dEVyHc3QGWeW
         p+C/gGUaN+ivmqzZ0FP1JefMLoo8Etx/K050Qz5+JtCRoE7EEgMRxIj3YHF86XqEKZDJ
         wWAQ==
X-Gm-Message-State: AJIora9TvOsVRnpHpD3TPTr7XNQiFPWQKtavIOFfsq/4IoWzodmB5zIn
        52T5w1QP+gy2KQn3TS4FKO68IiMenYIx7exL6OLOOg==
X-Google-Smtp-Source: AGRyM1v27CNMnBcn0g2o7zhsJ/MyLQPHQ0FaLWdS99mATqRq3+ORykWe5FcxukL1nQBDPZ/4iExKqLFKk0x5Tp5UDZw=
X-Received: by 2002:a05:6512:10c3:b0:47f:a97e:35c with SMTP id
 k3-20020a05651210c300b0047fa97e035cmr11411428lfg.417.1656420813860; Tue, 28
 Jun 2022 05:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-2-elver@google.com>
In-Reply-To: <20220628095833.2579903-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jun 2022 14:53:22 +0200
Message-ID: <CACT4Y+brMfpe1_T5eaki8YLRVeCsFqJ6WbUCAe2+ALNTT=By0w@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

 On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
>
> Add KUnit test for hw_breakpoint constraints accounting, with various
> interesting mixes of breakpoint targets (some care was taken to catch
> interesting corner cases via bug-injection).
>
> The test cannot be built as a module because it requires access to
> hw_breakpoint_slots(), which is not inlinable or exported on all
> architectures.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * New patch.
> ---
>  kernel/events/Makefile             |   1 +
>  kernel/events/hw_breakpoint_test.c | 321 +++++++++++++++++++++++++++++
>  lib/Kconfig.debug                  |  10 +
>  3 files changed, 332 insertions(+)
>  create mode 100644 kernel/events/hw_breakpoint_test.c
>
> diff --git a/kernel/events/Makefile b/kernel/events/Makefile
> index 8591c180b52b..91a62f566743 100644
> --- a/kernel/events/Makefile
> +++ b/kernel/events/Makefile
> @@ -2,4 +2,5 @@
>  obj-y := core.o ring_buffer.o callchain.o
>
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
> +obj-$(CONFIG_HW_BREAKPOINT_KUNIT_TEST) += hw_breakpoint_test.o
>  obj-$(CONFIG_UPROBES) += uprobes.o
> diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> new file mode 100644
> index 000000000000..747a0249a606
> --- /dev/null
> +++ b/kernel/events/hw_breakpoint_test.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for hw_breakpoint constraints accounting logic.
> + *
> + * Copyright (C) 2022, Google LLC.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/cpumask.h>
> +#include <linux/hw_breakpoint.h>
> +#include <linux/kthread.h>
> +#include <linux/perf_event.h>
> +#include <asm/hw_breakpoint.h>
> +
> +#define TEST_REQUIRES_BP_SLOTS(test, slots)                                            \
> +       do {                                                                            \
> +               if ((slots) > get_test_bp_slots()) {                                    \
> +                       kunit_skip((test), "Requires breakpoint slots: %d > %d", slots, \
> +                                  get_test_bp_slots());                                \
> +               }                                                                       \
> +       } while (0)
> +
> +#define TEST_EXPECT_NOSPC(expr) KUNIT_EXPECT_EQ(test, -ENOSPC, PTR_ERR(expr))
> +
> +#define MAX_TEST_BREAKPOINTS 512
> +
> +static char break_vars[MAX_TEST_BREAKPOINTS];
> +static struct perf_event *test_bps[MAX_TEST_BREAKPOINTS];
> +static struct task_struct *__other_task;
> +
> +static struct perf_event *register_test_bp(int cpu, struct task_struct *tsk, int idx)
> +{
> +       struct perf_event_attr attr = {};
> +
> +       if (WARN_ON(idx < 0 || idx >= MAX_TEST_BREAKPOINTS))
> +               return NULL;
> +
> +       hw_breakpoint_init(&attr);
> +       attr.bp_addr = (unsigned long)&break_vars[idx];
> +       attr.bp_len = HW_BREAKPOINT_LEN_1;
> +       attr.bp_type = HW_BREAKPOINT_RW;
> +       return perf_event_create_kernel_counter(&attr, cpu, tsk, NULL, NULL);
> +}
> +
> +static void unregister_test_bp(struct perf_event **bp)
> +{
> +       if (WARN_ON(IS_ERR(*bp)))
> +               return;
> +       if (WARN_ON(!*bp))
> +               return;
> +       unregister_hw_breakpoint(*bp);
> +       *bp = NULL;
> +}
> +
> +static int get_test_bp_slots(void)
> +{
> +       static int slots;

Why is this function needed? Is hw_breakpoint_slots() very slow?

> +
> +       if (!slots)
> +               slots = hw_breakpoint_slots(TYPE_DATA);
> +
> +       return slots;
> +}
> +
> +static void fill_one_bp_slot(struct kunit *test, int *id, int cpu, struct task_struct *tsk)
> +{
> +       struct perf_event *bp = register_test_bp(cpu, tsk, *id);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, bp);
> +       KUNIT_ASSERT_FALSE(test, IS_ERR(bp));
> +       KUNIT_ASSERT_NULL(test, test_bps[*id]);
> +       test_bps[(*id)++] = bp;
> +}
> +
> +/*
> + * Fills up the given @cpu/@tsk with breakpoints, only leaving @skip slots free.
> + *
> + * Returns true if this can be called again, continuing at @id.
> + */
> +static bool fill_bp_slots(struct kunit *test, int *id, int cpu, struct task_struct *tsk, int skip)
> +{
> +       for (int i = 0; i < get_test_bp_slots() - skip; ++i)
> +               fill_one_bp_slot(test, id, cpu, tsk);
> +
> +       return *id + get_test_bp_slots() <= MAX_TEST_BREAKPOINTS;
> +}
> +
> +static int dummy_kthread(void *arg)
> +{
> +       return 0;
> +}
> +
> +static struct task_struct *get_other_task(struct kunit *test)
> +{
> +       struct task_struct *tsk;
> +
> +       if (__other_task)
> +               return __other_task;
> +
> +       tsk = kthread_create(dummy_kthread, NULL, "hw_breakpoint_dummy_task");
> +       KUNIT_ASSERT_FALSE(test, IS_ERR(tsk));
> +       __other_task = tsk;
> +       return __other_task;
> +}
> +
> +static int get_other_cpu(void)
> +{
> +       int cpu;
> +
> +       for_each_online_cpu(cpu) {
> +               if (cpu != raw_smp_processor_id())

Are we guaranteed to not be rescheduled in the middle of a test?
If not, can't get_other_cpu() return the same CPU that was returned by
raw_smp_processor_id() earlier in the test?

> +                       break;
> +       }
> +
> +       return cpu;
> +}
> +
> +/* ===== Test cases ===== */
> +
> +static void test_one_cpu(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       fill_bp_slots(test, &idx, raw_smp_processor_id(), NULL, 0);
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +}
> +
> +static void test_many_cpus(struct kunit *test)
> +{
> +       int idx = 0;
> +       int cpu;
> +
> +       /* Test that CPUs are independent. */
> +       for_each_online_cpu(cpu) {
> +               bool do_continue = fill_bp_slots(test, &idx, cpu, NULL, 0);
> +
> +               TEST_EXPECT_NOSPC(register_test_bp(cpu, NULL, idx));
> +               if (!do_continue)
> +                       break;
> +       }
> +}
> +
> +static void test_one_task_on_all_cpus(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       fill_bp_slots(test, &idx, -1, current, 0);
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +       /* Remove one and adding back CPU-target should work. */
> +       unregister_test_bp(&test_bps[0]);
> +       fill_one_bp_slot(test, &idx, raw_smp_processor_id(), NULL);
> +}
> +
> +static void test_two_tasks_on_all_cpus(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       /* Test that tasks are independent. */
> +       fill_bp_slots(test, &idx, -1, current, 0);
> +       fill_bp_slots(test, &idx, -1, get_other_task(test), 0);
> +
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, get_other_task(test), idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), get_other_task(test), idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +       /* Remove one from first task and adding back CPU-target should not work. */
> +       unregister_test_bp(&test_bps[0]);
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +}
> +
> +static void test_one_task_on_one_cpu(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       fill_bp_slots(test, &idx, raw_smp_processor_id(), current, 0);
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +       /*
> +        * Remove one and adding back CPU-target should work; this case is
> +        * special vs. above because the task's constraints are CPU-dependent.
> +        */
> +       unregister_test_bp(&test_bps[0]);
> +       fill_one_bp_slot(test, &idx, raw_smp_processor_id(), NULL);
> +}
> +
> +static void test_one_task_mixed(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       TEST_REQUIRES_BP_SLOTS(test, 3);
> +
> +       fill_one_bp_slot(test, &idx, raw_smp_processor_id(), current);
> +       fill_bp_slots(test, &idx, -1, current, 1);
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +
> +       /* Transition from CPU-dependent pinned count to CPU-independent. */
> +       unregister_test_bp(&test_bps[0]);
> +       unregister_test_bp(&test_bps[1]);
> +       fill_one_bp_slot(test, &idx, raw_smp_processor_id(), NULL);
> +       fill_one_bp_slot(test, &idx, raw_smp_processor_id(), NULL);
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +}
> +
> +static void test_two_tasks_on_one_cpu(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       fill_bp_slots(test, &idx, raw_smp_processor_id(), current, 0);
> +       fill_bp_slots(test, &idx, raw_smp_processor_id(), get_other_task(test), 0);
> +
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, get_other_task(test), idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), get_other_task(test), idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +       /* Can still create breakpoints on some other CPU. */
> +       fill_bp_slots(test, &idx, get_other_cpu(), NULL, 0);
> +}
> +
> +static void test_two_tasks_on_one_all_cpus(struct kunit *test)
> +{
> +       int idx = 0;
> +
> +       fill_bp_slots(test, &idx, raw_smp_processor_id(), current, 0);
> +       fill_bp_slots(test, &idx, -1, get_other_task(test), 0);
> +
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, get_other_task(test), idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), get_other_task(test), idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +       /* Cannot create breakpoints on some other CPU either. */
> +       TEST_EXPECT_NOSPC(register_test_bp(get_other_cpu(), NULL, idx));
> +}
> +
> +static void test_task_on_all_and_one_cpu(struct kunit *test)
> +{
> +       int tsk_on_cpu_idx, cpu_idx;
> +       int idx = 0;
> +
> +       TEST_REQUIRES_BP_SLOTS(test, 3);
> +
> +       fill_bp_slots(test, &idx, -1, current, 2);
> +       /* Transitioning from only all CPU breakpoints to mixed. */
> +       tsk_on_cpu_idx = idx;
> +       fill_one_bp_slot(test, &idx, raw_smp_processor_id(), current);
> +       fill_one_bp_slot(test, &idx, -1, current);
> +
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +
> +       /* We should still be able to use up another CPU's slots. */
> +       cpu_idx = idx;
> +       fill_one_bp_slot(test, &idx, get_other_cpu(), NULL);
> +       TEST_EXPECT_NOSPC(register_test_bp(get_other_cpu(), NULL, idx));
> +
> +       /* Transitioning back to task target on all CPUs. */
> +       unregister_test_bp(&test_bps[tsk_on_cpu_idx]);
> +       /* Still have a CPU target breakpoint in get_other_cpu(). */
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       /* Remove it and try again. */
> +       unregister_test_bp(&test_bps[cpu_idx]);
> +       fill_one_bp_slot(test, &idx, -1, current);
> +
> +       TEST_EXPECT_NOSPC(register_test_bp(-1, current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), current, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(raw_smp_processor_id(), NULL, idx));
> +       TEST_EXPECT_NOSPC(register_test_bp(get_other_cpu(), NULL, idx));
> +}
> +
> +static struct kunit_case hw_breakpoint_test_cases[] = {
> +       KUNIT_CASE(test_one_cpu),
> +       KUNIT_CASE(test_many_cpus),
> +       KUNIT_CASE(test_one_task_on_all_cpus),
> +       KUNIT_CASE(test_two_tasks_on_all_cpus),
> +       KUNIT_CASE(test_one_task_on_one_cpu),
> +       KUNIT_CASE(test_one_task_mixed),
> +       KUNIT_CASE(test_two_tasks_on_one_cpu),
> +       KUNIT_CASE(test_two_tasks_on_one_all_cpus),
> +       KUNIT_CASE(test_task_on_all_and_one_cpu),
> +       {},
> +};
> +
> +static int test_init(struct kunit *test)
> +{
> +       /* Most test cases want 2 distinct CPUs. */
> +       return num_online_cpus() < 2 ? -EINVAL : 0;
> +}
> +
> +static void test_exit(struct kunit *test)
> +{
> +       for (int i = 0; i < MAX_TEST_BREAKPOINTS; ++i) {
> +               if (test_bps[i])
> +                       unregister_test_bp(&test_bps[i]);
> +       }
> +
> +       if (__other_task) {
> +               kthread_stop(__other_task);
> +               __other_task = NULL;
> +       }
> +}
> +
> +static struct kunit_suite hw_breakpoint_test_suite = {
> +       .name = "hw_breakpoint",
> +       .test_cases = hw_breakpoint_test_cases,
> +       .init = test_init,
> +       .exit = test_exit,
> +};
> +
> +kunit_test_suites(&hw_breakpoint_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Marco Elver <elver@google.com>");
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff19..4c87a6edf046 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2513,6 +2513,16 @@ config STACKINIT_KUNIT_TEST
>           CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
>           or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
>
> +config HW_BREAKPOINT_KUNIT_TEST
> +       bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
> +       depends on HAVE_HW_BREAKPOINT
> +       depends on KUNIT=y
> +       default KUNIT_ALL_TESTS
> +       help
> +         Tests for hw_breakpoint constraints accounting.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
