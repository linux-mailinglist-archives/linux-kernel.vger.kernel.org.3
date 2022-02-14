Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710E94B4D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349148AbiBNKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:47:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350233AbiBNKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:46:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9375C15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d5GJFaZfEuG4Hdri9olKUMmdfH3QS7N4ZwsXYTk7jcU=; b=pqJuoFpwMHO7muPWRFwYzzA3Em
        1+lHxe8LmKC25l/y3p9w91f+ketCVBGvmylvFJvGqRPP4qwKoPNpuESVyEV7YBnGe1zyNVE+toRaG
        PifsPo2sSopRefCp6+nAKfyaWM9ZXU9QsRdkwTp34VOGuVuHc2kULQsz0Hi8ZhIFqbAzghXO7+NqH
        MUpXtvPB2kUmhqA+U3vPSqNL3FqRumfW7WY1o7Wu5pbp6xWev/0Eeb6S36poIBQuzqRtyzViYs9u4
        W7VC5Uq2BhWxYY6SWlRL9qXp3BUFzh/xKrYICTlEioQsJHNdKk5NK2tmzSCnCIx1BqIxyK10oRSR3
        HuoXi5Og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJYI3-00CloE-A7; Mon, 14 Feb 2022 10:09:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E45B3002C5;
        Mon, 14 Feb 2022 11:09:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F157B2067AC08; Mon, 14 Feb 2022 11:09:01 +0100 (CET)
Date:   Mon, 14 Feb 2022 11:09:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, arbn@yandex-team.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Minye Zhu <zhuminye@bytedance.com>
Subject: Re: [PATCH] sched/cpuacct: fix charge percpu cpuusage
Message-ID: <YgoqPT67g2NcV/eH@hirez.programming.kicks-ass.net>
References: <20220213120118.93471-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213120118.93471-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 08:01:18PM +0800, Chengming Zhou wrote:
> The cpuacct_account_field() is always called by the current task
> itself, so it's ok to use __this_cpu_add() to charge the tick time.
> 
> But cpuacct_charge() maybe called by update_curr() in load_balance()
> on a random CPU, different from the CPU on which the task is running.
> So __this_cpu_add() will charge that cputime to a random incorrect CPU.
> 
> Reported-by: Minye Zhu <zhuminye@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Can I get a Fixes: tag for this?

> ---
>  kernel/sched/cpuacct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 3d06c5e4220d..75fbc212cb71 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -335,11 +335,12 @@ static struct cftype files[] = {
>  void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
>  	struct cpuacct *ca;
> +	unsigned int cpu = task_cpu(tsk);
>  
>  	rcu_read_lock();
>  
>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
> -		__this_cpu_add(*ca->cpuusage, cputime);
> +		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
>  
>  	rcu_read_unlock();
>  }

Also, while we there, what about this as an additional patch?

--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -334,15 +334,13 @@ static struct cftype files[] = {
  */
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
-	struct cpuacct *ca;
 	unsigned int cpu = task_cpu(tsk);
+	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_rq_held(cpu_rq(cpu));
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
