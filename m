Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C724721A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhLMHXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:23:20 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43843 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhLMHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:23:19 -0500
Received: by mail-lf1-f48.google.com with SMTP id b40so29031064lfv.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnUR0p1Dx7mBNdkU/KsZpEyTVFgfeTiPCBQfd+x+DlM=;
        b=A1CHXSnk5A0oo5hw2ylhASlYJ8Z6HAy7nhxozTwb8H0j/dGVftx+pHEzQdDL7LlcNe
         yqr7eqQMb/qPpmZkpaJ7I9VS6w5om7qNw2Lf07DpYaXPccXjpdbaUAtO9QrQ6S3gGqjp
         7+4IWccdcP8MMXXLO1SVcKXtip1Us5+O49NpFb0yltI4eofoKwKgoAZFBiS7vcfuB0lY
         TkPdSDpOQHugSUsgko1KzHR+uK8i0hiA4vXbvGBwUIcp7dqRGnjSOd/9lxrgMPSalqQu
         ntHohBER86GuiTzhcaRP1olSQvqFC4lUAt9eCqJu4fx6m+7VZ7W8p1GOgAjABoQbODSJ
         fEPQ==
X-Gm-Message-State: AOAM530KoPZnj+BXPrw+68vCIP26LE7m9D2cjelVhABFMJd+YZU5UyDm
        fr3X8qoYW80S3QevR4oMl8iro7hpt6TndP8Rcks=
X-Google-Smtp-Source: ABdhPJzxp92s/3aYevSYcFzacr/1Y0VrgBCMD1pyZ/bv2x2y1cW/IRxUyAKaxORZyUDEMj3uGp+G0HGbffIH4tP5V9g=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr28575600lfv.481.1639380198458;
 Sun, 12 Dec 2021 23:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <20211129231830.1117781-5-namhyung@kernel.org>
 <738F7D58-264D-48A2-9A83-E7D126A50471@fb.com> <CAM9d7cit6h25_fb7qfhw+erXPPRtHLfQ9EG478R_yjHiVOWQ6w@mail.gmail.com>
In-Reply-To: <CAM9d7cit6h25_fb7qfhw+erXPPRtHLfQ9EG478R_yjHiVOWQ6w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 12 Dec 2021 23:23:07 -0800
Message-ID: <CAM9d7ci7-oMJXg6QRb_9YGg49EAWNPS8CkFLF4Wt8Gazq1v90w@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 10:00 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Song,
>
> On Mon, Dec 6, 2021 at 5:06 PM Song Liu <songliubraving@fb.com> wrote:
> >
> >
> >
> > > On Nov 29, 2021, at 3:18 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The -b/--use-bpf option is to use BPF to get latency info of kernel
> > > functions.  It'd have better performance impact and I observed that
> > > latency of same function is smaller than before when using BPF.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> >
> > We can actually get something similar with a bpftrace one-liner, like:
> >
> > bpftrace -e 'kprobe:mutex_lock { @start[tid] = nsecs; } kretprobe:mutex_lock /@start[tid] != 0/ { @delay = hist(nsecs - @start[tid]); delete(@start[tid]); } END {clear(@start); }'
> > Attaching 3 probes...
> > ^C
> >
> > @delay:
> > [256, 512)       1553006 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [512, 1K)          89171 |@@                                                  |
> > [1K, 2K)           37522 |@                                                   |
> > [2K, 4K)            3308 |                                                    |
> > [4K, 8K)             415 |                                                    |
> > [8K, 16K)             38 |                                                    |
> > [16K, 32K)            47 |                                                    |
> > [32K, 64K)             2 |                                                    |
> > [64K, 128K)            0 |                                                    |
> > [128K, 256K)           0 |                                                    |
> > [256K, 512K)           0 |                                                    |
> > [512K, 1M)             0 |                                                    |
> > [1M, 2M)               0 |                                                    |
> > [2M, 4M)               0 |                                                    |
> > [4M, 8M)               1 |                                                    |
> >
> >
> > So I am not quite sure whether we need this for systems with BPF features.
>
> Yeah, bpftrace can do this too but there are situations one cannot
> use the tool for some reason.  On the other hand, we have been
> using perf tools widely to collect performance profiles on the fleet.
>
> So it'd be really nice if we can use it as a vehicle to carry various
> innovative features using BPF.  I plan to add more functionalities
> in BCC/bpftrace to the perf tools in this regard.
>
>
> >
> > Other than this, a few comments and nitpicks below.
> >
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 2e5bfbb69960..294b12430d73 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -144,6 +144,7 @@ perf-$(CONFIG_LIBBPF) += bpf-loader.o
> > > perf-$(CONFIG_LIBBPF) += bpf_map.o
> > > perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
> > > perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> > > +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
> > > perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
> > > perf-$(CONFIG_LIBELF) += symbol-elf.o
> > > perf-$(CONFIG_LIBELF) += probe-file.o
> > > diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> > > new file mode 100644
> > > index 000000000000..1975a6fe73c9
> > > --- /dev/null
> > > +++ b/tools/perf/util/bpf_ftrace.c
> > > @@ -0,0 +1,113 @@
> > > +#include <stdio.h>
> > > +#include <fcntl.h>
> > > +#include <stdint.h>
> > > +#include <stdlib.h>
> > > +
> > > +#include <linux/err.h>
> > > +
> > > +#include "util/ftrace.h"
> > > +#include "util/debug.h"
> > > +#include "util/bpf_counter.h"
> > > +
> > > +#include "util/bpf_skel/func_latency.skel.h"
> > > +
> > > +static struct func_latency_bpf *skel;
> > > +
> > > +int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
> > > +{
> > > +     int fd, err;
> > > +     struct filter_entry *func;
> > > +     struct bpf_link *begin_link, *end_link;
> > > +
> > > +     if (!list_is_singular(&ftrace->filters)) {
> > > +             pr_err("ERROR: %s target function(s).\n",
> > > +                    list_empty(&ftrace->filters) ? "No" : "Too many");
> > > +             return -1;
> > > +     }
> > > +
> > > +     func = list_first_entry(&ftrace->filters, struct filter_entry, list);
> > > +
> > > +     skel = func_latency_bpf__open();
> > > +     if (!skel) {
> > > +             pr_err("Failed to open func latency skeleton\n");
> > > +             return -1;
> > > +     }
> > > +
> > > +     set_max_rlimit();
> > > +
> > > +     err = func_latency_bpf__load(skel);
> >
> > We can do func_latency_bpf__open_and_load() to save a few lines.
>
> Sure, but I was thinking to add some modifications between
> them like in patch 5/5.
>
> >
> > > +     if (err) {
> > > +             pr_err("Failed to load func latency skeleton\n");
> > > +             goto out;
> > > +     }
> > > +
> > > +     begin_link = bpf_program__attach_kprobe(skel->progs.func_begin,
> > > +                                              false, func->name);
> > > +     if (IS_ERR(begin_link)) {
> > > +             pr_err("Failed to attach fentry program\n");
> > > +             err = PTR_ERR(begin_link);
> > > +             goto out;
> > > +     }
> > > +
> > > +     end_link = bpf_program__attach_kprobe(skel->progs.func_end,
> > > +                                           true, func->name);
> > > +     if (IS_ERR(end_link)) {
> > > +             pr_err("Failed to attach fexit program\n");
> > > +             err = PTR_ERR(end_link);
> > > +             bpf_link__destroy(begin_link);
> > > +             goto out;
> > > +     }
> >
> > I think we are leaking begin_link and end_link here? (They will be released
> > on perf termination, but we are not freeing them in the code).
>
> Right, I'll keep them and destroy at the end.

Oh, it seems I can just use skel->links.func_begin (and _end).

>
> >
> > [...]
> >
> > > diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
> > > new file mode 100644
> > > index 000000000000..d7d31cfeabf8
> > > --- /dev/null
> > > +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> > > @@ -0,0 +1,92 @@
> > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +// Copyright (c) 2021 Google
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +#define NUM_BUCKET  22
> >
> > We define NUM_BUCKET twice, which might cause issue when we change it.
> > Maybe just use bpf_map__set_max_entries() in user space?

It's also used for the loop count so I need to keep it..
Maybe I can add a comment to inform that it should be in sync
with the userspace.

Thanks,
Namhyung
