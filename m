Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED74F9A00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiDHQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiDHQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:00:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFE48BE31
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:58:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so13530513wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23SmiqJC1qQUM9Lp1LHRDkIYhqlVVxP27oOWxzxomHI=;
        b=Qr/N2cp+sUPSBIozQ1JBiVKHQwmUVsOWoEz2lSpzNzF/qlSdhM4AYTCxgZaxPUc7Me
         NUDLh0mbNn8LlsaBBfFe7aoVgnZgKQBKchJa3/G3gKTyH8IzVx2Nyg9u/VwxbXQISPv2
         esAY0v6FqDpts9BA+is6KmKHsWPRYwI9b0YPlr/UvWz/BYVBkYe7FHeO1ypuyo0tQcQ4
         tJRIiJB9fPL51oKU4iQYx/sVke/EXaJO9T62PiBfnBO7aTjQ6pd/X1bSnvFiUlqlG++3
         Li3MuosCW2IRbiVmoVAeXooSSwp4maqBXijc16SkUcmDFVLR6HwzmXtpRYzjOm/Rgx5y
         Gsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23SmiqJC1qQUM9Lp1LHRDkIYhqlVVxP27oOWxzxomHI=;
        b=0tgJUV7k5VEguhZ61sxTB5ic5JAsqXYCUzN2Ncn7UyGgU7TTe+lao52cGvKd3GrIAo
         zQztUvJqukfRaHxrftKs/ZUwe3oqP7ZvwrOV+/aag0nDk0YlCQj5u1Ak+32mavWm5H1z
         E7sYsh9JlwRQ47o8WsVe6rqqLRvkA585sIVsGo32j2to4ZewaylTxqJ8sz9Ss4fNcMRm
         U80/wE9TsdISNr8OTkFBIJX+zmruk10BE7CVOCPG6jegS1qrSKIfMxgFZaXOQiB4iNqw
         FZL0AXd04zDarmtqM6+wO/AtIZ6jhFBkxX6TF+Pa1hFMgkLa75EGfd/AjdNzaO41c07E
         Ly3g==
X-Gm-Message-State: AOAM532chB761K1BOWqvi7R0RPNRYpfua3mKFD3cBllO7wBOjCdGxP2S
        Bq1bcM6P+IhSk7KeRvEvOPXXXn18rNUejepnHRsH6g==
X-Google-Smtp-Source: ABdhPJxmmG0rUv/Cih/0Lo4yqaBHtCcwUgzXD4TDTpmuB+Y32/sBe14juqoAuiAfQ706adSRUV5xKGUXM2iYRK2L7V8=
X-Received: by 2002:adf:8123:0:b0:206:1759:f164 with SMTP id
 32-20020adf8123000000b002061759f164mr15790557wrm.654.1649433523145; Fri, 08
 Apr 2022 08:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
 <20220407085721.3289414-1-florian.fischer@muhq.space> <20220407085721.3289414-3-florian.fischer@muhq.space>
In-Reply-To: <20220407085721.3289414-3-florian.fischer@muhq.space>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Apr 2022 08:58:30 -0700
Message-ID: <CAP-5=fWC5e9PTs9PVttVDdNbCzYQVeqyuf95q181Vkg4NqJxqg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf stat: add rusage utime and stime events
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>
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

On Thu, Apr 7, 2022 at 1:58 AM Florian Fischer
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
> This patch adds two new tool internal events 'rusage_user_time'
> and 'rusage_system_time' as well as their aliases 'ru_utime' and
> 'ru_stime', similarly to the already present 'duration_time' event.
>
> Both events use the already collected rusage information obtained by wait4
> and tracked in the global ru_stats.
>
> Examples presenting cache-misses and rusage information in both human and
> machine-readable form:
>
> $ ./perf stat -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
>
>  Performance counter stats for 'grep -q -r duration_time .':
>
>         67,422,542 ns   duration_time:u
>         50,517,000 ns   ru_utime:u
>         16,839,000 ns   ru_stime:u
>             30,937      cache-misses:u
>
>        0.067422542 seconds time elapsed
>
>        0.050517000 seconds user
>        0.016839000 seconds sys
>
> $ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> 72134524,ns,duration_time:u,72134524,100.00,,
> 65225000,ns,ru_utime:u,65225000,100.00,,
> 6865000,ns,ru_stime:u,6865000,100.00,,
> 38705,,cache-misses:u,71189328,100.00,,

This is really nice. For metric code we currently handle duration_time
in a special way, for example:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n745
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n1131
We will need to do something similar with these tool events, but I'm
happy that it can be follow-up work.

I'm not a huge fan of the names ru_utime and ru_stime, two thoughts
here we could do duration_time:u and duration_time:k but I don't think
that really makes sense. My preference would be to just call ru_utime
user_time and ru_stime system_time.

Something beyond these changes is that we have a notion of literals in metrics:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/expr.c?h=perf/core#n410
I think it would be more consistent if these were tool events, even
though they only ever return a constant value.

Thanks,
Ian

> Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
> ---
>  tools/perf/builtin-stat.c      | 36 ++++++++++++++++++++++++++--------
>  tools/perf/util/evsel.h        |  3 +++
>  tools/perf/util/parse-events.c |  4 +++-
>  tools/perf/util/parse-events.l |  2 ++
>  4 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 61faffb535f5..c73afc8f6da5 100644
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
> +       switch(counter->tool_event) {
> +               case PERF_TOOL_DURATION_TIME: {
> +                       u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> +                       struct perf_counts_values *count =
> +                               perf_counts(counter->counts, cpu_map_idx, thread);
> +                       count->ena = count->run = val;
> +                       count->val = val;
> +                       return 0;
> +               }
> +               case PERF_TOOL_RU_UTIME:
> +               case PERF_TOOL_RU_STIME: {
> +                       u64 val;
> +                       struct perf_counts_values *count =
> +                               perf_counts(counter->counts, cpu_map_idx, thread);
> +                       if (counter->tool_event == PERF_TOOL_RU_UTIME)
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
> +               case PERF_TOOL_LAST:
> +                       /* this case should never be reached */
> +                       return 0;
>         }
> -       return evsel__read_counter(counter, cpu_map_idx, thread);
>  }
>
>  /*
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 041b42d33bf5..e89b1224ae61 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -30,6 +30,9 @@ typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  enum perf_tool_event {
>         PERF_TOOL_NONE          = 0,
>         PERF_TOOL_DURATION_TIME = 1,
> +       PERF_TOOL_RU_UTIME = 2,
> +       PERF_TOOL_RU_STIME = 3,
> +       PERF_TOOL_LAST
>  };
>
>  /** struct evsel - event selector
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 24997925ae00..e9d3d4404ea6 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -402,7 +402,9 @@ static int add_event_tool(struct list_head *list, int *idx,
>         if (!evsel)
>                 return -ENOMEM;
>         evsel->tool_event = tool_event;
> -       if (tool_event == PERF_TOOL_DURATION_TIME) {
> +       if (tool_event == PERF_TOOL_DURATION_TIME
> +           || tool_event == PERF_TOOL_RU_UTIME
> +           || tool_event == PERF_TOOL_RU_STIME) {
>                 free((char *)evsel->unit);
>                 evsel->unit = strdup("ns");
>         }
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 5b6e4b5249cf..3c7227b8035c 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -353,6 +353,8 @@ alignment-faults                            { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_AL
>  emulation-faults                               { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
>  dummy                                          { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
>  duration_time                                  { return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
> +rusage_user_time|ru_utime      { return tool(yyscanner, PERF_TOOL_RU_UTIME); }
> +rusage_system_time|ru_stime    { return tool(yyscanner, PERF_TOOL_RU_STIME); }
>  bpf-output                                     { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
>  cgroup-switches                                        { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
>
> --
> 2.35.1
>
