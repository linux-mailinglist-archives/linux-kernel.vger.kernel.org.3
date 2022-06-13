Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACBC547E60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiFMEQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiFMEQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863A631E;
        Sun, 12 Jun 2022 21:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C9A0612D3;
        Mon, 13 Jun 2022 04:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68154C34114;
        Mon, 13 Jun 2022 04:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655093813;
        bh=4fmOkN+5AoyYhjkaX2oIHrmVwvNNF0DHCImS5duUnIQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SR2Sc+aWlPDkzrqfL4pLiwH+4/AyGC4QNb6FsDJ8t/a+ZkKwXvo32j8gtR7ylFDjK
         3Iu2fkfTBVFugnHhi9/H//HU1koM5lA6rCN7661qxJL7wPY4s3p3IOIOljO38Sej/X
         scCPyJBYmDzUXd6WKnMT2rXBIQqhLQ4hk96S/hsysRbL77LZzl8PvECiHEnwbcLUWQ
         A0nF8udO9Q+1ZXY2C5QyKLIWNorlo6DW3ipC6MRu5nPghWNpTN9q/Gvh5ww7QakgiL
         w7dB5cqBxMIqBaiCVriwz6jbpD0be2+3ioE5wSGmK6cmopaPIxXNS/VLe6sMMw2jMS
         OZFGgSmqQFMRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EDF4F5C059E; Sun, 12 Jun 2022 21:16:52 -0700 (PDT)
Date:   Sun, 12 Jun 2022 21:16:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, mtosatti@redhat.com,
        sheng.yang@intel.com
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Message-ID: <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 08:57:11PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 13, 2022 at 11:04:39AM +0800, zhangfei.gao@foxmail.com wrote:
> > Hi, Paul
> > 
> > On 2022/6/13 上午2:49, Paul E. McKenney wrote:
> > > On Sun, Jun 12, 2022 at 07:29:30PM +0200, Paolo Bonzini wrote:
> > > > On 6/12/22 18:40, Paul E. McKenney wrote:
> > > > > > Do these reserved memory regions really need to be allocated separately?
> > > > > > (For example, are they really all non-contiguous?  If not, that is, if
> > > > > > there are a lot of contiguous memory regions, could you sort the IORT
> > > > > > by address and do one ioctl() for each set of contiguous memory regions?)
> > > > > > 
> > > > > > Are all of these reserved memory regions set up before init is spawned?
> > > > > > 
> > > > > > Are all of these reserved memory regions set up while there is only a
> > > > > > single vCPU up and running?
> > > > > > 
> > > > > > Is the SRCU grace period really needed in this case?  (I freely confess
> > > > > > to not being all that familiar with KVM.)
> > > > > Oh, and there was a similar many-requests problem with networking many
> > > > > years ago.  This was solved by adding a new syscall/ioctl()/whatever
> > > > > that permitted many requests to be presented to the kernel with a single
> > > > > system call.
> > > > > 
> > > > > Could a new ioctl() be introduced that requested a large number
> > > > > of these memory regions in one go so as to make each call to
> > > > > synchronize_rcu_expedited() cover a useful fraction of your 9000+
> > > > > requests?  Adding a few of the KVM guys on CC for their thoughts.
> > > > Unfortunately not.  Apart from this specific case, in general the calls to
> > > > KVM_SET_USER_MEMORY_REGION are triggered by writes to I/O registers in the
> > > > guest, and those writes then map to a ioctl.  Typically the guest sets up a
> > > > device at a time, and each setup step causes a synchronize_srcu()---and
> > > > expedited at that.
> > > I was afraid of something like that...
> > > 
> > > > KVM has two SRCUs:
> > > > 
> > > > 1) kvm->irq_srcu is hardly relying on the "sleepable" part; it has readers
> > > > that are very very small, but it needs extremely fast detection of grace
> > > > periods; see commit 719d93cd5f5c ("kvm/irqchip: Speed up
> > > > KVM_SET_GSI_ROUTING", 2014-05-05) which split it off kvm->srcu.  Readers are
> > > > not so frequent.
> > > > 
> > > > 2) kvm->srcu is nastier because there are readers all the time.  The
> > > > read-side critical section are still short-ish, but they need the sleepable
> > > > part because they access user memory.
> > > Which one of these two is in play in this case?
> > > 
> > > > Writers are not frequent per se; the problem is they come in very large
> > > > bursts when a guest boots.  And while the whole boot path overall can be
> > > > quadratic, O(n) expensive calls to synchronize_srcu() can have a larger
> > > > impact on runtime than the O(n^2) parts, as demonstrated here.
> > > > 
> > > > Therefore, we operated on the assumption that the callers of
> > > > synchronized_srcu_expedited were _anyway_ busy running CPU-bound guest code
> > > > and the desire was to get past the booting phase as fast as possible.  If
> > > > the guest wants to eat host CPU it can "for(;;)" as much as it wants;
> > > > therefore, as long as expedited GPs didn't eat CPU *throughout the whole
> > > > system*, a preemptable busy wait in synchronize_srcu_expedited() were not
> > > > problematic.
> > > > 
> > > > This assumptions did match the SRCU code when kvm->srcu and kvm->irq_srcu
> > > > were was introduced (respectively in 2009 and 2014).  But perhaps they do
> > > > not hold anymore now that each SRCU is not as independent as it used to be
> > > > in those years, and instead they use workqueues instead?
> > > The problem was not internal to SRCU, but rather due to the fact
> > > that kernel live patching (KLP) had problems with the CPU-bound tasks
> > > resulting from repeated synchronize_rcu_expedited() invocations.  So I
> > > added heuristics to get the occasional sleep in there for KLP's benefit.
> > > Perhaps these heuristics need to be less aggressive about adding sleep.
> > > 
> > > These heuristics have these aspects:
> > > 
> > > 1.	The longer readers persist in an expedited SRCU grace period,
> > > 	the longer the wait between successive checks of the reader
> > > 	state.  Roughly speaking, we wait as long as the grace period
> > > 	has currently been in effect, capped at ten jiffies.
> > > 
> > > 2.	SRCU grace periods have several phases.  We reset so that each
> > > 	phase starts by not waiting (new phase, new set of readers,
> > > 	so don't penalize this set for the sins of the previous set).
> > > 	But once we get to the point of adding delay, we add the
> > > 	delay based on the beginning of the full grace period.
> > > 
> > > Right now, the checking for grace-period length does not allow for the
> > > possibility that a grace period might start just before the jiffies
> > > counter gets incremented (because I didn't realize that anyone cared),
> > > so that is one possible thing to change.  I can also allow more no-delay
> > > checks per SRCU grace-period phase.
> > > 
> > > Zhangfei, does something like the patch shown below help?
> > > 
> > > Additional adjustments are likely needed to avoid re-breaking KLP,
> > > but we have to start somewhere...
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 50ba70f019dea..6a354368ac1d1 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
> > >   #define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
> > >   #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
> > > -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
> > > +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
> > >   #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
> > >   /*
> > > @@ -522,12 +522,18 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
> > >    */
> > >   static unsigned long srcu_get_delay(struct srcu_struct *ssp)
> > >   {
> > > +	unsigned long gpstart;
> > > +	unsigned long j;
> > >   	unsigned long jbase = SRCU_INTERVAL;
> > >   	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> > >   		jbase = 0;
> > > -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
> > > -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
> > > +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
> > > +		j = jiffies - 1;
> > > +		gpstart = READ_ONCE(ssp->srcu_gp_start);
> > > +		if (time_after(j, gpstart))
> > > +			jbase += j - gpstart;
> > > +	}
> > >   	if (!jbase) {
> > >   		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> > >   		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> > Unfortunately, this patch does not helpful.
> > 
> > Then re-add the debug info.
> > 
> > During the qemu boot
> > [  232.997667]  __synchronize_srcu loop=1000
> > 
> > [  361.094493]  __synchronize_srcu loop=9000
> > [  361.094501] Call trace:
> > [  361.094502]  dump_backtrace+0xe4/0xf0
> > [  361.094505]  show_stack+0x20/0x70
> > [  361.094507]  dump_stack_lvl+0x8c/0xb8
> > [  361.094509]  dump_stack+0x18/0x34
> > [  361.094511]  __synchronize_srcu+0x120/0x128
> > [  361.094514]  synchronize_srcu_expedited+0x2c/0x40
> > [  361.094515]  kvm_swap_active_memslots+0x130/0x198
> > [  361.094519]  kvm_activate_memslot+0x40/0x68
> > [  361.094520]  kvm_set_memslot+0x2f8/0x3b0
> > [  361.094523]  __kvm_set_memory_region+0x2e4/0x438
> > [  361.094524]  kvm_set_memory_region+0x78/0xb8
> > [  361.094526]  kvm_vm_ioctl+0x5a0/0x13e0
> > [  361.094528]  __arm64_sys_ioctl+0xb0/0xf8
> > [  361.094530]  invoke_syscall+0x4c/0x110
> > [  361.094533]  el0_svc_common.constprop.0+0x68/0x128
> > [  361.094536]  do_el0_svc+0x34/0xc0
> > [  361.094538]  el0_svc+0x30/0x98
> > [  361.094541]  el0t_64_sync_handler+0xb8/0xc0
> > [  361.094544]  el0t_64_sync+0x18c/0x190
> > [  363.942817]  kvm_set_memory_region loop=6000
> 
> Huh.
> 
> One possibility is that the "if (!jbase)" block needs to be nested
> within the "if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {" block.

And when I run 10,000 consecutive synchronize_rcu_expedited() calls, the
above change reduces the overhead by more than an order of magnitude.
Except that the overhead of the series is far less than one second,
not the several minutes that you are seeing.  So the per-call overhead
decreases from about 17 microseconds to a bit more than one microsecond.

I could imagine an extra order of magnitude if you are running HZ=100
instead of the HZ=1000 that I am running.  But that only gets up to a
few seconds.

> One additional debug is to apply the patch below on top of the one you
> just now kindly tested, then use whatever debug technique you wish to
> work out what fraction of the time during that critical interval that
> srcu_get_delay() returns non-zero.

So I am very interested in the above debug.  ;-)

Other thoughts?

							Thanx, Paul
