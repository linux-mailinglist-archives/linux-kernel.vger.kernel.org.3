Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38184E9AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiC1PVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1PVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:21:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8314B39145
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:19:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A11BD6E;
        Mon, 28 Mar 2022 08:19:49 -0700 (PDT)
Received: from [10.57.42.177] (unknown [10.57.42.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01863F73B;
        Mon, 28 Mar 2022 08:19:47 -0700 (PDT)
Message-ID: <32ac2c66-6286-5d35-81e0-a3adcf8c35d4@arm.com>
Date:   Mon, 28 Mar 2022 16:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
 <878rt2atre.ffs@tglx> <bc66bee6-7c99-b289-f5e9-ccaf03d5605d@arm.com>
 <87wngla932.ffs@tglx> <a704e21e-c1a6-6ffd-439c-e715a2633319@arm.com>
 <87czicap83.ffs@tglx>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <87czicap83.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 11:21, Thomas Gleixner wrote:
> On Wed, Mar 23 2022 at 10:10, Steven Price wrote:
>> On 22/03/2022 22:58, Thomas Gleixner wrote:
>>> Indeed. But the description is not the only problem here:
>>>
>>> It's completely uncomprehensible from the code in _cpu_up() _WHY_ this
>>>
>>>      st->cpu = cpu;
>>>      
>>> assignment has to be there.
>>>
>>> It's non-sensical if you really think about it, right?
>>
>> I entirely agree, and I did ask in my v1 posting[1] if anyone could
>> point me to a better place to do the assignment. Vincent suggested
>> moving it earlier in _cpu_up() which is this v2.
>>
>> But it still seems out-of-place to me. I've just had a go at simply
>> removing the 'cpu' member and it doesn't look too bad. I'll post that
>> patch as a follow up. I'm open to other suggestions for the best way to
>> fix this.
> 
> Yes, we can do that. The alternative solution is to initialize the
> states once upfront. Something like the uncompiled below.

The below works as well. Do you prefer to go with that or my removal of
the 'cpu' member?

If the below then would you be able to send a proper patch? Feel free to
add my...

Tested-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> Thanks,
> 
>         tglx
> ---
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -714,15 +714,6 @@ static int cpuhp_up_callbacks(unsigned i
>  /*
>   * The cpu hotplug threads manage the bringup and teardown of the cpus
>   */
> -static void cpuhp_create(unsigned int cpu)
> -{
> -	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
> -
> -	init_completion(&st->done_up);
> -	init_completion(&st->done_down);
> -	st->cpu = cpu;
> -}
> -
>  static int cpuhp_should_run(unsigned int cpu)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> @@ -882,15 +873,28 @@ static int cpuhp_kick_ap_work(unsigned i
>  
>  static struct smp_hotplug_thread cpuhp_threads = {
>  	.store			= &cpuhp_state.thread,
> -	.create			= &cpuhp_create,
>  	.thread_should_run	= cpuhp_should_run,
>  	.thread_fn		= cpuhp_thread_fun,
>  	.thread_comm		= "cpuhp/%u",
>  	.selfparking		= true,
>  };
>  
> +static __init void cpuhp_init_state(void)
> +{
> +	struct cpuhp_cpu_state *st;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		st = per_cpu_ptr(&cpuhp_state, cpu);
> +		init_completion(&st->done_up);
> +		init_completion(&st->done_down);
> +		st->cpu = cpu;
> +	}
> +}
> +
>  void __init cpuhp_threads_init(void)
>  {
> +	cpuhp_init_state();
>  	BUG_ON(smpboot_register_percpu_thread(&cpuhp_threads));
>  	kthread_unpark(this_cpu_read(cpuhp_state.thread));
>  }

