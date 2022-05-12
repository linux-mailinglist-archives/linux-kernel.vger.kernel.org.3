Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBF524792
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351314AbiELIEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiELIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:04:38 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B42210B86
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:04:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e2fa360f6dso5766966fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqKG1NgSCQODDGQnJq/Jj45dVWvKzrP+TW5D3p4oSbk=;
        b=GczzKkExxDvf5edQwdTsP7nnMbagfK4Ezh5XjcfwMGRA51K9phqFpIrd/n6NtGNP4u
         wYLUOOZvu4OOtnYaCpUl2spCxDtWfZKFFrRYJphIgeD4Y4ez0rOH6xgDyjuV9dHcrLpt
         U+HQAEyX5VqYNQhTXo5ok6j/1wKQUXkTbbh+NYw9IUwXSNFK7HpYvS7tE/rsgRv1Aezj
         pO5avcE2IMmTSlEMZJtXCGHPOFurO8IEC9I0emuNTCdrJCXwpPs+0CJT86qa1XxD1yF4
         RvNM8JVkvASoVyzoBN8ffz0jSFCFYGWc4OjVunJItRdxJSfAO5GYcvvk4nMzLwVRkPLl
         qYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqKG1NgSCQODDGQnJq/Jj45dVWvKzrP+TW5D3p4oSbk=;
        b=iEBVPhlzW+qlAKPHeHQAkb4r7EL2rBY3kTpRXVcGj+5zx8dvBj4UPLZA51NyQwe3ur
         bmu75CPoIgExmvK7aQETtT8R0GcrT0N2e4bc7rWXOWoLu9R8kNosvLR6Pxcv9Ci76Qqa
         5t7sfiRYhMVshIo54EFtM8uCSaRvGF/IDSJZdJuARBOwm3bWlM89YvcRq3gTSfx+xoNU
         GR0WXdoiKY4+G4IFcqHD5G0bX+xF9S92fNo3pXOKQXG4L/1X7i4tv1ag1U2Db/59gUjV
         vi/wHDhLLH2SF1LUkvvrn4b326YyP1p6VxdG0HhzIi+m/ImfNiayJOa6JPm9MY1xIFDn
         4ilw==
X-Gm-Message-State: AOAM531iAa056eyZOL34/QW3UkHobooR4Qo8aqX09ngAurKG7TCAdaYB
        6+L3SYo+sHOlAaLnv6OVeLJLYeF746DIQFz/bkMFXw==
X-Google-Smtp-Source: ABdhPJxoW7Kiul2tlubpsThXGoUFIaG5rnBFqA1EbfHEJsoTAwjFN2RXeTQAUBqiY9nro9pQhKpvjVtZA1lWI4OP83E=
X-Received: by 2002:a05:6870:b61e:b0:ec:a426:bab5 with SMTP id
 cm30-20020a056870b61e00b000eca426bab5mr4888243oab.163.1652342675612; Thu, 12
 May 2022 01:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220505155745.1690906-1-dvyukov@google.com> <CAP-5=fVDs-AQvhXbZM9ksRqMdfS00Mpn8LDRZUppJb76TCkrAg@mail.gmail.com>
In-Reply-To: <CAP-5=fVDs-AQvhXbZM9ksRqMdfS00Mpn8LDRZUppJb76TCkrAg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 10:04:24 +0200
Message-ID: <CACT4Y+ZtjkwnGwsLGytvN7Zy+O8o_iewUAP5FK5vun34kdDScA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: add breakpoint benchmarks
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, elver@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

 On Wed, 11 May 2022 at 17:35, Ian Rogers <irogers@google.com> wrote:
>
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
>
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

I am ready to send a follow up with stdatomic.h if that's considered a
better option.
