Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2A950890D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378875AbiDTNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378833AbiDTNUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:20:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924E427FC;
        Wed, 20 Apr 2022 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4PXFzm35+V0BALCL5GGLWBjOBStzXizdcmfFE2QG5fU=; b=IVkLgdZ3smr9rN45/3wIy1QAbU
        mtlQOug5VjX2sinlNH74dHiShDQ8CjJh4CEdA9Xag8csr2Rx4tnwqbUia93LDT+8/xdlu45eNSq8V
        lDJzLOjKP/NeF1cy/49cOSl6/PfUnDmmyHlmYOdS2L7xpY6XhQbau+HNAUGfw8izcWGIQvMej6YPC
        Mfkl916JNeWdE4FPQbYAlHlHksW55B76SPojAOZACyTFI9JV462juXrb4ECxhYfNRuu3Hht7pFXjE
        MFvGUBaQDj6/WcfBp6A0/mdo2QwzKlUupTTi1Vk9ozpqe+O9GJ9g441ock0372d9RyRYZ//f2zbqc
        Rb5M+IYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhAD7-0077j4-2L; Wed, 20 Apr 2022 13:17:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2ECBE9861A4; Wed, 20 Apr 2022 15:17:31 +0200 (CEST)
Date:   Wed, 20 Apr 2022 15:17:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220420131731.GF2731@worktop.programming.kicks-ass.net>
References: <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418170104.GA16199@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:01:05PM +0200, Oleg Nesterov wrote:

> diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
> index ec8b312f7506..1b5a57048e13 100644
> --- a/include/linux/sched/jobctl.h
> +++ b/include/linux/sched/jobctl.h
> @@ -22,7 +22,8 @@ struct task_struct;
>  
>  #define JOBCTL_STOPPED_BIT	24
>  #define JOBCTL_TRACED_BIT	25
> +#define JOBCTL_TRACED_XXX_BIT	25

26, also we must come up with a better name than tripple-x. In my head
it's started to be called TRACED_OLEG, but that can't be right either
;-)

Does something like:

#define JOBCTL_TRACED_BIT		25
#define JOBCTL_TRACED_QUIESCE_BIT	26

work?

> diff --git a/kernel/signal.c b/kernel/signal.c
> index 0aea3f0a8002..c7a89904cc4a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2182,6 +2182,13 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  	spin_unlock_irqrestore(&sighand->siglock, flags);
>  }
>  
> +static void clear_traced_xxx(void)
> +{
> +	spin_lock_irq(&current->sighand->siglock);
> +	current->jobctl &= ~JOBCTL_TRACED_XXX;
> +	spin_unlock_irq(&current->sighand->siglock);
> +}
> +
>  /*
>   * This must be called with current->sighand->siglock held.
>   *
> @@ -2220,7 +2227,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  	 * schedule() will not sleep if there is a pending signal that
>  	 * can awaken the task.
>  	 */
> -	current->jobctl |= JOBCTL_TRACED;
> +	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_XXX;
>  	set_special_state(TASK_TRACED);
>  
>  	/*
> @@ -2282,6 +2289,8 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  		if (gstop_done && ptrace_reparented(current))
>  			do_notify_parent_cldstop(current, false, why);
>  
> +		clear_traced_xxx();
> +		wake_up_state(current->parent, TASK_KILLABLE);
>  		/*
>  		 * Don't want to allow preemption here, because
>  		 * sys_ptrace() needs this task to be inactive.
> @@ -2297,8 +2306,12 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  	} else {
>  		/*
>  		 * By the time we got the lock, our tracer went away.
> -		 * Don't drop the lock yet, another tracer may come.
> -		 *
> +		 * Don't drop the lock yet, another tracer may come,
> +		 * tasklist protects us from ptrace_freeze_traced().
> +		 */
> +		__set_current_state(TASK_RUNNING);
> +		clear_traced_xxx();
> +		/*
>  		 * If @gstop_done, the ptracer went away between group stop
>  		 * completion and here.  During detach, it would have set
>  		 * JOBCTL_STOP_PENDING on us and we'll re-enter

This is that same else clause again; perhaps make signal_wake_up_state()
also clear TRACED_XXX instead?
