Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABA5A82F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiHaQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiHaQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3E22BC7;
        Wed, 31 Aug 2022 09:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6C361968;
        Wed, 31 Aug 2022 16:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B6C433C1;
        Wed, 31 Aug 2022 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661962829;
        bh=ssC4Aj8Uy877AtKzbtZ5F2ELtgCjf8HUDzaC/i9iLNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnaT+7Bk0YxFbhq/ciFKdx/3qPR0hqe6CC5WUk/xhMr6GiogddXvhsdzmrFPHRsC4
         eT4xfDQn5dsK5OKqdGVItN+vUPAwz5/kF26+4XBqV8aUB2Ayd5XYGfNyiLextpvsWO
         jOc0OBHKkhgEpRxHUghGMNb1gp3Az6H2rp4K8brfwg7nCxkh46VobM/6//UOP7m+g1
         hTzNWSkNzWo8JNCmL8KO1rGrMUxRAbRfj58rUyM1Fz8F7nVbx92HqTrxXOlziMZhOo
         5DGif9bPALv3eWCn41Afzy3ejJZJskA2/TDgYGi/n9jByqPCI5xktT/rpUSv36RJMo
         g5f9iIOtR0UJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A105E404A1; Wed, 31 Aug 2022 13:20:26 -0300 (-03)
Date:   Wed, 31 Aug 2022 13:20:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 5/8] perf topology: Add core_wide
Message-ID: <Yw+KSp4+DTGuAsh2@kernel.org>
References: <20220830164846.401143-1-irogers@google.com>
 <20220830164846.401143-6-irogers@google.com>
 <Yw9y1mEW7BhNvStT@kernel.org>
 <CAP-5=fUxRMSJUemUEcrDuRXpUFj3qNiRFQz1S7=cQrvmfyGYew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUxRMSJUemUEcrDuRXpUFj3qNiRFQz1S7=cQrvmfyGYew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 31, 2022 at 08:58:49AM -0700, Ian Rogers escreveu:
> On Wed, Aug 31, 2022 at 7:40 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Aug 30, 2022 at 09:48:43AM -0700, Ian Rogers escreveu:
> > > It is possible to optimize metrics when all SMT threads (CPUs) on a
> > > core are measuring events in system wide mode. For example, TMA
> > > metrics defines CORE_CLKS for Sandybrdige as:
> > >
> > > if SMT is disabled:
> > >   CPU_CLK_UNHALTED.THREAD
> > > if SMT is enabled and recording on all SMT threads:
> > >   CPU_CLK_UNHALTED.THREAD_ANY / 2
> > > if SMT is enabled and not recording on all SMT threads:
> > >   (CPU_CLK_UNHALTED.THREAD/2)*
> > >   (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
> > >
> > > That is two more events are necessary when not gathering counts on all
> > > SMT threads. To distinguish all SMT threads on a core vs system wide
> > > (all CPUs) call the new property core wide.  Add a core wide test that
> > > determines the property from user requested CPUs, the topology and
> > > system wide. System wide is required as other processes running on a
> > > SMT thread will change the counts.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/cputopo.c | 46 +++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/cputopo.h |  3 +++
> > >  tools/perf/util/smt.c     | 14 ++++++++++++
> > >  tools/perf/util/smt.h     |  7 ++++++
> > >  4 files changed, 70 insertions(+)
> > >
> > > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > > index 511002e52714..1a3ff6449158 100644
> > > --- a/tools/perf/util/cputopo.c
> > > +++ b/tools/perf/util/cputopo.c
> > > @@ -172,6 +172,52 @@ bool cpu_topology__smt_on(const struct cpu_topology *topology)
> > >       return false;
> > >  }
> > >
> > > +bool cpu_topology__core_wide(const struct cpu_topology *topology,
> > > +                          const char *user_requested_cpu_list)
> > > +{
> > > +     struct perf_cpu_map *user_requested_cpus;
> > > +
> > > +     /*
> > > +      * If user_requested_cpu_list is empty then all CPUs are recorded and so
> > > +      * core_wide is true.
> > > +      */
> > > +     if (!user_requested_cpu_list)
> > > +             return true;
> > > +
> > > +     user_requested_cpus = perf_cpu_map__new(user_requested_cpu_list);
> >
> > Don't we need a NULL test here?

> No, NULL is a valid perf_cpu_map, one with no values in it. For
> example, see here:

But in this specific case, if perf_cpu_map__new() returns NULL, its
because it failed to parse user_requested_cpu_list, so checking against
NULL is valid, no?

- Arnaldo

> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n266
> So there's no way to tell an error (ENOMEM) from an empty map. My
> suggestion is a rewrite of perf_cpu_map, I'd like to do this in a new
> "libperf2" which has a more permissive than GPL license like libbpf.
> That is out-of-scope here.
 
> Thanks,
> Ian
> 
> > > +     /* Check that every user requested CPU is the complete set of SMT threads on a core. */
> > > +     for (u32 i = 0; i < topology->core_cpus_lists; i++) {
> > > +             const char *core_cpu_list = topology->core_cpus_list[i];
> > > +             struct perf_cpu_map *core_cpus = perf_cpu_map__new(core_cpu_list);
> >
> > Here too, no?
> >
> > > +             struct perf_cpu cpu;
> > > +             int idx;
> > > +             bool has_first, first = true;
> > > +
> > > +             perf_cpu_map__for_each_cpu(cpu, idx, core_cpus) {
> > > +                     if (first) {
> > > +                             has_first = perf_cpu_map__has(user_requested_cpus, cpu);
> > > +                             first = false;
> > > +                     } else {
> > > +                             /*
> > > +                              * If the first core CPU is user requested then
> > > +                              * all subsequent CPUs in the core must be user
> > > +                              * requested too. If the first CPU isn't user
> > > +                              * requested then none of the others must be
> > > +                              * too.
> > > +                              */
> > > +                             if (perf_cpu_map__has(user_requested_cpus, cpu) != has_first) {
> > > +                                     perf_cpu_map__put(core_cpus);
> > > +                                     perf_cpu_map__put(user_requested_cpus);
> > > +                                     return false;
> > > +                             }
> > > +                     }
> > > +             }
> > > +             perf_cpu_map__put(core_cpus);
> > > +     }
> > > +     perf_cpu_map__put(user_requested_cpus);
> > > +     return true;
> > > +}
> > > +
> > >  static bool has_die_topology(void)
> > >  {
> > >       char filename[MAXPATHLEN];
> > > diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
> > > index 469db775a13c..969e5920a00e 100644
> > > --- a/tools/perf/util/cputopo.h
> > > +++ b/tools/perf/util/cputopo.h
> > > @@ -60,6 +60,9 @@ struct cpu_topology *cpu_topology__new(void);
> > >  void cpu_topology__delete(struct cpu_topology *tp);
> > >  /* Determine from the core list whether SMT was enabled. */
> > >  bool cpu_topology__smt_on(const struct cpu_topology *topology);
> > > +/* Are the sets of SMT siblings all enabled or all disabled in user_requested_cpus. */
> > > +bool cpu_topology__core_wide(const struct cpu_topology *topology,
> > > +                          const char *user_requested_cpu_list);
> > >
> > >  struct numa_topology *numa_topology__new(void);
> > >  void numa_topology__delete(struct numa_topology *tp);
> > > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > > index ce90c4ee4138..994e9e418227 100644
> > > --- a/tools/perf/util/smt.c
> > > +++ b/tools/perf/util/smt.c
> > > @@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
> > >       cached = true;
> > >       return cached_result;
> > >  }
> > > +
> > > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > > +            const struct cpu_topology *topology)
> > > +{
> > > +     /* If not everything running on a core is being recorded then we can't use core_wide. */
> > > +     if (!system_wide)
> > > +             return false;
> > > +
> > > +     /* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
> > > +     if (!smt_on(topology))
> > > +             return true;
> > > +
> > > +     return cpu_topology__core_wide(topology, user_requested_cpu_list);
> > > +}
> > > diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
> > > index e26999c6b8d4..ae9095f2c38c 100644
> > > --- a/tools/perf/util/smt.h
> > > +++ b/tools/perf/util/smt.h
> > > @@ -7,4 +7,11 @@ struct cpu_topology;
> > >  /* Returns true if SMT (aka hyperthreading) is enabled. */
> > >  bool smt_on(const struct cpu_topology *topology);
> > >
> > > +/*
> > > + * Returns true when system wide and all SMT threads for a core are in the
> > > + * user_requested_cpus map.
> > > + */
> > > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > > +            const struct cpu_topology *topology);
> > > +
> > >  #endif /* __SMT_H */
> > > --
> > > 2.37.2.672.g94769d06f0-goog
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
