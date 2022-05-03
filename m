Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A31518677
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiECOXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiECOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:23:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357529C83;
        Tue,  3 May 2022 07:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B59F3B81ED0;
        Tue,  3 May 2022 14:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F756C385A9;
        Tue,  3 May 2022 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651587593;
        bh=m1gj6+3YfWLYuNch8icQuX4tVXD7bLAGeCx2hhQWcR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8qJWPmO2q681rj2MA+bg8H/9W6AW9+bcV6+a2yCVtViK8mh1+5HcIy3vvobjB5Ia
         6ml6Ynv74RDdAZ4/ZTrJTdiR7U83U6F/k2cg94zwdjIyRCQk6j2MNDfj+a6n3DYesC
         m1XxpA6fNnBLWTuLhgyJagOgKDdBR32OIwL/FZh8ZZKAokNn249IAVUcqiGkDubu/O
         5GovoMTqBIl2Kw7iznCFz5WSFDAZjyYnegFKltO48Vpjqw4dGLjGxlBk5JlGTLPU2Z
         IXVGMLYKeR/ApV8uQOnhDFBCu9PlJciF34irgX+kjDatLajzFaBPo0i8x4AcjBKEQ2
         m0LGo2NXTVDDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6298400B1; Tue,  3 May 2022 11:19:50 -0300 (-03)
Date:   Tue, 3 May 2022 11:19:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 3/6] perf stat: Avoid printing cpus with no counters
Message-ID: <YnE6Bvju43ohfFip@kernel.org>
References: <20220503041757.2365696-1-irogers@google.com>
 <20220503041757.2365696-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503041757.2365696-4-irogers@google.com>
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

Em Mon, May 02, 2022 at 09:17:54PM -0700, Ian Rogers escreveu:
> perf_evlist's user_requested_cpus can contain CPUs not present in any
> evsel's cpus, for example uncore counters. Avoid printing the prefix and
> trailing \n until the first valid counter is encountered.
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


Thanks, applied.

- Arnaldo


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index d9629a83aa78..13f705737367 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -948,8 +948,6 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  		struct evsel *counter;
>  		bool first = true;
>  
> -		if (prefix)
> -			fputs(prefix, config->output);
>  		evlist__for_each_entry(evlist, counter) {
>  			u64 ena, run, val;
>  			double uval;
> @@ -961,6 +959,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  
>  			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>  			if (first) {
> +				if (prefix)
> +					fputs(prefix, config->output);
>  				aggr_printout(config, counter, id, 0);
>  				first = false;
>  			}
> @@ -972,7 +972,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  			printout(config, id, 0, counter, uval, prefix,
>  				 run, ena, 1.0, &rt_stat);
>  		}
> -		fputc('\n', config->output);
> +		if (!first)
> +			fputc('\n', config->output);
>  	}
>  }
>  
> -- 
> 2.36.0.464.gb9c8b46e94-goog

-- 

- Arnaldo
