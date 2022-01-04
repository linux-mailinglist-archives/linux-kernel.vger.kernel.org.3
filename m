Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC8484658
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiADRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiADRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:01:45 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 09:01:45 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y11so39683457iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+e+H7/zWSIXqVq2THQZSwH8X/rsfhLcfNE1CJkEArEY=;
        b=gYpGHvksYyEqXrOa03cCtnrVf5ek4IA3ORUGIUk89j/ZVejBTwK2BZ00U//41OQXv8
         H3HGFpznGo369Hc3PtPuBTzqhYPEehA+7rfKSRoh3eWhnz8DUoCeGIOXtHeA9J+7pauD
         zvYMasOv1PRWYECjLUYdMth0+v9Ggzopq8hZ5k/H8xRNsfSc3cOMN4aD9Zb6xGtsMXOi
         PGgWHRvibc9cDjHrk5IyugjMzwO0yK7Mn81DKd40IolWWwzJLlZInCZk2QWScr6E2Dpx
         VbTB+8Y/qZQvHaqyYxtf3zgycKTNaAnGo2pxK1jL429s27F4cvFl1Q+BpAyxKgA5/okn
         WSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+e+H7/zWSIXqVq2THQZSwH8X/rsfhLcfNE1CJkEArEY=;
        b=JkDwRDf8cuGgFEKSJCUX1QYOdE01GQNTt4E79jZ0+l++jOnRbzJ+Mpq5NogQ6QAOMy
         L3GEZ997EK+1kj50ov3/Kbbe//N/xDf+fZKWiIHXFJ58DFzP8tlFIRc8oLPpkcqePYWM
         T6ErFkxCUR+JYHDKI/z/JYHBcqoy706XyfKfXsZZv1klFgUUs0AiOScg8r7brlvOSXjE
         REVW9J4YM8I6HmyUUek4dlUchwh8mMqwQqkcp1eq9yB91Pc/y09NkeFgTVL7Pxtl20/t
         ODFsOq6DPnSR93a6SCDlsRBRc+SOuijOPBXSML4RixjCIIP2sT8z7NVoU2dIoQKljRMi
         q1EA==
X-Gm-Message-State: AOAM532YFlbsbmjo/sQmqjO7f9FBLs70hf36q2ORSE1q2fmeH9OvBiYI
        Rc6gzIdsqVEunWRVrIZRSl46CRex3T7pkNyfQwOg6A==
X-Google-Smtp-Source: ABdhPJyooJkIhAMqTYvnUUyqkCZrx7rLO3Dzq47P/K6gkovkrCiyyChZXaSuciLKXJ16jJHu8ohu5D0vjIE5M6rSj5Q=
X-Received: by 2002:a02:cce5:: with SMTP id l5mr21543654jaq.126.1641315704497;
 Tue, 04 Jan 2022 09:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com> <20211230072030.302559-3-irogers@google.com>
 <YdRX5zgB3AORM/Wd@krava>
In-Reply-To: <YdRX5zgB3AORM/Wd@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Jan 2022 09:01:32 -0800
Message-ID: <CAP-5=fXyBU4yF=S2FSjd6sZXCwqqJ=BS5eOynPk0C4KTs9EcsQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf evlist: Remove group option.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 6:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Dec 29, 2021 at 11:19:43PM -0800, Ian Rogers wrote:
> > The group option predates grouping events using curly braces added in
> > commit 89efb029502d ("perf tools: Add support to parse event group syntax")
> > The --group option was retained for legacy support (in August 2012) but
> > keeping it adds complexity.
> >
> > v2 and v3. were rebases.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> it should not be part of this patchset right?
> I see it was posted separately

Yep, sorry. Not part of this patch set I hadn't realized I had another
v3 patch when I ran send-mail. This patch was sent out a little
earlier already.

Thanks,
Ian

> jirka
>
> > ---
> >  tools/perf/Documentation/perf-record.txt |  4 ----
> >  tools/perf/Documentation/perf-top.txt    |  7 ++-----
> >  tools/perf/builtin-record.c              |  2 --
> >  tools/perf/builtin-stat.c                |  6 ------
> >  tools/perf/builtin-top.c                 |  2 --
> >  tools/perf/tests/attr/README             |  2 --
> >  tools/perf/tests/attr/test-record-group  | 22 ----------------------
> >  tools/perf/tests/attr/test-stat-group    | 17 -----------------
> >  tools/perf/util/evlist.c                 |  2 +-
> >  tools/perf/util/evlist.h                 |  2 --
> >  tools/perf/util/python.c                 |  8 --------
> >  tools/perf/util/record.c                 |  7 -------
> >  tools/perf/util/record.h                 |  1 -
> >  13 files changed, 3 insertions(+), 79 deletions(-)
> >  delete mode 100644 tools/perf/tests/attr/test-record-group
> >  delete mode 100644 tools/perf/tests/attr/test-stat-group
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 55df7b073a55..960fb1ad3f27 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -238,10 +238,6 @@ OPTIONS
> >       Also, by adding a comma, the number of mmap pages for AUX
> >       area tracing can be specified.
> >
> > ---group::
> > -     Put all events in a single event group.  This precedes the --event
> > -     option and remains only for backward compatibility.  See --event.
> > -
> >  -g::
> >       Enables call-graph (stack chain/backtrace) recording for both
> >       kernel space and user space.
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > index cac3dfbee7d8..acbafe777e52 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -51,9 +51,6 @@ Default is to monitor all CPUS.
> >  --count-filter=<count>::
> >       Only display functions with more events than this.
> >
> > ---group::
> > -        Put the counters into a counter group.
> > -
> >  --group-sort-idx::
> >       Sort the output by the event at the index n in group. If n is invalid,
> >       sort by the first event. It can support multiple groups with different
> > @@ -313,10 +310,10 @@ use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
> >
> >               perf top -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
> >
> > -        Alternatively one can ask for --group and then two overhead columns
> > +        Alternatively one can ask for a group and then two overhead columns
> >             will appear, the first for cycles and the second for the switch-on event.
> >
> > -             perf top --group -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
> > +             perf top -e '{cycles,probe:icmp_rcv}' --switch-on=probe:icmp_rcv
> >
> >       This may be interesting to measure a workload only after some initialization
> >       phase is over, i.e. insert a perf probe at that point and use the above
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 6ac2160913ea..54eff61f78eb 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -2521,8 +2521,6 @@ static struct option __record_options[] = {
> >       OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
> >                    "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
> >                    record__mmap_flush_parse),
> > -     OPT_BOOLEAN(0, "group", &record.opts.group,
> > -                 "put the counters into a counter group"),
> >       OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
> >                          NULL, "enables call-graph recording" ,
> >                          &record_callchain_opt),
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index f6ca2b054c5b..8ce4ca6111ae 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -180,7 +180,6 @@ static bool                       topdown_run                     = false;
> >  static bool                  smi_cost                        = false;
> >  static bool                  smi_reset                       = false;
> >  static int                   big_num_opt                     =  -1;
> > -static bool                  group                           = false;
> >  static const char            *pre_cmd                        = NULL;
> >  static const char            *post_cmd                       = NULL;
> >  static bool                  sync_run                        = false;
> > @@ -800,9 +799,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >               child_pid = evsel_list->workload.pid;
> >       }
> >
> > -     if (group)
> > -             evlist__set_leader(evsel_list);
> > -
> >       if (affinity__setup(&affinity) < 0)
> >               return -1;
> >
> > @@ -1212,8 +1208,6 @@ static struct option stat_options[] = {
> >  #endif
> >       OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
> >                   "system-wide collection from all CPUs"),
> > -     OPT_BOOLEAN('g', "group", &group,
> > -                 "put the counters into a counter group"),
> >       OPT_BOOLEAN(0, "scale", &stat_config.scale,
> >                   "Use --no-scale to disable counter scaling for multiplexing"),
> >       OPT_INCR('v', "verbose", &verbose,
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 1fc390f136dd..0d8441942f34 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1472,8 +1472,6 @@ int cmd_top(int argc, const char **argv)
> >                           "dump the symbol table used for profiling"),
> >       OPT_INTEGER('f', "count-filter", &top.count_filter,
> >                   "only display functions with more events than this"),
> > -     OPT_BOOLEAN(0, "group", &opts->group,
> > -                         "put the counters into a counter group"),
> >       OPT_BOOLEAN('i', "no-inherit", &opts->no_inherit,
> >                   "child tasks do not inherit counters"),
> >       OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
> > diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
> > index a36f49fb4dbe..f538272af57b 100644
> > --- a/tools/perf/tests/attr/README
> > +++ b/tools/perf/tests/attr/README
> > @@ -47,7 +47,6 @@ Following tests are defined (with perf commands):
> >    perf record -g kill                           (test-record-graph-default)
> >    perf record --call-graph dwarf kill                (test-record-graph-dwarf)
> >    perf record --call-graph fp kill              (test-record-graph-fp)
> > -  perf record --group -e cycles,instructions kill (test-record-group)
> >    perf record -e '{cycles,instructions}' kill   (test-record-group1)
> >    perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
> >    perf record -D kill                           (test-record-no-delay)
> > @@ -61,6 +60,5 @@ Following tests are defined (with perf commands):
> >    perf stat -d kill                             (test-stat-detailed-1)
> >    perf stat -dd kill                            (test-stat-detailed-2)
> >    perf stat -ddd kill                           (test-stat-detailed-3)
> > -  perf stat --group -e cycles,instructions kill (test-stat-group)
> >    perf stat -e '{cycles,instructions}' kill     (test-stat-group1)
> >    perf stat -i -e cycles kill                   (test-stat-no-inherit)
> > diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
> > deleted file mode 100644
> > index 14ee60fd3f41..000000000000
> > --- a/tools/perf/tests/attr/test-record-group
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -[config]
> > -command = record
> > -args    = --no-bpf-event --group -e cycles,instructions kill >/dev/null 2>&1
> > -ret     = 1
> > -
> > -[event-1:base-record]
> > -fd=1
> > -group_fd=-1
> > -sample_type=327
> > -read_format=4
> > -
> > -[event-2:base-record]
> > -fd=2
> > -group_fd=1
> > -config=1
> > -sample_type=327
> > -read_format=4
> > -mmap=0
> > -comm=0
> > -task=0
> > -enable_on_exec=0
> > -disabled=0
> > diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
> > deleted file mode 100644
> > index e15d6946e9b3..000000000000
> > --- a/tools/perf/tests/attr/test-stat-group
> > +++ /dev/null
> > @@ -1,17 +0,0 @@
> > -[config]
> > -command = stat
> > -args    = --group -e cycles,instructions kill >/dev/null 2>&1
> > -ret     = 1
> > -
> > -[event-1:base-stat]
> > -fd=1
> > -group_fd=-1
> > -read_format=3|15
> > -
> > -[event-2:base-stat]
> > -fd=2
> > -group_fd=1
> > -config=1
> > -disabled=0
> > -enable_on_exec=0
> > -read_format=3|15
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 5f92319ce258..2e11d82d15e0 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -224,7 +224,7 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
> >       return err;
> >  }
> >
> > -void evlist__set_leader(struct evlist *evlist)
> > +static void evlist__set_leader(struct evlist *evlist)
> >  {
> >       perf_evlist__set_leader(&evlist->core);
> >  }
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 27594900a052..ebab48a8120f 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -203,8 +203,6 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
> >  int evlist__create_maps(struct evlist *evlist, struct target *target);
> >  int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
> >
> > -void evlist__set_leader(struct evlist *evlist);
> > -
> >  u64 __evlist__combined_sample_type(struct evlist *evlist);
> >  u64 evlist__combined_sample_type(struct evlist *evlist);
> >  u64 evlist__combined_branch_type(struct evlist *evlist);
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 7f782a31bda3..d063375c346a 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1121,14 +1121,6 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
> >                                  PyObject *args, PyObject *kwargs)
> >  {
> >       struct evlist *evlist = &pevlist->evlist;
> > -     int group = 0;
> > -     static char *kwlist[] = { "group", NULL };
> > -
> > -     if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist, &group))
> > -             return NULL;
> > -
> > -     if (group)
> > -             evlist__set_leader(evlist);
> >
> >       if (evlist__open(evlist) < 0) {
> >               PyErr_SetFromErrno(PyExc_OSError);
> > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> > index bff669b615ee..9e694db7c7ee 100644
> > --- a/tools/perf/util/record.c
> > +++ b/tools/perf/util/record.c
> > @@ -99,13 +99,6 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
> >       bool use_comm_exec;
> >       bool sample_id = opts->sample_id;
> >
> > -     /*
> > -      * Set the evsel leader links before we configure attributes,
> > -      * since some might depend on this info.
> > -      */
> > -     if (opts->group)
> > -             evlist__set_leader(evlist);
> > -
> >       if (evlist->core.cpus->map[0] < 0)
> >               opts->no_inherit = true;
> >
> > diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> > index ef6c2715fdd9..0a7a8dbbea9c 100644
> > --- a/tools/perf/util/record.h
> > +++ b/tools/perf/util/record.h
> > @@ -13,7 +13,6 @@ struct option;
> >
> >  struct record_opts {
> >       struct target target;
> > -     bool          group;
> >       bool          inherit_stat;
> >       bool          no_buffering;
> >       bool          no_inherit;
> > --
> > 2.34.1.307.g9b7440fafd-goog
> >
>
