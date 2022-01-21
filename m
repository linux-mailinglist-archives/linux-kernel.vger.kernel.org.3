Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A47495E92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350224AbiAULsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380234AbiAULsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:48:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF535C06173F;
        Fri, 21 Jan 2022 03:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFHfkJxcnXYD0/r/G4ykqtBeToVnk/8ZWOb3hXPkSGs=; b=In+XDGoh4xfF62ZOJqOxbFOxvI
        AyqXSblou41zoHqurVRhHtaM4vPwYhN/jyrxm5ahd2FZ3boobCmk3Slg+6vRxOrajOAs8+V0Ot7Pp
        C0e4UNjDW9IsxVh4qi6HfYTsg5t+Q6WLQgTvWuAVmHZ+qa7W5VaewfKCftPIazCHqisI44gOBfB3q
        Yy3w8P/6VuIA+LV+dUwIBBhr0416w4RF5ymf1QZSMmUDlvENSDlBXomFtPTWPxmyh3vwTLS4V7X++
        V3jsGYrC8GLOlCHWTl9NfmHFDZNbvUt79RO/BhPhykQZS6a4q9749ad+ZyB/8QVcvHM0YnfYCmUHi
        GMpFI3bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAsOf-002ZUP-3V; Fri, 21 Jan 2022 11:48:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE8679853F1; Fri, 21 Jan 2022 12:47:58 +0100 (CET)
Date:   Fri, 21 Jan 2022 12:47:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <20220121114758.GF20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120160822.914418096@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:

> +SYSCALL_DEFINE2(umcg_wait, u32, flags, u64, timo)
> +{
> +	struct task_struct *tsk = current;
> +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> +	bool worker = tsk->flags & PF_UMCG_WORKER;
> +	int ret;
> +
> +	if (!self || flags)
> +		return -EINVAL;
> +
> +	if (worker) {
> +		tsk->flags &= ~PF_UMCG_WORKER;
> +		if (timo)
> +			return -ERANGE;
> +	}
> +
> +	/* see umcg_sys_{enter,exit}() syscall exceptions */
> +	ret = umcg_pin_pages();
> +	if (ret)
> +		goto unblock;
> +
> +	/*
> +	 * Clear UMCG_TF_COND_WAIT *and* check state == RUNNABLE.
> +	 */
> +	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNABLE);
> +	if (ret)
> +		goto unpin;
> +
> +	ret = umcg_wake_next(tsk, self);
> +	if (ret)
> +		goto unpin;
> +
> +	if (worker) {
> +		/*
> +		 * If this fails it is possible ::next_tid is already running
> +		 * while this task is not going to block. This violates our
> +		 * constraints.
> +		 *
> +		 * That said, pretty much the only way to make this fail is by
> +		 * force munmap()'ing things. In which case one is most welcome
> +		 * to the pieces.
> +		 */
> +		ret = umcg_enqueue_and_wake(tsk);
> +		if (ret)
> +			goto unpin;
> +	}
> +
> +	umcg_unpin_pages();
> +
> +	ret = umcg_wait(timo);
> +	switch (ret) {
> +	case 0:		/* all done */
> +	case -EINTR:	/* umcg_notify_resume() will continue the wait */

So I was playing with the whole worker timeout thing last night and
realized this is broken. If we get a signal while we have a timeout, the
timeout gets lost.

I think the easiest solution is to have umcg_notify_resume() also resume
the timeout, but the first pass of that was yuck, so I need to try
again.

Related, by moving the whole enqueue-and-wake thing into the timeout, we
get more 'fun' failure cases :-(

Oh well..

> +		ret = 0;
> +		break;
> +
> +	default:
> +		goto unblock;
> +	}
> +out:
> +	if (worker)
> +		tsk->flags |= PF_UMCG_WORKER;
> +	return ret;
> +
> +unpin:
> +	umcg_unpin_pages();
> +unblock:
> +	umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING);
> +	goto out;
> +}
