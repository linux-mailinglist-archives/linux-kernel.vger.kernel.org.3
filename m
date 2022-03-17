Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6E4DCF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiCQUc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiCQUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:32:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7444186C1;
        Thu, 17 Mar 2022 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9m3Wk4/8Nn1QkYXebUrJc3OWe+WqxVuM6ISBD/PRUyo=; b=cAqfdnfWZ1UHSyl9GPqP/n1Cga
        Tz71XKkymuvvmnl3E91OOrjUFqad6Wx4JLAtXzIyQektLrIZpbDn5qBX1HzKafwIRmhBoTVFpuyxX
        noGnW1g/+DpAqyYd8SFByIPMk2MSNby76giIWu7HlXxiY1pJ94k/JlHm94ZxjetLOOkB/kp/v7mN4
        AKQJqr1vrE02As/9NnHFNvZVth7So/PMRL5RUzukYPmjfvj+9nkY1JS1UmD+ufIIECLrHXX1ejfyQ
        1pLaaNgR/2FVOMjm0zT7I28VBZMtm2T2LBgzwvDPyM7p/GsRr/E62WOiuvwrcXNYpGdc6fZknGyya
        21Lf0q9Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUwm1-001zco-Gz; Thu, 17 Mar 2022 20:31:06 +0000
Message-ID: <323e29c6-36ce-4aa6-22f7-7b98c1425d10@infradead.org>
Date:   Thu, 17 Mar 2022 13:31:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RCU: undefined reference to irq_work_queue
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317162033.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNll+Iv++LORS0n@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317173621.GQ4285@paulmck-ThinkPad-P17-Gen-1>
 <48d30a49-541f-ac67-aa2a-bef8b182dcd9@infradead.org>
 <20220317202925.GS4285@paulmck-ThinkPad-P17-Gen-1>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220317202925.GS4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/22 13:29, Paul E. McKenney wrote:
> On Thu, Mar 17, 2022 at 01:26:45PM -0700, Randy Dunlap wrote:
>>
>>
>> On 3/17/22 10:36, Paul E. McKenney wrote:
>>> On Thu, Mar 17, 2022 at 04:45:11PM +0000, Hyeonggon Yoo wrote:
>>>> On Thu, Mar 17, 2022 at 09:20:33AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, Mar 17, 2022 at 03:24:42PM +0000, Hyeonggon Yoo wrote:
>>>>>> On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
>>>>>>> On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
>>>>>>>> Hello RCU folks,
>>>>>>>>
>>
>>> ------------------------------------------------------------------------
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 678a80713b21..66c5b5543511 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -38,6 +38,7 @@ config KPROBES
>>>  	depends on MODULES
>>>  	depends on HAVE_KPROBES
>>>  	select KALLSYMS
>>> +	select TASKS_RCU if PREEMPTION
>>>  	help
>>>  	  Kprobes allows you to trap at almost any kernel address and
>>>  	  execute a callback function.  register_kprobe() establishes
>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>> index f559870fbf8b..4f665ae0cf55 100644
>>> --- a/kernel/rcu/Kconfig
>>> +++ b/kernel/rcu/Kconfig
>>> @@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
>>>  	  task-based RCU implementations.  Not for manual selection.
>>>  
>>>  config TASKS_RCU
>>> -	def_bool PREEMPTION
>>> +	def_bool 0
>>
>> preferably
>> 	def_bool n
>>
>> but the 0 probably works...  :)
> 
> In a later commit, it ends up like this:
> 
> config TASKS_TRACE_RCU
> 	bool "Enable Tasks Trace RCU"
> 	depends on RCU_EXPERT
> 	default n
> 	select IRQ_WORK
> 	help
> 	  This option enables a task-based RCU implementation that uses
> 	  explicit rcu_read_lock_trace() read-side markers, and allows
> 	  these readers to appear in the idle loop as well as on the CPU
> 	  hotplug code paths.  It can force IPIs on online CPUs, including
> 	  idle ones, so use with caution.
> 
> The reason being to allow people to use rcutorture without having
> to have TASKS_TRACE_RCU enabled.
> 
> So you got your wish!  I think...  ;-)
> 
> 							Thanx, Paul

Yeah, thanks.

>>> +	select IRQ_WORK
>>>  	help
>>>  	  This option enables a task-based RCU implementation that uses
>>>  	  only voluntary context switch (not preemption!), idle, and
>>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>>> index 752ed89a293b..a7aaf150b704 100644
>>> --- a/kernel/trace/Kconfig
>>> +++ b/kernel/trace/Kconfig
>>> @@ -127,6 +127,7 @@ config TRACING
>>>  	select BINARY_PRINTF
>>>  	select EVENT_TRACING
>>>  	select TRACE_CLOCK
>>> +	select TASKS_RCU if PREEMPTION
>>>  
>>>  config GENERIC_TRACER
>>>  	bool
>>
>> -- 
>> ~Randy

-- 
~Randy
