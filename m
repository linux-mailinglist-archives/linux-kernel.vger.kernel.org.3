Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065725A28FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiHZOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiHZOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832EC00D6;
        Fri, 26 Aug 2022 07:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C32DB82A67;
        Fri, 26 Aug 2022 14:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EEBC433C1;
        Fri, 26 Aug 2022 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661522500;
        bh=p/JDAuAHU4Zd+HtSCGRiMszPIJbGgAjMGbUVAPyyTpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Evz/oTNMeXYkF7kcjWRT7CXxCTmLxbN1wc/7mtIdyMnlHPXdyxiHde6qEF9Yat2d7
         NKhouvQkBNsjNt/FtVAEC1KDwlyGwAHRnU5LhoLlqH9F8D4lhgGox9T6s0p69+6qpO
         SawgGE0iuaCRMv51h9qqYd5wfcEcWhv9lLgEaXCyI2dlTj1DACqfYWliSVmtHv9mIj
         1JMlFJ0xAoRVFpsTJaWEb7/8lICYusrXNRezqHBlszB++Hk2ibWXHC/fhS0GGCEae1
         i3q8eqEOihhjoNx4hHwdxuISgudI/mW05mZAeOitz8HozWGBfNSDP7gnJAP07Rvvwp
         R+JnkcwlWMbMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2EE9F404A1; Fri, 26 Aug 2022 11:01:35 -0300 (-03)
Date:   Fri, 26 Aug 2022 11:01:35 -0300
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
Subject: Re: [PATCH v2] perf sched: Fix memory leaks in __cmd_record
Message-ID: <YwjSP83b3u2Hp5Le@kernel.org>
References: <20220824145733.409005-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824145733.409005-1-irogers@google.com>
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

Em Wed, Aug 24, 2022 at 07:57:33AM -0700, Ian Rogers escreveu:
> An array of strings is passed to cmd_record but not freed. As
> cmd_record modifies the array, add another array as a copy that can be
> mutated allowing the original array contents to all be freed.
> 
> Detected with -fsanitize=address.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-sched.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 2f6cd1b8b662..a5cf243c337f 100644
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
> @@ -3391,14 +3393,18 @@ static int __cmd_record(int argc, const char **argv)
>  	 */
>  	rec_argc = ARRAY_SIZE(record_args) + 2 + schedstat_argc + argc - 1;
>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
> -
>  	if (rec_argv == NULL)
>  		return -ENOMEM;
> +	rec_argv_copy = calloc(rec_argc + 1, sizeof(char *));
> +	if (rec_argv_copy == NULL) {
> +		free(rec_argv);
> +		return -ENOMEM;
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(record_args); i++)
>  		rec_argv[i] = strdup(record_args[i]);
>  
> -	rec_argv[i++] = "-e";
> +	rec_argv[i++] = strdup("-e");
>  	waking_event = trace_event__tp_format("sched", "sched_waking");
>  	if (!IS_ERR(waking_event))
>  		rec_argv[i++] = strdup("sched:sched_waking");
> @@ -3409,11 +3415,19 @@ static int __cmd_record(int argc, const char **argv)
>  		rec_argv[i++] = strdup(schedstat_args[j]);
>  
>  	for (j = 1; j < (unsigned int)argc; j++, i++)
> -		rec_argv[i] = argv[j];
> +		rec_argv[i] = strdup(argv[j]);
>  
>  	BUG_ON(i != rec_argc);
>  
> -	return cmd_record(i, rec_argv);
> +	memcpy(rec_argv_copy, rec_argv, sizeof(char *) * rec_argc);
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
