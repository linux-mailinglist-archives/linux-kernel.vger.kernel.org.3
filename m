Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19E50EC57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiDYXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiDYXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:02:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828AA41FA9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC6361586
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CBCC385A7;
        Mon, 25 Apr 2022 22:59:00 +0000 (UTC)
Date:   Mon, 25 Apr 2022 18:58:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <jolsa@redhat.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Reset the function filter after completing
 trampoline/graph selftest
Message-ID: <20220425185859.29e8f9d8@gandalf.local.home>
In-Reply-To: <20220418073958.104029-1-lihuafei1@huawei.com>
References: <20220418073958.104029-1-lihuafei1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 15:39:58 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> The direct trampoline and graph coexistence test sets global_ops to
> trace only 'trace_selftest_dynamic_test_func', but does not reset it
> after the test is completed, resulting in the function filter being set
> already after the system starts. Although it can be reset through the
> tracefs interface, it is more or less confusing to the user, and we
> should reset it to trace all functions after the trampoline/graph test
> completes.
> 
> Fixes: 130c08065848 ("tracing: Add trampoline/graph selftest")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/trace/trace_selftest.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index abcadbe933bb..e89f72571f8e 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -866,12 +866,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
>  				     (unsigned long) trace_direct_tramp);
>  	if (ret)
> -		goto out;
> +		goto reset_filter;
>  
>  	ret = register_ftrace_graph(&fgraph_ops);
>  	if (ret) {
>  		warn_failed_init_tracer(trace, ret);
> -		goto out;
> +		goto reset_filter;
>  	}
>  
>  	DYN_FTRACE_TEST_NAME();
> @@ -887,14 +887,18 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
>  				       (unsigned long) trace_direct_tramp);
>  	if (ret)
> -		goto out;
> +		goto reset_filter;
>  
>  	tracing_start();
>  
>  	if (!ret && !count) {
>  		ret = -1;
> -		goto out;
> +		goto reset_filter;

No need for all the 'goto reset_filter', if this function fails, then the
tracer is disabled, and there's no reason to clear the filter. In fact, it
may cause a crash (because something bad happened).

-- Steve


>  	}
> +
> +reset_filter:
> +	/* Enable tracing on all functions again */
> +	ftrace_set_global_filter(NULL, 0, 1);
>  #endif
>  
>  	/* Don't test dynamic tracing, the function tracer already did */

