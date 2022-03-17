Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554374DCF54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiCQU2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiCQU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:28:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6346642;
        Thu, 17 Mar 2022 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QWXUe21q1gHls2uczwr3JpXzhHSqbD4o/avgcFBuero=; b=f7hzC9sXay5fUDnXj7tiN55V8M
        1m6lUnI7zujcL8yQgsuLgsQ/OnzWVul2XBJiN3Z0I94CwtcNmYUBBHyqW8w5eHY6bQ64Hqf4FW/KP
        XV33m62D9eWlFuUMIeaB2IeoI2uk2wAUXtQqbqdj2TgfNBYzdM6ojmuw+0a2ovvcOnPKdlO17vLmz
        9kaK5AzNA/nvNvLXX+SaFa8pFQ1AY0CQY7qPYbCxZWV41X2YeaQ0IbYk6DDiWiHe9AvspRjFviMj5
        CcpKNFbA076sOrUCVEAGwHQ/Xhj6h4mQ0V9fCUEtAvOcSdI933YDHNNKjw+TwSn3o1Rc2L+e6tBpF
        9Zz4te4g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUwhu-001zWV-Er; Thu, 17 Mar 2022 20:26:51 +0000
Message-ID: <48d30a49-541f-ac67-aa2a-bef8b182dcd9@infradead.org>
Date:   Thu, 17 Mar 2022 13:26:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RCU: undefined reference to irq_work_queue
Content-Language: en-US
To:     paulmck@kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220317173621.GQ4285@paulmck-ThinkPad-P17-Gen-1>
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



On 3/17/22 10:36, Paul E. McKenney wrote:
> On Thu, Mar 17, 2022 at 04:45:11PM +0000, Hyeonggon Yoo wrote:
>> On Thu, Mar 17, 2022 at 09:20:33AM -0700, Paul E. McKenney wrote:
>>> On Thu, Mar 17, 2022 at 03:24:42PM +0000, Hyeonggon Yoo wrote:
>>>> On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
>>>>>> Hello RCU folks,
>>>>>>

> ------------------------------------------------------------------------
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..66c5b5543511 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -38,6 +38,7 @@ config KPROBES
>  	depends on MODULES
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
> +	select TASKS_RCU if PREEMPTION
>  	help
>  	  Kprobes allows you to trap at almost any kernel address and
>  	  execute a callback function.  register_kprobe() establishes
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index f559870fbf8b..4f665ae0cf55 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
>  	  task-based RCU implementations.  Not for manual selection.
>  
>  config TASKS_RCU
> -	def_bool PREEMPTION
> +	def_bool 0

preferably
	def_bool n

but the 0 probably works...  :)

> +	select IRQ_WORK
>  	help
>  	  This option enables a task-based RCU implementation that uses
>  	  only voluntary context switch (not preemption!), idle, and
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 752ed89a293b..a7aaf150b704 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -127,6 +127,7 @@ config TRACING
>  	select BINARY_PRINTF
>  	select EVENT_TRACING
>  	select TRACE_CLOCK
> +	select TASKS_RCU if PREEMPTION
>  
>  config GENERIC_TRACER
>  	bool

-- 
~Randy
