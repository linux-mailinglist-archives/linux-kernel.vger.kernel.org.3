Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50974D0761
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiCGTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiCGTQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:16:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AB7CDCA;
        Mon,  7 Mar 2022 11:15:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4646B8167A;
        Mon,  7 Mar 2022 19:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42696C340EB;
        Mon,  7 Mar 2022 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646680513;
        bh=td5XA/vasPQzk2dJn/2PdCjukKMBaa8j+bLAS4+mKCk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YYUCqr68s2efIf+qL+Ov/nYK3ID7rndO+/BzWZHEFEbH/vNmfXqBlPQ94F70Phi+X
         6654CSGtwy1huUQfFeTpRK3H2ltjd49oX6wMHzXzyKH9d5bbzSmaSbSziJgYcuqdnC
         tRdS1fgQ1gXcU9SM+mk/ST/NCrWVw0GiBNhpecYdbMWw5mpSz7EOf6boWRy6SAFaPd
         Sj0jsy3CNCWdZwVOzPTAl17vnNKeIz16/O0t0Nsaui8A6hftRN+YzUqOmziWBXZSfP
         /3HCcaPc4DRjQRDq7nP2LfRQgZr9avKOKM+qsBagBFLyKNsguSXtvwDfn7y7l5uTJf
         0NB/vQGOavZFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E44925C0260; Mon,  7 Mar 2022 11:15:12 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:15:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, bigeasy@linutronix.de
Subject: Re: [PATCH] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <20220307191512.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
 <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
 <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:03:17AM +0000, Zhang, Qiang1 wrote:
> On 3/4/2022 2:56 PM, Zqiang wrote:
> > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > who are blocking a given grace period, if the current reader tasks
> > have a higher priority than boost kthreads(the boost kthreads priority
> > not always 1, if the kthread_prio is set), boosting is useless, skip
> > current task and select next task to boosting, reduce the time for a
> > given grace period.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Adding to CC to get more eyes on this.  I am not necessarily opposed to
it, but I don't do that much RT work myself these days.

							Thanx, Paul

> > ---
> >   kernel/rcu/tree_plugin.h | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index c3d212bc5338..d35b6da66bbd 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -12,6 +12,7 @@
> >    */
> >   
> >   #include "../locking/rtmutex_common.h"
> > +#include <linux/sched/deadline.h>
> >   
> >   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> >   {
> > @@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
> >   	 * section.
> >   	 */
> >   	t = container_of(tb, struct task_struct, rcu_node_entry);
> > +	if (!rnp->exp_tasks && (dl_task(t) || t->prio <= current->prio)) {
> > +		tb = rcu_next_node_entry(t, rnp);
> > +		WRITE_ONCE(rnp->boost_tasks, tb);
> > +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > +		goto end;
> > +	}
> > +
> >   	rt_mutex_init_proxy_locked(&rnp->boost_mtx.rtmutex, t);
> >   	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >   	/* Lock only for side effect: boosts task t's priority. */
> >   	rt_mutex_lock(&rnp->boost_mtx);
> >   	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
> >   	rnp->n_boosts++;
> > -
> > +end:
> >>
> >>Nit: maybe rename the label to "skip_boost:" ?
> >>
> >>Code looks fine; however, out of curiosity; given that the higher 
> >>priority tasks, in general, would exit their read side critical section
> >>quickly and boost the next blocking reader on exiting their read side 
> >>section; do you see noticeable reduction in grace period timings with 
> >>the change for certain type of workloads?
> 
> Thanks for feedback ,  In preempt-RT systems, there will be many real-time threads (most
> of them are created by users themselves ),  their priority is higher or lower than boost kthreads
> (kthread_prio is set),  for rt tasks  with higher priority than boost kthreads, maybe it will exit
> read side critical quickly,  maybe not, if it is preempted by a higher priority task,  If try to boost operation, 
> this increases the boosts kthread waiting time, as a result, the next blkd tasks cannot be
> boosted in time.  of course, I don't deny it,  there are also reasons that user priority setting is inappropriate.
> 
> Thanks
> Zqiang
> 
> >>
> >>
> >>Thanks
> >>Neeraj
> 
> >   	return READ_ONCE(rnp->exp_tasks) != NULL ||
> >   	       READ_ONCE(rnp->boost_tasks) != NULL;
> >   }
