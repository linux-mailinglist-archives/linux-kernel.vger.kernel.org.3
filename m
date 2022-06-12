Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E164547B95
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiFLStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiFLSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D08F5373C;
        Sun, 12 Jun 2022 11:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8E66101E;
        Sun, 12 Jun 2022 18:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE8C34115;
        Sun, 12 Jun 2022 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059785;
        bh=cfyOcuxLFukFeHQ+4I3fYlI7s2CihAB0D73dmmVDtK0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ffMHzYvoCorYoT70gusAFUkNE44TMUrubTZKHbsX7wFSFISB80dYvIfxXOjGUCtS1
         qqOpUlJqJxBPs7scuDZFgnUvTyCIG+jKM21trtwH40URJqLNpMUATNcVYSRcNgtARr
         6P0cXdlv1awTC+QK4shOTbJEHlbWvRoDbh4iyxhhTYcwRtcGFR5YaF/o8tHm7CgYjs
         nR/WUbFJcPiRJChD0tOVyNGS25JFVzGrqTLAkbUpVEXiXrH9cWYC89SgW2GdGN8cHo
         m3pIel+W6LOB73jNrcyg8h02jGsFiQ2C9/VuItH93wf1r6fNMwAYFkcOXRoLakycGG
         dpPqLqH6ozMZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F32D25C0266; Sun, 12 Jun 2022 11:49:44 -0700 (PDT)
Date:   Sun, 12 Jun 2022 11:49:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
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
Message-ID: <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
 <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 07:29:30PM +0200, Paolo Bonzini wrote:
> On 6/12/22 18:40, Paul E. McKenney wrote:
> > > Do these reserved memory regions really need to be allocated separately?
> > > (For example, are they really all non-contiguous?  If not, that is, if
> > > there are a lot of contiguous memory regions, could you sort the IORT
> > > by address and do one ioctl() for each set of contiguous memory regions?)
> > > 
> > > Are all of these reserved memory regions set up before init is spawned?
> > > 
> > > Are all of these reserved memory regions set up while there is only a
> > > single vCPU up and running?
> > > 
> > > Is the SRCU grace period really needed in this case?  (I freely confess
> > > to not being all that familiar with KVM.)
> > 
> > Oh, and there was a similar many-requests problem with networking many
> > years ago.  This was solved by adding a new syscall/ioctl()/whatever
> > that permitted many requests to be presented to the kernel with a single
> > system call.
> > 
> > Could a new ioctl() be introduced that requested a large number
> > of these memory regions in one go so as to make each call to
> > synchronize_rcu_expedited() cover a useful fraction of your 9000+
> > requests?  Adding a few of the KVM guys on CC for their thoughts.
> 
> Unfortunately not.  Apart from this specific case, in general the calls to
> KVM_SET_USER_MEMORY_REGION are triggered by writes to I/O registers in the
> guest, and those writes then map to a ioctl.  Typically the guest sets up a
> device at a time, and each setup step causes a synchronize_srcu()---and
> expedited at that.

I was afraid of something like that...

> KVM has two SRCUs:
> 
> 1) kvm->irq_srcu is hardly relying on the "sleepable" part; it has readers
> that are very very small, but it needs extremely fast detection of grace
> periods; see commit 719d93cd5f5c ("kvm/irqchip: Speed up
> KVM_SET_GSI_ROUTING", 2014-05-05) which split it off kvm->srcu.  Readers are
> not so frequent.
> 
> 2) kvm->srcu is nastier because there are readers all the time.  The
> read-side critical section are still short-ish, but they need the sleepable
> part because they access user memory.

Which one of these two is in play in this case?

> Writers are not frequent per se; the problem is they come in very large
> bursts when a guest boots.  And while the whole boot path overall can be
> quadratic, O(n) expensive calls to synchronize_srcu() can have a larger
> impact on runtime than the O(n^2) parts, as demonstrated here.
> 
> Therefore, we operated on the assumption that the callers of
> synchronized_srcu_expedited were _anyway_ busy running CPU-bound guest code
> and the desire was to get past the booting phase as fast as possible.  If
> the guest wants to eat host CPU it can "for(;;)" as much as it wants;
> therefore, as long as expedited GPs didn't eat CPU *throughout the whole
> system*, a preemptable busy wait in synchronize_srcu_expedited() were not
> problematic.
> 
> This assumptions did match the SRCU code when kvm->srcu and kvm->irq_srcu
> were was introduced (respectively in 2009 and 2014).  But perhaps they do
> not hold anymore now that each SRCU is not as independent as it used to be
> in those years, and instead they use workqueues instead?

The problem was not internal to SRCU, but rather due to the fact
that kernel live patching (KLP) had problems with the CPU-bound tasks
resulting from repeated synchronize_rcu_expedited() invocations.  So I
added heuristics to get the occasional sleep in there for KLP's benefit.
Perhaps these heuristics need to be less aggressive about adding sleep.

These heuristics have these aspects:

1.	The longer readers persist in an expedited SRCU grace period,
	the longer the wait between successive checks of the reader
	state.  Roughly speaking, we wait as long as the grace period
	has currently been in effect, capped at ten jiffies.

2.	SRCU grace periods have several phases.  We reset so that each
	phase starts by not waiting (new phase, new set of readers,
	so don't penalize this set for the sins of the previous set).
	But once we get to the point of adding delay, we add the
	delay based on the beginning of the full grace period.

Right now, the checking for grace-period length does not allow for the
possibility that a grace period might start just before the jiffies
counter gets incremented (because I didn't realize that anyone cared),
so that is one possible thing to change.  I can also allow more no-delay
checks per SRCU grace-period phase.

Zhangfei, does something like the patch shown below help?

Additional adjustments are likely needed to avoid re-breaking KLP,
but we have to start somewhere...

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 50ba70f019dea..6a354368ac1d1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 
 #define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
 #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
-#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
+#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
 #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
 
 /*
@@ -522,12 +522,18 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
  */
 static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 {
+	unsigned long gpstart;
+	unsigned long j;
 	unsigned long jbase = SRCU_INTERVAL;
 
 	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
 		jbase = 0;
-	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
-		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
+	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
+		j = jiffies - 1;
+		gpstart = READ_ONCE(ssp->srcu_gp_start);
+		if (time_after(j, gpstart))
+			jbase += j - gpstart;
+	}
 	if (!jbase) {
 		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
 		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
