Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A85568258
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiGFJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiGFJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:00:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC41A3A1;
        Wed,  6 Jul 2022 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lc1nfuTmRLJC5zrVjNH0l/duy5mbZIyykH5a0W+voY8=; b=i8xduWRVHzPycpj4aYcRorY6TA
        XTVVYE1I11IukCdv42nkSkB4f3OUjy3AJBnUNvj4TUakkooAJ1n5Jxvz/d11wUl5GqYcIieozQ864
        B2Kq4qM14Ou6J9CVLN/3LK5EtRqKlxLdn/RmXRZRjVpX8V+q58etmYn1WtdVfrGKd1PjTnLKIclOH
        a+kaMIxwNo1ZpUXKKhskeM8BfC/efZCZUI/kLzOIUxKfbHx5WlpT/PAfH8HC0Vsd+kQRpn60lp6J6
        7jOYxvTDvKgYfoTkv2ZeG6LX11dKbzDctVwLJJNREnMQMKg8yLBMcQhZCodE4KYfbJDXW00LAylze
        g1pP64tw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o90sB-000N9S-20; Wed, 06 Jul 2022 08:59:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 875EF980050; Wed,  6 Jul 2022 10:59:00 +0200 (CEST)
Date:   Wed, 6 Jul 2022 10:59:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YsVO1NU3bXGg9YJ3@worktop.programming.kicks-ass.net>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
 <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220628191541.34a073fc@gandalf.local.home>
 <yt9d5ykbekn3.fsf@linux.ibm.com>
 <yt9dpmijcvu6.fsf@linux.ibm.com>
 <YsSQRmCZSIQ1ewzo@worktop.programming.kicks-ass.net>
 <yt9dsfneaczk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dsfneaczk.fsf@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:58:55AM +0200, Sven Schnelle wrote:

> >> [   86.218551] kill_chi-343805    6d.... 79990141us : ptrace_stop: JOBCTL_TRACED already set, state=0 <------ valid combination of flags?
> >
> > Yeah, that's not supposed to be so. JOBCTL_TRACED is supposed to follow
> > __TASK_TRACED for now. Set when __TASK_TRACED, cleared when
> > TASK_RUNNING.
> >
> > Specifically {ptrace_,}signal_wake_up() in signal.h clear JOBCTL_TRACED
> > when they would wake a __TASK_TRACED task.
> 
> try_to_wake_up() clears TASK_TRACED in this case because a signal
> (SIGKILL) has to be delivered. As a test I put the following change
> on top, and it "fixes" the problem:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da0bf6fe9ecd..f2e0f5e70e77 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4141,6 +4149,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>          * TASK_WAKING such that we can unlock p->pi_lock before doing the
>          * enqueue, such as ttwu_queue_wakelist().
>          */
> +       if (p->__state & TASK_TRACED)
> +               trace_printk("clearing TASK_TRACED 2\n");
> +       p->jobctl &= ~JOBCTL_TRACED;
>         WRITE_ONCE(p->__state, TASK_WAKING);
> 
>         /*
> 
> There are several places where the state is changed from TASK_TRACED to
> something else without clearing JOBCTL_TRACED.

I'm having difficulty spotting them; I find:

TASK_WAKEKILL: signal_wake_up()
__TASK_TRACED: ptrace_signal_wake_up(), ptrace_unfreeze_traced(), ptrace_resume()

And all those sites dutifully clear JOBCTL_TRACED.

I'd be most interested in the calstack for the 'clearing TASK_TRACED 2'
events to see where we miss a spot.
