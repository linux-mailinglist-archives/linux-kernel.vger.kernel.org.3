Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3FC59FB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiHXNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbiHXNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683B7DF53;
        Wed, 24 Aug 2022 06:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4F7614C2;
        Wed, 24 Aug 2022 13:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB00C433C1;
        Wed, 24 Aug 2022 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661348236;
        bh=EQYgx2ILFFg1QXRoYyC52FpjVJo12AMoBM4Wemwr6E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ou6Myf5+8knuXNUYvfBpdyPabrCMoPcGBOVdHIpa+Ee1BJ8EozZjxJ1DMQt+cDsjh
         WrCgrBFmA37Vw5TiQZRQEDGDHG02qOVwKjOJAk7G1v2YA7nd0IQEkRdFrqdN1ekGiC
         EAh982aMRGTDrZ2RNsjCgtKBdzThwR8ki0eJJeGYToxea9ln7fyhOMTwadAzNQ5Ch0
         NbNoAcdHvAhiX3jiWauEikqUtonUt48clig/bYeVb89WgeaHGTYpvoLqIrLs/b/wjU
         Qmpzm46YPZdDXmX4jmTbNjTHGvzOfjNePpMHG+jNqY9ZPkO2m5sbt3J32aVs9nk15x
         wqrqK7f/VK1CA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CB2B404A1; Wed, 24 Aug 2022 10:37:14 -0300 (-03)
Date:   Wed, 24 Aug 2022 10:37:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf sched: Fix memory leaks in __cmd_record
Message-ID: <YwYpiuN3VlzVyCiw@kernel.org>
References: <20220824043825.322827-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220824043825.322827-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 23, 2022 at 09:38:25PM -0700, Ian Rogers escreveu:
> An array of strings is passed to cmd_record but not freed. As
> cmd_record modifies the array, add another array as a copy that can be
> mutated allowing the original array contents to all be freed.
> 
> Detected with -fsanitize=address.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-sched.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 2f6cd1b8b662..59ba14d2321c 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3355,7 +3355,8 @@ static bool schedstat_events_exposed(void)
>  static int __cmd_record(int argc, const char **argv)
>  {
>  	unsigned int rec_argc, i, j;
> -	const char **rec_argv;
> +	char **rec_argv;
> +	const char **rec_argv_copy;
>  	const char * const record_args[] = {
>  		"record",
>  		"-a",
> @@ -3384,6 +3385,7 @@ static int __cmd_record(int argc, const char **argv)
>  		ARRAY_SIZE(schedstat_args) : 0;
>  
>  	struct tep_event *waking_event;
> +	int ret;
>  
>  	/*
>  	 * +2 for either "-e", "sched:sched_wakeup" or
> @@ -3391,14 +3393,15 @@ static int __cmd_record(int argc, const char **argv)
>  	 */
>  	rec_argc = ARRAY_SIZE(record_args) + 2 + schedstat_argc + argc - 1;
>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
> +	rec_argv_copy = calloc(rec_argc + 1, sizeof(char *));
>  
> -	if (rec_argv == NULL)
> +	if (rec_argv == NULL || rec_argv_copy == NULL)
>  		return -ENOMEM;

Here you´re leaking rec_argv if rec_argv_copy fails to be allocated, no?

- Arnaldo

>  
>  	for (i = 0; i < ARRAY_SIZE(record_args); i++)
>  		rec_argv[i] = strdup(record_args[i]);
>  
> -	rec_argv[i++] = "-e";
> +	rec_argv[i++] = strdup("-e");
>  	waking_event = trace_event__tp_format("sched", "sched_waking");
>  	if (!IS_ERR(waking_event))
>  		rec_argv[i++] = strdup("sched:sched_waking");
> @@ -3409,11 +3412,19 @@ static int __cmd_record(int argc, const char **argv)
>  		rec_argv[i++] = strdup(schedstat_args[j]);
>  
>  	for (j = 1; j < (unsigned int)argc; j++, i++)
> -		rec_argv[i] = argv[j];
> +		rec_argv[i] = strdup(argv[j]);
>  
>  	BUG_ON(i != rec_argc);
>  
> -	return cmd_record(i, rec_argv);
> +	memcpy(rec_argv_copy, rec_argv, sizeof(char*) * rec_argc);
> +	ret = cmd_record(rec_argc, rec_argv_copy);
> +
> +	for (i = 0; i < rec_argc; i++)
> +		free(rec_argv[i]);
> +	free(rec_argv);
> +	free(rec_argv_copy);
> +
> +	return ret;
>  }
>  
>  int cmd_sched(int argc, const char **argv)
> -- 
> 2.37.2.609.g9ff673ca1a-goog

-- 

- Arnaldo
