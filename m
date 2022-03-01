Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E984C9240
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiCAR4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiCAR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:56:10 -0500
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3A45DA76
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:55:27 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 689B5C5B2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:55:27 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id P6idnPhzt22u3P6idnMza1; Tue, 01 Mar 2022 11:55:27 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40038 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nP6ic-003Ftl-OS; Tue, 01 Mar 2022 11:55:26 -0600
Message-ID: <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
Date:   Tue, 1 Mar 2022 18:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        paulmck@kernel.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
 <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nP6ic-003Ftl-OS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40038
X-Source-Auth: kernel@bristot.me
X-Email-Count: 14
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 11:52, Nicolas Saenz Julienne wrote:
> On Mon, 2022-02-28 at 21:00 +0100, Daniel Bristot de Oliveira wrote:
>> On 2/28/22 15:14, Nicolas Saenz Julienne wrote:
>>> At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
>>> kernel might have the side effect of extending grace periods too much.
>>> This will eventually entice RCU to schedule a task on the isolated CPU
>>> to end the overly extended grace period, adding unwarranted noise to the
>>> CPU being traced in the process.
>>>
>>> So, check if we're the only ones running on this isolated CPU and that
>>> we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
>>> between measurements.
>>>
>>> Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
>>> loop's cond_resched() will go though a quiescent state for them.
>>>
>>> Note that this same exact problem is what extended quiescent states were
>>> created for. But adapting them to this specific use-case isn't trivial
>>> as it'll imply reworking entry/exit and dynticks/context tracking code.
>>>
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
>>> ---
>>>  kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>>> index 870a08da5b48..4928358f6e88 100644
>>> --- a/kernel/trace/trace_osnoise.c
>>> +++ b/kernel/trace/trace_osnoise.c
>>> @@ -21,7 +21,9 @@
>>>  #include <linux/uaccess.h>
>>>  #include <linux/cpumask.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/tick.h>
>>>  #include <linux/sched/clock.h>
>>> +#include <linux/sched/isolation.h>
>>>  #include <uapi/linux/sched/types.h>
>>>  #include <linux/sched.h>
>>>  #include "trace.h"
>>> @@ -1295,6 +1297,7 @@ static int run_osnoise(void)
>>>  	struct osnoise_sample s;
>>>  	unsigned int threshold;
>>>  	u64 runtime, stop_in;
>>> +	unsigned long flags;
>>>  	u64 sum_noise = 0;
>>>  	int hw_count = 0;
>>>  	int ret = -1;
>>> @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
>>>  					osnoise_stop_tracing();
>>>  		}
>>>  
>>> +		/*
>>> +		 * Check if we're the only ones running on this nohz_full CPU
>>> +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
>>> +		 * QS since there is no way for RCU to know we're not making
>>> +		 * use of it.
>>> +		 *
>>> +		 * Otherwise it'll be done through cond_resched().
>>> +		 */
>>> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
>>> +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
>>
>> Does this restrict to only isolcpus cpus?
> 
> nohz_full CPUs actually, IIUC HK_FLAG_MISC isn't set if isolcpus is used, which
> is deprecated anyway.

Perfecto!

> 
>> what if this CPU was isolated via other methods?
> 
> osnoise with an uncontested FIFO priority for example?

No, I was mentioning something like tuna/tasket/systemd/cgroup, anything other
than isolcpus... as it is doing (I miss interpreted the HK_FLAG_MISC).

I do not agree on using busy-loop with FIFO.

I believe in that case
> RCU will start throwing "rcu_preempt detected stalls" style warnings. As it
> won't be able to preempt the osnoise CPU to force the grace period ending.
> 
> I see your point though, this would also help in that situation. We could maybe
> relax the entry barrier to rcu_momentary_dyntick_idle(). I think it's safe to
> call it regardless of nohz_full/tick state for most cases, I just wanted to
> avoid the overhead. The only thing that worries me is PREEMPT_RT and its
> rt_spinlocks, which can be preempted.

no, that was not my point.

> 
>>> +		    tick_nohz_tick_stopped()) {
>>> +			local_irq_save(flags);
>>
>> This code is always with interrupts enabled, so local_irq_disable()/enable()
>> should be enough (and faster).
> 
> Noted.
> 
>>> +			rcu_momentary_dyntick_idle();
>>> +			local_irq_restore(flags);
>>> +		}
>>
>> Question, if we set this once, we could avoid setting it on every loop unless we
>> have a preemption from another thread, right?
> 
> This tells RCU the CPU went through a quiescent state, which removes it from
> the current grace period accounting. It's different from an extended quiescent
> state, which fully disables the CPU from RCU's perspective.

Got it!

> We don't need to do it on every iteration, but as Paul explained in the mail
> thread it has to happen at least every ~20-30ms.

I see, as long as it costs < 1 us, I am ok. If it gets > 1us in a reasonably
fast machine, we start see HW noise where it does not exist, and that would
reduce the resolution of osnoise. AFAICS, it is not causing that problem, but we
need to make it as lightweight as possible.

-- Daniel

> Thanks!
> 

