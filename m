Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA56E49E7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbiA0Qfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiA0Qfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:35:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA26C061714;
        Thu, 27 Jan 2022 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t/MCe4N7Ko6is9DLB7uPGMJ/tYaOgslIsh77bZ85QzU=; b=pzgmDHJPfnOclTpFQU6PM7WHhS
        SUsJNzZTuhvkvo3z27n5iqlhd975F9rMLJaopHIZKJez/FChf7KM/zQOtSJdyZGTegGNQNsfswHje
        MEGDkb3uy+WqvrGjvC4GBwnD69G2eLmvBh5Q0uyazG7jt9lq3/oGRsoOQveG4F44of14B4yyHuT+z
        oSbGYyvlQhTnZuCTg2CjOPpqbAmoMZJwdrkOixGLuvLWM2mnwwbV/IJUvkJj7FwY68dh0Wi6eqafY
        qQug+QiAKvXjq4f7SH2EQiv4Dh3GTAL1dh4oPKQCSDdyWXuuQNjMp4k6b0UK/bMG0uR7+6v3dFXCn
        k1SBUSuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD7jt-005QJL-E4; Thu, 27 Jan 2022 16:35:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6891986245; Thu, 27 Jan 2022 17:35:12 +0100 (CET)
Date:   Thu, 27 Jan 2022 17:35:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC PATCH v2 5/5] sched: UMCG: allow to sys_umcg_kick UMCG
 servers
Message-ID: <20220127163512.GR20638@worktop.programming.kicks-ass.net>
References: <20220113233940.3608440-1-posk@google.com>
 <20220113233940.3608440-6-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113233940.3608440-6-posk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:39:40PM -0800, Peter Oskolkov wrote:
> ---
>  include/uapi/linux/umcg.h | 10 ++++++++++
>  kernel/sched/umcg.c       |  7 +++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
> index 93fccb44283b..a29e5e91a251 100644
> --- a/include/uapi/linux/umcg.h
> +++ b/include/uapi/linux/umcg.h
> @@ -148,4 +148,14 @@ enum umcg_ctl_flag {
>  	UMCG_CTL_WORKER		= 0x10000,
>  };
>  
> +/**
> + * enum umcg_kick_flag - flags to pass to sys_umcg_kick
> + * @UMCG_KICK_RESCHED: reschedule the task; used for worker preemption
> + * @UMCG_KICK_TTWU: wake the task; used to wake servers
> + */
> +enum umcg_kick_flag {
> +	UMCG_KICK_RESCHED	= 0x001,
> +	UMCG_KICK_TTWU		= 0x002,
> +};
> +
>  #endif /* _UAPI_LINUX_UMCG_H */
> diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
> index b85dec6b82e4..e33ec9eddc3e 100644
> --- a/kernel/sched/umcg.c
> +++ b/kernel/sched/umcg.c
> @@ -669,12 +669,15 @@ SYSCALL_DEFINE2(umcg_kick, u32, flags, pid_t, tid)
>  	if (!task)
>  		return -ESRCH;
>  
> -	if (flags)
> +	if (flags != UMCG_KICK_RESCHED && flags != UMCG_KICK_TTWU)
>  		return -EINVAL;
>  
>  #ifdef CONFIG_SMP
> -	smp_send_reschedule(task_cpu(task));
> +	if (flags == UMCG_KICK_RESCHED)
> +		smp_send_reschedule(task_cpu(task));
>  #endif
> +	if (flags == UMCG_KICK_TTWU)
> +		try_to_wake_up(task, TASK_NORMAL, 0);
>  
>  	return 0;
>  }

I'm thinking the simpler thing is this..
(also note the task ref leak fixed)

--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -719,16 +719,22 @@ void umcg_notify_resume(struct pt_regs *
  */
 SYSCALL_DEFINE2(umcg_kick, u32, flags, pid_t, tid)
 {
-	struct task_struct *task = umcg_get_task(tid);
-	if (!task)
-		return -ESRCH;
+	struct task_struct *task;
 
 	if (flags)
 		return -EINVAL;
+       
+	task = umcg_get_task(tid);
+	if (!task)
+		return -ESRCH;
 
+	if (!try_to_wake_up(task, TASK_NORMAL, WF_CURRENT_CPU)) {
 #ifdef CONFIG_SMP
-	smp_send_reschedule(task_cpu(task));
+		smp_send_reschedule(task_cpu(task));
 #endif
+	}
+
+	put_task_struct(task);
 
 	return 0;
 }
