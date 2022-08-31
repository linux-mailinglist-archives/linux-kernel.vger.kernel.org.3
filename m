Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21445A835C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiHaQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiHaQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:39:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90262D7CE5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:39:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so16287873wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dsSxLYfuxcr5lWI6o/jGPTBNE9ClNQ9J9YKLKEkUn5M=;
        b=sGTJWvkD3Tsp/+NVAej1syY6a2BhfZNRJn+XetGEL/EWEaXSOHddlsRkHk9zYAt160
         q3rAnwcsZqaCBwVcNdmueSJAD2kIBnnk4WlL5sebIxmTrSRbPOU96ggd/Q25+yrlLxhs
         DtIan9vG1MG19dE5LBgPdM9Js9lCHwU8dCEFE4s+rLvCRDRyC6oIYOwdZ/+K2FrAvMPx
         6gT8hAIImtk2QEW3IxdvGvGjI6KgSASmHKv0QeqRf2pxxCylnPu0kiNICv//1d0khbOn
         uCbT6ykUhEMckOuH9zz6KvZJy5TpDJsDMf65LtN4JzgIs3KX2+ZTUk4Fj7bKFhiDfoDq
         WakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dsSxLYfuxcr5lWI6o/jGPTBNE9ClNQ9J9YKLKEkUn5M=;
        b=02ABYLhcQ3n8apnyoM1FHC9x6AZZTYne2ma0FErJZQB2EG+WxDRbXzwnrF8HAf/1hz
         86jhmt1bxKl9+YlAULbrWbNJ2K5kuxqIFcC6nDctFc0Ijm7HKx2R9Mj/1AZIdIxRK06S
         Xw4TjSPnRY7YhwBTsYr0bAuI3cS+IT5zkV5cXQ8Tqgwqsuy8gfrfdxP9q+yd9fyr/jAj
         hfi8hhfvZJ33BiYRzQA27IeNtdFkS0s404HI+s2+O6I9etUSN/kGp6WjTcNOsxEQPGzk
         DMi7tqd2dh1BMpzTQDYWrRXKq5k4eGTKFwL6iUcQuHylxw3vUzU+OWanG/JZbappB3j3
         Usug==
X-Gm-Message-State: ACgBeo0RPQIQC7sWFoGGlD2ZwrRNU1cH/4h3tolAoHbE5LXK7HdI0U97
        v/aIYCSRy7q53Fi0LC8GSW2YBEw/sTNxXpqF6yKSrA==
X-Google-Smtp-Source: AA6agR55kFd+NTZoHrePAUJ2Lax2W95+y8VWcYOV44aedSzBhW3iFz2Nbmtqzk4hk6YsfITaR9OdUoI0jroxXFMB8nw=
X-Received: by 2002:adf:ce01:0:b0:226:e131:5d8f with SMTP id
 p1-20020adfce01000000b00226e1315d8fmr5679645wrn.375.1661963945758; Wed, 31
 Aug 2022 09:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com> <20220830164846.401143-8-irogers@google.com>
 <Yw9zu55ldneyTXuo@kernel.org>
In-Reply-To: <Yw9zu55ldneyTXuo@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 Aug 2022 09:38:53 -0700
Message-ID: <CAP-5=fUXA62MsTCKuutOdU+uUeWANN=U9S2AG-WBgsgux4rwwQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] perf metrics: Wire up core_wide
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
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

On Wed, Aug 31, 2022 at 7:44 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 30, 2022 at 09:48:45AM -0700, Ian Rogers escreveu:
> > Pass state necessary for core_wide into the expression parser. Add
> > system_wide and user_requested_cpu_list to perf_stat_config to make it
> > available at display time. evlist isn't used as the
> > evlist__create_maps, that computes user_requested_cpus, needs the list
> > of events which is generated by the metric.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c     |  9 ++++
> >  tools/perf/util/expr.c        | 10 ++++-
> >  tools/perf/util/expr.h        |  4 +-
> >  tools/perf/util/expr.l        |  6 +--
> >  tools/perf/util/metricgroup.c | 82 +++++++++++++++++++++++++++--------
> >  tools/perf/util/metricgroup.h |  2 +
> >  tools/perf/util/stat-shadow.c | 11 +++--
> >  tools/perf/util/stat.h        |  2 +
> >  8 files changed, 101 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index c813b1aa7d7c..0554ba6547a5 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1802,6 +1802,8 @@ static int add_default_attributes(void)
> >                       return metricgroup__parse_groups(evsel_list, "transaction",
> >                                                        stat_config.metric_no_group,
> >                                                        stat_config.metric_no_merge,
> > +                                                      stat_config.user_requested_cpu_list,
> > +                                                      stat_config.system_wide,
> >                                                        &stat_config.metric_events);
> >               }
> >
> > @@ -2435,6 +2437,10 @@ int cmd_stat(int argc, const char **argv)
> >       if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
> >               target.per_thread = true;
> >
> > +     stat_config.system_wide = target.system_wide;
> > +     if (target.cpu_list)
> > +             stat_config.user_requested_cpu_list = strdup(target.cpu_list);
>
> Check strdup() result?

Added to v2.

> > +
> >       /*
> >        * Metric parsing needs to be delayed as metrics may optimize events
> >        * knowing the target is system-wide.
> > @@ -2443,6 +2449,8 @@ int cmd_stat(int argc, const char **argv)
> >               metricgroup__parse_groups(evsel_list, metrics,
> >                                       stat_config.metric_no_group,
> >                                       stat_config.metric_no_merge,
> > +                                     stat_config.user_requested_cpu_list,
> > +                                     stat_config.system_wide,
> >                                       &stat_config.metric_events);
> >               zfree(&metrics);
> >       }
> > @@ -2633,6 +2641,7 @@ int cmd_stat(int argc, const char **argv)
> >               iostat_release(evsel_list);
> >
> >       zfree(&stat_config.walltime_run);
> > +     zfree(&stat_config.user_requested_cpu_list);
> >
> >       if (smi_cost && smi_reset)
> >               sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 8aa7dafa18b3..ce186bf663c4 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -310,7 +310,9 @@ struct expr_parse_ctx *expr__ctx_new(void)
> >               free(ctx);
> >               return NULL;
> >       }
> > +     ctx->sctx.user_requested_cpu_list = NULL;
> >       ctx->sctx.runtime = 0;
> > +     ctx->sctx.system_wide = false;
> >
> >       return ctx;
> >  }
> > @@ -332,6 +334,7 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
> >       struct hashmap_entry *cur;
> >       size_t bkt;
> >
> > +     free(ctx->sctx.user_requested_cpu_list);
>
> Isn't better to use zfree(&) here?

ctx is freed just below.

> >       hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >               free((char *)cur->key);
> >               free(cur->value);
> > @@ -407,7 +410,7 @@ double arch_get_tsc_freq(void)
> >  }
> >  #endif
> >
> > -double expr__get_literal(const char *literal)
> > +double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
> >  {
> >       static struct cpu_topology *topology;
> >       double result = NAN;
> > @@ -439,6 +442,11 @@ double expr__get_literal(const char *literal)
> >               result = smt_on(topology) ? 1.0 : 0.0;
> >               goto out;
> >       }
> > +     if (!strcmp("#core_wide", literal)) {
> > +             result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list, topology)
> > +                     ? 1.0 : 0.0;
> > +             goto out;
> > +     }
> >       if (!strcmp("#num_packages", literal)) {
> >               result = topology->package_cpus_lists;
> >               goto out;
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index de9b886ec49a..32740e4c81ef 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -14,7 +14,9 @@
> >  struct metric_ref;
> >
> >  struct expr_scanner_ctx {
> > +     char *user_requested_cpu_list;
> >       int runtime;
> > +     bool system_wide;
> >  };
> >
> >  struct expr_parse_ctx {
> > @@ -58,6 +60,6 @@ int expr__find_ids(const char *expr, const char *one,
> >
> >  double expr_id_data__value(const struct expr_id_data *data);
> >  double expr_id_data__source_count(const struct expr_id_data *data);
> > -double expr__get_literal(const char *literal);
> > +double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx);
> >
> >  #endif
> > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > index 4dc8edbfd9ce..0168a9637330 100644
> > --- a/tools/perf/util/expr.l
> > +++ b/tools/perf/util/expr.l
> > @@ -79,11 +79,11 @@ static int str(yyscan_t scanner, int token, int runtime)
> >       return token;
> >  }
> >
> > -static int literal(yyscan_t scanner)
> > +static int literal(yyscan_t scanner, const struct expr_scanner_ctx *sctx)
> >  {
> >       YYSTYPE *yylval = expr_get_lval(scanner);
> >
> > -     yylval->num = expr__get_literal(expr_get_text(scanner));
> > +     yylval->num = expr__get_literal(expr_get_text(scanner), sctx);
> >       if (isnan(yylval->num))
> >               return EXPR_ERROR;
> >
> > @@ -108,7 +108,7 @@ min               { return MIN; }
> >  if           { return IF; }
> >  else         { return ELSE; }
> >  source_count { return SOURCE_COUNT; }
> > -{literal}    { return literal(yyscanner); }
> > +{literal}    { return literal(yyscanner, sctx); }
> >  {number}     { return value(yyscanner); }
> >  {symbol}     { return str(yyscanner, ID, sctx->runtime); }
> >  "|"          { return '|'; }
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 9151346a16ab..f7d93dc02326 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/list_sort.h>
> >  #include <linux/string.h>
> >  #include <linux/zalloc.h>
> > +#include <perf/cpumap.h>
> >  #include <subcmd/parse-options.h>
> >  #include <api/fs/fs.h>
> >  #include "util.h"
> > @@ -192,7 +193,9 @@ static bool metricgroup__has_constraint(const struct pmu_event *pe)
> >  static struct metric *metric__new(const struct pmu_event *pe,
> >                                 const char *modifier,
> >                                 bool metric_no_group,
> > -                               int runtime)
> > +                               int runtime,
> > +                               const char *user_requested_cpu_list,
> > +                               bool system_wide)
> >  {
> >       struct metric *m;
> >
> > @@ -215,7 +218,11 @@ static struct metric *metric__new(const struct pmu_event *pe,
> >       }
> >       m->metric_expr = pe->metric_expr;
> >       m->metric_unit = pe->unit;
> > +     m->pctx->sctx.user_requested_cpu_list = NULL;
> > +     if (user_requested_cpu_list)
> > +             m->pctx->sctx.user_requested_cpu_list = strdup(user_requested_cpu_list);
>
> Check?

Added to v2.

Thanks,
Ian

> >       m->pctx->sctx.runtime = runtime;
> > +     m->pctx->sctx.system_wide = system_wide;
> >       m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
> >       m->metric_refs = NULL;
> >       m->evlist = NULL;
> > @@ -874,6 +881,8 @@ struct metricgroup_add_iter_data {
> >       int *ret;
> >       bool *has_match;
> >       bool metric_no_group;
> > +     const char *user_requested_cpu_list;
> > +     bool system_wide;
> >       struct metric *root_metric;
> >       const struct visited_metric *visited;
> >       const struct pmu_events_table *table;
> > @@ -887,6 +896,8 @@ static int add_metric(struct list_head *metric_list,
> >                     const struct pmu_event *pe,
> >                     const char *modifier,
> >                     bool metric_no_group,
> > +                   const char *user_requested_cpu_list,
> > +                   bool system_wide,
> >                     struct metric *root_metric,
> >                     const struct visited_metric *visited,
> >                     const struct pmu_events_table *table);
> > @@ -899,6 +910,8 @@ static int add_metric(struct list_head *metric_list,
> >   * @metric_no_group: Should events written to events be grouped "{}" or
> >   *                   global. Grouping is the default but due to multiplexing the
> >   *                   user may override.
> > + * @user_requested_cpu_list: Command line specified CPUs to record on.
> > + * @system_wide: Are events for all processes recorded.
> >   * @root_metric: Metrics may reference other metrics to form a tree. In this
> >   *               case the root_metric holds all the IDs and a list of referenced
> >   *               metrics. When adding a root this argument is NULL.
> > @@ -910,6 +923,8 @@ static int add_metric(struct list_head *metric_list,
> >  static int resolve_metric(struct list_head *metric_list,
> >                         const char *modifier,
> >                         bool metric_no_group,
> > +                       const char *user_requested_cpu_list,
> > +                       bool system_wide,
> >                         struct metric *root_metric,
> >                         const struct visited_metric *visited,
> >                         const struct pmu_events_table *table)
> > @@ -956,7 +971,8 @@ static int resolve_metric(struct list_head *metric_list,
> >        */
> >       for (i = 0; i < pending_cnt; i++) {
> >               ret = add_metric(metric_list, &pending[i].pe, modifier, metric_no_group,
> > -                             root_metric, visited, table);
> > +                              user_requested_cpu_list, system_wide, root_metric, visited,
> > +                              table);
> >               if (ret)
> >                       break;
> >       }
> > @@ -974,6 +990,8 @@ static int resolve_metric(struct list_head *metric_list,
> >   *                   global. Grouping is the default but due to multiplexing the
> >   *                   user may override.
> >   * @runtime: A special argument for the parser only known at runtime.
> > + * @user_requested_cpu_list: Command line specified CPUs to record on.
> > + * @system_wide: Are events for all processes recorded.
> >   * @root_metric: Metrics may reference other metrics to form a tree. In this
> >   *               case the root_metric holds all the IDs and a list of referenced
> >   *               metrics. When adding a root this argument is NULL.
> > @@ -987,6 +1005,8 @@ static int __add_metric(struct list_head *metric_list,
> >                       const char *modifier,
> >                       bool metric_no_group,
> >                       int runtime,
> > +                     const char *user_requested_cpu_list,
> > +                     bool system_wide,
> >                       struct metric *root_metric,
> >                       const struct visited_metric *visited,
> >                       const struct pmu_events_table *table)
> > @@ -1011,7 +1031,8 @@ static int __add_metric(struct list_head *metric_list,
> >                * This metric is the root of a tree and may reference other
> >                * metrics that are added recursively.
> >                */
> > -             root_metric = metric__new(pe, modifier, metric_no_group, runtime);
> > +             root_metric = metric__new(pe, modifier, metric_no_group, runtime,
> > +                                       user_requested_cpu_list, system_wide);
> >               if (!root_metric)
> >                       return -ENOMEM;
> >
> > @@ -1060,8 +1081,9 @@ static int __add_metric(struct list_head *metric_list,
> >               ret = -EINVAL;
> >       } else {
> >               /* Resolve referenced metrics. */
> > -             ret = resolve_metric(metric_list, modifier, metric_no_group, root_metric,
> > -                                  &visited_node, table);
> > +             ret = resolve_metric(metric_list, modifier, metric_no_group,
> > +                                  user_requested_cpu_list, system_wide,
> > +                                  root_metric, &visited_node, table);
> >       }
> >
> >       if (ret) {
> > @@ -1109,6 +1131,8 @@ static int add_metric(struct list_head *metric_list,
> >                     const struct pmu_event *pe,
> >                     const char *modifier,
> >                     bool metric_no_group,
> > +                   const char *user_requested_cpu_list,
> > +                   bool system_wide,
> >                     struct metric *root_metric,
> >                     const struct visited_metric *visited,
> >                     const struct pmu_events_table *table)
> > @@ -1119,7 +1143,8 @@ static int add_metric(struct list_head *metric_list,
> >
> >       if (!strstr(pe->metric_expr, "?")) {
> >               ret = __add_metric(metric_list, pe, modifier, metric_no_group, 0,
> > -                                root_metric, visited, table);
> > +                                user_requested_cpu_list, system_wide, root_metric,
> > +                                visited, table);
> >       } else {
> >               int j, count;
> >
> > @@ -1132,7 +1157,8 @@ static int add_metric(struct list_head *metric_list,
> >
> >               for (j = 0; j < count && !ret; j++)
> >                       ret = __add_metric(metric_list, pe, modifier, metric_no_group, j,
> > -                                     root_metric, visited, table);
> > +                                        user_requested_cpu_list, system_wide,
> > +                                        root_metric, visited, table);
> >       }
> >
> >       return ret;
> > @@ -1149,6 +1175,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
> >               return 0;
> >
> >       ret = add_metric(d->metric_list, pe, d->modifier, d->metric_no_group,
> > +                      d->user_requested_cpu_list, d->system_wide,
> >                        d->root_metric, d->visited, d->table);
> >       if (ret)
> >               goto out;
> > @@ -1191,7 +1218,9 @@ struct metricgroup__add_metric_data {
> >       struct list_head *list;
> >       const char *metric_name;
> >       const char *modifier;
> > +     const char *user_requested_cpu_list;
> >       bool metric_no_group;
> > +     bool system_wide;
> >       bool has_match;
> >  };
> >
> > @@ -1208,8 +1237,8 @@ static int metricgroup__add_metric_callback(const struct pmu_event *pe,
> >
> >               data->has_match = true;
> >               ret = add_metric(data->list, pe, data->modifier, data->metric_no_group,
> > -                              /*root_metric=*/NULL,
> > -                              /*visited_metrics=*/NULL, table);
> > +                              data->user_requested_cpu_list, data->system_wide,
> > +                              /*root_metric=*/NULL, /*visited_metrics=*/NULL, table);
> >       }
> >       return ret;
> >  }
> > @@ -1223,12 +1252,16 @@ static int metricgroup__add_metric_callback(const struct pmu_event *pe,
> >   * @metric_no_group: Should events written to events be grouped "{}" or
> >   *                   global. Grouping is the default but due to multiplexing the
> >   *                   user may override.
> > + * @user_requested_cpu_list: Command line specified CPUs to record on.
> > + * @system_wide: Are events for all processes recorded.
> >   * @metric_list: The list that the metric or metric group are added to.
> >   * @table: The table that is searched for metrics, most commonly the table for the
> >   *       architecture perf is running upon.
> >   */
> >  static int metricgroup__add_metric(const char *metric_name, const char *modifier,
> >                                  bool metric_no_group,
> > +                                const char *user_requested_cpu_list,
> > +                                bool system_wide,
> >                                  struct list_head *metric_list,
> >                                  const struct pmu_events_table *table)
> >  {
> > @@ -1242,6 +1275,8 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
> >                       .metric_name = metric_name,
> >                       .modifier = modifier,
> >                       .metric_no_group = metric_no_group,
> > +                     .user_requested_cpu_list = user_requested_cpu_list,
> > +                     .system_wide = system_wide,
> >                       .has_match = false,
> >               };
> >               /*
> > @@ -1263,6 +1298,8 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
> >                               .metric_name = metric_name,
> >                               .modifier = modifier,
> >                               .metric_no_group = metric_no_group,
> > +                             .user_requested_cpu_list = user_requested_cpu_list,
> > +                             .system_wide = system_wide,
> >                               .has_match = &has_match,
> >                               .ret = &ret,
> >                               .table = table,
> > @@ -1293,12 +1330,15 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
> >   * @metric_no_group: Should events written to events be grouped "{}" or
> >   *                   global. Grouping is the default but due to multiplexing the
> >   *                   user may override.
> > + * @user_requested_cpu_list: Command line specified CPUs to record on.
> > + * @system_wide: Are events for all processes recorded.
> >   * @metric_list: The list that metrics are added to.
> >   * @table: The table that is searched for metrics, most commonly the table for the
> >   *       architecture perf is running upon.
> >   */
> >  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
> > -                                     struct list_head *metric_list,
> > +                                     const char *user_requested_cpu_list,
> > +                                     bool system_wide, struct list_head *metric_list,
> >                                       const struct pmu_events_table *table)
> >  {
> >       char *list_itr, *list_copy, *metric_name, *modifier;
> > @@ -1315,8 +1355,8 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
> >                       *modifier++ = '\0';
> >
> >               ret = metricgroup__add_metric(metric_name, modifier,
> > -                                           metric_no_group, metric_list,
> > -                                           table);
> > +                                           metric_no_group, user_requested_cpu_list,
> > +                                           system_wide, metric_list, table);
> >               if (ret == -EINVAL)
> >                       pr_err("Cannot find metric or group `%s'\n", metric_name);
> >
> > @@ -1505,6 +1545,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
> >  static int parse_groups(struct evlist *perf_evlist, const char *str,
> >                       bool metric_no_group,
> >                       bool metric_no_merge,
> > +                     const char *user_requested_cpu_list,
> > +                     bool system_wide,
> >                       struct perf_pmu *fake_pmu,
> >                       struct rblist *metric_events_list,
> >                       const struct pmu_events_table *table)
> > @@ -1518,7 +1560,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> >       if (metric_events_list->nr_entries == 0)
> >               metricgroup__rblist_init(metric_events_list);
> >       ret = metricgroup__add_metric_list(str, metric_no_group,
> > -                                        &metric_list, table);
> > +                                        user_requested_cpu_list,
> > +                                        system_wide, &metric_list, table);
> >       if (ret)
> >               goto out;
> >
> > @@ -1650,6 +1693,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
> >                             const char *str,
> >                             bool metric_no_group,
> >                             bool metric_no_merge,
> > +                           const char *user_requested_cpu_list,
> > +                           bool system_wide,
> >                             struct rblist *metric_events)
> >  {
> >       const struct pmu_events_table *table = pmu_events_table__find();
> > @@ -1657,8 +1702,9 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
> >       if (!table)
> >               return -EINVAL;
> >
> > -     return parse_groups(perf_evlist, str, metric_no_group,
> > -                         metric_no_merge, NULL, metric_events, table);
> > +     return parse_groups(perf_evlist, str, metric_no_group, metric_no_merge,
> > +                         user_requested_cpu_list, system_wide,
> > +                         /*fake_pmu=*/NULL, metric_events, table);
> >  }
> >
> >  int metricgroup__parse_groups_test(struct evlist *evlist,
> > @@ -1668,8 +1714,10 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
> >                                  bool metric_no_merge,
> >                                  struct rblist *metric_events)
> >  {
> > -     return parse_groups(evlist, str, metric_no_group,
> > -                         metric_no_merge, &perf_pmu__fake, metric_events, table);
> > +     return parse_groups(evlist, str, metric_no_group, metric_no_merge,
> > +                         /*user_requested_cpu_list=*/NULL,
> > +                         /*system_wide=*/false,
> > +                         &perf_pmu__fake, metric_events, table);
> >  }
> >
> >  static int metricgroup__has_metric_callback(const struct pmu_event *pe,
> > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> > index af9ceadaec0f..732d3a0d3334 100644
> > --- a/tools/perf/util/metricgroup.h
> > +++ b/tools/perf/util/metricgroup.h
> > @@ -68,6 +68,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
> >                             const char *str,
> >                             bool metric_no_group,
> >                             bool metric_no_merge,
> > +                           const char *user_requested_cpu_list,
> > +                           bool system_wide,
> >                             struct rblist *metric_events);
> >  int metricgroup__parse_groups_test(struct evlist *evlist,
> >                                  const struct pmu_events_table *table,
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 1439acd109db..1deb75741df4 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -911,7 +911,10 @@ static void generic_metric(struct perf_stat_config *config,
> >       if (!pctx)
> >               return;
> >
> > +     if (config->user_requested_cpu_list)
> > +             pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
> >       pctx->sctx.runtime = runtime;
> > +     pctx->sctx.system_wide = config->system_wide;
> >       i = prepare_metric(metric_events, metric_refs, pctx, cpu_map_idx, st);
> >       if (i < 0) {
> >               expr__ctx_free(pctx);
> > @@ -1304,7 +1307,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                               core_bound * 100.);
> >       } else if (evsel->metric_expr) {
> >               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> > -                             evsel->name, evsel->metric_name, NULL, 1, cpu_map_idx, out, st);
> > +                            evsel->name, evsel->metric_name, NULL, 1,
> > +                            cpu_map_idx, out, st);
> >       } else if (runtime_stat_n(st, STAT_NSECS, cpu_map_idx, &rsd) != 0) {
> >               char unit = ' ';
> >               char unit_buf[10] = "/sec";
> > @@ -1329,8 +1333,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                       if (num++ > 0)
> >                               out->new_line(config, ctxp);
> >                       generic_metric(config, mexp->metric_expr, mexp->metric_events,
> > -                                     mexp->metric_refs, evsel->name, mexp->metric_name,
> > -                                     mexp->metric_unit, mexp->runtime, cpu_map_idx, out, st);
> > +                                    mexp->metric_refs, evsel->name, mexp->metric_name,
> > +                                    mexp->metric_unit, mexp->runtime,
> > +                                    cpu_map_idx, out, st);
> >               }
> >       }
> >       if (num == 0)
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index 668250022f8c..72713b344b79 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -141,6 +141,8 @@ struct perf_stat_config {
> >       bool                     stop_read_counter;
> >       bool                     quiet;
> >       bool                     iostat_run;
> > +     char                     *user_requested_cpu_list;
> > +     bool                     system_wide;
> >       FILE                    *output;
> >       unsigned int             interval;
> >       unsigned int             timeout;
> > --
> > 2.37.2.672.g94769d06f0-goog
>
> --
>
> - Arnaldo
