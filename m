Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9374B2B43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbiBKRE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:04:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiBKREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:04:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CD2E8;
        Fri, 11 Feb 2022 09:04:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D405B828ED;
        Fri, 11 Feb 2022 17:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36733C340ED;
        Fri, 11 Feb 2022 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644599060;
        bh=jq+JT3HFl251HwYt9ZbjwRY1pR4WKBYx4AFM1bWHGKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7pISgi1qI8QmKqCEL9DlkWizqtzF+DW0cfw4WVsdQV4NZmDq3r20rycIFkpdQe9T
         vGKLBNXJmerWRhyiFaFUeeiPxKlgPsoD50PalVG0ETNf2LX/KWKWkXACUf00j8iwAu
         3DWGQbELIaLQN4vbPutoTKinJIwTNzBPxMI23UcnflfeUhVl6wsPsQt9ZmOmHjJMj3
         VFALYVx7bhvwU/lWeM4gl7zb6GR9TPFxmrQU/ZxSLvXMfjHacvj4A0Mx63xge6qb+o
         zC0PUt2SCrLj51EC7toYEMY4v+qDquIkuvA5JRFOpzykjng6FzO/JWoIZepO5GKM/u
         JUqzrY1MbWGRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 55842400FE; Fri, 11 Feb 2022 14:04:18 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:04:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 02/22] perf cpumap: Use for each loop
Message-ID: <YgaXEo6pOolljvo5@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-3-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:33:55AM -0800, Ian Rogers escreveu:
> Improve readability in perf_pmu__cpus_match by using
> perf_cpu_map__for_each_cpu.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8dfbba15aeb8..9a1c7e63e663 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1998,7 +1998,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>  {
>  	struct perf_cpu_map *pmu_cpus = pmu->cpus;
>  	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> -	int matched_nr = 0, unmatched_nr = 0;
> +	struct perf_cpu cpu;
> +	int i, matched_nr = 0, unmatched_nr = 0;
>  
>  	matched_cpus = perf_cpu_map__default_new();
>  	if (!matched_cpus)
> @@ -2010,14 +2011,11 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>  		return -1;
>  	}
>  
> -	for (int i = 0; i < cpus->nr; i++) {
> -		int cpu;
> -
> -		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
> -		if (cpu == -1)
> -			unmatched_cpus->map[unmatched_nr++] = cpus->map[i];
> +	perf_cpu_map__for_each_cpu(cpu, i, cpus) {

I'm applying this patch, but I wonder if we couldn't remove the need for
pre-declaring the integer iterator, so that the previous patch hunk
wouldn't be needed.

> +		if (!perf_cpu_map__has(pmu_cpus, cpu))
> +			unmatched_cpus->map[unmatched_nr++] = cpu;
>  		else
> -			matched_cpus->map[matched_nr++] = cpus->map[i];
> +			matched_cpus->map[matched_nr++] = cpu;
>  	}
>  
>  	unmatched_cpus->nr = unmatched_nr;
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
