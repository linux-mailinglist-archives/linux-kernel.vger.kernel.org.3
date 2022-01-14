Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F203F48EBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiANOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:34:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33630 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiANOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD115B82600;
        Fri, 14 Jan 2022 14:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572D4C36AEA;
        Fri, 14 Jan 2022 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642170850;
        bh=KhFkcaHFPtVxwWG92zTEFmBhWfuBW5f1coADlCc6qIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glpSHlhmwWKkGsewBPqXRvALwSFmFB7KkKiBHZQ+2oRuumMBcady8g/Rxwxvu9Rre
         BwUIUB3P+3cugkY7adzfcL60zXvcHKDh97hQkTNjq9HORnOR9n5tWkBa7mIXXNbAQq
         DdPybzUEwRtL2mOS9dQfZY04tg9KH7Wfh3kVbZxl7YcoYLFycS7+WQln0hmZn0UQcv
         xsOwNzHWutlJzJ2ruD0m6aom5coQkuA43ljvodB0zZ/ByzgTSkeFY4Q3lVUgId4SPx
         1t3kdU2zq/nI4Za+VjgNLqDjhJmGjkReNo6478GqI51sJR66DcwU93+HJgVd/Icn2e
         +IdeGVHv/5aXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8927640714; Fri, 14 Jan 2022 11:34:08 -0300 (-03)
Date:   Fri, 14 Jan 2022 11:34:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf tests: Update a use of the new cpumap api.
Message-ID: <YeGJ4PJOQRwNVThV@kernel.org>
References: <20220114065105.1806542-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114065105.1806542-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 13, 2022 at 10:51:05PM -0800, Ian Rogers escreveu:
> Fixes a build breakage.
> 
> Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")

I wonder how I didn't catch this in my tests...

Thanks, applied.

- Arnaldo


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/tests/test-evlist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index e7afff12c35a..b3479dfa9a1c 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -334,7 +334,8 @@ static int test_mmap_cpus(void)
>  	};
>  	cpu_set_t saved_mask;
>  	char path[PATH_MAX];
> -	int id, err, cpu, tmp;
> +	int id, err, tmp;
> +	struct perf_cpu cpu;
>  	union perf_event *event;
>  	int count = 0;
>  
> @@ -377,7 +378,7 @@ static int test_mmap_cpus(void)
>  		cpu_set_t mask;
>  
>  		CPU_ZERO(&mask);
> -		CPU_SET(cpu, &mask);
> +		CPU_SET(cpu.cpu, &mask);
>  
>  		err = sched_setaffinity(0, sizeof(mask), &mask);
>  		__T("sched_setaffinity failed", err == 0);
> -- 
> 2.34.1.703.g22d0c6ccf7-goog

-- 

- Arnaldo
