Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC4480E03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhL2ACT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:02:19 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:36580 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhL2ACR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:02:17 -0500
Received: by mail-lj1-f171.google.com with SMTP id h21so21106674ljh.3;
        Tue, 28 Dec 2021 16:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32rsIg3VWqbZwutZeOh5ns8yO3D3rvXE7eV6PIDv43M=;
        b=tIkMQKmCHgV8kfVAyll26yJvy6HC//5K5ZUNJ5YIUGo9Lr5qn95Kvo9ZtQ/u79R5GL
         RpTWrGzX16CkTtI81yn1jg2uT9FAwtas9rsJqHprljVfX3M3uj7huEPUakILIjPycS/9
         gMOiKOTxBAZPyJyGTaRFmos197u6mUCCFwniG6hfty6eBt72vsLylvRdcEtKoAOP2lt4
         QkirMi07DBxbrSz5b8jZjOiTKP7uh5qcaXOYIk0/L6sr7FKF4NQh1KexFpjIyXcrLYJ/
         LTIGNwNsUDFRN4QAIwkbXvF49h3L7ySEkpPYRdPNQV/KdwQ7LsIXvq0tTRZrvFGKpfGW
         m1rA==
X-Gm-Message-State: AOAM533MEHD5MxAk7EcW6z0OWey5vzlT02fKB3kEhM1EZCIdod6XGkQ0
        jKvNOMKZ+ZJMa943HyA0emF8joHFfxMoeb6V0Jc=
X-Google-Smtp-Source: ABdhPJwrs+5JxAKAiON/UNJACTtNUH+au5yDJMDyLGaJYCBqe27a1k3M6ABWIKSxwU19T2AhXQkdkNMWEE6O7QKf/3c=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr16306056ljq.457.1640736135809;
 Tue, 28 Dec 2021 16:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-25-irogers@google.com>
In-Reply-To: <20211223074541.3318938-25-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 16:02:04 -0800
Message-ID: <CAM9d7ci5LY-sO0DYNk4TOa2RYC5XtAUXK8Q4=BO1YJGXWBV=5A@mail.gmail.com>
Subject: Re: [PATCH v2 24/48] perf cpumap: Add CPU to aggr_cpu_id
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:47 PM Ian Rogers <irogers@google.com> wrote:
>
> With no aggregration, such as 'perf stat -A', the aggr_cpu_id lacks a
> way to describe per CPU aggregation and the core is set to the CPU in
> places like print_counter_aggrdata in stat-display.c. Setting the core
> to the CPU is undesirable as the CPU will exceed valid core values and
> lead to confusion. Add a CPU variable to address this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 985c87f1f1ca..a535fd360d46 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -253,6 +253,20 @@ struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
>
>  }
>
> +struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data)
> +{
> +       struct aggr_cpu_id id;
> +
> +       /* aggr_cpu_id__die returns a struct with socket and die set*/

A copy and paste error?

Thanks,
Namhyung


> +       id = aggr_cpu_id__core(cpu, data);
> +       if (aggr_cpu_id__is_empty(&id))
> +               return id;
> +
> +       id.cpu = cpu;
> +       return id;
> +
> +}
> +
>  struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data __maybe_unused)
>  {
>         struct aggr_cpu_id id = aggr_cpu_id__empty();
> @@ -576,7 +590,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
>                 a->node == b->node &&
>                 a->socket == b->socket &&
>                 a->die == b->die &&
> -               a->core == b->core;
> +               a->core == b->core &&
> +               a->cpu == b->cpu;
>  }
>
>  bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
> @@ -585,7 +600,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
>                 a->node == -1 &&
>                 a->socket == -1 &&
>                 a->die == -1 &&
> -               a->core == -1;
> +               a->core == -1 &&
> +               a->cpu == -1;
>  }
>
>  struct aggr_cpu_id aggr_cpu_id__empty(void)
> @@ -595,7 +611,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
>                 .node = -1,
>                 .socket = -1,
>                 .die = -1,
> -               .core = -1
> +               .core = -1,
> +               .cpu = -1
>         };
>         return ret;
>  }
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 8acef8ff8753..651c6417d3c3 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -22,6 +22,8 @@ struct aggr_cpu_id {
>         int die;
>         /** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
>         int core;
> +       /** CPU aggregation, note there is one CPU for each SMT thread. */
> +       int cpu;
>  };
>
>  /** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
> @@ -109,6 +111,12 @@ struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data);
>   * compatible with aggr_cpu_id_get_t.
>   */
>  struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data);
> +/**
> + * aggr_cpu_id__core - Create an aggr_cpu_id with the cpu, core, die and socket
> + * populated with the cpu, core, die and socket for cpu. The function signature
> + * is compatible with aggr_cpu_id_get_t.
> + */
> +struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data);
>  /**
>   * aggr_cpu_id__node - Create an aggr_cpu_id with the numa node populated for
>   * cpu. The function signature is compatible with aggr_cpu_id_get_t.
> --
> 2.34.1.307.g9b7440fafd-goog
>
