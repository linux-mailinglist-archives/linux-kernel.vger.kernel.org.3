Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B245AF0FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiIFQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiIFQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:47:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CA26F574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:31:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y18so8448340qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MFwnn+PjFU1sAg+k+NBIGiAHHm5kHb9P+qOI11RuYt8=;
        b=BTGxLACxbWQw7ODC9R83yb8DVAQFZnsVTrGuL5qP5Iygy1nIREdig974eAQPfDHfW+
         5BlvAyS8Rg0JdIG4o4Hr+AazUrgo35GujbZj2LUzLdbwD2qYgq39jRqEccgakBl5ZD1A
         7gNzh6dYsNj2GSLMLBLhy1FpFVCPPE4iBkNrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MFwnn+PjFU1sAg+k+NBIGiAHHm5kHb9P+qOI11RuYt8=;
        b=qdl/EvzMr4NtlIULzpw6STkqXGk8nmOaU32ynwY1ib8z4pYX8ZmRymZ+MQ1WFksLjV
         4HZSbmaSvbSMPOGcwMXoan1r+qNHz9NK8A0DFoz3fLggLYdLxG3sPYwQz43Ld3u+vPmJ
         xKfC3UkJdCsRK1Mcgr9b1zKMnHkQpoG4Ht6C0t4a3/yVLrBbQpm4FFWpNBNckHIll9YY
         /4xwZTFDCbAsTnOJ0199U+NYYNodPEH34qQe9msmGDLWWJAg80DR+PGGhurs7s50V9od
         UqOQE0D4+0okOzZirR85bzPIWK27iJdcV+v+3dzUf/tz8hm17OnwanX6Smnn7wou9JYF
         FJZg==
X-Gm-Message-State: ACgBeo3dwOLY7mu5rc6jZaq7/0xj5pQmcjufBegC2GxdKrNEnsra1N1b
        LtIay8F35Zyw1peJ3BnKonQuyg==
X-Google-Smtp-Source: AA6agR4tyNRvLvbE8meY6DSpa1F7rsPRIvyMegMAekLW106CXua4frDNyIpP4RWJ8kbl/daADZTqxA==
X-Received: by 2002:a05:622a:2cc:b0:344:6004:314c with SMTP id a12-20020a05622a02cc00b003446004314cmr44974464qtx.412.1662481868273;
        Tue, 06 Sep 2022 09:31:08 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bl28-20020a05620a1a9c00b006bc5cdc890bsm10784549qkb.77.2022.09.06.09.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:31:07 -0700 (PDT)
Message-ID: <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
Date:   Tue, 6 Sep 2022 12:31:06 -0400
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
In-Reply-To: <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
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



On 9/6/2022 12:15 PM, Joel Fernandes wrote:
>>> @@ -461,16 +521,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>  	// We need to use the bypass.
>>>  	rcu_nocb_wait_contended(rdp);
>>>  	rcu_nocb_bypass_lock(rdp);
>>> +
>>>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>>>  	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>>> +
>>> +	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
>>> +		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
>>> +
>>>  	if (!ncbs) {
>>>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
>>>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>>>  	}
>>> +
>>>  	rcu_nocb_bypass_unlock(rdp);
>>>  	smp_mb(); /* Order enqueue before wake. */
>>> -	if (ncbs) {
>>> +
>>> +	// We had CBs in the bypass list before. There is nothing else to do if:
>>> +	// There were only non-lazy CBs before, in this case, the bypass timer
>> Kind of misleading. I would replace "There were only non-lazy CBs before" with
>> "There was at least one non-lazy CBs before".
> I really mean "There were only non-lazy CBs ever queued in the bypass list
> before". That's the bypass_is_lazy variable. So I did not fully understand your
> suggested comment change.
> 
>>> +	// or GP-thread will handle the CBs including any new lazy ones.
>>> +	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
>>> +	// case the old lazy timer would have been setup. When that expires,
>>> +	// the new lazy one will be handled.
>>> +	if (ncbs && (!bypass_is_lazy || lazy)) {
>>>  		local_irq_restore(flags);
>>>  	} else {
>>>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
>>> @@ -479,6 +552,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>  					    TPS("FirstBQwake"));
>>>  			__call_rcu_nocb_wake(rdp, true, flags);
>>> +		} else if (bypass_is_lazy && !lazy) {
>>> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>> +					    TPS("FirstBQwakeLazy2Non"));
>>> +			__call_rcu_nocb_wake(rdp, true, flags);
>>
>> Not sure we need this chunk. Since there are pending callbacks anyway,
>> nocb_gp_wait() should be handling them and it will set the appropriate
>> timer on the next loop.
>
> We do because those pending callbacks could be because of a bypass list flush
> and not because there were pending CBs before, right? I do recall missed wake
> ups of non-lazy CBs, and them having to wait for the full lazy timer duration
> and slowing down synchronize_rcu() which is on the ChromeOS boot critical path!
> 

Just to add more details, consider the series of events:

1. Only lazy CBs are ever queued. Timer is armed for multiple seconds.
rcu_segcblist_pend_cbs remains false.

2. First non-lazy CB triggers to code that does the bypyass rate-limit thing.

3. By pass list is flushed because it is non-lazy CB and we need to start GP
processing soon.

4. Due to flush, rcu_segcblist_pend_cbs() is now true.

5. We reach this "else if" clause because bypass_is_lazy means only lazy CBs
were ever buffered. We need to reprogram the timer or do an immediate wake up.
That's the intention of __call_rcu_nocb_wake().

I really saw #1 and #2 trigger during boot up itself and cause a multi-second
boot regression.

The chunk is needed to handle this case. I indeed do not see a boot regression
any more. Did I miss something?

Thanks,

 - Joel
