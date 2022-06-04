Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA153D79E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiFDQD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiFDQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 12:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2A286DA;
        Sat,  4 Jun 2022 09:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6428C60E8F;
        Sat,  4 Jun 2022 16:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED8AC385B8;
        Sat,  4 Jun 2022 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358633;
        bh=ZN+4KgfxWcOwSaMGIOBFEHBu/Dm9p0xts0efbrS4AP4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RYFfosEyXRoJm1vLy7b8WUW8aRcf7hAJEd0LK4vwgvPHkZkkj1xvHtoKusB3ncGpz
         PkhITWvFRktUJ1evDgiYgjGtKHKrMb/0CFcX50C4L0nG4mdDS09cl4pqKgaT0qqPpg
         SHnIK3qvgRtu7tUfg8XCnWyMexdu0E26lwrUq7lzevc/f2+HXnQYg6pgFtQnPUeAMr
         bghpL5wA9e0F40Y14P2VkYQoyI1RqYhVnOWjNiDoTTrk60fa9AxRxdW+RAJrAFtw0i
         uzK1RoYMGEW61S6Zt3NjDwUfxB2czh8tZ5A+fpOlRZaYXqx4GbfEo56wEriVOT64M9
         Wt9l+antn2iCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57DB15C04E6; Sat,  4 Jun 2022 09:03:53 -0700 (PDT)
Date:   Sat, 4 Jun 2022 09:03:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Remove useless monitor_todo flag
Message-ID: <20220604160353.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220602080644.432156-1-urezki@gmail.com>
 <YplLK2BcTn2oM0hr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YplLK2BcTn2oM0hr@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:43:39PM +0000, Joel Fernandes wrote:
> On Thu, Jun 02, 2022 at 10:06:43AM +0200, Uladzislau Rezki (Sony) wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > monitor_todo is not needed as the work struct already tracks
> > if work is pending. Just use that to know if work is pending
> > using schedule_delayed_work() helper.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 222d59299a2a..fd16c0b46d9e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3295,7 +3295,6 @@ struct kfree_rcu_cpu_work {
> >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> >   * @lock: Synchronize access to this structure
> >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> >   * @initialized: The @rcu_work fields have been initialized
> >   * @count: Number of objects for which GP not started
> >   * @bkvcache:
> > @@ -3320,7 +3319,6 @@ struct kfree_rcu_cpu {
> >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> >  	raw_spinlock_t lock;
> >  	struct delayed_work monitor_work;
> > -	bool monitor_todo;
> >  	bool initialized;
> >  	int count;
> >  
> > @@ -3500,6 +3498,18 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	}
> >  }
> >  
> > +static bool
> > +need_offload_krc(struct kfree_rcu_cpu *krcp)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < FREE_N_CHANNELS; i++)
> > +		if (krcp->bkvhead[i])
> > +			return true;
> > +
> > +	return !!krcp->head;
> > +}
> 
> Thanks for modifying my original patch to do this, and thanks for giving me
> the attribution for the patch. This function is a nice addition.
> 
> For the patch in its entirety:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I pulled this one in for testing and further review, thank you both!

Given the description, I reversed the order of the Signed-off-by
tags to indicate that the patch came through Uladzislau from Joel.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> > +
> >  /*
> >   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> >   */
> > @@ -3556,9 +3566,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >  	// of the channels that is still busy we should rearm the
> >  	// work to repeat an attempt. Because previous batches are
> >  	// still in progress.
> > -	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
> > -		krcp->monitor_todo = false;
> > -	else
> > +	if (need_offload_krc(krcp))
> >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  
> >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > @@ -3746,11 +3754,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	WRITE_ONCE(krcp->count, krcp->count + 1);
> >  
> >  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > -	    !krcp->monitor_todo) {
> > -		krcp->monitor_todo = true;
> > +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > -	}
> >  
> >  unlock_return:
> >  	krc_this_cpu_unlock(krcp, flags);
> > @@ -3825,14 +3830,8 @@ void __init kfree_rcu_scheduler_running(void)
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >  
> >  		raw_spin_lock_irqsave(&krcp->lock, flags);
> > -		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
> > -				krcp->monitor_todo) {
> > -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > -			continue;
> > -		}
> > -		krcp->monitor_todo = true;
> > -		schedule_delayed_work_on(cpu, &krcp->monitor_work,
> > -					 KFREE_DRAIN_JIFFIES);
> > +		if (need_offload_krc(krcp))
> > +			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >  	}
> >  }
> > -- 
> > 2.30.2
> > 
