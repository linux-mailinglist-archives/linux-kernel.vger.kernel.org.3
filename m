Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701BC532E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiEXQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiEXQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BDB1EACA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3140C6090C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034F7C34113;
        Tue, 24 May 2022 16:07:14 +0000 (UTC)
Date:   Tue, 24 May 2022 12:07:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] tracing: Use trace_create_file() to simplify
 creation of tracefs entries
Message-ID: <20220524120713.6bd853d9@gandalf.local.home>
In-Reply-To: <20220114131052.534382-1-ytcoode@gmail.com>
References: <20220113142314.2bd7eebe@gandalf.local.home>
        <20220114131052.534382-1-ytcoode@gmail.com>
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

On Fri, 14 Jan 2022 21:10:52 +0800
Yuntao Wang <ytcoode@gmail.com> wrote:

> Creating tracefs entries with tracefs_create_file() followed by pr_warn()
> is tedious and repetitive, we can use trace_create_file() to simplify
> this process and make the code more readable.

Sorry I missed this patch (I was in the process of changing jobs when it
was sent out, and I had COVID :-p ). I'll add it to my queue.

Masami, this touches trace_kprobes.c, care to ACK that part?

Thanks,

-- Steve


> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> Changes since v1:
> - Remove format change updates
> 
> Changes since v2:
> - Remove unused variables
> 
>  kernel/trace/ftrace.c                 |  9 +++------
>  kernel/trace/trace_dynevent.c         |  9 ++-------
>  kernel/trace/trace_events.c           | 29 +++++++++------------------
>  kernel/trace/trace_kprobe.c           | 15 ++++----------
>  kernel/trace/trace_recursion_record.c |  7 ++-----
>  5 files changed, 21 insertions(+), 48 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 403e485bf091..6d9bb73d19d3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -952,7 +952,6 @@ static struct tracer_stat function_stats __initdata = {
>  static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
>  {
>  	struct ftrace_profile_stat *stat;
> -	struct dentry *entry;
>  	char *name;
>  	int ret;
>  	int cpu;
> @@ -983,11 +982,9 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
>  		}
>  	}
>  
> -	entry = tracefs_create_file("function_profile_enabled",
> -				    TRACE_MODE_WRITE, d_tracer, NULL,
> -				    &ftrace_profile_fops);
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'function_profile_enabled' entry\n");
> +	trace_create_file("function_profile_enabled",
> +			  TRACE_MODE_WRITE, d_tracer, NULL,
> +			  &ftrace_profile_fops);
>  }
>  
>  #else /* CONFIG_FUNCTION_PROFILER */
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index e34e8182ee4b..076b447a1b88 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -255,19 +255,14 @@ static const struct file_operations dynamic_events_ops = {
>  /* Make a tracefs interface for controlling dynamic events */
>  static __init int init_dynamic_event(void)
>  {
> -	struct dentry *entry;
>  	int ret;
>  
>  	ret = tracing_init_dentry();
>  	if (ret)
>  		return 0;
>  
> -	entry = tracefs_create_file("dynamic_events", TRACE_MODE_WRITE, NULL,
> -				    NULL, &dynamic_events_ops);
> -
> -	/* Event list interface */
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'dynamic_events' entry\n");
> +	trace_create_file("dynamic_events", TRACE_MODE_WRITE, NULL,
> +			  NULL, &dynamic_events_ops);
>  
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 3147614c1812..718518b3c491 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3446,12 +3446,10 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  	struct dentry *d_events;
>  	struct dentry *entry;
>  
> -	entry = tracefs_create_file("set_event", TRACE_MODE_WRITE, parent,
> -				    tr, &ftrace_set_event_fops);
> -	if (!entry) {
> -		pr_warn("Could not create tracefs 'set_event' entry\n");
> +	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
> +				  tr, &ftrace_set_event_fops);
> +	if (!entry)
>  		return -ENOMEM;
> -	}
>  
>  	d_events = tracefs_create_dir("events", parent);
>  	if (!d_events) {
> @@ -3466,16 +3464,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  
>  	/* There are not as crucial, just warn if they are not created */
>  
> -	entry = tracefs_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
> -				    tr, &ftrace_set_event_pid_fops);
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'set_event_pid' entry\n");
> +	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
> +			  tr, &ftrace_set_event_pid_fops);
>  
> -	entry = tracefs_create_file("set_event_notrace_pid",
> -				    TRACE_MODE_WRITE, parent, tr,
> -				    &ftrace_set_event_notrace_pid_fops);
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'set_event_notrace_pid' entry\n");
> +	trace_create_file("set_event_notrace_pid",
> +			  TRACE_MODE_WRITE, parent, tr,
> +			  &ftrace_set_event_notrace_pid_fops);
>  
>  	/* ring buffer internal formats */
>  	trace_create_file("header_page", TRACE_MODE_READ, d_events,
> @@ -3690,17 +3684,14 @@ static __init int event_trace_init_fields(void)
>  __init int event_trace_init(void)
>  {
>  	struct trace_array *tr;
> -	struct dentry *entry;
>  	int ret;
>  
>  	tr = top_trace_array();
>  	if (!tr)
>  		return -ENODEV;
>  
> -	entry = tracefs_create_file("available_events", TRACE_MODE_READ,
> -				    NULL, tr, &ftrace_avail_fops);
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'available_events' entry\n");
> +	trace_create_file("available_events", TRACE_MODE_READ,
> +			  NULL, tr, &ftrace_avail_fops);
>  
>  	ret = early_event_add_tracer(NULL, tr);
>  	if (ret)
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 3d85323278ed..5c35c2311690 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1906,25 +1906,18 @@ core_initcall(init_kprobe_trace_early);
>  static __init int init_kprobe_trace(void)
>  {
>  	int ret;
> -	struct dentry *entry;
>  
>  	ret = tracing_init_dentry();
>  	if (ret)
>  		return 0;
>  
> -	entry = tracefs_create_file("kprobe_events", TRACE_MODE_WRITE,
> -				    NULL, NULL, &kprobe_events_ops);
> -
>  	/* Event list interface */
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'kprobe_events' entry\n");
> +	trace_create_file("kprobe_events", TRACE_MODE_WRITE,
> +			  NULL, NULL, &kprobe_events_ops);
>  
>  	/* Profile interface */
> -	entry = tracefs_create_file("kprobe_profile", TRACE_MODE_READ,
> -				    NULL, NULL, &kprobe_profile_ops);
> -
> -	if (!entry)
> -		pr_warn("Could not create tracefs 'kprobe_profile' entry\n");
> +	trace_create_file("kprobe_profile", TRACE_MODE_READ,
> +			  NULL, NULL, &kprobe_profile_ops);
>  
>  	setup_boot_kprobe_events();
>  
> diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
> index 4d4b78c8ca25..a520b11afb0d 100644
> --- a/kernel/trace/trace_recursion_record.c
> +++ b/kernel/trace/trace_recursion_record.c
> @@ -224,12 +224,9 @@ static const struct file_operations recursed_functions_fops = {
>  
>  __init static int create_recursed_functions(void)
>  {
> -	struct dentry *dentry;
>  
> -	dentry = trace_create_file("recursed_functions", TRACE_MODE_WRITE,
> -				   NULL, NULL, &recursed_functions_fops);
> -	if (!dentry)
> -		pr_warn("WARNING: Failed to create recursed_functions\n");
> +	trace_create_file("recursed_functions", TRACE_MODE_WRITE,
> +			  NULL, NULL, &recursed_functions_fops);
>  	return 0;
>  }
>  

