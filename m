Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97F577685
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGQOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGQOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:01:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766BBF4B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23DB3CE0E93
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E8DC3411E;
        Sun, 17 Jul 2022 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658066464;
        bh=kPrXq4s7FhU3O3sAvSQWtL6Um5wrTy7pKXsIY4QLLFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Che6jrwXT6JA0zNNg+mc9qinJh124uoQmoSrjHDE79mePwkMl4735T0cQDW7mY0xd
         Kss7csZ0/+1RdOmHz1z99bxT2Lc09hS+6P+y2TKN9L/7QmroAqB/HGWxKOpK0hjDg4
         JqsYS1F59j44yIUZH2eDhMcHQrnTKi0Rx1hfRMsqe3CeOf8H16ITgFPAABF8d4luYQ
         KxDGmyG0/qK9VEa6IrAJph+fkDq+VWLJGMMTeu3tvcCGxV1Vhtl9sMGIx6T2Os8ZM4
         /s75HCgsdNeaxEmUnMBf/Qo7yFblrKRLuqMFl2P67wwO0ber0l95E7qpP+TYVkZ6gs
         ANp7RiLJy8VQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0237040374; Sun, 17 Jul 2022 11:01:01 -0300 (-03)
Date:   Sun, 17 Jul 2022 11:01:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Fix SIGSEGV when processing syscall args
Message-ID: <YtQWHTddjHhsqnOZ@kernel.org>
References: <20220707090900.572584-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707090900.572584-1-naveen.n.rao@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 07, 2022 at 02:39:00PM +0530, Naveen N. Rao escreveu:
> On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
> process a perf.data file created with 'perf trace record -p':
> 
>   #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <snip> at builtin-trace.c:1492
>   #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
>   #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
>   #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at builtin-trace.c:1973
>   #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
>   #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2319
> 
> That points to the below code in tools/perf/builtin-trace.c:
> 	/*
> 	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
> 	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
> 	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
> 	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
> 	 * so when handling, say the openat syscall, we end up getting 6 args for the
> 	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
> 	 * thinking that the extra 2 u64 args are the augmented filename, so just check
> 	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
> 	 */
> 	if (evsel != trace->syscalls.events.sys_enter)
> 		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
> 
> As the comment points out, we should not be trying to augment the args
> for raw_syscalls. However, when processing a perf.data file, we are not
> initializing those properly. Fix the same.

Thanks, applied.

- Arnaldo

 
> Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 897fc504918b91..f075cf37a65ef8 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4280,6 +4280,7 @@ static int trace__replay(struct trace *trace)
>  		goto out;
>  
>  	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_enter");
> +	trace->syscalls.events.sys_enter = evsel;
>  	/* older kernels have syscalls tp versus raw_syscalls */
>  	if (evsel == NULL)
>  		evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_enter");
> @@ -4292,6 +4293,7 @@ static int trace__replay(struct trace *trace)
>  	}
>  
>  	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_exit");
> +	trace->syscalls.events.sys_exit = evsel;
>  	if (evsel == NULL)
>  		evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_exit");
>  	if (evsel &&
> 
> base-commit: 52f28b7bac75da9b8508f17438c9a8d83ab48e5d
> -- 
> 2.36.1

-- 

- Arnaldo
