Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A14982AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiAXOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:46:30 -0500
Received: from out2.migadu.com ([188.165.223.204]:31768 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbiAXOq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:46:29 -0500
Date:   Mon, 24 Jan 2022 22:46:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643035587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4WvYZ9EsFviMO5mAWJLfSbIOq5V9P7euYY8I6ZoQ8fw=;
        b=Tx5+sN5L8vIHOisAOz3iiSkMzMlrIWQOB5r8bOyOttd2Oy1xFq/IneAeBwct4b0JZPd9fZ
        4/MOB/e5hDK0MWq5hVneVRkZVUjjtsqaFjc/YSIrKtugvWW2cb1ETBpv15VndKUsVtR5XN
        TDzu1Ymxfa/4fD7bCPh50Qshjxstgkc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <Ye67uQa4CwUuQJVY@geo.homenetwork>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120160822.914418096@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:

[...]

> +/* pre-schedule() */
> +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> +{
> +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> +	int ret;
> +
> +	if (!tsk->umcg_server) {
> +		/*
> +		 * Already blocked before, the pages are unpinned.
> +		 */
> +		return;
> +	}
> +
> +	/* Must not fault, mmap_sem might be held. */
> +	pagefault_disable();
> +
> +	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED);
> +	if (ret == -EAGAIN) {
> +		/*
> +		 * Consider:
> +		 *
> +		 *   self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
> +		 *   ...
> +		 *   sys_umcg_wait();
> +		 *
> +		 * and the '...' code doing a blocking syscall/fault. This
> +		 * ensures that returns with UMCG_TASK_RUNNING, which will make

/UMCG_TASK_RUNNING/UMCG_TASK_RUNNABLE/

> +		 * sys_umcg_wait() return with -EAGAIN.
> +		 */
> +		ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_BLOCKED);
> +	}
> +	if (ret)
> +		UMCG_DIE_PF("state");
> +
> +	if (umcg_wake_server(tsk))
> +		UMCG_DIE_PF("wake");
> +
> +	pagefault_enable();
> +
> +	/*
> +	 * We're going to sleep, make sure to unpin the pages, this ensures
> +	 * the pins are temporary. Also see umcg_sys_exit().
> +	 */
> +	umcg_unpin_pages();
> +}

[...]

> +/* Called from syscall exit path and exceptions that can schedule */
> +void umcg_sys_exit(struct pt_regs *regs)
> +{
> +	struct task_struct *tsk = current;
> +	long syscall = syscall_get_nr(tsk, regs);
> +
> +	if (syscall == __NR_umcg_wait ||
> +	    syscall == __NR_umcg_ctl)
> +		return;
> +
> +	if (tsk->umcg_server) {
> +		/*
> +		 * Didn't block, we done.
> +		 */
> +		umcg_unpin_pages();
> +		return;
> +	}
> +
> +	umcg_unblock_and_wait();

umcg_unblock_and_wait() -> umcg_enqueue_and_wake() ->
umcg_wake_server() -> umcg_wake_task(tsk->umcg_server, ...)

tsk->umcg_server is NULL here and umcg_wake_task() use it to update
state in umcg_update_state(NULL, ...), that means tsk->umcg_clock
will happen something i do not know.

There are two places to call umcg_unblock_and_wait(). One is in 
umcg_register() where the server is set. Another one is in
umcg_sys_exit() where the server is not set. May use a bool to
indicate if the server is set.

> +}

[...]

> +/**
> + * sys_umcg_wait: transfer running context
> + *
> + * Called like:
> + *
> + *	self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
> + *	...
> + *	sys_umcg_wait(0, time);
> + *
> + * The syscall will clear TF_COND_WAIT and wait until state becomes RUNNING.
> + * The code '...' must not contain syscalls
> + *
> + * If self->next_tid is set and indicates a valid UMCG task with RUNNABLE state
> + * that task will be made RUNNING and woken -- transfering the running context
> + * to that task. In this case self->next_tid is modified with TID_RUNNING to
> + * indicate self->next_tid is consumed.
> + *
> + * If self->next has TID_RUNNING set, it is validated the related task has

/self->next/self->next_tid/
Things are not clear to me even they are clear now. Nice.

Thanks,
Tao
