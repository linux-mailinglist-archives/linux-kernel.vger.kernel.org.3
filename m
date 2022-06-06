Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB653E7E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiFFKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiFFKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 929FB21265
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654511950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekyQXqLwxIXfCRwgaKQzIzTuvcOtNcZ3TaO9dqLv8oI=;
        b=EhsEdAXofGKzmtLiZVX5vc9e9IVkdQT+Gf2ipgfNWrcHiJUnyXGz7Hecr/eyp55OS9+fEY
        /kdjRhq3/bWGYVtAUw85s46oSxbl2k8C9+vBPRbNfzb5U51tvDeLQqupovG2MyZ+eZ1UUU
        bvBkCb+5LBe1IhVWujz1okw/gV100BE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-VG2vqLzlOAKaNIIZm29UaA-1; Mon, 06 Jun 2022 06:39:09 -0400
X-MC-Unique: VG2vqLzlOAKaNIIZm29UaA-1
Received: by mail-wr1-f72.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso2676100wrw.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ekyQXqLwxIXfCRwgaKQzIzTuvcOtNcZ3TaO9dqLv8oI=;
        b=Lv9MfISDy359m1tXk7qkK6ZxSktgSMSJ97EKhGJpSvwaPi+QN8rXZIiYDjefd1HsAt
         eHZk7WJlRBU/sWgn2td2VlmO5JiSo9Z0vyUUesgVGPknwZvuDs45Ks3kb1kbZ0P92PE6
         83P5JY16h3jaTNVKwvNeT7fyfmVCLB36tQyLjmXvA15YYl5X3cyGGLh/+Vuv3wlmkaXr
         pSR1u4cDuXFffauuDAbTq8hykQGhWV6sYgW0w3dn1dnQT+EwA/M/4/xTHd4zQHFBgIDC
         CxuMhSkeuYNRKCMDrKkvw65kbFR7WEW5uYExP2xPR8BEsz0Sr0h/vklojYeCPjKttjq5
         //SA==
X-Gm-Message-State: AOAM532/9LpszH/wsYjEm5crCoLjKqTdFQFR7YUC8cbqiL90xx0O4fiO
        IDtusZfhIbA9WkXQ3ZBQXZXNm+UfpZBt3Xi96plXim7H7ulTDKOH/E5SlL6SJ6ZUwTSTCc+lLs6
        zCRAjkhxip5ilbRKph1ZqMxIkcVnEycQd6b7CC2Jj+j/lAyc/ireRe0lGDtqE4gST8VW4eD/B+q
        bc
X-Received: by 2002:a05:600c:3513:b0:39c:2a32:37a6 with SMTP id h19-20020a05600c351300b0039c2a3237a6mr20749063wmq.161.1654511948046;
        Mon, 06 Jun 2022 03:39:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztJnOdvnaqf6MN+SeYynQ8CzWQpdQSIe+sd60X2Gn1H5ppjHeOs3PAyRJivA8btAUsGGwTUQ==
X-Received: by 2002:a05:600c:3513:b0:39c:2a32:37a6 with SMTP id h19-20020a05600c351300b0039c2a3237a6mr20749037wmq.161.1654511947728;
        Mon, 06 Jun 2022 03:39:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id e16-20020adffc50000000b0020fdc90aeabsm14832433wrs.82.2022.06.06.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:39:07 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched: Remove the limitation of WF_ON_CPU on
 wakelist if wakee cpu is idle
In-Reply-To: <20220602040645.275555-3-dtcccc@linux.alibaba.com>
References: <20220602040645.275555-1-dtcccc@linux.alibaba.com>
 <20220602040645.275555-3-dtcccc@linux.alibaba.com>
Date:   Mon, 06 Jun 2022 11:39:06 +0100
Message-ID: <xhsmh35gi84ad.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/22 12:06, Tianchen Ding wrote:

> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Minor nits below, otherwise:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/sched/core.c  | 27 ++++++++++++++++-----------
>  kernel/sched/sched.h |  1 -
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a9efe134fbe5..ccb9e0fbf49b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3808,7 +3808,7 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
>  	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
>  }
>  
> -static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> +static inline bool ttwu_queue_cond(int cpu)
>  {
>  	/*
>  	 * Do not complicate things with the async wake_list while the CPU is
> @@ -3824,13 +3824,21 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  	if (!cpus_share_cache(smp_processor_id(), cpu))
>  		return true;
>  
> +	if (cpu == smp_processor_id())
> +		return false;
> +
>  	/*
> -	 * If the task is descheduling and the only running task on the
> -	 * CPU then use the wakelist to offload the task activation to
> -	 * the soon-to-be-idle CPU as the current CPU is likely busy.
> -	 * nr_running is checked to avoid unnecessary task stacking.
> +	 * If the wakee cpu is idle, or the task is descheduling and the
> +	 * only running task on the CPU, then use the wakelist to offload
> +	 * the task activation to the idle (or soon-to-be-idle) CPU as
> +	 * the current CPU is likely busy. nr_running is checked to
> +	 * avoid unnecessary task stacking.
> +	 *

> +	 * Note that we can only get here with (wakee) p->on_rq=0,
> +	 * p->on_cpu can be whatever, we've done the dequeue, so
> +	 * the wakee has been accounted out of ->nr_running.

If you want to include it, that comment should be added in patch 1 rather
than in patch 2.

>  	 */
> -	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
> +	if (!cpu_rq(cpu)->nr_running)
>  		return true;
>  
>  	return false;
> @@ -3838,10 +3846,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  
>  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
> -	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
> -		if (WARN_ON_ONCE(cpu == smp_processor_id()))
> -			return false;
> -
> +	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu)) {
>  		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>  		__ttwu_queue_wakelist(p, cpu, wake_flags);
>  		return true;
> @@ -4163,7 +4168,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * scheduling.
>  	 */
>  	if (smp_load_acquire(&p->on_cpu) &&
> -	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
> +	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
>  		goto unlock;
>  
>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 01259611beb9..1e34bb4527fd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2039,7 +2039,6 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>  
>  #define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
>  #define WF_MIGRATED 0x20 /* Internal use, task got migrated */
> -#define WF_ON_CPU   0x40 /* Wakee is on_cpu */

There still is a reference to WF_ON_CPU in a comment in prepare_task(),
maybe change that one to "smp_load_acquire(&p->on_cpu)".

>  
>  #ifdef CONFIG_SMP
>  static_assert(WF_EXEC == SD_BALANCE_EXEC);
> -- 
> 2.27.0

