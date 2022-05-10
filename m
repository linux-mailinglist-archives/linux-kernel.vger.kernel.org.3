Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1481F522233
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347484AbiEJRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEJRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480E2685DC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B638F618CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1325C385C8;
        Tue, 10 May 2022 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203175;
        bh=Y/QxQyHGxCO9RRfcjtnD+iK8WeMCV9qey4TqYl8ZPPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvrdF9mSZvXqll1j3WV6sJ0ESRqcWWq1tZdq6rg8s28Eh5EXmgunJdflCZfJ1yEMj
         BWt5JO4zI4NaXXP7UR+GmSE6hrFYP5fBsqjCeIetxk0SfqoOHZEaLnb/E2ERhBu65E
         2GAhbaeiW42no7gNPpWB0DAOKJ7l6jlS53sx+CH7vHgixY5fLRYdvskPs71FZcHZfH
         +mcnXFsXogEHmRYHluTAqCq7hxHa7dSKXHVikrZm8Go+mF76TyhhuoAQaHTrgr680Q
         xSO5S1YeU8WmL3NKcZIMVJOBAWcA9VW9CBZbmphOdKnRttCXMX7sxSL+mz/w/AJV1/
         cUBY008t7SHcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A87BE400B1; Tue, 10 May 2022 14:19:32 -0300 (-03)
Date:   Tue, 10 May 2022 14:19:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 02/23] libperf evsel: Add perf_evsel__enable_thread()
Message-ID: <YnqepF/2T0VDrkJu@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-3-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:40PM +0300, Adrian Hunter escreveu:
> Add perf_evsel__enable_thread() as a counterpart to
> perf_evsel__enable_cpu(), to enable all events for a thread.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evsel.c              | 15 +++++++++++++++
>  tools/lib/perf/include/perf/evsel.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 20ae9f5f8b30..c1d58673f6ef 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -360,6 +360,21 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>  	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>  }
>  
> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> +{
> +	struct perf_cpu cpu __maybe_unused;
> +	int idx;
> +	int err;
> +
> +	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
> +		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  int perf_evsel__enable(struct perf_evsel *evsel)
>  {
>  	int i;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 2a9516b42d15..699c0ed97d34 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -36,6 +36,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int
>  				 struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> +LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> -- 
> 2.25.1

-- 

- Arnaldo
