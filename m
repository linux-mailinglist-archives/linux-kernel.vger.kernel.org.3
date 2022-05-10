Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C682522127
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347341AbiEJQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiEJQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79129132769
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15343617F0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBB5C385C2;
        Tue, 10 May 2022 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652199853;
        bh=km0BMpb24Wggcdk/CWnp34r65qFaHvU9tKPdPWkdkG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHv1aBCL9SkCb51L26aM7sC3EYvcYsk4oyHINYrgB/9zTA0MzS4PHdmImbzK4HLDr
         IyNRk8REnNOYVt9WkrfWN4XcvTo4gyamZDS8p0QEX3vmtX80J8gw5lsxZHU+W+LwpZ
         XX9Bot9jibO9afM9pw0Go/udkl0bMGS4pOgtr4ogVSFQQFJnM7KTBtllGFjB0kOJVW
         xPQrbnbTernWMDMZ90yNlQrA6255bcaDcgMV2acAMod47ueR7urSqDsd9nwjmdBmtF
         gpO2/Tqrttt1AIis/pLfZnvgQ/Ivm0oZ6dcQ6TRI0i3+hcAqZCv3qLK4uFY6Z2c79Q
         dL2/LJtN4Bokw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3195400B1; Tue, 10 May 2022 13:24:08 -0300 (-03)
Date:   Tue, 10 May 2022 13:24:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
Message-ID: <YnqRqHsyIzp03qI4@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com>
 <CAP-5=fV3SWDb8uTsUmdkweRrO9t9OZXzP=9GWqKxTYn0bdfriw@mail.gmail.com>
 <078c3b3a-9976-9ee4-0cd2-11ff6599dbd2@intel.com>
 <CAP-5=fWWHeFN1UeyFU=HS39kQNXHcu74JTdOmw0Nar_ztFG-uw@mail.gmail.com>
 <0cde1030-e9e5-8688-d98d-6f5f8b2cde27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cde1030-e9e5-8688-d98d-6f5f8b2cde27@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 10, 2022 at 05:55:34PM +0300, Adrian Hunter escreveu:
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

Agreed, the intention is for all CPUs to be traced, so all that can be
traced should be traced, at the time of the call to this function.

An improvement, that would change the workings of this function, but
that would still do what was asked, would be to have functionality that
remembers such requestgs for tracing all CPUs and when a CPU that was
offline is brought online, gets that CPU added to whoever asked for all
CPUs to be traced.

If this is something critical to the caller, then perhaps it should
provide a callback for when CPUs are made online (or offline).

But then we can add that functionality when the need arises?

- Arnaldo
 
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
> 
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

-- 

- Arnaldo
