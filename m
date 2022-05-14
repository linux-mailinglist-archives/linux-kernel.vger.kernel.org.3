Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29DF52714D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiENNfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiENNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:35:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CED22538
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 06:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620B660EE3
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E46C340EE;
        Sat, 14 May 2022 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652535337;
        bh=qr2nHQBaMDVmjWfGNRQXv0gHRvT0ASlWyfL40/Z974I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Be6DtmKu1X/pNPogb7DItA0TEpgUEKk4pBR01ZeMbKvS89jf8ahbsL2qFikKoCk5D
         0v0OOgQLpyTVOuasZjLSvhRVNurN67jiW4quwHz6Jvk+aH6Y73bH0pXCyBPGPSsrsJ
         FmMThnZfYtg5D8WWohRK3Xrs0q63Jf4n+z2JyJQm6nlYRHwyXs9oqutd1dQmnHlD/p
         6CiYIzS36PVnN/TO+j5Cv0FV9uyU7napMyjHxAOULU9wX5s7EfxiogzSogLvRLY2dz
         QJRTwV60DYAUTQS2eKMpJLStCHHXi890n8sc7btHMpmbsfz2Q8RRRfEQimZKm3hZWx
         C3rwAGMsAwyiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8DA07400B1; Sat, 14 May 2022 10:35:34 -0300 (-03)
Date:   Sat, 14 May 2022 10:35:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
Message-ID: <Yn+wJlzymeAaHHcI@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com>
 <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
 <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com>
 <CAM9d7cgDCd2uUJbWcvqmCDGMoPc9kppx--_rcO2OVp_GarLJkg@mail.gmail.com>
 <f92a7681-30ca-eaf5-6f3e-de54bc19adec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92a7681-30ca-eaf5-6f3e-de54bc19adec@intel.com>
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

Em Fri, May 13, 2022 at 07:48:40AM +0300, Adrian Hunter escreveu:
> On 12/05/22 21:53, Namhyung Kim wrote:
> > On Thu, May 12, 2022 at 3:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 12/05/22 08:27, Namhyung Kim wrote:
> >>> On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
> >>>> has_user_cpus. Change that so that system-wide events retain their own
> >>>> CPUs and they are added to all_cpus.
> >>>>
> >>>> Acked-by: Ian Rogers <irogers@google.com>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>  tools/lib/perf/evlist.c | 11 +++++------
> >>>>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> >>>> index 1c801f8da44f..9a6801b53274 100644
> >>>> --- a/tools/lib/perf/evlist.c
> >>>> +++ b/tools/lib/perf/evlist.c
> >>>> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >>>>          * We already have cpus for evsel (via PMU sysfs) so
> >>>>          * keep it, if there's no target cpu list defined.
> >>>>          */
> >>>> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
> >>>> -               perf_cpu_map__put(evsel->cpus);
> >>>> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >>>> -       } else if (!evsel->system_wide &&
> >>>> -                  !evsel->requires_cpu &&
> >>>> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
> >>>> +       if (!evsel->own_cpus ||
> >>>> +           (!evsel->system_wide && evlist->has_user_cpus) ||
> >>>> +           (!evsel->system_wide &&
> >>>> +            !evsel->requires_cpu &&
> >>>> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
> >>>
> >>> This is getting hard to understand.  IIUC this propagation basically
> >>> sets user requested cpus to evsel unless it has its own cpus, right?
> >>
> >> I put the conditional logic altogether because that is kernel style but
> >> it does make it practically unreadable.
> >>
> >> If we start with the original logic:
> >>
> >>         if (!evsel->own_cpus || evlist->has_user_cpus) {
> >>                 perf_cpu_map__put(evsel->cpus);
> >>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >>         } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
> >>                 perf_cpu_map__put(evsel->cpus);
> >>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >>         } else if (evsel->cpus != evsel->own_cpus) {
> >>                 perf_cpu_map__put(evsel->cpus);
> >>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> >>         }
> >>
> >> Then make it more readable, i.e. same functionality
> >>
> >>         struct perf_cpu_map *cpus;
> >>
> >>         if (!evsel->own_cpus || evlist->has_user_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus))
> >>                 cpus = evlist->user_requested_cpus;
> >>         else
> >>                 cpus = evsel->own_cpus;
> >>
> >>         if (evsel->cpus != cpus) {
> >>                 perf_cpu_map__put(evsel->cpus);
> >>                 evsel->cpus = perf_cpu_map__get(cpus);
> >>         }
> >>
> >> Then separate out the conditions, i.e. still same functionality
> >>
> >>         if (!evsel->own_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (evlist->has_user_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (evsel->system_wide)
> >>                 cpus = evsel->own_cpus;
> >>         else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>                 cpus = evlist->user_requested_cpus;
> >>         else
> >>                 cpus = evsel->own_cpus;
> >>
> >> Then add the new requires_cpu flag:
> >>
> >>         if (!evsel->own_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (evlist->has_user_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (evsel->system_wide)
> >>                 cpus = evsel->own_cpus;
> >> -       else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >> +       else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>                 cpus = evlist->user_requested_cpus;
> >>         else
> >>                 cpus = evsel->own_cpus;
> >>
> >> Then make system_wide keep own_cpus even if has_user_cpus:
> >>
> >>         if (!evsel->own_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >> +       else if (evsel->system_wide)
> >> +               cpus = evsel->own_cpus;
> >>         else if (evlist->has_user_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >> -       else if (evsel->system_wide)
> >> -               cpus = evsel->own_cpus;
> >>         else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>                 cpus = evlist->user_requested_cpus;
> >>         else
> >>                 cpus = evsel->own_cpus;
> >>
> >> Which leaves:
> >>
> >>         if (!evsel->own_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (evsel->system_wide)
> >>                 cpus = evsel->own_cpus;
> >>         else if (evlist->has_user_cpus)
> >>                 cpus = evlist->user_requested_cpus;
> >>         else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>                 cpus = evlist->user_requested_cpus;
> >>         else
> >>                 cpus = evsel->own_cpus;
> >>
> >> And putting it back together:
> >>
> >>         if (!evsel->own_cpus ||
> >>             (!evsel->system_wide && evlist->has_user_cpus) ||
> >>             (!evsel->system_wide &&
> >>              !evsel->requires_cpu &&
> >>              perf_cpu_map__empty(evlist->user_requested_cpus))) {
> >>                 cpus = evlist->user_requested_cpus;
> >>         else
> >>                 cpus = evsel->own_cpus;
> >>
> >> Perhaps I shouldn't put it together?
> > 
> > Cool, thanks a lot for explaining it in detail.
> > I do not oppose your change but little worried about the
> > complexity.  And I think we have some issues with uncore
> > events already.
> 
> Yes it is a bit complicated because we are handling
> many different use cases.
> 
> > 
> > So do you have any idea where evsel->own_cpus
> > doesn't propagate to evsel->cpus?
> 
> We let the user's list of CPUs override it i.e. the
> evlist->has_user_cpus case.  Essentially we are expecting
> the user to know what they are doing.
> 
> > 
> > I think evsel->system_wide and evsel->requires_cpu
> > can be replaced to check evsel->own_cpus instead.
> 
> Not at the moment because we let the user override
> own_cpus.
> 
> > 
> > Actually evlist->has_user_cpus is checked first so
> > uncore events' own_cpus might not be used.
> 
> Yes
> 
> > 
> > In my laptop, perf stat -a -A -e imc/data_reads/
> > will use cpu 0 as it's listed in the pmu cpumask.
> > But when I use -C1,2 it'll use the both cpus and
> > returns the similar values each (so the sum is 2x).
> 
> We expect the user to understand the uncore PMU they
> are using.  AFAICT an uncore PMU cpu mask with only
> CPU 0 typically means a single PMU that counts events
> that could be indrectly caused by any CPU.  When the
> cpu mask has more than one CPU, it means a PMU for
> each of a group of CPU's (e.g. a core or socket)
> 
> So in the example you gave above, there is only 1 PMU
> and reading from any CPU will give it's value.
> 
> A user providing a list of CPUs for uncore events
> is useful only in certain cases.  For example when
> each core has an uncore PMU and you only want to get
> values from one core.
> 
> > 
> > I'm not sure if it's intended.  I expect it runs on
> > cpu 0 or one of the given cpus.  Or it runs on both
> > cpus and returns value in half so that the sum is
> > the same as the original value (from a cpu).
> 
> I don't know if there is anything wrong with the way
> we are handling uncore PMUs, except that I don't know
> if it is documented anywhere.

Good thing about this conversation is that it will result in
documentation :-)

Thank you guys for having it and detailing it so nicely.

- Arnaldo
 
> > 
> >>
> >>>
> >>> But the hybrid pmus make this complex.  Maybe we can move the
> >>> logic in evlist__fix_hybrid_cpus() here and simplify it like below
> >>>
> >>> if (evsel->own_cpus) {
> >>>    if (evsel->pmu->is_hybrid)
> >>>       evsel->cpus = fixup_hybrid_cpus(evsel>own_cpus,
> >>>                                       evlist->user_requested_cpus);  //?
> >>>    else
> >>>       evsel->cpus = evlist->own_cpus;  // put + get
> >>> } else {
> >>>    evsel->cpus = evlist->user_requested_cpus;  // put + get
> >>> }
> >>>
> >>> Then we need to make sure evsel->pmu is set properly.
> >>>
> >>> What do you think?
> >>
> >> Hybrid handling looks complicated.  I would have to spend time
> >> better understanding it.
> >>
> >> So, in the context of this patch set, I don't want to look at
> >> issues with hybrid CPUs, except that there should be no change
> >> to how they are handled.
> > 
> > Fair enough.  But I think we have to look at it again soon.
> > 
> > Thanks,
> > Namhyung
