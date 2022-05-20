Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7952F3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353212AbiETT2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiETT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:28:43 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452418C052;
        Fri, 20 May 2022 12:28:41 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f1d5464c48so11392722fac.6;
        Fri, 20 May 2022 12:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cDuz6fQsc5aaEblyOpia8pv18iquWLvYErtJW4LGps=;
        b=i4IODgBPIiuF/mMNVw4CcSyjn7j3wU99E8TA5reSlMFNb5EjIE4v7XFjMtmPsH+d1q
         i/C2aDEZUZ7GAzuhmL8lNW6IGzFlEVyayPluidP4WufvzxZ+mzo6lGGr4qQVi0/kQGPX
         GRGhrgk1sU2HGZGHn6rBsbRW6bj+SlnDUw/mlVYh1y+a41OeUJJurJXtJmHu//u8YsL+
         kLPdebfLGamlDs0utnx+qdtuLisVOhjOxjtvj+H+pWZ2IAiLIGAyQU6WH+Kx2zfk6AVD
         EsKR9jI6eQREyKqdhyvRrQejU9vaYV3gp0rILmzYPfl6fMfTNCAEvRXiA+EEEDUZwrjx
         vwjA==
X-Gm-Message-State: AOAM533AzPhhEfEfffKS90gYyLUudpVlvgwKDzzGkzPeHEuR2NRGHghM
        jYMzUHKeYoubqx0jCaYRXfBRgFGvhH0DFX7pWjZHObAe
X-Google-Smtp-Source: ABdhPJx7BBa/4OP6RFw0ULAdpUukLO1CluVd2oxXHaf9x2VoeupAU3XTvXzii/RNn5g2ALAKRdrZtJxGnZnkjU6yINc=
X-Received: by 2002:a05:6870:d1cd:b0:e1:e7ee:faa0 with SMTP id
 b13-20020a056870d1cd00b000e1e7eefaa0mr6986769oac.5.1653074921048; Fri, 20 May
 2022 12:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com> <20220422093833.340873-4-nakamura.shun@fujitsu.com>
In-Reply-To: <20220422093833.340873-4-nakamura.shun@fujitsu.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 May 2022 12:28:29 -0700
Message-ID: <CAM9d7cjqP=M=V2neRC8WCQ-xAJKK0H21LK6vMo3MPed-QQ5WcA@mail.gmail.com>
Subject: Re: [PATCH 3/7] libperf: Add support for overflow handling of
 sampling events
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 2:44 AM Shunsuke Nakamura
<nakamura.shun@fujitsu.com> wrote:
>
> Extend the fields of the opts structure to set up overflow handling
> for sampling events. Also, add processing to set signal handlers in
> perf_evsel__open_opts.
>
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  6 +-
>  tools/lib/perf/Makefile                  |  1 +
>  tools/lib/perf/evsel.c                   | 79 ++++++++++++++++++++++++
>  tools/lib/perf/include/perf/evsel.h      |  6 +-
>  tools/lib/perf/tests/test-evlist.c       |  1 -
>  5 files changed, 90 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 6ca91ca94e01..ec93b1c75ebe 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -137,8 +137,12 @@ SYNOPSIS
>            size_t sz;
>
>            unsigned long open_flags;       /* perf_event_open flags */
> +          int flags;                      /* fcntl flags */

What about just rename it to fcntl_flags ?

> +          unsigned int signal;

int ?

> +          int owner_type;

Please add a comment that it's for F_SETOWN_EX.

> +          struct sigaction *sig;
>    };
> -  #define perf_evsel_open_opts__last_field open_flags
> +  #define perf_evsel_open_opts__last_field sig
>
>    #define LIBPERF_OPTS(TYPE, NAME, ...)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 21df023a2103..4c8fae193cf5 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -75,6 +75,7 @@ override CFLAGS += -Werror -Wall
>  override CFLAGS += -fPIC
>  override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
> +override CFLAGS += -D_GNU_SOURCE
>
>  all:
>
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 00c0cea43b52..a289f6c44d7c 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -460,6 +460,79 @@ void perf_counts_values__scale(struct perf_counts_values *count,
>                 *pscaled = scaled;
>  }
>
> +static int perf_evsel__run_fcntl(struct perf_evsel *evsel,
> +                                unsigned int cmd, unsigned long arg,
> +                                int cpu_map_idx)

I think it'd be better to have _cpu suffix in the function name
as it handles on the specific cpu.

> +{
> +       int thread;
> +
> +       for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> +               int err;
> +               int *fd = FD(evsel, cpu_map_idx, thread);
> +
> +               if (!fd || *fd < 0)
> +                       return -1;
> +
> +               err = fcntl(*fd, cmd, arg);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int perf_evsel__set_signal_handler(struct perf_evsel *evsel,
> +                                         struct perf_evsel_open_opts *opts)
> +{
> +       unsigned int flags;
> +       unsigned int signal;
> +       struct f_owner_ex owner;
> +       struct sigaction *sig;

It can be confused with the signal number, how about sigact?


> +       int cpu_map_idx;
> +       int err = 0;
> +
> +       flags = OPTS_GET(opts, flags, (O_RDWR | O_NONBLOCK | O_ASYNC));
> +       signal = OPTS_GET(opts, signal, SIGIO);
> +       owner.type = OPTS_GET(opts, owner_type, F_OWNER_PID);
> +       sig = OPTS_GET(opts, sig, NULL);
> +
> +       if (flags == 0 && signal == 0 && !owner.type == 0 && sig == 0)

You man want to check owner.type without "!".

> +               return err;
> +
> +       err = sigaction(signal, sig, NULL);
> +       if (err)
> +               return err;
> +
> +       switch (owner.type) {
> +       case F_OWNER_PID:
> +               owner.pid = getpid();
> +               break;
> +       case F_OWNER_TID:
> +               owner.pid = syscall(SYS_gettid);
> +               break;
> +       case F_OWNER_PGRP:
> +       default:
> +               return -1;
> +       }
> +
> +       for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd); cpu_map_idx++) {
> +               err = perf_evsel__run_fcntl(evsel, F_SETFL, flags, cpu_map_idx);
> +               if (err)
> +                       return err;
> +
> +               err = perf_evsel__run_fcntl(evsel, F_SETSIG, signal, cpu_map_idx);
> +               if (err)
> +                       return err;
> +
> +               err = perf_evsel__run_fcntl(evsel, F_SETOWN_EX,
> +                                           (unsigned long)&owner, cpu_map_idx);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return err;
> +}
> +
>  int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>                           struct perf_thread_map *threads,
>                           struct perf_evsel_open_opts *opts)
> @@ -474,6 +547,12 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>         evsel->open_flags = OPTS_GET(opts, open_flags, 0);
>
>         err = perf_evsel__open(evsel, cpus, threads);
> +       if (err)
> +               return err;
> +
> +       err = perf_evsel__set_signal_handler(evsel, opts);
> +       if (err)
> +               return err;
>
>         return err;
>  }
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 1140df4d2578..50662babfe97 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -29,8 +29,12 @@ struct perf_evsel_open_opts {
>         size_t sz;
>
>         unsigned long open_flags;       /* perf_event_open flags */
> +       int flags;                      /* fcntl flags */
> +       unsigned int signal;
> +       int owner_type;
> +       struct sigaction *sig;
>  };
> -#define perf_evsel_open_opts__last_field open_flags
> +#define perf_evsel_open_opts__last_field sig
>
>  #define LIBPERF_OPTS(TYPE, NAME, ...)                  \
>         struct TYPE NAME = ({                           \
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index ed616fc19b4f..d8f9493cd4d1 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)

Could be in a separate change.

Thanks,
Namhyung


>  #include <inttypes.h>
>  #include <sched.h>
>  #include <stdio.h>
> --
> 2.25.1
>
