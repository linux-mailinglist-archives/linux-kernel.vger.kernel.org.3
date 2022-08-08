Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBF58CAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbiHHO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbiHHO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:57:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475BDB1F6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 13so7362465plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xgqexFqNfWEI+vjZmxBXO3+TInw86fqMbwNyn542u8I=;
        b=P3gxdnZNWJdVmBjp4eV03crxJ18dSpDU/aLVgSbmNM8Tupilkpyzu9uSGyQJs/k16w
         7yMoHrtB0VmXA3bdSgMkiunX/fbjRrMyKFw7FEdIE3G0I47i2zXvAZm79w178CxSd0cy
         91D9oFeZVqd4Lpmkg3qnSsRoB+bVB3BGiFsS+A7RTdSES/aGB8WGz0pToofcFE9dEjF6
         sxtl35HMxEjK0HgDMAKmcHsKKyuCWXSAgwoBF6GrhfhozGCK2kf4953g5pSGIJp9+fTP
         JCey2ob3ENOfDyZMOeFhwRrm10o82aTsEO/RGkF5xaNGAwfWJ3YJD4X731/HYbWaUK/o
         BfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xgqexFqNfWEI+vjZmxBXO3+TInw86fqMbwNyn542u8I=;
        b=dnaaCOi4QJgOt2T7ULr5Copl1Yk2mNEMnmd6lniOZl/OycozVgwUD68NJRGKJykGEN
         OdPvTev0Q+jU5FhJb9JqkdrbafWPRSW2OFXHTQbohN0FHW+7XslQqpY/fCc2886eAZej
         F8Al7guCWMb1EMECRU0o/FBfU3MBLbHpK71PhQJVX0bl5zp4AKr5II4Nr9ybI9EhtYol
         18OiGHY3QNKwBvHIclQkDXIeBRdoykLdglAP29Lh6DuygMVhiKTXbag9bla1RjFwg2BT
         od+hBnRlIogF0B5o+YP354fw3dUOtky8CBo4JgBsF/iWZtA/+OvCd7F1L3BklmZpgz+d
         4IJA==
X-Gm-Message-State: ACgBeo36+fdj8FHL6Yi1yuYEsaDMnYO2+oATkQ4YrdO712/RTpgyw7TW
        u4YUzUlZC/NiW/2S0P0QrglYvg==
X-Google-Smtp-Source: AA6agR4BUfTZhyPXZwWUu79DD/Wzc9VniGVmZerobhOxABOMPLIfM6QawSyrqLdAHep8X0F4GWk8og==
X-Received: by 2002:a17:90a:a401:b0:1f2:19a0:2874 with SMTP id y1-20020a17090aa40100b001f219a02874mr29683232pjp.146.1659970649774;
        Mon, 08 Aug 2022 07:57:29 -0700 (PDT)
Received: from [10.254.250.112] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0016cb873fe6fsm8926179plg.183.2022.08.08.07.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 07:57:29 -0700 (PDT)
Message-ID: <616ed01f-3c4d-6c50-f5b7-096676dd9d1f@bytedance.com>
Date:   Mon, 8 Aug 2022 22:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v4 7/9] sched/fair: allow changing cgroup of new forked
 task
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
 <20220808125745.22566-8-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220808125745.22566-8-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/8 20:57, Chengming Zhou wrote:
> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
> introduce a TASK_NEW state and an unnessary limitation that would fail
> when changing cgroup of new forked task.
> 
> Because at that time, we can't handle task_change_group_fair() for new
> forked fair task which hasn't been woken up by wake_up_new_task(),
> which will cause detach on an unattached task sched_avg problem.
> 
> This patch delete this unnessary limitation by adding check before do
> detach or attach in task_change_group_fair().
> 
> So cpu_cgrp_subsys.can_attach() has nothing to do for fair tasks,
> only define it in #ifdef CONFIG_RT_GROUP_SCHED.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  include/linux/sched.h |  5 ++---
>  kernel/sched/core.c   | 30 +++++++-----------------------
>  kernel/sched/fair.c   |  7 +++++++
>  3 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 88b8817b827d..b504e55bbf7a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -95,10 +95,9 @@ struct task_group;
>  #define TASK_WAKEKILL			0x0100
>  #define TASK_WAKING			0x0200
>  #define TASK_NOLOAD			0x0400
> -#define TASK_NEW			0x0800
>  /* RT specific auxilliary flag to mark RT lock waiters */
> -#define TASK_RTLOCK_WAIT		0x1000
> -#define TASK_STATE_MAX			0x2000
> +#define TASK_RTLOCK_WAIT		0x0800
> +#define TASK_STATE_MAX			0x1000
>  
>  /* Convenience macros for the sake of set_current_state: */
>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e74e79f783af..d5faa1700bd7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4500,11 +4500,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  {
>  	__sched_fork(clone_flags, p);
>  	/*
> -	 * We mark the process as NEW here. This guarantees that
> +	 * We mark the process as running here. This guarantees that
>  	 * nobody will actually run it, and a signal or other external
>  	 * event cannot wake it up and insert it on the runqueue either.
>  	 */
> -	p->__state = TASK_NEW;
> +	p->__state = TASK_RUNNING;
>  
>  	/*
>  	 * Make sure we do not leak PI boosting priority to the child.
> @@ -4622,7 +4622,6 @@ void wake_up_new_task(struct task_struct *p)
>  	struct rq *rq;
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> -	WRITE_ONCE(p->__state, TASK_RUNNING);
>  #ifdef CONFIG_SMP
>  	/*
>  	 * Fork balancing, do it here and not earlier because:
> @@ -10238,36 +10237,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>  	sched_unregister_group(tg);
>  }
>  
> +#ifdef CONFIG_RT_GROUP_SCHED
>  static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>  {
>  	struct task_struct *task;
>  	struct cgroup_subsys_state *css;
> -	int ret = 0;
>  
>  	cgroup_taskset_for_each(task, css, tset) {
> -#ifdef CONFIG_RT_GROUP_SCHED
>  		if (!sched_rt_can_attach(css_tg(css), task))
>  			return -EINVAL;
> -#endif
> -		/*
> -		 * Serialize against wake_up_new_task() such that if it's
> -		 * running, we're sure to observe its full state.
> -		 */
> -		raw_spin_lock_irq(&task->pi_lock);
> -		/*
> -		 * Avoid calling sched_move_task() before wake_up_new_task()
> -		 * has happened. This would lead to problems with PELT, due to
> -		 * move wanting to detach+attach while we're not attached yet.
> -		 */
> -		if (READ_ONCE(task->__state) == TASK_NEW)
> -			ret = -EINVAL;
> -		raw_spin_unlock_irq(&task->pi_lock);
> -
> -		if (ret)
> -			break;
>  	}
> -	return ret;
> +	return 0;
>  }
> +#endif
>  
>  static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>  {
> @@ -11103,7 +11085,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
>  	.css_released	= cpu_cgroup_css_released,
>  	.css_free	= cpu_cgroup_css_free,
>  	.css_extra_stat_show = cpu_extra_stat_show,
> +#ifdef CONFIG_RT_GROUP_SCHED
>  	.can_attach	= cpu_cgroup_can_attach,
> +#endif
>  	.attach		= cpu_cgroup_attach,
>  	.legacy_cftypes	= cpu_legacy_files,
>  	.dfl_cftypes	= cpu_files,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4bc76d95a99d..90aba33a3780 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11669,6 +11669,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static void task_change_group_fair(struct task_struct *p)
>  {
> +	/*
> +	 * We couldn't detach or attach a forked task which
> +	 * hasn't been woken up by wake_up_new_task().
> +	 */
> +	if (!p->on_rq && !se->sum_exec_runtime)

should be: if (!p->on_rq && !p->se.sum_exec_runtime)
sorry for my carelessness...


> +		return;
> +
>  	detach_task_cfs_rq(p);
>  
>  #ifdef CONFIG_SMP
