Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6295173D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiEBQMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbiEBQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:12:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88CDEFB;
        Mon,  2 May 2022 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651507761; x=1683043761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HIEm6DHONqf1fh3RVxZ900oiPNIDtiHGMYYJWK8XUcg=;
  b=Q4w7ye9PAR2TVYI9BijEFAPzOy/MfHnyE2ylzEfcl0PBTbv2obfr7TeG
   TvXyF1oWFrZunnfULG/p91ktPcxB+owr5lxrvdEgL6zC5AFP9I7CYdSyJ
   3SuOIkvVF6fXCfJ3LFqskXgklXcGOZD4o27VCQDxFqWb5OYRHlLWxoy0/
   /EySVOxmwbI0Dn5kVmYzUtpr7k5yzPw11kVggf8hZh5oNYA2OqQTJ0vh8
   +teExmAEehtd8JwQL4WJN+yOTlM+FrOxgkeGrh5tEtoCvc4IiH6qW89ir
   nQ6C/RjeLX7VEV2tXr6qov7f5I6y58OEEZYxdNyM5BoyjLWCQNZzJHXNr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330241183"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330241183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:09:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583770530"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:09:13 -0700
Message-ID: <8510a140-e2e2-39ce-b344-b456f069a9d0@intel.com>
Date:   Mon, 2 May 2022 19:09:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/6] perf stat: Avoid printing cpus with no counters
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220430062324.1565215-1-irogers@google.com>
 <20220430062324.1565215-4-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220430062324.1565215-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/22 09:23, Ian Rogers wrote:
> perf_evlist's user_requested_cpus can contain CPUs not present in any
> evsel's cpus, for example uncore counters. Avoid printing the prefix and
> trailing \n until the first valid counter is encountered.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

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

