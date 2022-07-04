Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C59565013
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGDIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiGDIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:53:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A119B7F1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jVshmOJVGm7NgCJsCyHB652i2EKwS6Y5885hBpBBrLA=; b=qwpRN2yQ97B00UHcJqVyvlv5bD
        bUlpC5Lm96GD0X+agOyEqio2eNZEcEXBFW5FzvNQZL6JEwkunwgbWLRn+MkxrCfSaImTw/1HlcKTx
        pebvt2xCwJd/+qkyfsTjhvJ4GSaoAp+Cbo7gWqNj/ZUw37WP+4rslF7YaULseQmdNXBejjpFhnnEe
        Zuiu+Izy4TXC5tNMKxCn5LNpTnYLNh82gXWjhD01CDx1KAQrJCyA+SscIVZ5LTmowPKhq/KmM5CT/
        ZuIdXb/oTe6MabLm6QnLY5QG7OVQITA0JYds1c2cQ5WAITxb/Lu0qihDp6YzBd0fEzV5NV0WGolz9
        osj163WQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hpa-00H3ls-Lw; Mon, 04 Jul 2022 08:53:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F03230003A;
        Mon,  4 Jul 2022 10:53:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0508A201850A7; Mon,  4 Jul 2022 10:53:19 +0200 (CEST)
Date:   Mon, 4 Jul 2022 10:53:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/core: Fix the bug that task won't enqueue into
 core tree when update cookie
Message-ID: <YsKqf3mnv/aemeuC@hirez.programming.kicks-ass.net>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:23PM +0800, Cruz Zhao wrote:
> In function sched_core_update_cookie(), a task will enqueue into the
> core tree only when it enqueued before, that is, if an uncookied task
> is cookied, it will not enqueue into the core tree until it enqueue
> again, which will result in unnecessary force idle.
> 
> Here follows the scenario:
>   CPU x and CPU y are a pair of SMT siblings.
>   1. Start task a running on CPU x without sleeping, and task b and
>      task c running on CPU y without sleeping.
>   2. We create a cookie and share it to task a and task b, and then
>      we create another cookie and share it to task c.
>   3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched
> 
> And we will find out that core_forceidle_sum of task a takes 30%
> time of the sampling period, which shouldn't happen as task a and b
> have the same cookie.
> 
> Then we migrate task a to CPU x', migrate task b and c to CPU y', where
> CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
> will found out that core_forceidle_sum of task a and b are almost zero.
> 
> To solve this problem, we enqueue the task into the core tree if it's
> on rq.
> 
> Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  kernel/sched/core_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index 38a2cec..ba2466c 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -75,7 +75,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
>  	old_cookie = p->core_cookie;
>  	p->core_cookie = cookie;
>  
> -	if (enqueued)
> +	if (task_on_rq_queued(p))
>  		sched_core_enqueue(rq, p);
>  
>  	/*

Yeah; I suppose that's true. However if we want to consider the
asymmetric case, we should be complete and also consider the case where
we clear the cookie.

And if you remove the second use of @enqueued, having that variable is
rather redudant, which then leaves me with something like this.

---
Subject: sched/core: Fix the bug that task won't enqueue into core tree when update cookie
From: Cruz Zhao <CruzZhao@linux.alibaba.com>
Date: Tue, 28 Jun 2022 15:57:23 +0800

From: Cruz Zhao <CruzZhao@linux.alibaba.com>

In function sched_core_update_cookie(), a task will enqueue into the
core tree only when it enqueued before, that is, if an uncookied task
is cookied, it will not enqueue into the core tree until it enqueue
again, which will result in unnecessary force idle.

Here follows the scenario:
  CPU x and CPU y are a pair of SMT siblings.
  1. Start task a running on CPU x without sleeping, and task b and
     task c running on CPU y without sleeping.
  2. We create a cookie and share it to task a and task b, and then
     we create another cookie and share it to task c.
  3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched

And we will find out that core_forceidle_sum of task a takes 30%
time of the sampling period, which shouldn't happen as task a and b
have the same cookie.

Then we migrate task a to CPU x', migrate task b and c to CPU y', where
CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
will found out that core_forceidle_sum of task a and b are almost zero.

To solve this problem, we enqueue the task into the core tree if it's
on rq.

Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com
---
 kernel/sched/core_sched.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -56,7 +56,6 @@ static unsigned long sched_core_update_c
 	unsigned long old_cookie;
 	struct rq_flags rf;
 	struct rq *rq;
-	bool enqueued;
 
 	rq = task_rq_lock(p, &rf);
 
@@ -68,14 +67,16 @@ static unsigned long sched_core_update_c
 	 */
 	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
 
-	enqueued = sched_core_enqueued(p);
-	if (enqueued)
+	if (sched_core_enqueued(p))
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
 
 	old_cookie = p->core_cookie;
 	p->core_cookie = cookie;
 
-	if (enqueued)
+	/*
+	 * Consider the cases: !prev_cookie and !cookie.
+	 */
+	if (cookie && task_on_rq_queued(p))
 		sched_core_enqueue(rq, p);
 
 	/*
