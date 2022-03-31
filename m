Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2814EE485
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiCaXMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCaXMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB0105AB3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F26A461667
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE2CC340ED;
        Thu, 31 Mar 2022 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648768228;
        bh=ayML8RaUBnTdmf9yaj5JTyemKW/LWEmylZyis/jy1qs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=et7LVT6cqkFFJE1LiTtUjV6Ct58X+Blk10UZVTxQPugeXH5+LV2yk6/t1Qs3vlaDO
         aT051BFezb7g3ItIzqxX/+Tw74CQQMDiUPxR9ieguv2wpCPF0leo/9LpyUDZF4ld9Y
         9TR67sDAEoW37xxaH/t9Cy/2afPSmR1grHAb1Q/wu+y4wKh5CXkzBBzBDwA+t0PZFS
         tXY1RSI+A+CgLK8Z0m+e43o94CVIKggUkL1u3a7xWamBt4q/9In8YEVG1jPQ30KH4S
         J92R2FBPOxP6tiaR6cYbt+x7bFdJkiPXaN/tiSlJa4BPHcgjUAY2swSZJ7Be5J7rlV
         Jh0ezqfehqqlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0A04C5C0A0E; Thu, 31 Mar 2022 16:10:27 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:10:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
Message-ID: <20220331231027.GZ4285@paulmck-ThinkPad-P17-Gen-1>
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

OK, not yet an emergency, then.  ;-)

If it does become an emergency, one workaround is to set the
rcupdate.rcu_task_enqueue_lim kernel boot parameter to the number of CPUs.

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

My thought is to replace the shift with a boolean.  One setting just
always uses CPU 0's cblist (or that of the boot CPU, if there is some
architecture that is completely innocent of CPU 0), and the other setting
always uses that of the currently running CPU.  This does rule out the
current possibility of using (say) 16 cblists on a 64-CPU system, but
I suspect that this would be just fine.

Neeraj's and my proposed memory-diet patches for SRCU do something like
this.  These are on branch srcu.2022.03.29a on -rcu.

Thoughts?

							Thanx, Paul

> > > Thanks.
> > >
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 99cf3a13954cfb17828fbbeeb884f11614a526a9..df3785be4022e903d9682dd403464aa9927aa5c2
> > > 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -273,13 +273,17 @@ static void call_rcu_tasks_generic(struct
> > > rcu_head *rhp, rcu_callback_t func,
> > >         bool needadjust = false;
> > >         bool needwake;
> > >         struct rcu_tasks_percpu *rtpcp;
> > > +       int ideal_cpu, chosen_cpu;
> > >
> > >         rhp->next = NULL;
> > >         rhp->func = func;
> > >         local_irq_save(flags);
> > >         rcu_read_lock();
> > > -       rtpcp = per_cpu_ptr(rtp->rtpcpu,
> > > -                           smp_processor_id() >>
> > > READ_ONCE(rtp->percpu_enqueue_shift));
> > > +
> > > +       ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
> > > +       chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_online_mask);
> > > +
> > > +       rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
> > >         if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
> > >                 raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
> > >                 j = jiffies;
