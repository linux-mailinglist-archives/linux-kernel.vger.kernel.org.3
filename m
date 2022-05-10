Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37377522299
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348110AbiEJRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348358AbiEJRbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C14A3CA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9FF16192A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F361C385C2;
        Tue, 10 May 2022 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203617;
        bh=MH7Zsi8yFAeRcDHjpDleZQKFS4ZPgItbU4fbMKDx9y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvZtUsRa1l6vIkNhFWA9kpvEG0xAQoWl5Ltu9uZSSR4TwOVjk9sGK54Mqo1Ni5G0T
         HyyZXrAawFoE8oXBV52TJWyPc9C7CXe06eR+9aUkhFcRNTOfPOzSsOxpm0CKkwWrhr
         pliQIVYxKdozyT+Imir5m9C4bczmQQnZskOuKcv/so4zhta0NS9GAyHxbKNXzgr9uX
         symQC3si9rNKNsb10D77sOVu/KXzssoA07oJkErmBEz4Nc7I4psw3Elg6z42lEDQB6
         idhrSkMn2vthrFWfk2R7ze0MN6KGuYDpxyKxX9YApG+qA8C6T3oG5YzsZfqtRCeLpG
         peEKcoU7/aSdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96D00400B1; Tue, 10 May 2022 14:26:54 -0300 (-03)
Date:   Tue, 10 May 2022 14:26:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 08/23] libperf evlist: Add evsel as a parameter to
 ->idx()
Message-ID: <YnqgXgcTRw4CpghV@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-9-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:46PM +0300, Adrian Hunter escreveu:
> Add evsel as a parameter to ->idx() in preparation for correctly
> determining whether an auxtrace mmap is needed.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/lib/perf/evlist.c                  | 2 +-
>  tools/lib/perf/include/internal/evlist.h | 3 ++-
>  tools/perf/util/evlist.c                 | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 4fce417432aa..ed66f2e38464 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -479,7 +479,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			refcount_set(&map->refcnt, 2);
>  
>  			if (ops->idx)
> -				ops->idx(evlist, mp, idx);
> +				ops->idx(evlist, evsel, mp, idx);
>  
>  			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>  				return -1;
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 0d5c830431a7..6f89aec3e608 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -38,7 +38,8 @@ struct perf_evlist {
>  };
>  
>  typedef void
> -(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int);
> +(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_evsel*,
> +			      struct perf_mmap_param*, int);
>  typedef struct perf_mmap*
>  (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
>  typedef int
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 09a1d3400fd9..7ae56b062f44 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -747,6 +747,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
>  
>  static void
>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
> +			 struct perf_evsel *_evsel __maybe_unused,
>  			 struct perf_mmap_param *_mp,
>  			 int idx)
>  {
> -- 
> 2.25.1

-- 

- Arnaldo
