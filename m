Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA3A484334
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiADOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbiADOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641305982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztPwQbcR7E3FSo8LAE3RE42xQfVhZkttEdVXnDtSjVo=;
        b=OsnpFKjPIsxCVdPiq+qCZ4V1iHxzJOKOf4GPj/JTpPgEqkBTqLWm/OAjsfY1PVlU4MyDrS
        jWGCywiyCfNKRll/K5dpTcGOy39NnNyTlf7+hs6C+l2cVLoJDJszVf9Cz+SK36UmOs/Mi5
        juxcRqau0p4K0DMVaTsPYfJoSRZvoDg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-6FE84vvENP6uuTnMoQBmDw-1; Tue, 04 Jan 2022 09:19:39 -0500
X-MC-Unique: 6FE84vvENP6uuTnMoQBmDw-1
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a056402520700b003f841380832so25353391edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztPwQbcR7E3FSo8LAE3RE42xQfVhZkttEdVXnDtSjVo=;
        b=V0/lRh42ybkS3R/20NL01MKJPJAjFQZAQlw2hGgA6NUuGGvFygmT+sq98NouzXX0yx
         gQQFOhRDQWkqDcYLE9eEssN2gMgtvLZYJF1uo9DcxYOFvszNCliSfWFG8DR1KS1UeunY
         uRJ2KbcqZLE5/fasKuSLLbM9DKokrbh/c7uW/JHyirNGYdg2/m6x0+eZ3Geaw4EOfuoX
         uncXuca+IJt3gi4mFX2dqySr94Vze2YE2Ho+Niv3BAHBKhfpD3n3LrslgojrqOdZS7fD
         iYhR14XBgypEeYFpzflf4IhILO62dnrVb5L+C2ciz6mlnjzdjDIpzFS2ISmOZdKNUKl2
         1/VA==
X-Gm-Message-State: AOAM5325i+U81s/fs2uWS65TrDpAyWVPw873+ZA4+pkqhB+lw+X2tRRw
        JrfT8C8rDw2OOoqRLSr1DBICVVD8BCvEQqu6KDfH+DlETYaEdqxPPe66dw0+23FaqCOQV6blnxx
        wzM56gPVR5upGd6QwI/d9fVkM
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr41650578ejc.189.1641305978286;
        Tue, 04 Jan 2022 06:19:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiJHqaCQNImwOzgATU/PasDtEuAT2Pa4ZJzVW95oxpDZvx/sCFqJMS8e58GPQQ4vQKElCjaQ==
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr41650554ejc.189.1641305978060;
        Tue, 04 Jan 2022 06:19:38 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 2sm4252772ejx.123.2022.01.04.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:19:37 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:19:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v3 03/48] perf stat: Correct aggregation CPU map
Message-ID: <YdRXd4jBUfduSSAY@krava>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230072030.302559-5-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 11:19:45PM -0800, Ian Rogers wrote:
> Switch the perf_cpu_map in aggr_update_shadow from
> the evlist to the counter's cpu map, so the index is appropriate. This
> addresses a problem where uncore counts, with a cpumap like:
> $ cat /sys/devices/uncore_imc_0/cpumask
> 0,18
> Don't aggregate counts in CPUs based on the index of those values in the
> cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
> metric calculations in per-socket mode for counters without a full
> cpumask.
> 
> On a SkylakeX with a tweaked DRAM_BW_Use metric, to remove unnecessary
> scaling, this gives:
> 
> Before:
> $ /perf stat --per-socket -M DRAM_BW_Use -I 1000
>      1.001102293 S0        1              27.01 MiB  uncore_imc/cas_count_write/ #   103.00 DRAM_BW_Use
>      1.001102293 S0        1              30.22 MiB  uncore_imc/cas_count_read/
>      1.001102293 S0        1      1,001,102,293 ns   duration_time
>      1.001102293 S1        1              20.10 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
>      1.001102293 S1        1              32.74 MiB  uncore_imc/cas_count_read/
>      1.001102293 S1        0      <not counted> ns   duration_time
>      2.003517973 S0        1              83.04 MiB  uncore_imc/cas_count_write/ #   920.00 DRAM_BW_Use
>      2.003517973 S0        1             145.95 MiB  uncore_imc/cas_count_read/
>      2.003517973 S0        1      1,002,415,680 ns   duration_time
>      2.003517973 S1        1             302.45 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
>      2.003517973 S1        1             290.99 MiB  uncore_imc/cas_count_read/
>      2.003517973 S1        0      <not counted> ns   duration_time
> 
> After:
> $ perf stat --per-socket -M DRAM_BW_Use -I 1000
>      1.001080840 S0        1              24.96 MiB  uncore_imc/cas_count_write/ #    54.00 DRAM_BW_Use
>      1.001080840 S0        1              33.64 MiB  uncore_imc/cas_count_read/
>      1.001080840 S0        1      1,001,080,840 ns   duration_time
>      1.001080840 S1        1              42.43 MiB  uncore_imc/cas_count_write/ #    84.00 DRAM_BW_Use
>      1.001080840 S1        1              47.05 MiB  uncore_imc/cas_count_read/
>      1.001080840 S1        0      <not counted> ns   duration_time
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 588601000f3f..b0fa81ffce61 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -526,7 +526,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
>  		evlist__for_each_entry(evlist, counter) {
>  			val = 0;
>  			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
> -				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
> +				s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
>  				if (!cpu_map__compare_aggr_cpu_id(s2, id))
>  					continue;
>  				val += perf_counts(counter->counts, cpu, 0)->val;

makes sense, there's another instance of this in first_shadow_cpu

thanks,
jirka

> -- 
> 2.34.1.448.ga2b2bfdf31-goog
> 

