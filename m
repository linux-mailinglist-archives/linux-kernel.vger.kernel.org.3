Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9B4F4C55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578131AbiDEXSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357777AbiDEK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:27:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5113339BB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JRCtPql37TI0QCAvo5gW2Zck8T0P/CqvA5SiZrYJuYk=; b=P8Fdu3E46UH/j9cbM0vhZ3I4j4
        P3hCnKljTXjPpOhVbNoxZbPnnfk27KD6EdpsVXRQHssmrcI+3FVTxjnsBl9pBUDZt3LfpTBUYhRgw
        KRWmyMkFq27QsAgh6ZOFp1I3FmgmAJMyXXs2S6DZE2tXKeP2B86RgCPjfbwbNarCOv2ICByaJtg1Y
        U/Mi1uoPFm2LQAl8MyKlTW3fGanNx840M0f9u83HcYFAhS2nYyK/obT1nkuz/js72ov5v7Ls2LTBE
        C+lwefHBW8UpMOscSP7shKLI2UpkNPLXDG18jcRLnaly9S9wPNLZW62aG/T/WOFwB4xmpUqwpHg2z
        u+iq5xAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbg8q-006aqi-SA; Tue, 05 Apr 2022 10:10:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03E57986B5B; Tue,  5 Apr 2022 12:10:26 +0200 (CEST)
Date:   Tue, 5 Apr 2022 12:10:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on
 PREEMPT_RT.
Message-ID: <20220405101026.GB34954@worktop.programming.kicks-ass.net>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
 <YkW55u6u2fo5QmV7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkW55u6u2fo5QmV7@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:25:42PM +0200, Sebastian Andrzej Siewior wrote:
> As explained by Alexander Fyodorov <halcy@yandex.ru>:
> 
> |read_lock(&tasklist_lock) in ptrace_stop() is converted to sleeping
> |lock on a PREEMPT_RT kernel, and it can remove __TASK_TRACED from
> |task->__state (by moving  it to task->saved_state). If parent does
> |wait() on child followed by a sys_ptrace call, the following race can
> |happen:
> |
> |- child sets __TASK_TRACED in ptrace_stop()
> |- parent does wait() which eventually calls wait_task_stopped() and returns
> |  child's pid
> |- child blocks on read_lock(&tasklist_lock) in ptrace_stop() and moves
> |  __TASK_TRACED flag to saved_state
> |- parent calls sys_ptrace, which calls ptrace_check_attach() and
> |  wait_task_inactive()
> 
> The patch is based on his initial patch where an additional check is
> added in case the __TASK_TRACED moved to ->saved_state. The pi_lock is
> acquired to have stable view on ->__state and ->saved_state.
> 
> wait_task_inactive() needs to check both task states while waiting for the
> expected task state. Should the expected task state be in ->saved_state then
> the task is blocked on a sleeping lock. In this case wait_task_inactive() needs
> to wait until the lock situtation has been resolved (the expected state is in
> ->__state). This ensures that the task is idle and does not wakeup as part of
> lock resolving and races for instance with __switch_to_xtra() while the
> debugger clears TIF_BLOCKSTEP() (noted by Oleg Nesterov).
> 
> [ Fix for ptrace_unfreeze_traced() by Oleg Nesterov ]
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>   - Use also ->saved_state in task_state_match_and_set().
>   - Wait in wait_task_inactive() until the desired task state is in
>     ->__state so that the task won't wake up a as part of lock
>     resolving. Pointed out by Oleg Nesterov.
> 
>  include/linux/sched.h |  128 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/ptrace.c       |   25 +++++----
>  kernel/sched/core.c   |   11 +++-
>  3 files changed, 146 insertions(+), 18 deletions(-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -118,12 +118,8 @@ struct task_group;
>  
>  #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
>  
> -#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
> -
>  #define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
>  
> -#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
> -
>  /*
>   * Special states are those that do not use the normal wait-loop pattern. See
>   * the comment with set_special_state().

Urgh, so I have reworking all this somewhere on my todo list as well.
Except I mean to move it away from using p->__state entirely. We should
not be keeping canonical state in there.

As is, I think we can write task_is_stopped() like:

#define task_is_stopped(task)	((task)->jobctl & JOBCTL_STOP_PENDING)

Because jobctl is in fact the canonical state. I'm still not sure if we
can do the same with task_is_traced(), ideally that would be expressed
in terms of (task)->ptrace. But ptrace_stop() hurts my brain. All that
stuff is entirely to involved.

Anyway, let me see if I can page some of that back..


