Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707D44D665E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiCKQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350380AbiCKQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:33:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D91C65C5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:31:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B3061C0D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73738C340E9;
        Fri, 11 Mar 2022 16:31:55 +0000 (UTC)
Date:   Fri, 11 Mar 2022 11:31:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <mingo@redhat.com>, <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] tracing: make tracer_init_tracefs initcall asynchronous
Message-ID: <20220311113153.2d627800@gandalf.local.home>
In-Reply-To: <20220311112656.25348-1-mark-pk.tsai@mediatek.com>
References: <20220311112656.25348-1-mark-pk.tsai@mediatek.com>
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

On Fri, 11 Mar 2022 19:26:56 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> tracer_init_tracefs() is slow especially when there are
> lots of trace events.
> Create a kthread to do tracer_init_tracefs() asynchronously

When making comments like this, please provide the benchmarks you used,
with the numbers before and after.

> to speed up the initialization of kernel and move the
> related functions and variables out of init section.

Thus we sacrifice memory for boot time. I'd like to also see how much
memory is freed from init before and after this patch.

> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  fs/tracefs/inode.c          |  8 ++++----
>  kernel/trace/ftrace.c       | 12 ++++++------
>  kernel/trace/trace.c        | 21 ++++++++++++++++-----
>  kernel/trace/trace_events.c |  2 +-
>  4 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index de7252715b12..9a713d6bcb7e 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -561,10 +561,10 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
>   *
>   * Returns the dentry of the instances directory.
>   */
> -__init struct dentry *tracefs_create_instance_dir(const char *name,
> -					  struct dentry *parent,
> -					  int (*mkdir)(const char *name),
> -					  int (*rmdir)(const char *name))
> +struct dentry *tracefs_create_instance_dir(const char *name,
> +					   struct dentry *parent,
> +					   int (*mkdir)(const char *name),
> +					   int (*rmdir)(const char *name))
>  {
>  	struct dentry *dentry;
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index a4b462b6f944..197630cbd5dd 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -940,7 +940,7 @@ static const struct file_operations ftrace_profile_fops = {
>  };
>  
>  /* used to initialize the real stat files */
> -static struct tracer_stat function_stats __initdata = {
> +static struct tracer_stat function_stats = {
>  	.name		= "functions",
>  	.stat_start	= function_stat_start,
>  	.stat_next	= function_stat_next,
> @@ -949,7 +949,7 @@ static struct tracer_stat function_stats __initdata = {
>  	.stat_show	= function_stat_show
>  };
>  
> -static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
> +static void ftrace_profile_tracefs(struct dentry *d_tracer)
>  {
>  	struct ftrace_profile_stat *stat;
>  	struct dentry *entry;
> @@ -991,7 +991,7 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
>  }
>  
>  #else /* CONFIG_FUNCTION_PROFILER */
> -static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
> +static void ftrace_profile_tracefs(struct dentry *d_tracer)
>  {
>  }
>  #endif /* CONFIG_FUNCTION_PROFILER */
> @@ -6359,7 +6359,7 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
>  	mutex_unlock(&ftrace_lock);
>  }
>  
> -static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
> +static int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
>  {
>  
>  	trace_create_file("available_filter_functions", TRACE_MODE_READ,
> @@ -7754,8 +7754,8 @@ void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  			  d_tracer, tr, &ftrace_no_pid_fops);
>  }
>  
> -void __init ftrace_init_tracefs_toplevel(struct trace_array *tr,
> -					 struct dentry *d_tracer)
> +void ftrace_init_tracefs_toplevel(struct trace_array *tr,
> +				  struct dentry *d_tracer)
>  {
>  	/* Only the top level directory has the dyn_tracefs and profile */
>  	WARN_ON(!(tr->flags & TRACE_ARRAY_FL_GLOBAL));
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index eb44418574f9..f55da82060e2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9562,10 +9562,10 @@ int tracing_init_dentry(void)
>  extern struct trace_eval_map *__start_ftrace_eval_maps[];
>  extern struct trace_eval_map *__stop_ftrace_eval_maps[];
>  
> -static struct workqueue_struct *eval_map_wq __initdata;
> -static struct work_struct eval_map_work __initdata;
> +static struct workqueue_struct *eval_map_wq;
> +static struct work_struct eval_map_work;
>  
> -static void __init eval_map_work_func(struct work_struct *work)
> +static void eval_map_work_func(struct work_struct *work)
>  {
>  	int len;
>  
> @@ -9573,7 +9573,7 @@ static void __init eval_map_work_func(struct work_struct *work)
>  	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
>  }
>  
> -static int __init trace_eval_init(void)
> +static int trace_eval_init(void)
>  {
>  	INIT_WORK(&eval_map_work, eval_map_work_func);
>  
> @@ -9671,7 +9671,7 @@ static struct notifier_block trace_module_nb = {
>  };
>  #endif /* CONFIG_MODULES */
>  
> -static __init int tracer_init_tracefs(void)
> +static int tracefs_init(void *data)
>  {
>  	int ret;
>  
> @@ -9721,6 +9721,17 @@ static __init int tracer_init_tracefs(void)
>  	return 0;
>  }
>  
> +static __init int tracer_init_tracefs(void)
> +{
> +	struct task_struct *thread;
> +
> +	thread = kthread_run(tracefs_init, NULL, "tracefs_init");
> +	if (IS_ERR(thread))
> +		return PTR_ERR(thread);
> +
> +	return 0;
> +}
> +
>  fs_initcall(tracer_init_tracefs);
>  
>  static int trace_panic_handler(struct notifier_block *this,
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 3147614c1812..fe055bef1e8f 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3687,7 +3687,7 @@ static __init int event_trace_init_fields(void)
>  	return 0;
>  }
>  
> -__init int event_trace_init(void)
> +int event_trace_init(void)
>  {
>  	struct trace_array *tr;
>  	struct dentry *entry;

Hmm, this calls early_event_tracer() which is also in __init. Looks like
there's going to be a ripple effect due to this change.

If we want to go this route, then first a change must be made to remove the
needed functions from init, and then see if we can consolidate it. As there
are some init functions that are duplicated for init purposes.

-- Steve
