Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8D487CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiAGS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:58:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiAGS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:57:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDB2EB826D7;
        Fri,  7 Jan 2022 18:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D1AC36AE0;
        Fri,  7 Jan 2022 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641581851;
        bh=FyNWGzfcKGqhD6HtVa6E88uU1lNTBW4ZjhctypUoluc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3UaqwTkRQ4QWF0wTORaXJiwx4GaU2drKZdq0p20JD+53V3UkfxiPJ5KQJpOJ9FAs
         NEFSfkLbGxAPFQMXoZvjuaPaEGxchG74+rq5IH3PvIVO6r5XQYsmt847tODk4SQkt0
         jEecbKaEwTLuo4CH2NqApD0e52Nf64QVNy4GZ8bqCu38QiYWMq9h0dUZHT0owEROOO
         Wyc2FmFWpnnVOLfoQ9nUF1JbqU4bqQjTD8o9juhy4EI3H2ti3PteIPFix9RCGo4W+t
         0TvkUHHG7+UaPT75yOkuTh1psB8M4VeQHz7zl3YtlGQ5d+PrXWsTZT6oQaCp4HYKxH
         iIzYrFD/A8QUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D54740B92; Fri,  7 Jan 2022 15:57:28 -0300 (-03)
Date:   Fri, 7 Jan 2022 15:57:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Christy Lee <christyc.y.lee@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Move SIGCHLD handler init to trace__run
Message-ID: <YdiNGGNPG3DpTEUe@kernel.org>
References: <20220106222030.227499-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106222030.227499-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 06, 2022 at 11:20:30PM +0100, Jiri Olsa escreveu:
> When running perf trace with bpf object like:
>   # perf trace -e openat,/.../tools/perf/examples/bpf/hello.c
> 
> the event parsing eventually calls llvm__get_kbuild_opts function
> that runs script and that ends up with SIGCHLD delivered to perf
> trace handler, which assumes the workload process is done and quits
> perf trace.
> 
> Moving the SIGCHLD handler setup directly to trace__run, where the
> event is parsed and object already compiled.


Thanks, reproduced the problem without the patch, applied, tested again,
works.

- Arnaldo

 
> Cc: Christy Lee <christyc.y.lee@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 94d62a92f1a1..4282ef9ec354 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3925,6 +3925,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	bool draining = false;
>  
>  	trace->live = true;
> +	signal(SIGCHLD, sig_handler);
>  
>  	if (!trace->raw_augmented_syscalls) {
>  		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> @@ -4876,7 +4877,6 @@ int cmd_trace(int argc, const char **argv)
>  
>  	signal(SIGSEGV, sighandler_dump_stack);
>  	signal(SIGFPE, sighandler_dump_stack);
> -	signal(SIGCHLD, sig_handler);
>  	signal(SIGINT, sig_handler);
>  
>  	trace.evlist = evlist__new();
> -- 
> 2.33.1

-- 

- Arnaldo
