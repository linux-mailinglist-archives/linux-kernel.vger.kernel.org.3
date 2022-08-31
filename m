Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C395A82CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiHaQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiHaQOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:14:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A33CB5F7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:14:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso3342882wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IWp/nrGyciEfU1XYNypVD2gVXNEtS7OFhjckBxMvnpM=;
        b=NWBO58yc8VsOw8kfv2ixgptXXeR/onyFS6nEi9an/QZ0nSPw9Ivgu5Bhiq3upVBPVr
         yumHGlD8out1bds+9QMTsvwkIEnobzHH8juv4uT8S4Tnj4m3U94oJ0edgu6poTbPIG7s
         Y35ZdF6g8AJCmSZypTI4NTZ8gliqxWJEuHgh1X6Em5PCMbfb0uqWJlQXYBMTHt6lQIoH
         NsMH4DfZLb75CvhYAe+UXxXex/sMc8O7mxv4yZHiAVJ/bpkfbubcCVr8UhzgBaHoiHgY
         A3+nHOirBmT6pNMQLIZJXtt1DuEb9X9dzGEvawmGRDmtKd9wv/j9AeTZURAEeleecjm+
         UwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IWp/nrGyciEfU1XYNypVD2gVXNEtS7OFhjckBxMvnpM=;
        b=xcQ+k0xcwf/T3f9DZ7dbpr1JXLcR+pNfrVrCdXhozvdQSbuoz5WPQzwM2wFXH4IXpX
         /P4uzwOCK4ZsX7t/cbyamwZJpAibxptWwfsPiMSazfAaNywW3Od8aUDorUmM3AJd3k73
         slAf4jYPURKR7GZ5OPWz0D9bNhq2RORSo6Ekep4fcxqPZ13nHYHmnnLQZbQ344ggTDvO
         9Q3aBuccQKObUzCC2E+jLK11CUAXUnAGQTYxZ9QV30mjNV1U39KcQlH6Fuhqzi+CJR2c
         udolwQubhNRgP0O9Zjbh8pIAdV42ttO5UWU5ADU9LjH2fCDoHbbgcEVAMZjSIra43mKA
         HW9A==
X-Gm-Message-State: ACgBeo2wPC05SKgyFn+SsFJjlEmCjqjf2TIgfnkQmMiOKuGXXk+IxrAo
        cIQ/sgGfaLa9vRjpzLGxjE5VaIbSx+47r3D1YH4XZQ==
X-Google-Smtp-Source: AA6agR7hCrdUB9fYlOGi4RFsZkmar3bWBKgS3WY4LhnhXIKnJ7zn7EZG+mYny26ZH1ITX5dFwJsxAasoe3SCQNpZ6XE=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id
 14-20020a05600c25ce00b003a5a3b7bbfemr2591617wml.115.1661962452014; Wed, 31
 Aug 2022 09:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com> <20220830164846.401143-7-irogers@google.com>
 <Yw9zPxVqbfkSOdbu@kernel.org>
In-Reply-To: <Yw9zPxVqbfkSOdbu@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 Aug 2022 09:13:59 -0700
Message-ID: <CAP-5=fU7zxoLoen7PH+a0gehSfd0zJzfxsXN+oP_jySTO0=mPg@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] perf stat: Delay metric parsing
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 7:42 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 30, 2022 at 09:48:44AM -0700, Ian Rogers escreveu:
> > Having metric parsing as part of argument processing causes issues as
> > flags like metric-no-group may be specified later. It also denies the
> > opportunity to optimize the events on SMT systems where fewer events
> > may be possible if we know the target is system-wide. Move metric
> > parsing to after command line option parsing. Because of how stat runs
> > this moves the parsing after record/report which fail to work with
> > metrics currently anyway.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c     | 48 ++++++++++++++++++++++++-----------
> >  tools/perf/util/metricgroup.c |  3 +--
> >  tools/perf/util/metricgroup.h |  2 +-
> >  3 files changed, 35 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 7fb81a44672d..c813b1aa7d7c 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -191,6 +191,7 @@ static bool                       append_file;
> >  static bool                  interval_count;
> >  static const char            *output_name;
> >  static int                   output_fd;
> > +static char                  *metrics;
> >
> >  struct perf_stat {
> >       bool                     record;
> > @@ -1147,14 +1148,21 @@ static int enable_metric_only(const struct option *opt __maybe_unused,
> >       return 0;
> >  }
> >
> > -static int parse_metric_groups(const struct option *opt,
> > +static int append_metric_groups(const struct option *opt __maybe_unused,
> >                              const char *str,
> >                              int unset __maybe_unused)
> >  {
> > -     return metricgroup__parse_groups(opt, str,
> > -                                      stat_config.metric_no_group,
> > -                                      stat_config.metric_no_merge,
> > -                                      &stat_config.metric_events);
> > +     if (metrics) {
> > +             char *tmp;
> > +
> > +             if (asprintf(&tmp, "%s,%s", metrics, str) < 0)
> > +                     return -ENOMEM;
>
> We check if we managed to allocate memory here, but not later at
> strdup()?

Added to v2.

Thanks,
Ian

> > +             free(metrics);
> > +             metrics = tmp;
> > +     } else {
> > +             metrics = strdup(str);
> > +     }
> > +     return 0;
> >  }
> >
> >  static int parse_control_option(const struct option *opt,
> > @@ -1298,7 +1306,7 @@ static struct option stat_options[] = {
> >                       "measure SMI cost"),
> >       OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
> >                    "monitor specified metrics or metric groups (separated by ,)",
> > -                  parse_metric_groups),
> > +                  append_metric_groups),
> >       OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
> >                        "Configure all used events to run in kernel space.",
> >                        PARSE_OPT_EXCLUSIVE),
> > @@ -1791,11 +1799,9 @@ static int add_default_attributes(void)
> >                * on an architecture test for such a metric name.
> >                */
> >               if (metricgroup__has_metric("transaction")) {
> > -                     struct option opt = { .value = &evsel_list };
> > -
> > -                     return metricgroup__parse_groups(&opt, "transaction",
> > +                     return metricgroup__parse_groups(evsel_list, "transaction",
> >                                                        stat_config.metric_no_group,
> > -                                                     stat_config.metric_no_merge,
> > +                                                      stat_config.metric_no_merge,
> >                                                        &stat_config.metric_events);
> >               }
> >
> > @@ -2260,8 +2266,6 @@ int cmd_stat(int argc, const char **argv)
> >       argc = parse_options_subcommand(argc, argv, stat_options, stat_subcommands,
> >                                       (const char **) stat_usage,
> >                                       PARSE_OPT_STOP_AT_NON_OPTION);
> > -     perf_stat__collect_metric_expr(evsel_list);
> > -     perf_stat__init_shadow_stats();
> >
> >       if (stat_config.csv_sep) {
> >               stat_config.csv_output = true;
> > @@ -2428,6 +2432,23 @@ int cmd_stat(int argc, const char **argv)
> >                       target.system_wide = true;
> >       }
> >
> > +     if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
> > +             target.per_thread = true;
> > +
> > +     /*
> > +      * Metric parsing needs to be delayed as metrics may optimize events
> > +      * knowing the target is system-wide.
> > +      */
> > +     if (metrics) {
> > +             metricgroup__parse_groups(evsel_list, metrics,
> > +                                     stat_config.metric_no_group,
> > +                                     stat_config.metric_no_merge,
> > +                                     &stat_config.metric_events);
> > +             zfree(&metrics);
> > +     }
> > +     perf_stat__collect_metric_expr(evsel_list);
> > +     perf_stat__init_shadow_stats();
> > +
> >       if (add_default_attributes())
> >               goto out;
> >
> > @@ -2447,9 +2468,6 @@ int cmd_stat(int argc, const char **argv)
> >               }
> >       }
> >
> > -     if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
> > -             target.per_thread = true;
> > -
> >       if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
> >               pr_err("failed to use cpu list %s\n", target.cpu_list);
> >               goto out;
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index b144c3e35264..9151346a16ab 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1646,13 +1646,12 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> >       return ret;
> >  }
> >
> > -int metricgroup__parse_groups(const struct option *opt,
> > +int metricgroup__parse_groups(struct evlist *perf_evlist,
> >                             const char *str,
> >                             bool metric_no_group,
> >                             bool metric_no_merge,
> >                             struct rblist *metric_events)
> >  {
> > -     struct evlist *perf_evlist = *(struct evlist **)opt->value;
> >       const struct pmu_events_table *table = pmu_events_table__find();
> >
> >       if (!table)
> > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> > index 016b3b1a289a..af9ceadaec0f 100644
> > --- a/tools/perf/util/metricgroup.h
> > +++ b/tools/perf/util/metricgroup.h
> > @@ -64,7 +64,7 @@ struct metric_expr {
> >  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
> >                                        struct evsel *evsel,
> >                                        bool create);
> > -int metricgroup__parse_groups(const struct option *opt,
> > +int metricgroup__parse_groups(struct evlist *perf_evlist,
> >                             const char *str,
> >                             bool metric_no_group,
> >                             bool metric_no_merge,
> > --
> > 2.37.2.672.g94769d06f0-goog
>
> --
>
> - Arnaldo
