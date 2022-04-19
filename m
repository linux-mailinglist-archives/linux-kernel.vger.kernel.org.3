Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595E506915
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350798AbiDSKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350795AbiDSKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:51:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514711CFE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pia42eYWUXDGfQPlliFB9bh+93t0WxAscUmkE30teBA=; b=qkF+3PEDemB83mZFp0Dv4DMWZf
        rjIhQF9OXE+HWSlTGsU7kCZBVpwoTLzPxmoLL/NKRBjXE15xdhKbL/LyXC4GPAVso9Q7ae0xXTqkY
        C06Cg+5A9F5nhY1l6g8ULTnvp9WsZe+lHIlB370m9ru8Y98Jgml/cwxnhzNfi+ppcBV8+8Q6WnrdL
        +EOTmBGvtmSlskDMhNhnZsI/IdNsgJGJbKNjb/5W4d18BTQLGyQU6rORQKQzF5nVzvpQGQvRnYZqG
        BypdD92WtdSg0AhKgjMgnUvvn9+bks9qoXqQjka8PcI9lcA5QSIHgj2Jjd0K1MjhbZy6DxyNYv9SW
        pR0SXaqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nglPK-0030oU-5P; Tue, 19 Apr 2022 10:48:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32144986195; Tue, 19 Apr 2022 12:48:28 +0200 (CEST)
Date:   Tue, 19 Apr 2022 12:48:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Avoid obvious double update_rq_clock warning
Message-ID: <20220419104828.GQ2731@worktop.programming.kicks-ass.net>
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418090929.54005-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 05:09:29PM +0800, Hao Jia wrote:
> When we use raw_spin_rq_lock to acquire the rq lock and have to
> update the rq clock while holding the lock, the kernel may issue
> a WARN_DOUBLE_CLOCK warning.
> 
> Since we directly use raw_spin_rq_lock to acquire rq lock instead of
> rq_lock, there is no corresponding change to rq->clock_update_flags.
> In particular, we have obtained the rq lock of other cores,
> the core rq->clock_update_flags may be RQCF_UPDATED at this time, and
> then calling update_rq_clock will trigger the WARN_DOUBLE_CLOCK warning.

> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  kernel/sched/deadline.c | 18 +++++++++++-------
>  kernel/sched/rt.c       | 20 ++++++++++++++++++--

Very good for keeping them in sync.

>  2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fb4255ae0b2c..9207b978cc43 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

> @@ -2317,16 +2318,14 @@ static int push_dl_task(struct rq *rq)
>  		goto retry;
>  	}
>  
> +	rq_pin_lock(rq, &srf);
> +	rq_pin_lock(later_rq, &drf);
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, later_rq->cpu);
> -
> -	/*
> -	 * Update the later_rq clock here, because the clock is used
> -	 * by the cpufreq_update_util() inside __add_running_bw().
> -	 */
> -	update_rq_clock(later_rq);
> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> +	activate_task(later_rq, next_task, 0);
>  	ret = 1;
> +	rq_unpin_lock(rq, &srf);
> +	rq_unpin_lock(later_rq, &drf);
>  
>  	resched_curr(later_rq);
>  

> @@ -2413,11 +2413,15 @@ static void pull_dl_task(struct rq *this_rq)
>  			if (is_migration_disabled(p)) {
>  				push_task = get_push_task(src_rq);
>  			} else {
> +				rq_pin_lock(this_rq, &this_rf);
> +				rq_pin_lock(src_rq, &src_rf);
>  				deactivate_task(src_rq, p, 0);
>  				set_task_cpu(p, this_cpu);
>  				activate_task(this_rq, p, 0);
>  				dmin = p->dl.deadline;
>  				resched = true;
> +				rq_unpin_lock(this_rq, &this_rf);
> +				rq_unpin_lock(src_rq, &src_rf);
>  			}
>  
>  			/* Is there any other task even earlier? */

I'm really not sure about this part though. This is a bit of a mess. The
balancer doesn't really need the pinning stuff. I realize you did that
because we got the clock annotation mixed up with that, but urgh.

Basically we want double_rq_lock() / double_lock_balance() to clear
RQCF_UPDATED, right? Perhaps do that directly?

(maybe with an inline helper and a wee comment?)

The only immediate problem with this would appear to be that
_double_rq_lock() behaves differently when it returns 0. Not sure that
matters.

Hmm?


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f259621f4c93..be4baec84430 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -610,10 +610,13 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 		swap(rq1, rq2);
 
 	raw_spin_rq_lock(rq1);
-	if (__rq_lockp(rq1) == __rq_lockp(rq2))
-		return;
+	if (__rq_lockp(rq1) != __rq_lockp(rq2))
+		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
 
-	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+#ifdef CONFIG_SCHED_DEBUG
+	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
 }
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..3ca8dd5ca17c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2644,6 +2644,10 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	BUG_ON(rq1 != rq2);
 	raw_spin_rq_lock(rq1);
 	__acquire(rq2->lock);	/* Fake it out ;) */
+#ifdef CONFIG_SCHED_DEBUG
+	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
 }
 
 /*
