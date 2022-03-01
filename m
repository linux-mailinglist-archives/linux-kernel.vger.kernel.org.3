Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE04C95B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiCAUQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiCAUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:15:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44F793B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6o8nIBZ0Ps4Qmeg40M/Ug+f6byp9f0Ke0jla8RoneDw=; b=dYyduuOPlyzkDoVATYGdboQCpp
        +LMD3rVk2SuXHomUx+E3qYxQdUg3SH+57d+oM/7OuohmVV0/3AFiuvaMuT0yAXORmIXsWKXAD2gh6
        N7rTLWMfG6MhYJNUHYAPksIX2wMaRi/vjR2/D74ybgTUS96yGm294oJn/G+6itUQynxc4PJGSnGje
        A4uVBJNIEtNbBWY1jaZBChge+o5SmpoEobfZOQRSwz4rNiww7nHi60CbFg6m+FadyF9yfgX1jLiZl
        2h0Db0q1tsA1+n5h36Y1MG3wW5/VaQkBN3BVdWO5DvOV9M3RX///Tninpo8DqVphk7Nz8njhI0ZxD
        YQ3aqhfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP8tF-00EMkD-RK; Tue, 01 Mar 2022 20:14:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F3B0986271; Tue,  1 Mar 2022 21:14:32 +0100 (CET)
Date:   Tue, 1 Mar 2022 21:14:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Make preempt_enable_no_resched() behave like
 preempt_enable() on PREEMPT_RT
Message-ID: <20220301201432.GL11184@worktop.programming.kicks-ass.net>
References: <Yh5mSGCbvqDdeCa3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh5mSGCbvqDdeCa3@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 07:30:32PM +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use the distinction that has been made earlier between
> preempt_enable_no_resched() and sched_preempt_enable_no_resched().
> sched_preempt_enable_no_resched() is used within the scheduler where an
> immediate schedule() follows. preempt_enable_no_resched() is used
> outside of the scheduler and an immediate schedule() invocation may not
> follow for other reasons.
> 
> The lack of an immediate schedule() invocation matters on PREEMPT_RT
> where it will introduce latencies while the scheduler expects a context
> switch.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/preempt.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index b4381f255a5ca..582e43856a532 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -210,7 +210,11 @@ do { \
>  	preempt_count_dec(); \
>  } while (0)
>  
> -#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
> +#ifdef CONFIG_PREEMPT_RT
> +# define preempt_enable_no_resched() preempt_enable()
> +#else
> +# define preempt_enable_no_resched() sched_preempt_enable_no_resched()
> +#endif

Ignoring !x86 for a moment:

arch/x86/mm/kmmio.c:    preempt_enable_no_resched();
arch/x86/mm/kmmio.c:    preempt_enable_no_resched();
include/linux/preempt.h:#define sched_preempt_enable_no_resched() \
include/linux/preempt.h:#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
include/linux/preempt.h:#define preempt_enable_no_resched_notrace() \
include/linux/preempt.h:#define sched_preempt_enable_no_resched()       barrier()
include/linux/preempt.h:#define preempt_enable_no_resched()             barrier()
include/linux/preempt.h:#define preempt_enable_no_resched_notrace()     barrier()
include/linux/preempt.h:#undef sched_preempt_enable_no_resched
include/linux/preempt.h:#undef preempt_enable_no_resched
include/linux/preempt.h:#undef preempt_enable_no_resched_notrace
kernel/sched/core.c:            preempt_enable_no_resched();
kernel/sched/core.c:                    preempt_enable_no_resched();
kernel/sched/core.c:            sched_preempt_enable_no_resched();
kernel/sched/core.c:    sched_preempt_enable_no_resched();
kernel/sched/core.c:            sched_preempt_enable_no_resched();
kernel/sched/core.c:            preempt_enable_no_resched_notrace();
kernel/sched/core.c:            preempt_enable_no_resched_notrace();
kernel/sched/core.c:            sched_preempt_enable_no_resched();
kernel/sched/core.c:    sched_preempt_enable_no_resched();
kernel/signal.c:                preempt_enable_no_resched();
kernel/smpboot.c:                       preempt_enable_no_resched();
lib/smp_processor_id.c: preempt_enable_no_resched_notrace();


Surely we can audit that... At a glance the proposed patch does more
harm than good. Only the kmmio case looks obviousl fail, but then IIRC
kmmio had worse problems.
