Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86D6463D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbhK3SPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:15:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243131AbhK3SPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638295902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddL8n8P0TCUoTeHHnDhgCoDcqA2h1iCOGqF7iCcQ86E=;
        b=DLO0GpdWV9TE06zw2OiDBOyImD58nvwt5BVJq/cRwBmKaj7oQ1TT9tAb/y4XhDoQQpKAnq
        nOZ5xBH+AMYLuvSW00PAWOC88bULIUyNy3GLEv2pWsk5JnBywI4njRK5NYG5dChYHJkUHs
        frr1waPsLOoxSi2bkT1mkCtPHi/Wkaw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-janfu2BWMPGZ6__oJD5qxA-1; Tue, 30 Nov 2021 13:11:40 -0500
X-MC-Unique: janfu2BWMPGZ6__oJD5qxA-1
Received: by mail-wm1-f70.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso14216557wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddL8n8P0TCUoTeHHnDhgCoDcqA2h1iCOGqF7iCcQ86E=;
        b=FywRlnvwMm46oHsLYrVjoVQqQ8/D18nlaejDi7uVnKotppnSMSoGF3VbBPGkwJEHgR
         vWNphOtBGn7eyDg8o3ouHzBiPVXobDJevMvzq7kcuEBtDNP/lQD0rSBdTsIszV95tDZv
         2Z5R28knEo593ZJBl6xJVIbx3NvSxJ7ZsHdRv0SsCnFhd2gv5TAkqG+Gj1WOp5JeTbZM
         z3QQHRTSxFRI2Zdw0qga1ZbIYBXKHufrJbjsd0ITvrooR36PfmPKcWkCape88Ka23YGN
         oKnmQ2kUz9CCX/W1m1mjfDuSyhZm2vhAlG33xNdG4hxIsVTc0z521SlLEuCWE85DrsR0
         tqGg==
X-Gm-Message-State: AOAM533KTl4bZC8sC47TMwy6SIJ59b2BCVjEB0g8yN2z1UG3HGesj4DT
        9roxBPCt6xgX2t0JnalC8zIvVm+nGVk7FYOpP4Bfo/1BVkz+jRMoXeC/v+IE2DypfgKVyIS2C8t
        okuPKI2aQ2IsHo3x8e3gSSsLy
X-Received: by 2002:a05:600c:2f10:: with SMTP id r16mr288629wmn.141.1638295899724;
        Tue, 30 Nov 2021 10:11:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5wN+F933qqKEgjN80+OQ468Igi/bARHDXAHS1GcmhJ/HGDfcsCzvIk6/yQO6vb4K4Dwe8jA==
X-Received: by 2002:a05:600c:2f10:: with SMTP id r16mr288572wmn.141.1638295899406;
        Tue, 30 Nov 2021 10:11:39 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id e12sm22632784wrq.20.2021.11.30.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:11:38 -0800 (PST)
Date:   Tue, 30 Nov 2021 19:11:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf metric: Reduce multiplexing with duration_time
Message-ID: <YaZpWOi26cLgYnPz@krava>
References: <20211124015226.3317994-1-irogers@google.com>
 <YaOs+DjuoQvuqIrC@krava>
 <CAP-5=fXBRa7+ugLAWjuOkwr3vqWtaby86e8zovUvkX2wmYV4ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXBRa7+ugLAWjuOkwr3vqWtaby86e8zovUvkX2wmYV4ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:46:31AM -0800, Ian Rogers wrote:
> On Sun, Nov 28, 2021 at 8:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Nov 23, 2021 at 05:52:26PM -0800, Ian Rogers wrote:
> > > It is common to use the same counters with and without
> > > duration_time. The ID sharing code treats duration_time as if it
> > > were a hardware event placed in the same group. This causes
> > > unnecessary multiplexing such as in the following example where
> > > l3_cache_access isn't shared:
> > >
> > > $ perf stat -M l3 -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >          3,117,007      l3_cache_miss             #    199.5 MB/s  l3_rd_bw
> > >                                                   #     43.6 %  l3_hits
> > >                                                   #     56.4 %  l3_miss               (50.00%)
> > >          5,526,447      l3_cache_access                                               (50.00%)
> > >          5,392,435      l3_cache_access           # 5389191.2 access/s  l3_access_rate  (50.00%)
> > >      1,000,601,901 ns   duration_time
> > >
> > >        1.000601901 seconds time elapsed
> > >
> > > Fix this by placing duration_time in all groups unless metric
> > > sharing has been disabled on the command line:
> > >
> > > $ perf stat -M l3 -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >          3,597,972      l3_cache_miss             #    230.3 MB/s  l3_rd_bw
> > >                                                   #     48.0 %  l3_hits
> > >                                                   #     52.0 %  l3_miss
> > >          6,914,459      l3_cache_access           # 6909935.9 access/s  l3_access_rate
> > >      1,000,654,579 ns   duration_time
> > >
> > >        1.000654579 seconds time elapsed
> > >
> > > $ perf stat --metric-no-merge -M l3 -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >          3,501,834      l3_cache_miss             #     53.5 %  l3_miss               (24.99%)
> > >          6,548,173      l3_cache_access                                               (24.99%)
> > >          3,417,622      l3_cache_miss             #     45.7 %  l3_hits               (25.04%)
> > >          6,294,062      l3_cache_access                                               (25.04%)
> > >          5,923,238      l3_cache_access           # 5919688.1 access/s  l3_access_rate  (24.99%)
> > >      1,000,599,683 ns   duration_time
> > >          3,607,486      l3_cache_miss             #    230.9 MB/s  l3_rd_bw           (49.97%)
> > >
> > >        1.000599683 seconds time elapsed
> > >
> > > v2. Doesn't count duration_time in the metric_list_cmp function that
> > >     sorts larger metrics first. Without this a metric with duration_time
> > >     and an event is sorted the same as a metric with two events,
> > >     possibly not allowing the first metric to share with the second.
> >
> > hum, isn't the change about adding duration_time in every metric?
> > or you could still end up with metric without duration_time
> 
> It is about adding duration_time to all metrics. Sorting of the
> metrics by number of IDs happens before we insert duration_time which
> happens just prior to parsing. duration_time needn't be inserted if
> --metric-no-merge is passed.

I see, so that sorting takes place before it's added, makes sense then

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > thanks,
> > jirka
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/metricgroup.c | 42 +++++++++++++++++++++++++++--------
> > >  1 file changed, 33 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > index fffe02aae3ed..51c99cb08abf 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -1115,13 +1115,27 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
> > >       return ret;
> > >  }
> > >
> > > +/**
> > > + * metric_list_cmp - list_sort comparator that sorts metrics with more events to
> > > + *                   the front. duration_time is excluded from the count.
> > > + */
> > >  static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
> > >                          const struct list_head *r)
> > >  {
> > >       const struct metric *left = container_of(l, struct metric, nd);
> > >       const struct metric *right = container_of(r, struct metric, nd);
> > > +     struct expr_id_data *data;
> > > +     int left_count, right_count;
> > > +
> > > +     left_count = hashmap__size(left->pctx->ids);
> > > +     if (!expr__get_id(left->pctx, "duration_time", &data))
> > > +             left_count--;
> > > +
> > > +     right_count = hashmap__size(right->pctx->ids);
> > > +     if (!expr__get_id(right->pctx, "duration_time", &data))
> > > +             right_count--;
> > >
> > > -     return hashmap__size(right->pctx->ids) - hashmap__size(left->pctx->ids);
> > > +     return right_count - left_count;
> > >  }
> > >
> > >  /**
> > > @@ -1299,14 +1313,16 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
> > >  /**
> > >   * parse_ids - Build the event string for the ids and parse them creating an
> > >   *             evlist. The encoded metric_ids are decoded.
> > > + * @metric_no_merge: is metric sharing explicitly disabled.
> > >   * @fake_pmu: used when testing metrics not supported by the current CPU.
> > >   * @ids: the event identifiers parsed from a metric.
> > >   * @modifier: any modifiers added to the events.
> > >   * @has_constraint: false if events should be placed in a weak group.
> > >   * @out_evlist: the created list of events.
> > >   */
> > > -static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
> > > -                  const char *modifier, bool has_constraint, struct evlist **out_evlist)
> > > +static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
> > > +                  struct expr_parse_ctx *ids, const char *modifier,
> > > +                  bool has_constraint, struct evlist **out_evlist)
> > >  {
> > >       struct parse_events_error parse_error;
> > >       struct evlist *parsed_evlist;
> > > @@ -1314,12 +1330,19 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
> > >       int ret;
> > >
> > >       *out_evlist = NULL;
> > > -     if (hashmap__size(ids->ids) == 0) {
> > > +     if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
> > >               char *tmp;
> > >               /*
> > > -              * No ids/events in the expression parsing context. Events may
> > > -              * have been removed because of constant evaluation, e.g.:
> > > -              *  event1 if #smt_on else 0
> > > +              * We may fail to share events between metrics because
> > > +              * duration_time isn't present in one metric. For example, a
> > > +              * ratio of cache misses doesn't need duration_time but the same
> > > +              * events may be used for a misses per second. Events without
> > > +              * sharing implies multiplexing, that is best avoided, so place
> > > +              * duration_time in every group.
> > > +              *
> > > +              * Also, there may be no ids/events in the expression parsing
> > > +              * context because of constant evaluation, e.g.:
> > > +              *    event1 if #smt_on else 0
> > >                * Add a duration_time event to avoid a parse error on an empty
> > >                * string.
> > >                */
> > > @@ -1387,7 +1410,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> > >               ret = build_combined_expr_ctx(&metric_list, &combined);
> > >
> > >               if (!ret && combined && hashmap__size(combined->ids)) {
> > > -                     ret = parse_ids(fake_pmu, combined, /*modifier=*/NULL,
> > > +                     ret = parse_ids(metric_no_merge, fake_pmu, combined,
> > > +                                     /*modifier=*/NULL,
> > >                                       /*has_constraint=*/true,
> > >                                       &combined_evlist);
> > >               }
> > > @@ -1435,7 +1459,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> > >                       }
> > >               }
> > >               if (!metric_evlist) {
> > > -                     ret = parse_ids(fake_pmu, m->pctx, m->modifier,
> > > +                     ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
> > >                                       m->has_constraint, &m->evlist);
> > >                       if (ret)
> > >                               goto out;
> > > --
> > > 2.34.0.rc2.393.gf8c9666880-goog
> > >
> >
> 

