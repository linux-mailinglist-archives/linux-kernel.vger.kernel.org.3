Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8D57C1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiGUAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:54:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293C4BD25;
        Wed, 20 Jul 2022 17:54:04 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f14so311213qkm.0;
        Wed, 20 Jul 2022 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3lLrosI1/cNYKOYojGU7UNK7R9m4ERBIOUqoHDIgNU=;
        b=pit3ukjGiNq5ITD+Tp90qAtrZJP3BfsyTlpP4qYYMetwKhDJv0F/aQ+Zh5va7yt41x
         NPpkCZ9hyjSE0Xb1EKhsvKaF9yzq911DYYEzAQ1gnWIL8Zc2EUijaAssY+1PxdMq64an
         bh0pw/JYTI/FW/aZwN1iB3KzleLjfMZLMe4aT4L5927UMgWxRH1BFQOg1wSODcu1xE2p
         skWdiZ6/Qsbx/RG7lbYnfmNb/kDQY7MWsGFaTpn0kP3OjlMIlVpWBF0tUPwfPTHOUA5Z
         j0aW0fkJzzqiy313ESk9g0bA+wR00duk9gW+nWSFql6LzQUP0iTFHwA5DsAaNvRmburB
         YGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t3lLrosI1/cNYKOYojGU7UNK7R9m4ERBIOUqoHDIgNU=;
        b=FCo98yDZ0JmkVUHeXDwXr2rt8j2rEuU0jTu3iqSZhS6t/9QlAgTIsZTc2qu1hi+Mgp
         fS6zMSaAau84tX4NfKqAoPzITMA/m+OOJJAPo0C93Vik7IyMm0fQHCjPZ6hxrF6IaY+v
         oA7WIklAXN3H2kZBZCayVey65XVuhrzsD3qbFWMcsBWTiY2opbOZR8LUQP9x+Ng692O6
         M74p9vgHvBVzJDl0Q70rzzVMZ29juy07aG6/Yj/Pcb1Kwg1qQj4KgELDmli+JiAsiKER
         pz9OwUSDDvnUrSbumZyGD5loOIMOwwrxlyfEGVwXBjx8WjRzLd7F3vfdDr3NxNCRsoCy
         +q7A==
X-Gm-Message-State: AJIora+GSLDtWD551yor1vo20d4qrt6OGTC/EQtQzGPPJFfw5OTKAmFx
        T2pC2BSupBj/07x1iMuhv80=
X-Google-Smtp-Source: AGRyM1vmxQfv+X64OfAMStLLu3Ax1kE9S4gCpd3gwU/qBz985mSddw8Lk2Y6oW5dgTIwEXVFBWUdFw==
X-Received: by 2002:a37:644b:0:b0:6b5:d62f:7ed with SMTP id y72-20020a37644b000000b006b5d62f07edmr17096802qkb.143.1658364843672;
        Wed, 20 Jul 2022 17:54:03 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a130900b0031efc91644fsm460293qtk.33.2022.07.20.17.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:54:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 80DD027C0054;
        Wed, 20 Jul 2022 20:54:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 20 Jul 2022 20:54:02 -0400
X-ME-Sender: <xms:qaPYYgYi8jeYRe4glzw7zS5686LJUjmd-TCDJDwKBGV9FrJUDZgl8Q>
    <xme:qaPYYrb8JzZPEseTtGvNriPKwC7l-QEF7IR6LtaKRDYEUOJ1NroeHgqaLLSC03tns
    vsLsMOfoWzMFoF-ZA>
X-ME-Received: <xmr:qaPYYq91Or_jQhTPyS5O65LcF2vI5auyr-UVRjWL5rvcjsv3JoVsvxmHdvAHZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelfedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfh
    gvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdeftdevudfhtdeh
    udfhheehtdejleejieetudfgleehjeeiudelleekudfhudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qaPYYqrB1nXFHL6t5P3b77HTg0L-l-tVPeHur7QT0gkXNLuChtSV8A>
    <xmx:qaPYYrr1ak-5vWm6SMuec_pIMtqyIZGZ0AYXlSb2cQXj_xd6dfkRQw>
    <xmx:qaPYYoRYrj3c1D5nZUXRTFzPqnL65kYUgKl4SzDPplwArkv98-S8Kw>
    <xmx:qqPYYvcnvi08dU3KhyI3V0S83qKDc8O7UoXC3W-awBh3og9DCfHfPw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Jul 2022 20:54:01 -0400 (EDT)
Date:   Wed, 20 Jul 2022 17:53:38 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to
 ->gp_seq_polled
Message-ID: <Ytijki0fkkyKaD9u@boqun-archlinux>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
 <20220620225128.3842050-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620225128.3842050-4-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Jun 20, 2022 at 03:51:20PM -0700, Paul E. McKenney wrote:
> This commit switches the existing polled grace-period APIs to use a
> new ->gp_seq_polled counter in the rcu_state structure.  An additional
> ->gp_seq_polled_snap counter in that same structure allows the normal
> grace period kthread to interact properly with the !SMP !PREEMPT fastpath
> through synchronize_rcu().  The first of the two to note the end of a
> given grace period will make knowledge of this transition available to
> the polled API.
> 
> This commit is in preparation for polled expedited grace periods.
> 
> Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
> Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Ian Kent <raven@themaw.net>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 90 +++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/rcu/tree.h |  2 ++
>  2 files changed, 89 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 46cfceea87847..637e8f9454573 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1775,6 +1775,78 @@ static void rcu_strict_gp_boundary(void *unused)
>  	invoke_rcu_core();
>  }
>  
> +// Has rcu_init() been invoked?  This is used (for example) to determine
> +// whether spinlocks may be acquired safely.
> +static bool rcu_init_invoked(void)
> +{
> +	return !!rcu_state.n_online_cpus;
> +}
> +
> +// Make the polled API aware of the beginning of a grace period.
> +static void rcu_poll_gp_seq_start(unsigned long *snap)
> +{
> +	struct rcu_node *rnp = rcu_get_root();
> +
> +	if (rcu_init_invoked())
> +		raw_lockdep_assert_held_rcu_node(rnp);
> +
> +	// If RCU was idle, note beginning of GP.
> +	if (!rcu_seq_state(rcu_state.gp_seq_polled))
> +		rcu_seq_start(&rcu_state.gp_seq_polled);
> +
> +	// Either way, record current state.
> +	*snap = rcu_state.gp_seq_polled;
> +}
> +
> +// Make the polled API aware of the end of a grace period.
> +static void rcu_poll_gp_seq_end(unsigned long *snap)
> +{
> +	struct rcu_node *rnp = rcu_get_root();
> +
> +	if (rcu_init_invoked())
> +		raw_lockdep_assert_held_rcu_node(rnp);
> +
> +	// If the the previously noted GP is still in effect, record the
> +	// end of that GP.  Either way, zero counter to avoid counter-wrap
> +	// problems.
> +	if (*snap && *snap == rcu_state.gp_seq_polled) {
> +		rcu_seq_end(&rcu_state.gp_seq_polled);
> +		rcu_state.gp_seq_polled_snap = 0;
> +	} else {
> +		*snap = 0;
> +	}
> +}
> +
> +// Make the polled API aware of the beginning of a grace period, but
> +// where caller does not hold the root rcu_node structure's lock.
> +static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
> +{
> +	struct rcu_node *rnp = rcu_get_root();
> +
> +	if (rcu_init_invoked()) {
> +		lockdep_assert_irqs_enabled();
> +		raw_spin_lock_irq_rcu_node(rnp);
> +	}
> +	rcu_poll_gp_seq_start(snap);
> +	if (rcu_init_invoked())
> +		raw_spin_unlock_irq_rcu_node(rnp);
> +}
> +
> +// Make the polled API aware of the end of a grace period, but where
> +// caller does not hold the root rcu_node structure's lock.
> +static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> +{
> +	struct rcu_node *rnp = rcu_get_root();
> +
> +	if (rcu_init_invoked()) {
> +		lockdep_assert_irqs_enabled();
> +		raw_spin_lock_irq_rcu_node(rnp);
> +	}
> +	rcu_poll_gp_seq_end(snap);
> +	if (rcu_init_invoked())
> +		raw_spin_unlock_irq_rcu_node(rnp);
> +}
> +
>  /*
>   * Initialize a new grace period.  Return false if no grace period required.
>   */
> @@ -1810,6 +1882,7 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	rcu_seq_start(&rcu_state.gp_seq);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> +	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
>  	raw_spin_unlock_irq_rcu_node(rnp);
>  
>  	/*
> @@ -2069,6 +2142,7 @@ static noinline void rcu_gp_cleanup(void)
>  	 * safe for us to drop the lock in order to mark the grace
>  	 * period as completed in all of the rcu_node structures.
>  	 */
> +	rcu_poll_gp_seq_end(&rcu_state.gp_seq_polled_snap);
>  	raw_spin_unlock_irq_rcu_node(rnp);
>  
>  	/*
> @@ -3837,8 +3911,18 @@ void synchronize_rcu(void)
>  			 lock_is_held(&rcu_lock_map) ||
>  			 lock_is_held(&rcu_sched_lock_map),
>  			 "Illegal synchronize_rcu() in RCU read-side critical section");
> -	if (rcu_blocking_is_gp())
> +	if (rcu_blocking_is_gp()) {
> +		// Note well that this code runs with !PREEMPT && !SMP.
> +		// In addition, all code that advances grace periods runs
> +		// at process level.  Therefore, this GP overlaps with other
> +		// GPs only by being fully nested within them, which allows
> +		// reuse of ->gp_seq_polled_snap.
> +		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
> +		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
> +		if (rcu_init_invoked())
> +			cond_resched_tasks_rcu_qs();
>  		return;  // Context allows vacuous grace periods.
> +	}
>  	if (rcu_gp_is_expedited())
>  		synchronize_rcu_expedited();
>  	else
> @@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
>  	 * before the load from ->gp_seq.
>  	 */
>  	smp_mb();  /* ^^^ */
> -	return rcu_seq_snap(&rcu_state.gp_seq);
> +	return rcu_seq_snap(&rcu_state.gp_seq_polled);

I happened to run into this. There is one usage of
get_state_synchronize_rcu() in start_poll_synchronize_rcu(), in which
the return value of get_state_synchronize_rcu() ("gp_seq") will be used
for rcu_start_this_gp(). I don't think this is quite right, because
after this change, rcu_state.gp_seq and rcu_state.gp_seq_polled are
different values, in fact ->gp_seq_polled is greater than ->gp_seq
by how many synchronize_rcu() is called in early boot.

Am I missing something here?

Regards,
Boqun

>  }
>  EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
>  
> @@ -3925,7 +4009,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
>  bool poll_state_synchronize_rcu(unsigned long oldstate)
>  {
>  	if (oldstate == RCU_GET_STATE_COMPLETED ||
> -	    rcu_seq_done_exact(&rcu_state.gp_seq, oldstate)) {
> +	    rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
>  		smp_mb(); /* Ensure GP ends before subsequent accesses. */
>  		return true;
>  	}
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2ccf5845957df..9c853033f159d 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -323,6 +323,8 @@ struct rcu_state {
>  	short gp_state;				/* GP kthread sleep state. */
>  	unsigned long gp_wake_time;		/* Last GP kthread wake. */
>  	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
> +	unsigned long gp_seq_polled;		/* GP seq for polled API. */
> +	unsigned long gp_seq_polled_snap;	/* ->gp_seq_polled at normal GP start. */
>  
>  	/* End of fields guarded by root rcu_node's lock. */
>  
> -- 
> 2.31.1.189.g2e36527f23
> 
