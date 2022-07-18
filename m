Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2E578681
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiGRPiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiGRPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7448BF6C;
        Mon, 18 Jul 2022 08:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCAE61254;
        Mon, 18 Jul 2022 15:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60174C341CA;
        Mon, 18 Jul 2022 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658158686;
        bh=3yZ1jSHssAY3HgAy72zNKH6+/8SrEIHJAMJj70k/W0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ue34b7d++T+f0rwIIWjDYfLQe5ww3aYWLC3c7MEDR7hPf5EJk0J1qkIKx6DCXiB5x
         Z31JINkl9KXmq9Q71jaZqVnb1tktpR8UvPnO2sVhXgRT0uzlf88WoXjnuJCse3Pa2p
         xh+ICwspP2QHPbU0hMxXNkQ1qW5HiSUiqxtE5XVqQGQp+aFB7c024ZhE09AeHeRiSE
         +bfqwMn9S3jbcncSm6xWGM6mX5rPa8vitSAdGFYPzjpm0lOZ6NUqqWox5qhhX4dGPx
         T3zF5vx1X6jq9JUqYANBj3VavTKnJl569sNXaxqPOggkrjJutCaHzg+YfbEt8CRruZ
         ZEzL0wZJUsGOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F30AD40374; Mon, 18 Jul 2022 12:38:03 -0300 (-03)
Date:   Mon, 18 Jul 2022 12:38:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     xaizek <xaizek@posteo.net>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf gtk: Only support --gtk if compiled in
Message-ID: <YtV+Wxf8l7NgVLTy@kernel.org>
References: <20220707203836.345918-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707203836.345918-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 07, 2022 at 01:38:36PM -0700, Ian Rogers escreveu:
> If HAVE_GTK2_SUPPORT isn't defined then --gtk can't succeed, don't
> support it as a command line option in this case.
> 
> v2. Is a rebase. Patch appears to have been missed in:
> https://lore.kernel.org/lkml/Ygu40djM1MqAfkcF@kernel.org/

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-annotate.c | 8 ++++++++
>  tools/perf/builtin-report.c   | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 2ffe071dbcff..f839e69492e8 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -50,7 +50,9 @@ struct perf_annotate {
>  	bool	   use_tui;
>  #endif
>  	bool	   use_stdio, use_stdio2;
> +#ifdef HAVE_GTK2_SUPPORT
>  	bool	   use_gtk;
> +#endif
>  	bool	   skip_missing;
>  	bool	   has_br_stack;
>  	bool	   group_set;
> @@ -526,7 +528,9 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_BOOLEAN('q', "quiet", &quiet, "do now show any message"),
>  	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
>  		    "dump raw trace in ASCII"),
> +#ifdef HAVE_GTK2_SUPPORT
>  	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
> +#endif
>  #ifdef HAVE_SLANG_SUPPORT
>  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
>  #endif
> @@ -614,10 +618,12 @@ int cmd_annotate(int argc, const char **argv)
>  	if (annotate_check_args(&annotate.opts) < 0)
>  		return -EINVAL;
>  
> +#ifdef HAVE_GTK2_SUPPORT
>  	if (symbol_conf.show_nr_samples && annotate.use_gtk) {
>  		pr_err("--show-nr-samples is not available in --gtk mode at this time\n");
>  		return ret;
>  	}
> +#endif
>  
>  	ret = symbol__validate_sym_arguments();
>  	if (ret)
> @@ -656,8 +662,10 @@ int cmd_annotate(int argc, const char **argv)
>  	else if (annotate.use_tui)
>  		use_browser = 1;
>  #endif
> +#ifdef HAVE_GTK2_SUPPORT
>  	else if (annotate.use_gtk)
>  		use_browser = 2;
> +#endif
>  
>  	setup_browser(true);
>  
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index afe4a5539ecc..91ed41cc7d88 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -74,7 +74,9 @@ struct report {
>  #ifdef HAVE_SLANG_SUPPORT
>  	bool			use_tui;
>  #endif
> +#ifdef HAVE_GTK2_SUPPORT
>  	bool			use_gtk;
> +#endif
>  	bool			use_stdio;
>  	bool			show_full_info;
>  	bool			show_threads;
> @@ -1227,7 +1229,9 @@ int cmd_report(int argc, const char **argv)
>  #ifdef HAVE_SLANG_SUPPORT
>  	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
>  #endif
> +#ifdef HAVE_GTK2_SUPPORT
>  	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
> +#endif
>  	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
>  		    "Use the stdio interface"),
>  	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
> @@ -1516,8 +1520,10 @@ int cmd_report(int argc, const char **argv)
>  	else if (report.use_tui)
>  		use_browser = 1;
>  #endif
> +#ifdef HAVE_GTK2_SUPPORT
>  	else if (report.use_gtk)
>  		use_browser = 2;
> +#endif
>  
>  	/* Force tty output for header output and per-thread stat. */
>  	if (report.header || report.header_only || report.show_threads)
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog

-- 

- Arnaldo
