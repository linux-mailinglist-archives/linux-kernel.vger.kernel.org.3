Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E598522E68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiEKIbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243732AbiEKIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:30:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00777AE59
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5e65L0M41Gs6gcibvNCWhoVMZX63kJooFCukdv86e0=; b=cC5m+FXs3pQOted/Fo/m8h5tmY
        MEN2YGzsI/VpSjyAa6MS24IIDOd1qWs6Cea7KeF+u465ZQBXMAPudbzUYnPGMuUFhb43mnAJKZNYz
        Ao35McZcy9IbGAvfB/A2+MKq2Tk+HeO5xj1u5+dX5R6qlcIZQFLGDG10rO7SbXqqdQqZJnjm0g6XN
        wzmUgjGqLPwvC7GUJvSaDJ2IzBL6VV8Hs/SttaLW4VTvIFCyy3He6GuURAmNxjYqGDgWkctxsIdYz
        qJYpRbJ73gk/kLRZD9kv27O8tfn0iOQJCLJBHvk1VHfB2Jz+lU4axJqJ/oVSiqhfPYQjYy74xB3qC
        rh9kIkMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nohjy-005HDw-Dz; Wed, 11 May 2022 08:30:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44F0E980E3A; Wed, 11 May 2022 10:30:36 +0200 (CEST)
Date:   Wed, 11 May 2022 10:30:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for
 rwlocks used in interrupt context
Message-ID: <20220511083036.GY76023@worktop.programming.kicks-ass.net>
References: <20220510192134.434753-1-longman@redhat.com>
 <20220510192134.434753-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510192134.434753-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:21:34PM -0400, Waiman Long wrote:
> Even though qrwlock is supposed to be a fair lock, it does allow readers
> from interrupt context to spin on the lock until it can acquire it making
> it not as fair. This exception was added due to the requirement to allow
> recursive read lock in interrupt context. This can also be achieved by
> just ignoring the writer waiting bit without spinning on the lock.
> 
> By making this change, we make qrwlock a bit more fair and eliminating
> the problem of cacheline bouncing for rwlocks that are used heavily in
> interrupt context, like the networking stack. This should also reduce
> the chance of lock starvation for those interrupt context rwlocks.

> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 2e1600906c9f..d52d13e95600 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -18,21 +18,16 @@
>   * queued_read_lock_slowpath - acquire read lock of a queued rwlock
>   * @lock: Pointer to queued rwlock structure
>   */
> -void queued_read_lock_slowpath(struct qrwlock *lock)
> +void queued_read_lock_slowpath(struct qrwlock *lock, int cnts)
>  {
>  	/*
> -	 * Readers come here when they cannot get the lock without waiting
> +	 * Readers come here when they cannot get the lock without waiting.
> +	 * Readers in interrupt context can steal the lock immediately
> +	 * if the writer is just waiting (not holding the lock yet).
>  	 */
> -	if (unlikely(in_interrupt())) {
> -		/*
> -		 * Readers in interrupt context will get the lock immediately
> -		 * if the writer is just waiting (not holding the lock yet),
> -		 * so spin with ACQUIRE semantics until the lock is available
> -		 * without waiting in the queue.
> -		 */
> -		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> +	if (unlikely(!(cnts & _QW_LOCKED) && in_interrupt()))
>  		return;
> -	}
> +
>  	atomic_sub(_QR_BIAS, &lock->cnts);
>  
>  	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);

I'm confused; prior to this change:

	CPU0			CPU1

	write_lock_irq(&l)
				read_lock(&l)
				<INRQ>
				  read_lock(&l)
				  ...

was not deadlock, but now it would AFAICT.
