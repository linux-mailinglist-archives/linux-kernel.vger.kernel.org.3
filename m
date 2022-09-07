Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48D85B0866
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIGPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIGPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:23:11 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ABBA8304
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:23:08 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b2so10688434qkh.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3zamXV3S6eOICBQg+fr/jn5WCgU07mBuOfPsHLEZuXM=;
        b=P6630qpEsbQ7QFqA4zv5EBYtJjj5at5tuDoGpOjLw4TMwxbvmIuVOfcqjOMPumR92i
         EXJ8y/Nhz08mL6FXcKbndUBaendDiQlJpYUMBMavxWO8ipWBk+V+TwoRo7McGqOimhO9
         tsgYvg7Ovtw1jRCwEM1mHDPMniohHS50flg5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3zamXV3S6eOICBQg+fr/jn5WCgU07mBuOfPsHLEZuXM=;
        b=lhajwd9HQ2MKxJtkFCuTv2VAwksQCxdgUvvSQiLjXROolHf3njibyPI3j8C5xOSNv9
         C3gMkVAujRMCWCl8tq0GASYQmhtBBVvpoS5UnXaXlsrKTsZFCWX+hkH1aO59zcQhv4kI
         eenwP090j66quVxzYFeQH0oZeCrcqo5N3822hGFHeOOZv3YKF8d1ovhNya0h5VhXkqfE
         kUYpLr5SsY/1VPCkpIZBoME0Szl7Ld2o3tSsUcITle7wfq2GfFuBVyQ9neUTboHo0B+d
         iLzbhv2rbY8zX6BgsWU9GBHBpxvNNrxLQAuphBBRtfM0D3IIHsD1wNwwUrHBWvv7o3dX
         uypw==
X-Gm-Message-State: ACgBeo090DtOunqo5SJK86qtLgjlfVRaaBvIJW1y0Ziq8JUjPC0sWCm3
        WazLt/ZCVx9bxa8dYvI7DlAm2Q==
X-Google-Smtp-Source: AA6agR7GQs7WbSFpxM2OC6iWA5ExQZcACNKPELahvGHBicBJ2yLmYsnf3EHY+SEg2QwynBynrhav5Q==
X-Received: by 2002:a05:620a:2416:b0:6bb:d0e0:39d7 with SMTP id d22-20020a05620a241600b006bbd0e039d7mr3156563qkn.654.1662564187404;
        Wed, 07 Sep 2022 08:23:07 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id u15-20020a05622a010f00b003435bb7fe9csm12667712qtw.78.2022.09.07.08.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:23:07 -0700 (PDT)
Message-ID: <d67ff219-ee60-7af3-9187-d51244e9efd2@joelfernandes.org>
Date:   Wed, 7 Sep 2022 11:23:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
To:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <YxeOZxngROuSFgc2@pc636>
 <264e5ce7-45c9-7526-12ae-97029d549d8e@joelfernandes.org>
 <Yxhb5r09C53DzoNu@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <Yxhb5r09C53DzoNu@pc638.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

On 9/7/2022 4:52 AM, Uladzislau Rezki wrote:
> On Tue, Sep 06, 2022 at 02:21:46PM -0400, Joel Fernandes wrote:
>>
>>
>> On 9/6/2022 2:16 PM, Uladzislau Rezki wrote:
>>>> On Fri, Sep 02, 2022 at 05:21:32PM +0200, Frederic Weisbecker wrote:
>>>>> On Thu, Sep 01, 2022 at 10:17:08PM +0000, Joel Fernandes (Google) wrote:
>>>>>> Implement timer-based RCU lazy callback batching. The batch is flushed
>>>>>> whenever a certain amount of time has passed, or the batch on a
>>>>>> particular CPU grows too big. Also memory pressure will flush it in a
>>>>>> future patch.
>>>>>>
>>>>>> To handle several corner cases automagically (such as rcu_barrier() and
>>>>>> hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
>>>>>> length has the lazy CB length included in it. A separate lazy CB length
>>>>>> counter is also introduced to keep track of the number of lazy CBs.
>>>>>>
>>>>>> Suggested-by: Paul McKenney <paulmck@kernel.org>
>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>> ---
>>>>
>>>> Here is the updated version of this patch for further testing and review.
>>>> Paul, you could consider updating your test branch. I have tested it in
>>>> ChromeOS as well, and rcuscale. The laziness and boot times are looking good.
>>>> There was at least one bug that I fixed that got introduced with the moving
>>>> of the length field to rcu_data.  Thanks a lot Frederic for the review
>>>> comments.
>>>>
>>>> I will look at the rcu torture issue next... I suspect the length field issue
>>>> may have been causing it.
>>>>
>>>> ---8<-----------------------
>>>>
>>>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>>> Subject: [PATCH v6] rcu: Introduce call_rcu_lazy() API implementation
>>>>
>>>> Implement timer-based RCU lazy callback batching. The batch is flushed
>>>> whenever a certain amount of time has passed, or the batch on a
>>>> particular CPU grows too big. Also memory pressure will flush it in a
>>>> future patch.
>>>>
>>>> To handle several corner cases automagically (such as rcu_barrier() and
>>>> hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
>>>> length has the lazy CB length included in it. A separate lazy CB length
>>>> counter is also introduced to keep track of the number of lazy CBs.
>>>>
>>>> v5->v6:
>>>>
>>>> [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
>>>>   deferral levels wake much earlier so for those it is not needed. ]
>>>>
>>>> [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
>>>>
>>>> [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
>>>>
>>>> Suggested-by: Paul McKenney <paulmck@kernel.org>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>>>  include/linux/rcupdate.h |   6 ++
>>>>  kernel/rcu/Kconfig       |   8 ++
>>>>  kernel/rcu/rcu.h         |  11 +++
>>>>  kernel/rcu/tree.c        | 133 +++++++++++++++++++----------
>>>>  kernel/rcu/tree.h        |  17 +++-
>>>>  kernel/rcu/tree_nocb.h   | 175 ++++++++++++++++++++++++++++++++-------
>>>>  6 files changed, 269 insertions(+), 81 deletions(-)
>>>>
>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>> index 08605ce7379d..82e8a07e0856 100644
>>>> --- a/include/linux/rcupdate.h
>>>> +++ b/include/linux/rcupdate.h
>>>> @@ -108,6 +108,12 @@ static inline int rcu_preempt_depth(void)
>>>>  
>>>>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>>>>  
>>>> +#ifdef CONFIG_RCU_LAZY
>>>> +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
>>>> +#else
>>>> +#define call_rcu_lazy(head, func) call_rcu(head, func)
>>>> +#endif
>>>> +
>>>>  /* Internal to kernel */
>>>>  void rcu_init(void);
>>>>  extern int rcu_scheduler_active;
>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>>> index d471d22a5e21..3128d01427cb 100644
>>>> --- a/kernel/rcu/Kconfig
>>>> +++ b/kernel/rcu/Kconfig
>>>> @@ -311,4 +311,12 @@ config TASKS_TRACE_RCU_READ_MB
>>>>  	  Say N here if you hate read-side memory barriers.
>>>>  	  Take the default if you are unsure.
>>>>  
>>>> +config RCU_LAZY
>>>> +	bool "RCU callback lazy invocation functionality"
>>>> +	depends on RCU_NOCB_CPU
>>>> +	default n
>>>> +	help
>>>> +	  To save power, batch RCU callbacks and flush after delay, memory
>>>> +	  pressure or callback list growing too big.
>>>> +
>>>>  endmenu # "RCU Subsystem"
>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>>> index be5979da07f5..94675f14efe8 100644
>>>> --- a/kernel/rcu/rcu.h
>>>> +++ b/kernel/rcu/rcu.h
>>>> @@ -474,6 +474,14 @@ enum rcutorture_type {
>>>>  	INVALID_RCU_FLAVOR
>>>>  };
>>>>  
>>>> +#if defined(CONFIG_RCU_LAZY)
>>>> +unsigned long rcu_lazy_get_jiffies_till_flush(void);
>>>> +void rcu_lazy_set_jiffies_till_flush(unsigned long j);
>>>> +#else
>>>> +static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
>>>> +static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
>>>> +#endif
>>>> +
>>>>  #if defined(CONFIG_TREE_RCU)
>>>>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>>>>  			    unsigned long *gp_seq);
>>>> @@ -483,6 +491,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>>>>  			       unsigned long c_old,
>>>>  			       unsigned long c);
>>>>  void rcu_gp_set_torture_wait(int duration);
>>>> +void rcu_force_call_rcu_to_lazy(bool force);
>>>> +
>>>>  #else
>>>>  static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
>>>>  					  int *flags, unsigned long *gp_seq)
>>>> @@ -501,6 +511,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>>>>  	do { } while (0)
>>>>  #endif
>>>>  static inline void rcu_gp_set_torture_wait(int duration) { }
>>>> +static inline void rcu_force_call_rcu_to_lazy(bool force) { }
>>>>  #endif
>>>>  
>>>>  #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index 9fe581be8696..dbd25b8c080e 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -2728,47 +2728,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
>>>>  	raw_spin_unlock_rcu_node(rnp);
>>>>  }
>>>>  
>>>> -/**
>>>> - * call_rcu() - Queue an RCU callback for invocation after a grace period.
>>>> - * @head: structure to be used for queueing the RCU updates.
>>>> - * @func: actual callback function to be invoked after the grace period
>>>> - *
>>>> - * The callback function will be invoked some time after a full grace
>>>> - * period elapses, in other words after all pre-existing RCU read-side
>>>> - * critical sections have completed.  However, the callback function
>>>> - * might well execute concurrently with RCU read-side critical sections
>>>> - * that started after call_rcu() was invoked.
>>>> - *
>>>> - * RCU read-side critical sections are delimited by rcu_read_lock()
>>>> - * and rcu_read_unlock(), and may be nested.  In addition, but only in
>>>> - * v5.0 and later, regions of code across which interrupts, preemption,
>>>> - * or softirqs have been disabled also serve as RCU read-side critical
>>>> - * sections.  This includes hardware interrupt handlers, softirq handlers,
>>>> - * and NMI handlers.
>>>> - *
>>>> - * Note that all CPUs must agree that the grace period extended beyond
>>>> - * all pre-existing RCU read-side critical section.  On systems with more
>>>> - * than one CPU, this means that when "func()" is invoked, each CPU is
>>>> - * guaranteed to have executed a full memory barrier since the end of its
>>>> - * last RCU read-side critical section whose beginning preceded the call
>>>> - * to call_rcu().  It also means that each CPU executing an RCU read-side
>>>> - * critical section that continues beyond the start of "func()" must have
>>>> - * executed a memory barrier after the call_rcu() but before the beginning
>>>> - * of that RCU read-side critical section.  Note that these guarantees
>>>> - * include CPUs that are offline, idle, or executing in user mode, as
>>>> - * well as CPUs that are executing in the kernel.
>>>> - *
>>>> - * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
>>>> - * resulting RCU callback function "func()", then both CPU A and CPU B are
>>>> - * guaranteed to execute a full memory barrier during the time interval
>>>> - * between the call to call_rcu() and the invocation of "func()" -- even
>>>> - * if CPU A and CPU B are the same CPU (but again only if the system has
>>>> - * more than one CPU).
>>>> - *
>>>> - * Implementation of these memory-ordering guarantees is described here:
>>>> - * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
>>>> - */
>>>> -void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>> +static void
>>>> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
>>>>  {
>>>>  	static atomic_t doublefrees;
>>>>  	unsigned long flags;
>>>> @@ -2818,7 +2779,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>  		trace_rcu_callback(rcu_state.name, head,
>>>>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>>>>  
>>>> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
>>>> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
>>>>  		return; // Enqueued onto ->nocb_bypass, so just leave.
>>>>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>>>>  	rcu_segcblist_enqueue(&rdp->cblist, head);
>>>> @@ -2833,8 +2794,86 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>  		local_irq_restore(flags);
>>>>  	}
>>>>  }
>>>> -EXPORT_SYMBOL_GPL(call_rcu);
>>>>  
>>>> +#ifdef CONFIG_RCU_LAZY
>>>> +/**
>>>> + * call_rcu_lazy() - Lazily queue RCU callback for invocation after grace period.
>>>> + * @head: structure to be used for queueing the RCU updates.
>>>> + * @func: actual callback function to be invoked after the grace period
>>>> + *
>>>> + * The callback function will be invoked some time after a full grace
>>>> + * period elapses, in other words after all pre-existing RCU read-side
>>>> + * critical sections have completed.
>>>> + *
>>>> + * Use this API instead of call_rcu() if you don't mind the callback being
>>>> + * invoked after very long periods of time on systems without memory pressure
>>>> + * and on systems which are lightly loaded or mostly idle.
>>>> + *
>>>> + * Other than the extra delay in callbacks being invoked, this function is
>>>> + * identical to, and reuses call_rcu()'s logic. Refer to call_rcu() for more
>>>> + * details about memory ordering and other functionality.
>>>> + */
>>>> +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func)
>>>> +{
>>>> +	return __call_rcu_common(head, func, true);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(call_rcu_lazy);
>>>> +#endif
>>>> +
>>>> +static bool force_call_rcu_to_lazy;
>>>> +
>>>> +void rcu_force_call_rcu_to_lazy(bool force)
>>>> +{
>>>> +	if (IS_ENABLED(CONFIG_RCU_SCALE_TEST))
>>>> +		WRITE_ONCE(force_call_rcu_to_lazy, force);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(rcu_force_call_rcu_to_lazy);
>>>> +
>>>> +/**
>>>> + * call_rcu() - Queue an RCU callback for invocation after a grace period.
>>>> + * @head: structure to be used for queueing the RCU updates.
>>>> + * @func: actual callback function to be invoked after the grace period
>>>> + *
>>>> + * The callback function will be invoked some time after a full grace
>>>> + * period elapses, in other words after all pre-existing RCU read-side
>>>> + * critical sections have completed.  However, the callback function
>>>> + * might well execute concurrently with RCU read-side critical sections
>>>> + * that started after call_rcu() was invoked.
>>>> + *
>>>> + * RCU read-side critical sections are delimited by rcu_read_lock()
>>>> + * and rcu_read_unlock(), and may be nested.  In addition, but only in
>>>> + * v5.0 and later, regions of code across which interrupts, preemption,
>>>> + * or softirqs have been disabled also serve as RCU read-side critical
>>>> + * sections.  This includes hardware interrupt handlers, softirq handlers,
>>>> + * and NMI handlers.
>>>> + *
>>>> + * Note that all CPUs must agree that the grace period extended beyond
>>>> + * all pre-existing RCU read-side critical section.  On systems with more
>>>> + * than one CPU, this means that when "func()" is invoked, each CPU is
>>>> + * guaranteed to have executed a full memory barrier since the end of its
>>>> + * last RCU read-side critical section whose beginning preceded the call
>>>> + * to call_rcu().  It also means that each CPU executing an RCU read-side
>>>> + * critical section that continues beyond the start of "func()" must have
>>>> + * executed a memory barrier after the call_rcu() but before the beginning
>>>> + * of that RCU read-side critical section.  Note that these guarantees
>>>> + * include CPUs that are offline, idle, or executing in user mode, as
>>>> + * well as CPUs that are executing in the kernel.
>>>> + *
>>>> + * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
>>>> + * resulting RCU callback function "func()", then both CPU A and CPU B are
>>>> + * guaranteed to execute a full memory barrier during the time interval
>>>> + * between the call to call_rcu() and the invocation of "func()" -- even
>>>> + * if CPU A and CPU B are the same CPU (but again only if the system has
>>>> + * more than one CPU).
>>>> + *
>>>> + * Implementation of these memory-ordering guarantees is described here:
>>>> + * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
>>>> + */
>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>> +{
>>>> +	return __call_rcu_common(head, func, force_call_rcu_to_lazy);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(call_rcu);
>>>>  
>>>>  /* Maximum number of jiffies to wait before draining a batch. */
>>>>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>>>> @@ -3904,7 +3943,11 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>>>>  	rdp->barrier_head.func = rcu_barrier_callback;
>>>>  	debug_rcu_head_queue(&rdp->barrier_head);
>>>>  	rcu_nocb_lock(rdp);
>>>> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>>> +        /*
>>>> +         * Flush the bypass list, but also wake up the GP thread as otherwise
>>>> +         * bypass/lazy CBs maynot be noticed, and can cause real long delays!
>>>> +         */
>>>> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAKE));
>>>>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>>>  		atomic_inc(&rcu_state.barrier_cpu_count);
>>>>  	} else {
>>>> @@ -4325,7 +4368,7 @@ void rcutree_migrate_callbacks(int cpu)
>>>>  	my_rdp = this_cpu_ptr(&rcu_data);
>>>>  	my_rnp = my_rdp->mynode;
>>>>  	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
>>>> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
>>>> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, FLUSH_BP_NONE));
>>>>  	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
>>>>  	/* Leverage recent GPs and set GP for new callbacks. */
>>>>  	needwake = rcu_advance_cbs(my_rnp, rdp) ||
>>>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>>>> index d4a97e40ea9c..361c41d642c7 100644
>>>> --- a/kernel/rcu/tree.h
>>>> +++ b/kernel/rcu/tree.h
>>>> @@ -263,14 +263,16 @@ struct rcu_data {
>>>>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
>>>>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
>>>>  
>>>> +	long lazy_len;			/* Length of buffered lazy callbacks. */
>>>>  	int cpu;
>>>>  };
>>>>  
>>>>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>>>>  #define RCU_NOCB_WAKE_NOT	0
>>>>  #define RCU_NOCB_WAKE_BYPASS	1
>>>> -#define RCU_NOCB_WAKE		2
>>>> -#define RCU_NOCB_WAKE_FORCE	3
>>>> +#define RCU_NOCB_WAKE_LAZY	2
>>>> +#define RCU_NOCB_WAKE		3
>>>> +#define RCU_NOCB_WAKE_FORCE	4
>>>>  
>>>>  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>>>>  					/* For jiffies_till_first_fqs and */
>>>> @@ -439,10 +441,17 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
>>>>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>>>>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>>>>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>>>> +
>>>> +#define FLUSH_BP_NONE 0
>>>> +/* Is the CB being enqueued after the flush, a lazy CB? */
>>>> +#define FLUSH_BP_LAZY BIT(0)
>>>> +/* Wake up nocb-GP thread after flush? */
>>>> +#define FLUSH_BP_WAKE BIT(1)
>>>>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>> -				  unsigned long j);
>>>> +				  unsigned long j, unsigned long flush_flags);
>>>>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>> -				bool *was_alldone, unsigned long flags);
>>>> +				bool *was_alldone, unsigned long flags,
>>>> +				bool lazy);
>>>>  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>>>>  				 unsigned long flags);
>>>>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
>>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>>> index 4dc86274b3e8..b201606f7c4f 100644
>>>> --- a/kernel/rcu/tree_nocb.h
>>>> +++ b/kernel/rcu/tree_nocb.h
>>>> @@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>>>>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>>>>  }
>>>>  
>>>> +/*
>>>> + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
>>>> + * can elapse before lazy callbacks are flushed. Lazy callbacks
>>>> + * could be flushed much earlier for a number of other reasons
>>>> + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
>>>> + * left unsubmitted to RCU after those many jiffies.
>>>> + */
>>>> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
>>>> +unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
>>>> +
>>>> +#ifdef CONFIG_RCU_LAZY
>>>> +// To be called only from test code.
>>>> +void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
>>>> +{
>>>> +	jiffies_till_flush = jif;
>>>> +}
>>>> +EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
>>>> +
>>>> +unsigned long rcu_lazy_get_jiffies_till_flush(void)
>>>> +{
>>>> +	return jiffies_till_flush;
>>>> +}
>>>> +EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
>>>> +#endif
>>>> +
>>>>  /*
>>>>   * Arrange to wake the GP kthread for this NOCB group at some future
>>>>   * time when it is safe to do so.
>>>> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>>>>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>>>>  
>>>>  	/*
>>>> -	 * Bypass wakeup overrides previous deferments. In case
>>>> -	 * of callback storm, no need to wake up too early.
>>>> +	 * Bypass wakeup overrides previous deferments. In case of
>>>> +	 * callback storm, no need to wake up too early.
>>>>  	 */
>>>> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
>>>> +	if (waketype == RCU_NOCB_WAKE_LAZY
>>>> +		&& READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {
>>>> +		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
>>>> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>>> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>>>>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>>>>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>>>  	} else {
>>>>
>>> Joel, i have a question here. I see that lazy callback just makes the GP
>>> start later where a regular call_rcu() API will instead cut it back.
>>> Could you please clarify how it solves the sequence like:
>>>
>>> CPU:
>>>
>>> 1) task A -> call_rcu_lazy();
>>> 2) task B -> call_rcu();
>>>
>>> so lazily decision about running GP later a task B overrides to initiate it sooner? 
>>
>> Is your question that task B will make task A's CB run sooner? Yes that's right.
>> The reason is that the point of call_rcu_lazy() is to delay GP start as much as
>> possible to keep system quiet. However, if a call_rcu() comes in any way, we
>> have to start a GP soon. So we might as well take advantage of that for the lazy
>> one as we are paying the full price for the new GP.
>>
>> It is kind of like RCU's amortizing behavior in that sense, however we put that
>> into overdrive to be greedy for power.
>>
>> Does that answer your question?
>>
> OK. I get it correctly then :) IMHO, the problem with such approach is that we
> may end-up in non-lazy way of moving RCU-core forward even though we do t lazily
> and one user not.

Yes, the best we can do seems to be to identify all call_rcu() users that can be
lazified (say using rcutop) and apply the API change to them. It depends on use
case for sure, for example if some usecase is doing frequent synchronize_rcu()
for whatever reason, then that will impede the lazy users. On the Intel ChromeOS
device, we do not see such a problem.

> According to my observation, our setup suffers from many wake-ups across the CPUs
> and mixing non_lazy_way with lazy_way will just be converted into a regular patern. 
> 
> I think adding kind of high_water_mark on "entry" would solve it. Any thoughts here?

By high water mark, do you mean for memory? If memory, we have to consider that
we cannot assume that call_rcu() users are using RCU for memory reclaim only.
There could be usecases like per-cpu refcounts which use call_rcu() for
non-memory purposes. How would use a memory-watermark there?


> Joel, do you see that v6 makes the system more idle from RCU perspective on the Intel SoC?

I did not compare Intel with say ARM, so I don't know whether ARM SoC is less
sensitive to this issue. I think it depends on the firmware as well. On Intel we
see that the firmware does not go as aggressive on SoC-wide power management if
there is RCU activity.. at least that's the observation.

> From my side i will port v6 on the 5.10 kernel and give some tests today.

Great, thanks! Looking forward to it.

- Joel

