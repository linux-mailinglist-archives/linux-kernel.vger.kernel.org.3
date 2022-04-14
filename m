Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89F5009EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiDNJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiDNJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:34:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6C6E574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1gnVKcslmL9jjdvWv9rXEVHSWDeQjeOFVmI2MFK5p+k=; b=D6crr4sOv+1HkELGgdRMFLXlIZ
        Q8yOUQtUVuePMl/TeHNBnmfoRJV2cGP06LHk6I5P4ybDda2tSABoTvdB8drghMfFtqIyRxPc8xhQs
        RMWWYKuR+q3HkiJBVeNyrAyGeyhsRROAwdLnR0TalQRH5vMDuBzHB4DvFwW3t9SCKDkuJ0/InhJT3
        faLjB6i4cS+mlAT0sG1WL/LY47a8Y72jIp3DPej8Hcj5kVYUtFz41ZbaZEsPeiHKprGyLNKgY1Ogd
        AKZWF+ImWpxpOb+nJdj6YorxvNI06YiR2DE/4C6yBqc823Q+UkZCkJgfdlmsHW8V+rZch1QBFORtI
        XgECsyLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nevpe-004yVm-Cz; Thu, 14 Apr 2022 09:32:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59E1230031E;
        Thu, 14 Apr 2022 11:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1723C2B3A873C; Thu, 14 Apr 2022 11:32:04 +0200 (CEST)
Date:   Thu, 14 Apr 2022 11:32:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_work: Add event-tracing points for irq_work
Message-ID: <YlfqFJLau+7PlPJ3@hirez.programming.kicks-ass.net>
References: <20220414063829.2472251-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414063829.2472251-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:38:29PM +0800, Zqiang wrote:
> Add irq_work_queue_on tracepoints allow tracing when and how
> a irq-work is queued, irq_work_execute_start/end tracepoints
> allow know when a irq-work is executed and the executed time.

Yeah, but why?

> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 7afa40fe5cc4..edad992556d0 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -22,6 +22,9 @@
>  #include <asm/processor.h>
>  #include <linux/kasan.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/irq_work.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> @@ -81,7 +84,9 @@ static void __irq_work_queue_local(struct irq_work *work)
>  	bool rt_lazy_work = false;
>  	bool lazy_work = false;
>  	int work_flags;
> +	int cpu = smp_processor_id();
>  
> +	trace_irq_work_queue_on(cpu, work);

That's not very nice, you made this function more expensive for no
reason. And you violated coding style while doing it :/

>  	work_flags = atomic_read(&work->node.a_flags);
>  	if (work_flags & IRQ_WORK_LAZY)
>  		lazy_work = true;
> @@ -143,7 +148,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>  	if (cpu != smp_processor_id()) {
>  		/* Arch remote IPI send/receive backend aren't NMI safe */
>  		WARN_ON_ONCE(in_nmi());
> -
> +		trace_irq_work_queue_on(cpu, work);
>  		/*
>  		 * On PREEMPT_RT the items which are not marked as
>  		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
> @@ -208,7 +213,9 @@ void irq_work_single(void *arg)
>  	smp_mb();
>  
>  	lockdep_irq_work_enter(flags);
> +	trace_irq_work_execute_start(work);
>  	work->func(work);
> +	trace_irq_work_execute_end(work);
>  	lockdep_irq_work_exit(flags);
>  
>  	/*


