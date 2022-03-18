Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA94DDBA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiCRO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiCRO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:28:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE3267F92
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF81B823E0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 14:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E2C340EC;
        Fri, 18 Mar 2022 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647613619;
        bh=oL+w66Sjhl/Au3JgDeFmuXM/Jh0p/2JsQ9+YXUdRlxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpiTHvDtj5DnASRog0zf0C3sPFzsHsyNGpmgziW2x2sJcOtlgz9zH7mwuTOujMCdB
         FOhk0YidMOSEVmoBeSmOc9BvKAKMyx65QP3RMAbre6FrKtU7ZsxZLA2rfSwnKVy7/G
         61AfhJgBRVHY3/+TllgePrmumYZKFCpwV8/ZBecpbe7t+IcqWvxrlwKf+FCnLLHhjq
         oH5YPAFyHHUIjddmcRiGtIJ9t5I52NilP749oFT9un5gQNB+Bk3Ou/5m6rUuQNH7M2
         lTtDT5kmbfu6H6oI1lp/8Ttt7eHGcUQxbhb9bzQozq64tX2V+k30Z706PLhhm4/Jvc
         h3he1LWuuo5ZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 184E640407; Fri, 18 Mar 2022 11:26:55 -0300 (-03)
Date:   Fri, 18 Mar 2022 11:26:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf evlist: Avoid iteration for empty evlist.
Message-ID: <YjSWr5P6J1fN2PiR@kernel.org>
References: <20220317231643.550902-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317231643.550902-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 17, 2022 at 04:16:43PM -0700, Ian Rogers escreveu:
> As seen with 'perf stat --null ..' and reported in:
> https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/
> 
> v2. Avoids setting evsel in the empty list case as suggested by Jiri
>     Olsa <jolsa@kernel.org>.
> Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, replaced v1 with this new one.

- Arnaldo

> ---
>  tools/perf/util/evlist.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8134d45e2164..9bb79e049957 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -346,7 +346,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
>  {
>  	struct evlist_cpu_iterator itr = {
>  		.container = evlist,
> -		.evsel = evlist__first(evlist),
> +		.evsel = NULL,
>  		.cpu_map_idx = 0,
>  		.evlist_cpu_map_idx = 0,
>  		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
> @@ -354,16 +354,22 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
>  		.affinity = affinity,
>  	};
>  
> -	if (itr.affinity) {
> -		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
> -		affinity__set(itr.affinity, itr.cpu.cpu);
> -		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
> -		/*
> -		 * If this CPU isn't in the evsel's cpu map then advance through
> -		 * the list.
> -		 */
> -		if (itr.cpu_map_idx == -1)
> -			evlist_cpu_iterator__next(&itr);
> +	if (evlist__empty(evlist)) {
> +		/* Ensure the empty list doesn't iterate. */
> +		itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
> +	} else {
> +		itr.evsel = evlist__first(evlist);
> +		if (itr.affinity) {
> +			itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
> +			affinity__set(itr.affinity, itr.cpu.cpu);
> +			itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
> +			/*
> +			 * If this CPU isn't in the evsel's cpu map then advance
> +			 * through the list.
> +			 */
> +			if (itr.cpu_map_idx == -1)
> +				evlist_cpu_iterator__next(&itr);
> +		}
>  	}
>  	return itr;
>  }
> -- 
> 2.35.1.894.gb6a874cedc-goog

-- 

- Arnaldo
