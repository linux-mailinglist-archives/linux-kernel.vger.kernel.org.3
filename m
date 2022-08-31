Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9955A79DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHaJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHaJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1ADB959F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GFz5iOxIbBoTaBFwG7z+teOGvv89yKvEwyJQ2cSoFzc=; b=D4zzVGFeJjxoIM9PhRE79Psysy
        L4dFtyScAG6Wa48YuDOjM+fJbgDNWzZyPe368/WcSPOg7RGLC1Du+pMHJoKqIWkuQWlmH0YH7KzEK
        MpurqE66sfdNtecXb8kohhx0B2OmsCM2Csy6deuk1fO9E8RzNF7GCI9jHjt8X2HeN8AhzSX8GeJ3T
        RIBoCzr3dHoGLfsqtBvzNl78Xq8KRApeWubuMraMMehdP3mkUuiGpIn7VbgCQupUHwKtFky2PWw0S
        CjGSvUDh4iDqW7FKfnHRJwgtu2tlKr54Z8WAiaGcRS+iiXLNZuWl8P1KX8e5cf7yUaajDCMWWEC8v
        7D9hAWww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTJno-004xPS-44; Wed, 31 Aug 2022 09:14:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACFEB300137;
        Wed, 31 Aug 2022 11:14:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 930052B84630D; Wed, 31 Aug 2022 11:14:25 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:14:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v6 3/5] sched: Enforce user requested affinity
Message-ID: <Yw8mcbgYThZGpMfN@hirez.programming.kicks-ass.net>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826010119.1265764-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:01:17PM -0400, Waiman Long wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ac2b103d69dc..1c2f548e5369 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2928,11 +2928,40 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  static int __set_cpus_allowed_ptr(struct task_struct *p,
>  				  const struct cpumask *new_mask, u32 flags)
>  {
> +	struct cpumask *alloc_mask = NULL;
>  	struct rq_flags rf;
>  	struct rq *rq;
> +	int ret;
>  
>  	rq = task_rq_lock(p, &rf);
> -	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
> +	if (p->user_cpus_ptr) {
> +
> +		/*
> +		 * A scratch cpumask is allocated on the percpu runqueues
> +		 * to enable additional masking with user_cpus_ptr. This
> +		 * cpumask, once allocated, will not be freed.
> +		 */
> +		if (unlikely(!rq->scratch_mask)) {
> +			alloc_mask = kmalloc(cpumask_size(), GFP_ATOMIC);

This -- absolutely not. You can't have allocations under a
raw_spinlock_t.
