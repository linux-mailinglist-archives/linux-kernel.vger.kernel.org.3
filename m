Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F85548B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357731AbiFVLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355742AbiFVLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:46:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1E33A23;
        Wed, 22 Jun 2022 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655898406; x=1687434406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PLePtGK/nNadtMrdup55F1Wn755t1dKBv+FuXP1GQkU=;
  b=GWizppB8KtezXisVGMan2u3AF3nfi6qc8eW4/6Nblq5Dur8u7c/DcF6C
   Oc6uwviUvHiLJNtJISaLWEvc2PevYt7vJVM/g86Bxql55R9ZsaiSeoeah
   pCYgwzLVO+5tsZsuZTMN1ZoG/AAxuf8R81Z28yYulfKSDO2NxLXsiLc+p
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 04:46:45 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:46:45 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 04:46:43 -0700
Message-ID: <65e9c3bf-af54-3726-dff5-208a70473f65@quicinc.com>
Date:   Wed, 22 Jun 2022 17:16:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 01/12] rcu: Decrease FQS scan wait time in case of
 callback overloading
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-1-paulmck@kernel.org>
 <87c17e9a-565a-d717-3534-83a4c506b984@quicinc.com>
 <20220621221925.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220621221925.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2022 3:49 AM, Paul E. McKenney wrote:
> On Tue, Jun 21, 2022 at 10:59:58AM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
>>> The force-quiesce-state loop function rcu_gp_fqs_loop() checks for
>>> callback overloading and does an immediate initial scan for idle CPUs
>>> if so.  However, subsequent rescans will be carried out at as leisurely a
>>> rate as they always are, as specified by the rcutree.jiffies_till_next_fqs
>>> module parameter.  It might be tempting to just continue immediately
>>> rescanning, but this turns the RCU grace-period kthread into a CPU hog.
>>> It might also be tempting to reduce the time between rescans to a single
>>> jiffy, but this can be problematic on larger systems.
>>>
>>> This commit therefore divides the normal time between rescans by three,
>>> rounding up.  Thus a small system running at HZ=1000 that is suffering
>>> from callback overload will wait only one jiffy instead of the normal
>>> three between rescans.
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>    kernel/rcu/tree.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index c25ba442044a6..c19d5926886fb 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1993,6 +1993,11 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>>>    			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
>>>    				   jiffies + (j ? 3 * j : 2));
>>>    		}
>>> +		if (rcu_state.cbovld) {
>>> +			j = (j + 2) / 3;
>>> +			if (j <= 0)
>>> +				j = 1;
>>> +		}
>>
>> We update 'j' here, after setting rcu_state.jiffies_force_qs
>>
>>      WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j)
>>
>> So, we return from swait_event_idle_timeout_exclusive after 1/3 time
>> duration.
>>
>>      swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
>> 				 rcu_gp_fqs_check_wake(&gf), j);
>>
>> This can result in !timer_after check to return false and we will
>> enter the 'else' (stray signal block) code?
>>
>> This might not matter for first 2 fqs loop iterations, where
>> RCU_GP_FLAG_OVLD is set in 'gf', but subsequent iterations won't benefit
>> from this patch?
>>
>>
>> if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
>> 	(gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>> 			...
>> } else {
>> 	/* Deal with stray signal. */
>> }
>>
>>
>> So, do we need to move this calculation above the 'if' block which sets
>> rcu_state.jiffies_force_qs?
>> 		if (!ret) {
>>
>> 			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies +
>> 						j);...
>> 		}
> 
> Good catch, thank you!  How about the updated patch shown below?
> 

Looks good to me.


Thanks
Neeraj

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 77de092c78f549b5c28075bfee9998a525d21f84
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Apr 12 15:08:14 2022 -0700
> 
>      rcu: Decrease FQS scan wait time in case of callback overloading
>      
>      The force-quiesce-state loop function rcu_gp_fqs_loop() checks for
>      callback overloading and does an immediate initial scan for idle CPUs
>      if so.  However, subsequent rescans will be carried out at as leisurely a
>      rate as they always are, as specified by the rcutree.jiffies_till_next_fqs
>      module parameter.  It might be tempting to just continue immediately
>      rescanning, but this turns the RCU grace-period kthread into a CPU hog.
>      It might also be tempting to reduce the time between rescans to a single
>      jiffy, but this can be problematic on larger systems.
>      
>      This commit therefore divides the normal time between rescans by three,
>      rounding up.  Thus a small system running at HZ=1000 that is suffering
>      from callback overload will wait only one jiffy instead of the normal
>      three between rescans.
>      
>      [ paulmck: Apply Neeraj Upadhyay feedback. ]
>      
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c25ba442044a6..52094e72866e5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1983,7 +1983,12 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>   		gf = RCU_GP_FLAG_OVLD;
>   	ret = 0;
>   	for (;;) {
> -		if (!ret) {
> +		if (rcu_state.cbovld) {
> +			j = (j + 2) / 3;
> +			if (j <= 0)
> +				j = 1;
> +		}
> +		if (!ret || time_before(jiffies + j, rcu_state.jiffies_force_qs)) {
>   			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j);
>   			/*
>   			 * jiffies_force_qs before RCU_GP_WAIT_FQS state
