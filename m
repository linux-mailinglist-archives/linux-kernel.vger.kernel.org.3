Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D794715A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhLKTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:25:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231861AbhLKTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639250699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCtUaBAOzyXY3KXXR3aZzZQ4AfKFricrW8TE0Pl7r9c=;
        b=Ot3+3ZwVVyL8rPLGllD4Udd66XjeTpnTJvM5Z9wWTjK54TUfl9YWUFsXR4z+JQygB2bBOH
        cK3RcbqfNF5BWQU+5n4OpvCrGoSdGRPopjpwabJk/1+Qi+FTHPG4ASFH1AzkjUu+hvVk4W
        9YMSkGA5oKAg9CVpukk+oW121ogvjjc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-268-NtQhIRLwOPGh0KQaulXaRA-1; Sat, 11 Dec 2021 14:24:58 -0500
X-MC-Unique: NtQhIRLwOPGh0KQaulXaRA-1
Received: by mail-wm1-f71.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso7034975wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 11:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCtUaBAOzyXY3KXXR3aZzZQ4AfKFricrW8TE0Pl7r9c=;
        b=uSpceG1bP3nFfI13WAwp0ycfRZ0XXxOint/KzP5MAyt5JLEwNye9ICpKbY7e5Mp6in
         JdDgoxpiAa4cthqKiPiXS4Ueejvirognl24cFduuSez7TSIT7Cly0gi4d7l8ew0Igrqq
         THWZYcvY1q/d1uaf/49fcgYo1IjS282bV92WKaeAQtU9rGcCoLsQAFmpsnsh/2q8Qxf6
         8boTl3vuW0LDTZAWDulmsvVxCWZaHnRMlmeKatlMVYUxVrUxy/g+xA1OBHC0GgZIoMb8
         f8GwsCwEY+y+cZm2+brUAVvY48YeezdnjUluDWx3wF+m6i1EUE0Z2IHfsChv5eXGxX0j
         2AsA==
X-Gm-Message-State: AOAM5300WMIvVbalRiw7BV7qj2W4SMsbFAyFi1n3a5ziBp9jpP+LrDma
        vghHmx5suia9cWV3+338qBOvFJOuTDn30eQcUveU+uZFId9H4zdc8XrcmeZPflLnWu0bbOzoOaY
        5n4qXMgDXYu1YUpHHDcB0Eqrh
X-Received: by 2002:a5d:4107:: with SMTP id l7mr21737548wrp.209.1639250697296;
        Sat, 11 Dec 2021 11:24:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9I/tj/f+gGo2zMIx5mkdqIEGB0qOPQDR8i8T0zr5AELbrNeig84rZPb11rSNDGxbEebTbqw==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr21737534wrp.209.1639250697085;
        Sat, 11 Dec 2021 11:24:57 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id bg34sm2228709wmb.47.2021.12.11.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:24:56 -0800 (PST)
Date:   Sat, 11 Dec 2021 20:24:54 +0100
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
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Subject: Re: [PATCH 03/22] perf stat: Switch aggregation to use for_each loop
Message-ID: <YbT7Bg3KA/re1HAF@krava>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208024607.1784932-4-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:45:48PM -0800, Ian Rogers wrote:
> Tidy up the use of cpu and index to hopefully make the code less error
> prone. Avoid unused warnings with (void) which will be removed in a
> later patch.
> 
> In aggr_update_shadow, the perf_cpu_map is switched from
> the evlist to the counter's cpu map, so the index is appropriate. This
> addresses a problem where uncore counts, with a cpumap like:
> $ cat /sys/devices/uncore_imc_0/cpumask
> 0,18
> Don't aggregate counts in CPUs based on the index of those values in the
> cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
> metric calculations in per-socket mode for counters with without a full
> cpumask.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 48 +++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 588601000f3f..efab39a759ff 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -330,8 +330,8 @@ static void print_metric_header(struct perf_stat_config *config,
>  static int first_shadow_cpu(struct perf_stat_config *config,
>  			    struct evsel *evsel, struct aggr_cpu_id id)
>  {
> -	struct evlist *evlist = evsel->evlist;
> -	int i;
> +	struct perf_cpu_map *cpus;
> +	int cpu, idx;
>  
>  	if (config->aggr_mode == AGGR_NONE)
>  		return id.core;
> @@ -339,14 +339,11 @@ static int first_shadow_cpu(struct perf_stat_config *config,
>  	if (!config->aggr_get_id)
>  		return 0;
>  
> -	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
> -		int cpu2 = evsel__cpus(evsel)->map[i];
> -
> -		if (cpu_map__compare_aggr_cpu_id(
> -					config->aggr_get_id(config, evlist->core.cpus, cpu2),
> -					id)) {
> -			return cpu2;
> -		}
> +	cpus = evsel__cpus(evsel);
> +	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> +		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
> +						 id))
> +			return cpu;

so this looks strange, you pass idx instead of cpu2 to aggr_get_id,
which takes idx as 3rd argument, so it looks like it was broken now,
should this be a separate fix?

also the original code for some reason passed evlist->core.cpus
to aggr_get_id, which might differ rom evsel's cpus

same for aggr_update_shadow change

jirka

