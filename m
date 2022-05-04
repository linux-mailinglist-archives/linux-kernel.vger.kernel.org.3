Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2351A1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbiEDOGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiEDOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DE2C28992
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651672975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWK4ZOfJVM6RjQ4Lfcqx7f0iXv4BQ56O8KCQMl4QeHw=;
        b=ev160W64NtDRItaio2AQvWWpAA4AnkAk23EvSPnl70s9iQ/bVMl4MLf4iGnQ9Ua0w5QFEE
        FFVbWd28UQqxqkVhdI0hoHDVm229bDYKLtPinu5P5g5vAPVtd2L2QMeDYGyFrl4xlazIAM
        FwoKksFn/Ts0g7RrfxZxOEsPElOW3Ws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-lLC0nUZAP4mgPBTEv5ytUg-1; Wed, 04 May 2022 10:02:47 -0400
X-MC-Unique: lLC0nUZAP4mgPBTEv5ytUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EF9D1C3E988;
        Wed,  4 May 2022 14:02:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDC8BC52C8A;
        Wed,  4 May 2022 14:02:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  4 May 2022 16:02:44 +0200 (CEST)
Date:   Wed, 4 May 2022 16:02:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
Message-ID: <20220504140210.GA24581@redhat.com>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-7-ebiederm@xmission.com>
 <20220502153934.GD17276@redhat.com>
 <87levjrixl.fsf@email.froward.int.ebiederm.org>
 <20220503134149.GA22999@redhat.com>
 <877d72l50n.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d72l50n.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > But why is it bad if the tracee doesn't sleep in schedule ? If it races
> > with SIGKILL. I still can't understand this.
> >
> > Yes, wait_task_inactive() can fail, so you need to remove WARN_ON_ONCE()
> > in 11/12.
>
> >
> > Why is removing TASK_WAKEKILL from TASK_TRACED and complicating
> > *signal_wake_up() better?
>
> Not changing __state is better because it removes special cases
> from the scheduler that only apply to ptrace.

Hmm. But I didn't argue with that? I like the idea of JOBCTL_TASK_FROZEN.

I meant, I do not think that removing KILLABLE from TASK_TRACED (not
from __state) and complicating *signal_wake_up() (I mean, compared
to your previous version) is a good idea.

And. At least in context of this series it is fine if the JOBCTL_TASK_FROZEN
tracee do not block in schedule(), just you need to remove WARN_ON_ONCE()
around wait_task_inactive().

> > And even if we need to ensure the tracee will always block after
> > ptrace_freeze_traced(), we can change signal_pending_state() to
> > return false if JOBCTL_PTRACE_FROZEN. Much simpler, imo. But still
> > looks unnecessary to me.
>
> We still need to change signal_wake_up in that case.  Possibly
> signal_wake_up_state.

Of course. See above.

> >> if we depend on wait_task_inactive failing if the process is in the
> >> wrong state.
> >
> > OK, I guess this is what I do not understand. Could you spell please?
> >
> > And speaking of RT, wait_task_inactive() still can fail because
> > cgroup_enter_frozen() takes css_set_lock? And it is called under
> > preempt_disable() ? I don't understand the plan :/
>
> Let me describe his freezer change as that is much easier to get to the
> final result.  RT has more problems as it turns all spin locks into
> sleeping locks.  When a task is frozen

[...snip...]

Oh, thanks Eric, but I understand this part. But I still can't understand
why is it that critical to block in schedule... OK, I need to think about
it. Lets assume this is really necessary.

Anyway. I'd suggest to not change TASK_TRACED in this series and not
complicate signal_wake_up() more than you did in your previous version:

	static inline void signal_wake_up(struct task_struct *t, bool resume)
	{
		bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
		signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
	}

JOBCTL_PTRACE_FROZEN is fine.

ptrace_check_attach() can do

	if (!ret && !ignore_state &&
	    /*
	     * This can only fail if the frozen tracee races with
	     * SIGKILL and enters schedule() with fatal_signal_pending
	     */
	    !wait_task_inactive(child, __TASK_TRACED))
		ret = -ESRCH;

	return ret;


Now. If/when we really need to ensure that the frozen tracee always
blocks and wait_task_inactive() never fails, we can just do

	- add the fatal_signal_pending() check into ptrace_stop()
	  (like this patch does)

	- say, change signal_pending_state:

	static inline int signal_pending_state(unsigned int state, struct task_struct *p)
	{
		if (!(state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
			return 0;
		if (!signal_pending(p))
			return 0;
		if (p->jobctl & JOBCTL_TASK_FROZEN)
			return 0;
		return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
	}

in a separate patch which should carefully document the need for this
change.

> > I didn't look at JOBCTL_PTRACE_SIGNR yet. But this looks minor to me,
> > I mean, I am not sure it worth the trouble.
>
> The immediate problem the JOBCTL_PTRACE_SIGNR patch solves is:
> - stopping in ptrace_report_syscall.
> - Not having PT_TRACESYSGOOD set.
> - The tracee being killed with a fatal signal
        ^^^^^^
        tracer ?
> - The tracee sending SIGTRAP to itself.

Oh, but this is clear. But do we really care? If the tracer exits
unexpectedly, the tracee can have a lot more problems, I don't think
that this particular one is that important.

Oleg.

