Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BD510061
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbiDZO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350915AbiDZO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E3A5B3C3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83E4F616F9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3DC385A0;
        Tue, 26 Apr 2022 14:25:03 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:25:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH v2 3/4] tracing: Replace usage of found with dedicated
 list iterator variable
Message-ID: <20220426102502.67aa7916@gandalf.local.home>
In-Reply-To: <20220402103341.1763932-4-jakobkoschel@gmail.com>
References: <20220402103341.1763932-1-jakobkoschel@gmail.com>
        <20220402103341.1763932-4-jakobkoschel@gmail.com>
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

On Sat,  2 Apr 2022 12:33:40 +0200
Jakob Koschel <jakobkoschel@gmail.com> wrote:

> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  kernel/trace/trace_events_hist.c    | 17 ++++++++---------
>  kernel/trace/trace_events_trigger.c | 28 +++++++++++++---------------
>  2 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 44db5ba9cabb..7f60d04d5b6e 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6089,32 +6089,31 @@ static void hist_unregister_trigger(char *glob,
>  				    struct event_trigger_data *data,
>  				    struct trace_event_file *file)
>  {
> +	struct event_trigger_data *test = NULL, *iter, *named_data = NULL;
>  	struct hist_trigger_data *hist_data = data->private_data;
> -	struct event_trigger_data *test, *named_data = NULL;
> -	bool unregistered = false;
>  
>  	lockdep_assert_held(&event_mutex);
>  
>  	if (hist_data->attrs->name)
>  		named_data = find_named_trigger(hist_data->attrs->name);
>  
> -	list_for_each_entry(test, &file->triggers, list) {
> -		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
> -			if (!hist_trigger_match(data, test, named_data, false))
> +	list_for_each_entry(iter, &file->triggers, list) {
> +		if (iter->cmd_ops->trigger_type == ETT_EVENT_HIST) {
> +			if (!hist_trigger_match(data, iter, named_data, false))
>  				continue;
> -			unregistered = true;
> -			list_del_rcu(&test->list);
> +			test = iter;
> +			list_del_rcu(&iter->list);
>  			trace_event_trigger_enable_disable(file, 0);
>  			update_cond_flag(file);
>  			break;
>  		}
>  	}
>  
> -	if (unregistered && test->ops->free)
> +	if (test && test->ops->free)
>  		test->ops->free(test->ops, test);
>  
>  	if (hist_data->enable_timestamps) {
> -		if (!hist_data->remove || unregistered)
> +		if (!hist_data->remove || test)
>  			tracing_set_filter_buffering(file->tr, false);
>  	}
>  }
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 7eb9d04f1c2e..1ba54a489416 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -614,22 +614,21 @@ static void unregister_trigger(char *glob,
>  			       struct event_trigger_data *test,
>  			       struct trace_event_file *file)
>  {
> -	struct event_trigger_data *data;
> -	bool unregistered = false;
> +	struct event_trigger_data *data = NULL, *iter;
>  
>  	lockdep_assert_held(&event_mutex);
>  
> -	list_for_each_entry(data, &file->triggers, list) {
> -		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
> -			unregistered = true;
> -			list_del_rcu(&data->list);
> +	list_for_each_entry(iter, &file->triggers, list) {
> +		if (iter->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
> +			data = iter;
> +			list_del_rcu(&iter->list);

Don't use the iterator in the logic.

			data = iter;
			list_del_rcu(&data->list);

  is just fine.

>  			trace_event_trigger_enable_disable(file, 0);
>  			update_cond_flag(file);
>  			break;
>  		}
>  	}
>  
> -	if (unregistered && data->ops->free)
> +	if (data && data->ops->free)
>  		data->ops->free(data->ops, data);
>  }
>  
> @@ -1976,27 +1975,26 @@ void event_enable_unregister_trigger(char *glob,
>  				     struct trace_event_file *file)
>  {
>  	struct enable_trigger_data *test_enable_data = test->private_data;
> +	struct event_trigger_data *data = NULL, *iter;
>  	struct enable_trigger_data *enable_data;
> -	struct event_trigger_data *data;
> -	bool unregistered = false;
>  
>  	lockdep_assert_held(&event_mutex);
>  
> -	list_for_each_entry(data, &file->triggers, list) {
> -		enable_data = data->private_data;
> +	list_for_each_entry(iter, &file->triggers, list) {
> +		enable_data = iter->private_data;
>  		if (enable_data &&
> -		    (data->cmd_ops->trigger_type ==
> +		    (iter->cmd_ops->trigger_type ==
>  		     test->cmd_ops->trigger_type) &&
>  		    (enable_data->file == test_enable_data->file)) {
> -			unregistered = true;
> -			list_del_rcu(&data->list);
> +			data = iter;
> +			list_del_rcu(&iter->list);

Same here.

And please rebase on top of Linus's lastest tree.

-- Steve


>  			trace_event_trigger_enable_disable(file, 0);
>  			update_cond_flag(file);
>  			break;
>  		}
>  	}
>  
> -	if (unregistered && data->ops->free)
> +	if (data && data->ops->free)
>  		data->ops->free(data->ops, data);
>  }
>  

