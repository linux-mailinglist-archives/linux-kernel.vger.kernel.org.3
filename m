Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048B522291
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348144AbiEJRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348079AbiEJR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E544658F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F89AB81D1B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AB8C385C2;
        Tue, 10 May 2022 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203542;
        bh=+0eyN2nfbMubCkVIS+NqHdmV9ENcdjgyUIRK5bT5xBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldEywOFDf2GcjlVa6Ce7bCZh6+SC0QVkijEsgcoeBYmyy9qdutHuFjttp6Y5MaIAL
         EN0zzx0QCy7gT/S+PFwkbRN9z0auiH0r7WI/UNCiTstgXk28b66x1xdrUkWaPN3D7N
         1WxBA3ey22VdLw7WZX8jD3sdykbS2tjTZ8JBg2F3UVLOn0OWhb95ijKCd3U4s1hX2G
         sRB0BPDHHcE2xQVCridn0PH0RPydEynPBzq5c+6G0ojjhG7EfMjTpgJcs9KwDqf1Ha
         cu9RO5Ol4x1H2DsNC0kAaQFO87l0An+XlzTB0Kn5do7tb7FgEyO+r18CC4uyOE3mAE
         ZM02KNJ4PDaBA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C5BC400B1; Tue, 10 May 2022 14:25:40 -0300 (-03)
Date:   Tue, 10 May 2022 14:25:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 05/23] perf auxtrace: Do not mix up mmap idx
Message-ID: <YnqgFIqV08QReZES@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-6-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:43PM +0300, Adrian Hunter escreveu:
> The idx is with respect to evlist not evsel. That hasn't mattered because
> they are the same at present. Prepare for that not being the case, which it
> won't be when sideband tracking events are allowed on all CPUs even when
> auxtrace is limited to selected CPUs.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 10936a38031f..b11549ae39df 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -640,8 +640,14 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>  {
>  	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
>  
> -	if (per_cpu_mmaps)
> -		return perf_evsel__enable_cpu(&evsel->core, idx);
> +	if (per_cpu_mmaps) {
> +		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> +		int cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
> +
> +		if (cpu_map_idx == -1)
> +			return -EINVAL;
> +		return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
> +	}
>  
>  	return perf_evsel__enable_thread(&evsel->core, idx);
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
