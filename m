Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDC52225A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348008AbiEJR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiEJR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B181546BC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5140618E8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C28C385C2;
        Tue, 10 May 2022 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203398;
        bh=qnCcRXsrG9tuCtfhy1zakNr4J8vl7Uot6TBfLpOX0Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4dvgqi9poF1hRh4foadfGsH/SQiVot5JIRDIcN53a5ilXsu0lYSnpFaeRUZh25UD
         8kGERQrFsMOAbQ8dF42mWP+Fz/4c/epi9xskCycbMJWS0XKRaYAQbum2rBU7gWDRJa
         vto3khEBnaEw5ItiXyTzAmj7RDcHMgjBs9IDQd/sQkTKhXszRHkLm7CRAEGqKvECgT
         GrzzXC6zQX5E7382PRRhXc4Q4ckMny5BH1kqV9UZMCI8ttoJ2QQzBmNzraoW9RR/Wd
         hFSQqzyIldsr6d2sqN2vfcSy625PE7MZd1P3acOjCid+5kgZYFdU6BQuZ2QvEcuHql
         XTJf/Mdypausw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33A5C400B1; Tue, 10 May 2022 14:23:06 -0300 (-03)
Date:   Tue, 10 May 2022 14:23:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 03/23] perf evlist: Use libperf functions in
 evlist__enable_event_idx()
Message-ID: <YnqfepatSiSXb/0o@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-4-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:41PM +0300, Adrian Hunter escreveu:
> evlist__enable_event_idx() is used only for auxtrace events which are never
> system_wide. Simplify by using libperf enable event functions.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/evlist.c | 44 ++--------------------------------------
>  1 file changed, 2 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 52ea004ba01e..9fcecf7daa62 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -334,14 +334,6 @@ int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name,
>  	return 0;
>  }
>  
> -static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
> -{
> -	if (evsel->core.system_wide)
> -		return 1;
> -	else
> -		return perf_thread_map__nr(evlist->core.threads);
> -}
> -
>  struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
>  {
>  	struct evlist_cpu_iterator itr = {
> @@ -546,46 +538,14 @@ void evlist__toggle_enable(struct evlist *evlist)
>  	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
>  }
>  
> -static int evlist__enable_event_cpu(struct evlist *evlist, struct evsel *evsel, int cpu)
> -{
> -	int thread;
> -	int nr_threads = evlist__nr_threads(evlist, evsel);
> -
> -	if (!evsel->core.fd)
> -		return -EINVAL;
> -
> -	for (thread = 0; thread < nr_threads; thread++) {
> -		int err = ioctl(FD(evsel, cpu, thread), PERF_EVENT_IOC_ENABLE, 0);
> -		if (err)
> -			return err;
> -	}
> -	return 0;
> -}
> -
> -static int evlist__enable_event_thread(struct evlist *evlist, struct evsel *evsel, int thread)
> -{
> -	int cpu;
> -	int nr_cpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
> -
> -	if (!evsel->core.fd)
> -		return -EINVAL;
> -
> -	for (cpu = 0; cpu < nr_cpus; cpu++) {
> -		int err = ioctl(FD(evsel, cpu, thread), PERF_EVENT_IOC_ENABLE, 0);
> -		if (err)
> -			return err;
> -	}
> -	return 0;
> -}
> -
>  int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
>  {
>  	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
>  
>  	if (per_cpu_mmaps)
> -		return evlist__enable_event_cpu(evlist, evsel, idx);
> +		return perf_evsel__enable_cpu(&evsel->core, idx);
>  
> -	return evlist__enable_event_thread(evlist, evsel, idx);
> +	return perf_evsel__enable_thread(&evsel->core, idx);
>  }
>  
>  int evlist__add_pollfd(struct evlist *evlist, int fd)
> -- 
> 2.25.1

-- 

- Arnaldo
