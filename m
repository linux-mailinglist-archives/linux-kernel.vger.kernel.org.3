Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975346DBC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbhLHTHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhLHTHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:07:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64951C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BC50B82075
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 19:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FA4C00446;
        Wed,  8 Dec 2021 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638990237;
        bh=K0T9ia7Yj5mMan783G8po9YlP5kdf/nDPcfiFXhVGYc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oxJhHjWyepsks4m34KkuhpUIfAqMcQvfgBtT7pWKrGtZSeV59c0Whm1ihLUpaGOBb
         +wgUPYZTtBXCjC9EHq4Rz7Tj4rAXLv9AZiZo2zjXTkLtJwXoUVCBILVnFxaF3Bafm8
         EXUOSdLpjuz/OT4k0G0cbLqQAl9g/WB3XU06oavTmCKeIOXI65jpj6CtqrUE7nelF4
         6VdjAwqq/973gZTquzhfTnwTQwCeQ7s9ia3YyLtkBjM5swA3LmkdqwWP7+app9e0Z2
         T9cql0RAnxqBY1upY1NrRyq17iN8Wo3fTTFiPTOVxSop/6MGwyNxhvHng+JjjClt2T
         9VGdg9XrkVDAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 680A15C069B; Wed,  8 Dec 2021 11:03:57 -0800 (PST)
Date:   Wed, 8 Dec 2021 11:03:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Schander, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian <hejingxian@huawei.com>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
Message-ID: <20211208190357.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <877dnedt7l.fsf@nanos.tec.linutronix.de>
 <87zh09tcqz.fsf@nanos.tec.linutronix.de>
 <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
 <5039f6178715dc4725a8c7f071dfd9ef5d70ae43.camel@infradead.org>
 <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
 <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
 <0824902894565e850b79e494c38a7856f8358b99.camel@infradead.org>
 <f67ce85c73941bd5d35e8af84765c70f56ddcdf7.camel@infradead.org>
 <20211208173549.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <9c5ad763b77543768b9b0e62aa238d62c47dbcb3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5ad763b77543768b9b0e62aa238d62c47dbcb3.camel@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 06:32:15PM +0000, David Woodhouse wrote:
> On Wed, 2021-12-08 at 09:35 -0800, Paul E. McKenney wrote:
> > On Wed, Dec 08, 2021 at 04:57:07PM +0000, David Woodhouse wrote:
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ef8d36f580fc..544198c674f2 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -4246,11 +4246,11 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  
> > >  	rnp = rdp->mynode;
> > >  	mask = rdp->grpmask;
> > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > 
> > If I am not too confused this morning, this can result in confusing
> > lockdep splats because lockdep needs RCU to be watching the CPU
> > acquiring the lock.  See the rcu_lockdep_current_cpu_online()
> > function and is callers, with emphasis on lockdep_rcu_suspicious()
> > and rcu_read_lock_held_common().
> 
> Hm, OK. And it is the very act of setting rnp->ofl_seq & 1 which
> triggers that, yes?

Prevents that from triggering, but if I recall correctly, yes.

> > >  	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
> > >  	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
> > >  	rcu_dynticks_eqs_online();
> > >  	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
> > > -	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> 
> 
> 
> > >  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
> > >  	newcpu = !(rnp->expmaskinitnext & mask);
> > >  	rnp->expmaskinitnext |= mask;
> > > @@ -4261,6 +4261,11 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > >  
> > > +	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
> > > +	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
> > > +	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
> > > +	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
> > > +
> > >  	/* An incoming CPU should never be blocking a grace period. */
> > >  	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
> > >  		rcu_disable_urgency_upon_qs(rdp);
> > > @@ -4269,10 +4274,6 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	} else {
> > >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > 
> > And ditto here upon release.
> > 
> > As a short-term hack, I suggest moving the ->ofl_seq field from the
> > rcu_node structure to the rcu_data structure.  This will require the loop
> > in rcu_gp_init() to wait on each of the current rcu_node structure's CPUs.
> > Which is not good from the viewpoint of the RCU grace-period kthread's
> > CPU consumption, but it should allow you to make progress on your testing.
> 
> Ok, thanks. My initial hack of sticking my own spinlock around the
> whole thing was also working for testing, but now I'm trying to clean
> it up so I can post something for merging.

Sounds good!

You know, maybe it would be way easier to just create a new spinlock and
use arch_spin_lock() to acquire it and arch_spin_unlock() to release it,
bypassing lockdep for that one lock.  Then proceed as in your initial
patch.

> > Though I are having some difficulty remembering why that wait loop in
> > rcu_gp_init() needs to be there.  I am going to try removing it and
> > seeing if rcutorture will be kind enough to remind me.  ;-)
> > 
> > And it will of course be necessary to upgrade rcutorture to test
> > concurrent CPU-online operations.  Will there be some sort of
> > start-CPU-online function, or should I instead expect to need to
> > provide multiple kthreads for onlining and an additional kthread
> > for offliing?
> 
> This is just at *boot* time, not runtime hotplug/unplug. We observed
> that we spend quite a lot of time on a 96-way 2-socket Skylake system
> just sending INIT to each CPU in turn, then waiting for it to be fully
> online, then moving on to the next one. Hence doing them all in
> parallel, which reduces the AP bringup time from about 300ms to 30ms.
> 
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-5.16

Nice win!!!

And I do understand that you are only worried about boot speed, but
adequate stress-testing of this will require run-time exercising of this.
Yes, 30ms is fast, but you have other overheads when repeatedly rebooting,
and so doing runtime tests will find bugs faster.

> > Huh.  I take it that concurrent online and offline is future work?
> > Or does that need to work initially?
> 
> Concurrent *online* (at boot) is the whole point. Those last two
> commits currently in the branch linked above are the "oh crap, *that*
> part doesn't work if you really let it happen concurrently, so let's
> serialize them" hacks. In particular, the RCU one is 
> https://git.infradead.org/users/dwmw2/linux.git/commitdiff/5f4b77c9459c
> 
> And now I'm trying to come up with something a little less hackish :)

Understood!  I am just trying to work out a decent validation plan for
this.  Let's just say that changes in this area have not traditionally
been boring.  ;-)

> > More to the point, what are you using to stress-test this capability?
> 
> Just boot. With lots of CPUs (and vCPUs in qemu, but even with a nice
> fast parallel CPU bringup, Linux then spends the next 16 seconds
> printing silly pr_info messages about KVM features so it isn't the most
> exciting overall result right now)
> 
> I confess I haven't actually tested runtime hotplug/unplug again
> recently. I should do that ;)

The rcutorture TREE03 scenario is rather aggressive about this.
From the root of a recent Linux-kernel source tree:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1h configs "TREE03" --trust-make

Or, if you have a 64-CPU system:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1h configs "4*TREE03" --trust-make

The latter would be a semi-credible smoke test for this sort of change.

							Thanx, Paul
