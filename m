Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BDB5AF151
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiIFQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiIFQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:57:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA418B26
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:43:55 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j17so8452122qtp.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=B182PVkBm791K8NmHQmY6fLkscgqMQ03lQQDlaJn5I4=;
        b=yIs/TVG6wpus2gZzdMF3HjxqdsHh4jhxhUpoottcDatOSKkqELTRf1AVKWyGLwm58f
         YmBT2DH1r6ty1CF44R4MvkYk8dgYHqL4qVb68qi0g1AyHhIScT6yKQWGvaS+cUrpNoqb
         jyZ7vvKVMtrIfdJuILipS0IQtWWJf6WL3zwYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B182PVkBm791K8NmHQmY6fLkscgqMQ03lQQDlaJn5I4=;
        b=wR1pju5b5NO7XvWffqUSWNVLETLVF8gt3CVzZ4zoaV1C1AcHPeyUTXBwxg3v4bmNgF
         iGksuHl8NmXf45vO+c3rtx8bZg3c7ydf4NHKz+Xxn9HOcOS2qvpel/bbVqXW9B/A+4Vl
         3idSMhio8kMSZ7etVaf36EApNuvrOxH/1OfcA5aooMXvQcokl6rnn91vbrSNKuE/epGN
         7Q2ZrfXKaLKd5/kpiYYKCXMSsHM5CL1dwbpBo/duSq0JavmZ1piKn73UG6h0O8Vd1BRE
         4I7JVURXss7ZaVdoj+MRRkml7WtqlYby28PoNkW+pK8M5Hez2l0vvHo7scun1pO7/EQK
         /awQ==
X-Gm-Message-State: ACgBeo2C1eJRkn4ajQRCwWdHAb0PBSaGt7tWuL4nmqIhWDbJ5X1OIabU
        62ZXMmUGBJBUGNckNFVqbp3CIw==
X-Google-Smtp-Source: AA6agR7iygu6haibQiGI65Zy4C3daZATQR8SrJdUP9vfWqIh4lcuAf/ighYpKSovybWMP0rdfcIcVg==
X-Received: by 2002:ac8:5cc8:0:b0:344:79c3:9d9c with SMTP id s8-20020ac85cc8000000b0034479c39d9cmr44692171qta.638.1662482634146;
        Tue, 06 Sep 2022 09:43:54 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id g19-20020ac84813000000b003051ea4e7f6sm9684365qtq.48.2022.09.06.09.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:43:53 -0700 (PDT)
Message-ID: <4f6061f0-0de7-2916-dc6e-9f5af9b944c0@joelfernandes.org>
Date:   Tue, 6 Sep 2022 12:43:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
 <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
 <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
In-Reply-To: <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
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



On 9/6/2022 12:38 PM, Joel Fernandes wrote:
> 
> 
> On 9/6/2022 12:31 PM, Joel Fernandes wrote:
>>
>>
>> On 9/6/2022 12:15 PM, Joel Fernandes wrote:
>>>>> @@ -461,16 +521,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>>>  	// We need to use the bypass.
>>>>>  	rcu_nocb_wait_contended(rdp);
>>>>>  	rcu_nocb_bypass_lock(rdp);
>>>>> +
>>>>>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>>>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>>>>>  	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
>>>>> +		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
>>>>> +
>>>>>  	if (!ncbs) {
>>>>>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
>>>>>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>>>>>  	}
>>>>> +
>>>>>  	rcu_nocb_bypass_unlock(rdp);
>>>>>  	smp_mb(); /* Order enqueue before wake. */
>>>>> -	if (ncbs) {
>>>>> +
>>>>> +	// We had CBs in the bypass list before. There is nothing else to do if:
>>>>> +	// There were only non-lazy CBs before, in this case, the bypass timer
>>>> Kind of misleading. I would replace "There were only non-lazy CBs before" with
>>>> "There was at least one non-lazy CBs before".
>>> I really mean "There were only non-lazy CBs ever queued in the bypass list
>>> before". That's the bypass_is_lazy variable. So I did not fully understand your
>>> suggested comment change.
>>>
>>>>> +	// or GP-thread will handle the CBs including any new lazy ones.
>>>>> +	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
>>>>> +	// case the old lazy timer would have been setup. When that expires,
>>>>> +	// the new lazy one will be handled.
>>>>> +	if (ncbs && (!bypass_is_lazy || lazy)) {
>>>>>  		local_irq_restore(flags);
>>>>>  	} else {
>>>>>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
>>>>> @@ -479,6 +552,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>>  					    TPS("FirstBQwake"));
>>>>>  			__call_rcu_nocb_wake(rdp, true, flags);
>>>>> +		} else if (bypass_is_lazy && !lazy) {
>>>>> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>> +					    TPS("FirstBQwakeLazy2Non"));
>>>>> +			__call_rcu_nocb_wake(rdp, true, flags);
>>>>
>>>> Not sure we need this chunk. Since there are pending callbacks anyway,
>>>> nocb_gp_wait() should be handling them and it will set the appropriate
>>>> timer on the next loop.
>>>
>>> We do because those pending callbacks could be because of a bypass list flush
>>> and not because there were pending CBs before, right? I do recall missed wake
>>> ups of non-lazy CBs, and them having to wait for the full lazy timer duration
>>> and slowing down synchronize_rcu() which is on the ChromeOS boot critical path!
>>>
>>
>> Just to add more details, consider the series of events:
>>
>> 1. Only lazy CBs are ever queued. Timer is armed for multiple seconds.
>> rcu_segcblist_pend_cbs remains false.
>>
>> 2. First non-lazy CB triggers to code that does the bypyass rate-limit thing.
>>
>> 3. By pass list is flushed because it is non-lazy CB and we need to start GP
>> processing soon.
> 
> Correcting the events, #3 does not happen if we got here.
> 
>>
>> 4. Due to flush, rcu_segcblist_pend_cbs() is now true.
> 
> So rcu_segcblist_pend_cbs() cannot be true.
> 
>> 5. We reach this "else if" clause because bypass_is_lazy means only lazy CBs
>> were ever buffered. We need to reprogram the timer or do an immediate wake up.
>> That's the intention of __call_rcu_nocb_wake().
>>
>> I really saw #1 and #2 trigger during boot up itself and cause a multi-second
>> boot regression.
> 
> So may be this hunk is needed not needed any more and the boot regression is
> fine. I can try to drop this hunk and run the tests again...

Ah, now I know why I got confused. I *used* to flush the bypass list before when
!lazy CBs showed up. Paul suggested this is overkill. In this old overkill
method, I was missing a wake up which was likely causing the boot regression.
Forcing a wake up fixed that. Now in v5 I make it such that I don't do the flush
on a !lazy rate-limit.

I am sorry for the confusion. Either way, in my defense this is just an extra
bit of code that I have to delete. This code is hard. I have mostly relied on a
test-driven development. But now thanks to this review and I am learning the
code more and more...

Thanks,

 - Joel



