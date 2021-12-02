Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D49466B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbhLBVGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhLBVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:06:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nr75ugCDtn6FabMmV0djrs1/0hpK+Vc9tFjBmACeXU8=; b=pqeLtkrZPBoBwJ7ZvjCxHZxXE6
        hJ/bszrPho6bqBICZZkwMomMrfpkukktS0Mz8a5TaPpUXO56syIXw1kIR53Iw9dg3tIigBJlacaZr
        C4rO+L5EI7tqL8KPB33lhWATVzp2w5mOslrZVxLh+0G6k8lDrbxNO9dMbQwRNwUTBWKOL2jP+dEBI
        e+kCcy/ye06LuhpE7QHNzMvD8gE9GFxN3rT9xlTgJqDTztb51aeEQWtpG5BzUZoKQGk0LMBHMmtby
        wuGLPgA/+gtKUjIpc742qL7P1ce+2u78bIgGHjHiYfdhCwAJBnJTunqpcQ6LU90TLAyx9McoAxX+D
        1NHiTqfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mstDi-001saj-T5; Thu, 02 Dec 2021 21:02:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E559A9810D4; Thu,  2 Dec 2021 22:02:21 +0100 (CET)
Date:   Thu, 2 Dec 2021 22:02:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/11] sched: Trigger warning if ->migration_disabled
 counter underflows.
Message-ID: <20211202210221.GB16608@worktop.programming.kicks-ass.net>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
 <20211129174654.668506-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129174654.668506-2-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 06:46:44PM +0100, Sebastian Andrzej Siewior wrote:
> If migrate_enable() is used more often than its counter part then it
> remains undetected and rq::nr_pinned will underflow, too.
> 
> Add a warning if migrate_enable() is attempted if without a matching a
> migrate_disable().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 76f9deeaa9420..02be3f6144e97 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2171,6 +2171,8 @@ void migrate_enable(void)
>  	if (p->migration_disabled > 1) {
>  		p->migration_disabled--;
>  		return;

Due to return there ^

> +	} else if (WARN_ON_ONCE(p->migration_disabled == 0)) {
> +		return;
>  	}

we can do away with else and simply write:

	if (WARN_ON_ONCE(!p->migration_disabled))
		return;
