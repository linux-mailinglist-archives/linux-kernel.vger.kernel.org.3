Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060F4A6FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbiBBLYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiBBLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:24:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C9C061714;
        Wed,  2 Feb 2022 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0uChyntsGbZTYF0NOYbJgym9Avq1awMCpANR+feQH8w=; b=DYhEZ9Kr6q4Vf8w3RGMPtj5fer
        CeDPlxxRKjB8rYp0besQzPX5n1VUUl5wdTY02xwPKrz1GS/iw5KUJv85yQRLqiR1T9/JghiH1FdAM
        eh5Jz6bvL7r/WriU89jKlO8TANkIcRPNPtVuWC6yOLsHZzVy+F8LjKfKZAGIEGZfxVQTVubw9+tD4
        CTS7fph0lnMnS+SHC2E5Xju+4aCx3OeTjeKy1/6/p4mWFmeS+VQQKyulRwbXOQZDSmVGeHILZVTIf
        wC8uHNKYY65xQ2KcEz9zVkSoAltQ8O9jHvtoqWmiaJP9jj9okWkuq3BL5FQdHe/OZoMjbpO4sk1R0
        XcCAgJ3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFDjk-00ESwW-8Y; Wed, 02 Feb 2022 11:23:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ACFB98327C; Wed,  2 Feb 2022 12:23:43 +0100 (CET)
Date:   Wed, 2 Feb 2022 12:23:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 1/3] Introduce per thread group current virtual cpu id
Message-ID: <20220202112343.GZ20638@worktop.programming.kicks-ass.net>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:25:38PM -0500, Mathieu Desnoyers wrote:

> +static inline void tg_vcpu_get(struct task_struct *t)
> +{
> +	struct cpumask *cpumask = &t->signal->vcpu_mask;
> +	unsigned int vcpu;
> +
> +	if (t->flags & PF_KTHREAD)
> +		return;
> +	/* Atomically reserve lowest available vcpu number. */
> +	do {
> +		vcpu = cpumask_first_zero(cpumask);
> +		WARN_ON_ONCE(vcpu >= nr_cpu_ids);
> +	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
> +	t->tg_vcpu = vcpu;
> +}
> +
> +static inline void tg_vcpu_put(struct task_struct *t)
> +{
> +	if (t->flags & PF_KTHREAD)
> +		return;
> +	cpumask_clear_cpu(t->tg_vcpu, &t->signal->vcpu_mask);
> +	t->tg_vcpu = 0;
> +}

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2e4ae00e52d1..2690e80977b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4795,6 +4795,8 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>  	sched_info_switch(rq, prev, next);
>  	perf_event_task_sched_out(prev, next);
>  	rseq_preempt(prev);
> +	tg_vcpu_put(prev);
> +	tg_vcpu_get(next);


URGGHHH!!! that's *2* atomics extra on the context switch path. Worse,
that's on a line that's trivially contended with a few threads.
