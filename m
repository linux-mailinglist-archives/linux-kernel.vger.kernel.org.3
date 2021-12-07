Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25146C23E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbhLGSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:04:29 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41631 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:04:28 -0500
Received: by mail-lf1-f41.google.com with SMTP id z21so140838lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGsskQMQjpVQlfTy9skedeGAINE9Lj1BrqEY0Xhv8Ec=;
        b=rA1podhwNO076B1lJKXPOkxRnrHhr7znnrlBN3E8uKCoBpvW3Sn/LnkYIPmSc8EAok
         DOYQDh7s1S30fXEqSbeR53VGvJGXJTFWYJk1Xy6IA43rCxGMXe+Tl0yBRABMdrWKUsTI
         ZdCBu+5nJqe9+F4NAsCHNZZNYN4gbRkbXTRmZcsCFXvld2tCYzaN2wuM+qZZIpAsBMii
         b8tTyNODx532QfSo38k2NG4VJkehYS6x3HyP2rKo04zJLhfdHjvMW56mXdnHOMwm5NFG
         ehODrLTXVpvf5D0RGnB9WvPZw019mT/1hJzzsPZfXGqHWJvmP5RgW9aR7GKdxMGVOn23
         is8Q==
X-Gm-Message-State: AOAM5321RcauRqGEIocEP6tBIGJUfrHJKIaR6KMDsYT3Mb9BXr/SuBv0
        Sf59oDhm2nI7oXLSd/OdnprBnR76MqirxT1QFdcsim9S
X-Google-Smtp-Source: ABdhPJz6nU3KoXeHBuV1hMt1sYN6/QZNls3Gn+Ujwp30bB76GMI2xyOSUz4QzgZlBLUkJpwe6FfBIvr8OmvTvfEnOUE=
X-Received: by 2002:a19:4f42:: with SMTP id a2mr42617223lfk.47.1638900056871;
 Tue, 07 Dec 2021 10:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <20211129231830.1117781-5-namhyung@kernel.org>
 <738F7D58-264D-48A2-9A83-E7D126A50471@fb.com>
In-Reply-To: <738F7D58-264D-48A2-9A83-E7D126A50471@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Dec 2021 10:00:45 -0800
Message-ID: <CAM9d7cit6h25_fb7qfhw+erXPPRtHLfQ9EG478R_yjHiVOWQ6w@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency subcommand
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Mon, Dec 6, 2021 at 5:06 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Nov 29, 2021, at 3:18 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The -b/--use-bpf option is to use BPF to get latency info of kernel
> > functions.  It'd have better performance impact and I observed that
> > latency of same function is smaller than before when using BPF.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
>
> We can actually get something similar with a bpftrace one-liner, like:
>
> bpftrace -e 'kprobe:mutex_lock { @start[tid] = nsecs; } kretprobe:mutex_lock /@start[tid] != 0/ { @delay = hist(nsecs - @start[tid]); delete(@start[tid]); } END {clear(@start); }'
> Attaching 3 probes...
> ^C
>
> @delay:
> [256, 512)       1553006 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [512, 1K)          89171 |@@                                                  |
> [1K, 2K)           37522 |@                                                   |
> [2K, 4K)            3308 |                                                    |
> [4K, 8K)             415 |                                                    |
> [8K, 16K)             38 |                                                    |
> [16K, 32K)            47 |                                                    |
> [32K, 64K)             2 |                                                    |
> [64K, 128K)            0 |                                                    |
> [128K, 256K)           0 |                                                    |
> [256K, 512K)           0 |                                                    |
> [512K, 1M)             0 |                                                    |
> [1M, 2M)               0 |                                                    |
> [2M, 4M)               0 |                                                    |
> [4M, 8M)               1 |                                                    |
>
>
> So I am not quite sure whether we need this for systems with BPF features.

Yeah, bpftrace can do this too but there are situations one cannot
use the tool for some reason.  On the other hand, we have been
using perf tools widely to collect performance profiles on the fleet.

So it'd be really nice if we can use it as a vehicle to carry various
innovative features using BPF.  I plan to add more functionalities
in BCC/bpftrace to the perf tools in this regard.


>
> Other than this, a few comments and nitpicks below.
>
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 2e5bfbb69960..294b12430d73 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -144,6 +144,7 @@ perf-$(CONFIG_LIBBPF) += bpf-loader.o
> > perf-$(CONFIG_LIBBPF) += bpf_map.o
> > perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
> > perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> > +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
> > perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
> > perf-$(CONFIG_LIBELF) += symbol-elf.o
> > perf-$(CONFIG_LIBELF) += probe-file.o
> > diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> > new file mode 100644
> > index 000000000000..1975a6fe73c9
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_ftrace.c
> > @@ -0,0 +1,113 @@
> > +#include <stdio.h>
> > +#include <fcntl.h>
> > +#include <stdint.h>
> > +#include <stdlib.h>
> > +
> > +#include <linux/err.h>
> > +
> > +#include "util/ftrace.h"
> > +#include "util/debug.h"
> > +#include "util/bpf_counter.h"
> > +
> > +#include "util/bpf_skel/func_latency.skel.h"
> > +
> > +static struct func_latency_bpf *skel;
> > +
> > +int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
> > +{
> > +     int fd, err;
> > +     struct filter_entry *func;
> > +     struct bpf_link *begin_link, *end_link;
> > +
> > +     if (!list_is_singular(&ftrace->filters)) {
> > +             pr_err("ERROR: %s target function(s).\n",
> > +                    list_empty(&ftrace->filters) ? "No" : "Too many");
> > +             return -1;
> > +     }
> > +
> > +     func = list_first_entry(&ftrace->filters, struct filter_entry, list);
> > +
> > +     skel = func_latency_bpf__open();
> > +     if (!skel) {
> > +             pr_err("Failed to open func latency skeleton\n");
> > +             return -1;
> > +     }
> > +
> > +     set_max_rlimit();
> > +
> > +     err = func_latency_bpf__load(skel);
>
> We can do func_latency_bpf__open_and_load() to save a few lines.

Sure, but I was thinking to add some modifications between
them like in patch 5/5.

>
> > +     if (err) {
> > +             pr_err("Failed to load func latency skeleton\n");
> > +             goto out;
> > +     }
> > +
> > +     begin_link = bpf_program__attach_kprobe(skel->progs.func_begin,
> > +                                              false, func->name);
> > +     if (IS_ERR(begin_link)) {
> > +             pr_err("Failed to attach fentry program\n");
> > +             err = PTR_ERR(begin_link);
> > +             goto out;
> > +     }
> > +
> > +     end_link = bpf_program__attach_kprobe(skel->progs.func_end,
> > +                                           true, func->name);
> > +     if (IS_ERR(end_link)) {
> > +             pr_err("Failed to attach fexit program\n");
> > +             err = PTR_ERR(end_link);
> > +             bpf_link__destroy(begin_link);
> > +             goto out;
> > +     }
>
> I think we are leaking begin_link and end_link here? (They will be released
> on perf termination, but we are not freeing them in the code).

Right, I'll keep them and destroy at the end.

>
> [...]
>
> > diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
> > new file mode 100644
> > index 000000000000..d7d31cfeabf8
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +// Copyright (c) 2021 Google
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#define NUM_BUCKET  22
>
> We define NUM_BUCKET twice, which might cause issue when we change it.
> Maybe just use bpf_map__set_max_entries() in user space?

Sure, will do.

Thanks,
Namhyung
