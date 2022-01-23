Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D34975CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiAWVsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 16:48:06 -0500
Received: from mout02.posteo.de ([185.67.36.66]:53559 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240234AbiAWVsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 16:48:04 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 927C7240105
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1642974483; bh=twScTrUhs7Zg7H8SAP05UMjgUOoyiLmLUs+1hsNNGos=;
        h=Date:From:To:Cc:Subject:From;
        b=UT/DlyTHTkYmchpwXrJZiKFI1FYTS0IpMibuPj+REt1H+jgw6cUnlym6IpOQVj1l3
         FG0dOQy94HARJ2e4gK0QUWa4coInqTj3pDi0P6r47JhyLiPbM98Hp19WBvBxo0tMJ7
         DzV5/DNKWQTKj1Hb5XP2Fr8QgAS1OlerFE+8QatCaUS0ejQyG1A2n+C+0YdySEfeQ+
         MgM52XOjDrtysvWPEyfoSnfEbKJvSY3t9mNzepZCdTiaMdT44f1fRXZPscCMVBA94c
         xSvFCppD60/WYhsWs5T+cmEzviwPPfnslSNXabXRC9655L87HxPxbFLuFdPRkL327W
         z7kmP2ZwPq6sg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Jhmv65GQxz6tnv;
        Sun, 23 Jan 2022 22:48:02 +0100 (CET)
Date:   Sun, 23 Jan 2022 21:49:01 +0000
From:   xaizek <xaizek@posteo.net>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tui: Only support --tui with slang
Message-ID: <Ye3NTTt7CctUFRmk@zx-spectrum.none>
References: <20220123191849.3655855-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123191849.3655855-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Ian.  The patch works as expected on 5.15.12 (--gtk patch
didn't apply on this revision).

Regards,
xaizek

On Sun, Jan 23, 2022 at 11:18:48AM -0800, Ian Rogers wrote:
> Make the --tui command line flags dependent HAVE_SLANG_SUPPORT. This was
> reported as confusing in:
> https://lore.kernel.org/linux-perf-users/YevaTkzdXmFKdGpc@zx-spectrum.none/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-annotate.c | 10 +++++++++-
>  tools/perf/builtin-report.c   | 10 +++++++++-
>  tools/perf/builtin-top.c      |  4 ++++
>  tools/perf/util/top.h         |  5 ++++-
>  4 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 490bb9b8cf17..5e038d9bab05 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -46,7 +46,11 @@ struct perf_annotate {
>  	struct perf_tool tool;
>  	struct perf_session *session;
>  	struct annotation_options opts;
> -	bool	   use_tui, use_stdio, use_stdio2, use_gtk;
> +#ifdef HAVE_SLANG_SUPPORT
> +	bool	   use_tui;
> +#endif
> +	bool	   use_stdio, use_stdio2;
> +	bool	   use_gtk;
>  	bool	   skip_missing;
>  	bool	   has_br_stack;
>  	bool	   group_set;
> @@ -503,7 +507,9 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
>  		    "dump raw trace in ASCII"),
>  	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
> +#ifdef HAVE_SLANG_SUPPORT
>  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
> +#endif
>  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
>  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
>  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> @@ -624,8 +630,10 @@ int cmd_annotate(int argc, const char **argv)
>  
>  	if (annotate.use_stdio || annotate.use_stdio2)
>  		use_browser = 0;
> +#ifdef HAVE_SLANG_SUPPORT
>  	else if (annotate.use_tui)
>  		use_browser = 1;
> +#endif
>  	else if (annotate.use_gtk)
>  		use_browser = 2;
>  
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1dd92d8c9279..1ad75c7ba074 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -71,7 +71,11 @@ struct report {
>  	struct perf_tool	tool;
>  	struct perf_session	*session;
>  	struct evswitch		evswitch;
> -	bool			use_tui, use_gtk, use_stdio;
> +#ifdef HAVE_SLANG_SUPPORT
> +	bool			use_tui;
> +#endif
> +	bool			use_gtk;
> +	bool			use_stdio;
>  	bool			show_full_info;
>  	bool			show_threads;
>  	bool			inverted_callchain;
> @@ -1206,7 +1210,9 @@ int cmd_report(int argc, const char **argv)
>  		    "Show per-thread event counters"),
>  	OPT_STRING(0, "pretty", &report.pretty_printing_style, "key",
>  		   "pretty printing style key: normal raw"),
> +#ifdef HAVE_SLANG_SUPPORT
>  	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
> +#endif
>  	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
>  	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
>  		    "Use the stdio interface"),
> @@ -1492,8 +1498,10 @@ int cmd_report(int argc, const char **argv)
>  
>  	if (report.use_stdio)
>  		use_browser = 0;
> +#ifdef HAVE_SLANG_SUPPORT
>  	else if (report.use_tui)
>  		use_browser = 1;
> +#endif
>  	else if (report.use_gtk)
>  		use_browser = 2;
>  
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1fc390f136dd..e1a134a0a377 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1486,7 +1486,9 @@ int cmd_top(int argc, const char **argv)
>  		    "display this many functions"),
>  	OPT_BOOLEAN('U', "hide_user_symbols", &top.hide_user_symbols,
>  		    "hide user symbols"),
> +#ifdef HAVE_SLANG_SUPPORT
>  	OPT_BOOLEAN(0, "tui", &top.use_tui, "Use the TUI interface"),
> +#endif
>  	OPT_BOOLEAN(0, "stdio", &top.use_stdio, "Use the stdio interface"),
>  	OPT_INCR('v', "verbose", &verbose,
>  		    "be more verbose (show counter open errors, etc)"),
> @@ -1667,8 +1669,10 @@ int cmd_top(int argc, const char **argv)
>  
>  	if (top.use_stdio)
>  		use_browser = 0;
> +#ifdef HAVE_SLANG_SUPPORT
>  	else if (top.use_tui)
>  		use_browser = 1;
> +#endif
>  
>  	setup_browser(false);
>  
> diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> index ff8391208ecd..1c2c0a838430 100644
> --- a/tools/perf/util/top.h
> +++ b/tools/perf/util/top.h
> @@ -33,7 +33,10 @@ struct perf_top {
>  	int		   print_entries, count_filter, delay_secs;
>  	int		   max_stack;
>  	bool		   hide_kernel_symbols, hide_user_symbols, zero;
> -	bool		   use_tui, use_stdio;
> +#ifdef HAVE_SLANG_SUPPORT
> +	bool		   use_tui;
> +#endif
> +	bool		   use_stdio;
>  	bool		   vmlinux_warned;
>  	bool		   dump_symtab;
>  	bool		   stitch_lbr;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
