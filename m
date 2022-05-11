Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0D52406D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348912AbiEKWxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbiEKWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:53:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068D6F49F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:53:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652309597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJCx/JZR7FMKyZ5jsPBr5sn4ghW4qqCOnaHIaFs+jyE=;
        b=wMjZtA33gC2+9jWxFm3oXeenXbYxynAzgZXy4/Nxv5pchern+rbsOD3wW3bxQ37/nz0Kbt
        nYOTCz29HkJLfY+rnh2MOqqF4ASHMSZ7bpRe0WaG9mB1U9zVFqvyc/zKLml2t3ljUUdYX/
        3OZjj6cI8WrKbDx9gccr1lp7CW9Lu6xgim0yR7NidrbLoYjkHeSkeihVEVdAdFpqWkSIAq
        ANnV/4wA/4re8LNQ+C47hqvROTbiogxsTpdBWSVuEYA8fX+bQ8mBlih+S89eW+ksycOc7n
        ERFuiBvKmGudfta7yY+WPWc8LgbnGOel7tJRn2RhMg8fNl2xvii3DtJrm517Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652309597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJCx/JZR7FMKyZ5jsPBr5sn4ghW4qqCOnaHIaFs+jyE=;
        b=OZgPP5LEMsDJodUnXoUk6SBxnInrnC+qwrjfmkgMBlgm+eDsE7t9l+QtKVQctiD44oKCh2
        4D2bY6vV5I+JT9Cg==
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>, keescook@chromium.org,
        Peter Zijlstra <peterz@infradead.org>, elver@google.com,
        legion@kernel.org, oleg@redhat.com, brauner@kernel.org
Subject: Re: Question about kill a process group
In-Reply-To: <87a6bnudfy.fsf@email.froward.int.ebiederm.org>
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
 <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
 <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
 <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
 <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com>
 <874k2mtny7.fsf@email.froward.int.ebiederm.org> <87zgk5v148.ffs@tglx>
 <87a6bnudfy.fsf@email.froward.int.ebiederm.org>
Date:   Thu, 12 May 2022 00:53:16 +0200
Message-ID: <87bkw3y943.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 13:33, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> So unless the number of PIDs for a user is limited this _is_ an
>> unpriviledged DoS vector.
>
> After having slept on this a bit it finally occurred to me the
> semi-obvious solution to this issue is to convert tasklist_lock
> from a rw-spinlock to rw-semaphore.  The challenge is finding
> the users (tty layer?) that generate signals from interrupt
> context and redirect that signal generation.

From my outdated notes where I looked at this before:

[soft]interrupt context which acquires tasklist_lock:
sysrq-e		send_sig_all()
sysrq-i         send_sig_all()
sysrq-n		normalize_rt_tasks()

tasklist_lock nesting into other locks:
   fs/fcntl.c: send_sigio(), send_sigurg()

   send_sigurg() is called from the network stack ...

Some very obscure stuff in arch/ia64/kernel/mca.c which is called
from a DIE notifier.

Plus quite a bunch of read_lock() instances which nest inside
rcu_read_lock() held sections.

This is probably incomplete, but the scope of the problem has been
greatly reduced vs. the point where I looked at it last time a couple of
years ago. But that's still a herculean task.

> Once signals holding tasklist_lock are no longer generated from
> interrupt context irqs no longer need to be disabled and
> after verifying tasklist_lock isn't held under any other spinlocks
> it can be converted to a semaphore.

Going to take a while. :)

> It won't help the signal delivery times, but it should reduce
> the effect on the rest of the system, and prevent watchdogs from
> firing.

The signal delivery time itself is the least of the worries, but this
still prevents any other operations which require tasklist_lock from
making progress for quite some time, i.e. fork/exec for unrelated
processes/users will have to wait too. So you converted the 'visible'
DoS to an 'invisible' one.

The real problem is that the scope of tasklist_lock is too broad for
most use cases. That does not change when you actually can convert it to
a rwsem. The underlying problem still persists.

Let's take a step back and look what most sane use cases (sysrq-* is not
in that category) require:

   Preventing that tasks are added or removed

Do they require that any task is added or removed? No.

   They require to prevent add/remove for the intended scope.

That's the thing we need to focus on: reducing the protection scope.

If we can segment the protection for the required scope of e.g. kill(2)
then we still can let unrelated processes/tasks make progress and just
inflict the damage on the affected portion of processes/tasks.

For example:

	read_lock(&tasklist_lock);
	for_each_process(p) {
		if (task_pid_vnr(p) > 1 &&
		    !same_thread_group(p, current)) {

			group_send_sig_info(...., p);
		}
	}
	read_unlock(&tasklist_lock);

same_thread_group() does:

   return p->signal == current->signal;

Ideally we can do:

	read_lock(&tasklist_lock);
        prevent_add_remove(current->signal);
	read_unlock(&tasklist_lock);

        rcu_read_lock();
	for_each_process(p) {
		if (task_pid_vnr(p) > 1 &&
		    !same_thread_group(p, current)) {

			group_send_sig_info(...., p);
		}
	}
        rcu_read_unlock();

        allow_add_remove(current->signal);

Where prevent_add_remove() sets a state which has to be waited for to be
cleared by anything which wants to add/remove a task in that scope or
change $relatedtask->signal until allow_add_remove() removes that
blocker. I'm sure it's way more complicated, but you get the idea.

If we find a solution to this scope reduction problem, then it will not
only squash the issue which started this discussion. This will have a
benefit in general.

Thanks,

        tglx
