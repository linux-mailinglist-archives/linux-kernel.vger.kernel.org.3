Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73F52210A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbiEJQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbiEJQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:23:22 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F12A18B4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:19:23 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z144so17397038vsz.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUU7BBSpAi75FzYjPIRUNtb4vWMrTsil53ADDK8Ozvc=;
        b=sicCIWwa9VQNueMk8/LCZqkZmIw71qQG5IRakl2R+yJFNrC9p6S+K4ETCHz+ciYf54
         UjjK7/O28jYobFRYyBZ4zUXATiQ5EbAJ7kCULUsluvWghtpcrJD1qICvpEqC8FViKL9p
         JwDqSPDfJ0dcORH40xtlFwz3TGf/KgLiWxuzKNvn7zec5vkPYLEX2wW0zurpj8outqTi
         IuY9Nd2JxZ1PTUI2584pDO7oWGU4sbafzyUb1K/qzEu2p4WFB1TxmQFuLLy7eFFiKBsP
         mt6vtxBulyEP6GutcOj6iVbCagrVjDug5Z5HL4jXH1jECH5QAedr9LOpU5mTI80eBAw/
         BjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUU7BBSpAi75FzYjPIRUNtb4vWMrTsil53ADDK8Ozvc=;
        b=QmEU9UZJ/cIDOBfGug1vsWDUMnqD2cx+2AGzk+9E979Ha0V45jGuV+O3U0l+ZpqgxY
         v0oMmCwlDdbMBQTFjbB3VrqkLYf/dlEFEz8IvOz4M+pAhG96VPURfNtEZejEETHDrGAD
         SEEvV5gzv89p6SnieTNK7PgclYwRZILevokf6f3X4OlKZWGhywdjoOjsonYeG+JfxiHk
         sdVTizlHHO1iyEvHdJks0dmkHVkeIrh4xchl0RuHhHa13Jflkj86Wx77GOBK/h46n6Lq
         xCoCqbquTD65kmyk1OxbOoevPPkp3D/oIY78kPNfmjCU/fFY2zTRM6cvmfXYuafcoJNt
         Xr3A==
X-Gm-Message-State: AOAM532wmN01jpb54FEbWX4jvq9JTbsgNUPVa2Q6NZzjILKGxnCnDZhv
        wStuElkoWfzqN602m3W0YmlxB2GxtH/BKimdZsBX3ebmEHQ=
X-Google-Smtp-Source: ABdhPJxYGXqzoGfsm6fVvjk8Jqv9hXRCQ8Bm4LZE3lu8s09VgBPo17/jY5vhbrsxp+SakcuZaggmwtTmLaGGM+h/Qrs=
X-Received: by 2002:a05:6102:2929:b0:32d:6662:72e2 with SMTP id
 cz41-20020a056102292900b0032d666272e2mr12026358vsb.56.1652199560469; Tue, 10
 May 2022 09:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com> <CAP-5=fV3SWDb8uTsUmdkweRrO9t9OZXzP=9GWqKxTYn0bdfriw@mail.gmail.com>
 <078c3b3a-9976-9ee4-0cd2-11ff6599dbd2@intel.com> <CAP-5=fWWHeFN1UeyFU=HS39kQNXHcu74JTdOmw0Nar_ztFG-uw@mail.gmail.com>
 <0cde1030-e9e5-8688-d98d-6f5f8b2cde27@intel.com>
In-Reply-To: <0cde1030-e9e5-8688-d98d-6f5f8b2cde27@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 May 2022 09:19:08 -0700
Message-ID: <CAP-5=fXMstJCbAkj-xCpNOKUKJvm-jK-toKOyU8Ys+RM8zbcrQ@mail.gmail.com>
Subject: Re: [PATCH V2 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
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

On Tue, May 10, 2022 at 7:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/05/22 18:35, Ian Rogers wrote:
> > On Fri, May 6, 2022 at 8:08 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 6/05/22 16:47, Ian Rogers wrote:
> >>> On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
> >>>> event that sets up the system-wide maps before map propagation.
> >>>>
> >>>> For convenience, add evlist__add_aux_dummy() so that the logic can be used
> >>>> whether or not the event needs to be system-wide.
> >>>>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>  tools/perf/util/evlist.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>>>  tools/perf/util/evlist.h |  5 +++++
> >>>>  2 files changed, 45 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>>> index 78c47cbafbc2..c16bd4836314 100644
> >>>> --- a/tools/perf/util/evlist.c
> >>>> +++ b/tools/perf/util/evlist.c
> >>>> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
> >>>> +{
> >>>> +       evsel->core.system_wide = true;
> >>>> +
> >>>> +       /* All CPUs */
> >>>> +       perf_cpu_map__put(evsel->core.own_cpus);
> >>>> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> >>>> +       perf_cpu_map__put(evsel->core.cpus);
> >>>> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> >>>> +
> >>>> +       /* No threads */
> >>>> +       perf_thread_map__put(evsel->core.threads);
> >>>> +       evsel->core.threads = perf_thread_map__new_dummy();
> >>>> +
> >>>> +       evlist__add(evlist, evsel);
> >>>> +}
> >>>> +
> >>>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> >>>> +{
> >>>> +       struct evsel *evsel = evlist__dummy_event(evlist);
> >>>> +
> >>>> +       if (!evsel)
> >>>> +               return NULL;
> >>>> +
> >>>> +       evsel->core.attr.exclude_kernel = 1;
> >>>> +       evsel->core.attr.exclude_guest = 1;
> >>>> +       evsel->core.attr.exclude_hv = 1;
> >>>> +       evsel->core.attr.freq = 0;
> >>>> +       evsel->core.attr.sample_period = 1;
> >>>> +       evsel->no_aux_samples = true;
> >>>> +       evsel->name = strdup("dummy:u");
> >>>> +
> >>>> +       if (system_wide)
> >>>> +               evlist__add_on_all_cpus(evlist, evsel);
> >>>> +       else
> >>>> +               evlist__add(evlist, evsel);
> >>>> +
> >>>> +       return evsel;
> >>>> +}
> >>>> +
> >>>>  static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> >>>>  {
> >>>>         struct evsel *evsel, *n;
> >>>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> >>>> index 4062f5aebfc1..1bde9ccf4e7d 100644
> >>>> --- a/tools/perf/util/evlist.h
> >>>> +++ b/tools/perf/util/evlist.h
> >>>> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
> >>>>  struct evsel *arch_evlist__leader(struct list_head *list);
> >>>>
> >>>>  int evlist__add_dummy(struct evlist *evlist);
> >>>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> >>>> +static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
> >>>
> >>> Sorry to be a language lawyer. What I hope to clean up with CPU maps is that:
> >>>
> >>> empty == dummy == any CPU
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
> >>>
> >>> Given every CPU map should be empty or contain any CPU then it seems
> >>> they all meet the definition of empty - so something is wrong.
> >>
> >> Nothing is wrong.  I am not against clarifying things, but stop assuming
> >> natural language has to mean anything exactly.  That is what computer
> >> languages are for.
> >>
> >> Sometimes more abstract language is used, precisely to stop people
> >> making assumptions about the details.
> >>
> >>>
> >>> The cpu map here is explicitly opened so that it gets all online CPUs:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n174
> >>>
> >>> From:
> >>> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/cputopology.rst
> >>> there are example topologies like:
> >>> kernel_max: 31
> >>>    offline: 2,4-31,32-63
> >>>     online: 0-1,3
> >>>   possible: 0-31
> >>>    present: 0-31
> >>>
> >>> all_cpus could mean the union of offline and online CPUs, possible
> >>> CPUs or present CPUs. You are saying that in the perf code all_cpus
> >>> should be the same as all online cpus as only those CPUs are valid
> >>> with perf_event_open. That's true but offline CPUs can be made online.
> >>> If that happens here then the dummy events will have a CPU map that
> >>> rather than being for all CPUs will be for all online CPUs at the
> >>> point it was opened. Having online in the function name I think
> >>> captures the time dependent nature of this - but if you think that's
> >>> too much could we add a comment?
> >>
> >> If you ask me it does the exact opposite.  The function of the code
> >> is to put the event on all CPUS without having to know the details
> >> of: well actually perf doesn't automagically retain or restore events
> >> across enabling or disabling CPUs so in fact we deal only in online
> >> CPUs.
> >
> > But 'any CPU' (-1) could map to an offline CPU brought online. Calling
> > this function twice could also result in this behavior. Via the
> > topology documentation we have language to describe exactly the
> > scenario that's happening and I'd prefer not to muddy that by making
> > all and online synonyms.
>
> In this case the caller wants all CPUs, not online CPUs.  The detail
> that we can't trace offline CPUs that become online is not relevant
> to the caller.  Why would the caller call a function limited to online
> CPUs when that is not what the caller wants.
>
> >
> >>> too much could we add a comment? I'm trying to avoid a situation, like
> >>> with the CPU map code, where all and online are interchangeable
> >>> leading to the code being unnecessarily confusing unless you read
> >>> every line.
> >>
> >> It is normal to have to read the details of code, and, in my
> >> experience at least, normal for the code not to work exactly the
> >> way I'd imagined.
> >
> > :-) The problem is that we all need to work with abstractions at some
> > point, abstraction is pretty much the whole point of computer science.
> > We need to fix CPU maps empty function, it is just a fundamental level
> > of contradiction. As with the CPU map index being often mistaken for
> > the CPU leading to bugs and crashes, I suspect remedying empty will
> > fix existing and future bugs. With function naming the point is to be
> > short and succinct, but also to be intention revealing for the sake of
> > abstraction. Yes you need to read the code, but as with CPU map empty
> > even that isn't enough and trying to infer behavior from usage can be
> > a long and painful process.
>
> You seem to be insisting that the function be named for its
> implementation (i.e. offline CPUs are not supported) not its
> purpose (trace system wide).
>
> I can only suggest we go back to the original name, because the
> function has *nothing* to do with whether or not perf supports
> tracing per-cpu contexts on offline CPUs that become online.

Hi Adrian,

Do you understand my concern for 'all' and 'online' not being synonyms
for each other? When I read 'all' I assume online + offline, this
function is explicitly just online and it didn't seem like a big ask
to have that in the function name. My hope is to have intention
revealing function names rather than to have to plod through code when
things don't work as intended. In any case, I already said that a
comment will suffice that in this context 'all' == 'online'. I'm keen
to land this patch series as we clearly need to fix what is meant by
'empty' that is true for:
truly empty: {}
dummy/any: {-1}
dummy/any merged: {-1,0,1,2,3}
ie empty can mean any CPU, actual CPUs or none. I know I'm adopting
the role of language lawyer in doing this but honestly we need this
fixed, and my hope is with tests on it.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> +{
> >>>> +       return evlist__add_aux_dummy(evlist, true);
> >>>> +}
> >>>>
> >>>>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
> >>>>                          evsel__sb_cb_t cb, void *data);
> >>>> --
> >>>> 2.25.1
> >>>>
> >>
>
