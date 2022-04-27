Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B816510E26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356788AbiD0Bkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356786AbiD0Bkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:40:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76457FE5E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:37:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e24so433081wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBqGFBHoy10oUf22H25XbDmYIQfWBC7JjrTiQSpnkyM=;
        b=OHnqdSO/I2st11mrhmpALHq+VskSXZFFNUEYQ/YTb2kNhSwQzIUH7ic1xkUYGLZ9jx
         zpvf9dD6N6xdCsUH1vaMp6pppptG4jLqZNVkKBN+4TA66jCoBGPYeE2Hu+iAFpJBbajY
         8R7CtiYNQHmmw/xAxYwmlABsfvTmpRjCx0HD4gGUHeLTGNZmMQqLm82RZk+8k6AHp6pp
         bLZWkl94DYJE7m3idlxXb4179EpvPjrX5593gP+FJXqNlVjPvaxIj3unr1s24dXi9RZZ
         ZurSmtpWY12x0TUQ4A6znJxef7UIL+1CGiURJEniQ17caoJQbWWCWwq+PmYLn9t0q7Xd
         4EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBqGFBHoy10oUf22H25XbDmYIQfWBC7JjrTiQSpnkyM=;
        b=U4+V7dCnimcFZ4U9LhGDmLCAeO+OX2dt8ICwxb90W++uSlOHKGAccEPflwgHtURnl5
         MSmH/hwr8D4jfUWcA4FJymLs/Cwz1Ra4Jxs4vsv4YjckqoH6JDKYYMhMAYw7NB0jIbU1
         tz99HQcc2iK+Ekq0glzDr5+W5tA3i65HBmd1jU5BMlTJsBzu8VgCuVZxK9KSGOaMpKeX
         yaS5w2T19V0Msps9+dJhlQ0r9NcVsHyCRqU7/qaB/m6E3c7Uv39JIK0rOyTDPFAygAEy
         DaUISDQ4kWRD/gh9WgKiVM/bojecGexJwLUYyBpmCBtnKMTe4E7yQQyjMm/uFAcVM69C
         zQ9Q==
X-Gm-Message-State: AOAM532ZXjI4vUS/9DmwdVvEvHuNtZCaUH0CbiuX/vx30y+9jWZBt2Bm
        v7WF8T5B5RnsMpgBN/OD01EOVa+R6sq0DzD1ck/BtA==
X-Google-Smtp-Source: ABdhPJxltppQLACvAbvHonj7wphrSyRlSnYaiiNjX126eAJeoANW1qNBSatQlUZDWJqsIRK+dKq4aE8RFv9AclYTwvg=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr6528705wro.654.1651023457604; Tue, 26
 Apr 2022 18:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102354.468173-1-florian.fischer@muhq.space> <20220420102354.468173-3-florian.fischer@muhq.space>
In-Reply-To: <20220420102354.468173-3-florian.fischer@muhq.space>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Apr 2022 18:37:24 -0700
Message-ID: <CAP-5=fX8ubOJJ7cauDAL8giVGz2uhr0GqOZUpQEOHTkYndvngA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf stat: add user_time and system_time events
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 3:24 AM Florian Fischer
<florian.fischer@muhq.space> wrote:
>
> It bothered me that during benchmarking using perf stat (to collect
> for example CPU cache events) I could not simultaneously retrieve the
> times spend in user or kernel mode in a machine readable format.
>
> When running perf stat the output for humans contains the times
> reported by rusage and wait4.
>
> $ perf stat -e cache-misses:u -- true
>
>  Performance counter stats for 'true':
>
>              4,206      cache-misses:u
>
>        0.001113619 seconds time elapsed
>
>        0.001175000 seconds user
>        0.000000000 seconds sys
>
> But perf stat's machine-readable format does not provide this information.
>
> $ perf stat -x, -e cache-misses:u -- true
> 4282,,cache-misses:u,492859,100.00,,
>
> I found no way to retrieve this information using the available events
> while using machine-readable output.
>
> This patch adds two new tool internal events 'user_time'
> and 'system_time', similarly to the already present 'duration_time' event.
>
> Both events use the already collected rusage information obtained by wait4
> and tracked in the global ru_stats.
>
> Examples presenting cache-misses and rusage information in both human and
> machine-readable form:
>
> $ ./perf stat -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time .
>
>  Performance counter stats for 'grep -q -r duration_time .':
>
>         67,422,542 ns   duration_time:u
>         50,517,000 ns   user_time:u
>         16,839,000 ns   system_time:u
>             30,937      cache-misses:u

nit: Are the :u on the *_time accurate here?

>        0.067422542 seconds time elapsed
>
>        0.050517000 seconds user
>        0.016839000 seconds sys
>
> $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time .
> 72134524,ns,duration_time:u,72134524,100.00,,
> 65225000,ns,user_time:u,65225000,100.00,,
> 6865000,ns,system_time:u,6865000,100.00,,
> 38705,,cache-misses:u,71189328,100.00,,

nit: Similarly.

> Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
> ---
>  tools/perf/builtin-stat.c      | 36 ++++++++++++++++++++++++++--------
>  tools/perf/util/evsel.h        |  4 ++++
>  tools/perf/util/parse-events.c |  4 +++-
>  tools/perf/util/parse-events.l |  2 ++
>  4 files changed, 37 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 61faffb535f5..dea34c8990ae 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -342,15 +342,35 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
>  static int read_single_counter(struct evsel *counter, int cpu_map_idx,
>                                int thread, struct timespec *rs)
>  {
> -       if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
> -               u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> -               struct perf_counts_values *count =
> -                       perf_counts(counter->counts, cpu_map_idx, thread);
> -               count->ena = count->run = val;
> -               count->val = val;
> -               return 0;

When this was 1 tool event I think the if was okay, I think now we
should move the reading of the tool events to their own helper like
evsel__read_counter. Perhaps evsel__read_tool.

Thanks,
Ian

> +       switch(counter->tool_event) {
> +               case PERF_TOOL_DURATION_TIME: {
> +                       u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> +                       struct perf_counts_values *count =
> +                               perf_counts(counter->counts, cpu_map_idx, thread);
> +                       count->ena = count->run = val;
> +                       count->val = val;
> +                       return 0;
> +               }
> +               case PERF_TOOL_USER_TIME:
> +               case PERF_TOOL_SYSTEM_TIME: {
> +                       u64 val;
> +                       struct perf_counts_values *count =
> +                               perf_counts(counter->counts, cpu_map_idx, thread);
> +                       if (counter->tool_event == PERF_TOOL_USER_TIME)
> +                               val = ru_stats.ru_utime_usec_stat.mean;
> +                       else
> +                               val = ru_stats.ru_stime_usec_stat.mean;
> +                       count->ena = count->run = val;
> +                       count->val = val;
> +                       return 0;
> +               }
> +               default:
> +               case PERF_TOOL_NONE:
> +                       return evsel__read_counter(counter, cpu_map_idx, thread);
> +               case PERF_TOOL_MAX:
> +                       /* This should never be reached */
> +                       return 0;
>         }
> -       return evsel__read_counter(counter, cpu_map_idx, thread);
>  }
>
>  /*
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 041b42d33bf5..7e2209b47b39 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -30,6 +30,10 @@ typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  enum perf_tool_event {
>         PERF_TOOL_NONE          = 0,
>         PERF_TOOL_DURATION_TIME = 1,
> +       PERF_TOOL_USER_TIME = 2,
> +       PERF_TOOL_SYSTEM_TIME = 3,
> +
> +       PERF_TOOL_MAX,
>  };
>
>  /** struct evsel - event selector
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index dd84fed698a3..064ec368a90b 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -402,7 +402,9 @@ static int add_event_tool(struct list_head *list, int *idx,
>         if (!evsel)
>                 return -ENOMEM;
>         evsel->tool_event = tool_event;
> -       if (tool_event == PERF_TOOL_DURATION_TIME) {
> +       if (tool_event == PERF_TOOL_DURATION_TIME
> +           || tool_event == PERF_TOOL_USER_TIME
> +           || tool_event == PERF_TOOL_SYSTEM_TIME) {
>                 free((char *)evsel->unit);
>                 evsel->unit = strdup("ns");
>         }
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 5b6e4b5249cf..3a9ce96c8bce 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -353,6 +353,8 @@ alignment-faults                            { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_AL
>  emulation-faults                               { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
>  dummy                                          { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
>  duration_time                                  { return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
> +user_time                                              { return tool(yyscanner, PERF_TOOL_USER_TIME); }
> +system_time                                            { return tool(yyscanner, PERF_TOOL_SYSTEM_TIME); }
>  bpf-output                                     { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
>  cgroup-switches                                        { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
>
> --
> 2.36.0
>
