Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BCB4EE481
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbiCaXMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbiCaXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:12:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9998E09A1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BD44B82207
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5079FC340ED;
        Thu, 31 Mar 2022 23:10:07 +0000 (UTC)
Date:   Thu, 31 Mar 2022 19:10:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] ftrace: remove check of list iterator against head past
 the loop body
Message-ID: <20220331191005.2954969f@gandalf.local.home>
In-Reply-To: <20220331223752.902726-1-jakobkoschel@gmail.com>
References: <20220331223752.902726-1-jakobkoschel@gmail.com>
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

On Fri,  1 Apr 2022 00:37:52 +0200
Jakob Koschel <jakobkoschel@gmail.com> wrote:

Hi Jakob,

The patch looks fine, I have some small nits though.

First, the subject should actually be:

Subject: [PATCH] tracing: Remove check of list iterator against head past the loop body

Changes that only deal specifically with the function probes are labeled as
"ftrace:", but the more generic changes that touches files outside of
ftrace.c and fgraph.c should be "tracing:". Also, Linus prefers to have the
next part of the subject start with a capital letter: "Remove" instead of
"remove".

> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
> 
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
> 
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  kernel/trace/ftrace.c       | 20 ++++++++++++--------
>  kernel/trace/trace_eprobe.c | 14 ++++++++------
>  kernel/trace/trace_events.c | 12 ++++++------
>  3 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4f1d2f5e7263..096f5a83358d 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4560,8 +4560,8 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
>  			       struct ftrace_probe_ops *probe_ops,
>  			       void *data)
>  {
> +	struct ftrace_func_probe *probe = NULL, *iter;
>  	struct ftrace_func_entry *entry;
> -	struct ftrace_func_probe *probe;
>  	struct ftrace_hash **orig_hash;
>  	struct ftrace_hash *old_hash;
>  	struct ftrace_hash *hash;
> @@ -4580,11 +4580,13 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
>  
>  	mutex_lock(&ftrace_lock);
>  	/* Check if the probe_ops is already registered */
> -	list_for_each_entry(probe, &tr->func_probes, list) {
> -		if (probe->probe_ops == probe_ops)
> +	list_for_each_entry(iter, &tr->func_probes, list) {
> +		if (iter->probe_ops == probe_ops) {
> +			probe = iter;
>  			break;
> +		}
>  	}
> -	if (&probe->list == &tr->func_probes) {
> +	if (!probe) {
>  		probe = kzalloc(sizeof(*probe), GFP_KERNEL);
>  		if (!probe) {
>  			mutex_unlock(&ftrace_lock);
> @@ -4704,7 +4706,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
>  {
>  	struct ftrace_ops_hash old_hash_ops;
>  	struct ftrace_func_entry *entry;
> -	struct ftrace_func_probe *probe;
> +	struct ftrace_func_probe *probe = NULL, *iter;

Can you move this to the first declaration to keep the nice "upside-down
x-mas tree" look.

>  	struct ftrace_glob func_g;
>  	struct ftrace_hash **orig_hash;
>  	struct ftrace_hash *old_hash;
> @@ -4732,11 +4734,13 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
>  
>  	mutex_lock(&ftrace_lock);
>  	/* Check if the probe_ops is already registered */
> -	list_for_each_entry(probe, &tr->func_probes, list) {
> -		if (probe->probe_ops == probe_ops)
> +	list_for_each_entry(iter, &tr->func_probes, list) {
> +		if (iter->probe_ops == probe_ops) {
> +			probe = iter;
>  			break;
> +		}
>  	}
> -	if (&probe->list == &tr->func_probes)
> +	if (!probe)
>  		goto err_unlock_ftrace;
>  
>  	ret = -EINVAL;
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 541aa13581b9..63e901a28425 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -650,7 +650,7 @@ static struct trace_event_functions eprobe_funcs = {
>  static int disable_eprobe(struct trace_eprobe *ep,
>  			  struct trace_array *tr)
>  {
> -	struct event_trigger_data *trigger;
> +	struct event_trigger_data *trigger = NULL, *iter;
>  	struct trace_event_file *file;
>  	struct eprobe_data *edata;
>  
> @@ -658,14 +658,16 @@ static int disable_eprobe(struct trace_eprobe *ep,
>  	if (!file)
>  		return -ENOENT;
>  
> -	list_for_each_entry(trigger, &file->triggers, list) {
> -		if (!(trigger->flags & EVENT_TRIGGER_FL_PROBE))
> +	list_for_each_entry(iter, &file->triggers, list) {
> +		if (!(iter->flags & EVENT_TRIGGER_FL_PROBE))
>  			continue;
> -		edata = trigger->private_data;
> -		if (edata->ep == ep)
> +		edata = iter->private_data;
> +		if (edata->ep == ep) {
> +			trigger = iter;
>  			break;
> +		}
>  	}
> -	if (list_entry_is_head(trigger, &file->triggers, list))
> +	if (!trigger)
>  		return -ENODEV;
>  
>  	list_del_rcu(&trigger->list);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index e11e167b7809..fe3dc157e635 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2281,7 +2281,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  		    struct trace_event_file *file, struct dentry *parent)
>  {
>  	struct trace_subsystem_dir *dir;
> -	struct event_subsystem *system;
> +	struct event_subsystem *system, *iter;

And move this above dir as well, for the same reason.

Thanks,

-- Steve


>  	struct dentry *entry;
>  
>  	/* First see if we did not already create this dir */
> @@ -2295,13 +2295,13 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  	}
>  
>  	/* Now see if the system itself exists. */
> -	list_for_each_entry(system, &event_subsystems, list) {
> -		if (strcmp(system->name, name) == 0)
> +	system = NULL;
> +	list_for_each_entry(iter, &event_subsystems, list) {
> +		if (strcmp(iter->name, name) == 0) {
> +			system = iter;
>  			break;
> +		}
>  	}
> -	/* Reset system variable when not found */
> -	if (&system->list == &event_subsystems)
> -		system = NULL;
>  
>  	dir = kmalloc(sizeof(*dir), GFP_KERNEL);
>  	if (!dir)
> 
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275

