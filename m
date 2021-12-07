Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F2246BD69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhLGOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:22:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58350 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhLGOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:22:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D434B817BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9606EC341C3;
        Tue,  7 Dec 2021 14:18:44 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:18:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: use WARN instead of printk and WARN_ON
Message-ID: <20211207091843.0765fa3f@gandalf.local.home>
In-Reply-To: <1638881732-3157-1-git-send-email-wangqing@vivo.com>
References: <1638881732-3157-1-git-send-email-wangqing@vivo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Dec 2021 04:55:32 -0800
Qing Wang <wangqing@vivo.com> wrote:

> From: Wang Qing <wangqing@vivo.com>
> 
> Simply use WARN instead of printk(KERN_WARNING, ...) and WARN_ON.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  kernel/trace/trace_output.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 3547e71..e0348ec
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -775,8 +775,7 @@ int register_trace_event(struct trace_event *event)
>  		list_add_tail(&event->list, list);
>  
>  	} else if (event->type > __TRACE_LAST_TYPE) {
> -		printk(KERN_WARNING "Need to add type to trace.h\n");
> -		WARN_ON(1);
> +		WARN(1, "Need to add type to trace.h\n");

If you are going to fix this, then please fix it properly.

	} else if (WARN(event->type > __TRACE_LAST_TYPE,
			"Need to add type to trace.h")) {

>  		goto out;
>  	} else {
>  		/* Is this event already used */
> @@ -1569,11 +1568,9 @@ __init static int init_events(void)
>  		event = events[i];
>  
>  		ret = register_trace_event(event);
> -		if (!ret) {
> -			printk(KERN_WARNING "event %d failed to register\n",
> -			       event->type);
> -			WARN_ON_ONCE(1);
> -		}
> +		if (!ret)
> +			WARN_ONCE(1, "event %d failed to register\n",
> +				  event->type);

And this should just turn into:

		WARN_ONCE(!ret, "event %d failed to register", event->type);

-- Steve


>  	}
>  
>  	return 0;

