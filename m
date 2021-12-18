Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46933479BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhLRRua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 12:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLRRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 12:50:30 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB923C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 09:50:29 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id q14so5890374qtx.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s48KrK5AuOf1/MWqn46CNFWp2gYF6vzpNwkSPYryhzY=;
        b=LbxRsInLDLmSYUAz1ZzWEC00IVEe4vE+4MkktJL3q+wcPxevbNGFuLyAy7ucMN4t5Q
         vnyQCdWKL3v4fwLFFPUyyLvz42b2vD6AJPsg4oOPe9FpLnBhKK41xFThAoWIgrf06wFF
         04P9A8JSuCYhsmRhOvm2+kNYyQ25c11R+nVMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s48KrK5AuOf1/MWqn46CNFWp2gYF6vzpNwkSPYryhzY=;
        b=lwsjGjL7pBJAxgpRuSHwWCTQmr2/MZNyWsZButqUXiji6K8NX3Pka8Q1sVLX2lxvi8
         VcxmVHTCUJQJpFUzecPK0FlTgVBNe5WwGO65HYLtJFU1qB/P0PtaI/oMChJcctN+goAk
         X3HAiWBbIz17EWUDS2+giy8x+fvUYeBGyiUC+I/neEw94hLPAAVQ+toGtQ82/NVyh+9H
         bNQK4eCOqJ3XJe2Awr+O0hwNOzL/y8qznVk8gTw3QPlva9HEkb/3EDDMtmHDQJtLRTQp
         Mr6qRk1s1NYfdC9BKqVr7CUmqzdYGPfZ6O2YVuM+Hy/uri5CtL0wNmkHLEoXBpt6eGA1
         yrDw==
X-Gm-Message-State: AOAM532VYKHG2CJG5AgcrXWASLHMhseJtgywZ+QEH9Fq1ChB8gjmMXwZ
        bX0VHfHQT2W73YAheGCa4TsLgg==
X-Google-Smtp-Source: ABdhPJyieKlpRoZYEzXw2tChFauWx++kdivkimuhh/vQxwcAFVgnCCbReBwbjUrd5+SW5vMqS8Ailg==
X-Received: by 2002:ac8:4459:: with SMTP id m25mr6752398qtn.659.1639849829027;
        Sat, 18 Dec 2021 09:50:29 -0800 (PST)
Received: from localhost ([2620:0:1004:5:c7a4:7f4e:c595:fd82])
        by smtp.gmail.com with ESMTPSA id br13sm7599406qkb.10.2021.12.18.09.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 09:50:28 -0800 (PST)
Date:   Sat, 18 Dec 2021 12:50:28 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
        vincent.guittot@linaro.org
Subject: Re: [RFC] High latency with core scheduling
Message-ID: <Yb4fZOdeGHyKvxBu@google.com>
References: <Ybvcu5RIwV+Vko09@google.com>
 <20211218000102.GK16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218000102.GK16608@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
Thanks for the reply.

On Sat, Dec 18, 2021 at 01:01:02AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 16, 2021 at 07:41:31PM -0500, Joel Fernandes wrote:
> 
> > One of the issues we see is that the core rbtree is static when nothing in
> > the tree goes to sleep or wakes up. This can cause the same task in the core
> > rbtree to be repeatedly picked in pick_task().
> > 
> > The below diff seems to improve the situation, could you please take a look?
> > If it seems sane, we can go ahead and make it a formal patch to at least fix
> > one of the known issues.
> > 
> > The patch is simple, just remove the currently running task from the core rb
> > tree as its vruntime is not really static. Add it back on preemption.
> 
> > note: This is against a 5.4 kernel, but the code is about the same and its RFC.
> 
> I think you'll find there's significant differences..

Sure, the scheduler keeps changing and we have to be careful what and how we
backport to products. The bar for backporting is pretty high like it has to
fix a visible bug or cause any non-trivial improvement. That's why its
important for you to consider taking stable backports seriously (like by
CC'ing stable on critical fixes so products get them. I hope you do consider
caring about stable since bug fixes are no good if no one gets them or gets
them after half a decade :-) ).  See below for more replies on the issues we
are discussing:

> > note: The issue does not seem to happen without CGroups involved so perhaps
> >       something is wonky in cfs_prio_less() still. Peter?
> 
> that's weird... but it's also 00h30 am, so who knows :-)

It seems cfs_prio_less() falls apart from the following usecase (thanks
Vineeth for discussing this with me):

root group
  /  \
 T1   G2
      / \
     T2 T3

Say T1 and T2 are *not* tagged, and T3 is tagged. All are CFS tasks and, T2
and T3 are in CGroup G2.

Say T1 is highest dynamic priority and runs for some time, while it is
running T2 is selected to run on a different hyperthread because it is
compatible with T1.

Because T2 gets to run, G2's vruntime moves forward.

Because both G2 and T1 have their vruntime moving forward at the same time,
T1 will always end up being higher priority than G2.

End result is T3 gets starved.

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index c023a9a0c4ae..3c588ad05ab6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -200,7 +200,7 @@ static inline void dump_scrb(struct rb_node *root, int lvl, char *buf, int size)
> >  	dump_scrb(root->rb_right, lvl+1, buf, size);
> >  }
> >  
> > -static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
> > +void sched_core_enqueue(struct rq *rq, struct task_struct *p)
> >  {
> >  	struct rb_node *parent, **node;
> >  	struct task_struct *node_task;
> > @@ -212,6 +212,9 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
> >  	if (!p->core_cookie)
> >  		return;
> >  
> > +	if (sched_core_enqueued(p))
> > +		return;
> 
> Are you actually hitting that? It feels wrong.

Yes, in initial version of the diff, the system wasn't booting without this.
You're right its likely not needed any more.

> > +		cookie_pick = rq->curr;
> > +	}
> 
> This is the part that doesn't apply.. We completely rewrote the pick
> loop. I think you're looking at a change in sched_core_find() now.
> Basically it should check rq->curr against whatever it finds in the
> core_tree, right?

Yeah but the core tree is static even with that re-write, so it still has the
issue. Right?

Yes, we need to update the pick loop with the upstream version. That gets
hard to do on older kernels/products as it adds risk to already tested code.
But if the pick loop rewrite fixed a bug, we should definitely prioritize
backporting that.

> > +
> >  	/*
> >  	 * If class > max && class > cookie, it is the highest priority task on
> >  	 * the core (so far) and it must be selected, otherwise we must go with
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 86cc67dd38e9..820c5cf4ecc1 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1936,15 +1936,33 @@ struct sched_class {
> >  #endif
> >  };
> >  
> > +void sched_core_enqueue(struct rq *rq, struct task_struct *p);
> > +void sched_core_dequeue(struct rq *rq, struct task_struct *p);
> > +
> >  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
> >  {
> >  	WARN_ON_ONCE(rq->curr != prev);
> >  	prev->sched_class->put_prev_task(rq, prev);
> > +#ifdef CONFIG_SCHED_CORE
> > +	if (sched_core_enabled(rq) && READ_ONCE(prev->state) != TASK_DEAD && prev->core_cookie && prev->on_rq) {
> 
> That TASK_DEAD thing is weird... do_task_dead() goes something like:
> 
> 	set_special_state(TASK_DEAD)
> 	schedule()
> 	  deactivate_task(prev)
> 	    prev->on_rq = 0;
> 	    dequeue_task()
> 	      sched_core_dequeue() /* also wrong, see below */
> 	      prev->sched_class->dequeue_task()
> 	  ...
> 	  next = pick_next_task(..,prev,..);
> 	    put_prev_task()
> 	      if (... && prev->on_rq /* false */)
> 	        sched_core_enqueue()
> 
> 
> Notably, the sched_core_dequeue() in dequeue_task() shouldn't happen
> either, because it's current and as such shouldn't be enqueued to begin
> with.

Yes, you're right. The TASK_DEAD check should likely not be needed. We'll do
a thorough investigation of where all the core tree queues/dequeues are
happening.

> > +		sched_core_enqueue(rq, prev);
> > +	}
> > +#endif
> >  }
> >  
> >  static inline void set_next_task(struct rq *rq, struct task_struct *next)
> >  {
> >  	next->sched_class->set_next_task(rq, next, false);
> > +#ifdef CONFIG_SCHED_CORE
> > +	/*
> > +	 * This task is going to run next and its vruntime will change.
> > +	 * Remove it from core rbtree so as to not confuse the ordering
> > +	 * in the rbtree when its vrun changes.
> > +	 */
> > +	if (sched_core_enabled(rq) && next->core_cookie && next->on_rq) {
> > +		sched_core_dequeue(rq, next);
> > +	}
> > +#endif
> 
> Anyway... *ouch* at the additional rb-tree ops, but I think you're right
> about needing this :/

Thanks for acknowledging the issue.

thanks!

 - Joel

