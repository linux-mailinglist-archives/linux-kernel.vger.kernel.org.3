Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166B6522198
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbiEJQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEJQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:49:17 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A41F90C5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:45:18 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id x5so6845131uap.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYucDXUH3bHmr7L94p9Xhlsk40ETaody5ZHiPH3dW8E=;
        b=iUQ1/7OVzf+SBDfKC9WA5nEmHvM3FbLbALFw8mA262RbT28epxSTIIIaJtvsOHHFYr
         YzsEV+P1Xr9aYRaLbLu1Q/sYZooprWGauBa6Ujb70y2c4PYfYMbn8tvaNbsEF0H1qsGe
         +WgL342BMAZChUTHriyHjT3jiI/RKWu5+d+tBmIxA9wUtdcP+qUjEaPqzKO3sV8QL3ZO
         zt3oOnsEQ0bPGdrfwqeeTZbIR97d6V4cxCgqY7orW00DXS8VozAfrQxNiTGwIdaM49c8
         MK2LHBXZDy39HaVnkyXpOe1BesXuP5S/qJvz5SvH/IkYtFJOLomTqG2xg+uPA2D4ZT0r
         T5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYucDXUH3bHmr7L94p9Xhlsk40ETaody5ZHiPH3dW8E=;
        b=3Apz7CRoFDY4TTEU8LKD+Cbb390BswXwNDHcG+To68qbkKJCHO7SrFTyqijdFQ+NGt
         AOXVpYFUpvIM1T1Y9gee6gh4iElRt/Yr/P3nXc1N9zpQW7hqnauEcIcayhNHErDOdvlA
         RCbUlQ8kOldu5GZOzQ+HRzp3foWU51XU0CpbRmc2gpssRHBmhm9475yNx9zjV52y1Yvw
         tFOrs/jyJnWUJWGSelzMeTGYWw8HHNqan2aNMJMozy20FnJBLcWrJEcBsaCnCbEa+pRq
         f/3pl+lTE0kClnewuYKjJp1C8h7GNGpWy3tB9wOBPWLuQqT79JrfR8t72pEO5MtcAS5I
         hQkA==
X-Gm-Message-State: AOAM533/bBf74oRt0InGBj4xsyo6XhptRcvGM0NrUjpPTTvBxfaIWsY7
        Cvvd0k7EOINw6EYPicwDxAd3arvty2XmlIxqS+/ZDA==
X-Google-Smtp-Source: ABdhPJxKKYHH+Nq39IxnWw5lGCjODWofEde3xjPzIrvoQhmWDGPuIdQZVCZainhAH/virCJXC4M6ESVyN+rc3Dgbtt4=
X-Received: by 2002:ab0:240e:0:b0:360:325a:7352 with SMTP id
 f14-20020ab0240e000000b00360325a7352mr11873143uan.108.1652201116812; Tue, 10
 May 2022 09:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com> <20220507053410.3798748-2-irogers@google.com>
 <YnkTIwiVBEGUJRKn@kernel.org> <b01a66c4-ec4d-ccb7-8ca7-130d93855177@linux.intel.com>
 <708fab8f-b5c5-8f34-4322-3e337c56b869@linux.intel.com> <YnqJaS5D8pESXk4Z@kernel.org>
In-Reply-To: <YnqJaS5D8pESXk4Z@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 May 2022 09:45:05 -0700
Message-ID: <CAP-5=fUFU-pfy3BhSJGjG1880G=Yghr6CFcdjRrZmGh-iZncuw@mail.gmail.com>
Subject: Re: [PATCH 1/5] Revert "perf stat: Support metrics with hybrid events"
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Tue, May 10, 2022 at 8:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, May 10, 2022 at 05:31:37PM +0800, Xing Zhengjun escreveu:
> > On 5/10/2022 5:55 AM, Liang, Kan wrote:
> > > On 5/9/2022 9:12 AM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, May 06, 2022 at 10:34:06PM -0700, Ian Rogers escreveu:
> > > > > This reverts commit 60344f1a9a597f2e0efcd57df5dad0b42da15e21.
>
> > > > I picked this from the cover letter and added to this revert, to justify
> > > > it:
>
> > > > "Hybrid metrics place a PMU at the end of the parse string. This is
> > > > also where tool events are placed. The behavior of the parse string
> > > > isn't clear and so revert the change for now."
>
> > > I think the original patch used a "#" to indicate the PMU name, which
> > > can be used to distinguish between the tool events and the PMU name.
> > > To be honest, I'm not sure what's unclear here. Could you please clarify?
>
> > > With this revert, the issue mentioned in the original patch must be
> > > broken on ADL. I don't see a replacement fix in this patch series.
> > > Could you please propose a solution for the issue to replace the #PMU
> > > name solution?
>
> > > Thanks,
> > > Kan
>
> > I am surprised the origin patch is reverted during discussion and though the
> > discussion still has no conclusion.
>
> Yeah, the situation is not a good one, it was my mistake to merge the
> patch in the first place without giving time for people like Ian, that
> works a lot in the metrics code to voice his concerns, to review it.
>
> So I decided to revert to give more time for interested parties to
> discuss it further, again, I'm sorry about that.
>
> - Arnaldo

Thanks, I appreciate the time to discuss and get this done in a more proper way.

> > Let me introduce the purpose of the origin patch.
> > For a hybrid system such as ADL, if both the metrics and the formula are
> > different for the different PMUs, without this patch, the metric and event
> > parser should work ok, nothing should be special for the hybrid. In fact,
> > both "cpu_core" and "cpu_atom" may have the same metrics--the same metric
> > name, even the same formula for the metrics. For example, both "cpu_core"
> > and "cpu_atom" have metrics "IpBranch" and "IPC", For "IpBranch", both
> > "cpu_core" and "cpu_atom" has the same metric name and their formula also is
> > the same, the event name is the same though they belong to different PMUs.
> > The old metric and event parser can not handle this kind of metric, that's
> > why we need this patch.
> >
> >     "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> >     "MetricName": "IpBranch",
> >     "Unit": "cpu_core"
> >
> >     "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> >     "MetricName": "IpBranch",
> >     "Unit": "cpu_atom"
> >
> >
> >    "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> >    "MetricName": "IPC",
> >    "Unit": "cpu_core"
> >
> >    "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
> >    "MetricName": "IPC",
> >    "Unit": "cpu_atom"
> >
> > Except for the above two metrics, there are still a lot of similar metrics,
> > "CPU_Utilization"...
> >
> > The original patch expanded the metric group string by adding "#PMU_name" to
> > indicate the PMU name, which can be used to distinguish between the tool
> > events and the PMU name, then the metric and event parser can parse the
> > right PMU for the events.
> >
> > With the patch all the ADL metrics can pass, without the patch, a lot of
> > metrics will fail. I don't think it's a good idea to revert it before the
> > new solution is proposed.
> >
> > >
> > > > I apologise for not having provided ample time for reviewing this patch,
> > > > sorry about that.
> > > >
> > > > - Arnaldo
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >   tools/perf/util/metricgroup.c  | 263 +++------------------------------
> > > > >   tools/perf/util/stat-display.c |   8 +-
> > > > >   2 files changed, 22 insertions(+), 249 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/metricgroup.c
> > > > > b/tools/perf/util/metricgroup.c
> > > > > index 126a43a8917e..d8492e339521 100644
> > > > > --- a/tools/perf/util/metricgroup.c
> > > > > +++ b/tools/perf/util/metricgroup.c
> > > > > @@ -141,11 +141,6 @@ struct metric {
> > > > >        * output.
> > > > >        */
> > > > >       const char *metric_unit;
> > > > > -    /**
> > > > > -     * The name of the CPU such as "cpu_core" or "cpu_atom" in
> > > > > hybrid systems
> > > > > -     * and "NULL" in non-hybrid systems.
> > > > > -     */
> > > > > -    const char *pmu_name;
> > > > >       /** Optional null terminated array of referenced metrics. */
> > > > >       struct metric_ref *metric_refs;
> > > > >       /**
> > > > > @@ -220,7 +215,6 @@ static struct metric *metric__new(const
> > > > > struct pmu_event *pe,
> > > > >       }
> > > > >       m->metric_expr = pe->metric_expr;
> > > > >       m->metric_unit = pe->unit;
> > > > > -    m->pmu_name = pe->pmu;
> > > > >       m->pctx->runtime = runtime;
> > > > >       m->has_constraint = metric_no_group ||
> > > > > metricgroup__has_constraint(pe);
> > > > >       m->metric_refs = NULL;
> > > > > @@ -256,12 +250,10 @@ static bool contains_metric_id(struct
> > > > > evsel **metric_events, int num_events,
> > > > >    * @ids: the metric IDs to match.
> > > > >    * @metric_evlist: the list of perf events.
> > > > >    * @out_metric_events: holds the created metric events array.
> > > > > - * @pmu_name: the name of the CPU.
> > > > >    */
> > > > >   static int setup_metric_events(struct hashmap *ids,
> > > > >                      struct evlist *metric_evlist,
> > > > > -                   struct evsel ***out_metric_events,
> > > > > -                   const char *pmu_name)
> > > > > +                   struct evsel ***out_metric_events)
> > > > >   {
> > > > >       struct evsel **metric_events;
> > > > >       const char *metric_id;
> > > > > @@ -294,10 +286,6 @@ static int setup_metric_events(struct hashmap *ids,
> > > > >            * about this event.
> > > > >            */
> > > > >           if (hashmap__find(ids, metric_id, (void **)&val_ptr)) {
> > > > > -            if (evsel__is_hybrid(ev) && pmu_name &&
> > > > > -                strcmp(pmu_name, ev->pmu_name)) {
> > > > > -                continue;
> > > > > -            }
> > > > >               metric_events[matched_events++] = ev;
> > > > >               if (matched_events >= ids_size)
> > > > > @@ -736,8 +724,7 @@ static int decode_all_metric_ids(struct
> > > > > evlist *perf_evlist, const char *modifie
> > > > >   static int metricgroup__build_event_string(struct strbuf *events,
> > > > >                          const struct expr_parse_ctx *ctx,
> > > > >                          const char *modifier,
> > > > > -                       bool has_constraint,
> > > > > -                       const char *pmu_name)
> > > > > +                       bool has_constraint)
> > > > >   {
> > > > >       struct hashmap_entry *cur;
> > > > >       size_t bkt;
> > > > > @@ -819,18 +806,12 @@ static int
> > > > > metricgroup__build_event_string(struct strbuf *events,
> > > > >           if (no_group) {
> > > > >               /* Strange case of a metric of just duration_time. */
> > > > >               ret = strbuf_addf(events, "duration_time");
> > > > > -        } else if (!has_constraint) {
> > > > > -            ret = strbuf_addf(events, "}:W");
> > > > > -            if (pmu_name)
> > > > > -                ret = strbuf_addf(events, "#%s", pmu_name);
> > > > > -            ret = strbuf_addf(events, ",duration_time");
> > > > > -        } else
> > > > > +        } else if (!has_constraint)
> > > > > +            ret = strbuf_addf(events, "}:W,duration_time");
> > > > > +        else
> > > > >               ret = strbuf_addf(events, ",duration_time");
> > > > > -    } else if (!no_group && !has_constraint) {
> > > > > +    } else if (!no_group && !has_constraint)
> > > > >           ret = strbuf_addf(events, "}:W");
> > > > > -        if (pmu_name)
> > > > > -            ret = strbuf_addf(events, "#%s", pmu_name);
> > > > > -    }

To Zhengjun's point about adding the #pmu_name done above: the code is
conditionally adding the #pmu_name but only when events are grouped,
this means that the behavior with the command line option
--metric-no-group is different as in that case no #pmu_name will be
added (there's no group). In that case how do the events choose the
correct PMU? While this may work for existing Alderlake metrics I
don't expect it to work in the future or with command line options.
The problem reminds me of modifiers on metrics where we rewrite events
to add in the modifiers:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n703
The logic here is also used in event deduplication for things like the
combined event list and I don't understand how #pmu_name is expected
to work in that context. It is only partially working here.

Thanks,
Ian

> > > > >       return ret;
> > > > >   #undef RETURN_IF_NON_ZERO
> > > > > @@ -1169,13 +1150,11 @@ static int metric_list_cmp(void *priv
> > > > > __maybe_unused, const struct list_head *l,
> > > > >    * @metric_list: The list that the metric or metric group are
> > > > > added to.
> > > > >    * @map: The map that is searched for metrics, most commonly
> > > > > the table for the
> > > > >    *       architecture perf is running upon.
> > > > > - * @pmu_name: the name of the CPU.
> > > > >    */
> > > > > -static int metricgroup__add_metric(const char *metric_name,
> > > > > -                   const char *modifier, bool metric_no_group,
> > > > > +static int metricgroup__add_metric(const char *metric_name,
> > > > > const char *modifier,
> > > > > +                   bool metric_no_group,
> > > > >                      struct list_head *metric_list,
> > > > > -                   const struct pmu_events_map *map,
> > > > > -                   const char *pmu_name)
> > > > > +                   const struct pmu_events_map *map)
> > > > >   {
> > > > >       const struct pmu_event *pe;
> > > > >       LIST_HEAD(list);
> > > > > @@ -1188,8 +1167,6 @@ static int metricgroup__add_metric(const
> > > > > char *metric_name,
> > > > >        */
> > > > >       map_for_each_metric(pe, i, map, metric_name) {
> > > > >           has_match = true;
> > > > > -        if (pmu_name && pe->pmu && strcmp(pmu_name, pe->pmu))
> > > > > -            continue;
> > > > >           ret = add_metric(&list, pe, modifier, metric_no_group,
> > > > >                    /*root_metric=*/NULL,
> > > > >                    /*visited_metrics=*/NULL, map);
> > > > > @@ -1238,12 +1215,10 @@ static int metricgroup__add_metric(const
> > > > > char *metric_name,
> > > > >    * @metric_list: The list that metrics are added to.
> > > > >    * @map: The map that is searched for metrics, most commonly
> > > > > the table for the
> > > > >    *       architecture perf is running upon.
> > > > > - * @pmu_name: the name of the CPU.
> > > > >    */
> > > > >   static int metricgroup__add_metric_list(const char *list, bool
> > > > > metric_no_group,
> > > > >                       struct list_head *metric_list,
> > > > > -                    const struct pmu_events_map *map,
> > > > > -                    const char *pmu_name)
> > > > > +                    const struct pmu_events_map *map)
> > > > >   {
> > > > >       char *list_itr, *list_copy, *metric_name, *modifier;
> > > > >       int ret, count = 0;
> > > > > @@ -1260,7 +1235,7 @@ static int
> > > > > metricgroup__add_metric_list(const char *list, bool
> > > > > metric_no_group,
> > > > >           ret = metricgroup__add_metric(metric_name, modifier,
> > > > >                             metric_no_group, metric_list,
> > > > > -                          map, pmu_name);
> > > > > +                          map);
> > > > >           if (ret == -EINVAL)
> > > > >               pr_err("Cannot find metric or group `%s'\n", metric_name);
> > > > > @@ -1335,183 +1310,6 @@ static int build_combined_expr_ctx(const
> > > > > struct list_head *metric_list,
> > > > >       return ret;
> > > > >   }
> > > > > -static char *get_metric_pmus(char *orig_str, struct strbuf
> > > > > *metric_pmus)
> > > > > -{
> > > > > -    char *llist, *nlist, *p1, *p2, *new_str = NULL;
> > > > > -    int ret;
> > > > > -    struct strbuf new_events;
> > > > > -
> > > > > -    if (!strchr(orig_str, '#')) {
> > > > > -        /*
> > > > > -         * pmu name is added after '#'. If no '#' found,
> > > > > -         * don't need to process pmu.
> > > > > -         */
> > > > > -        return strdup(orig_str);
> > > > > -    }
> > > > > -
> > > > > -    nlist = strdup(orig_str);
> > > > > -    if (!nlist)
> > > > > -        return new_str;
> > > > > -
> > > > > -    ret = strbuf_init(&new_events, 100);
> > > > > -    if (ret)
> > > > > -        goto err_out;
> > > > > -
> > > > > -    ret = strbuf_grow(metric_pmus, 100);
> > > > > -    if (ret)
> > > > > -        goto err_out;
> > > > > -
> > > > > -    llist = nlist;
> > > > > -    while ((p1 = strsep(&llist, ",")) != NULL) {
> > > > > -        p2 = strchr(p1, '#');
> > > > > -        if (p2) {
> > > > > -            *p2 = 0;
> > > > > -            ret = strbuf_addf(&new_events, "%s,", p1);
> > > > > -            if (ret)
> > > > > -                goto err_out;
> > > > > -
> > > > > -            ret = strbuf_addf(metric_pmus, "%s,", p2 + 1);
> > > > > -            if (ret)
> > > > > -                goto err_out;
> > > > > -
> > > > > -        } else {
> > > > > -            ret = strbuf_addf(&new_events, "%s,", p1);
> > > > > -            if (ret)
> > > > > -                goto err_out;
> > > > > -        }
> > > > > -    }
> > > > > -
> > > > > -    new_str = strdup(new_events.buf);
> > > > > -    if (new_str) {
> > > > > -        /* Remove last ',' */
> > > > > -        new_str[strlen(new_str) - 1] = 0;
> > > > > -    }
> > > > > -err_out:
> > > > > -    free(nlist);
> > > > > -    strbuf_release(&new_events);
> > > > > -    return new_str;
> > > > > -}
> > > > > -
> > > > > -static void set_pmu_unmatched_events(struct evlist *evlist, int
> > > > > group_idx,
> > > > > -                     char *pmu_name,
> > > > > -                     unsigned long *evlist_removed)
> > > > > -{
> > > > > -    struct evsel *evsel, *pos;
> > > > > -    int i = 0, j = 0;
> > > > > -
> > > > > -    /*
> > > > > -     * Move to the first evsel of a given group
> > > > > -     */
> > > > > -    evlist__for_each_entry(evlist, evsel) {
> > > > > -        if (evsel__is_group_leader(evsel) &&
> > > > > -            evsel->core.nr_members >= 1) {
> > > > > -            if (i < group_idx) {
> > > > > -                j += evsel->core.nr_members;
> > > > > -                i++;
> > > > > -                continue;
> > > > > -            }
> > > > > -        }
> > > > > -    }
> > > > > -
> > > > > -    i = 0;
> > > > > -    evlist__for_each_entry(evlist, evsel) {
> > > > > -        if (i < j) {
> > > > > -            i++;
> > > > > -            continue;
> > > > > -        }
> > > > > -
> > > > > -        /*
> > > > > -         * Now we are at the first evsel in the group
> > > > > -         */
> > > > > -        for_each_group_evsel(pos, evsel) {
> > > > > -            if (evsel__is_hybrid(pos) &&
> > > > > -                strcmp(pos->pmu_name, pmu_name)) {
> > > > > -                set_bit(pos->core.idx, evlist_removed);
> > > > > -            }
> > > > > -        }
> > > > > -        break;
> > > > > -    }
> > > > > -}
> > > > > -
> > > > > -static void remove_pmu_umatched_events(struct evlist *evlist,
> > > > > char *metric_pmus)
> > > > > -{
> > > > > -    struct evsel *evsel, *tmp, *new_leader = NULL;
> > > > > -    unsigned long *evlist_removed;
> > > > > -    char *llist, *nlist, *p1;
> > > > > -    bool need_new_leader = false;
> > > > > -    int i = 0, new_nr_members = 0;
> > > > > -
> > > > > -    nlist = strdup(metric_pmus);
> > > > > -    if (!nlist)
> > > > > -        return;
> > > > > -
> > > > > -    evlist_removed = bitmap_zalloc(evlist->core.nr_entries);
> > > > > -    if (!evlist_removed) {
> > > > > -        free(nlist);
> > > > > -        return;
> > > > > -    }
> > > > > -
> > > > > -    llist = nlist;
> > > > > -    while ((p1 = strsep(&llist, ",")) != NULL) {
> > > > > -        if (strlen(p1) > 0) {
> > > > > -            /*
> > > > > -             * p1 points to the string of pmu name, e.g. "cpu_atom".
> > > > > -             * The metric group string has pmu suffixes, e.g.
> > > > > -             * "{inst_retired.any,cpu_clk_unhalted.thread}:W#cpu_core,
> > > > > -             *  {cpu_clk_unhalted.core,inst_retired.any_p}:W#cpu_atom"
> > > > > -             * By counting the pmu name, we can know the index of
> > > > > -             * group.
> > > > > -             */
> > > > > -            set_pmu_unmatched_events(evlist, i++, p1,
> > > > > -                         evlist_removed);
> > > > > -        }
> > > > > -    }
> > > > > -
> > > > > -    evlist__for_each_entry_safe(evlist, tmp, evsel) {
> > > > > -        if (test_bit(evsel->core.idx, evlist_removed)) {
> > > > > -            if (!evsel__is_group_leader(evsel)) {
> > > > > -                if (!need_new_leader) {
> > > > > -                    if (new_leader)
> > > > > -                        new_leader->core.leader->nr_members--;
> > > > > -                    else
> > > > > -                        evsel->core.leader->nr_members--;
> > > > > -                } else
> > > > > -                    new_nr_members--;
> > > > > -            } else {
> > > > > -                /*
> > > > > -                 * If group leader is to remove, we need to
> > > > > -                 * prepare a new leader and adjust all group
> > > > > -                 * members.
> > > > > -                 */
> > > > > -                need_new_leader = true;
> > > > > -                new_nr_members =
> > > > > -                    evsel->core.leader->nr_members - 1;
> > > > > -            }
> > > > > -
> > > > > -            evlist__remove(evlist, evsel);
> > > > > -            evsel__delete(evsel);
> > > > > -        } else {
> > > > > -            if (!evsel__is_group_leader(evsel)) {
> > > > > -                if (need_new_leader) {
> > > > > -                    need_new_leader = false;
> > > > > -                    new_leader = evsel;
> > > > > -                    new_leader->core.leader =
> > > > > -                        &new_leader->core;
> > > > > -                    new_leader->core.nr_members =
> > > > > -                        new_nr_members;
> > > > > -                } else if (new_leader)
> > > > > -                    evsel->core.leader = &new_leader->core;
> > > > > -            } else {
> > > > > -                need_new_leader = false;
> > > > > -                new_leader = NULL;
> > > > > -            }
> > > > > -        }
> > > > > -    }
> > > > > -
> > > > > -    bitmap_free(evlist_removed);
> > > > > -    free(nlist);
> > > > > -}
> > > > > -
> > > > >   /**
> > > > >    * parse_ids - Build the event string for the ids and parse
> > > > > them creating an
> > > > >    *             evlist. The encoded metric_ids are decoded.
> > > > > @@ -1521,18 +1319,14 @@ static void
> > > > > remove_pmu_umatched_events(struct evlist *evlist, char
> > > > > *metric_pmus)
> > > > >    * @modifier: any modifiers added to the events.
> > > > >    * @has_constraint: false if events should be placed in a weak group.
> > > > >    * @out_evlist: the created list of events.
> > > > > - * @pmu_name: the name of the CPU.
> > > > >    */
> > > > >   static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
> > > > >                struct expr_parse_ctx *ids, const char *modifier,
> > > > > -             bool has_constraint, struct evlist **out_evlist,
> > > > > -             const char *pmu_name)
> > > > > +             bool has_constraint, struct evlist **out_evlist)
> > > > >   {
> > > > >       struct parse_events_error parse_error;
> > > > >       struct evlist *parsed_evlist;
> > > > >       struct strbuf events = STRBUF_INIT;
> > > > > -    struct strbuf metric_pmus = STRBUF_INIT;
> > > > > -    char *nlist = NULL;
> > > > >       int ret;
> > > > >       *out_evlist = NULL;
> > > > > @@ -1559,7 +1353,7 @@ static int parse_ids(bool metric_no_merge,
> > > > > struct perf_pmu *fake_pmu,
> > > > >           ids__insert(ids->ids, tmp);
> > > > >       }
> > > > >       ret = metricgroup__build_event_string(&events, ids, modifier,
> > > > > -                          has_constraint, pmu_name);
> > > > > +                          has_constraint);
> > > > >       if (ret)
> > > > >           return ret;
> > > > > @@ -1570,20 +1364,11 @@ static int parse_ids(bool
> > > > > metric_no_merge, struct perf_pmu *fake_pmu,
> > > > >       }
> > > > >       pr_debug("Parsing metric events '%s'\n", events.buf);
> > > > >       parse_events_error__init(&parse_error);
> > > > > -    nlist = get_metric_pmus(events.buf, &metric_pmus);
> > > > > -    if (!nlist) {
> > > > > -        ret = -ENOMEM;
> > > > > -        goto err_out;
> > > > > -    }
> > > > > -    ret = __parse_events(parsed_evlist, nlist, &parse_error, fake_pmu);
> > > > > +    ret = __parse_events(parsed_evlist, events.buf,
> > > > > &parse_error, fake_pmu);
> > > > >       if (ret) {
> > > > >           parse_events_error__print(&parse_error, events.buf);
> > > > >           goto err_out;
> > > > >       }
> > > > > -
> > > > > -    if (metric_pmus.alloc)
> > > > > -        remove_pmu_umatched_events(parsed_evlist, metric_pmus.buf);
> > > > > -
> > > > >       ret = decode_all_metric_ids(parsed_evlist, modifier);
> > > > >       if (ret)
> > > > >           goto err_out;
> > > > > @@ -1591,12 +1376,9 @@ static int parse_ids(bool
> > > > > metric_no_merge, struct perf_pmu *fake_pmu,
> > > > >       *out_evlist = parsed_evlist;
> > > > >       parsed_evlist = NULL;
> > > > >   err_out:
> > > > > -    if (nlist)
> > > > > -        free(nlist);
> > > > >       parse_events_error__exit(&parse_error);
> > > > >       evlist__delete(parsed_evlist);
> > > > >       strbuf_release(&events);
> > > > > -    strbuf_release(&metric_pmus);
> > > > >       return ret;
> > > > >   }
> > > > > @@ -1615,8 +1397,7 @@ static int parse_groups(struct evlist
> > > > > *perf_evlist, const char *str,
> > > > >       if (metric_events_list->nr_entries == 0)
> > > > >           metricgroup__rblist_init(metric_events_list);
> > > > >       ret = metricgroup__add_metric_list(str, metric_no_group,
> > > > > -                       &metric_list, map,
> > > > > -                       perf_evlist->hybrid_pmu_name);
> > > > > +                       &metric_list, map);
> > > > >       if (ret)
> > > > >           goto out;
> > > > > @@ -1632,8 +1413,7 @@ static int parse_groups(struct evlist
> > > > > *perf_evlist, const char *str,
> > > > >               ret = parse_ids(metric_no_merge, fake_pmu, combined,
> > > > >                       /*modifier=*/NULL,
> > > > >                       /*has_constraint=*/true,
> > > > > -                    &combined_evlist,
> > > > > -                    perf_evlist->hybrid_pmu_name);
> > > > > +                    &combined_evlist);
> > > > >           }
> > > > >           if (combined)
> > > > >               expr__ctx_free(combined);
> > > > > @@ -1670,9 +1450,6 @@ static int parse_groups(struct evlist
> > > > > *perf_evlist, const char *str,
> > > > >                       continue;
> > > > >                   if (expr__subset_of_ids(n->pctx, m->pctx)) {
> > > > > -                    if (m->pmu_name && n->pmu_name
> > > > > -                        && strcmp(m->pmu_name, n->pmu_name))
> > > > > -                        continue;
> > > > >                       pr_debug("Events in '%s' fully contained
> > > > > within '%s'\n",
> > > > >                            m->metric_name, n->metric_name);
> > > > >                       metric_evlist = n->evlist;
> > > > > @@ -1682,16 +1459,14 @@ static int parse_groups(struct evlist
> > > > > *perf_evlist, const char *str,
> > > > >               }
> > > > >           }
> > > > >           if (!metric_evlist) {
> > > > > -            ret = parse_ids(metric_no_merge, fake_pmu, m->pctx,
> > > > > -                      m->modifier, m->has_constraint,
> > > > > -                      &m->evlist, m->pmu_name);
> > > > > +            ret = parse_ids(metric_no_merge, fake_pmu, m->pctx,
> > > > > m->modifier,
> > > > > +                    m->has_constraint, &m->evlist);
> > > > >               if (ret)
> > > > >                   goto out;
> > > > >               metric_evlist = m->evlist;
> > > > >           }
> > > > > -        ret = setup_metric_events(m->pctx->ids, metric_evlist,
> > > > > -                      &metric_events, m->pmu_name);
> > > > > +        ret = setup_metric_events(m->pctx->ids, metric_evlist,
> > > > > &metric_events);
> > > > >           if (ret) {
> > > > >               pr_debug("Cannot resolve IDs for %s: %s\n",
> > > > >                   m->metric_name, m->metric_expr);
> > > > > diff --git a/tools/perf/util/stat-display.c
> > > > > b/tools/perf/util/stat-display.c
> > > > > index 13f705737367..98669ca5a86b 100644
> > > > > --- a/tools/perf/util/stat-display.c
> > > > > +++ b/tools/perf/util/stat-display.c
> > > > > @@ -539,8 +539,7 @@ static void aggr_update_shadow(struct
> > > > > perf_stat_config *config,
> > > > >       }
> > > > >   }
> > > > > -static void uniquify_event_name(struct evsel *counter,
> > > > > -                struct perf_stat_config *stat_config)
> > > > > +static void uniquify_event_name(struct evsel *counter)
> > > > >   {
> > > > >       char *new_name;
> > > > >       char *config;
> > > > > @@ -559,8 +558,7 @@ static void uniquify_event_name(struct evsel
> > > > > *counter,
> > > > >               counter->name = new_name;
> > > > >           }
> > > > >       } else {
> > > > > -        if (perf_pmu__has_hybrid() &&
> > > > > -            stat_config->metric_events.nr_entries == 0) {
> > > > > +        if (perf_pmu__has_hybrid()) {
> > > > >               ret = asprintf(&new_name, "%s/%s/",
> > > > >                          counter->pmu_name, counter->name);
> > > > >           } else {
> > > > > @@ -634,7 +632,7 @@ static bool collect_data(struct
> > > > > perf_stat_config *config, struct evsel *counter,
> > > > >           return false;
> > > > >       cb(config, counter, data, true);
> > > > >       if (config->no_merge || hybrid_merge(counter, config, false))
> > > > > -        uniquify_event_name(counter, config);
> > > > > +        uniquify_event_name(counter);
> > > > >       else if (counter->auto_merge_stats ||
> > > > > hybrid_merge(counter, config, true))
> > > > >           collect_all_aliases(config, counter, cb, data);
> > > > >       return true;
> > > > > --
> > > > > 2.36.0.512.ge40c2bad7a-goog
> > > >
> >
> > --
> > Zhengjun Xing
>
> --
>
> - Arnaldo
