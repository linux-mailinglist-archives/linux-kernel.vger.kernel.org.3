Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E05AF0DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiIFQkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiIFQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:38:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6276555F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:15:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id w4so4638853qvp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LOelBV/IXXPtmIJeYUARfOPCrWQ4CDmcKuWEe2JOG+Q=;
        b=e+CL9Rwtoo2kdhze7KSvkUNH5pMPPU7/KnYPHvdr9P1queZSVHfyc/5hKEXOTC3PCF
         q1ZWtaCbVCq/JQ5ZLyIAKlc3lNsZ8W2nAKqWVjS31JK39/8v816d5VoDeFfHJT1AEh8a
         c2GLB/mnPFdQKeG+6WNDRna9qIrR8I4sdi3QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LOelBV/IXXPtmIJeYUARfOPCrWQ4CDmcKuWEe2JOG+Q=;
        b=MPXs9zRR6nx4h2DjVMczpx74w5+6f9w/Wd2rrJ5LJgjO3QJ96NxoJu73GILKdimc+9
         ls5RJ4fd0M0BuIt9oD89xzrxEsMSJKwNcUn503HFctlpICKJcjREpJyHDbI2TcdWFYQ9
         tTpIA+O3R1D05PIQrjCz5WdAvncAJXIw6rBH8cU6H1ANNjoXmq0NUbKnAo5W1peDFjXV
         FRUcIymXrmhP8zOnrcMb5ZO4lePQuvYcPfKjMChTW3ZcGFU8w8XTGj/wyOabf7DeauPi
         wLmMgIfRIY//+t07zk6PJW9CjJCYMy/KshcqZe7OOHT4EQ2PR1gA47XgIV98WUqsYjZy
         07FQ==
X-Gm-Message-State: ACgBeo0UPjM8U5rrPPNoitaBDG9RWBO+S0S/ueK5wA3j8y4YBDU/a/CW
        cQu8Vb1z+zwAYPwOBoRVDnF0DQ==
X-Google-Smtp-Source: AA6agR5z0nIrV7ZT0sPMUkcKspYCEnTSkuvEPYVNrqP7AtL7Mn5I2us7n2V2g58P+PHFrpUn35WAsg==
X-Received: by 2002:a0c:ec46:0:b0:4a7:509:386e with SMTP id n6-20020a0cec46000000b004a70509386emr8314823qvq.61.1662480921703;
        Tue, 06 Sep 2022 09:15:21 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id j11-20020ac85c4b000000b0031ef67386a5sm10165581qtj.68.2022.09.06.09.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:15:21 -0700 (PDT)
Message-ID: <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
Date:   Tue, 6 Sep 2022 12:15:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220906151757.GA183806@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 11:17 AM, Frederic Weisbecker wrote:
> On Tue, Sep 06, 2022 at 03:05:46AM +0000, Joel Fernandes wrote:
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 4dc86274b3e8..b201606f7c4f 100644
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
> Still not static.

Oops will fix.

>> @@ -293,12 +322,16 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>>   * proves to be initially empty, just return false because the no-CB GP
>>   * kthread may need to be awakened in this case.
>>   *
>> + * Return true if there was something to be flushed and it succeeded, otherwise
>> + * false.
>> + *
> 
> This kind of contradict the comment that follows. Not sure you need to add
> that line because the existing comment seem to cover it.
> 
>>   * Note that this function always returns true if rhp is NULL.
> 
>>   */
>>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>> -				     unsigned long j)
>> +				     unsigned long j, unsigned long flush_flags)
>>  {
>>  	struct rcu_cblist rcl;
>> +	bool lazy = flush_flags & FLUSH_BP_LAZY;
>>  
>>  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
>>  	rcu_lockdep_assert_cblist_protected(rdp);
>> @@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>   * Note that this function always returns true if rhp is NULL.
>>   */
>>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>> -				  unsigned long j)
>> +				  unsigned long j, unsigned long flush_flags)
>>  {
>> +	bool ret;
>> +
>>  	if (!rcu_rdp_is_offloaded(rdp))
>>  		return true;
>>  	rcu_lockdep_assert_cblist_protected(rdp);
>>  	rcu_nocb_bypass_lock(rdp);
>> -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
>> +	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>> +
>> +	if (flush_flags & FLUSH_BP_WAKE)
>> +		wake_nocb_gp(rdp, true);
> 
> Why the true above?
> 
> Also should we check if the wake up is really necessary (otherwise it means we
> force a wake up for all rdp's from rcu_barrier())?

Good point. I need to look into your suggested optimization here more, it is
possible the wake up is not needed some of the times, but considering that
rcu_barrier() is a slow path, I will probably aim for robustness here over
mathematically correct code. And the cost of a missed wake up here can be
serious as I saw by the RCU_SCALE test I added. Also the wake up pf the rcuog
thread is square root of CPUs because of the rdp grouping right?

Still, it'd be good to not do something unnecessary, so your point is well
taken. I'll spend some time on this and get back to you.

>        was_alldone = rcu_segcblist_pend_cbs(&rdp->cblist);
>        ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>        if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
>        	  wake_nocb_gp(rdp, false);
> 
> 
>> @@ -461,16 +521,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>  	// We need to use the bypass.
>>  	rcu_nocb_wait_contended(rdp);
>>  	rcu_nocb_bypass_lock(rdp);
>> +
>>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>>  	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>> +
>> +	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
>> +		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
>> +
>>  	if (!ncbs) {
>>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
>>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>>  	}
>> +
>>  	rcu_nocb_bypass_unlock(rdp);
>>  	smp_mb(); /* Order enqueue before wake. */
>> -	if (ncbs) {
>> +
>> +	// We had CBs in the bypass list before. There is nothing else to do if:
>> +	// There were only non-lazy CBs before, in this case, the bypass timer
> 
> Kind of misleading. I would replace "There were only non-lazy CBs before" with
> "There was at least one non-lazy CBs before".

I really mean "There were only non-lazy CBs ever queued in the bypass list
before". That's the bypass_is_lazy variable. So I did not fully understand your
suggested comment change.

>> +	// or GP-thread will handle the CBs including any new lazy ones.
>> +	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
>> +	// case the old lazy timer would have been setup. When that expires,
>> +	// the new lazy one will be handled.
>> +	if (ncbs && (!bypass_is_lazy || lazy)) {
>>  		local_irq_restore(flags);
>>  	} else {
>>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
>> @@ -479,6 +552,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>  					    TPS("FirstBQwake"));
>>  			__call_rcu_nocb_wake(rdp, true, flags);
>> +		} else if (bypass_is_lazy && !lazy) {
>> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>> +					    TPS("FirstBQwakeLazy2Non"));
>> +			__call_rcu_nocb_wake(rdp, true, flags);
> 
> Not sure we need this chunk. Since there are pending callbacks anyway,
> nocb_gp_wait() should be handling them and it will set the appropriate
> timer on the next loop.

We do because those pending callbacks could be because of a bypass list flush
and not because there were pending CBs before, right? I do recall missed wake
ups of non-lazy CBs, and them having to wait for the full lazy timer duration
and slowing down synchronize_rcu() which is on the ChromeOS boot critical path!

Thanks,

 - Joel



