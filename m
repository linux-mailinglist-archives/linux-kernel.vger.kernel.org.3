Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B253514A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiEZPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347900AbiEZPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC451E40;
        Thu, 26 May 2022 08:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9548A61C39;
        Thu, 26 May 2022 15:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69C3C385A9;
        Thu, 26 May 2022 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653578261;
        bh=NBf+pAq2v5/7g2321kGFNz//hLtJL3AHQxwCRfNxGQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mvpl6nH9ATWNnLSOb8duPOItXoH8WfMcvvDbmoA6anRZzVItyVQrJt/1F7ZVEc5xv
         xotAO+pP/aaXlgY3VNQ3BZXWeGguFwMefngw8gsCxRppJA9EwMcTQtA879OVtqW36y
         gP4TO5B7GtVZAkGFj+LiajGhuIORNG97Sj571nNxq9ZPIOzf5fB5Z3/DQkUnTL9H3j
         S5HK3HMRZsPCZGhUqK0hfuohJGZqQ73a21lQ5aFy9P8jye66axeDNKMua6bNQa0dNi
         TFei1TdSgwZvtQteRGKlbnuuFGC/pY0BKVpa8AiP4cCff8dB7Ae7Qqhz3tCxs+wuRT
         hU87qrfLKPTig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23F024036D; Thu, 26 May 2022 12:17:39 -0300 (-03)
Date:   Thu, 26 May 2022 12:17:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2] perf c2c: Use stdio interface if slang is not
 supported
Message-ID: <Yo+aE7dEoKaECHEu@kernel.org>
References: <20220526145400.611249-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526145400.611249-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 26, 2022 at 10:54:00PM +0800, Leo Yan escreveu:
> If slang lib is not installed on the system, perf c2c tool disables
> TUI mode and roll back to use stdio mode;  but the flag 'c2c.use_stdio'
> is missed to set true and thus it wrongly applies UI quirks in the
> function ui_quirks().
> 
> This commit forces to use stdio interface if slang is not supported,
> and it can avoid to apply the UI quirks and show the correct metric
> header.
> 
> Before:
> 
> =================================================
>       Shared Cache Line Distribution Pareto
> =================================================
>   -------------------------------------------------------------------------------
>       0        0        0       99        0        0        0      0xaaaac17d6000
>   -------------------------------------------------------------------------------
>     0.00%    0.00%    6.06%    0.00%    0.00%    0.00%   0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
>     0.00%    0.00%   93.94%    0.00%    0.00%    0.00%   0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0
> 
> After:
> 
> =================================================
>       Shared Cache Line Distribution Pareto
> =================================================
>   -------------------------------------------------------------------------------
>       0        0        0       99        0        0        0      0xaaaac17d6000
>   -------------------------------------------------------------------------------
>            0.00%    0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
>            0.00%    0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0
> 
> Fixes: 5a1a99cd2e4e ("perf c2c report: Add main TUI browser")
> Reported-by: Joe Mario <jmario@redhat.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

> ---
> 
> Changes from v1:
> * Added fixes tag;
> * Added reported tag from Joe.
> 
>  tools/perf/builtin-c2c.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c8230c48125f..80b525c065ed 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2801,9 +2801,7 @@ static int perf_c2c__report(int argc, const char **argv)
>  		   "the input file to process"),
>  	OPT_INCR('N', "node-info", &c2c.node_info,
>  		 "show extra node info in report (repeat for more info)"),
> -#ifdef HAVE_SLANG_SUPPORT
>  	OPT_BOOLEAN(0, "stdio", &c2c.use_stdio, "Use the stdio interface"),
> -#endif
>  	OPT_BOOLEAN(0, "stats", &c2c.stats_only,
>  		    "Display only statistic tables (implies --stdio)"),
>  	OPT_BOOLEAN(0, "full-symbols", &c2c.symbol_full,
> @@ -2833,6 +2831,10 @@ static int perf_c2c__report(int argc, const char **argv)
>  	if (argc)
>  		usage_with_options(report_c2c_usage, options);
>  
> +#ifndef HAVE_SLANG_SUPPORT
> +	c2c.use_stdio = true;
> +#endif
> +
>  	if (c2c.stats_only)
>  		c2c.use_stdio = true;
>  
> -- 
> 2.25.1

-- 

- Arnaldo
