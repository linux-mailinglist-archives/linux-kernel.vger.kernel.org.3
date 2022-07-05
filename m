Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15E5675D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGERen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiGERel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:34:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FD14094
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tzh69ecxxFahzsxZMQDY6oUHv+2OxChrl1uKATDHkpk=; b=ppnyF68XTBuMUOH4Lrb+xwHioL
        6fqhWIfCoxux+gO1hSgHYEbpMB3yaeGK7qWw8d48v0lrkC0CLx4F8kjFbBv55BxUhSNE8HLy9TNK/
        Hyb9kknb0WzYCU4W9s/1ZjkGSX5L2ebrEO+474PAVhht5N/uVGMjpD2emI1nYWn27MNDpa9IHOcsN
        q8tW5PvAIqP5N8Vn/cnS43X9CiJSZ4LJFcjkCO+cR6WGEfAfqwK95vnj2IJl4pd8NDxv0YMM4Dl2c
        8MnCgHSv/wALrvnIcgZEPuTCk+ZS9pvqcJoE8hQPRW3DjEZ+eZyYJwk4tFm7NKrhmMeK7XMupdoqd
        Q4BQa3AA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8mRP-0004nJ-HW; Tue, 05 Jul 2022 17:34:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E45D4980059; Tue,  5 Jul 2022 19:34:25 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:34:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] locking/qspinlock: separate pv_wait_node from the
 non-paravirt path
Message-ID: <YsR2IQsnqAOgDxXu@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-13-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-13-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:19AM +1000, Nicholas Piggin wrote:
> pv_wait_node waits until node->locked is non-zero, no need for the
> pv case to wait again by also executing the !pv code path.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/locking/qspinlock.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 9db168753124..19e2f286be0a 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -862,10 +862,11 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool parav
>  		/* Link @node into the waitqueue. */
>  		WRITE_ONCE(prev->next, node);
>  
> +		/* Wait for mcs node lock to be released */
>  		if (paravirt)
>  			pv_wait_node(node, prev);
> -		/* Wait for mcs node lock to be released */
> -		smp_cond_load_acquire(&node->locked, VAL);
> +		else
> +			smp_cond_load_acquire(&node->locked, VAL);
>  

(from patch #6):

+static void pv_wait_node(struct qnode *node, struct qnode *prev)
+{
+       int loop;
+       bool wait_early;
+
	...
+
+       /*
+        * By now our node->locked should be 1 and our caller will not actually
+        * spin-wait for it. We do however rely on our caller to do a
+        * load-acquire for us.
+        */
+}

