Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7656BB47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiGHNyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiGHNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:54:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328ADB12;
        Fri,  8 Jul 2022 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KdpxrMXT2mCsDT4flLvoU9tUZBZs1h2+IEZln4wT0ls=; b=UXKO4evhThTvqEZFqMyNNOIb8H
        mhXcsLgaN+WdoU1oJEetE2SikVVvSroh0TQxpH9DWF3Bz8xwfVtrl0T2Cxgep8TAU1Ya0DMeBJw3q
        kuCprBGoFdkaPxztHNZbnGRyoSKCDrtk6BKYIv0Ywz2oVU7zowvLk4oooVgdf+KsLRdl42kynS6DI
        TKww+KiVwIhJVguForf8faxNWHRz6CeJ8eiA/DGI4+bKhOvePssn47Ve3bvDNn9JRAUPfIWIkWNeE
        LmmES4H3UfrvsnD5DqQ/hN5U7cfSe88NwPOLHnaTm6hOmSg4ctVjQOkTUNJnXJtOpX33ja6S74hbY
        FcqZTd+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9oQJ-001kdl-7g; Fri, 08 Jul 2022 13:53:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8546998007C; Fri,  8 Jul 2022 15:53:34 +0200 (CEST)
Date:   Fri, 8 Jul 2022 15:53:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Keeping <john@metanate.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] sched/core: Always flush pending blk_plug
Message-ID: <Ysg23mJmFiBc/eA1@worktop.programming.kicks-ass.net>
References: <20220708093213.1635880-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708093213.1635880-1-john@metanate.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 10:32:12AM +0100, John Keeping wrote:

> It seems that the intent here is to skip blk_flush_plug() in the case
> where a non-preemptible lock (such as a spinlock) has been converted to
> a rtmutex on RT, which is the case covered by the SM_RTLOCK_WAIT
> schedule flag.  But sched_submit_work() is only called from schedule()
> which is never called in this scenario, so the check can simply be
> deleted.

>  include/linux/sched/rt.h | 8 --------
>  kernel/sched/core.c      | 3 ---
>  2 files changed, 11 deletions(-)
> 
> diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> index e5af028c08b49..994c25640e156 100644
> --- a/include/linux/sched/rt.h
> +++ b/include/linux/sched/rt.h
> @@ -39,20 +39,12 @@ static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *p)
>  }
>  extern void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task);
>  extern void rt_mutex_adjust_pi(struct task_struct *p);
> -static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
> -{
> -	return tsk->pi_blocked_on != NULL;
> -}
>  #else
>  static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
>  {
>  	return NULL;
>  }
>  # define rt_mutex_adjust_pi(p)		do { } while (0)
> -static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
> -{
> -	return false;
> -}
>  #endif
>  
>  extern void normalize_rt_tasks(void);

Excellent, glad to see the back of that.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1d4660a1915b3..e4974fe003b5b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6578,9 +6578,6 @@ static inline void sched_submit_work(struct task_struct *tsk)
>  			io_wq_worker_sleeping(tsk);
>  	}
>  
> -	if (tsk_is_pi_blocked(tsk))
> -		return;
> -

Would it make sense to replace this with:

	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);

Along with a comment along the lines of:

>    - spinlock and rwlock must not flush block requests. This will deadlock
>      if the callback attempts to acquire a lock which is already acquired.
>      Similarly to being preempted, there should be no warning if the
>      scheduling point is within a RCU read section.
