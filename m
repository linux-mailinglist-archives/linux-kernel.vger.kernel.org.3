Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBCF49EA97
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiA0SrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:47:20 -0500
Received: from out0.migadu.com ([94.23.1.103]:15157 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbiA0SrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:47:13 -0500
Date:   Fri, 28 Jan 2022 02:47:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643309232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKkvOop6NBVOz4myJcJLCtPSQ/pPLA6YNYvDUwSzWJ4=;
        b=ql3pdQZqzgSNQx7urPCbVYqgUhXgY2dDoca6ITOB9uk7Z7y+jziWdFN+HH4EctHL2OotPO
        xCEg5xYnWPXObr6N0yZInYF0yhqhfK2V3Gm87xbMOHQcY7eDUR5MSeySAvcFvvI7zyuh1G
        fj9JxF6CRWX27HJ/xEU1aEciWim9ryE=
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
Message-ID: <YfLorAvvQJO5uhL5@geo.homenetwork>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Ye67uQa4CwUuQJVY@geo.homenetwork>
 <YfKPQJ+Nr4Qokgim@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKPQJ+Nr4Qokgim@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:25:36PM +0100, Peter Zijlstra wrote:

> On Mon, Jan 24, 2022 at 10:46:17PM +0800, Tao Zhou wrote:
> 
> > > +/* Called from syscall exit path and exceptions that can schedule */
> > > +void umcg_sys_exit(struct pt_regs *regs)
> > > +{
> > > +	struct task_struct *tsk = current;
> > > +	long syscall = syscall_get_nr(tsk, regs);
> > > +
> > > +	if (syscall == __NR_umcg_wait ||
> > > +	    syscall == __NR_umcg_ctl)
> > > +		return;
> > > +
> > > +	if (tsk->umcg_server) {
> > > +		/*
> > > +		 * Didn't block, we done.
> > > +		 */
> > > +		umcg_unpin_pages();
> > > +		return;
> > > +	}
> > > +
> > > +	umcg_unblock_and_wait();
> > 
> > umcg_unblock_and_wait() -> umcg_enqueue_and_wake() ->
> > umcg_wake_server() -> umcg_wake_task(tsk->umcg_server, ...)
> > 
> > tsk->umcg_server is NULL here and umcg_wake_task() use it to update
> > state in umcg_update_state(NULL, ...), that means tsk->umcg_clock
> > will happen something i do not know.
> 
> I think umcg_unblock_and_wait() will repin, at which point we should
> have tsk->umcg_server again.

That's right, I miss that.

> > There are two places to call umcg_unblock_and_wait(). One is in 
> > umcg_register() where the server is set. Another one is in
> > umcg_sys_exit() where the server is not set. May use a bool to
> > indicate if the server is set.
> 
> I'm not sure what you're on about, but I absolutely hate redundant
> state, that only leads to problems.


But, it's my noise though.
