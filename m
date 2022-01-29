Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80E4A30AA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352733AbiA2QhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiA2QhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:37:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900FC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 540B2B827C6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CADC340E5;
        Sat, 29 Jan 2022 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643474242;
        bh=9V2PsIVfGM10lLF4yZ4EtnkIU5xar4/Tv+/Ai7QSZtw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WwT7LLaZX5wifQDF3J492y47tk/GLUajntexLqMxuphpryg7yo9uovl1NiYdUF+fm
         m9gUFbA4KSD/rb1sEVN4Hs+5uKPc8HhVfD/hWEA5EUNXzFAppXhksWJfuAkaSC2FsT
         RMZjsEwffTDYaq6fwrhQBllsMFykKKC18rCSVhotMAux2eVnZWkqqR7mFyoKoFh12G
         8+hHjcUF2GISgdOaIVN3ee2fwkmtgFSBwIkbVAlNxMJCpVK62qBjnyQ/vkadKhXA6N
         trVQ9SbUs3GBbYmwameqoemT104F/z2Qbf8FPxtzxCqxOHCAokPD0unWIkJ2xIplRp
         Zjba6BSfR8TdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF7425C03AE; Sat, 29 Jan 2022 08:37:21 -0800 (PST)
Date:   Sat, 29 Jan 2022 08:37:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup
 waitqueue is not requried
Message-ID: <20220129163721.GQ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220128031346.157961-1-qiang1.zhang@intel.com>
 <20220129051748.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880073B7080265117EE2868DA239@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880073B7080265117EE2868DA239@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 05:55:34AM +0000, Zhang, Qiang1 wrote:
> 
> On Fri, Jan 28, 2022 at 11:13:46AM +0800, Zqiang wrote:
> > When grace period cleanup, the rcuog kthreads that waiting in sq 
> > waitqueue will be awakened, however if the 'rcu_nocb_poll' is set, the 
> > sq waitqueue always empty, so if 'rcu_nocb_poll' is set, return 
> > directly.
> 
> >This does decrease grace-period-cleanup overhead in kernels built with CONFIG_RCU_NOCB_CPU=y and booted with the rcu_nocb_poll kernel boot parameter set.  On the other hand, it increases grace-period-cleanup overhead in kernels built with CONFIG_RCU_NOCB_CPU=y but booted without the rcu_nocb_poll kernel boot parameter set.
> >
> >Last I checked, more kernels were booted without the rcu_nocb_poll kernel boot parameter set.  If this is still the case, this patch would slow things down for most systems.
> >
> >Or are there now lots of systems booted with rcu_nocb_poll?
> 
> Hi Paul
> I found that some of our customers configured rcu_nocb_poll startup parameters under Preempt-RT kernel.
> at each grace period cleanup, we'll all wakeup sq waitqueue, however when rcuog kthreads is in polling mode, 
> the wakeup operation doesn't required, because the sq waitqueue always empty.

OK, fair enough.  But was there any difference in performance measurable
at the system level?  Let's take a look at swake_up_all():

	void swake_up_all(struct swait_queue_head *q)
	{
		struct swait_queue *curr;
		LIST_HEAD(tmp);

		raw_spin_lock_irq(&q->lock);
		list_splice_init(&q->task_list, &tmp);
		while (!list_empty(&tmp)) {
			curr = list_first_entry(&tmp, typeof(*curr), task_list);

			wake_up_state(curr->task, TASK_NORMAL);
			list_del_init(&curr->task_list);

			if (list_empty(&tmp))
				break;

			raw_spin_unlock_irq(&q->lock);
			raw_spin_lock_irq(&q->lock);
		}
		raw_spin_unlock_irq(&q->lock);
	}

If the list is empty, we acquire an uncontended lock, splice an empty
list, check a pair of pointers for equality, and release that lock.
We do this once per 16 CPUs per grace period, which normally will be
every few milliseconds or less frequently.

What is the system-level performance difference and how did you measure
it?

Please don't get me wrong.  If this really is causing your users trouble,
we clearly do need to fix it.  But if so, let's do so in a way that
doesn't risk penalizing the many users who do not set rcu_nocb_poll.

							Thanx, Paul

> Thanks,
> Zqiang
> 
> >
> >							Thanx, Paul
> 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index 
> > 636d0546a4e9..9e106c590e56 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -201,6 +201,8 @@ static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
> >   */
> >  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)  {
> > +	if (rcu_nocb_poll)
> > +		return;
> >  	swake_up_all(sq);
> >  }
> >  
> > --
> > 2.25.1
> > 
