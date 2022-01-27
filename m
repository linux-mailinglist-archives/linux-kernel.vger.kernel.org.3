Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8049EA62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiA0Sbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiA0Sbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:31:32 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE6C061714;
        Thu, 27 Jan 2022 10:31:31 -0800 (PST)
Date:   Fri, 28 Jan 2022 02:31:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643308288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HcZCBQQDy6q0SacmFWf+zshxrXVq6Q4RcA0g5Ed/lI=;
        b=DcoRBMLtGByO5XycrxUasKnSoej24PKMzEcEjlEAV0pU9Q9uwcI6qlsckWkJ2Ic4ozlIrO
        7Hu9ocn5l3P+uWKqjtaA8w8jG+nzXieTwGesw3yQHNk+hReXZDHo1I2zg3Xi3iJwYHklhX
        zBqsnwOzKbKy/KgkBYWdd/7WvOIRIe4=
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
Message-ID: <YfLk/BlerNaAFMLL@geo.homenetwork>
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

On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:

Another iterator of the patch, some nits below.

[...]

> +/*
> + * Pinning a page inhibits rmap based unmap for Anon pages. Doing a load
> + * through the user mapping ensures the user mapping exists.
> + */
> +#define umcg_pin_and_load(_self, _pagep, _member)				\
> +({										\
> +	__label__ __out;							\
> +	int __ret = -EFAULT;							\
> +										\
> +	if (pin_user_pages_fast((unsigned long)(_self), 1, 0, &(_pagep)) != 1)	\
> +		goto __out;							\
> +										\
> +	if (!PageAnon(_pagep) ||						\
> +	    get_user(_member, &(_self)->_member)) {				\

Here should be 'get_user(_member, &(_self)->##_member))'
if I am not wrong.

> +		unpin_user_page(_pagep);					\
> +		goto __out;							\
> +	}									\
> +	__ret = 0;								\
> +__out:	__ret;									\
> +})

[...]

> +
> +/*
> + * Enqueue @tsk on it's server's runnable list
> + *
> + * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
> + *
> + * cmpxchg based single linked list add such that list integrity is never
> + * violated.  Userspace *MUST* remove it from the list before changing ->state.
> + * As such, we must change state to RUNNABLE before enqueue.
> + *
> + * Returns:
> + *   0: success
> + *   -EFAULT
> + */
> +static int umcg_enqueue_runnable(struct task_struct *tsk)
> +{
> +	struct umcg_task __user *server = tsk->umcg_server_task;
> +	struct umcg_task __user *self = tsk->umcg_task;
> +	u64 first_ptr, *head = &server->runnable_workers_ptr;
> +	u64 self_ptr = (unsigned long)self;

Why not 'u64 self_ptr = (u64)self;' ?

> +	/*
> +	 * umcg_pin_pages() did access_ok() on both pointers, use self here
> +	 * only because __user_access_begin() isn't available in generic code.
> +	 */
> +	if (!user_access_begin(self, sizeof(*self)))
> +		return -EFAULT;
> +
> +	unsafe_get_user(first_ptr, head, Efault);
> +	do {
> +		unsafe_put_user(first_ptr, &self->runnable_workers_ptr, Efault);
> +	} while (!unsafe_try_cmpxchg_user(head, &first_ptr, self_ptr, Efault));
> +
> +	user_access_end();
> +	return 0;
> +
> +Efault:
> +	user_access_end();
> +	return -EFAULT;
> +}

[...]

> +/*
> + * Handles ::next_tid as per sys_umcg_wait().
> + *
> + * ::next_tid		- return
> + * -----------------------------
> + * 0			- 0 (success)
> + *
> + * tid			- -ESRCH (no such task, or not of this UMCG)
> + *			- -EAGAIN (next::state != RUNNABLE)
> + *			- 0 (success, ::next_tid |= RUNNING)
> + *
> + * tid|RUNNING		- -EAGAIN (next::state != RUNNING)
> + *			- 0 (success)
> + *
> + * Returns:
> + *  0: success
> + *  -EFAULT
> + *  -ESRCH
> + *  -EAGAIN
> + */
> +static int umcg_wake_next(struct task_struct *tsk, struct umcg_task __user *self)

@tsk is not used in function.

> +{
> +	struct umcg_task __user *next_task;
> +	struct task_struct *next;
> +	u32 next_tid, state;
> +	int ret;
> +
> +	if (get_user(next_tid, &self->next_tid))
> +		return -EFAULT;
> +
> +	if (!next_tid)
> +		return 0;
> +
> +	next = umcg_get_task(next_tid);
> +	if (!next)
> +		return -ESRCH;
> +
> +	next_task = READ_ONCE(next->umcg_task);
> +
> +	if (next_tid & UMCG_TID_RUNNING) {
> +		ret = -EFAULT;
> +		if (get_user(state, &next_task->state))
> +			goto put_next;
> +
> +		ret = 0;
> +		if ((state & UMCG_TASK_MASK) != UMCG_TASK_RUNNING)
> +			ret = -EAGAIN;
> +
> +	} else {
> +		ret = umcg_wake_task(next, next_task);
> +		if (ret)
> +			goto put_next;
> +
> +		ret = -EFAULT;
> +		if (put_user(next_tid | UMCG_TID_RUNNING, &self->next_tid))
> +			goto put_next;
> +
> +		/*
> +		 * If this is a worker doing sys_umcg_wait() switching to
> +		 * another worker, userspace has the responsibility to update
> +		 * server::next_tid.
> +		 */
> +
> +		ret = 0;
> +	}
> +
> +put_next:
> +	put_task_struct(next);
> +	return ret;
> +}
> +
