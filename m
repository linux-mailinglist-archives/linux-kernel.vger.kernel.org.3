Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33151A595
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353267AbiEDQgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiEDQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED60D4666B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651681993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kun2d8v6KzR2PZ/jkAtJAEPrLbaHdQFXGWtALXuj76k=;
        b=gm5+6do7JadWDE8xd0JjQTLYWI5AVIsM+zERDDPpFpmSNbr9EW59gvY4V6/Ngah8rvrFso
        JqfAUY+YAQmybhzKpsXxu1Xkq8jgkMSBhDAlu/U61eLuL4ReZKYclc3UYXjLILx2LWlsc1
        wZs/3A68lqUkujjbxh1HTLv+pz/L0cg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-3U_pRYdYNUaNXMi_emxg1g-1; Wed, 04 May 2022 12:33:02 -0400
X-MC-Unique: 3U_pRYdYNUaNXMi_emxg1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1137229AB40D;
        Wed,  4 May 2022 16:33:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4A5454A76;
        Wed,  4 May 2022 16:33:00 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C862C493662E; Wed,  4 May 2022 13:32:38 -0300 (-03)
Date:   Wed, 4 May 2022 13:32:38 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <YnKqpkdATqqlDHvK@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.130167792@fedora.localdomain>
 <878rrryp8y.ffs@tglx>
 <87ilquybgz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilquybgz.ffs@tglx>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 02:09:16PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 27 2022 at 09:11, Thomas Gleixner wrote:
> > On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> >> If a thread has task isolation activated, is preempted by thread B,
> >> which marks vmstat information dirty, and is preempted back in,
> >> one might return to userspace with vmstat dirty information on the 
> >> CPU in question.
> >>
> >> To address this problem, add a preempt notifier that transfers vmstat dirty
> >> information to TIF_TASK_ISOL thread flag.
> >
> > How does this compile with CONFIG_KVM=n?
> 
> Aside of that, the existance of this preempt notifier alone tells me
> that this is either a design fail or has no design in the first place.
> 
> The state of vmstat does not matter at all at the point where a task is
> scheduled in. It matters when an isolated task goes out to user space or
> enters a VM.

If the following happens, with two threads with names that mean whether
a thread has task isolation enabled or not:

Thread-no-task-isol, Thread-task-isol.

Events:

not-runnable  		Thread-task-isol
runnable      		Thread-task-no-isol
marks vmstat dirty	Thread-task-no-isol (writes to some per-CPU vmstat
counter)
not-runnable		Thread-task-no-isol
runnable		Thread-task-isol

Then we have to transfer the "vmstat dirty" information from per-CPU 
bool to per-thread TIF_TASK_ISOL bit (so that the
task_isolation_process_work thing executes on return to userspace).

> We already have something similar in the exit to user path:
> 
>    tick_nohz_user_enter_prepare()
> 
> So you can do something like the below and have:
> 
> static inline void task_isol_exit_to_user_prepare(void)
> {
>         if (unlikely(current_needs_isol_exit_to_user())
>         	__task_isol_exit_to_user_prepare();
> }
> 
> where current_needs_isol_exit_to_user() is a simple check of either an
> existing mechanism like
> 
>          task->syscall_work & SYSCALL_WORK_TASK_ISOL_EXIT
> 
> or of some new task isolation specific member of task_struct which is
> placed so it is cache hot at that point:
> 
>         task->isol_work & SYSCALL_TASK_ISOL_EXIT
> 
> which is going to be almost zero overhead for any non isolated task.

Sure, but who sets SYSCALL_TASK_ISOL_EXIT or SYSCALL_TASK_ISOL_EXIT ?

> It's trivial enough to encode the real stuff into task->isol_work and
> I'm pretty sure, that a 32bit member is sufficient for that. There is
> absolutely no need for a potential 64x64 bit feature matrix.

Well, OK, the meaning of TIF_TASK_ISOL thread flag is ambiguous:

1) We set it when quiescing vmstat feature of task isolation.
2) We set it when switching between tasks A and B, B has 
task isolation configured and activated, and per-CPU vmstat information 
was dirty.
3) We clear it on return to userspace:

	if (test_bit(TIF_TASK_ISOL, thread->flags)) {
		clear_bit(TIF_TASK_ISOL, thread->flags))
		process_task_isol_work();
	}

So you prefer to separate:

Use TIF_TASK_ISOL for "task isolation configured and activated,
quiesce vmstat work on return to userspace" only, and then have
the "is vmstat per-CPU data dirty?" information held on 
task->syscall_work or task->isol_work ? (that will be probably be two
cachelines).

You'd still need the preempt notifier, though (unless i am missing
something).

Happy with either case.

Thanks for the review!

> Thanks,
> 
>         tglx
> ---
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -142,6 +142,12 @@ void noinstr exit_to_user_mode(void)
>  /* Workaround to allow gradual conversion of architecture code */
>  void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
>  
> +static void exit_to_user_update_work(void)
> +{
> +	tick_nohz_user_enter_prepare();
> +	task_isol_exit_to_user_prepare();
> +}
> +
>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  					    unsigned long ti_work)
>  {
> @@ -178,8 +184,7 @@ static unsigned long exit_to_user_mode_l
>  		 */
>  		local_irq_disable_exit_to_user();
>  
> -		/* Check if any of the above work has queued a deferred wakeup */
> -		tick_nohz_user_enter_prepare();
> +		exit_to_user_update_work();
>  
>  		ti_work = read_thread_flags();
>  	}
> @@ -194,8 +199,7 @@ static void exit_to_user_mode_prepare(st
>  
>  	lockdep_assert_irqs_disabled();
>  
> -	/* Flush pending rcuog wakeup before the last need_resched() check */
> -	tick_nohz_user_enter_prepare();
> +	exit_to_user_update_work();
>  
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
> 
> 

