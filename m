Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59074797B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 01:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhLRABa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 19:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLRABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 19:01:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mn47uzGbKULz1+bcMFUi6yun/6AQ2/GYaGeo8ns1Ce4=; b=ojv+afRx/+ks0+itPxh6UVM55F
        J9nlaguEPgon4I8xjISSzCRyH1fYMQU1HLMLPYbz6UNJaHhimMeOLHAmIYfQxHJLE5znpLNrPK5Bl
        v5y6CxAIsretz/kSGFQo1VShORzcHoKztkr9y2MAx4FFOq3WS3FhxOgWCn3DDhMea45qSh6sWqMsm
        11RzMyiHm+UiYWKAybMX70re/Ej/SAURRZ0toj9imCLugcpxIb/yvb74cjweyX58OPeU1Zbtqjifd
        fkhgrV8+tKXhzdcavIk/WIvWJUijzhJUiwe0p/QfQ7krnDCDNnOxRSoybKpb2hoGHiUz77j3zjz8S
        c/U4g8nQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myN9r-00HB8U-58; Sat, 18 Dec 2021 00:01:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72D769862C4; Sat, 18 Dec 2021 01:01:02 +0100 (CET)
Date:   Sat, 18 Dec 2021 01:01:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Josh Don <joshdon@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "AubreyLi@google.com" <aubrey.intel@gmail.com>,
        aubrey.li@linux.intel.com, Aaron Lu <aaron.lwe@gmail.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Don Hiatt <dhiatt@digitalocean.com>, ricardo.neri@intel.com,
        vincent.guittot@linaro.org, joelaf@google.com
Subject: Re: [RFC] High latency with core scheduling
Message-ID: <20211218000102.GK16608@worktop.programming.kicks-ass.net>
References: <Ybvcu5RIwV+Vko09@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybvcu5RIwV+Vko09@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 07:41:31PM -0500, Joel Fernandes wrote:

> One of the issues we see is that the core rbtree is static when nothing in
> the tree goes to sleep or wakes up. This can cause the same task in the core
> rbtree to be repeatedly picked in pick_task().
> 
> The below diff seems to improve the situation, could you please take a look?
> If it seems sane, we can go ahead and make it a formal patch to at least fix
> one of the known issues.
> 
> The patch is simple, just remove the currently running task from the core rb
> tree as its vruntime is not really static. Add it back on preemption.

> note: This is against a 5.4 kernel, but the code is about the same and its RFC.

I think you'll find there's significant differences..

> note: The issue does not seem to happen without CGroups involved so perhaps
>       something is wonky in cfs_prio_less() still. Peter?

that's weird... but it's also 00h30 am, so who knows :-)

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c023a9a0c4ae..3c588ad05ab6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -200,7 +200,7 @@ static inline void dump_scrb(struct rb_node *root, int lvl, char *buf, int size)
>  	dump_scrb(root->rb_right, lvl+1, buf, size);
>  }
>  
> -static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
> +void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  {
>  	struct rb_node *parent, **node;
>  	struct task_struct *node_task;
> @@ -212,6 +212,9 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  	if (!p->core_cookie)
>  		return;
>  
> +	if (sched_core_enqueued(p))
> +		return;

Are you actually hitting that? It feels wrong.

>  	node = &rq->core_tree.rb_node;
>  	parent = *node;
>  
> @@ -232,7 +235,7 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  	rb_insert_color(&p->core_node, &rq->core_tree);
>  }
>  
> -static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> +void sched_core_dequeue(struct rq *rq, struct task_struct *p)
>  {
>  	rq->core->core_task_seq++;
>  
> @@ -4745,6 +4748,18 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
>  		return class_pick;
>  
>  	cookie_pick = sched_core_find(rq, cookie);
> +
> +	/*
> +	 * Currently running process might not be in the runqueue if fair class.
> +	 * If it is of the same cookie as cookie_pick and has more priority,
> +	 * then select it.
> +	 */
> +	if (rq != this_rq() && !is_task_rq_idle(cookie_pick) && !is_task_rq_idle(rq->curr) &&
> +		cookie_pick->core_cookie == rq->curr->core_cookie &&
> +		prio_less(cookie_pick, rq->curr, in_fi)) {

guys, this indent style kills infants.

> +		cookie_pick = rq->curr;
> +	}

This is the part that doesn't apply.. We completely rewrote the pick
loop. I think you're looking at a change in sched_core_find() now.
Basically it should check rq->curr against whatever it finds in the
core_tree, right?

> +
>  	/*
>  	 * If class > max && class > cookie, it is the highest priority task on
>  	 * the core (so far) and it must be selected, otherwise we must go with
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 86cc67dd38e9..820c5cf4ecc1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1936,15 +1936,33 @@ struct sched_class {
>  #endif
>  };
>  
> +void sched_core_enqueue(struct rq *rq, struct task_struct *p);
> +void sched_core_dequeue(struct rq *rq, struct task_struct *p);
> +
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>  {
>  	WARN_ON_ONCE(rq->curr != prev);
>  	prev->sched_class->put_prev_task(rq, prev);
> +#ifdef CONFIG_SCHED_CORE
> +	if (sched_core_enabled(rq) && READ_ONCE(prev->state) != TASK_DEAD && prev->core_cookie && prev->on_rq) {

That TASK_DEAD thing is weird... do_task_dead() goes something like:

	set_special_state(TASK_DEAD)
	schedule()
	  deactivate_task(prev)
	    prev->on_rq = 0;
	    dequeue_task()
	      sched_core_dequeue() /* also wrong, see below */
	      prev->sched_class->dequeue_task()
	  ...
	  next = pick_next_task(..,prev,..);
	    put_prev_task()
	      if (... && prev->on_rq /* false */)
	        sched_core_enqueue()


Notably, the sched_core_dequeue() in dequeue_task() shouldn't happen
either, because it's current and as such shouldn't be enqueued to begin
with.


> +		sched_core_enqueue(rq, prev);
> +	}
> +#endif
>  }
>  
>  static inline void set_next_task(struct rq *rq, struct task_struct *next)
>  {
>  	next->sched_class->set_next_task(rq, next, false);
> +#ifdef CONFIG_SCHED_CORE
> +	/*
> +	 * This task is going to run next and its vruntime will change.
> +	 * Remove it from core rbtree so as to not confuse the ordering
> +	 * in the rbtree when its vrun changes.
> +	 */
> +	if (sched_core_enabled(rq) && next->core_cookie && next->on_rq) {
> +		sched_core_dequeue(rq, next);
> +	}
> +#endif

Anyway... *ouch* at the additional rb-tree ops, but I think you're right
about needing this :/

Just please, think through the whole enqueue/dequeue thing because even
for an rfc this seems overly sloppy.

