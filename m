Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDF4B6EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiBOO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:29:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiBOO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:29:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8163E44AE;
        Tue, 15 Feb 2022 06:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E7AE61784;
        Tue, 15 Feb 2022 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB6CC340EB;
        Tue, 15 Feb 2022 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644935379;
        bh=D5fzY5EQd1IDj4tgL8zZWtp6cbHxxDxIKh0qVmUriFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkRRkXJsd+pyznC9u7T32BjNdl3z2oPnKMI+XHrUw2G52N0WVMXeUMkJVKRMfsY9p
         9k48yTrCoXzgxCyhl6G8ecacl8S2dM1sspkZAfNJPcqPqnFadc53e5jnGLcIN3kOPW
         2N782DXztlbKs0n5qbzux5H56FjMD93PbiYczKuq226C80ShYkecOyUOT09hOtELWg
         lQPKYyDdG+IPjlr2O95EGnwArKE4TJUrn0np9xMHMXnI8+4KUnSSsWOPQ0Z1f7TU0z
         FF3IbLxdiBHlShNxO+qc97xRmnRWwRD8lq/keLOcQ1pebyr3OGgpHRf7jTRXtsp6HP
         AZ7xOX/ypNb3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0333400FE; Tue, 15 Feb 2022 11:29:37 -0300 (-03)
Date:   Tue, 15 Feb 2022 11:29:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     xaizek <xaizek@posteo.net>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tui: Only support --tui with slang
Message-ID: <Ygu40djM1MqAfkcF@kernel.org>
References: <20220123191849.3655855-1-irogers@google.com>
 <Ye3NTTt7CctUFRmk@zx-spectrum.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye3NTTt7CctUFRmk@zx-spectrum.none>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 23, 2022 at 09:49:01PM +0000, xaizek escreveu:
> Thank you, Ian.  The patch works as expected on 5.15.12 (--gtk patch
> didn't apply on this revision).

Thanks, applied and added a Reported-by + Tested-by: xaizek.

- Arnaldo
 
> Regards,
> xaizek
> 
> On Sun, Jan 23, 2022 at 11:18:48AM -0800, Ian Rogers wrote:
> > Make the --tui command line flags dependent HAVE_SLANG_SUPPORT. This was
> > reported as confusing in:
> > https://lore.kernel.org/linux-perf-users/YevaTkzdXmFKdGpc@zx-spectrum.none/
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-annotate.c | 10 +++++++++-
> >  tools/perf/builtin-report.c   | 10 +++++++++-
> >  tools/perf/builtin-top.c      |  4 ++++
> >  tools/perf/util/top.h         |  5 ++++-
> >  4 files changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 490bb9b8cf17..5e038d9bab05 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -46,7 +46,11 @@ struct perf_annotate {
> >  	struct perf_tool tool;
> >  	struct perf_session *session;
> >  	struct annotation_options opts;
> > -	bool	   use_tui, use_stdio, use_stdio2, use_gtk;
> > +#ifdef HAVE_SLANG_SUPPORT
> > +	bool	   use_tui;
> > +#endif
> > +	bool	   use_stdio, use_stdio2;
> > +	bool	   use_gtk;
> >  	bool	   skip_missing;
> >  	bool	   has_br_stack;
> >  	bool	   group_set;
> > @@ -503,7 +507,9 @@ int cmd_annotate(int argc, const char **argv)
> >  	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
> >  		    "dump raw trace in ASCII"),
> >  	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
> > +#ifdef HAVE_SLANG_SUPPORT
> >  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
> > +#endif
> >  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
> >  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
> >  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> > @@ -624,8 +630,10 @@ int cmd_annotate(int argc, const char **argv)
> >  
> >  	if (annotate.use_stdio || annotate.use_stdio2)
> >  		use_browser = 0;
> > +#ifdef HAVE_SLANG_SUPPORT
> >  	else if (annotate.use_tui)
> >  		use_browser = 1;
> > +#endif
> >  	else if (annotate.use_gtk)
> >  		use_browser = 2;
> >  
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 1dd92d8c9279..1ad75c7ba074 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -71,7 +71,11 @@ struct report {
> >  	struct perf_tool	tool;
> >  	struct perf_session	*session;
> >  	struct evswitch		evswitch;
> > -	bool			use_tui, use_gtk, use_stdio;
> > +#ifdef HAVE_SLANG_SUPPORT
> > +	bool			use_tui;
> > +#endif
> > +	bool			use_gtk;
> > +	bool			use_stdio;
> >  	bool			show_full_info;
> >  	bool			show_threads;
> >  	bool			inverted_callchain;
> > @@ -1206,7 +1210,9 @@ int cmd_report(int argc, const char **argv)
> >  		    "Show per-thread event counters"),
> >  	OPT_STRING(0, "pretty", &report.pretty_printing_style, "key",
> >  		   "pretty printing style key: normal raw"),
> > +#ifdef HAVE_SLANG_SUPPORT
> >  	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
> > +#endif
> >  	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
> >  	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
> >  		    "Use the stdio interface"),
> > @@ -1492,8 +1498,10 @@ int cmd_report(int argc, const char **argv)
> >  
> >  	if (report.use_stdio)
> >  		use_browser = 0;
> > +#ifdef HAVE_SLANG_SUPPORT
> >  	else if (report.use_tui)
> >  		use_browser = 1;
> > +#endif
> >  	else if (report.use_gtk)
> >  		use_browser = 2;
> >  
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 1fc390f136dd..e1a134a0a377 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1486,7 +1486,9 @@ int cmd_top(int argc, const char **argv)
> >  		    "display this many functions"),
> >  	OPT_BOOLEAN('U', "hide_user_symbols", &top.hide_user_symbols,
> >  		    "hide user symbols"),
> > +#ifdef HAVE_SLANG_SUPPORT
> >  	OPT_BOOLEAN(0, "tui", &top.use_tui, "Use the TUI interface"),
> > +#endif
> >  	OPT_BOOLEAN(0, "stdio", &top.use_stdio, "Use the stdio interface"),
> >  	OPT_INCR('v', "verbose", &verbose,
> >  		    "be more verbose (show counter open errors, etc)"),
> > @@ -1667,8 +1669,10 @@ int cmd_top(int argc, const char **argv)
> >  
> >  	if (top.use_stdio)
> >  		use_browser = 0;
> > +#ifdef HAVE_SLANG_SUPPORT
> >  	else if (top.use_tui)
> >  		use_browser = 1;
> > +#endif
> >  
> >  	setup_browser(false);
> >  
> > diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> > index ff8391208ecd..1c2c0a838430 100644
> > --- a/tools/perf/util/top.h
> > +++ b/tools/perf/util/top.h
> > @@ -33,7 +33,10 @@ struct perf_top {
> >  	int		   print_entries, count_filter, delay_secs;
> >  	int		   max_stack;
> >  	bool		   hide_kernel_symbols, hide_user_symbols, zero;
> > -	bool		   use_tui, use_stdio;
> > +#ifdef HAVE_SLANG_SUPPORT
> > +	bool		   use_tui;
> > +#endif
> > +	bool		   use_stdio;
> >  	bool		   vmlinux_warned;
> >  	bool		   dump_symtab;
> >  	bool		   stitch_lbr;
> > -- 
> > 2.35.0.rc0.227.g00780c9af4-goog

-- 

- Arnaldo
