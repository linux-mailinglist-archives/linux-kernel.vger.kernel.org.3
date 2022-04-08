Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24FE4F9DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiDHUJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiDHUJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:09:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF45353AAA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j9g5EHdwCeCGiDH+OptcbmwwyDPvJqZc+LesmTwslqM=; b=l7nnbBb2JXVJWhFHQb+EsAebGP
        x47Ze152fGhFOpyWK4R5wqh8jhw0hHFtRGIWwUcO4il6F7S+6O+9KdyGrlQ+MH0qUQ+1aGTMB8R7/
        5l9rnIsilGJTCn37OedWb1vPTs3WQ6Axn4BcNnHe7N437jh9nTFlKItKUapqNI8BhDYLN40HesuwU
        9IIT0hrshy605QKPJ22XfUxprlkRGMDVIJkQ4Fq7xoqZHdnGgCfZBqdiWlZf76QuQCdndE+VsHq/g
        koGtGFvOwcu3vitJM4HfLFWAGso32D+v9lTGK2URm++MgDxuJs2rKPGFueXPW4xQyxHw6dfKPHi4k
        klkzmFwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncusL-00333H-81; Fri, 08 Apr 2022 20:06:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8BA23000E6;
        Fri,  8 Apr 2022 22:06:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61A1D3223116A; Fri,  8 Apr 2022 22:06:30 +0200 (CEST)
Date:   Fri, 8 Apr 2022 22:06:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
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
Message-ID: <YlCVxlTVL1pyBF08@hirez.programming.kicks-ass.net>
References: <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
 <YkW55u6u2fo5QmV7@linutronix.de>
 <20220405101026.GB34954@worktop.programming.kicks-ass.net>
 <20220405102849.GA2708@redhat.com>
 <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
 <20220407121340.GA2762@worktop.programming.kicks-ass.net>
 <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
 <20220408090908.GO2731@worktop.programming.kicks-ass.net>
 <874k332wjp.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k332wjp.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:40:42PM -0500, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Thu, Apr 07, 2022 at 05:50:39PM -0500, Eric W. Biederman wrote:
> 
> >> Given that fundamentally TASK_WAKEKILL must be added in ptrace_stop and
> >> removed in ptrace_attach I don't see your proposed usage of jobctl helps
> >> anything fundamental.
> >> 
> >> I suspect somewhere there is a deep trade-off between complicating
> >> the scheduler to have a very special case for what is now
> >> TASK_RTLOCK_WAIT, and complicating the rest of the code with having
> >> TASK_RTLOCK_WAIT in __state and the values that should be in state
> >> stored somewhere else.
> >
> > The thing is; ptrace is a special case. I feel very strongly we should
> > not complicate the scheduler/wakeup path for something that 'never'
> > happens.
> 
> I was going to comment that I could not understand how the saved_state
> mechanism under PREEMPT_RT works.  Then I realized that wake_up_process
> and wake_up_state call try_to_wake_up which calls ttwu_state_match which
> modifies saved_state.

Correct.

> The options appear to be that either ptrace_freeze_traced modifies
> __state/state to remove TASK_KILLABLE.  Or that something clever happens
> in ptrace_freeze_traced that guarantees the task does not wake
> up.  Something living in kernel/sched/* like wait_task_inactive.

The code I posted in the parent will attempt to strip (and re-instate)
WAKEKILL from __state and then saved_state, all under pi_lock.

I think that preserves the current constraints.

> I can imagine adding add a loop around freezable_schedule in
> ptrace_stop.  That does something like:
> 
> 	do {
>         	freezable_schedule();
>         } while (current->jobctl & JOBCTL_PTRACE_FREEZE);

I'm not entirely sure where you're headin with this; but my goal is to
get rid of freezable_*() everything.

I'll ponder if wait_task_inactive() can simplify things..

> What ptrace_freeze_traced and ptrace_unfreeze_traced fundamentally need
> is that the process to not do anything interesting, so that the tracer
> process can modify the process and it's task_struct.

Agreed, I understand this need. I think I've done this, but I'll
centrainly look hard at it again Monday -- the weekend hopefully
clearing my brain of preconceptions enough so that I can see my own code
a-fresh.

Anyway, my current set lives here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/wip.freezer

I meant to post earlier today, but stuff got in between and I've not
even done build-tests yet :/
