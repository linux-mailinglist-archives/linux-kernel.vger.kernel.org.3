Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B1510301
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbiDZQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352878AbiDZQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325AFD16;
        Tue, 26 Apr 2022 09:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C050A61A21;
        Tue, 26 Apr 2022 16:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F90C385A0;
        Tue, 26 Apr 2022 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650989747;
        bh=3B3qy2u1RzfgmSMW4KIWgul+JI/xSXzOaBcnk441JTA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nVzJzy4AMeojqXBfkyCmN+iErHWl7CU2Itj+7psuJ/u6ofn/SzMd3Zw/o0T1kG1Fp
         bDitFeMdgE4SnAYnXdfzjglOdRkyhVCUutkEGpS0X/3PrDWFkXWtlBDm3JxWul0Mf0
         tXalmvvYd03UosNeEhM5f/gEyQ7Z8IsJIKBlpgGXVmDL3vz5FxnhU/MTyFB/rpMcXZ
         E4RLRvURfAD++pTiajGDriYLcJ9BCD1o5BmOmmSmYZcQ4ijW0zRp9U2FuURUh54IDU
         1uiHqbSAjnOnTrj4FVDsiMTqKn4li0vwdH9dA4g5ILbOBPTard1X4Js02agBp5AO5G
         0TQGFIiDs6jtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6B255C0460; Tue, 26 Apr 2022 09:15:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:15:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Message-ID: <20220426161546.GF4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220425010404.3249118-1-qiang1.zhang@intel.com>
 <20220425154533.GT4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A72D33DCB9CDC22DED19DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220426134844.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588050E2A88BE7CEE6F8634DDAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588050E2A88BE7CEE6F8634DDAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:38:20PM +0000, Zhang, Qiang1 wrote:
> 
> On Tue, Apr 26, 2022 at 06:44:46AM +0000, Zhang, Qiang1 wrote:
> > 
> > On Mon, Apr 25, 2022 at 09:04:04AM +0800, Zqiang wrote:
> > > If the rcutree.use_softirq is configured, when RCU Stall event 
> > > happened, dump status of all rcuc kthreads who due to starvation 
> > > prevented grace period ends on CPUs that not report quiescent state.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  v1->v2:
> > >  rework rcuc_kthread_dump function
> > >  v2->v3:
> > >  merge this rcuc-stalled information into print_cpu_stall_info()
> > >  v3->v4:
> > >  print rcuc info only when rcuc kthread is starved
> > > 
> > >  kernel/rcu/tree_stall.h | 49
> > > ++++++++++++++++++-----------------------
> > >  1 file changed, 21 insertions(+), 28 deletions(-)
> > 
> > >I have queued this for testing and further review, thank you!
> > >
> > >I did the usual wordsmithing, plus I got rid of a couple of space characters that are extraneous in the common case (one of yours and one pre-existing instance).
> > >
> > >Could you please generate an actual stall of this type?  You might need to add a delay to the rcuc code, but other than that, please see the rcutorture blog series [1] and in particular the post on forcing stall warnings [2].
> > >
> > >							Thanx, Paul
> > >
> > >[1] https://paulmck.livejournal.com/61432.html
> > >[2] https://paulmck.livejournal.com/58077.html
> > 
> > I followed the instructions, add " rcutorture.stall_cpu=22 
> > rcutorture.fwd_progress=0"  and " rcutree.use_softirq=0"to bootargs, can trigger  RCU CPU stall warning:
> > 
> > root@qemux86-64:/# dmesg
> > [   37.556435] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [   37.556437] rcu:     3-....: (1 GPs behind) idle=269/1/0x4000000000000000 softirq=0/0 fqs=5631 rcuc=26004 jiffies(starved)
> > [   37.556440]  (t=26000 jiffies g=3589 q=35403)
> > [   37.556441] NMI backtrace for cpu 3
> > [   37.556442] CPU: 3 PID: 117 Comm: rcu_torture_sta Tainted: G             L    5.17.0-yoctodev-standard #16 7fe7533e7466875b0801ac148f921afcf57d38bc
> > [   37.556443] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> > [   37.556444] Call Trace:
> > [   37.556445]  <IRQ>
> > [   37.556446]  dump_stack_lvl+0x5b/0x82
> > [   37.556449]  dump_stack+0x10/0x12
> > [   37.556451]  nmi_cpu_backtrace.cold+0x32/0x8a
> > [   37.556452]  ? lapic_can_unplug_cpu+0x80/0x80
> > [   37.556454]  nmi_trigger_cpumask_backtrace+0xce/0xe0
> > [   37.556456]  arch_trigger_cpumask_backtrace+0x19/0x20
> > [   37.556458]  rcu_dump_cpu_stacks+0xcd/0x140
> > [   37.556460]  rcu_sched_clock_irq.cold+0x7a/0x3ba
> > [   37.556463]  ? debug_smp_processor_id+0x17/0x20
> > [   37.556466]  update_process_times+0x9b/0xd0
> > [   37.556467]  tick_sched_handle.isra.0+0x25/0x50
> > [   37.556469]  tick_sched_timer+0x79/0x90
> > [   37.556470]  ? tick_sched_do_timer+0x60/0x60
> > [   37.556471]  __hrtimer_run_queues+0x1d1/0x4c0
> > [   37.556473]  hrtimer_interrupt+0x114/0x230
> > [   37.556475]  ? rcu_read_lock_held_common+0x12/0x50
> > [   37.556489]  __sysvec_apic_timer_interrupt+0xa4/0x280
> > [   37.556491]  sysvec_apic_timer_interrupt+0x95/0xc0
> > [   37.556492]  </IRQ>
> 
> >Excellent, thank you!!!
> >
> >Now could you please do the same thing for a use_softirq kernel to verify that it prints correctly when that message is not supposed to be shown?
> 
> The use_softirq is not set zero, log follow:
> 
> rcu: INFO: rcu_preempt self-detected stall on CPU	
> [   32.388910] rcu:     3-....: (20847 ticks this GP) idle=733/1/0x4000000000000000 softirq=4565/4565 fqs=4655
> [   32.388913]  (t=21000 jiffies g=8113 q=12547)
> [   32.388914] NMI backtrace for cpu 3
> [   32.388914] CPU: 3 PID: 73 Comm: rcu_torture_sta Tainted: G             L    5.17.0-yoctodev-standard #2 05f26dfea00beb93d9714ba8d61bb77646676403
> [   32.388915] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   32.388916] Call Trace:
> [   32.388916]  <IRQ>
> [   32.388917]  dump_stack_lvl+0x5b/0x82

Again excellent, and again, thank you!

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
> 
> > Thanks
> > Zqiang
> > 
> > >
> > ----------------------------------------------------------------------
> > --
> > 
> > commit 66226e2acda8b31b60137b1ae71244df68541a01
> > Author: Zqiang <qiang1.zhang@intel.com>
> > Date:   Mon Apr 25 09:04:04 2022 +0800
> > 
> >     rcu: Dump all rcuc kthreads status for CPUs that not report 
> > quiescent state
> >     
> >     If the rcutree.use_softirq kernel boot parameter is disabled, then it is
> >     possible that a RCU CPU stall is due to the rcuc kthreads being starved of
> >     CPU time.  There is currently no easy way to infer this from the RCU CPU
> >     stall warning output.  This commit therefore adds a string of the form "
> >     rcuc=%ld jiffies(starved)" to a given CPU's output if the corresponding
> >     rcuc kthread has been starved for more than two seconds.
> >     
> >     [ paulmck: Eliminate extraneous space characters. ]
> >     
> >     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index 
> > d7956c03edbd4..0a25a4ea6eef8 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -407,7 +407,19 @@ static bool rcu_is_gp_kthread_starving(unsigned 
> > long *jp)
> >  
> >  static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)  {
> > -	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
> > +	int cpu;
> > +	struct task_struct *rcuc;
> > +	unsigned long j;
> > +
> > +	rcuc = rdp->rcu_cpu_kthread_task;
> > +	if (!rcuc)
> > +		return false;
> > +
> > +	cpu = task_cpu(rcuc);
> > +	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> > +		return false;
> > +
> > +	j = jiffies - READ_ONCE(rdp->rcuc_activity);
> >  
> >  	if (jp)
> >  		*jp = j;
> > @@ -432,6 +444,9 @@ static void print_cpu_stall_info(int cpu)
> >  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  	char *ticks_title;
> >  	unsigned long ticks_value;
> > +	bool rcuc_starved;
> > +	unsigned long j;
> > +	char buf[32];
> >  
> >  	/*
> >  	 * We could be printing a lot while holding a spinlock.  Avoid @@ -449,7 +464,10 @@ static void print_cpu_stall_info(int cpu)
> >  	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
> >  	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
> >  			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
> > -	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
> > +	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
> > +	if (rcuc_starved)
> > +		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
> > +	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u 
> > +fqs=%ld%s%s\n",
> >  	       cpu,
> >  	       "O."[!!cpu_online(cpu)],
> >  	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)], @@ -462,32 +480,10 @@ static void print_cpu_stall_info(int cpu)
> >  	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
> >  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
> >  	       data_race(rcu_state.n_force_qs) - 
> > rcu_state.n_force_qs_gpstart,
> > +	       rcuc_starved ? buf : "",
> >  	       falsepositive ? " (false positive?)" : "");  }
> >  
> > -static void rcuc_kthread_dump(struct rcu_data *rdp) -{
> > -	int cpu;
> > -	unsigned long j;
> > -	struct task_struct *rcuc;
> > -
> > -	rcuc = rdp->rcu_cpu_kthread_task;
> > -	if (!rcuc)
> > -		return;
> > -
> > -	cpu = task_cpu(rcuc);
> > -	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> > -		return;
> > -
> > -	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
> > -		return;
> > -
> > -	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
> > -	sched_show_task(rcuc);
> > -	if (!trigger_single_cpu_backtrace(cpu))
> > -		dump_cpu_task(cpu);
> > -}
> > -
> >  /* Complain about starvation of grace-period kthread.  */  static 
> > void rcu_check_gp_kthread_starvation(void)
> >  {
> > @@ -659,9 +655,6 @@ static void print_cpu_stall(unsigned long gps)
> >  	rcu_check_gp_kthread_expired_fqs_timer();
> >  	rcu_check_gp_kthread_starvation();
> >  
> > -	if (!use_softirq)
> > -		rcuc_kthread_dump(rdp);
> > -
> >  	rcu_dump_cpu_stacks();
> >  
> >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
