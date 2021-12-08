Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8744246D9D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbhLHRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:39:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49250 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhLHRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45590B82201
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A8C00446;
        Wed,  8 Dec 2021 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638984950;
        bh=XygnzHWntqNwjeSNjB1IeWJyrtur0zmn0t/LKQkRR5U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c8W4KpyC+xdwLcJE28HRO8+Ivbij1/SApqsG0s5rrTn3JgySW5g6/wWq+Za/596Gn
         YUL+yo9Ad+2x4mBwsgcmLM7ZEMW44dC9N08pvoUnTcSyG4yVYoFffzjgHBKeXcYqSf
         SZu6MaYfBrXuMR1PbUUsN0IrRl4OyEolXRScm1GPfOS4mcGHxEkTjgeBddtk0Kg31E
         q9jOdJY0zfHPWT+T5wqAbpWNFxoVZceIPmmzkKbpPO9LFKCPbELJoKA04i044qv/D/
         yRnbIOazFUtEN2pDTKufGXm9Xrfx+NTX4swhzzdZ5Jlu/mh85r3jnVYR9zmSq3+CxV
         F94iif3knosQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A91665C069B; Wed,  8 Dec 2021 09:35:49 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:35:49 -0800
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
Message-ID: <20211208173549.GU641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87ft22dxop.fsf@nanos.tec.linutronix.de>
 <27357c74bdc3b52bdf59e6f48cd8690495116d64.camel@infradead.org>
 <877dnedt7l.fsf@nanos.tec.linutronix.de>
 <87zh09tcqz.fsf@nanos.tec.linutronix.de>
 <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
 <5039f6178715dc4725a8c7f071dfd9ef5d70ae43.camel@infradead.org>
 <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
 <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
 <0824902894565e850b79e494c38a7856f8358b99.camel@infradead.org>
 <f67ce85c73941bd5d35e8af84765c70f56ddcdf7.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67ce85c73941bd5d35e8af84765c70f56ddcdf7.camel@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:57:07PM +0000, David Woodhouse wrote:
> On Wed, 2021-12-08 at 15:10 +0000, David Woodhouse wrote:
> > @@ -4266,13 +4266,13 @@ void rcu_cpu_starting(unsigned int cpu)
> >                 rcu_disable_urgency_upon_qs(rdp);
> >                 /* Report QS -after- changing ->qsmaskinitnext! */
> >                 rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > +               /* Er, why didn't we drop the lock here? */
> > -       } else {
> > -               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >         }
> > 
> 
> Oh, I see... how about this straw man then...

Yes, rcu_report_qs_rnp() does drop the lock.  (Apologies for not having
replied earlier, but I had not yet consumed enough chocolate to correctly
parse your comment.)

> From 083c8fb2656e9fc60a17c9bfd538fcee4c5ebacc Mon Sep 17 00:00:00 2001
> From: David Woodhouse <dwmw@amazon.co.uk>
> Date: Tue, 16 Feb 2021 15:04:34 +0000
> Subject: [PATCH 1/4] rcu: Expand locking around rcu_cpu_starting() to cover
>  rnp->ofl_seq bump
> 
> To allow architectures to bring APs online in parallel, we need only one
> of them to be going through rcu_cpu_starting() at a time. Expand the
> coverage of the existing per-node lock to cover the manipulation of
> rnp->ofl_seq too.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  kernel/rcu/tree.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ef8d36f580fc..544198c674f2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4246,11 +4246,11 @@ void rcu_cpu_starting(unsigned int cpu)
>  
>  	rnp = rdp->mynode;
>  	mask = rdp->grpmask;
> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);

If I am not too confused this morning, this can result in confusing
lockdep splats because lockdep needs RCU to be watching the CPU
acquiring the lock.  See the rcu_lockdep_current_cpu_online()
function and is callers, with emphasis on lockdep_rcu_suspicious()
and rcu_read_lock_held_common().

>  	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
>  	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
>  	rcu_dynticks_eqs_online();
>  	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
> -	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>  	newcpu = !(rnp->expmaskinitnext & mask);
>  	rnp->expmaskinitnext |= mask;
> @@ -4261,6 +4261,11 @@ void rcu_cpu_starting(unsigned int cpu)
>  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
>  
> +	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
> +	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
> +	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
> +	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
> +
>  	/* An incoming CPU should never be blocking a grace period. */
>  	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
>  		rcu_disable_urgency_upon_qs(rdp);
> @@ -4269,10 +4274,6 @@ void rcu_cpu_starting(unsigned int cpu)
>  	} else {
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);

And ditto here upon release.

As a short-term hack, I suggest moving the ->ofl_seq field from the
rcu_node structure to the rcu_data structure.  This will require the loop
in rcu_gp_init() to wait on each of the current rcu_node structure's CPUs.
Which is not good from the viewpoint of the RCU grace-period kthread's
CPU consumption, but it should allow you to make progress on your testing.

Though I are having some difficulty remembering why that wait loop in
rcu_gp_init() needs to be there.  I am going to try removing it and
seeing if rcutorture will be kind enough to remind me.  ;-)

And it will of course be necessary to upgrade rcutorture to test
concurrent CPU-online operations.  Will there be some sort of
start-CPU-online function, or should I instead expect to need to
provide multiple kthreads for onlining and an additional kthread
for offliing?

Huh.  I take it that concurrent online and offline is future work?
Or does that need to work initially?

More to the point, what are you using to stress-test this capability?

							Thanx, Paul

>  	}
> -	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
> -	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
> -	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
> -	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
>  }
>  
>  /*
> -- 
> 2.31.1
> 


