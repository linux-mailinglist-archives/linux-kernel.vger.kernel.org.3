Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E3523C36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbiEKSIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEKSII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982584C42E;
        Wed, 11 May 2022 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2195461DE9;
        Wed, 11 May 2022 18:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE8C340EE;
        Wed, 11 May 2022 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652292485;
        bh=s3Uj5z2jK9360nVzQqgYKlZfc8dFQIlZtVcyCHnD0f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoRFSR/Jj011J0pJjrks+MzcCEegnPeU0pButN0H/HMcp9yITFz4KPR0g7FKWmwyj
         w3DslEiyLTAeek2djBqm9iVGlMQMLzUZOLYlQ+Mu5rU3kKgFzIufewyqQhISuWnk/D
         ImPeiYK2zcBuZiXk6feVbDnYAwGOOR181AEBDEA3l7dW1SDPWwdfmkF4e5zsfXY/03
         +p9ASMfxZCETJliApJLQ9tC31MpFtsRUxlShs2KqiJZHbGJSXEaEp5iZ2D2++82wqu
         0nIfq58pjJZ8WGBdfvVsHzi+UB8ro2/G5Hvrvy78g6s2NFKX1yZYau9omPKsflQMeg
         BXQGu6ALRYvzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E982400B1; Wed, 11 May 2022 15:08:02 -0300 (-03)
Date:   Wed, 11 May 2022 15:08:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, elver@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf: add breakpoint benchmarks
Message-ID: <Ynv7gkbBVd9dlJRh@kernel.org>
References: <20220505155745.1690906-1-dvyukov@google.com>
 <CAP-5=fVDs-AQvhXbZM9ksRqMdfS00Mpn8LDRZUppJb76TCkrAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVDs-AQvhXbZM9ksRqMdfS00Mpn8LDRZUppJb76TCkrAg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 11, 2022 at 08:34:58AM -0700, Ian Rogers escreveu:
> On Thu, May 5, 2022 at 8:58 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > Add 2 benchmarks:
> > 1. Performance of thread creation/exiting in presence of breakpoints.
> > 2. Performance of breakpoint modification in presence of threads.
> >
> > The benchmarks capture use cases that we are interested in:
> > using inheritable breakpoints in large highly-threaded applications.
> > The benchmarks show significant slowdown imposed by breakpoints
> > (even when they don't fire).
> >
> > Testing on Intel 8173M with 112 HW threads show:
> >
> > perf bench --repeat=56 breakpoint thread --breakpoints=0 --parallelism=56 --threads=20
> >       78.675000 usecs/op
> > perf bench --repeat=56 breakpoint thread --breakpoints=4 --parallelism=56 --threads=20
> >    12967.135714 usecs/op
> > That's 165x slowdown due to presence of the breakpoints.
> >
> > perf bench --repeat=20000 breakpoint enable --passive=0 --active=0
> >        1.433250 usecs/op
> > perf bench --repeat=20000 breakpoint enable --passive=224 --active=0
> >      585.318400 usecs/op
> > perf bench --repeat=20000 breakpoint enable --passive=0 --active=111
> >      635.953000 usecs/op
> > That's 408x and 444x slowdown due to presence of threads.
> >
> > Profiles show some overhead in toggle_bp_slot,
> > but also very high contention:
> >
> >     90.83%  breakpoint-thre  [kernel.kallsyms]  [k] osq_lock
> >      4.69%  breakpoint-thre  [kernel.kallsyms]  [k] mutex_spin_on_owner
> >      2.06%  breakpoint-thre  [kernel.kallsyms]  [k] __reserve_bp_slot
> >      2.04%  breakpoint-thre  [kernel.kallsyms]  [k] toggle_bp_slot
> >
> >     79.01%  breakpoint-enab  [kernel.kallsyms]  [k] smp_call_function_single
> >      9.94%  breakpoint-enab  [kernel.kallsyms]  [k] llist_add_batch
> >      5.70%  breakpoint-enab  [kernel.kallsyms]  [k] _raw_spin_lock_irq
> >      1.84%  breakpoint-enab  [kernel.kallsyms]  [k] event_function_call
> >      1.12%  breakpoint-enab  [kernel.kallsyms]  [k] send_call_function_single_ipi
> >      0.37%  breakpoint-enab  [kernel.kallsyms]  [k] generic_exec_single
> >      0.24%  breakpoint-enab  [kernel.kallsyms]  [k] __perf_event_disable
> >      0.20%  breakpoint-enab  [kernel.kallsyms]  [k] _perf_event_enable
> >      0.18%  breakpoint-enab  [kernel.kallsyms]  [k] toggle_bp_slot
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/perf/bench/Build        |   1 +
> >  tools/perf/bench/bench.h      |   2 +
> >  tools/perf/bench/breakpoint.c | 235 ++++++++++++++++++++++++++++++++++
> >  tools/perf/builtin-bench.c    |   8 ++
> >  4 files changed, 246 insertions(+)
> >  create mode 100644 tools/perf/bench/breakpoint.c
> >
> > diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> > index 61d45fcb4057c..6b6155a8ad096 100644
> > --- a/tools/perf/bench/Build
> > +++ b/tools/perf/bench/Build
> > @@ -14,6 +14,7 @@ perf-y += kallsyms-parse.o
> >  perf-y += find-bit-bench.o
> >  perf-y += inject-buildid.o
> >  perf-y += evlist-open-close.o
> > +perf-y += breakpoint.o
> >
> >  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
> >  perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
> > diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> > index b3480bc33fe84..6cefb4315d75e 100644
> > --- a/tools/perf/bench/bench.h
> > +++ b/tools/perf/bench/bench.h
> > @@ -49,6 +49,8 @@ int bench_synthesize(int argc, const char **argv);
> >  int bench_kallsyms_parse(int argc, const char **argv);
> >  int bench_inject_build_id(int argc, const char **argv);
> >  int bench_evlist_open_close(int argc, const char **argv);
> > +int bench_breakpoint_thread(int argc, const char **argv);
> > +int bench_breakpoint_enable(int argc, const char **argv);
> >
> >  #define BENCH_FORMAT_DEFAULT_STR       "default"
> >  #define BENCH_FORMAT_DEFAULT           0
> > diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
> > new file mode 100644
> > index 0000000000000..56936fea246d7
> > --- /dev/null
> > +++ b/tools/perf/bench/breakpoint.c
> > @@ -0,0 +1,235 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <subcmd/parse-options.h>
> > +#include <linux/hw_breakpoint.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/time64.h>
> > +#include <sys/syscall.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/time.h>
> > +#include <pthread.h>
> > +#include <stddef.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include "bench.h"
> > +#include "futex.h"
> > +
> > +struct {
> > +       unsigned int nbreakpoints;
> > +       unsigned int nparallel;
> > +       unsigned int nthreads;
> > +} thread_params = {
> > +       .nbreakpoints = 1,
> > +       .nparallel = 1,
> > +       .nthreads = 1,
> > +};
> > +
> > +static const struct option thread_options[] = {
> > +       OPT_UINTEGER('b', "breakpoints", &thread_params.nbreakpoints,
> > +               "Specify amount of breakpoints"),
> > +       OPT_UINTEGER('p', "parallelism", &thread_params.nparallel, "Specify amount of parallelism"),
> > +       OPT_UINTEGER('t', "threads", &thread_params.nthreads, "Specify amount of threads"),
> > +       OPT_END()
> > +};
> > +
> > +static const char * const thread_usage[] = {
> > +       "perf bench breakpoint thread <options>",
> > +       NULL
> > +};
> > +
> > +struct breakpoint {
> > +       int fd;
> > +       char watched;
> > +};
> > +
> > +static int breakpoint_setup(void *addr)
> > +{
> > +       struct perf_event_attr attr = {0};
> > +
> > +       attr.type = PERF_TYPE_BREAKPOINT;
> > +       attr.size = sizeof(attr);
> > +       attr.inherit = 1;
> > +       attr.exclude_kernel = 1;
> > +       attr.exclude_hv = 1;
> > +       attr.bp_addr = (uint64_t)addr;
> > +       attr.bp_type = HW_BREAKPOINT_RW;
> > +       attr.bp_len = HW_BREAKPOINT_LEN_1;
> > +       return syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
> > +}
> > +
> > +static void *passive_thread(void *arg)
> > +{
> > +       unsigned int *done = (unsigned int *)arg;
> > +
> > +       while (!__atomic_load_n(done, __ATOMIC_RELAXED))
> 
> Note, this may be the first change with atomics since Linux moved to
> C11 which may make the use of stdatomic.h more idiomatic. Just
> flagging for potential future cleanup.
> 
> Thanks,
> Ian
> 
> > +               futex_wait(done, 0, NULL, 0);
> > +       return NULL;
> > +}
> > +
> > +static void *active_thread(void *arg)
> > +{
> > +       unsigned int *done = (unsigned int *)arg;
> > +
> > +       while (!__atomic_load_n(done, __ATOMIC_RELAXED));
> > +       return NULL;
> > +}
> > +
> > +static void *breakpoint_thread(void *arg)
> > +{
> > +       unsigned int i, done;
> > +       int *repeat = (int *)arg;
> > +       pthread_t *threads;
> > +
> > +       threads = calloc(thread_params.nthreads, sizeof(threads[0]));
> > +       while (__atomic_fetch_sub(repeat, 1, __ATOMIC_RELAXED) > 0) {
> > +               done = 0;
> > +               for (i = 0; i < thread_params.nthreads; i++) {
> > +                       if (pthread_create(&threads[i], NULL, passive_thread, &done))
> > +                               exit((perror("pthread_create"), EXIT_FAILURE));
> > +               }
> > +               __atomic_store_n(&done, 1, __ATOMIC_RELAXED);
> > +               futex_wake(&done, thread_params.nthreads, 0);
> > +               for (i = 0; i < thread_params.nthreads; i++)
> > +                       pthread_join(threads[i], NULL);
> > +       }
> > +       free(threads);
> > +       return NULL;
> > +}
> > +
> > +// The benchmark creates nbreakpoints inheritable breakpoints,
> > +// then starts nparallel threads which create and join bench_repeat batches of nthreads threads.
> > +int bench_breakpoint_thread(int argc, const char **argv)
> > +{
> > +       unsigned int i, result_usec;
> > +       int repeat = bench_repeat;
> > +       struct breakpoint *breakpoints;
> > +       pthread_t *parallel;
> > +       struct timeval start, stop, diff;
> > +
> > +       if (parse_options(argc, argv, thread_options, thread_usage, 0)) {
> > +               usage_with_options(thread_usage, thread_options);
> > +               exit(EXIT_FAILURE);
> > +       }
> > +       breakpoints = calloc(thread_params.nbreakpoints, sizeof(breakpoints[0]));
> > +       parallel = calloc(thread_params.nparallel, sizeof(parallel[0]));
> > +       for (i = 0; i < thread_params.nbreakpoints; i++) {
> > +               breakpoints[i].fd = breakpoint_setup(&breakpoints[i].watched);
> > +               if (breakpoints[i].fd == -1)
> > +                       exit((perror("perf_event_open"), EXIT_FAILURE));
> > +       }
> > +       gettimeofday(&start, NULL);
> > +       for (i = 0; i < thread_params.nparallel; i++) {
> > +               if (pthread_create(&parallel[i], NULL, breakpoint_thread, &repeat))
> > +                       exit((perror("pthread_create"), EXIT_FAILURE));
> > +       }
> > +       for (i = 0; i < thread_params.nparallel; i++)
> > +               pthread_join(parallel[i], NULL);
> > +       gettimeofday(&stop, NULL);
> > +       timersub(&stop, &start, &diff);
> > +       for (i = 0; i < thread_params.nbreakpoints; i++)
> > +               close(breakpoints[i].fd);
> > +       free(parallel);
> > +       free(breakpoints);
> > +       switch (bench_format) {
> > +       case BENCH_FORMAT_DEFAULT:
> > +               printf("# Created/joined %d threads with %d breakpoints and %d parallelism\n",
> > +                       bench_repeat, thread_params.nbreakpoints, thread_params.nparallel);
> > +               printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> > +                       (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> > +               result_usec = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> > +               printf(" %14lf usecs/op\n",
> > +                       (double)result_usec / bench_repeat / thread_params.nthreads);
> > +               printf(" %14lf usecs/op/cpu\n",
> > +                       (double)result_usec / bench_repeat /
> > +                       thread_params.nthreads * thread_params.nparallel);
> > +               break;
> > +       case BENCH_FORMAT_SIMPLE:
> > +               printf("%lu.%03lu\n", (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> > +               break;
> > +       default:
> > +               fprintf(stderr, "Unknown format: %d\n", bench_format);
> > +               exit(EXIT_FAILURE);
> > +       }
> > +       return 0;
> > +}
> > +
> > +struct {
> > +       unsigned int npassive;
> > +       unsigned int nactive;
> > +} enable_params = {
> > +       .nactive = 0,
> > +       .npassive = 0,
> > +};
> > +
> > +static const struct option enable_options[] = {
> > +       OPT_UINTEGER('p', "passive", &enable_params.npassive, "Specify amount of passive threads"),
> > +       OPT_UINTEGER('a', "active", &enable_params.nactive, "Specify amount of active threads"),
> > +       OPT_END()
> > +};
> > +
> > +static const char * const enable_usage[] = {
> > +       "perf bench breakpoint enable <options>",
> > +       NULL
> > +};
> > +
> > +// The benchmark creates an inheritable breakpoint,
> > +// then starts npassive threads that block and nactive threads that actively spin
> > +// and then disables and enables the breakpoint bench_repeat times.
> > +int bench_breakpoint_enable(int argc, const char **argv)
> > +{
> > +       unsigned int i, nthreads, result_usec, done = 0;
> > +       char watched;
> > +       int fd;
> > +       pthread_t *threads;
> > +       struct timeval start, stop, diff;
> > +
> > +       if (parse_options(argc, argv, enable_options, enable_usage, 0)) {
> > +               usage_with_options(enable_usage, enable_options);
> > +               exit(EXIT_FAILURE);
> > +       }
> > +       fd = breakpoint_setup(&watched);
> > +       if (fd == -1)
> > +               exit((perror("perf_event_open"), EXIT_FAILURE));
> > +       nthreads = enable_params.npassive + enable_params.nactive;
> > +       threads = calloc(nthreads, sizeof(threads[0]));
> > +       for (i = 0; i < nthreads; i++) {
> > +               if (pthread_create(&threads[i], NULL,
> > +                       i < enable_params.npassive ? passive_thread : active_thread, &done))
> > +                       exit((perror("pthread_create"), EXIT_FAILURE));
> > +       }
> > +       usleep(10000);  // let the threads block
> > +       gettimeofday(&start, NULL);
> > +       for (i = 0; i < bench_repeat; i++) {
> > +               if (ioctl(fd, PERF_EVENT_IOC_DISABLE, 0))
> > +                       exit((perror("ioctl(PERF_EVENT_IOC_DISABLE)"), EXIT_FAILURE));
> > +               if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0))
> > +                       exit((perror("ioctl(PERF_EVENT_IOC_ENABLE)"), EXIT_FAILURE));
> > +       }
> > +       gettimeofday(&stop, NULL);
> > +       timersub(&stop, &start, &diff);
> > +       __atomic_store_n(&done, 1, __ATOMIC_RELAXED);
> > +       futex_wake(&done, enable_params.npassive, 0);
> > +       for (i = 0; i < nthreads; i++)
> > +               pthread_join(threads[i], NULL);
> > +       free(threads);
> > +       close(fd);
> > +       switch (bench_format) {
> > +       case BENCH_FORMAT_DEFAULT:
> > +               printf("# Enabled/disabled breakpoint %d time with %d passive and %d active threads\n",
> > +                       bench_repeat, enable_params.npassive, enable_params.nactive);
> > +               printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> > +                       (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> > +               result_usec = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> > +               printf(" %14lf usecs/op\n", (double)result_usec / bench_repeat);
> > +               break;
> > +       case BENCH_FORMAT_SIMPLE:
> > +               printf("%lu.%03lu\n", (long)diff.tv_sec, (long)(diff.tv_usec / USEC_PER_MSEC));
> > +               break;
> > +       default:
> > +               fprintf(stderr, "Unknown format: %d\n", bench_format);
> > +               exit(EXIT_FAILURE);
> > +       }
> > +       return 0;
> > +}
> > diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> > index d291f3a8af5f2..334ab897aae3b 100644
> > --- a/tools/perf/builtin-bench.c
> > +++ b/tools/perf/builtin-bench.c
> > @@ -92,6 +92,13 @@ static struct bench internals_benchmarks[] = {
> >         { NULL,         NULL,                                   NULL                    }
> >  };
> >
> > +static struct bench breakpoint_benchmarks[] = {
> > +       { "thread", "Benchmark thread start/finish with breakpoints", bench_breakpoint_thread},
> > +       { "enable", "Benchmark breakpoint enable/disable", bench_breakpoint_enable},
> > +       { "all", "Run all breakpoint benchmarks", NULL},
> > +       { NULL, NULL, NULL },
> > +};
> > +
> >  struct collection {
> >         const char      *name;
> >         const char      *summary;
> > @@ -110,6 +117,7 @@ static struct collection collections[] = {
> >         {"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
> >  #endif
> >         { "internals",  "Perf-internals benchmarks",                    internals_benchmarks    },
> > +       { "breakpoint", "Breakpoint benchmarks",                        breakpoint_benchmarks   },
> >         { "all",        "All benchmarks",                               NULL                    },
> >         { NULL,         NULL,                                           NULL                    }
> >  };
> >
> > base-commit: bd24325684029a48f20a188b899eb84900d0bc9c
> > --
> > 2.36.0.464.gb9c8b46e94-goog
> >

-- 

- Arnaldo
