Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DE488BA4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiAISax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 13:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236493AbiAISau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 13:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641753050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYvOwjwqFrDqfGP5yZ04n7pfG3rcdHLdCFAeOhb9uKU=;
        b=TxedaNfUg4zpuGBxnuRVDp87bu2s/GIMFNZf4fRCiWZendYTgCmHKbEYiwiNTETX3n675U
        tr6gp1LZ/UOVuRMcO7xBBE7bYMbTAaH7otavlnW7gtlOtlvGCrc8Sz4rsKwoaNo3ROeiXL
        qPxJ61Gat4DoBHxKg2A0ljJQukz5B7U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658--qJ5kWvvOzGu0j72tzuB_Q-1; Sun, 09 Jan 2022 13:30:49 -0500
X-MC-Unique: -qJ5kWvvOzGu0j72tzuB_Q-1
Received: by mail-ed1-f72.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so8481766edc.18
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 10:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYvOwjwqFrDqfGP5yZ04n7pfG3rcdHLdCFAeOhb9uKU=;
        b=PzRFVfT3gjSBUG/xjqaS3fpjlg+AtknGxYUTuVfdP4/YqBx/ebVMO9CFtnGck8vB06
         gaETcTViX1/cyy92vJLYifvC8+xXuyxC7I7AhKkY8GqXoMmOr3Ff/5Cvayw+l9PkpVxS
         ZgaoHvPlxz+n8z2yv1VV9TWWBnXGrupH+AABRbybEvat0uzibElV7HFL30zBWbanYIbw
         3oWAvetMv6BxpIIkepVpVwYcbOlHheMoCJGlgKmfAN2St2ztFuNh8+3H48MPUjNcx5L+
         1PMjZ1KqJ4IIeMxdhV/QGQzFo/dsZMjWVPTpqy0kc9TSJ8GIxFdrvOoStUG403pnNiL8
         VRQA==
X-Gm-Message-State: AOAM532fAv/eLYxpU+5qTzhpqMlYETD0qfcGQl/YeIjc3+Uc3Y91BfHS
        9bDKA7F6abwcINNP7OK456nvJVx4ghX5IqVsit7fSf6ck+ZSKmVICLHiu3O9C6stRVCSTNZlr4Q
        ZaZwXlehgbZNk6At8koCflzeg
X-Received: by 2002:a17:907:97c7:: with SMTP id js7mr54984093ejc.84.1641753048061;
        Sun, 09 Jan 2022 10:30:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyV85a35OqUpicNWJWT5Lo2uyafytuFeApaXBkbpEfniiZMeOk+K5aqzwQAeklDfmJPYVfVRA==
X-Received: by 2002:a17:907:97c7:: with SMTP id js7mr54984064ejc.84.1641753047877;
        Sun, 09 Jan 2022 10:30:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o25sm2376412edr.20.2022.01.09.10.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 10:30:47 -0800 (PST)
Date:   Sun, 9 Jan 2022 19:30:45 +0100
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
Subject: Re: [PATCH v4 26/48] perf evsel: Derive CPUs and threads in
 alloc_counts
Message-ID: <Ydsp1d58t/gp/GHd@krava>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-27-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105061351.120843-27-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:13:29PM -0800, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> index 7ff36bf6d644..3e275e9c60d1 100644
> --- a/tools/perf/util/counts.h
> +++ b/tools/perf/util/counts.h
> @@ -40,7 +40,7 @@ void perf_counts__delete(struct perf_counts *counts);
>  void perf_counts__reset(struct perf_counts *counts);
>  
>  void evsel__reset_counts(struct evsel *evsel);
> -int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
> +int evsel__alloc_counts(struct evsel *evsel);
>  void evsel__free_counts(struct evsel *evsel);
>  
>  #endif /* __PERF_COUNTS_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 656c30b988ce..6c9af21776e6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1578,7 +1578,7 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
>  	if (FD(evsel, cpu, thread) < 0)
>  		return -EINVAL;
>  
> -	if (evsel->counts == NULL && evsel__alloc_counts(evsel, cpu + 1, thread + 1) < 0)
> +	if (evsel->counts == NULL && evsel__alloc_counts(evsel) < 0)

ugh, nice.. good that it's used only from test code ;-)

btw I noticed evsel__read_on_cpu_scaled is not used at all

jirka

>  		return -ENOMEM;
>  
>  	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index c69b221f5e3e..995cb5003133 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -152,11 +152,13 @@ static void evsel__free_stat_priv(struct evsel *evsel)
>  	zfree(&evsel->stats);
>  }
>  
> -static int evsel__alloc_prev_raw_counts(struct evsel *evsel, int ncpus, int nthreads)
> +static int evsel__alloc_prev_raw_counts(struct evsel *evsel)
>  {
> +	int cpu_map_nr = evsel__nr_cpus(evsel);
> +	int nthreads = perf_thread_map__nr(evsel->core.threads);
>  	struct perf_counts *counts;
>  
> -	counts = perf_counts__new(ncpus, nthreads);
> +	counts = perf_counts__new(cpu_map_nr, nthreads);
>  	if (counts)
>  		evsel->prev_raw_counts = counts;
>  
> @@ -177,12 +179,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
>  
>  static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
>  {
> -	int ncpus = evsel__nr_cpus(evsel);
> -	int nthreads = perf_thread_map__nr(evsel->core.threads);
> -
>  	if (evsel__alloc_stat_priv(evsel) < 0 ||
> -	    evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
> -	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel, ncpus, nthreads) < 0))
> +	    evsel__alloc_counts(evsel) < 0 ||
> +	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
>  		return -ENOMEM;
>  
>  	return 0;
> -- 
> 2.34.1.448.ga2b2bfdf31-goog
> 

