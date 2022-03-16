Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA604DB970
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354226AbiCPUgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349967AbiCPUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:36:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225665C844
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OvIDWLh0jLy/iDdFHjTCrPCxvaonCA6g5BZn+QH0ahA=; b=FvIMZ594gcdT/01tlxNeYor/f4
        RUm/tglmISWkrym+KYEZDa3oYvbEK1E0q7nE49GmYDDSb6P2Vn/nFm07DuWKcyQZQHc+gAs7AtfUC
        qK+liY87Ng2fSyKs9CYaQ+XkNdct52OjKaSfNEbf3z0wtY2bTo2y/uzzn9T0zOvgicw8cyOiUFj4N
        kI8C9SE2EmcwFN4rzWRDtRbXXW+xpJHEo9uxp9GYehjWYhM+T5seiYuMs1IoAOjhCWuVlN+WdRpbb
        3hW4awJZT5Px4WqJCJrRHo+yyvdC4lCrVujJ3CtblZ8+NZGgu6WH7qT4l2HdXeL6puDrdREpBui4E
        hcXc/tRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUaMf-001eVj-BB; Wed, 16 Mar 2022 20:35:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F09D99882AA; Wed, 16 Mar 2022 21:35:24 +0100 (CET)
Date:   Wed, 16 Mar 2022 21:35:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220316203524.GK8939@worktop.programming.kicks-ass.net>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <YjIKQBIbJR/kRR+N@linutronix.de>
 <YjIN4C8EFIOOR+o4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjIN4C8EFIOOR+o4@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:18:40PM +0100, Sebastian Andrzej Siewior wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 33ce5cd113d8..f4675bd8f878 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5968,6 +5967,9 @@ static bool try_steal_cookie(int this, int that)
>  		if (p == src->core_pick || p == src->curr)
>  			goto next;
>  
> +		if (p->migration_disabled)
> +			goto next;
> +
>  		if (!cpumask_test_cpu(this, &p->cpus_mask))
>  			goto next;
>  
> on top my problems are gone. Let me do some testing and then I would
> patch unless PeterZ does the yelling :)

The previous thing in wrong because it tries to solve the wrong thing,
the above makes sense, except I would write it like so:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f95a1ea..04c05bc4062e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5914,7 +5914,7 @@ static bool try_steal_cookie(int this, int that)
 		if (p == src->core_pick || p == src->curr)
 			goto next;
 
-		if (!cpumask_test_cpu(this, &p->cpus_mask))
+		if (!is_cpu_allowed(p, this))
 			goto next;
 
 		if (p->core_occupation > dst->idle->core_occupation)
