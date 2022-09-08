Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1645B209D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiIHOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiIHOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:32:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A32E697
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Syhp4rZA+qzthqvGC4M9hXWso78kYaxfP1wP3PPP5c=; b=c6512nj93xf/RVGnTp0Bbtmcy7
        UfydF5TaJwnb14XLEMnXbTfYe0YcRSvO7SJ7rSksRPv+EFFfm/mY/+NROrbnWgEHRLTdH2QOijZ7l
        iaiOwjEO3tXzOJ1EfduCcMo0m9WpVqDngfVHsjEpGPhrJq5QWgtoSV0BcWWGGxTCxYRllz0GhUTYz
        T7MVtYMYTdoN/PWHQpFwAqpGH+5JnPzwBUeehv3BYtuZHuY6AwSFBsIUKxMqb5LyIIy+DyY7NoKQG
        QymhaqTvsTWhdHoV3dJRQ+K4M/XCVywzf6RyzIV6YrIYb8yxRzerYlPYVwtNORaVfk1en5oeIXx56
        jKKYnfcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWIZk-00CPgr-UW; Thu, 08 Sep 2022 14:32:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A63730013F;
        Thu,  8 Sep 2022 16:32:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F07382B9B9AAE; Thu,  8 Sep 2022 16:32:12 +0200 (CEST)
Date:   Thu, 8 Sep 2022 16:32:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH] locking/rwsem: Disable preemption while trying for rwsem
 lock
Message-ID: <Yxn87KDv1h4mwbIL@hirez.programming.kicks-ass.net>
References: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:58:10PM +0530, Mukesh Ojha wrote:
> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> Make the region inside the rwsem_write_trylock non preemptible.
> 
> We observe RT task is hogging CPU when trying to acquire rwsem lock
> which was acquired by a kworker task but before the rwsem owner was set.
> 
> Here is the scenario:
> 1. CFS task (affined to a particular CPU) takes rwsem lock.
> 
> 2. CFS task gets preempted by a RT task before setting owner.
> 
> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> RT throttling happens for the lock as the lock was taken by CFS task.
> 
> This patch attempts to fix the above issue by disabling preemption
> until owner is set for the lock. while at it also fix this issue
> at the place where owner being set/cleared.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

This is not a valid SoB chain.

> ---
>  kernel/locking/rwsem.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 65f0262..3b4b32e 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -251,13 +251,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
>  static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
>  {
>  	long tmp = RWSEM_UNLOCKED_VALUE;
> +	bool ret = false;
>  
> +	preempt_disable();
>  	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
>  		rwsem_set_owner(sem);
> -		return true;
> +		ret = true;
>  	}
>  
> -	return false;
> +	preempt_enable();
> +	return ret;
>  }
>  
>  /*

Yes, this part looks ok.

> @@ -686,16 +689,21 @@ enum owner_state {
>  static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
>  {
>  	long count = atomic_long_read(&sem->count);
> +	bool ret = false;
>  
> +	preempt_disable();
>  	while (!(count & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))) {
>  		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
>  					count | RWSEM_WRITER_LOCKED)) {
>  			rwsem_set_owner(sem);
>  			lockevent_inc(rwsem_opt_lock);
> -			return true;
> +			ret = true;
> +			break;
>  		}
>  	}
> -	return false;
> +
> +	preempt_enable();
> +	return ret;
>  }
>  

This one I can't follow; afaict this is only called with preemption
already disabled.

>  static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> @@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
>  	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
>  			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
>  
> +	preempt_disable();
>  	rwsem_clear_owner(sem);
>  	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
> +	preempt_enable();
>  	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
>  		rwsem_wake(sem);
>  }

Yep, that looks good again.

Perhaps the thing to do would be to add:

  lockdep_assert_preemption_disabled()

to rwsem_{set,clear}_owner() and expand the comment there to explain
that these functions should be in the same preempt-disable section as
the atomic op that changes sem->count.
