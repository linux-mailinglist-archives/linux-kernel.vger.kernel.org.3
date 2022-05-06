Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3527651E10F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444455AbiEFVcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444438AbiEFVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF763BE4;
        Fri,  6 May 2022 14:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FEFEB839AB;
        Fri,  6 May 2022 21:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AFEC385B1;
        Fri,  6 May 2022 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651872491;
        bh=TrYz36ByuOKHwQfb3qqopQ1AYMU8C+k/4MDexI93QUY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oscvdUzEY/MEz+p61DYvzSU4OoJ39dxH7LZ1wK/W1t+mngTwIgS5jlhp+2Bc7cMXo
         uGOy9K8jPQwDbMbV+SDdE01LRhF7PLjvpLT00Pht2rGqGXQ1YG0lRTFSaEaDBZDPTa
         RYbb9VMWlcAAho7wyzNZZMNyspZJpESwN43fnQku3bm1ogmPI8N9bM29P0c9RUl2b6
         /cJGM1aMJBLrRRxoeT7T8CLNFooMVzV7UXtirz9fqVsVWX2+DP55F8HUioXOHr/uLx
         +poqwy59Ch0K8FeADJ7qS2FcTyr+K2v0D6I3g7SpstI1O+6TWu6iCaBNg0CUSeNALr
         hyEL7z7LtftiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB4BD5C08B7; Fri,  6 May 2022 11:59:55 -0700 (PDT)
Date:   Fri, 6 May 2022 11:59:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Message-ID: <20220506185955.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505155236.1559619-1-qiang1.zhang@intel.com>
 <20220505192956.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A25078A7D4DBAB1267C2DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220506040141.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880F4D73760DCA42238A29DDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880F4D73760DCA42238A29DDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 12:43:35PM +0000, Zhang, Qiang1 wrote:
> 
> On Fri, May 06, 2022 at 12:40:09AM +0000, Zhang, Qiang1 wrote:
> > On Thu, May 05, 2022 at 11:52:36PM +0800, Zqiang wrote:
> > > Currently, the rnp's cbovlmask is set in call_rcu(). when CPU going 
> > > offline, the outgoing CPU's callbacks is migrated to target CPU, the 
> > > number of callbacks on the my_rdp may be overloaded, if overload and 
> > > there is no call_rcu() call on target CPU for a long time, the rnp's 
> > > cbovldmask is not set in time. in order to fix this situation, add
> > > check_cb_ovld_locked() in rcutree_migrate_callbacks() to help CPU 
> > > more quickly reach quiescent states.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > >Doesn't this get set right at the end of the current grace period?
> > >Given that there is a callback overload, there should be a grace period in progress.
> > >
> > >See this code in rcu_gp_cleanup():
> > >
> > >		if (rcu_is_leaf_node(rnp))
> > >			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
> > >				rdp = per_cpu_ptr(&rcu_data, cpu);
> > >				check_cb_ovld_locked(rdp, rnp);
> > >			}
> > >
> > >So what am I missing here?  Or are you planning to remove the above code?
> > 
> > We only checked the overloaded rdp at the end of current grace period, 
> > for my_rdp overloaded cause by migration callbacks to it,  if the 
> > my_rdp overloaded, and the my_rdp->mynode 's cbovldmask  is empty,  
> > the my_rdp overloaded may be not checked at end of the current grace period.
> >
> >Very good!
> >
> > I have another question, why don't we call check_cb_ovld_locked() when rdp's n_cbs decreases.
> > for example call check_cb_ovld_locked() in rcu_do_bacth(), not at the end of grace period.
> 
> >The idea (as you noted above) is that it gets cleared at the end of each grace period.  We could also clear it in rcu_do_batch() as you suggest, but to make that change you would need to convince me that the extra overhead and complexity would provide a useful benefit.  This will not be easy.  ;-)
> 
> > >If so, wouldn't you also need to clear the indication for the CPU that is going offline, being careful to handle the case where the two CPUs have different leaf rcu_node structures?
> > 
> > Yes the offline CPU need to clear.
> >
> >But again, the clearing happens at the end of the next grace period.
> >Here we lose (almost) nothing by leaving the bit set because the other bit is set as well.
> >
> >Another question, as long as we brought up rcu_do_batch().
> >
> >Why have the local variable "empty" given that the local variable "count"
> >could be checked against zero?
> 
> Thanks for reminding
> I noticed  when RCU_NOCB_CPU and DEBUG_OBJECTS_RCU_HEAD is not enable . 
> double call call_rcu() will cause the rdp->cblist's len increase, but
> actually, the number of objects in the rdp->cblist has not changed.  the
> WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) && count != 0 && empty)
> will be triggered.

In this case, the system is probably dead anyway due to the callback being
reused.  But good point, this is a case where the counts can diverge.

Let this be a lesson to you.  Never invoke call_rcu() on an rcu_head
structure that is already queued waiting for a grace period to elapse.  ;-)

> When RCU_NOCB_CPU is enabled, even without double call call_rcu().  due to nocb  bypass
> Some objects may be in the rdp->nocb_bypass list, this causes the count to be non-zero 
> when the rdp->cblist list is empty.

Exactly!  Very good!!!

							Thanx, Paul

> >In the meantime, I have queued your commit for v5.20, thank you and good eyes!  As always, I could not resist the urge to wordsmith the commit log, so could you please check it for errors?
> 
> Thank you very much.
> 
> >							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 5c36f04bd460246dd28c178ce5dce6fb02f898e1
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Thu May 5 23:52:36 2022 +0800
> 
>     rcu: Add rnp->cbovldmask check in rcutree_migrate_callbacks()
>     
>     Currently, the rcu_node structure's ->cbovlmask field is set in call_rcu()
>     when a given CPU is suffering from callback overload.  But if that CPU
>     goes offline, the outgoing CPU's callbacks is migrated to the running
>     CPU, which is likely to overload the running CPU.  However, that CPU's
>     bit in its leaf rcu_node structure's ->cbovlmask field remains zero.
>     
>     Initially, this is OK because the outgoing CPU's bit remains set.
>     However, that bit will be cleared at the next end of a grace period,
>     at which time it is quite possible that the running CPU will still
>     be overloaded.  If the running CPU invokes call_rcu(), then overload
>     will be checked for and the bit will be set.  Except that there is no
>     guarantee that the running CPU will invoke call_rcu(), in which case the
>     next grace period will fail to take the running CPU's overload condition
>     into account.  Plus, because the bit is not set, the end of the grace
>     period won't check for overload on this CPU.
>     
>     This commit therefore adds a call to check_cb_ovld_locked() in
>     check_cb_ovld_locked() to set the running CPU's ->cbovlmask bit
>     appropriately.
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 9dc4c4e82db62..bcc5876c9753b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4577,6 +4577,7 @@ void rcutree_migrate_callbacks(int cpu)
>  	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
>  	rcu_segcblist_disable(&rdp->cblist);
>  	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
> +	check_cb_ovld_locked(my_rdp, my_rnp);
>  	if (rcu_rdp_is_offloaded(my_rdp)) {
>  		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
>  		__call_rcu_nocb_wake(my_rdp, true, flags);
