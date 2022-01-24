Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D0498270
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiAXObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbiAXObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:31:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF29C061772;
        Mon, 24 Jan 2022 06:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zm003PT7evhPd4nREot8EhRqp/f0aMO4joR+BuKJ58g=; b=IhySRJdN5vM3S13wy+sdRphe4k
        t6zJEGTbk72IDSl+2t7MkhPx8bzAP3LqAyNpV24t5GLvyOAkWTo1wnDsdoqAVKmApSgOQljn6gJGT
        phQetzpYZ3dUCOLVFN5LMLlglvsnlN2sWaZfU6uwE1Pb5oExmCxD1bh3GpOk9Tyy87vCsUe7FukFq
        OAR98VjbnhE3K1bBXy0TKZ227a51Cqvob2SByv5IdN44DOaYhHgdpmrigDx6nn2PdtHLWbSvZcFjA
        YxvImjlhZdJ3mq38g+pCK1pl3rGKklhwFWixB002O/QoQkYfZgbsSobjZUOIhcSxrQDJ/g2PyCEog
        0XYicAxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC0M0-000lKE-Nf; Mon, 24 Jan 2022 14:29:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44C523002A6;
        Mon, 24 Jan 2022 15:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C6212B5281A4; Mon, 24 Jan 2022 15:29:56 +0100 (CET)
Date:   Mon, 24 Jan 2022 15:29:56 +0100
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
Message-ID: <Ye635PiRpv4rXVl0@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <20220121114758.GF20638@worktop.programming.kicks-ass.net>
 <20220121151845.GB22849@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121151845.GB22849@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 04:18:46PM +0100, Peter Zijlstra wrote:
> Something like this, still yuck though. Also still need to write me a
> test for this.
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1300,12 +1300,14 @@ struct task_struct {
>  	clockid_t		umcg_clock;
>  	struct umcg_task __user	*umcg_task;
>  
> -	/* setup by umcg_pin_enter() */
> +	/* setup by umcg_pin_pages() */
>  	struct page		*umcg_page;
>  
>  	struct task_struct	*umcg_server;
>  	struct umcg_task __user *umcg_server_task;
>  	struct page		*umcg_server_page;
> +
> +	u64			umcg_timeout;
>  #endif
>  
>  	struct tlbflush_unmap_batch	tlb_ubc;
> --- a/kernel/sched/umcg.c
> +++ b/kernel/sched/umcg.c
> @@ -232,6 +232,8 @@ static int umcg_update_state(struct task
>  /* Called from syscall enter path and exceptions that can schedule */
>  void umcg_sys_enter(struct pt_regs *regs, long syscall)
>  {
> +	current->umcg_timeout = 0;
> +
>  	/* avoid recursion vs our own syscalls */
>  	if (syscall == __NR_umcg_wait ||
>  	    syscall == __NR_umcg_ctl)
> @@ -519,6 +521,7 @@ void umcg_notify_resume(struct pt_regs *
>  	struct umcg_task __user *self = tsk->umcg_task;
>  	bool worker = tsk->flags & PF_UMCG_WORKER;
>  	u32 state;
> +	int ret;
>  
>  	/* avoid recursion vs schedule() */
>  	if (worker)
> @@ -554,12 +557,17 @@ void umcg_notify_resume(struct pt_regs *
>  		umcg_unpin_pages();
>  	}
>  
> -	switch (umcg_wait(0)) {
> +	ret = umcg_wait(tsk->umcg_timeout);

Oh how I hate signals... this can get scribbled by a syscall/fault from
sigcontext :/

Maybe I can recover the timo argument from the original syscall
pt_regs.. let me try.

> +	switch (ret) {
>  	case 0:
>  	case -EINTR:
>  		/* we will resume the wait after the signal */
>  		break;
>  
> +	case -ETIMEDOUT:
> +		regs_set_return_value(regs, ret);
> +		break;
> +
>  	default:
>  		UMCG_DIE("wait");
>  	}
> @@ -759,6 +767,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
>  	switch (ret) {
>  	case 0:		/* all done */
>  	case -EINTR:	/* umcg_notify_resume() will continue the wait */
> +		tsk->umcg_timeout = timo;
>  		ret = 0;
>  		break;
>  
