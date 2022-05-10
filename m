Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51852226D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348050AbiEJR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348023AbiEJR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:28:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30945270192
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D659FB81C64
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E3FC385C9;
        Tue, 10 May 2022 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203462;
        bh=cqbvHB68JVJOj0M1qGZ7oFiI8xOchRUyk/TCJeHm8OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBj4S0cWags2pcFcoJfj9K1mzb6BtiSLQFN10YK7jiuQOEjIDElOlr/UvbWlqUc/m
         mYRbQ0nw6KUtvjsWKxdQbTOK5W6Hq4zZKWWxoLft4vttoj3NE13fMHTOj800nA2MB6
         qzKh8GCYkdOYFJjg0WlpJzhEWsLSp/AxBSCnr6OwYdN77ervOCisyxKmcRIANXodwc
         GpuF6O1xDtkt7OuW6QuKvyVXwb6ivWgCyK0EzqKqCn02PirU634SUFn1FLAAhxEyEF
         BTxIq7RBuQ9zmdm1Xg3zCuV51KoxkgzVGVNnHQz3iWS589mgEPwVjY8FLy8BGOOhYa
         5UCvpLGdQSq+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8FD5D400B1; Tue, 10 May 2022 14:24:20 -0300 (-03)
Date:   Tue, 10 May 2022 14:24:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/23] perf auxtrace: Move evlist__enable_event_idx()
 to auxtrace.c
Message-ID: <YnqfxD60graVBJq5@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506122601.367589-5-adrian.hunter@intel.com>
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

Em Fri, May 06, 2022 at 03:25:42PM +0300, Adrian Hunter escreveu:
> evlist__enable_event_idx() is used only by auxtrace. Move it to auxtrace.c
> in preparation for making it even more auxtrace specific.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++++
>  tools/perf/util/evlist.c   | 10 ----------
>  tools/perf/util/evlist.h   |  2 --
>  3 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index df1c5bbbaa0d..10936a38031f 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -636,6 +636,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  	return -EINVAL;
>  }
>  
> +static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
> +{
> +	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +
> +	if (per_cpu_mmaps)
> +		return perf_evsel__enable_cpu(&evsel->core, idx);
> +
> +	return perf_evsel__enable_thread(&evsel->core, idx);
> +}
> +
>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 9fcecf7daa62..f1309b39afe4 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -538,16 +538,6 @@ void evlist__toggle_enable(struct evlist *evlist)
>  	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
>  }
>  
> -int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
> -{
> -	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> -
> -	if (per_cpu_mmaps)
> -		return perf_evsel__enable_cpu(&evsel->core, idx);
> -
> -	return perf_evsel__enable_thread(&evsel->core, idx);
> -}
> -
>  int evlist__add_pollfd(struct evlist *evlist, int fd)
>  {
>  	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN, fdarray_flag__default);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index a21daaa5fc1b..4062f5aebfc1 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -196,8 +196,6 @@ void evlist__toggle_enable(struct evlist *evlist);
>  void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
>  void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
>  
> -int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx);
> -
>  void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
>  
>  int evlist__create_maps(struct evlist *evlist, struct target *target);
> -- 
> 2.25.1

-- 

- Arnaldo
