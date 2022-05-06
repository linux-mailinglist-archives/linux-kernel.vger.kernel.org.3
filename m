Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905AD51D374
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390166AbiEFIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiEFIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:38:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19D68317
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:34:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so9054156wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfh1fiTIk1xCjgD8sLnxJeVxqah+r7Lt/e2Er2MKweM=;
        b=BIjezw8vzVBC6te99D/heMb58qfFzO6633FNhmDKPtCcDeG6h+TFDT5AKJrAqy6PwB
         grTS4qadiFNOCnoj9YiKGj55sFSqxTWASgiT3+3ht3qwXErGWgdAqQ7HuXIMeg7mpC3n
         6pTqX94+qeoXEZMeKZNK7EC+vxh3T+TB4KGZ5xtgrjX9H0hk/pbobp5la0qREYETW24Q
         vW15W9W2AVBAqfGsc1+u7CrC3+s5COd+Z88ez4zSWqMk+4htdlm8D4o/e1EbgaB9rGVq
         lWqgsFT/Yn8SxgeLLWUAes8ugzZAPvMam/vdMYwhMkWj/nx86H1FUzGTq4EfrjVvj/Z8
         B5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfh1fiTIk1xCjgD8sLnxJeVxqah+r7Lt/e2Er2MKweM=;
        b=C6V6u1MuSpqiXya1fxq6nxOi2R59B0ymogjcUY63P2XHaTSyKhm4qmGZOPnxTL+9Hp
         aX97t/a3djaUoraHCnYwT1+/5kw+09pMf6lHSTHDrui9/lm22Y+vcHJrSggs5Z72pNem
         85+Dqk+cNlB5svTZiB6Yw0nod2OaWyE72KF0M0Qvr1LEh/vClrLZ1x2LDRHaRxKnrClr
         TV5ZnGYpuyMrGIVkiaK1qTnGdPDPv8XU3n8jY9MjguAuuQxWePhqKzzFoyODktdsBd5i
         zwvRHFSxl96yqlIq13Ut5DGIEaSMZ7wi6ImT0JuH0ZeIK5j6SGbgpEKd314u6s5EyYYL
         aLYA==
X-Gm-Message-State: AOAM533yS/6QK0pC4bWxjJPnlzxb170n/7BWayNEBSSCugGAuZ3TWNPR
        UZthuQF0W0pMhB5Dsih7RJwvBZGQqC9mCJCpzPQQjw==
X-Google-Smtp-Source: ABdhPJwjfdeDkLrBrRvSFcoAXyHnw/ATiHEoEGj0i5O1MHzRFqMgGo1B1TzFQJmPPUjqG7SVlEr17uLDrfiUwt0vFCs=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr1774940wrd.375.1651826068090; Fri, 06
 May 2022 01:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com>
 <20220505165639.361733-14-adrian.hunter@intel.com> <CAP-5=fWKOYiOSs=TppGCD+k283rUUsexzVuJP17Pm76EMOs+xA@mail.gmail.com>
 <fed8d256-b214-e25f-9a5f-492442c4b849@intel.com>
In-Reply-To: <fed8d256-b214-e25f-9a5f-492442c4b849@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 01:34:13 -0700
Message-ID: <CAP-5=fWF=c1Hu5JaJfz4oZLg15ZQy=gqVkNc34Xphtroenfm8g@mail.gmail.com>
Subject: Re: [PATCH V1 13/23] perf evlist: Add evlist__add_system_wide_dummy()
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

On Fri, May 6, 2022 at 1:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/05/22 02:56, Ian Rogers wrote:
> > On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Add evlist__add_system_wide_dummy() to enable creating a system-wide dummy
> >> event that sets up the system-wide maps before map propagation.
> >
> > Perhaps this should be:
> > evlist__add_dummy_on_all_online_cpus()
>
> Ok, but offline isn't an option, so I'll drop 'online' from the name.

I'm not sure I follow. There can be CPUs that are offline (echo 0 >
/sys/devices/system/cpu/cpu2/online) and then brought online while
perf is running. The output obviously won't be right as we're missing
dummy events. Losing online from the name here seems to remove a
useful clue.

Thanks,
Ian

> > my thoughts being that a system wide dummy sounds like the dummy CPU
> > map, ie {-1} whilst what happens here is opening on all online CPUs
> > {0-35} on a 36 hyperthread system. Note also that the libperf
> > cpu_map__read_all_cpu_map code doesn't discover sysfs' mount properly,
> > as done in:
> > tools/lib/api/fs/fs.h
> > Some tech debt.
> >
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
> >> index 78c47cbafbc2..58ea562ddbd2 100644
> >> --- a/tools/perf/util/evlist.c
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
> >>         return 0;
> >>  }
> >>
> >> +static void evlist__add_system_wide(struct evlist *evlist, struct evsel *evsel)
> >
> > This would be:
> > evlist__add_on_all_online_cpus(..)
> >
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
> >> +               evlist__add_system_wide(evlist, evsel);
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
> >> index 4062f5aebfc1..dd1af114e033 100644
> >> --- a/tools/perf/util/evlist.h
> >> +++ b/tools/perf/util/evlist.h
> >> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
> >>  struct evsel *arch_evlist__leader(struct list_head *list);
> >>
> >>  int evlist__add_dummy(struct evlist *evlist);
> >> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> >> +static inline struct evsel *evlist__add_system_wide_dummy(struct evlist *evlist)
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
