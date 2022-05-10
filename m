Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3C522295
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348111AbiEJRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348198AbiEJRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC938D9A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F37661926
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFECC385C2;
        Tue, 10 May 2022 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203569;
        bh=f3Rj3BOIiGHFWlkQ9+sb12X7XdisocSZpgkQBH2mfEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUBKemLB3Qme5RVk+mW+SdAAJMhxUqAHWDE1Zks4YtQWgrnbpYskq22ENyMnBcNFB
         zhYFTJWPdvllUu4CbaR0uB9tnG4WJ9Lb2Gm8AOwD5WFrGzERv5kLcxka7g7lps2S+b
         C7Xoi/yEFm+mLbFwJqa82lbnkgNp4Fr4Ft1mWB6s1mKQ20Ax0HWf7QNOilfflXW7as
         47u+Ow8I+2uCX9DbnVpi8YbQ/4JeJ5CWhEfBI0+zJcf/lKnAimYlXYsawLeV10gVV4
         hcdWXWytwYDEuv8j/RTZHyGAmL/PiISxw7jEMhhHtiOpv8ZGwZQeMofVXedijABx4/
         QdxwbdprFEpSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DFC7400B1; Tue, 10 May 2022 14:26:07 -0300 (-03)
Date:   Tue, 10 May 2022 14:26:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 06/23] libperf evlist: Remove ->idx() per_cpu parameter
Message-ID: <YnqgL5AmNuKCwvT/@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-7-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:44PM +0300, Adrian Hunter escreveu:
> Remove ->idx() per_cpu parameter because it isn't needed.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/lib/perf/evlist.c                  | 4 ++--
>  tools/lib/perf/include/internal/evlist.h | 2 +-
>  tools/perf/util/evlist.c                 | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 974b4585f93e..5e8ad854fa8a 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -521,7 +521,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		int output_overwrite = -1;
>  
>  		if (ops->idx)
> -			ops->idx(evlist, mp, thread, false);
> +			ops->idx(evlist, mp, thread);
>  
>  		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
>  				   &output, &output_overwrite))
> @@ -548,7 +548,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		int output_overwrite = -1;
>  
>  		if (ops->idx)
> -			ops->idx(evlist, mp, cpu, true);
> +			ops->idx(evlist, mp, cpu);
>  
>  		for (thread = 0; thread < nr_threads; thread++) {
>  			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index e3e64f37db7b..0d5c830431a7 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -38,7 +38,7 @@ struct perf_evlist {
>  };
>  
>  typedef void
> -(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
> +(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int);
>  typedef struct perf_mmap*
>  (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
>  typedef int
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f1309b39afe4..09a1d3400fd9 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -748,10 +748,11 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
>  static void
>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
>  			 struct perf_mmap_param *_mp,
> -			 int idx, bool per_cpu)
> +			 int idx)
>  {
>  	struct evlist *evlist = container_of(_evlist, struct evlist, core);
>  	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
> +	bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
>  
>  	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
