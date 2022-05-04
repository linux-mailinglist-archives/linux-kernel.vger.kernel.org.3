Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5AF51AC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiEDSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376817AbiEDSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:18:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F58BF33
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:39:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651685958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=do545rYU5ClLPDNrN+MjFDX3RspZ+0XSwmtK00rF288=;
        b=v9UH2acf54eJVlnZ+qnFpGVu744KbI68uu/QKJUO/YronQxk9OZzq8RMCqVH1st8ImsyJB
        bOvGNUU1E6zl9rsbuRpuQwJMkYs3uUSfhZANb9TKkjC037/4ubWz+NEuRYkRfW0aaZqVCW
        YSENMxTKV3Dv5ZubA/YPA8mdwRe7R76+qASes1ytr+MyedmNOkHS6KIi4z9TjEvjL5ABiI
        Ba/ezO21ARH/0+uTXg4KS5sXm5ts1l8Yklvpjz5cfmPvkhfTMW3/LVo/fex0V29fUjSbtW
        92y3R+Oyqf1reDmjk65FHAYTINJmp2viSZjDyUq+b+dnOgr7Ejaj1qzltp8ZmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651685958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=do545rYU5ClLPDNrN+MjFDX3RspZ+0XSwmtK00rF288=;
        b=G/YAgMkPRpcE2rFsLbm/eogTdBSkplLihjEVFh6Mdjx1opNF/Uup//Pg2DhLAc/hMDzxsx
        05FyRoNf+n4R36Aw==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 09/13] task isolation: add preempt notifier to sync
 per-CPU vmstat dirty info to thread info
In-Reply-To: <YnKqpkdATqqlDHvK@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.130167792@fedora.localdomain> <878rrryp8y.ffs@tglx>
 <87ilquybgz.ffs@tglx> <YnKqpkdATqqlDHvK@fuller.cnet>
Date:   Wed, 04 May 2022 19:39:17 +0200
Message-ID: <87a6bxjiyi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04 2022 at 13:32, Marcelo Tosatti wrote:
> On Wed, Apr 27, 2022 at 02:09:16PM +0200, Thomas Gleixner wrote:
>> Aside of that, the existance of this preempt notifier alone tells me
>> that this is either a design fail or has no design in the first place.
>> 
>> The state of vmstat does not matter at all at the point where a task is
>> scheduled in. It matters when an isolated task goes out to user space or
>> enters a VM.
>
> If the following happens, with two threads with names that mean whether
> a thread has task isolation enabled or not:
>
> Thread-no-task-isol, Thread-task-isol.
>
> Events:
>
> not-runnable  		Thread-task-isol
> runnable      		Thread-task-no-isol
> marks vmstat dirty	Thread-task-no-isol (writes to some per-CPU vmstat
> counter)
> not-runnable		Thread-task-no-isol
> runnable		Thread-task-isol
>
> Then we have to transfer the "vmstat dirty" information from per-CPU 
> bool to per-thread TIF_TASK_ISOL bit (so that the
> task_isolation_process_work thing executes on return to userspace).

That's absolute nonsense.

sched_out()      isolated task
vmstat_dirty()
  this_cpu_or(isolwork, VMSTAT);
sched_in()       isolated task

return_to_user()
  local_irq_disable();
  exit_to_user_update_work()
    task_isol_exit_to_user_prepare()
      if (!isolated_task())
          return;
      if (this_cpu_read(isolwork) & current->isol_work_mask)
      	  set_thread_flag(TIF_ISOL);

  exit_to_user_mode_loop()
     do {
        local_irq_enable();
        handle_TIF_bits();
        local_irq_disable();
        exit_to_user_update_work();
        work = read_thread_flags();
     } while (work & EXIT_WORK);
          
Solves the problem nicely with a minimal overhead for non-isolated
tasks.

Plus some of these isolwork bits could even be handled _after_ returning
from exit_do_user_mode_loop() if they are good to be done in irq
diasbled context.

> Sure, but who sets SYSCALL_TASK_ISOL_EXIT or SYSCALL_TASK_ISOL_EXIT ?

It's set once by the prctl() when an isolation feature is enabled for a
task and it's cleared by the prctl() when the last isolation feature is
disabled for the task.

That's then used in:

static inline bool isolated_task()
{
       return current->XXXX_work & TASK_ISOL_EXIT;
}

IOW, the return to user path has

     - _ONE_ extra cache hot conditional for non-isolated tasks.

     - _ONE_ central place to transform the per cpu isolation muck into
       the TIF flag.

See? No sprinkling of TIF bits, no preempt notifiers, nothing.

> Use TIF_TASK_ISOL for "task isolation configured and activated,
> quiesce vmstat work on return to userspace" only, and then have
> the "is vmstat per-CPU data dirty?" information held on 
> task->syscall_work or task->isol_work ? (that will be probably be two
> cachelines).

See above.

> You'd still need the preempt notifier, though (unless i am missing
> something).

Yes, see above.

Using a preempt notifier isa design fail because it tags information at
a place where this information is absolutely irrelevant and subject to
change.

Aside of that this information is not a task property. vmmstat_is_dirty
is a per CPU property. The only point where this per CPU property is
relevant for a task is when the task is isolated and goes out to user
space or enters a VM.

Trying to carry this information in a task flag is fundamentaly wrong
for obvious reasons and causes pointless overhead and complexity for
absolutely no value.

Thanks,

        tglx

