Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF96C51DC41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443035AbiEFPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442989AbiEFPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:39:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B1218D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:35:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e24so10528319wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRk0FMwd5CWvO2i8JuaQngK+sbgTIYr5RynUulYPdFk=;
        b=oRRBna5pTLYdWiR6CpC75sOZ4EbDiWTH1blFW3aOFujvYk8lOIlKOFqkWEutKSdriX
         W72ioFGefj12SD5L09o0VScA+fpLNE16FiLiUlOZGbT6T6RdL1rtwJ4RWmp6IAdgA8T5
         SGFRRT/Jtfz+RzCI/G6bef2uAouVqKrSYPN1AdTZERTmcVYVxC4CgRgX4miEyHOJ0NTR
         d7ii1Krncj8IQkt3ep+uMWZ3/2G5ArfnCPt6tZ/0q9B9rpa9zaZpK6AnfcYUrWpCMqxd
         a3Q0eOU2qTz5fts3Fi4wfcEt15GKRu+NB71gtUHQbJPnvOMEvl6Vpx+3A3zU3eUpL5Ld
         GZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRk0FMwd5CWvO2i8JuaQngK+sbgTIYr5RynUulYPdFk=;
        b=cHwuGxUnXMdnUAbTi9dNzAZ9pWx3SAalFtZ51M8I9OBI0MyHS7jRky5ZWtn1bvcTix
         BnCZSQ26+bscwiU7ryaSwJIfolsE5shPuR8gjtMa+3dp990MiIewp0M4klwhplr9j0DS
         CdEA4kQIRdotxkoG14L1Mb9R7juCbhfxSgW7UnCxFxM8Gywd6M0k1HNWFrV9nwi1/BIr
         W0c22Vnvwdj2R36KSXt0YQbdMFfCAKBbIupegIVw1A3+buhh7aB24oFQnN8Ysg3IH2b1
         5qM4gYM9HjFTTfDpbrDj6VgJC0GBaQ8A3VbWgV1r3Rh2S98h3d8X77yQakkqLwvUYGbO
         f7bQ==
X-Gm-Message-State: AOAM530e8DkpSzY/nVre5MD0f0ee2BG/OX2MTrJhGgBnL3xcupOfJru3
        x7hVuaYchH/J08ni4hqP5mz+lgYFJEbn1+A+Do9wWw==
X-Google-Smtp-Source: ABdhPJxshzu3Dlm2wtaGAOl/ocRvaV0GEY1nVucb9j2HYZgg3W/1rL/z/3SC+Xy3uIupSM1jY1ikfsqP66I+WKQF8JE=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr3244583wrd.375.1651851320542; Fri, 06
 May 2022 08:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com> <CAP-5=fV3SWDb8uTsUmdkweRrO9t9OZXzP=9GWqKxTYn0bdfriw@mail.gmail.com>
 <078c3b3a-9976-9ee4-0cd2-11ff6599dbd2@intel.com>
In-Reply-To: <078c3b3a-9976-9ee4-0cd2-11ff6599dbd2@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 08:35:08 -0700
Message-ID: <CAP-5=fWWHeFN1UeyFU=HS39kQNXHcu74JTdOmw0Nar_ztFG-uw@mail.gmail.com>
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

On Fri, May 6, 2022 at 8:08 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/05/22 16:47, Ian Rogers wrote:
> > On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
> >> event that sets up the system-wide maps before map propagation.
> >>
> >> For convenience, add evlist__add_aux_dummy() so that the logic can be used
> >> whether or not the event needs to be system-wide.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/util/evlist.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>  tools/perf/util/evlist.h |  5 +++++
> >>  2 files changed, 45 insertions(+)
> >>
> >> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >> index 78c47cbafbc2..c16bd4836314 100644
> >> --- a/tools/perf/util/evlist.c
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
> >>         return 0;
> >>  }
> >>
> >> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
> >> +{
> >> +       evsel->core.system_wide = true;
> >> +
> >> +       /* All CPUs */
> >> +       perf_cpu_map__put(evsel->core.own_cpus);
> >> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> >> +       perf_cpu_map__put(evsel->core.cpus);
> >> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> >> +
> >> +       /* No threads */
> >> +       perf_thread_map__put(evsel->core.threads);
> >> +       evsel->core.threads = perf_thread_map__new_dummy();
> >> +
> >> +       evlist__add(evlist, evsel);
> >> +}
> >> +
> >> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> >> +{
> >> +       struct evsel *evsel = evlist__dummy_event(evlist);
> >> +
> >> +       if (!evsel)
> >> +               return NULL;
> >> +
> >> +       evsel->core.attr.exclude_kernel = 1;
> >> +       evsel->core.attr.exclude_guest = 1;
> >> +       evsel->core.attr.exclude_hv = 1;
> >> +       evsel->core.attr.freq = 0;
> >> +       evsel->core.attr.sample_period = 1;
> >> +       evsel->no_aux_samples = true;
> >> +       evsel->name = strdup("dummy:u");
> >> +
> >> +       if (system_wide)
> >> +               evlist__add_on_all_cpus(evlist, evsel);
> >> +       else
> >> +               evlist__add(evlist, evsel);
> >> +
> >> +       return evsel;
> >> +}
> >> +
> >>  static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> >>  {
> >>         struct evsel *evsel, *n;
> >> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> >> index 4062f5aebfc1..1bde9ccf4e7d 100644
> >> --- a/tools/perf/util/evlist.h
> >> +++ b/tools/perf/util/evlist.h
> >> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
> >>  struct evsel *arch_evlist__leader(struct list_head *list);
> >>
> >>  int evlist__add_dummy(struct evlist *evlist);
> >> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> >> +static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
> >
> > Sorry to be a language lawyer. What I hope to clean up with CPU maps is that:
> >
> > empty == dummy == any CPU
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
> >
> > Given every CPU map should be empty or contain any CPU then it seems
> > they all meet the definition of empty - so something is wrong.
>
> Nothing is wrong.  I am not against clarifying things, but stop assuming
> natural language has to mean anything exactly.  That is what computer
> languages are for.
>
> Sometimes more abstract language is used, precisely to stop people
> making assumptions about the details.
>
> >
> > The cpu map here is explicitly opened so that it gets all online CPUs:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n174
> >
> > From:
> > https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/cputopology.rst
> > there are example topologies like:
> > kernel_max: 31
> >    offline: 2,4-31,32-63
> >     online: 0-1,3
> >   possible: 0-31
> >    present: 0-31
> >
> > all_cpus could mean the union of offline and online CPUs, possible
> > CPUs or present CPUs. You are saying that in the perf code all_cpus
> > should be the same as all online cpus as only those CPUs are valid
> > with perf_event_open. That's true but offline CPUs can be made online.
> > If that happens here then the dummy events will have a CPU map that
> > rather than being for all CPUs will be for all online CPUs at the
> > point it was opened. Having online in the function name I think
> > captures the time dependent nature of this - but if you think that's
> > too much could we add a comment?
>
> If you ask me it does the exact opposite.  The function of the code
> is to put the event on all CPUS without having to know the details
> of: well actually perf doesn't automagically retain or restore events
> across enabling or disabling CPUs so in fact we deal only in online
> CPUs.

But 'any CPU' (-1) could map to an offline CPU brought online. Calling
this function twice could also result in this behavior. Via the
topology documentation we have language to describe exactly the
scenario that's happening and I'd prefer not to muddy that by making
all and online synonyms.

> > too much could we add a comment? I'm trying to avoid a situation, like
> > with the CPU map code, where all and online are interchangeable
> > leading to the code being unnecessarily confusing unless you read
> > every line.
>
> It is normal to have to read the details of code, and, in my
> experience at least, normal for the code not to work exactly the
> way I'd imagined.

:-) The problem is that we all need to work with abstractions at some
point, abstraction is pretty much the whole point of computer science.
We need to fix CPU maps empty function, it is just a fundamental level
of contradiction. As with the CPU map index being often mistaken for
the CPU leading to bugs and crashes, I suspect remedying empty will
fix existing and future bugs. With function naming the point is to be
short and succinct, but also to be intention revealing for the sake of
abstraction. Yes you need to read the code, but as with CPU map empty
even that isn't enough and trying to infer behavior from usage can be
a long and painful process.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >> +{
> >> +       return evlist__add_aux_dummy(evlist, true);
> >> +}
> >>
> >>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
> >>                          evsel__sb_cb_t cb, void *data);
> >> --
> >> 2.25.1
> >>
>
