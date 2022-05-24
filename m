Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119995333D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbiEXXR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiEXXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488671A2A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BAB761800
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F92C34117;
        Tue, 24 May 2022 23:17:20 +0000 (UTC)
Date:   Tue, 24 May 2022 19:17:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH] ftrace/fgraph: fix increased missing-prototypes
 warnings
Message-ID: <20220524191718.5d906700@gandalf.local.home>
In-Reply-To: <20220506032737.23375-1-zhouchengming@bytedance.com>
References: <20220506032737.23375-1-zhouchengming@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change this fixes was merged into the ARM tree and I do not have that
code, so I can not apply this.

-- Steve


On Fri,  6 May 2022 11:27:37 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> After commit e999995c84c3 ("ftrace: cleanup ftrace_graph_caller enable
> and disable") merged into the linux-next tree, the kernel test robot
> (lkp@intel.com) has send out report that there are increased missing-prototypes
> warnings caused by that commit.
> 
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 \
> 	O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/
> warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
> 
> BTW there are so many missing-prototypes warnings if build kernel with "W=1".
> 
> The increased warnings for 'ftrace_[enable,disable]_ftrace_graph_caller'
> is caused by CONFIG_FUNCTION_GRAPH_TRACER && !CONFIG_DYNAMIC_FTRACE,
> so the declarations in <linux/ftrace.h> can't be seen in fgraph.c.
> 
> And this warning can't reproduce on x86_64 since x86_64 select
> HAVE_FUNCTION_GRAPH_TRACER only when DYNAMIC_FTRACE, so fgraph.c will
> always see the declarations in <linux/ftrace.h>.
> 
> This patch fix the increased warnings by put the definitions in
> CONFIG_DYNAMIC_FTRACE although there are no real problems exist.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/trace/fgraph.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 289311680c29..2cd374294be7 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -30,6 +30,7 @@ int ftrace_graph_active;
>  /* Both enabled by default (can be cleared by function_graph tracer flags */
>  static bool fgraph_sleep_time = true;
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE
>  /*
>   * archs can override this function if they must do something
>   * to enable hook for graph tracer.
> @@ -47,6 +48,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
>  {
>  	return 0;
>  }
> +#endif
>  
>  /**
>   * ftrace_graph_stop - set to permanently disable function graph tracing

