Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46A347320B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhLMQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:41:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42580 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhLMQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:41:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77437B80D99;
        Mon, 13 Dec 2021 16:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AFEC34604;
        Mon, 13 Dec 2021 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639413705;
        bh=f94qWxFspTfdg3kYbQ5GYdB9m2vzdlhU/yXAOzV90aI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EcDs2OedUlWpcxRedO/v2gRvHgXOk4RkJTxNYxSsYa8z9lKlY9Mp1qbN2X/EVOQV9
         o0Z9A+spXXbvquHOewB5PFCjdpgvQuQmw8qK3/kZbf09iN3ZSa4X5l4qV4w4O3K02O
         UT8MTHtmDrsdxDFatrqFIZUV8RZl3K8b9po63ijBgbeOrVjyit6LTeIWDMUAmpYhQl
         /KJLMD/KdfVuaxseau37jS916eJp3nGmHUKoXx7H910KUB9KHZxP8I/q9oxtxDlWmX
         Vm2Bz33odKoqc9HwPBlkZ/YIMJIImXlzS31Wsx/i7lDyl/+U0EdwlZK40zMrgM/rGX
         IkFoZcsEg9AFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E06385C0E5E; Mon, 13 Dec 2021 08:41:44 -0800 (PST)
Date:   Mon, 13 Dec 2021 08:41:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <20211213164144.GN641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <875ys9dacq.ffs@tglx>
 <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx>
 <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx>
 <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
 <87ee6w83yw.ffs@tglx>
 <87bl2083mu.ffs@tglx>
 <20211203200808.GT641268@paulmck-ThinkPad-P17-Gen-1>
 <09e4a37b390479baa4e0947670d49c44d58c2855.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09e4a37b390479baa4e0947670d49c44d58c2855.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:36:56AM +0100, Nicolas Saenz Julienne wrote:
> Hi All,
> now that this is good shape I'm taking over Thomas and preparing v3.
> 
> Paul, I introduced most (if not all) your paragraph corrections. Some questions
> below.

Thank you for taking this on!

> On Fri, 2021-12-03 at 12:08 -0800, Paul E. McKenney wrote:
> > > +The update order depends on the transition type and is explained below in
> > > +the transition type sections.
> > @@@
> 
> Sorry, I'm not 100% sure I get what you meant by this. Maybe introducing some
> sort of link?

What this sentence is trying to get across is that there are different
orders of state updates, depending on the type of transition.  It would
be good to link to the following sections, if that can be done reasonably.

> [...]
> 
> > > +syscall_exit_to_user_mode() handles all work which needs to be done before
> > > +returning to user space like tracing, audit, signals, task work etc. After
> > > +that it invokes exit_to_user_mode() which again handles the state
> > > +transition in the reverse order:
> > > +
> > > +  * Tracing
> > > +  * RCU / Context tracking
> > > +  * Lockdep
> > > +
> > > +syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
> > > +available as fine grained subfunctions in cases where the architecture code
> > > +has to do extra work between the various steps. In such cases it has to
> > > +ensure that enter_from_user_mode() is called first on entry and
> > > +exit_to_user_mode() is called last on exit.
> > 
> > !!! Here I have a question.  Can calls to enter_from_user_mode()
> > be nested?  RCU is OK with this, but I am not so sure that everything
> > else is.  If nesting is prohibited, this paragraph should explicitly
> > say that.  If nesting is theoretically possible, but should be avoided,
> > it would be good to say that as well.  (Otherwise "It looks like it
> > might work, so let's go for it!")
> 
> 
> In __enter_from_user_mode() I see:
> 
> 	CT_WARN_ON(ct_state() != CONTEXT_USER);
> 
> IIUC this signals that a nested syscall entry isn't expected from CT's point of
> view. I remember reading through RCU's dyntick code that the rationale for
> nesting in the syscall path was half interrupts (or upcalls). I did some
> research, but couldn't find an example of this. Is this something we can
> discard as an old technique not used anymore?

Indeed, there are thankfully no more half interrupts.

> On the other hand, interrupts are prone to nesting:
>  - Weird interrupt handlers that re-enable interrupts
>  - NMIs interrupting Hard IRQ context
>  - NMIs interrupting NMIs

Plus there are odd cases where (from RCU's viewpoint) an interrupt can
happen within an NMI handler.

> Please let me know if I'm off-base, but I think the topic of nesting is worth a
> sentence or two in each section.

I completely agree.  We should be clear on what nesting is permitted and
not.

> [...]
> 
> > > +Interrupts and regular exceptions
> > > +---------------------------------
> > > +
> > > +Interrupts entry and exit handling is slightly more complex than syscalls
> > > +and KVM transitions.
> > > +
> > > +If an interrupt is raised while the CPU executes in user space, the entry
> > > +and exit handling is exactly the same as for syscalls.
> > > +
> > > +If the interrupt is raised while the CPU executes in kernel space the entry
> > > +and exit handling is slightly different. RCU state is only updated when the
> > > +interrupt was raised in context of the CPU's idle task because that's the
> > > +only kernel context where RCU can be not watching on NOHZ enabled kernels.
> > > +Lockdep and tracing have to be updated unconditionally.
> > 
> > !!! You lost me on this one.  Does that second-to-last sentence instead
> > want to end something like this?  "... where RCU will not be watching
> > when running on non-nohz_full CPUs."
> 
> The paragraph covers IRQ entry from kernel space. In that context RCU is only
> shut-off during idle. That only happens on a NOHZ-enabled kernel, be it
> NO_HZ_IDLE or NO_HZ_FULL.

OK, good.  So the RCU-not-watching case is on a nohz-full CPU.

> I'll try to reword it a bit so it's more explicit.

Sounds good!  And thank you again for taking this on!

							Thanx, Paul

> Thanks!
> 
> -- 
> Nicolás Sáenz
> 
