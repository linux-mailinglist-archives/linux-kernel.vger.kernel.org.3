Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119444F1EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380990AbiDDVtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380378AbiDDTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3C559A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 367CC60E2C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE5CC340F3;
        Mon,  4 Apr 2022 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649101747;
        bh=4nne+0xo3HzeHab2dyKdi13sxHLq2lRKM4wjOgC56CA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ux4OdoOfyenToZ88WA0AcmvBseEZGnfqTlD4Rz4Y50tWafo9+Inn5HKQ2p47uEn6Y
         XGcl9YZENcaXKEvD0uVBLBeu8TlNRovgawgq/rPzcdt3UHnQ7EiwkvgILc2DWNm3z8
         gFX3s9ep+fU+N099/BSyowflvX5o6diDZXnesh5bQNuNTIH2WzLPZOjQarJZZELzsa
         Xqfnm8NXuD48WUNIdWjnbF1Du3EitY/mM4oTw/O8/4/Wz9x+UQ+WNGun1g5P3fu0S3
         g151tYhMqMtH/Jdp0Ytjg04sjGrB5dXX+nkylF8+xjlicTcXaPZE1UUnTMNCzsMMWX
         Gh+iJGE4yWqoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 341565C0555; Mon,  4 Apr 2022 12:49:07 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:49:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
Message-ID: <20220404194907.GA133884@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
 <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:54:02PM -0700, Eric Dumazet wrote:
> On Thu, Mar 31, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Mar 31, 2022 at 02:45:25PM -0700, Eric Dumazet wrote:
> > > Hi Paul
> > >
> > > It seems you assume per cpu ptr for arbitrary indexes (< nr_cpu_ids) are valid.
> >
> > Gah!  I knew I was forgetting something...
> >
> > But just to check, is this a theoretical problem or something you hit
> > on real hardware?  (For the rest of this email, I am assuming the latter.)
> 
> Code review really...
> 
> >
> > > What do you think of the (untested) following patch ?
> >
> > One issue with this patch is that the contention could be unpredictable,
> > or worse, vary among CPU, especially if the cpu_possible_mask was oddly
> > distributed.
> >
> > So might it be better to restrict this to all on CPU 0 on the one hand
> > and completely per-CPU on the other?  (Or all on the boot CPU, in case
> > I am forgetting some misbegotten architecture that can run without a
> > CPU 0.)
> 
> If I understand correctly, cblist_init_generic() could setup
> percpu_enqueue_shift
> to something smaller than order_base_2(nr_cpu_ids)
> 
> Meaning that we could reach a non zero idx in (smp_processor_id() >>
> percpu_enqueue_shift)
> 
> So even if CPU0 is always present (I am not sure this is guaranteed,
> but this seems reasonable),
> we could still attempt a per_cpu_ptr(PTR,  not_present_cpu), and get garbage.

And the problem with my wish to provide load balancing is that a
sparse cpumask could be sparse any which way that it wants to be.
Another problem is that, unlike TREE SRCU, Tasks RCU doesn't have an
efficient way to find all the CPUs with callbacks queued.  Yes, I could
add that information, but the benefit does not seem worth the complexity.

So I took your patch after all, but changed from cpu_online_mask to
cpu_possible_mask.  Thank you for bearing with me on this one!

Are you OK with your Signed-off-by on this patch as shown below?

						Thanx, Paul

------------------------------------------------------------------------

commit b77b2981bb22c4449a0a6e86eeb9fbab36a2beae
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Apr 4 12:30:18 2022 -0700

    rcu-tasks: Handle sparse cpu_possible_mask
    
    If the rcupdate.rcu_task_enqueue_lim kernel boot parameter is set to
    something greater than 1 and less than nr_cpu_ids, the code attempts to
    use a subset of the CPU's RCU Tasks callback lists.  This works, but only
    if the cpu_possible_mask is contiguous.  If there are "holes" in this
    mask, the callback-enqueue code might attempt to access a non-existent
    per-CPU ->rtcpu variable for a non-existent CPU.  For example, if only
    CPUs 0, 4, 8, 12, 16 and so on are in cpu_possible_mask, specifying
    rcupdate.rcu_task_enqueue_lim=4 would cause the code to attempt to
    use callback queues for non-existent CPUs 1, 2, and 3.  Because such
    systems have existed in the past and might still exist, the code needs
    to gracefully handle this situation.
    
    This commit therefore checks to see whether the desired CPU is present
    in cpu_possible_mask, and, if not, searches for the next CPU.  This means
    that the systems administrator of a system with a sparse cpu_possible_mask
    will need to account for this sparsity when specifying the value of
    the rcupdate.rcu_task_enqueue_lim kernel boot parameter.  For example,
    setting this parameter to the value 4 will use only CPUs 0 and 4, which
    CPU 4 getting three times the callback load of CPU 0.
    
    This commit assumes that bit (nr_cpu_ids - 1) is always set in
    cpu_possible_mask.
    
    Link: https://lore.kernel.org/lkml/CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com/
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 65d6e21a607a..44977c6a1cb8 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -273,7 +273,9 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
+	int chosen_cpu;
 	unsigned long flags;
+	int ideal_cpu;
 	unsigned long j;
 	bool needadjust = false;
 	bool needwake;
@@ -283,8 +285,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rhp->func = func;
 	local_irq_save(flags);
 	rcu_read_lock();
-	rtpcp = per_cpu_ptr(rtp->rtpcpu,
-			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
+	ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
+	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
+	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
 	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 		j = jiffies;
