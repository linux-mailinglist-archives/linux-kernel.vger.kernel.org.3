Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1B49EA67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiA0SdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiA0SdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:33:22 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC495C061714;
        Thu, 27 Jan 2022 10:33:21 -0800 (PST)
Date:   Fri, 28 Jan 2022 02:33:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643308400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVqeRfTnsDsLypLNnH4fgggsQaxIu1PGm+k1vPPQ5XU=;
        b=Ry8pLBkgu9CQJBV8Qrr/MymnU3+FUy8SP4qwSmI2wsw2carhgPUZ/kfCFqvvsFRogIsdMr
        niLcZ0tYZ8cdb86fK4ID0Jwvrj/3QCvNMCaWXIZgxyIh3XxDVrqGj2tS4QnGKYnpVlCTJT
        gHz56owtxtf9BbSd4QlziaFZkhb4/4Q=
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
Message-ID: <YfLlbMZRR4ouD52O@geo.homenetwork>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Ye67uQa4CwUuQJVY@geo.homenetwork>
 <YfKN3+84gtaIopHW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKN3+84gtaIopHW@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:19:43PM +0100, Peter Zijlstra wrote:

> On Mon, Jan 24, 2022 at 10:46:17PM +0800, Tao Zhou wrote:
> > Hi Peter,
> > 
> > On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:
> > 
> > [...]
> > 
> > > +/* pre-schedule() */
> > > +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> > > +{
> > > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > > +	int ret;
> > > +
> > > +	if (!tsk->umcg_server) {
> > > +		/*
> > > +		 * Already blocked before, the pages are unpinned.
> > > +		 */
> > > +		return;
> > > +	}
> > > +
> > > +	/* Must not fault, mmap_sem might be held. */
> > > +	pagefault_disable();
> > > +
> > > +	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED);
> > > +	if (ret == -EAGAIN) {
> > > +		/*
> > > +		 * Consider:
> > > +		 *
> > > +		 *   self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
> > > +		 *   ...
> > > +		 *   sys_umcg_wait();
> > > +		 *
> > > +		 * and the '...' code doing a blocking syscall/fault. This
> > > +		 * ensures that returns with UMCG_TASK_RUNNING, which will make
> > 
> > /UMCG_TASK_RUNNING/UMCG_TASK_RUNNABLE/
> 
> So the issue is that:
> 
> 	self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
> 
> 	<#PF>
> 	  umcg_sys_enter()
> 	    umcg_pin_user_page()
> 	  schedule()
> 	    sched_submit_work()
> 	      umcg_wq_worker_sleeping()
> 	        umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED) // -EAGAIN
> 		UMCG_DIE()
> 
> Which is clearly not desirable.
> 
> So this additinoal thing ensures that:
> 
> 		umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_BLOCKED) // 0
> 
> 	  umcg_sys_exit()
> 	    umcg_update_state(tsk, self, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE);
> 	    umcg_enqueue_and_wake()
> 
> 	  umcg_notify_resume()
> 	    umcg_wait()
> 
> 	// must be UMCG_TASK_RUNNING here
> 	</#PF>
> 
> So when the pagefault finally does return, it will have:
> UMCG_TASK_RUNNING.
> 
> Which will then make sys_umcg_wait() return -EAGAIN and around we go.

Thank you, Peter.

> > > +		 * sys_umcg_wait() return with -EAGAIN.
> > > +		 */
> > > +		ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_BLOCKED);
> > > +	}
> > > +	if (ret)
> > > +		UMCG_DIE_PF("state");
> > > +
> > > +	if (umcg_wake_server(tsk))
> > > +		UMCG_DIE_PF("wake");
> > > +
> > > +	pagefault_enable();
> > > +
> > > +	/*
> > > +	 * We're going to sleep, make sure to unpin the pages, this ensures
> > > +	 * the pins are temporary. Also see umcg_sys_exit().
> > > +	 */
> > > +	umcg_unpin_pages();
> > > +}
