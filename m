Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946EB4FC2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348750AbiDKRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiDKRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:10:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF31FCD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+iXwtVZvUdEhLEVqNt7D0roMyUFGILOUPB/s//8bFdU=; b=pSTkAwRoffNrDT+tQEQnmaFNcG
        Sl/WcFSGdTIFNjO553AgubZybJn+IKvIMGq4kJ/laKrhFs05W7UjJ+vTDrldkJVgPdPupmLJddwaR
        s02MC63I+H4D8yggIONijJk+i3bk5gGYqbQLJqoBT+KwUaI/96ZijYq8DeA9dzkSB6mUGPxEmjdoE
        QH4zNUA+6BXcJMQPh6veFUs5UHzDm0SJAxyMfmGKXt+oBB7b3SEK0z4aXObZACA+fJNkC3/UM/1X5
        xAxD5PbpntJoe6Vo/imVayj6iMK5WTcDf7qOQ9apedjCqLWnqcZ0As6KHTM/QEKoSZzGyw6Ij3S6+
        P3Fb28aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndxW6-0042Q1-Da; Mon, 11 Apr 2022 17:07:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7781F300212;
        Mon, 11 Apr 2022 19:07:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33F082D2B129D; Mon, 11 Apr 2022 19:07:53 +0200 (CEST)
Date:   Mon, 11 Apr 2022 19:07:53 +0200
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
Message-ID: <YlRgaZnJp2YONKhS@hirez.programming.kicks-ass.net>
References: <20220405101026.GB34954@worktop.programming.kicks-ass.net>
 <20220405102849.GA2708@redhat.com>
 <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
 <20220407121340.GA2762@worktop.programming.kicks-ass.net>
 <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
 <20220408090908.GO2731@worktop.programming.kicks-ass.net>
 <874k332wjp.fsf@email.froward.int.ebiederm.org>
 <YlCVxlTVL1pyBF08@hirez.programming.kicks-ass.net>
 <YlQSe6m2tidxwHt0@hirez.programming.kicks-ass.net>
 <87ee23zqdj.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee23zqdj.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:44:24AM -0500, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Fri, Apr 08, 2022 at 10:06:30PM +0200, Peter Zijlstra wrote:
> >
> >> I'll ponder if wait_task_inactive() can simplify things..
> >
> > This,.. so ptrace_check_attach(), which does ptrace_freeze_traced()
> > already does wait_task_inactive(), but on the 'wrong' side of things.
> >
> > AFAICT, if we move that up, we're almost there, except that opens up a
> > detach+attach race. That could be fixed by doing another
> > wait_task_inactive(), but we can't due to locking :/
> >
> > Let's see if I can make that work without making a mess of things.
> > Because ensuring the task is stuck in schedule() makes the whole
> > saved_state thing go away -- as you noted.
> 
> The code can perhaps synchronize on a bit using the the full locking and
> then drop the locks and call the wait_task_inactive or whatever.
> 
> The challenge as I see it is after the traced task is inactive to allow
> "wake_up_state(t, TASK_WAKEKILL)" on the traced task, have the traced
> tasks state change to TASK_RUNNING and not allow the traced task to run
> until what is today ptrace_unfreeze_task is called.
> 
> I just don't know how to get something stuck and not allow it to run.

Same as today? Clear TASK_WAKEKILL from __state and check
__fatal_signal_pending() before putting it back again.

The thing is, once we hit schedule() with TASK_TRACED, there's only two
possible ways for that task to wake up:

  wake_up_state(t, TASK_WAKEKILL)

and

  wake_up_state(t, __TASK_TRACED)

both are issued while holding sighand lock, so provided we hold sighand
lock, we can actually frob __state as we do today, we just need to know
the task really has scheduled out first.

That is, the problem today, for PREEMPT_RT, is:

ptrace_stop():					ptrace_freeze_traced()

  set_special_state(TASK_TRACING)

  ...

  spin_lock(&foo)
    current->saved_state = current->__state;
    current->__state = TASK_RTLOCK_WAIT

						READ_ONCE(t->__state)
						  // whoopsie, not
						  // TRACED

  ...

  schedule()


But if wait_task_inactive() ensures our @t is actually in schedule(),
we're good again, nothing will then ever change __state as long as we
hold sighand lock.

The only fun bit is that wait_task_inactive() likes to schedule so we
want do that with sighand lock held. What we need to do is call it
first, and then re-check stuff is still sane once we (re)acquire all the
locks.

This is certainly possible -- and not in fact too hard; the only thing
I'm really concerned about is not making it more ugly than dealing with
saved_state in the first place (and *that* is turning out to be somewhat
hard).

But while going over all this I think there might be an additional
problem; wait_task_inactive() is stubbed for SMP=n...


