Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62DD49E22D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbiA0MUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbiA0MUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:20:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59617C061714;
        Thu, 27 Jan 2022 04:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=apFD4UwkGbnUlS6QRwwlqJtZYogyGpQVvXHYQdU89mo=; b=RAzvWVT3QoIcd1wSs2pQDzCr8b
        utwt3vbxz/RrDaxL58pAOfQR/+/GRKD2AzzRN0m54fa3sRpOt09Rm6VNBBVqbSBZm605853qYqtR4
        UpyWDOeyi3RoCO4qadAapNaf4sA9e/nB576zo1ISzfWlUxXGyvGN1MaPL8614s0kKSb+e6y0BR4tS
        GHHU7Zx/O8rahpO3JDeJKFxaxc3IQMsA40kh64t7gay/9MGGba9oMddpbO4dy2/+vxMHBYd9fermu
        cpdlp69uG9ajzJpl5t/GrUVFf0VbK4x5fXiu653qop0byW2pNb6jDg5WhrH26JV355L9HrSmKBwJy
        EwjqrwaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD3kf-004A8L-FF; Thu, 27 Jan 2022 12:19:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E101300268;
        Thu, 27 Jan 2022 13:19:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4608A2B520929; Thu, 27 Jan 2022 13:19:43 +0100 (CET)
Date:   Thu, 27 Jan 2022 13:19:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <YfKN3+84gtaIopHW@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Ye67uQa4CwUuQJVY@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye67uQa4CwUuQJVY@geo.homenetwork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:46:17PM +0800, Tao Zhou wrote:
> Hi Peter,
> 
> On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:
> 
> [...]
> 
> > +/* pre-schedule() */
> > +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> > +{
> > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > +	int ret;
> > +
> > +	if (!tsk->umcg_server) {
> > +		/*
> > +		 * Already blocked before, the pages are unpinned.
> > +		 */
> > +		return;
> > +	}
> > +
> > +	/* Must not fault, mmap_sem might be held. */
> > +	pagefault_disable();
> > +
> > +	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED);
> > +	if (ret == -EAGAIN) {
> > +		/*
> > +		 * Consider:
> > +		 *
> > +		 *   self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
> > +		 *   ...
> > +		 *   sys_umcg_wait();
> > +		 *
> > +		 * and the '...' code doing a blocking syscall/fault. This
> > +		 * ensures that returns with UMCG_TASK_RUNNING, which will make
> 
> /UMCG_TASK_RUNNING/UMCG_TASK_RUNNABLE/

So the issue is that:

	self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;

	<#PF>
	  umcg_sys_enter()
	    umcg_pin_user_page()
	  schedule()
	    sched_submit_work()
	      umcg_wq_worker_sleeping()
	        umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED) // -EAGAIN
		UMCG_DIE()

Which is clearly not desirable.

So this additinoal thing ensures that:

		umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_BLOCKED) // 0

	  umcg_sys_exit()
	    umcg_update_state(tsk, self, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE);
	    umcg_enqueue_and_wake()

	  umcg_notify_resume()
	    umcg_wait()

	// must be UMCG_TASK_RUNNING here
	</#PF>

So when the pagefault finally does return, it will have:
UMCG_TASK_RUNNING.

Which will then make sys_umcg_wait() return -EAGAIN and around we go.

> > +		 * sys_umcg_wait() return with -EAGAIN.
> > +		 */
> > +		ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_BLOCKED);
> > +	}
> > +	if (ret)
> > +		UMCG_DIE_PF("state");
> > +
> > +	if (umcg_wake_server(tsk))
> > +		UMCG_DIE_PF("wake");
> > +
> > +	pagefault_enable();
> > +
> > +	/*
> > +	 * We're going to sleep, make sure to unpin the pages, this ensures
> > +	 * the pins are temporary. Also see umcg_sys_exit().
> > +	 */
> > +	umcg_unpin_pages();
> > +}
