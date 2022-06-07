Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E691540416
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbiFGQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbiFGQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:51:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C26F7481
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:51:23 -0700 (PDT)
Date:   Tue, 7 Jun 2022 18:51:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654620681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASmZspFJg7SV1th3PAV0hYBncv3mqyKHYuJqFLoK79U=;
        b=Uu53B0FCYjKCGgIGhdmtDk5V5kP1tMTCyYsEpurQvLdT3nM9VfzbLmTJiLYfF6bnuWN4Wu
        lJ2qFEtMwkc2g2IabQ2wU4LRIxc/Im+rAXLfWHXTw+g7VKDqlJwqIE3ZDD/aNIp81VycE0
        qf3j/J783AOnDU7H37PWJWRIOy9IB+crbNUlgS8DXWCsn/bXfvnIgrI1Bbb5QWl3zG09ZN
        2eAC/ss3AtPTNERb9L3jVM95CRqPlLNFZNdUGu672TKxOzyIiblx6a1BvIcwMM6frL+UtT
        s7NBIKKAqJMyUB1aqQLDHMJAEYI5SJZZA/Bcb6PsA0gtG6iLYOnO3aQ36q634Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654620681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASmZspFJg7SV1th3PAV0hYBncv3mqyKHYuJqFLoK79U=;
        b=aHKgUN3uP4JBhjv6rhRk3McIGb9hUM8HApx/EWVmRq9yFz+ChgfeLF/UR1CuxYcs+MIfB3
        0m0xpb2/iTjHXVAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <Yp+CCGIdrIFZbJKs@linutronix.de>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoNn3pTkm5+QzE5k@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 11:16:14 [+0200], To linux-kernel@vger.kernel.org wrote:
> Since the rewrote of prandom_u32(), in the commit mentioned below, the
> function uses sleeping locks which extracing random numbers and filling
> the batch.
> This breaks lockdep on PREEMPT_RT because lock_pin_lock() disables
> interrupts while calling __lock_pin_lock(). This can't be moved earlier
> because the main user of the function (rq_pin_lock()) invokes that
> function after disabling interrupts in order to acquire the lock.
> 
> The cookie does not require random numbers as its goal is to provide a
> random value in order to notice unexpected "unlock + lock" sites.
> 
> Use sched_clock() to provide random numbers.
> 
> Fixes: a0103f4d86f88 ("random32: use real rng for non-deterministic randomness")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> So if the architecture does not provide sched_clock() and does not
> enabled GENERIC_SCHED_CLOCK then we use jiffies here. Most of them do
> one or the other except for alpha, csky, hexagon, ... but I don't worry
> here since arm*, power*, x86* do provide it.

ping.

Jason suggested atomic_inc_return(&some_global).

>  kernel/locking/lockdep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 81e87280513ea..f06b91ca6482d 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5432,7 +5432,7 @@ static struct pin_cookie __lock_pin_lock(struct lockdep_map *lock)
>  			 * be guessable and still allows some pin nesting in
>  			 * our u32 pin_count.
>  			 */
> -			cookie.val = 1 + (prandom_u32() >> 16);
> +			cookie.val = 1 + (sched_clock() & 0xffff);
>  			hlock->pin_count += cookie.val;
>  			return cookie;
>  		}

Sebastian
