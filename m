Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57246DD73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhLHVNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:13:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 13:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05772B8210A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7635C00446;
        Wed,  8 Dec 2021 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638997778;
        bh=p2XadIlVm2dAvSz6nOGjJjLfxEumy00UgfvelOgDD/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TZk1K1aAp0cNd/fy33OkUeJxslNs9eWrV+pBhPHys+TPW9y1F1jXUmnlPytP6YeaF
         jM/IuBsWRSDJR+05UU5Uxy18RC48gg7jgswfCQJEfSZP8RFTebs/uAUMt+/QTtxaGD
         PASCGgBdqAeHsruCLitx4/eWulTW1ps3dpE/XO3/aZL8/ccnbJWXAZELtZ01YEuMg0
         yQbMcTK+MX/CKkH/JcpnsRcBwmbj2e7q3GcQeurkTVDzlvAWqB8xmwX+lhLiCRvzHU
         r9rG78Ays42XQvgtbKd/RanJNXu+cQqvk8cmW26/WhEpDV/JSymNy8q0m/jGxXR1LG
         8s2dp+5d5p2Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8AC935C069B; Wed,  8 Dec 2021 13:09:38 -0800 (PST)
Date:   Wed, 8 Dec 2021 13:09:38 -0800
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
Message-ID: <20211208210938.GZ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
 <5039f6178715dc4725a8c7f071dfd9ef5d70ae43.camel@infradead.org>
 <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
 <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
 <0824902894565e850b79e494c38a7856f8358b99.camel@infradead.org>
 <f67ce85c73941bd5d35e8af84765c70f56ddcdf7.camel@infradead.org>
 <20211208173549.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <9c5ad763b77543768b9b0e62aa238d62c47dbcb3.camel@infradead.org>
 <20211208190357.GX641268@paulmck-ThinkPad-P17-Gen-1>
 <b9c4bcf345caa32996d7e439116058052ef1a367.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c4bcf345caa32996d7e439116058052ef1a367.camel@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:35:00PM +0000, David Woodhouse wrote:
> On Wed, 2021-12-08 at 11:03 -0800, Paul E. McKenney wrote:
> > On Wed, Dec 08, 2021 at 06:32:15PM +0000, David Woodhouse wrote:
> > > On Wed, 2021-12-08 at 09:35 -0800, Paul E. McKenney wrote:
> > > > On Wed, Dec 08, 2021 at 04:57:07PM +0000, David Woodhouse wrote:
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index ef8d36f580fc..544198c674f2 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -4246,11 +4246,11 @@ void rcu_cpu_starting(unsigned int cpu)
> > > > >  
> > > > >  	rnp = rdp->mynode;
> > > > >  	mask = rdp->grpmask;
> > > > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > 
> > > > If I am not too confused this morning, this can result in confusing
> > > > lockdep splats because lockdep needs RCU to be watching the CPU
> > > > acquiring the lock.  See the rcu_lockdep_current_cpu_online()
> > > > function and is callers, with emphasis on lockdep_rcu_suspicious()
> > > > and rcu_read_lock_held_common().
> > > 
> > > Hm, OK. And it is the very act of setting rnp->ofl_seq & 1 which
> > > triggers that, yes?
> > 
> > Prevents that from triggering, but if I recall correctly, yes.
> 
> OK, thanks.
> 
> > > Ok, thanks. My initial hack of sticking my own spinlock around the
> > > whole thing was also working for testing, but now I'm trying to clean
> > > it up so I can post something for merging.
> > 
> > Sounds good!
> > 
> > You know, maybe it would be way easier to just create a new spinlock and
> > use arch_spin_lock() to acquire it and arch_spin_unlock() to release it,
> > bypassing lockdep for that one lock.  Then proceed as in your initial
> > patch.
> 
> Hm. So... (summarising a little from IRC for the peanut gallery and our
> own subsequent recollection) I had a play with doing an atomic
> 'acquire' for rnp->ofl_seq which is basically "spin until you can use
> cmpxchg() to atomically increment it to an odd number".
> 
> http://david.woodhou.se/acquire-ofl-seq.patch
> 
> But *every* call to that 'acquire_ofl_seq() is paired with locking
> rcu_state.ofl_lock, and *every* release is paired with unlocking
> rcu_state.ofl_lock.
> 
> So I don't think I want a *new* lock; I think I want to use
> arch_spin_lock on rcu_state.ofl_lock and expand it slightly (as in my
> previous attempt to cover the modifications of rnp->ofl_seq.
> 
> Will throw that together and see what breaks...

This approach makes sense to me!

> > > > Though I are having some difficulty remembering why that wait loop in
> > > > rcu_gp_init() needs to be there.  I am going to try removing it and
> > > > seeing if rcutorture will be kind enough to remind me.  ;-)
> > > > 
> > > > And it will of course be necessary to upgrade rcutorture to test
> > > > concurrent CPU-online operations.  Will there be some sort of
> > > > start-CPU-online function, or should I instead expect to need to
> > > > provide multiple kthreads for onlining and an additional kthread
> > > > for offliing?
> > > 
> > > This is just at *boot* time, not runtime hotplug/unplug. We observed
> > > that we spend quite a lot of time on a 96-way 2-socket Skylake system
> > > just sending INIT to each CPU in turn, then waiting for it to be fully
> > > online, then moving on to the next one. Hence doing them all in
> > > parallel, which reduces the AP bringup time from about 300ms to 30ms.
> > > 
> > > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-5.16
> > > 
> > 
> > Nice win!!!
> > 
> > And I do understand that you are only worried about boot speed, but
> > adequate stress-testing of this will require run-time exercising of this.
> > Yes, 30ms is fast, but you have other overheads when repeatedly rebooting,
> > and so doing runtime tests will find bugs faster.
> 
> Absolutely!
> 
> > > > Huh.  I take it that concurrent online and offline is future work?
> > > > Or does that need to work initially?
> > > 
> > > Concurrent *online* (at boot) is the whole point. Those last two
> > > commits currently in the branch linked above are the "oh crap, *that*
> > > part doesn't work if you really let it happen concurrently, so let's
> > > serialize them" hacks. In particular, the RCU one is 
> > > https://git.infradead.org/users/dwmw2/linux.git/commitdiff/5f4b77c9459c
> > > 
> > > 
> > > And now I'm trying to come up with something a little less hackish :)
> > 
> > Understood!  I am just trying to work out a decent validation plan for
> > this.  Let's just say that changes in this area have not traditionally
> > been boring.  ;-)
> > 
> > > > More to the point, what are you using to stress-test this capability?
> > > 
> > > Just boot. With lots of CPUs (and vCPUs in qemu, but even with a nice
> > > fast parallel CPU bringup, Linux then spends the next 16 seconds
> > > printing silly pr_info messages about KVM features so it isn't the most
> > > exciting overall result right now)
> > > 
> > > I confess I haven't actually tested runtime hotplug/unplug again
> > > recently. I should do that ;)
> > 
> > The rcutorture TREE03 scenario is rather aggressive about this.
> > From the root of a recent Linux-kernel source tree:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1h configs "TREE03" --trust-make
> > 
> > Or, if you have a 64-CPU system:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1h configs "4*TREE03" --trust-make
> > 
> > The latter would be a semi-credible smoke test for this sort of change.
> 
> Thanks.

This should address the bug that RCU complained bitterly about.  The search
for bugs that RCU suffers in silence might take a bit longer.  ;-)

							Thanx, Paul
