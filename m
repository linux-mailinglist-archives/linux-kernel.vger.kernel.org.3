Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75550C2FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiDVWnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiDVWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:43:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ABA178F41
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C789CB8327E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 21:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78106C385AA;
        Fri, 22 Apr 2022 21:43:00 +0000 (UTC)
Date:   Fri, 22 Apr 2022 17:42:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <mingo@redhat.com>, <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 1/2] tracing: Avoid adding tracer option before
 update_tracer_options
Message-ID: <20220422174258.1f41777a@gandalf.local.home>
In-Reply-To: <20220323152257.7871-2-mark-pk.tsai@mediatek.com>
References: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
        <20220323152257.7871-2-mark-pk.tsai@mediatek.com>
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

On Wed, 23 Mar 2022 23:22:56 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> To prepare for support asynchronous tracer_init_tracefs initcall,
> avoid calling create_trace_option_files before __update_tracer_options.
> Otherwise, create_trace_option_files will show warning because
> some tracers in trace_types list are already in tr->topts.
> 
> For example, hwlat_tracer call register_tracer in late_initcall,
> and global_trace.dir is already created in tracing_init_dentry,
> hwlat_tracer will be put into tr->topts.
> Then if the __update_tracer_options is executed after hwlat_tracer
> registered, create_trace_option_files find that hwlat_tracer is
> already in tr->topts.
> 
> Link: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Before this patch:

 # ls /sys/kernel/tracing/options
annotate	   funcgraph-duration  hex		stacktrace
bin		   funcgraph-irqs      irq-info		sym-addr
blk_cgname	   funcgraph-overhead  latency-format	sym-offset
blk_cgroup	   funcgraph-overrun   markers		sym-userobj
blk_classic	   funcgraph-proc      overwrite	test_nop_accept
block		   funcgraph-tail      pause-on-trace	test_nop_refuse
context-info	   func-no-repeats     printk-msg-only	trace_printk
disable_on_free    func_stack_trace    print-parent	userstacktrace
display-graph	   function-fork       raw		verbose
event-fork	   function-trace      record-cmd
funcgraph-abstime  graph-time	       record-tgid
funcgraph-cpu	   hash-ptr	       sleep-time


After this patch:

 # ls /sys/kernel/tracing/options
annotate      disable_on_free  irq-info         raw          trace_printk
bin           display-graph    latency-format   record-cmd   userstacktrace
blk_cgname    event-fork       markers          record-tgid  verbose
blk_cgroup    function-fork    overwrite        stacktrace
blk_classic   function-trace   pause-on-trace   sym-addr
block         hash-ptr         printk-msg-only  sym-offset
context-info  hex              print-parent     sym-userobj

Not good.

> ---
>  kernel/trace/trace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index eb44418574f9..85ec758c4455 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6317,12 +6317,18 @@ static void tracing_set_nop(struct trace_array *tr)
>  	tr->current_trace = &nop_trace;
>  }
>  
> +static bool tracer_options_updated;
> +
>  static void add_tracer_options(struct trace_array *tr, struct tracer *t)
>  {
>  	/* Only enable if the directory has been created already. */
>  	if (!tr->dir)
>  		return;
>  
> +	/* Only create trace option files after update_tracer_options finish */
> +	if (!tracer_options_updated)
> +		return;
> +
>  	create_trace_option_files(tr, t);
>  }
>  
> @@ -9133,6 +9139,7 @@ static void update_tracer_options(struct trace_array *tr)
>  {
>  	mutex_lock(&trace_types_lock);
>  	__update_tracer_options(tr);
> +	tracer_options_updated = true;

I think you want to set this before the __update, as doing it after just
makes the update a nop.

-- Steve


>  	mutex_unlock(&trace_types_lock);
>  }
>  

