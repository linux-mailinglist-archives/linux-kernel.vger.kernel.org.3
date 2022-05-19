Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5252CAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiESEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiESEHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:07:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80AAEE1B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:07:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so5327107wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNuXWhKssIgz97EAJOUK/IxpcOMm7Zfpt4AHtCRxlNE=;
        b=m0O77w9HmI2S/hjah0VunCdyktYpMvZNTiWjLwk4H49OZq/+goyNYFoZuYs3aSwnkx
         HrqB7M5mBXWUgci4wssPEybLL2E2mE7ZetYRiO7tlh2E8YENU0prowQR63E3pXvqxEOQ
         FyLn1I5oxje/sm96Rs6PrSwKNu1o49ypfgewJemHtYZcgWORzRU7UGUZGRAR4Q5QjiUl
         V0qGOoAZpeb2wIr/LKeuKw78mgSQQhMjh/xa2yL+IgO76G641lL1Jt5Wwl+jiRQb9zM3
         HdCL4aYczTKFNks627kG2tZ5NGdmjmQg2vOD52v3oa2a/miPHUyUipYhHS9RTNQ5kl6E
         hODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNuXWhKssIgz97EAJOUK/IxpcOMm7Zfpt4AHtCRxlNE=;
        b=nrb1C6nLF1UfQ+f8zqjZdp90cYVeu94xQ/rXlCc6jKpgwfCdnrN5L7j2yWjsybxSbI
         L1GxH5gueGtGdd71CpnQ6NM9O5H1Db8+6Et6HWq2xRWlifvLb+4crkSOrHdrcuwpTN1f
         r+ygiJANRnfAJod3TRIfkajuwTI5EMnbtFI+iqlDIgNehS8UNPXbpLyEWrpfEC+shD6e
         iu0uNkDBImPvYXbItIKARZ7DPkJLnlO/+iBgXWDfP6flVxMeM+bnTOUqxFVCyItHaDfw
         ib1jgbjToNBOGj9QWh9FCLvlMyQxHdx7DOmqv8Gvi3o14BzkQW2r98h1MCDr/V5to8WL
         am4g==
X-Gm-Message-State: AOAM530oBKugpUgNjweCYO3Tp7Nur5TJOIZSvGc+yTbt1+vhJJbJYgCk
        zoeTiS8SQ/tbS4XCyhBquDmFKdee5J9KFxdGcjkbwQ==
X-Google-Smtp-Source: ABdhPJz93eeXEcvDsp6fLms1s4bPDp7lz9yNI3GARG9eKflweNGTMm1+2b5k3LmMHmiJ6gvojhyfgph4Tfpci3XMP1U=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr2144365wri.343.1652933232287; Wed, 18
 May 2022 21:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-6-namhyung@kernel.org>
In-Reply-To: <20220518224725.742882-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:07:00 -0700
Message-ID: <CAP-5=fUL=KVpsd7rPOsWuML2iJGjciUe15Svdux67OsAngST1A@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf record: Add cgroup support for off-cpu profiling
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
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

On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> This covers two different use cases.  The first one is cgroup
> filtering given by -G/--cgroup option which controls the off-cpu
> profiling for tasks in the given cgroups only.
>
> The other use case is cgroup sampling which is enabled by
> --all-cgroups option and it adds PERF_SAMPLE_CGROUP to the sample_type
> to set the cgroup id of the task in the sample data.
>
> Example output.
>
>   $ sudo perf record -a --off-cpu --all-cgroups sleep 1
>
>   $ sudo perf report --stdio -s comm,cgroup --call-graph=no
>   ...
>   # Samples: 144  of event 'offcpu-time'
>   # Event count (approx.): 48452045427
>   #
>   # Children      Self  Command          Cgroup
>   # ........  ........  ...............  ..........................................
>   #
>       61.57%     5.60%  Chrome_ChildIOT  /user.slice/user-657345.slice/user@657345.service/app.slice/...
>       29.51%     7.38%  Web Content      /user.slice/user-657345.slice/user@657345.service/app.slice/...
>       17.48%     1.59%  Chrome_IOThread  /user.slice/user-657345.slice/user@657345.service/app.slice/...
>       16.48%     4.12%  pipewire-pulse   /user.slice/user-657345.slice/user@657345.service/session.slice/...
>       14.48%     2.07%  perf             /user.slice/user-657345.slice/user@657345.service/app.slice/...
>       14.30%     7.15%  CompositorTileW  /user.slice/user-657345.slice/user@657345.service/app.slice/...
>       13.33%     6.67%  Timer            /user.slice/user-657345.slice/user@657345.service/app.slice/...
>   ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c            |  2 +-
>  tools/perf/util/bpf_off_cpu.c          | 48 ++++++++++++++++++++++++--
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 33 ++++++++++++++++++
>  tools/perf/util/off_cpu.h              |  7 ++--
>  4 files changed, 85 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 7f60d2eac0b4..77fa21c2c69f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -907,7 +907,7 @@ static int record__config_text_poke(struct evlist *evlist)
>
>  static int record__config_off_cpu(struct record *rec)
>  {
> -       return off_cpu_prepare(rec->evlist, &rec->opts.target);
> +       return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>  }
>
>  static bool record__kcore_readable(struct machine *machine)
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 874856c55101..b73e84a02264 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -5,10 +5,12 @@
>  #include "util/evlist.h"
>  #include "util/off_cpu.h"
>  #include "util/perf-hooks.h"
> +#include "util/record.h"
>  #include "util/session.h"
>  #include "util/target.h"
>  #include "util/cpumap.h"
>  #include "util/thread_map.h"
> +#include "util/cgroup.h"
>  #include <bpf/bpf.h>
>
>  #include "bpf_skel/off_cpu.skel.h"
> @@ -24,6 +26,7 @@ struct off_cpu_key {
>         u32 tgid;
>         u32 stack_id;
>         u32 state;
> +       u64 cgroup_id;
>  };
>
>  union off_cpu_data {
> @@ -116,10 +119,11 @@ static void check_sched_switch_args(void)
>         }
>  }
>
> -int off_cpu_prepare(struct evlist *evlist, struct target *target)
> +int off_cpu_prepare(struct evlist *evlist, struct target *target,
> +                   struct record_opts *opts)
>  {
>         int err, fd, i;
> -       int ncpus = 1, ntasks = 1;
> +       int ncpus = 1, ntasks = 1, ncgrps = 1;
>
>         if (off_cpu_config(evlist) < 0) {
>                 pr_err("Failed to config off-cpu BPF event\n");
> @@ -143,6 +147,21 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
>                 bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
>         }
>
> +       if (evlist__first(evlist)->cgrp) {
> +               ncgrps = evlist->core.nr_entries - 1; /* excluding a dummy */
> +               bpf_map__set_max_entries(skel->maps.cgroup_filter, ncgrps);
> +
> +               if (!cgroup_is_v2("perf_event"))
> +                       skel->rodata->uses_cgroup_v1 = true;
> +       }
> +
> +       if (opts->record_cgroup) {
> +               skel->rodata->needs_cgroup = true;
> +
> +               if (!cgroup_is_v2("perf_event"))
> +                       skel->rodata->uses_cgroup_v1 = true;
> +       }
> +
>         set_max_rlimit();
>         check_sched_switch_args();
>
> @@ -178,6 +197,29 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
>                 }
>         }
>
> +       if (evlist__first(evlist)->cgrp) {
> +               struct evsel *evsel;
> +               u8 val = 1;
> +
> +               skel->bss->has_cgroup = 1;
> +               fd = bpf_map__fd(skel->maps.cgroup_filter);
> +
> +               evlist__for_each_entry(evlist, evsel) {
> +                       struct cgroup *cgrp = evsel->cgrp;
> +
> +                       if (cgrp == NULL)
> +                               continue;
> +
> +                       if (!cgrp->id && read_cgroup_id(cgrp) < 0) {
> +                               pr_err("Failed to read cgroup id of %s\n",
> +                                      cgrp->name);
> +                               goto out;
> +                       }
> +
> +                       bpf_map_update_elem(fd, &cgrp->id, &val, BPF_ANY);
> +               }
> +       }
> +
>         err = off_cpu_bpf__attach(skel);
>         if (err) {
>                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> @@ -275,6 +317,8 @@ int off_cpu_write(struct perf_session *session)
>                         /* calculate sample callchain data array length */
>                         n += len + 2;
>                 }
> +               if (sample_type & PERF_SAMPLE_CGROUP)
> +                       data.array[n++] = key.cgroup_id;
>                 /* TODO: handle more sample types */
>
>                 size = n * sizeof(u64);
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index 986d7db6e75d..792ae2847080 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -26,6 +26,7 @@ struct offcpu_key {
>         __u32 tgid;
>         __u32 stack_id;
>         __u32 state;
> +       __u64 cgroup_id;
>  };
>
>  struct {
> @@ -63,6 +64,13 @@ struct {
>         __uint(max_entries, 1);
>  } task_filter SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(key_size, sizeof(__u64));
> +       __uint(value_size, sizeof(__u8));
> +       __uint(max_entries, 1);
> +} cgroup_filter SEC(".maps");
> +
>  /* old kernel task_struct definition */
>  struct task_struct___old {
>         long state;
> @@ -71,8 +79,11 @@ struct task_struct___old {
>  int enabled = 0;
>  int has_cpu = 0;
>  int has_task = 0;
> +int has_cgroup = 0;
>
>  const volatile bool has_prev_state = false;
> +const volatile bool needs_cgroup = false;
> +const volatile bool uses_cgroup_v1 = false;
>
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
> @@ -92,6 +103,18 @@ static inline int get_task_state(struct task_struct *t)
>         return BPF_CORE_READ(t_old, state);
>  }
>
> +static inline __u64 get_cgroup_id(struct task_struct *t)
> +{
> +       struct cgroup *cgrp;
> +
> +       if (uses_cgroup_v1)
> +               cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
> +       else
> +               cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
> +
> +       return BPF_CORE_READ(cgrp, kn, id);
> +}
> +
>  static inline int can_record(struct task_struct *t, int state)
>  {
>         /* kernel threads don't have user stack */
> @@ -120,6 +143,15 @@ static inline int can_record(struct task_struct *t, int state)
>                         return 0;
>         }
>
> +       if (has_cgroup) {
> +               __u8 *ok;
> +               __u64 cgrp_id = get_cgroup_id(t);
> +
> +               ok = bpf_map_lookup_elem(&cgroup_filter, &cgrp_id);
> +               if (!ok)
> +                       return 0;
> +       }
> +
>         return 1;
>  }
>
> @@ -156,6 +188,7 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>                         .tgid = next->tgid,
>                         .stack_id = pelem->stack_id,
>                         .state = pelem->state,
> +                       .cgroup_id = needs_cgroup ? get_cgroup_id(next) : 0,
>                 };
>                 __u64 delta = ts - pelem->timestamp;
>                 __u64 *total;
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index f47af0232e55..548008f74d42 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -4,15 +4,18 @@
>  struct evlist;
>  struct target;
>  struct perf_session;
> +struct record_opts;
>
>  #define OFFCPU_EVENT  "offcpu-time"
>
>  #ifdef HAVE_BPF_SKEL
> -int off_cpu_prepare(struct evlist *evlist, struct target *target);
> +int off_cpu_prepare(struct evlist *evlist, struct target *target,
> +                   struct record_opts *opts);
>  int off_cpu_write(struct perf_session *session);
>  #else
>  static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
> -                                 struct target *target __maybe_unused)
> +                                 struct target *target __maybe_unused,
> +                                 struct record_opts *opts __maybe_unused)
>  {
>         return -1;
>  }
> --
> 2.36.1.124.g0e6072fb45-goog
>
