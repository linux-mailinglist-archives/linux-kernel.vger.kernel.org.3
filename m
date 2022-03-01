Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A074C928F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiCASIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiCASIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:08:05 -0500
X-Greylist: delayed 1231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 10:07:23 PST
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCE383
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:07:21 -0800 (PST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 014E1178997
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:46:50 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id P6YLnjux1b6UBP6YLnX1oA; Tue, 01 Mar 2022 11:44:49 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40036 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nP6YK-0035ji-VU; Tue, 01 Mar 2022 11:44:49 -0600
Message-ID: <c132609d-3eeb-9d8a-c06d-2171ff4c83f2@kernel.org>
Date:   Tue, 1 Mar 2022 18:44:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, paulmck@kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <20220228221154.GN4285@paulmck-ThinkPad-P17-Gen-1>
 <1b388cdc409fdfae75ef2280674d8211e5b6194e.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <1b388cdc409fdfae75ef2280674d8211e5b6194e.camel@redhat.com>
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
X-Exim-ID: 1nP6YK-0035ji-VU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40036
X-Source-Auth: kernel@bristot.me
X-Email-Count: 8
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 11:00, Nicolas Saenz Julienne wrote:
> On Mon, 2022-02-28 at 14:11 -0800, Paul E. McKenney wrote:
>> On Mon, Feb 28, 2022 at 03:14:23PM +0100, Nicolas Saenz Julienne wrote:
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
>>> +		    tick_nohz_tick_stopped()) {
>>> +			local_irq_save(flags);
>>> +			rcu_momentary_dyntick_idle();
>>> +			local_irq_restore(flags);
>>
>> What is supposed to happen in this case is that RCU figures out that
>> there is a nohz_full CPU running for an extended period of time in the
>> kernel and takes matters into its own hands.  This goes as follows on
>> a HZ=1000 kernel with default RCU settings:
>>
>> o	At about 20 milliseconds into the grace period, RCU makes
>> 	cond_resched() report quiescent states, among other things.
>> 	As you say, this does not help for CONFIG_PREEMPT=n kernels.
>>
>> o	At about 30 milliseconds into the grace period, RCU forces an
>> 	explicit context switch on the wayward CPU.  This should get
>> 	the CPU's attention even in CONFIG_PREEMPT=y kernels.
>>
>> So what is happening for you instead?
> 
> Well, that's exactly what I'm seeing, but it doesn't play well with osnoise.
> 
> Here's a simplified view of what the tracer does:
> 
> 	time1 = get_time();
> 	while(1) {
> 		time2 = get_time();
> 		if (time2 - time1 > threshold)
> 			trace_noise();
> 		cond_resched();
> 		time1 = time2;
> 	}
> 
> This is pinned to a specific CPU, and in the most extreme cases is expected to
> take 100% of CPU time. Eventually, some SMI, NMI/interrupt, or process
> execution will trigger the threshold, and osnoise will provide some nice traces
> explaining what happened.
> 
> RCU forcing a context switch on the wayward CPU is introducing unwarranted
> noise as it's triggered by the fact we're measuring and wouldn't happen
> otherwise.

I confirm this, it would be nice to have on osnoise a behavior similar to the
user-space (in EQS). I was about to send an RFC with a solution for the same
problem... (continues..)

> 
> If this were user-space, we'd be in an EQS, which would make this problem go
> away. An option would be mimicking this behaviour (assuming irq entry/exit code
> did the right thing):
> 
> 	rcu_eqs_enter(); <--
> 	time1 = get_time();
> 	while(1) {
> 		time2 = get_time();
> 		if (time2 - time1 > threshold)
> 			trace_noise();
> 		rcu_eqs_exit(); <--
> 		cond_resched();
> 		rcu_eqs_enter(); <--
> 		time1 = time2;
> 	}

... my patch was something in these lines. I was actually calling using
rcu_user_enter/exit (or context_tracking_enter/exit), pretending to be in
user-space. I left the user-mode if any thing from kernel would have to be
called, like tracepoints or re-sched. I had to keep preemption disabled to avoid
getting into the scheduler, enabling it in case of need resched. It worked (tm),
and it was equivalent to having osnoise preemptive.

BUT, it was more intrusive. I would prefer a solution in the lines of the one
Nicolas are proposing in his patch.

-- Danie

