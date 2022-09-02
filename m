Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876725ABB0D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiIBXJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIBXJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:09:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0A26576
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:09:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cv7so2544995qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GaMQNoIf/xRxwNpzf3eIjc1zighg0gfArRNujuKSwz8=;
        b=dTGuY2/vqDYBFWeYI9Dh2uWOCEN3c/86j0DhDh2N2WpLhgRk0CetMR21w38GTuIzlq
         TI5iJHCD3tTXmnM++W+6+Vkv4b/Nm82iFlXMoqWTYGazCxgPBWG4J/4iJ3VIZoe1FKRp
         SAIr0LUQbIrOYWwfXdPdhAMcC+11OeWiZf7lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GaMQNoIf/xRxwNpzf3eIjc1zighg0gfArRNujuKSwz8=;
        b=Tsn9V7eg8oVugH4fZ66itptj99PWI/gevAduboQEk+DFfliSTAMdBnuuPC3XSS3rmw
         Guyo2GYbaqHPEU0uWSsgBR4sRsMWREOiGTHf1RObfRcq04Q2KaND78dRSVzcNevmutjb
         vqMkmczErg6unTIq3FQI5H0Qizc5D5iaBmFcM3wrW02k7VhDxbBenpvYW6a3gCZXpRFC
         nEE+53eOlWaOpVGhLhxr9hua78tuz9xAgZYzq/v0vOiaIHGrVxtV1F3zIUSU74tzJhM+
         Zj9K+DqcsRmSf4QAYIi9qrw+kj1M0s3xvxkJSsFfhSbvcP3/4TpIvGuigh2J1abI+B4W
         edNg==
X-Gm-Message-State: ACgBeo2oYDAmYyS87JfA0GN9dj/if8jqm/2KJ6vvo/v2Ici9ag+vSlVB
        vLV5LeovG2QqeyUpscrD+CESfQ==
X-Google-Smtp-Source: AA6agR7cwsL9WFzrNXO5rxzsz7HQN8UQuIKSbFiQOdBcAxTHqKlxSfL+wt4DnIc6sGXes1BkRDgZDA==
X-Received: by 2002:a05:6214:27ef:b0:499:1e16:c4e7 with SMTP id jt15-20020a05621427ef00b004991e16c4e7mr13887380qvb.46.1662160184476;
        Fri, 02 Sep 2022 16:09:44 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006a6ebde4799sm2331265qkl.90.2022.09.02.16.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 16:09:43 -0700 (PDT)
Message-ID: <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
Date:   Fri, 2 Sep 2022 19:09:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220902152132.GA115525@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

On 9/2/2022 11:21 AM, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 10:17:08PM +0000, Joel Fernandes (Google) wrote:
>> Implement timer-based RCU lazy callback batching. The batch is flushed
>> whenever a certain amount of time has passed, or the batch on a
>> particular CPU grows too big. Also memory pressure will flush it in a
>> future patch.
>>
>> To handle several corner cases automagically (such as rcu_barrier() and
>> hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
>> length has the lazy CB length included in it. A separate lazy CB length
>> counter is also introduced to keep track of the number of lazy CBs.
>>
>> Suggested-by: Paul McKenney <paulmck@kernel.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  include/linux/rcupdate.h   |   6 ++
>>  kernel/rcu/Kconfig         |   8 ++
>>  kernel/rcu/rcu.h           |  11 +++
>>  kernel/rcu/rcu_segcblist.c |   2 +-
>>  kernel/rcu/tree.c          | 130 +++++++++++++++---------
>>  kernel/rcu/tree.h          |  13 ++-
>>  kernel/rcu/tree_nocb.h     | 198 ++++++++++++++++++++++++++++++-------
>>  7 files changed, 280 insertions(+), 88 deletions(-)
>>
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index 08605ce7379d..82e8a07e0856 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -108,6 +108,12 @@ static inline int rcu_preempt_depth(void)
>>  
>>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>>  
>> +#ifdef CONFIG_RCU_LAZY
>> +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
>> +#else
>> +#define call_rcu_lazy(head, func) call_rcu(head, func)
> 
> Why about an inline instead?

Sure, I can do that.

>> +#endif
>> +
>>  /* Internal to kernel */
>>  void rcu_init(void);
>>  extern int rcu_scheduler_active;
>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> index d471d22a5e21..3128d01427cb 100644
>> --- a/kernel/rcu/Kconfig
>> +++ b/kernel/rcu/Kconfig
>> @@ -311,4 +311,12 @@ config TASKS_TRACE_RCU_READ_MB
>>  	  Say N here if you hate read-side memory barriers.
>>  	  Take the default if you are unsure.
>>  
>> +config RCU_LAZY
>> +	bool "RCU callback lazy invocation functionality"
>> +	depends on RCU_NOCB_CPU
>> +	default n
>> +	help
>> +	  To save power, batch RCU callbacks and flush after delay, memory
>> +	  pressure or callback list growing too big.
>> +
>>  endmenu # "RCU Subsystem"
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index be5979da07f5..94675f14efe8 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -474,6 +474,14 @@ enum rcutorture_type {
>>  	INVALID_RCU_FLAVOR
>>  };
>>  
>> +#if defined(CONFIG_RCU_LAZY)
>> +unsigned long rcu_lazy_get_jiffies_till_flush(void);
>> +void rcu_lazy_set_jiffies_till_flush(unsigned long j);
>> +#else
>> +static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
>> +static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
>> +#endif
>> +
>>  #if defined(CONFIG_TREE_RCU)
>>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>>  			    unsigned long *gp_seq);
>> @@ -483,6 +491,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>>  			       unsigned long c_old,
>>  			       unsigned long c);
>>  void rcu_gp_set_torture_wait(int duration);
>> +void rcu_force_call_rcu_to_lazy(bool force);
>> +
>>  #else
>>  static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
>>  					  int *flags, unsigned long *gp_seq)
>> @@ -501,6 +511,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>>  	do { } while (0)
>>  #endif
>>  static inline void rcu_gp_set_torture_wait(int duration) { }
>> +static inline void rcu_force_call_rcu_to_lazy(bool force) { }
>>  #endif
>>  
>>  #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
>> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
>> index c54ea2b6a36b..55b50e592986 100644
>> --- a/kernel/rcu/rcu_segcblist.c
>> +++ b/kernel/rcu/rcu_segcblist.c
>> @@ -38,7 +38,7 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
>>   * element of the second rcu_cblist structure, but ensuring that the second
>>   * rcu_cblist structure, if initially non-empty, always appears non-empty
>>   * throughout the process.  If rdp is NULL, the second rcu_cblist structure
>> - * is instead initialized to empty.
>> + * is instead initialized to empty. Also account for lazy_len for lazy CBs.
> 
> Leftover?

Will fix, thanks.

>> @@ -3904,7 +3943,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>>  	rdp->barrier_head.func = rcu_barrier_callback;
>>  	debug_rcu_head_queue(&rdp->barrier_head);
>>  	rcu_nocb_lock(rdp);
>> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false,
>> +		     /* wake gp thread */ true));
> 
> It's a bad sign when you need to start commenting your boolean parameters :)
> Perhaps use a single two-bit flag instead of two booleans, for readability?

That's fair, what do you mean 2-bit flag? Are you saying, we encode the last 2
parameters to flush bypass in a u*?

> Also that's a subtle change which purpose isn't explained. It means that
> rcu_barrier_entrain() used to wait for the bypass timer in the worst case
> but now we force rcuog into it immediately. Should that be a separate change?

It could be split, but it is laziness that amplifies the issue so I thought of
keeping it in the same patch. I don't mind one way or the other.

>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 31068dd31315..7e97a7b6e046 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>>  }
>>  
>> +/*
>> + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
>> + * can elapse before lazy callbacks are flushed. Lazy callbacks
>> + * could be flushed much earlier for a number of other reasons
>> + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
>> + * left unsubmitted to RCU after those many jiffies.
>> + */
>> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
>> +unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
> 
> It seems this can be made static?

Yes, will do.
>> @@ -265,23 +290,39 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>>  {
>>  	unsigned long flags;
>>  	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>> +	unsigned long mod_jif = 0;
>>  
>>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>>  
>>  	/*
>> -	 * Bypass wakeup overrides previous deferments. In case
>> -	 * of callback storm, no need to wake up too early.
>> +	 * Bypass and lazy wakeup overrides previous deferments. In case of
>> +	 * callback storm, no need to wake up too early.
>>  	 */
>> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
>> -		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>> -		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>> -	} else {
>> +	switch (waketype) {
>> +	case RCU_NOCB_WAKE_LAZY:
>> +		if (rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_LAZY)
>> +			mod_jif = jiffies_till_flush;
>> +		break;
> 
> Ah so this timer override all the others, and it's a several seconds
> timers. Then I'll have a related concern on nocb_gp_wait().

Ok I replied below.

>> +	case RCU_NOCB_WAKE_BYPASS:
>> +		mod_jif = 2;
>> +		break;
>> +
>> +	case RCU_NOCB_WAKE:
>> +	case RCU_NOCB_WAKE_FORCE:
>> +		// For these, make it wake up the soonest if we
>> +		// were in a bypass or lazy sleep before.
>>  		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
>> -			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
>> -		if (rdp_gp->nocb_defer_wakeup < waketype)
>> -			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>> +			mod_jif = 1;
>> +		break;
>>  	}
>>  
>> +	if (mod_jif)
>> +		mod_timer(&rdp_gp->nocb_timer, jiffies + mod_jif);
>> +
>> +	if (rdp_gp->nocb_defer_wakeup < waketype)
>> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> 
> So RCU_NOCB_WAKE_BYPASS and RCU_NOCB_WAKE_LAZY don't override the timer state
> anymore? Looks like something is missing.

My goal was to make sure that NOCB_WAKE_LAZY wake keeps the timer lazy. If I
don't do this, then when CPU enters idle, it will immediately do a wake up via
this call:

	rcu_nocb_need_deferred_wakeup(rdp_gp, RCU_NOCB_WAKE)

That was almost always causing lazy CBs to be non-lazy thus negating all the
benefits.

Note that bypass will also have same issue where the bypass CB will not wait for
intended bypass duration. To make it consistent with lazy, I made bypass also
not override nocb_defer_wakeup.

I agree its not pretty, but it works and I could not find any code path where it
does not work. That said, I am open to ideas for changing this and perhaps some
of these unneeded delays with bypass CBs can be split into separate patches.

Regarding your point about nocb_defer_wakeup state diverging from the timer
programming, that happens anyway here in current code:

 283        } else {
 284                if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
 285                        mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
 286                if (rdp_gp->nocb_defer_wakeup < waketype)
 287                        WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 288        }

>> +
>>  	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
>>  
>>  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
> [...]
>> @@ -705,12 +816,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>>  	my_rdp->nocb_gp_gp = needwait_gp;
>>  	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
>>  
>> -	if (bypass && !rcu_nocb_poll) {
>> -		// At least one child with non-empty ->nocb_bypass, so set
>> -		// timer in order to avoid stranding its callbacks.
>> -		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
>> -				   TPS("WakeBypassIsDeferred"));
>> +	// At least one child with non-empty ->nocb_bypass, so set
>> +	// timer in order to avoid stranding its callbacks.
>> +	if (!rcu_nocb_poll) {
>> +		// If bypass list only has lazy CBs. Add a deferred
>> +		// lazy wake up.
>> +		if (lazy && !bypass) {
>> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
>> +					TPS("WakeLazyIsDeferred"));
> 
> What if:
> 
> 1) rdp(1) has lazy callbacks
> 2) all other rdp's have no callback at all
> 3) nocb_gp_wait() runs through all rdp's, everything is handled, except for
>    these lazy callbacks
> 4) It reaches the above path, ready to arm the RCU_NOCB_WAKE_LAZY timer,
>    but it hasn't yet called wake_nocb_gp_defer()
> 5) Oh but rdp(2) queues a non-lazy callback. interrupts are disabled so it defers
>    the wake up to nocb_gp_wait() with arming the timer in RCU_NOCB_WAKE.
> 6) nocb_gp_wait() finally calls wake_nocb_gp_defer() and override the timeout
>    to several seconds ahead.
> 7) No more callbacks queued, the non-lazy callback will have to wait several
>    seconds to complete.
> 
> Or did I miss something?

In theory, I can see this being an issue. In practice, I have not seen it to be.
In my view, the nocb GP thread should not go to sleep in the first place if
there are any non-bypass CBs being queued. If it does, then that seems an
optimization-related bug.

That said, we can make wake_nocb_gp_defer() more robust perhaps by making it not
overwrite the timer if the wake-type requested is weaker than RCU_NOCB_WAKE,
however that should not cause the going-into-idle issues I pointed. Whether the
idle time issue will happen, I have no idea. But in theory, will that address
your concern above?

> Note that the race exists with RCU_NOCB_WAKE_BYPASS
> but it's only about one jiffy delay, not seconds.

Well, 2 jiffies. But yeah.

Thanks, so far I do not see anything that cannot be fixed on top of this patch
but you raised some good points. Maybe we ought to rewrite the idle path to not
disturb lazy CBs in a different way, or something (while keeping the timer state
consistent with the programming of the timer in wake_nocb_gp_defer()).

> (further review later).

Ok thanks, looking forward to them.


- Joel




> 
> Thanks.
> 
>> +		// Otherwise add a deferred bypass wake up.
>> +		} else if (bypass) {
>> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
>> +					TPS("WakeBypassIsDeferred"));
>> +		}
>>  	}
>> +
>>  	if (rcu_nocb_poll) {
>>  		/* Polling, so trace if first poll in the series. */
>>  		if (gotcbs)
>> @@ -1036,7 +1156,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>>  	 * return false, which means that future calls to rcu_nocb_try_bypass()
>>  	 * will refuse to put anything into the bypass.
>>  	 */
>> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
>>  	/*
>>  	 * Start with invoking rcu_core() early. This way if the current thread
>>  	 * happens to preempt an ongoing call to rcu_core() in the middle,
>> @@ -1290,6 +1410,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
>>  	raw_spin_lock_init(&rdp->nocb_gp_lock);
>>  	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
>>  	rcu_cblist_init(&rdp->nocb_bypass);
>> +	WRITE_ONCE(rdp->lazy_len, 0);
>>  	mutex_init(&rdp->nocb_gp_kthread_mutex);
>>  }
>>  
>> @@ -1571,13 +1692,14 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>>  }
>>  
>>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>> -				  unsigned long j)
>> +				  unsigned long j, bool lazy, bool wakegp)
>>  {
>>  	return true;
>>  }
>>  
>>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>> -				bool *was_alldone, unsigned long flags)
>> +				bool *was_alldone, unsigned long flags,
>> +				bool lazy)
>>  {
>>  	return false;
>>  }
>> -- 
>> 2.37.2.789.g6183377224-goog
>>
