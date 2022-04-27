Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9143E510E17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356897AbiD0Bql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiD0Bqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:46:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2182B33EBF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:43:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so440157wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEw35Gp3O6jItGy5TeIREN+UddKvpiKz43OtX2JxC44=;
        b=gwADGsklxjgdgANW7WaTe0AWCSx6+zME7mNBDa+HZoyoqD892mcONC4xTne87haJmd
         akJpYS2M2erRLSTrWOiywXtw/wJBv5jx6SncUA+XVb5KDp0am6DsBiHmNLkI9GKAu9hl
         M2fzvTlkxCQTcpxyxQz5l+1ymJUB/FkEQgKK9amNt5kcJddywFnqnS/ghVzOBAX2qn8/
         2U3VflbOA01kMtN82G3GoesgogAlSh07G9/XZAIl/NxKIdu8s+cOGvXGABReWw9TWkWI
         vs/lc9zkJPihvbQOJX0g4vRLyZtHKIbNmpnMv6OEd5lu7bcoV3LfaKdlUzFF6UARS7kh
         D4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEw35Gp3O6jItGy5TeIREN+UddKvpiKz43OtX2JxC44=;
        b=ULmIWZ1+9iN8iFGIlBwgJy85L53/vW9dyAMU9xVOpR1hHFHaFBe3/US9MQoaZM6Fdy
         QYx+nRJ2kwflgEI7RnSUhqvj0HhXEtUXse1Mc1fre166arERQ6kAPLKVY+qwneKtTz4b
         tbjrw5HiLVivgCEJEoFOAHdhgVPnMHX88jdIOwIlYSsuC3lDRgF7rAw7J9YSdZlp45Zx
         enn+JOw0JuEzDSwYU+1RZOlTh6wGwiWIiufCj1sogh6HGaG8PIDdO+mA+z87k8JIM0uA
         kXUi8lcbJbiZt7NjoXEBY53/YW7tHvKgt4KHUNC3RYDFVtJj4xsQ3etKTv3dBKCW272u
         dIqQ==
X-Gm-Message-State: AOAM531os1GMA7NBwB8tehN74JkeAJsF7W94WXzzSVqPcVkA11tZ8oV9
        XKU4rERRn1JYer09gBjP4StndB+QOXKWG+MFFcmUyw==
X-Google-Smtp-Source: ABdhPJycC3jod/dBJDv4n46N1zIlGD5c9ulPdHvzj9z3nMIa399lUMlAQR5V385sDEFWVvS7d9LwzXULnDwLeFg6Nsc=
X-Received: by 2002:adf:eb09:0:b0:207:bb77:9abb with SMTP id
 s9-20020adfeb09000000b00207bb779abbmr20421879wrn.375.1651023808407; Tue, 26
 Apr 2022 18:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102354.468173-1-florian.fischer@muhq.space> <20220420102354.468173-2-florian.fischer@muhq.space>
In-Reply-To: <20220420102354.468173-2-florian.fischer@muhq.space>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Apr 2022 18:43:16 -0700
Message-ID: <CAP-5=fU7KfsFzk-aJ0d9q-VXw6HkMjDLaniD3u3155q=_6f3-A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] perf stat: introduce stats for the user and system
 rusage times
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     linux-perf-users@vger.kernel.org,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 3:24 AM Florian Fischer
<florian.fischer@muhq.space> wrote:
>
> This is preparation for exporting rusage values as tool events.
>
> Add new global stats tracking the values obtained via rusage.
> For now only ru_utime and ru_stime are part of the tracked stats.
> Both are stored as nanoseconds to be consistent with 'duration_time',
> although the finest resolution the struct timeval data in rusage
> provides are microseconds.
>
> Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
> ---
>  tools/perf/builtin-stat.c     |  5 ++++-
>  tools/perf/util/stat-shadow.c |  2 ++
>  tools/perf/util/stat.h        | 21 +++++++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..61faffb535f5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -216,6 +216,7 @@ static struct perf_stat_config stat_config = {
>         .run_count              = 1,
>         .metric_only_len        = METRIC_ONLY_LEN,
>         .walltime_nsecs_stats   = &walltime_nsecs_stats,
> +       .ru_stats               = &ru_stats,
>         .big_num                = true,
>         .ctl_fd                 = -1,
>         .ctl_fd_ack             = -1,
> @@ -1010,8 +1011,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                 evlist__reset_prev_raw_counts(evsel_list);
>                 runtime_stat_reset(&stat_config);
>                 perf_stat__reset_shadow_per_stat(&rt_stat);
> -       } else
> +       } else {
>                 update_stats(&walltime_nsecs_stats, t1 - t0);
> +               update_rusage_stats(&ru_stats, &stat_config.ru_data);
> +       }
>
>         /*
>          * Closing a group leader splits the group, and as we only disable
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 10af7804e482..ea4c35e4f1da 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -26,6 +26,7 @@
>
>  struct runtime_stat rt_stat;
>  struct stats walltime_nsecs_stats;
> +struct rusage_stats ru_stats;
>
>  struct saved_value {
>         struct rb_node rb_node;
> @@ -199,6 +200,7 @@ void perf_stat__reset_shadow_stats(void)
>  {
>         reset_stat(&rt_stat);
>         memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
> +       memset(&ru_stats, 0, sizeof(ru_stats));
>  }
>
>  void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 335d19cc3063..e31c94d952e9 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -108,6 +108,11 @@ struct runtime_stat {
>         struct rblist value_list;
>  };
>
> +struct rusage_stats {
> +       struct stats ru_utime_usec_stat;
> +       struct stats ru_stime_usec_stat;
> +};
> +
>  typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, struct perf_cpu cpu);
>
>  struct perf_stat_config {
> @@ -148,6 +153,7 @@ struct perf_stat_config {
>         const char              *csv_sep;
>         struct stats            *walltime_nsecs_stats;
>         struct rusage            ru_data;
> +       struct rusage_stats              *ru_stats;
>         struct cpu_aggr_map     *aggr_map;
>         aggr_get_id_t            aggr_get_id;
>         struct cpu_aggr_map     *cpus_aggr_map;
> @@ -177,6 +183,20 @@ static inline void init_stats(struct stats *stats)
>         stats->max  = 0;
>  }
>
> +static inline void init_rusage_stats(struct rusage_stats *ru_stats) {
> +       init_stats(&ru_stats->ru_utime_usec_stat);
> +       init_stats(&ru_stats->ru_stime_usec_stat);
> +}

Is there a missing call to this function?

Thanks,
Ian

> +static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rusage* rusage) {
> +       const u64 us_to_ns = 1000;
> +       const u64 s_to_ns = 1000000000;
> +       update_stats(&ru_stats->ru_utime_usec_stat,
> +                    (rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
> +       update_stats(&ru_stats->ru_stime_usec_stat,
> +                    (rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
> +}
> +
>  struct evsel;
>  struct evlist;
>
> @@ -196,6 +216,7 @@ bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
>
>  extern struct runtime_stat rt_stat;
>  extern struct stats walltime_nsecs_stats;
> +extern struct rusage_stats ru_stats;
>
>  typedef void (*print_metric_t)(struct perf_stat_config *config,
>                                void *ctx, const char *color, const char *unit,
> --
> 2.36.0
>
