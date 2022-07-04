Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723955659BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiGDP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGDP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:26:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB06BC83;
        Mon,  4 Jul 2022 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yLmRZX6jA00ousM7GAh7IbEYNptWCIMNu7crG86MVgA=; b=IeahdTt0ireNkPVHzQfKdTFtXP
        5qo6ofnGdTfsLWQzKdYPxoLjX7xd6fHaEyT4TayIU+mQNenvwqGoS4NUFZJ9BB8/cYolg6Q9F7Vo8
        jLQW4BWzKkvPHB/8sK40Mv6i+ljH0aWT/WQPLngw7GtyQJVfpJMe9rBjXFHB/jhwa1sFAQJxqUenH
        P+R6yf9OYjE2+NjrBbbGsbpmK8Pp3zC2cyELXDYwn3kxZNBRfPyb9jxu6pd4riVM97BVmlF5C19Ci
        dR3VqDlTb3hjjfSfIN6ERv4GvG/5qtqQh9DOqp6Nac4PdYT7PKOYwZ5SnmcxzPQp1UoDSPJyQb82A
        v6xQ3fGw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Nxd-00HOW1-OI; Mon, 04 Jul 2022 15:26:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBB3F98005D; Mon,  4 Jul 2022 17:26:03 +0200 (CEST)
Date:   Mon, 4 Jul 2022 17:26:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Fix data race between
 perf_event_set_output and perf_mmap_close
Message-ID: <YsMGixSL4CDPTTZs@worktop.programming.kicks-ass.net>
References: <20220704120006.98141-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704120006.98141-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 08:00:06PM +0800, Yang Jihong wrote:
> Data race exists between perf_event_set_output and perf_mmap_close.
> The scenario is as follows:
> 
>                   CPU1                                                       CPU2
>                                                                     perf_mmap_close(event2)
>                                                                       if (atomic_dec_and_test(&event2->rb->mmap_count)  // mmap_count 1 -> 0
>                                                                         detach_rest = true;
> ioctl(event1, PERF_EVENT_IOC_SET_OUTPUT, event2)
>   perf_event_set_output(event1, event2)
>                                                                       if (!detach_rest)
>                                                                         goto out_put;
>                                                                       list_for_each_entry_rcu(event, &event2->rb->event_list, rb_entry)
>                                                                         ring_buffer_attach(event, NULL)
>                                                                       // because event1 has not been added to event2->rb->event_list,
>                                                                       // event1->rb is not set to NULL in these loops
> 
>     ring_buffer_attach(event1, event2->rb)
>       list_add_rcu(&event1->rb_entry, &event2->rb->event_list)
> 
> The above data race causes a problem, that is, event1->rb is not NULL, but event1->rb->mmap_count is 0.
> If the perf_mmap interface is invoked for the fd of event1, the kernel keeps in the perf_mmap infinite loop:
> 
> again:
>         mutex_lock(&event->mmap_mutex);
>         if (event->rb) {
> <SNIP>
>                 if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
>                         /*
>                          * Raced against perf_mmap_close() through
>                          * perf_event_set_output(). Try again, hope for better
>                          * luck.
>                          */
>                         mutex_unlock(&event->mmap_mutex);
>                         goto again;
>                 }
> <SNIP>

Too tired, must look again tomorrow, little feeback below.

>  kernel/events/core.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 80782cddb1da..c67c070f7b39 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5900,6 +5900,7 @@ static void ring_buffer_attach(struct perf_event *event,
>  			       struct perf_buffer *rb)
>  {
>  	struct perf_buffer *old_rb = NULL;
> +	struct perf_buffer *new_rb = rb;
>  	unsigned long flags;
>  
>  	WARN_ON_ONCE(event->parent);
> @@ -5928,6 +5929,20 @@ static void ring_buffer_attach(struct perf_event *event,
>  
>  		spin_lock_irqsave(&rb->event_lock, flags);
>  		list_add_rcu(&event->rb_entry, &rb->event_list);
> +
> +		/*
> +		 * When perf_mmap_close traverses rb->event_list during
> +		 * detach all other events, new event may not be added to
> +		 * rb->event_list, let's check again, if rb->mmap_count is 0,
> +		 * it indicates that perf_mmap_close is executed.
> +		 * Manually delete event from rb->event_list and
> +		 * set event->rb to null.
> +		 */
> +		if (!atomic_read(&rb->mmap_count)) {
> +			list_del_rcu(&event->rb_entry);
> +			new_rb = NULL;
> +		}
> +
>  		spin_unlock_irqrestore(&rb->event_lock, flags);
>  	}
>  
> @@ -5944,7 +5959,7 @@ static void ring_buffer_attach(struct perf_event *event,
>  	if (has_aux(event))
>  		perf_event_stop(event, 0);
>  
> -	rcu_assign_pointer(event->rb, rb);
> +	rcu_assign_pointer(event->rb, new_rb);
>  
>  	if (old_rb) {
>  		ring_buffer_put(old_rb);

I'm confused by the above hunks; the below will avoid calling
ring_buffer_attach() when !rb->mmap_count, so how can the above ever
execute?

> @@ -11883,6 +11898,13 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>  			goto unlock;
>  	}
>  
> +	/*
> +	 * If rb->mmap_count is 0, perf_mmap_close is being executed,
> +	 * the ring buffer is about to be unmapped and cannot be attached.
> +	 */
> +	if (rb && !atomic_read(&rb->mmap_count))
> +		goto unlock;
> +
>  	ring_buffer_attach(event, rb);
>  
>  	ret = 0;

This is wrong I think, it'll leak ring_buffer_get().

