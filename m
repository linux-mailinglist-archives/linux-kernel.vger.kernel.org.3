Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDEF51D2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389796AbiEFIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389789AbiEFICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:02:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A167D0A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:59:06 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v66so6777695oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bsYKjag5VlFujE08QulXFGTrbxe+KEq9nUHUz7fus8=;
        b=o8BZaTzQMIFN0g1ffgXPs8MsxWSNzsy9rf+73aWRGQnMg0taoxGjg9TY4wVYW/zVhV
         70XQkkYbpVENrQ7a4A7/r7AwwqrRygptD+GNgBFPwwXYfJIe/o3rLUkLvA+QrP9xr1Cs
         ja0/SAfT11JkrgBM5b1S7J3EY/Q8IMjc7IyzEqh4QOA0Ga4i8TSjmPG8HuOS0IvdNQWg
         pD/XE3+7aZYLXwefgVro4EvmNB8BYC9+n3gI1FO/wYFy7Yxi7LZvtMQVvrMEImkGuUtM
         igC+0go/nu5/6+AAOmwEpk/Fs1prA6G5kH5b4ulNYsv+6gZqVDXsrI4vok2gGNRQ6v51
         gUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bsYKjag5VlFujE08QulXFGTrbxe+KEq9nUHUz7fus8=;
        b=hRHMO/FvLjZTyMPnYq+sGedNr3jPRO+YjYrvqnX7HJMjgK1KNCR3jGfVdJllXWAcZJ
         3vBj0qkC3BSAmHL4I4hiPXm8kTAcaVNq/5Vqb4ETaDWOAUxsGC2QHdW3aHtZS4zUqAj0
         43ShvtIBhUvvQ7g4eMpAXsCyBpAk5Spug5qnCumK2mW4jXpZTTgkQkLgRpoAqVt56HMI
         dLVr2VMLskHHHSLOQqMW/NFnRfeBFQS8or9e+tEOX7/y+VmP1TPZ8qCUUW9cB6IZ9UxH
         HiS7tm2Nf2gj4Ubco+TU9Cbq0XXFTOMBmV1B6foaqsCe1fN+oJCuyigYzr7Yf4OJlucw
         PKVw==
X-Gm-Message-State: AOAM532cQk5F+sqODA0hJS+FajGdHZAhdnD/Hn6Zhw50ZtjIDKJGDP30
        OcX6GdthJhBsevDQKmxE6w3SQqpzV8pHKfOqCAjX9g==
X-Google-Smtp-Source: ABdhPJye7hxFUHbk/xq21kzlNwbBU42arepyU85rZ1q/VpJEQJyOQAZ4bBV2TqgLyKFQOT110p/e3fQUc2NBOWFG0jQ=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr900746oib.163.1651823945463; Fri, 06
 May 2022 00:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220505155745.1690906-1-dvyukov@google.com>
In-Reply-To: <20220505155745.1690906-1-dvyukov@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 May 2022 09:58:54 +0200
Message-ID: <CACT4Y+aSF2+mQzMuP6ej-sKt0a8JKjduWH6f0-+a6fvXe=o6Ng@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: add breakpoint benchmarks
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     elver@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 5 May 2022 at 17:57, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Add 2 benchmarks:
> 1. Performance of thread creation/exiting in presence of breakpoints.
> 2. Performance of breakpoint modification in presence of threads.
>
> The benchmarks capture use cases that we are interested in:
> using inheritable breakpoints in large highly-threaded applications.
> The benchmarks show significant slowdown imposed by breakpoints
> (even when they don't fire).

Question to perf maintainers:
Do you know any low-hanging fruits re breakpoint performance? Or did
you want to improve something, but never got to actually implementing
it?

Do you know what would be a good way to remove the global nr_bp_mutex?
Do you know of any opportunities to reduce the number of IPIs on
breakpoint modifications?

Thanks in advance

> Testing on Intel 8173M with 112 HW threads show:
>
> perf bench --repeat=56 breakpoint thread --breakpoints=0 --parallelism=56 --threads=20
>       78.675000 usecs/op
> perf bench --repeat=56 breakpoint thread --breakpoints=4 --parallelism=56 --threads=20
>    12967.135714 usecs/op
> That's 165x slowdown due to presence of the breakpoints.
>
> perf bench --repeat=20000 breakpoint enable --passive=0 --active=0
>        1.433250 usecs/op
> perf bench --repeat=20000 breakpoint enable --passive=224 --active=0
>      585.318400 usecs/op
> perf bench --repeat=20000 breakpoint enable --passive=0 --active=111
>      635.953000 usecs/op
> That's 408x and 444x slowdown due to presence of threads.
>
> Profiles show some overhead in toggle_bp_slot,
> but also very high contention:
>
>     90.83%  breakpoint-thre  [kernel.kallsyms]  [k] osq_lock
>      4.69%  breakpoint-thre  [kernel.kallsyms]  [k] mutex_spin_on_owner
>      2.06%  breakpoint-thre  [kernel.kallsyms]  [k] __reserve_bp_slot
>      2.04%  breakpoint-thre  [kernel.kallsyms]  [k] toggle_bp_slot
>
>     79.01%  breakpoint-enab  [kernel.kallsyms]  [k] smp_call_function_single
>      9.94%  breakpoint-enab  [kernel.kallsyms]  [k] llist_add_batch
>      5.70%  breakpoint-enab  [kernel.kallsyms]  [k] _raw_spin_lock_irq
>      1.84%  breakpoint-enab  [kernel.kallsyms]  [k] event_function_call
>      1.12%  breakpoint-enab  [kernel.kallsyms]  [k] send_call_function_single_ipi
>      0.37%  breakpoint-enab  [kernel.kallsyms]  [k] generic_exec_single
>      0.24%  breakpoint-enab  [kernel.kallsyms]  [k] __perf_event_disable
>      0.20%  breakpoint-enab  [kernel.kallsyms]  [k] _perf_event_enable
>      0.18%  breakpoint-enab  [kernel.kallsyms]  [k] toggle_bp_slot
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/bench/Build        |   1 +
>  tools/perf/bench/bench.h      |   2 +
>  tools/perf/bench/breakpoint.c | 235 ++++++++++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c    |   8 ++
>  4 files changed, 246 insertions(+)
>  create mode 100644 tools/perf/bench/breakpoint.c
>
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index 61d45fcb4057c..6b6155a8ad096 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -14,6 +14,7 @@ perf-y += kallsyms-parse.o
>  perf-y += find-bit-bench.o
>  perf-y += inject-buildid.o
>  perf-y += evlist-open-close.o
> +perf-y += breakpoint.o
>
>  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
>  perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index b3480bc33fe84..6cefb4315d75e 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -49,6 +49,8 @@ int bench_synthesize(int argc, const char **argv);
>  int bench_kallsyms_parse(int argc, const char **argv);
>  int bench_inject_build_id(int argc, const char **argv);
>  int bench_evlist_open_close(int argc, const char **argv);
> +int bench_breakpoint_thread(int argc, const char **argv);
> +int bench_breakpoint_enable(int argc, const char **argv);
>
>  #define BENCH_FORMAT_DEFAULT_STR       "default"
>  #define BENCH_FORMAT_DEFAULT           0
> diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
> new file mode 100644
> index 0000000000000..56936fea246d7
> --- /dev/null
> +++ b/tools/perf/bench/breakpoint.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <subcmd/parse-options.h>
> +#include <linux/hw_breakpoint.h>
> +#include <linux/perf_event.h>
> +#include <linux/time64.h>
> +#include <sys/syscall.h>
> +#include <sys/ioctl.h>
> +#include <sys/time.h>
> +#include <pthread.h>
> +#include <stddef.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include "bench.h"
> +#include "futex.h"
> +
> +struct {
> +       unsigned int nbreakpoints;
> +       unsigned int nparallel;
> +       unsigned int nthreads;
> +} thread_params = {
> +       .nbreakpoints = 1,
> +       .nparallel = 1,
> +       .nthreads = 1,
> +};
> +
> +static const struct option thread_options[] = {
> +       OPT_UINTEGER('b', "breakpoints", &thread_params.nbreakpoints,
> +               "Specify amount of breakpoints"),
> +       OPT_UINTEGER('p', "parallelism", &thread_params.nparallel, "Specify amount of parallelism"),
> +       OPT_UINTEGER('t', "threads", &thread_params.nthreads, "Specify amount of threads"),
> +       OPT_END()
> +};
> +
> +static const char * const thread_usage[] = {
> +       "perf bench breakpoint thread <options>",
> +       NULL
> +};
> +
> +struct breakpoint {
> +       int fd;
> +       char watched;
> +};
> +
> +static int breakpoint_setup(void *addr)
> +{
> +       struct perf_event_attr attr = {0};
> +
> +       attr.type = PERF_TYPE_BREAKPOINT;
> +       attr.size = sizeof(attr);
> +       attr.inherit = 1;
> +       attr.exclude_kernel = 1;
> +       attr.exclude_hv = 1;
> +       attr.bp_addr = (uint64_t)addr;
> +       attr.bp_type = HW_BREAKPOINT_RW;
> +       attr.bp_len = HW_BREAKPOINT_LEN_1;
> +       return syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
> +}
> +
> +static void *passive_thread(void *arg)
> +{
> +       unsigned int *done = (unsigned int *)arg;
> +
> +       while (!__atomic_load_n(done, __ATOMIC_RELAXED))
> +               futex_wait(done, 0, NULL, 0);
> +       return NULL;
> +}
> +
> +static void *active_thread(void *arg)
> +{
> +       unsigned int *done = (unsigned int *)arg;
> +
> +       while (!__atomic_load_n(done, __ATOMIC_RELAXED));
> +       return NULL;
> +}
> +
> +static void *breakpoint_thread(void *arg)
> +{
> +       unsigned int i, done;
> +       int *repeat = (int *)arg;
> +       pthread_t *threads;
> +
> +       threads = calloc(thread_params.nthreads, sizeof(threads[0]));
> +       while (__atomic_fetch_sub(repeat, 1, __ATOMIC_RELAXED) > 0) {
> +               done = 0;
> +               for (i = 0; i < thread_params.nthreads; i++) {
> +                       if (pthread_create(&threads[i], NULL, passive_thread, &done))
> +                               exit((perror("pthread_create"), EXIT_FAILURE));
> +               }
> +               __atomic_store_n(&done, 1, __ATOMIC_RELAXED);
> +               futex_wake(&done, thread_params.nthreads, 0);
> +               for (i = 0; i < thread_params.nthreads; i++)
> +                       pthread_join(threads[i], NULL);
> +       }
> +       free(threads);
> +       return NULL;
> +}
> +
> +// The benchmark creates nbreakpoints inheritable breakpoints,
> +// then starts nparallel threads which create and join bench_repeat batches of nthreads threads.
> +int bench_breakpoint_thread(int argc, const char **argv)
> +{
> +       unsigned int i, result_usec;
> +       int repeat = bench_repeat;
> +       struct breakpoint *breakpoints;
> +       pthread_t *parallel;
> +       struct timeval start, stop, diff;
> +
> +       if (parse_options(argc, argv, thread_options, thread_usage, 0)) {
> +               usage_with_options(thread_usage, thread_options);
> +               exit(EXIT_FAILURE);
> +       }
> +       breakpoints = calloc(thread_params.nbreakpoints, sizeof(breakpoints[0]));
> +       parallel = calloc(thread_params.nparallel, sizeof(parallel[0]));
> +       for (i = 0; i < thread_params.nbreakpoints; i++) {
> +               breakpoints[i].fd = breakpoint_setup(&breakpoints[i].watched);
> +               if (breakpoints[i].fd == -1)
> +                       exit((perror("perf_event_open"), EXIT_FAILURE));
> +       }
> +       gettimeofday(&start, NULL);
> +       for (i = 0; i < thread_params.nparallel; i++) {
> +               if (pthread_create(&parallel[i], NULL, breakpoint_thread, &repeat))
> +                       exit((perror("pthread_create"), EXIT_FAILURE));
> +       }
> +       for (i = 0; i < thread_params.nparallel; i++)
> +               pthread_join(parallel[i], NULL);
> +       gettimeofday(&stop, NULL);
> +       timersub(&stop, &start, &diff);
> +       for (i = 0; i < thread_params.nbreakpoints; i++)
> +               close(breakpoints[i].fd);
> +       free(parallel);
> +       free(breakpoints);
> +       switch (bench_format) {
> +       case BENCH_FORMAT_DEFAULT:
> +               printf("# Created/joined %d threads with %d breakpoints and %d parallelism\n",
> +                       bench_repeat, thread_params.nbreakpoints, thread_params.nparallel);
> +               printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> +                       (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> +               result_usec = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +               printf(" %14lf usecs/op\n",
> +                       (double)result_usec / bench_repeat / thread_params.nthreads);
> +               printf(" %14lf usecs/op/cpu\n",
> +                       (double)result_usec / bench_repeat /
> +                       thread_params.nthreads * thread_params.nparallel);
> +               break;
> +       case BENCH_FORMAT_SIMPLE:
> +               printf("%lu.%03lu\n", (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> +               break;
> +       default:
> +               fprintf(stderr, "Unknown format: %d\n", bench_format);
> +               exit(EXIT_FAILURE);
> +       }
> +       return 0;
> +}
> +
> +struct {
> +       unsigned int npassive;
> +       unsigned int nactive;
> +} enable_params = {
> +       .nactive = 0,
> +       .npassive = 0,
> +};
> +
> +static const struct option enable_options[] = {
> +       OPT_UINTEGER('p', "passive", &enable_params.npassive, "Specify amount of passive threads"),
> +       OPT_UINTEGER('a', "active", &enable_params.nactive, "Specify amount of active threads"),
> +       OPT_END()
> +};
> +
> +static const char * const enable_usage[] = {
> +       "perf bench breakpoint enable <options>",
> +       NULL
> +};
> +
> +// The benchmark creates an inheritable breakpoint,
> +// then starts npassive threads that block and nactive threads that actively spin
> +// and then disables and enables the breakpoint bench_repeat times.
> +int bench_breakpoint_enable(int argc, const char **argv)
> +{
> +       unsigned int i, nthreads, result_usec, done = 0;
> +       char watched;
> +       int fd;
> +       pthread_t *threads;
> +       struct timeval start, stop, diff;
> +
> +       if (parse_options(argc, argv, enable_options, enable_usage, 0)) {
> +               usage_with_options(enable_usage, enable_options);
> +               exit(EXIT_FAILURE);
> +       }
> +       fd = breakpoint_setup(&watched);
> +       if (fd == -1)
> +               exit((perror("perf_event_open"), EXIT_FAILURE));
> +       nthreads = enable_params.npassive + enable_params.nactive;
> +       threads = calloc(nthreads, sizeof(threads[0]));
> +       for (i = 0; i < nthreads; i++) {
> +               if (pthread_create(&threads[i], NULL,
> +                       i < enable_params.npassive ? passive_thread : active_thread, &done))
> +                       exit((perror("pthread_create"), EXIT_FAILURE));
> +       }
> +       usleep(10000);  // let the threads block
> +       gettimeofday(&start, NULL);
> +       for (i = 0; i < bench_repeat; i++) {
> +               if (ioctl(fd, PERF_EVENT_IOC_DISABLE, 0))
> +                       exit((perror("ioctl(PERF_EVENT_IOC_DISABLE)"), EXIT_FAILURE));
> +               if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0))
> +                       exit((perror("ioctl(PERF_EVENT_IOC_ENABLE)"), EXIT_FAILURE));
> +       }
> +       gettimeofday(&stop, NULL);
> +       timersub(&stop, &start, &diff);
> +       __atomic_store_n(&done, 1, __ATOMIC_RELAXED);
> +       futex_wake(&done, enable_params.npassive, 0);
> +       for (i = 0; i < nthreads; i++)
> +               pthread_join(threads[i], NULL);
> +       free(threads);
> +       close(fd);
> +       switch (bench_format) {
> +       case BENCH_FORMAT_DEFAULT:
> +               printf("# Enabled/disabled breakpoint %d time with %d passive and %d active threads\n",
> +                       bench_repeat, enable_params.npassive, enable_params.nactive);
> +               printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> +                       (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> +               result_usec = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +               printf(" %14lf usecs/op\n", (double)result_usec / bench_repeat);
> +               break;
> +       case BENCH_FORMAT_SIMPLE:
> +               printf("%lu.%03lu\n", (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> +               break;
> +       default:
> +               fprintf(stderr, "Unknown format: %d\n", bench_format);
> +               exit(EXIT_FAILURE);
> +       }
> +       return 0;
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index d291f3a8af5f2..334ab897aae3b 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -92,6 +92,13 @@ static struct bench internals_benchmarks[] = {
>         { NULL,         NULL,                                   NULL                    }
>  };
>
> +static struct bench breakpoint_benchmarks[] = {
> +       { "thread", "Benchmark thread start/finish with breakpoints", bench_breakpoint_thread},
> +       { "enable", "Benchmark breakpoint enable/disable", bench_breakpoint_enable},
> +       { "all", "Run all breakpoint benchmarks", NULL},
> +       { NULL, NULL, NULL },
> +};
> +
>  struct collection {
>         const char      *name;
>         const char      *summary;
> @@ -110,6 +117,7 @@ static struct collection collections[] = {
>         {"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
>  #endif
>         { "internals",  "Perf-internals benchmarks",                    internals_benchmarks    },
> +       { "breakpoint", "Breakpoint benchmarks",                        breakpoint_benchmarks   },
>         { "all",        "All benchmarks",                               NULL                    },
>         { NULL,         NULL,                                           NULL                    }
>  };
>
> base-commit: bd24325684029a48f20a188b899eb84900d0bc9c
> --
> 2.36.0.464.gb9c8b46e94-goog
>
