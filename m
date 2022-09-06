Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166995AF3FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIFS42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIFS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:56:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633B578BA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:56:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bz13so13417851wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mVD0IDf4vFuc1b0w2Rkf2gOwBBGFdMNZB9N2hm12IS4=;
        b=LCuCg21uszaecDuXsrJyrMIKNi1K6QOXw6VYNepdmduxP1UzFltTJfd8d/HyQh0rXN
         zc7i4x5QdcEhoMawRzcrJBtyuUMb9TdffNUI/7F4Xi0QT1UO3mPtnK5ti60T/0bLJ97F
         4rq9F+iK9XoM3qHP9gql5pOjvfAlaJPLYYWvpzcOIqmNg9dezfNuQQTQVnwfpGZAyyDk
         r0Qd+T3D+IjGFxZD0wP0XxhC4CWrBZzhbmJa/kU2D+1KiZxvImjzhED3f9tFADx+f4up
         6oIOSVfXRag72JHXGqZRqd/izVhcRbFOvik8OWohAngd1NnnBkmBABVWZUi+6xjgUGSQ
         5h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mVD0IDf4vFuc1b0w2Rkf2gOwBBGFdMNZB9N2hm12IS4=;
        b=TMfTR2XRZn7Nw2+kbYlBY7O5YsNLMueRCzuVcJ8AyZ1G2hvjbOnk3x0epvWd10IjCl
         7rKQ6y4d8fWUMuzDKS0X7VNcyt6qlygSApVEpSTj2hDN3ZOFcInBM25s4crInylmsRjW
         uTJ2JJizFO3/o1R87MOlvGXOXSNclEmaY3IRZ2aGPdiarzosfbDxNJNokjokX0iz02k+
         N/gJTJVajWYdwpz4T/RCvVMduz2tXrCImQP5dAIjDIIX2Q3g9GBCz7K3VN2JNAhP8+YP
         A2wnRCUinhmoiaeTJU1TX120jyuzTscgbEmpEFSgL0YkyZgh2t90A2TZKl3DVrg/ATLd
         0B0w==
X-Gm-Message-State: ACgBeo2D2ohdokgzqGstD/q5PZ7mh9a3w0/8ZgCHJ7nA5Jkd4wzPVLeR
        7qvACBjNxtVfxzy3uO+4wvAHy0GcHT9NjfUjewGUNA==
X-Google-Smtp-Source: AA6agR46hahzJdc5E/HR0uJwAe8S3ikQpAgzLEBcoGGKWuG3OQhIWkIxCuk4qcbCn3AiJDMZXfOaXhvFvCMFvCeOYCk=
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr2849133wrm.300.1662490580638; Tue, 06
 Sep 2022 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com> <20220831174926.579643-5-irogers@google.com>
 <CAM9d7cgRb6_jFXCfoZZ+=K5WSH42hj4U2ZH-i-4oZTMKw+LAiA@mail.gmail.com>
In-Reply-To: <CAM9d7cgRb6_jFXCfoZZ+=K5WSH42hj4U2ZH-i-4oZTMKw+LAiA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Sep 2022 11:56:08 -0700
Message-ID: <CAP-5=fXVE+vLB2GN9pkvfj4jLa2Bdg6LY24yFtZ+ix5bP9QGpQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] perf topology: Add core_wide
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com,
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

On Thu, Sep 1, 2022 at 11:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Wed, Aug 31, 2022 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> >
> > It is possible to optimize metrics when all SMT threads (CPUs) on a
> > core are measuring events in system wide mode. For example, TMA
> > metrics defines CORE_CLKS for Sandybrdige as:
> >
> > if SMT is disabled:
> >   CPU_CLK_UNHALTED.THREAD
> > if SMT is enabled and recording on all SMT threads:
> >   CPU_CLK_UNHALTED.THREAD_ANY / 2
> > if SMT is enabled and not recording on all SMT threads:
> >   (CPU_CLK_UNHALTED.THREAD/2)*
> >   (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
> >
> > That is two more events are necessary when not gathering counts on all
> > SMT threads. To distinguish all SMT threads on a core vs system wide
> > (all CPUs) call the new property core wide.  Add a core wide test that
> > determines the property from user requested CPUs, the topology and
> > system wide. System wide is required as other processes running on a
> > SMT thread will change the counts.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > index ce90c4ee4138..994e9e418227 100644
> > --- a/tools/perf/util/smt.c
> > +++ b/tools/perf/util/smt.c
> > @@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
> >         cached = true;
> >         return cached_result;
> >  }
> > +
> > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > +              const struct cpu_topology *topology)
> > +{
> > +       /* If not everything running on a core is being recorded then we can't use core_wide. */
> > +       if (!system_wide)
> > +               return false;
>
> I'm not sure if it's correct.  Wouldn't it be ok if it runs on all
> threads in a core
> even if system wide is off?  I thought that's what the below code checks.
>
> In fact I thought the opposite logic like
>
>     if (system_wide)
>         return true;
>
> But it seems the code allows to have cpu_list in the system wide mode.
> Then it also needs to check the user requested cpus being NULL.
> (IMHO system_wide should be cleared when it has a cpu list...)
>
>     if (system_wide && !user_requested_cpu_list)
>         return true;
>
> And if we have a target pointer, we could add this too.
>
>     if (!target__has_cpu(target))
>         return false;
>
> Thanks,
> Namhyung

Thanks Namhyung,

It may be correct or may not be without the system wide flag, and so I
want to be conservative and say we need the flag. Let me provide more
detail with an example:

I'm going to assume we want to measure how many slots there were for
an SMT thread. In the "Count Domain" of TMA metrics before Icelake
slots is a core wide metric, meaning that you are measuring >1 hyper
thread. As we are measuring >1 hyper thread and we don't control the
scheduling of the other hyperthread, the only valid mode is system
wide on all CPUs, or all CPUs on a core (aka core wide in this patch
set). However, the slots count domain information also says "Slots -
ICL onwards or EBS_Mode before ICL" meaning the count domain is valid
for an SMT thread. If I look at SkylakeX currently we have two
metrics:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json?h=perf/core#n167

    {
       "BriefDescription": "Total issue-pipeline slots (per-Physical
Core till ICL; per-Logical Processor ICL onward)",
       "MetricExpr": "4 * CPU_CLK_UNHALTED.THREAD",
       "MetricGroup": "TmaL1",
       "MetricName": "SLOTS"
   },
   {
       "BriefDescription": "Total issue-pipeline slots (per-Physical
Core till ICL; per-Logical Processor ICL onward)",
       "MetricExpr": "4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
       "MetricGroup": "TmaL1_SMT",
       "MetricName": "SLOTS_SMT"
   },

The SLOTS metrics is going to compute a valid value if hyperthreading
is disabled, in other metrics you will see
(CPU_CLK_UNHALTED.THREAD_ANY / 2) where THREAD.ANY and THREAD are the
same event encoding. The reason for the divide by 2 is to adjust the
count down so that when we add the other hyperthreads count we get the
core wide value in the aggregation - the perf event on the 2nd hyper
thread isn't necessary, but that's a separate problem. SLOTS_SMT is
funny so let's dig into it:
The 4 is the pipeline width.
CPU_CLK_UNHALTED.THREAD is defined as, "Counts the number of core
cycles while the thread is not in a halt state.."
The divide by 2 is because of 2 hyperthreads.
The 1 is because we assume that half the slots are going to be given
to our hyperthread.
The CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK
will give a ratio for how many cycles our SMT thread was the only one
running, and so we got those slots from the other hyperthread.

With #core_wide we can have a single SLOTS metric of (new lines and //
comments for clarity):

// If we're #core_wide with SMT and we know the work on both
hyperthreads are being measured for all processes then use a single
counter
(4 * CPU_CLK_UNHALTED.THREAD_ANY / 2
  if #core_wide else
// We're not core wide so we need thread counters to adjust the slots
metric based on the time this SMT thread is active
  4 * ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )
) if #smt_on
// No hyper threading can just use the core wide counter
else 4 * CPU_CLK_UNHALTED.THREAD

As this metric is a foundation for many others then there is a great
deal of use for it and the current pre-Icelake computation is
generally only valid if on the command line you happen to have
specified a core wide set up - which is error prone.

Thanks,
Ian



> > +
> > +       /* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
> > +       if (!smt_on(topology))
> > +               return true;
> > +
> > +       return cpu_topology__core_wide(topology, user_requested_cpu_list);
> > +}
> > diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
> > index e26999c6b8d4..ae9095f2c38c 100644
> > --- a/tools/perf/util/smt.h
> > +++ b/tools/perf/util/smt.h
> > @@ -7,4 +7,11 @@ struct cpu_topology;
> >  /* Returns true if SMT (aka hyperthreading) is enabled. */
> >  bool smt_on(const struct cpu_topology *topology);
> >
> > +/*
> > + * Returns true when system wide and all SMT threads for a core are in the
> > + * user_requested_cpus map.
> > + */
> > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > +              const struct cpu_topology *topology);
> > +
> >  #endif /* __SMT_H */
> > --
> > 2.37.2.672.g94769d06f0-goog
> >
