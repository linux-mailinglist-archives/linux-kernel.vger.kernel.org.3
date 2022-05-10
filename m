Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C144522298
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348139AbiEJRbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348137AbiEJRap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF69B18D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FCE6192E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF16FC385D8;
        Tue, 10 May 2022 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203598;
        bh=vCCSLLtjOwvS3W3hD1s4XO34tcmV7QFOxFvFEB2rQRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwEQRxeMwelXChiWhZsSPt3LX1LsMjtZA6ZD6pTqnvXHgINYxWC3Lajkqw3S9rpVd
         /Uxo1VLee1tbpImZpR5R4sS0nnKS/CHPbmfPqH6yYUbX14QYhlTjvVHq3vp6Cwwsng
         jPXP2ZTzzFtsDbqtNvnXNFMPM1H20NKCWYyB969NlqYhAoTXnYI6gdJaYJZHxZlQId
         71JjY3/Qp8DfwOcuBrDRV2gZCZHZpe/expdekwsGjY3HCcJyCjpH6eB9szEMkxZoq5
         J11zBwB/JL6MnLsuyqjlmBv31T9Do9eqdR6HcH59MqkL97TX/EZr9n1uDgisKBvg/b
         Php3N/oMBF7lA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F14F8400B1; Tue, 10 May 2022 14:26:34 -0300 (-03)
Date:   Tue, 10 May 2022 14:26:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 07/23] libperf evlist: Move ->idx() into
 mmap_per_evsel()
Message-ID: <YnqgSll+nubb3/BD@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-8-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-8-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:45PM +0300, Adrian Hunter escreveu:
> Move ->idx() into mmap_per_evsel() in preparation for adding evsel as a
> parameter.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/lib/perf/evlist.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 5e8ad854fa8a..4fce417432aa 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -478,6 +478,9 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			 */
>  			refcount_set(&map->refcnt, 2);
>  
> +			if (ops->idx)
> +				ops->idx(evlist, mp, idx);
> +
>  			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>  				return -1;
>  
> @@ -520,9 +523,6 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		int output = -1;
>  		int output_overwrite = -1;
>  
> -		if (ops->idx)
> -			ops->idx(evlist, mp, thread);
> -
>  		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
>  				   &output, &output_overwrite))
>  			goto out_unmap;
> @@ -547,9 +547,6 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		int output = -1;
>  		int output_overwrite = -1;
>  
> -		if (ops->idx)
> -			ops->idx(evlist, mp, cpu);
> -
>  		for (thread = 0; thread < nr_threads; thread++) {
>  			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
>  					   thread, &output, &output_overwrite))
> -- 
> 2.25.1

-- 

- Arnaldo
