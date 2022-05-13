Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFC52674E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382029AbiEMQnK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiEMQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:43:04 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488110FE1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:43:02 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id w123so10782593oiw.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEkNDvL2lGQy3HoQISWPF6+nZqphRj4v5ybWfe42Mhw=;
        b=gRlJW3cVqABWifSkLbebC//x0ljnyCAwTC6ZNoU0dGZZFmSsDBTqoXXQw6gCVvCetp
         MwzFTpnajvRZ3MSNALurMSHXe6CtneSHgWKRenqZwSeohy//5+JKvG0GKHmDxnlzwPpf
         1/TRq5EZd6wQa+9yMsW3oSkldkI9OagSxCiyOc7Hr18UimM1yT5iUsR9j21xZImp2IAY
         IGmdwGL83+tV/G7pSQfWxt+3450creIJZmREspL06Dybn/xo1I3bA3gCTLHBgQvwf4i8
         kUB5dwy/n0XkJZupMUiCy/w8pK31kuM4DEoiVYeOxFzTJqDjdbJnw/0TJcqE7g6MCsS9
         ehXA==
X-Gm-Message-State: AOAM533uWneaJrKugnjj8kP55wfMD6zMSiny/FtcxN8d38hTF9K9fSw7
        fs5qG7i8ghF2S7D8oG2WHTvFbr9UpYZ4huD+9Hs=
X-Google-Smtp-Source: ABdhPJz4neBZptshH2Ns1cJbw5Be1VoftkRGjIwuvfqNkagaVKr6XRuVwHLWk+p36ReILkVaaAshWsuKvFTTj1l0Gao=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr8081283oib.5.1652460182067; Fri, 13
 May 2022 09:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com> <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
 <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com> <CAM9d7cgDCd2uUJbWcvqmCDGMoPc9kppx--_rcO2OVp_GarLJkg@mail.gmail.com>
 <f92a7681-30ca-eaf5-6f3e-de54bc19adec@intel.com> <9ae6d64e-a935-94f0-d2a9-cc49a578ba1c@linux.intel.com>
 <84737c6c-6fc5-57a1-b964-73a4ae8bf4be@intel.com> <584b0753-5e69-16b7-014f-7115d6b88683@linux.intel.com>
 <24814c81-fdff-17f1-e686-2dc968381e20@intel.com>
In-Reply-To: <24814c81-fdff-17f1-e686-2dc968381e20@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 13 May 2022 09:42:51 -0700
Message-ID: <CAM9d7ch5OY-AXM075aoZ0VwX3WAaui2c0DXNkKryJpVXO93MOA@mail.gmail.com>
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 9:11 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/05/22 18:46, Liang, Kan wrote:
> >
> >
> > On 5/13/2022 11:21 AM, Adrian Hunter wrote:
> >> On 13/05/22 17:12, Liang, Kan wrote:
> >>>
> >>>
> >>> On 5/13/2022 12:48 AM, Adrian Hunter wrote:
> >>>> On 12/05/22 21:53, Namhyung Kim wrote:
> >>>>> On Thu, May 12, 2022 at 3:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>>
> >>>>>> On 12/05/22 08:27, Namhyung Kim wrote:
> >>>>>>> On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>>>>
> >>>>>>>> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
> >>>>>>>> has_user_cpus. Change that so that system-wide events retain their own
> >>>>>>>> CPUs and they are added to all_cpus.
> >>>>>>>>
> >>>>>>>> Acked-by: Ian Rogers <irogers@google.com>
> >>>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>>>> ---
> >>>>>>>>    tools/lib/perf/evlist.c | 11 +++++------
> >>>>>>>>    1 file changed, 5 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> >>>>>>>> index 1c801f8da44f..9a6801b53274 100644
> >>>>>>>> --- a/tools/lib/perf/evlist.c
> >>>>>>>> +++ b/tools/lib/perf/evlist.c
> >>>>>>>> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >>>>>>>>            * We already have cpus for evsel (via PMU sysfs) so
> >>>>>>>>            * keep it, if there's no target cpu list defined.
> >>>>>>>>            */
> >>>>>>>> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
> >>>>>>>> -               perf_cpu_map__put(evsel->cpus);
> >>>>>>>> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >>>>>>>> -       } else if (!evsel->system_wide &&
> >>>>>>>> -                  !evsel->requires_cpu &&
> >>>>>>>> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
> >>>>>>>> +       if (!evsel->own_cpus ||
> >>>>>>>> +           (!evsel->system_wide && evlist->has_user_cpus) ||
> >>>>>>>> +           (!evsel->system_wide &&
> >>>>>>>> +            !evsel->requires_cpu &&
> >>>>>>>> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
> >>>>>>>
> >>>>>>> This is getting hard to understand.  IIUC this propagation basically
> >>>>>>> sets user requested cpus to evsel unless it has its own cpus, right?
> >>>>>>
> >>>>>> I put the conditional logic altogether because that is kernel style but
> >>>>>> it does make it practically unreadable.
> >>>>>>
> >>>>>> If we start with the original logic:
> >>>>>>
> >>>>>>           if (!evsel->own_cpus || evlist->has_user_cpus) {
> >>>>>>                   perf_cpu_map__put(evsel->cpus);
> >>>>>>                   evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >>>>>>           } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
> >>>>>>                   perf_cpu_map__put(evsel->cpus);
> >>>>>>                   evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >>>>>>           } else if (evsel->cpus != evsel->own_cpus) {
> >>>>>>                   perf_cpu_map__put(evsel->cpus);
> >>>>>>                   evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> >>>>>>           }
> >>>>>>
> >>>>>> Then make it more readable, i.e. same functionality
> >>>>>>
> >>>>>>           struct perf_cpu_map *cpus;
> >>>>>>
> >>>>>>           if (!evsel->own_cpus || evlist->has_user_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus))
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>
> >>>>>>           if (evsel->cpus != cpus) {
> >>>>>>                   perf_cpu_map__put(evsel->cpus);
> >>>>>>                   evsel->cpus = perf_cpu_map__get(cpus);
> >>>>>>           }
> >>>>>>
> >>>>>> Then separate out the conditions, i.e. still same functionality
> >>>>>>
> >>>>>>           if (!evsel->own_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (evlist->has_user_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (evsel->system_wide)
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>           else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>
> >>>>>> Then add the new requires_cpu flag:
> >>>>>>
> >>>>>>           if (!evsel->own_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (evlist->has_user_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (evsel->system_wide)
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>> -       else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>>>>> +       else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>
> >>>>>> Then make system_wide keep own_cpus even if has_user_cpus:
> >>>>>>
> >>>>>>           if (!evsel->own_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>> +       else if (evsel->system_wide)
> >>>>>> +               cpus = evsel->own_cpus;
> >>>>>>           else if (evlist->has_user_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>> -       else if (evsel->system_wide)
> >>>>>> -               cpus = evsel->own_cpus;
> >>>>>>           else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>
> >>>>>> Which leaves:
> >>>>>>
> >>>>>>           if (!evsel->own_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (evsel->system_wide)
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>           else if (evlist->has_user_cpus)
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>
> >>>>>> And putting it back together:
> >>>>>>
> >>>>>>           if (!evsel->own_cpus ||
> >>>>>>               (!evsel->system_wide && evlist->has_user_cpus) ||
> >>>>>>               (!evsel->system_wide &&
> >>>>>>                !evsel->requires_cpu &&
> >>>>>>                perf_cpu_map__empty(evlist->user_requested_cpus))) {
> >>>>>>                   cpus = evlist->user_requested_cpus;
> >>>>>>           else
> >>>>>>                   cpus = evsel->own_cpus;
> >>>>>>
> >>>>>> Perhaps I shouldn't put it together?
> >>>>>
> >>>>> Cool, thanks a lot for explaining it in detail.
> >>>>> I do not oppose your change but little worried about the
> >>>>> complexity.  And I think we have some issues with uncore
> >>>>> events already.
> >>>>
> >>>> Yes it is a bit complicated because we are handling
> >>>> many different use cases.
> >>>>
> >>>>>
> >>>>> So do you have any idea where evsel->own_cpus
> >>>>> doesn't propagate to evsel->cpus?
> >>>>
> >>>> We let the user's list of CPUs override it i.e. the
> >>>> evlist->has_user_cpus case.  Essentially we are expecting
> >>>> the user to know what they are doing.
> >>>>
> >>>>>
> >>>>> I think evsel->system_wide and evsel->requires_cpu
> >>>>> can be replaced to check evsel->own_cpus instead.
> >>>>
> >>>> Not at the moment because we let the user override
> >>>> own_cpus.
> >>>
> >>> Do we check whether the user's input is valid (match the PMU's cpumask) before the override?
> >>>
> >>> I think we know the PMU name. The cpumask of the PMU can be found in the sysfs. So we should have enough information for a sanity check.
> >>
> >> For the uncore PMU case, I am not sure what sanity is :-)
> >>
> >
> > For a non-core PMU, e.g., uncore, cstate, power and etc. The cpumask is under the /sys/devices/<PMU>/cpumask. It shows the cpumask which kernel supports. If a end user request a different CPU other that the cpumask, I think it's better throw a waning. It should mitigate the confusion which Namhyung mentioned (uncore -C1,2).
>
> So you couldn't get uncore events unless you are also coincidentally wanting to trace CPU 0.
>
> I guess really the requrement is not to perf_event_open() an uncore PMU more than once?
> To figure that out we'd need to be able map CPUs to uncore PMUs?

We might just use evsel->own_cpus for uncore events and
if the user-given cpu list contains other cpus it can show an
warning.

Thanks,
Namhyung
