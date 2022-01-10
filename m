Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8149B489F92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiAJSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:51:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33384 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiAJSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75246CE16C6;
        Mon, 10 Jan 2022 18:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E7C36AE9;
        Mon, 10 Jan 2022 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641840669;
        bh=iIkBlpSGrQmkNbx82dDCHemXgp467jTsEVwDl7ubF0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVQajCjD9adK9/KXoA48SUYzuX6sI9x5MfXOkr9pA3+ZLqeXDgEhB9iVNv5kd4nku
         rFxW7SQGwtKGbARlVJ8ctMWvKWTBlTdbQmYDr9+iuxZA5l9OM8tbGG3yTVSof7vzGc
         DggIWg/mJtT+4ypMwH3Do4lePTOyJAZUskrrR1ZnarlqFGfZZs6YlkLHv/t89XeyT2
         9+bmw33A2BCrfA1q2OFizbk04NazNaFo/+k0xBef4zS56VRiNa+SWJ87LK+eWGkNA4
         2vW1pJk+9IxGDvawir+pGojIDi+eaih7dh2HoDvLREgKZrMH2Uz8FYhZJNPnWp2W1s
         FIWpj0FNzmhzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC54540B92; Mon, 10 Jan 2022 15:51:07 -0300 (-03)
Date:   Mon, 10 Jan 2022 15:51:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dario Petrillo <dario.pk1@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tui: avoid crash when annotating recursive functions
Message-ID: <YdyAG9G6uPWvTJ9g@kernel.org>
References: <20220109234441.325106-1-dario.pk1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109234441.325106-1-dario.pk1@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 12:44:41AM +0100, Dario Petrillo escreveu:
> In perf report, entering a recursive function from inside of itself
> (either directly of indirectly through some other function) results in
> calling symbol__annotate2 multiple times, and freeing the whole disassembly
> when exiting from the innermost instance. The first issue causes the
> function's disassembly to be duplicated, and the latter a heap
> use-after-free (and crash) when trying to access the disassembly again.
> 
> I reproduced the bug on perf 5.11.22 (Ubuntu 20.04.3 LTS) and 5.16.rc8
> with the following testcase (compile with gcc recursive.c -o recursive).
> To reproduce:
> - perf record ./recursive
> - perf report
> - enter fibonacci and annotate it
> - move the cursor on one of the "callq fibonacci" instructions and press enter
>   - at this point there will be two copies of the function in the disassembly
> - go back by pressing q, and perf will crash
> 
> #include <stdio.h>
> 
> int fibonacci(int n)
> {
>     if(n <= 2) return 1;
>     return fibonacci(n-1) + fibonacci(n-2);
> }
> 
> int main()
> {
>     printf("%d\n", fibonacci(40));
> }
> 
> This patch addresses the issue by annotating a function and freeing the
> associated memory on exit only if no annotation is already present,
> so that a recursive function is only annotated on entry.

Problem reproduced, patch applied, problem fixed.

Thanks, applied.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Dario Petrillo <dario.pk1@gmail.com>
> 
> ---
>  tools/perf/ui/browsers/annotate.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index e81c2493efdf..44ba900828f6 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -966,6 +966,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  		.opts = opts,
>  	};
>  	int ret = -1, err;
> +	int not_annotated = list_empty(&notes->src->source);
>  
>  	if (sym == NULL)
>  		return -1;
> @@ -973,13 +974,15 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  	if (ms->map->dso->annotate_warned)
>  		return -1;
>  
> -	err = symbol__annotate2(ms, evsel, opts, &browser.arch);
> -	if (err) {
> -		char msg[BUFSIZ];
> -		ms->map->dso->annotate_warned = true;
> -		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> -		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
> -		goto out_free_offsets;
> +	if (not_annotated) {
> +		err = symbol__annotate2(ms, evsel, opts, &browser.arch);
> +		if (err) {
> +			char msg[BUFSIZ];
> +			ms->map->dso->annotate_warned = true;
> +			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> +			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
> +			goto out_free_offsets;
> +		}
>  	}
>  
>  	ui_helpline__push("Press ESC to exit");
> @@ -994,9 +997,11 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  
>  	ret = annotate_browser__run(&browser, evsel, hbt);
>  
> -	annotated_source__purge(notes->src);
> +	if(not_annotated)
> +		annotated_source__purge(notes->src);
>  
>  out_free_offsets:
> -	zfree(&notes->offsets);
> +	if(not_annotated)
> +		zfree(&notes->offsets);
>  	return ret;
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
