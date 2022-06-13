Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300CE54A19F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiFMVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbiFMVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:39:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A921BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:39:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x17so8688859wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+QjqldokXgQT8Xk7E8EKWG/SghQVrCZnNVhqvlo9TM=;
        b=b4btrcEiqIIEEbYNH4cfHh2MG0wVdlhdPNIWL4itm+3NOfF8QVY5J0SlKPHsHZOFEN
         UZ0QThdGoNP284if60xEeCjX6/PDQEcRW2s4JpB+KJkFcSzDuduKnW8LRTW/hbib9T3F
         hP4olhzcHkL8Q48267mo1+jyNTlLsX8r9wJ51mT4rM0FyE7yOVYD8vltpiNO0o2BNszZ
         xoDdHHl7x+kLpSXalqCLvY15kKbpyF5rkFTExfqQfNsfjFo9n37DMdbvaSRnAYgd4/gx
         01vg1KgCdBXUnovuQ7dhDEQKM+KABT6BbykNncE32wjkIdO0I0aEgu42IIMMIcIVItFM
         FrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+QjqldokXgQT8Xk7E8EKWG/SghQVrCZnNVhqvlo9TM=;
        b=KkXPWjjxxe6IY3d/JkOWeD7UuSPKN99CN24TZAj0cnuQ1e0lV+BNVdQpDbrT1GHKA6
         sykXoR0A3apb/OGKaq/HBt47ElmITwdqIr9mj9ou228nCk1Rtcl9GgkzQRe3ey/CvQml
         v6EsghyjOcDVHQxuh1Kggj1bhVRAPDUUHSz5/v0YRwECim7F8TxMw9WYjHc+FN191ObK
         NvE9TSSjEmp4+Rvjhmz2yHNfqTfwQG9gAOnQqJ/BcfJaWqW7ZIKCnrLXRIBr1//W6Blm
         YZ9XAAlgLxJg5x8G8Yo7/d1QaxuX2t/IzxGTlWCmGyDVTdlorxYR5EdNNOW2pAtCL3vZ
         LSVg==
X-Gm-Message-State: AJIora96twkGHdDo8kkze6SWIbabGRGN9aUuFiMCANCwQQoGSG/yEbE6
        TxCdLT+Gw31gXrE8Oms8lpP6WVFKDLqBhu6tFRR046LdxPT6rA==
X-Google-Smtp-Source: AGRyM1vkt/9Rye2WlO+X9jpXdlqp1gHkBN5ccrzAJSxnrSvTCqvlIBZ4zvahHy2ey6Mr5aGcJ0erXxqYqZHPZfeMPXQ=
X-Received: by 2002:adf:f5c4:0:b0:210:2ac2:6aa0 with SMTP id
 k4-20020adff5c4000000b002102ac26aa0mr1611265wrp.300.1655156355262; Mon, 13
 Jun 2022 14:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220526224515.4088240-1-irogers@google.com> <20220526224515.4088240-2-irogers@google.com>
In-Reply-To: <20220526224515.4088240-2-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Jun 2022 14:39:02 -0700
Message-ID: <CAP-5=fXRM3UtRYwH7-7ZqiL-LU62mxW0BzvuuLqMt1A1o18OWQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] perf stat: Add JSON output option
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>
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

On Thu, May 26, 2022 at 3:45 PM Ian Rogers <irogers@google.com> wrote:
>
> From: Claire Jensen <cjense@google.com>
>
> CSV output is tricky to format and column layout changes are susceptible
> to breaking parsers. New JSON-formatted output has variable names to
> identify fields that are consistent and informative, making
> the output parseable.
>
> CSV output example:
>
> 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> 0,,context-switches:u,1204272,100.00,0.000,/sec
> 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> 70,,page-faults:u,1204272,100.00,58.126,K/sec
>
> JSON output example:
>
> {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> {"counter-value" : "6166.000000", "unit" : "", "event" :
> "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> {"counter-value" : "466.000000", "unit" : "", "event" :
> "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> {"counter-value" : "208.000000", "unit" : "", "event" :
> "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
>
> Also added documentation for JSON option.
> There is some tidy up of CSV code including a potential memory over run
> in the os.nfields set up. To facilitate this an AGGR_MAX value is added.
>
> Signed-off-by: Claire Jensen <cjense@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  21 ++
>  tools/perf/builtin-stat.c              |   6 +
>  tools/perf/util/stat-display.c         | 384 ++++++++++++++++++-------
>  tools/perf/util/stat.c                 |   1 +
>  tools/perf/util/stat.h                 |   2 +
>  5 files changed, 308 insertions(+), 106 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 8d1cde00b8d6..f9cdfd912b05 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -570,6 +570,27 @@ Additional metrics may be printed with all earlier fields being empty.
>
>  include::intel-hybrid.txt[]
>
> +JSON FORMAT
> +-----------
> +
> +With -j, perf stat is able to print out a JSON format output
> +that can be used for parsing.
> +
> +- timestamp : optional usec time stamp in fractions of second (with -I)
> +- optional aggregate options:
> +               - core : core identifier (with --per-core)
> +               - die : die identifier (with --per-die)
> +               - socket : socket identifier (with --per-socket)
> +               - node : node identifier (with --per-node)
> +               - thread : thread identifier (with --per-thread)
> +- counter-value : counter value
> +- unit : unit of the counter value or empty
> +- event : event name
> +- variance : optional variance if multiple values are collected (with -r)
> +- runtime : run time of counter
> +- metric-value : optional metric value
> +- metric-unit : optional unit of metric
> +
>  SEE ALSO
>  --------
>  linkperf:perf-top[1], linkperf:perf-list[1]
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4ce87a8eb7d7..6c7e59440e3a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1256,6 +1256,8 @@ static struct option stat_options[] = {
>                     "Merge identical named hybrid events"),
>         OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
>                    "print counts with custom separator"),
> +       OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
> +                  "print counts in JSON format"),
>         OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
>                      "monitor event in cgroup name only", parse_stat_cgroups),
>         OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
> @@ -1442,6 +1444,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
>         case AGGR_GLOBAL:
>         case AGGR_THREAD:
>         case AGGR_UNSET:
> +       case AGGR_MAX:
>         default:
>                 return NULL;
>         }
> @@ -1466,6 +1469,7 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
>         case AGGR_GLOBAL:
>         case AGGR_THREAD:
>         case AGGR_UNSET:
> +       case AGGR_MAX:
>         default:
>                 return NULL;
>         }
> @@ -1616,6 +1620,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
>         case AGGR_GLOBAL:
>         case AGGR_THREAD:
>         case AGGR_UNSET:
> +       case AGGR_MAX:
>         default:
>                 return NULL;
>         }
> @@ -1636,6 +1641,7 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
>         case AGGR_GLOBAL:
>         case AGGR_THREAD:
>         case AGGR_UNSET:
> +       case AGGR_MAX:
>         default:
>                 return NULL;
>         }
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 606f09b09226..2bbd11446fa9 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -28,15 +28,21 @@
>  static void print_running(struct perf_stat_config *config,
>                           u64 run, u64 ena)
>  {
> -       if (config->csv_output) {
> -               fprintf(config->output, "%s%" PRIu64 "%s%.2f",
> -                                       config->csv_sep,
> -                                       run,
> -                                       config->csv_sep,
> -                                       ena ? 100.0 * run / ena : 100.0);
> -       } else if (run != ena) {
> +
> +       double enabled_percent = 100;
> +
> +       if (run != ena)
> +               enabled_percent = 100 * run / ena;
> +       if (config->json_output)
> +               fprintf(config->output,
> +                       "\"event-runtime\" : %lu, \"pcnt-running\" : %.2f, ",
> +                       run, enabled_percent);
> +       else if (config->csv_output)
> +               fprintf(config->output,
> +                       "%s%" PRIu64 "%s%.2f", config->csv_sep,
> +                       run, config->csv_sep, enabled_percent);
> +       else if (run != ena)
>                 fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
> -       }
>  }
>
>  static void print_noise_pct(struct perf_stat_config *config,
> @@ -44,7 +50,9 @@ static void print_noise_pct(struct perf_stat_config *config,
>  {
>         double pct = rel_stddev_stats(total, avg);
>
> -       if (config->csv_output)
> +       if (config->json_output)
> +               fprintf(config->output, "\"variance\" : %.2f, ", pct);
> +       else if (config->csv_output)
>                 fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
>         else if (pct)
>                 fprintf(config->output, "  ( +-%6.2f%% )", pct);
> @@ -66,7 +74,11 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
>  {
>         if (nr_cgroups) {
>                 const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
> -               fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
> +
> +               if (config->json_output)
> +                       fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
> +               else
> +                       fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
>         }
>  }
>
> @@ -74,69 +86,123 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
>  static void aggr_printout(struct perf_stat_config *config,
>                           struct evsel *evsel, struct aggr_cpu_id id, int nr)
>  {
> +
> +
> +       if (config->json_output && !config->interval)
> +               fprintf(config->output, "{");
> +
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
> -               fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
> -                       id.socket,
> -                       id.die,
> -                       config->csv_output ? 0 : -8,
> -                       id.core,
> -                       config->csv_sep,
> -                       config->csv_output ? 0 : 4,
> -                       nr,
> -                       config->csv_sep);
> +               if (config->json_output) {
> +                       fprintf(config->output,
> +                               "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
> +                               id.socket,
> +                               id.die,
> +                               id.core,
> +                               nr);
> +               } else {
> +                       fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
> +                               id.socket,
> +                               id.die,
> +                               config->csv_output ? 0 : -8,
> +                               id.core,
> +                               config->csv_sep,
> +                               config->csv_output ? 0 : 4,
> +                               nr,
> +                               config->csv_sep);
> +               }
>                 break;
>         case AGGR_DIE:
> -               fprintf(config->output, "S%d-D%*d%s%*d%s",
> -                       id.socket,
> -                       config->csv_output ? 0 : -8,
> -                       id.die,
> -                       config->csv_sep,
> -                       config->csv_output ? 0 : 4,
> -                       nr,
> -                       config->csv_sep);
> +               if (config->json_output) {
> +                       fprintf(config->output,
> +                               "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
> +                               id.socket,
> +                               id.die,
> +                               nr);
> +               } else {
> +                       fprintf(config->output, "S%d-D%*d%s%*d%s",
> +                               id.socket,
> +                               config->csv_output ? 0 : -8,
> +                               id.die,
> +                               config->csv_sep,
> +                               config->csv_output ? 0 : 4,
> +                               nr,
> +                               config->csv_sep);
> +               }
>                 break;
>         case AGGR_SOCKET:
> -               fprintf(config->output, "S%*d%s%*d%s",
> -                       config->csv_output ? 0 : -5,
> -                       id.socket,
> -                       config->csv_sep,
> -                       config->csv_output ? 0 : 4,
> -                       nr,
> -                       config->csv_sep);
> -                       break;
> +               if (config->json_output) {
> +                       fprintf(config->output,
> +                               "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
> +                               id.socket,
> +                               nr);
> +               } else {
> +                       fprintf(config->output, "S%*d%s%*d%s",
> +                               config->csv_output ? 0 : -5,
> +                               id.socket,
> +                               config->csv_sep,
> +                               config->csv_output ? 0 : 4,
> +                               nr,
> +                               config->csv_sep);
> +               }
> +               break;
>         case AGGR_NODE:
> -               fprintf(config->output, "N%*d%s%*d%s",
> -                       config->csv_output ? 0 : -5,
> -                       id.node,
> -                       config->csv_sep,
> -                       config->csv_output ? 0 : 4,
> -                       nr,
> -                       config->csv_sep);
> -                       break;
> +               if (config->json_output) {
> +                       fprintf(config->output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
> +                               id.node,
> +                               nr);
> +               } else {
> +                       fprintf(config->output, "N%*d%s%*d%s",
> +                               config->csv_output ? 0 : -5,
> +                               id.node,
> +                               config->csv_sep,
> +                               config->csv_output ? 0 : 4,
> +                               nr,
> +                               config->csv_sep);
> +               }
> +               break;
>         case AGGR_NONE:
> -               if (evsel->percore && !config->percore_show_thread) {
> -                       fprintf(config->output, "S%d-D%d-C%*d%s",
> -                               id.socket,
> -                               id.die,
> -                               config->csv_output ? 0 : -3,
> -                               id.core, config->csv_sep);
> -               } else if (id.cpu.cpu > -1) {
> -                       fprintf(config->output, "CPU%*d%s",
> -                               config->csv_output ? 0 : -7,
> -                               id.cpu.cpu, config->csv_sep);
> +               if (config->json_output) {
> +                       if (evsel->percore && !config->percore_show_thread) {
> +                               fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\"",
> +                                       id.socket,
> +                                       id.die,
> +                                       id.core);
> +                       } else if (id.core > -1) {
> +                               fprintf(config->output, "\"cpu\" : \"%d\", ",
> +                                       id.cpu.cpu);
> +                       }
> +               } else {
> +                       if (evsel->percore && !config->percore_show_thread) {
> +                               fprintf(config->output, "S%d-D%d-C%*d%s",
> +                                       id.socket,
> +                                       id.die,
> +                                       config->csv_output ? 0 : -3,
> +                                       id.core, config->csv_sep);
> +                       } else if (id.core > -1) {
> +                               fprintf(config->output, "CPU%*d%s",
> +                                       config->csv_output ? 0 : -7,
> +                                       id.cpu.cpu, config->csv_sep);
> +                       }
>                 }
>                 break;
>         case AGGR_THREAD:
> -               fprintf(config->output, "%*s-%*d%s",
> -                       config->csv_output ? 0 : 16,
> -                       perf_thread_map__comm(evsel->core.threads, id.thread),
> -                       config->csv_output ? 0 : -8,
> -                       perf_thread_map__pid(evsel->core.threads, id.thread),
> -                       config->csv_sep);
> +               if (config->json_output) {
> +                       fprintf(config->output, "\"thread\" : \"%s-%d\", ",
> +                               perf_thread_map__comm(evsel->core.threads, id.thread),
> +                               perf_thread_map__pid(evsel->core.threads, id.thread));
> +               } else {
> +                       fprintf(config->output, "%*s-%*d%s",
> +                               config->csv_output ? 0 : 16,
> +                               perf_thread_map__comm(evsel->core.threads, id.thread),
> +                               config->csv_output ? 0 : -8,
> +                               perf_thread_map__pid(evsel->core.threads, id.thread),
> +                               config->csv_sep);
> +               }
>                 break;
>         case AGGR_GLOBAL:
>         case AGGR_UNSET:
> +       case AGGR_MAX:
>         default:
>                 break;
>         }
> @@ -234,6 +300,31 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
>         fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
>  }
>
> +static void print_metric_json(struct perf_stat_config *config __maybe_unused,
> +                            void *ctx,
> +                            const char *color __maybe_unused,
> +                            const char *fmt __maybe_unused,
> +                            const char *unit, double val)
> +{
> +       struct outstate *os = ctx;
> +       FILE *out = os->fh;
> +
> +       fprintf(out, "\"metric-value\" : %f, ", val);
> +       fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> +       if (!config->metric_only)
> +               fprintf(out, "}");
> +}
> +
> +static void new_line_json(struct perf_stat_config *config, void *ctx)
> +{
> +       struct outstate *os = ctx;
> +
> +       fputc('\n', os->fh);
> +       if (os->prefix)
> +               fprintf(os->fh, "%s", os->prefix);
> +       aggr_printout(config, os->evsel, os->id, os->nr);
> +}
> +
>  /* Filter out some columns that don't work well in metrics only mode */
>
>  static bool valid_only_metric(const char *unit)
> @@ -300,6 +391,27 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
>         fprintf(out, "%s%s", vals, config->csv_sep);
>  }
>
> +static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
> +                                 void *ctx, const char *color __maybe_unused,
> +                                 const char *fmt,
> +                                 const char *unit, double val)
> +{
> +       struct outstate *os = ctx;
> +       FILE *out = os->fh;
> +       char buf[64], *vals, *ends;
> +       char tbuf[1024];
> +
> +       if (!valid_only_metric(unit))
> +               return;
> +       unit = fixunit(tbuf, os->evsel, unit);
> +       snprintf(buf, sizeof(buf), fmt, val);
> +       ends = vals = skip_spaces(buf);
> +       while (isdigit(*ends) || *ends == '.')
> +               ends++;
> +       *ends = 0;
> +       fprintf(out, "{\"metric-value\" : \"%s\"}", vals);
> +}
> +
>  static void new_line_metric(struct perf_stat_config *config __maybe_unused,
>                             void *ctx __maybe_unused)
>  {
> @@ -318,10 +430,13 @@ static void print_metric_header(struct perf_stat_config *config,
>             os->evsel->priv != os->evsel->evlist->selected->priv)
>                 return;
>
> -       if (!valid_only_metric(unit))
> +       if (!valid_only_metric(unit) && !config->json_output)
>                 return;
>         unit = fixunit(tbuf, os->evsel, unit);
> -       if (config->csv_output)
> +
> +       if (config->json_output)
> +               fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> +       else if (config->csv_output)
>                 fprintf(os->fh, "%s%s", unit, config->csv_sep);
>         else
>                 fprintf(os->fh, "%*s ", config->metric_only_len, unit);
> @@ -367,14 +482,28 @@ static void abs_printout(struct perf_stat_config *config,
>
>         aggr_printout(config, evsel, id, nr);
>
> -       fprintf(output, fmt, avg, config->csv_sep);
> +       if (config->json_output)
> +               fprintf(output, "\"counter-value\" : \"%f\", ", avg);
> +       else
> +               fprintf(output, fmt, avg, config->csv_sep);
> +
> +       if (config->json_output) {
> +               if (evsel->unit) {
> +                       fprintf(output, "\"unit\" : \"%s\", ",
> +                               evsel->unit);
> +               }
> +       } else {
> +               if (evsel->unit)
> +                       fprintf(output, "%-*s%s",
> +                               config->csv_output ? 0 : config->unit_width,
> +                               evsel->unit, config->csv_sep);
> +       }
>
> -       if (evsel->unit)
> -               fprintf(output, "%-*s%s",
> -                       config->csv_output ? 0 : config->unit_width,
> -                       evsel->unit, config->csv_sep);
>
> -       fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
> +       if (config->json_output)
> +               fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
> +       else
> +               fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
>
>         print_cgroup(config, evsel);
>  }
> @@ -416,34 +545,30 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                 .nr = nr,
>                 .evsel = counter,
>         };
> -       print_metric_t pm = print_metric_std;
> +       print_metric_t pm;
>         new_line_t nl;
>
> -       if (config->metric_only) {
> -               nl = new_line_metric;
> -               if (config->csv_output)
> -                       pm = print_metric_only_csv;
> -               else
> -                       pm = print_metric_only;
> -       } else
> -               nl = new_line_std;
> -
> -       if (config->csv_output && !config->metric_only) {
> -               static int aggr_fields[] = {
> -                       [AGGR_GLOBAL] = 0,
> -                       [AGGR_THREAD] = 1,
> +       if (config->csv_output) {
> +               static const int aggr_fields[AGGR_MAX] = {

Note, this change fixes an undefined/address sanitizer issue:
Test failed for input: util/stat-display.c:444:28: runtime error:
index 7 out of bounds for type 'int [6]'
util/stat-display.c:444:28: runtime error: load of address
0x55af9ac39c2c with insufficient space for an object of type 'int'
0x55af9ac39c2c: note: pointer points here
 00 00 06 00 27 5f 42 6f  6f 6c 27 00 ff ff 00 00  27 73 74 72 75 63
74 20  70 65 72 66 5f 65 76 6c

>                         [AGGR_NONE] = 1,
> +                       [AGGR_GLOBAL] = 0,
>                         [AGGR_SOCKET] = 2,
>                         [AGGR_DIE] = 2,
>                         [AGGR_CORE] = 2,
> +                       [AGGR_THREAD] = 1,
> +                       [AGGR_UNSET] = 0,
> +                       [AGGR_NODE] = 0,
>                 };
>
> -               pm = print_metric_csv;
> -               nl = new_line_csv;
> -               os.nfields = 3;
> -               os.nfields += aggr_fields[config->aggr_mode];
> -               if (counter->cgrp)
> -                       os.nfields++;
> +               pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
> +               nl = config->metric_only ? new_line_metric : new_line_csv;
> +               os.nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
> +       } else if (config->json_output) {
> +               pm = config->metric_only ? print_metric_only_json : print_metric_json;
> +               nl = config->metric_only ? new_line_metric : new_line_json;
> +       } else {
> +               pm = config->metric_only ? print_metric_only : print_metric_std;
> +               nl = config->metric_only ? new_line_metric : new_line_std;
>         }
>
>         if (!config->no_csv_summary && config->csv_output &&
> @@ -458,10 +583,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                 }
>                 aggr_printout(config, counter, id, nr);
>
> -               fprintf(config->output, "%*s%s",
> -                       config->csv_output ? 0 : 18,
> -                       counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
> -                       config->csv_sep);
> +               if (config->json_output) {
> +                       fprintf(config->output, "\"counter-value\" : \"%s\", ",
> +                                       counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED);
> +               } else {
> +                       fprintf(config->output, "%*s%s",
> +                               config->csv_output ? 0 : 18,
> +                               counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
> +                               config->csv_sep);
> +               }
>
>                 if (counter->supported) {
>                         if (!evlist__has_hybrid(counter->evlist)) {
> @@ -471,21 +601,32 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                         }
>                 }
>
> -               fprintf(config->output, "%-*s%s",
> -                       config->csv_output ? 0 : config->unit_width,
> -                       counter->unit, config->csv_sep);
> +               if (config->json_output) {
> +                       fprintf(config->output, "\"unit\" : \"%s\", ", counter->unit);
> +               } else {
> +                       fprintf(config->output, "%-*s%s",
> +                               config->csv_output ? 0 : config->unit_width,
> +                               counter->unit, config->csv_sep);
> +               }
>
> -               fprintf(config->output, "%*s",
> -                       config->csv_output ? 0 : -25, evsel__name(counter));
> +               if (config->json_output) {
> +                       fprintf(config->output, "\"event\" : \"%s\", ",
> +                               evsel__name(counter));
> +               } else {
> +                       fprintf(config->output, "%*s",
> +                                config->csv_output ? 0 : -25, evsel__name(counter));
> +               }
>
>                 print_cgroup(config, counter);
>
> -               if (!config->csv_output)
> +               if (!config->csv_output && !config->json_output)
>                         pm(config, &os, NULL, NULL, "", 0);
>                 print_noise(config, counter, noise);
>                 print_running(config, run, ena);
>                 if (config->csv_output)
>                         pm(config, &os, NULL, NULL, "", 0);
> +               else if (config->json_output)
> +                       pm(config, &os, NULL, NULL, "", 0);
>                 return;
>         }
>
> @@ -500,12 +641,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>         if (config->csv_output && !config->metric_only) {
>                 print_noise(config, counter, noise);
>                 print_running(config, run, ena);
> +       } else if (config->json_output && !config->metric_only) {
> +               print_noise(config, counter, noise);
> +               print_running(config, run, ena);
>         }
>
>         perf_stat__print_shadow_stats(config, counter, uval,
>                                 first_shadow_cpu_map_idx(config, counter, &id),
>                                 &out, &config->metric_events, st);
> -       if (!config->csv_output && !config->metric_only) {
> +       if (!config->csv_output && !config->metric_only && !config->json_output) {
>                 print_noise(config, counter, noise);
>                 print_running(config, run, ena);
>         }
> @@ -1004,8 +1148,12 @@ static void print_metric_headers(struct perf_stat_config *config,
>         struct outstate os = {
>                 .fh = config->output
>         };
> +       bool first = true;
> +
> +               if (config->json_output && !config->interval)
> +                       fprintf(config->output, "{");
>
> -       if (prefix)
> +       if (prefix && !config->json_output)
>                 fprintf(config->output, "%s", prefix);
>
>         if (!config->csv_output && !no_indent)
> @@ -1025,6 +1173,9 @@ static void print_metric_headers(struct perf_stat_config *config,
>                 os.evsel = counter;
>                 out.ctx = &os;
>                 out.print_metric = print_metric_header;
> +               if (!first && config->json_output)
> +                       fprintf(config->output, ", ");
> +               first = false;
>                 out.new_line = new_line_metric;
>                 out.force_header = true;
>                 perf_stat__print_shadow_stats(config, counter, 0,
> @@ -1033,6 +1184,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>                                               &config->metric_events,
>                                               &rt_stat);
>         }
> +       if (config->json_output)
> +               fprintf(config->output, "}");
>         fputc('\n', config->output);
>  }
>
> @@ -1048,10 +1201,18 @@ static void print_interval(struct perf_stat_config *config,
>         if (config->interval_clear)
>                 puts(CONSOLE_CLEAR);
>
> -       if (!config->iostat_run)
> -               sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
> -
> -       if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
> +       if (!config->iostat_run && !config->json_output)
> +               sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
> +                                ts->tv_nsec, config->csv_sep);
> +       if (!config->iostat_run && config->json_output && !config->metric_only)
> +               sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
> +                                ts->tv_sec, ts->tv_nsec);
> +       if (!config->iostat_run && config->json_output && config->metric_only)
> +               sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
> +                                ts->tv_sec, ts->tv_nsec);
> +
> +       if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
> +                        || config->interval_clear) {
>                 switch (config->aggr_mode) {
>                 case AGGR_NODE:
>                         fprintf(output, "#           time node   cpus");
> @@ -1091,12 +1252,19 @@ static void print_interval(struct perf_stat_config *config,
>                                         fprintf(output, "             counts %*s events\n", unit_width, "unit");
>                         }
>                 case AGGR_UNSET:
> +               case AGGR_MAX:
>                         break;
>                 }
>         }
>
> -       if ((num_print_interval == 0 || config->interval_clear) && metric_only)
> +       if ((num_print_interval == 0 || config->interval_clear)
> +                        && metric_only && !config->json_output)
>                 print_metric_headers(config, evlist, " ", true);
> +       if ((num_print_interval == 0 || config->interval_clear)
> +                        && metric_only && config->json_output) {
> +               fprintf(output, "{");
> +               print_metric_headers(config, evlist, " ", true);
> +       }
>         if (++num_print_interval == 25)
>                 num_print_interval = 0;
>  }
> @@ -1110,7 +1278,7 @@ static void print_header(struct perf_stat_config *config,
>
>         fflush(stdout);
>
> -       if (!config->csv_output) {
> +       if (!config->csv_output && !config->json_output) {
>                 fprintf(output, "\n");
>                 fprintf(output, " Performance counter stats for ");
>                 if (_target->bpf_str)
> @@ -1303,6 +1471,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                         num_print_iv = 0;
>                 if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
>                         fprintf(config->output, "%s", prefix);
> +
> +               if (config->json_output && !config->metric_only)
> +                       fprintf(config->output, "}");
>         }
>
>         switch (config->aggr_mode) {
> @@ -1341,12 +1512,13 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                         }
>                 }
>                 break;
> +       case AGGR_MAX:
>         case AGGR_UNSET:
>         default:
>                 break;
>         }
>
> -       if (!interval && !config->csv_output)
> +       if (!interval && !config->csv_output && !config->json_output)
>                 print_footer(config);
>
>         fflush(config->output);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 37ea2d044708..0882b4754fcf 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -401,6 +401,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 aggr->ena += count->ena;
>                 aggr->run += count->run;
>         case AGGR_UNSET:
> +       case AGGR_MAX:
>         default:
>                 break;
>         }
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b5aeb8e6d34b..668250022f8c 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -57,6 +57,7 @@ enum aggr_mode {
>         AGGR_THREAD,
>         AGGR_UNSET,
>         AGGR_NODE,
> +       AGGR_MAX
>  };
>
>  enum {
> @@ -121,6 +122,7 @@ struct perf_stat_config {
>         bool                     no_inherit;
>         bool                     identifier;
>         bool                     csv_output;
> +       bool                     json_output;
>         bool                     interval_clear;
>         bool                     metric_only;
>         bool                     null_run;
> --
> 2.36.1.124.g0e6072fb45-goog
>
