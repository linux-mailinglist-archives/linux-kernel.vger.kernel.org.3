Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F855CE10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbiF1MdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbiF1MdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:33:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2274DB2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:33:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so7030537pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dRkS9IzlKKjtIu786n+JWYXVfoXO0pQEumBnE4TFCOU=;
        b=YpgC7Ch/GB45GgZ62fT3kM966NOgnBtdEmNHFHobihqhhxkMOP0nXZJVX8ERzvPXcQ
         s42kHhozS1i98t6jf+T8JfuDnNfzz0ew0uqsDEJWRwiyaUhwgVRwxrfm78CtHNLpEgV8
         c6UfQqnTzWo9jxb4OKEWx0CxA1+IpGiqsoyggjoQ1qAOMENsK17XzSHz9iCjGE84FAmf
         Ha3OzFbowRJgAaUA+lwWznoSg2f/inXjaUcYJRlUfaHkqcV7lzoMuk4yMcL1fUXCZ4Dj
         pwt7lljQb0KQ9YjjVqtGAA2789cn89r6IcGce+lKvprkhe8y3nhQB/OGLr3sXL/n85s7
         FcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dRkS9IzlKKjtIu786n+JWYXVfoXO0pQEumBnE4TFCOU=;
        b=720nncO13ei7KpPV8IU+t3aKKCcYeNIZOPYoXcQHSWiz4MN0w1476/99EqiGpoKLKV
         6K1tRVdCIEsbzD78Eqov5Q1sGLifxMp2MV10HQJpg1caCds2+N8vBJXPqrtGMUY2IIFQ
         7vb+bnK+L7bg47drEDWSfarws5xkSaGK241q9dLDVolPw4IAAbM6Fu7nWcZbAqgk0qrT
         5sgQEJ9vhdqqs4j+saRGKD0dbDyf6CNzBrUNmPW/OZivwxSRH71aCDQvwQcKANhbNuX3
         W/feNpU5eqW3yHg5klMHjtiDA7cTmIdd8YiBcCU9U/ybclbhAn17D5NbTY8hMMb3sAQa
         yDLg==
X-Gm-Message-State: AJIora9e2crIl4prEmLQY6m5/jZc4GWlPb3IUF/FPSVNYGKvjzEZWCoC
        p7/ZhEiS2Avc9t3XA0yFc+O1Uw==
X-Google-Smtp-Source: AGRyM1uX59w57jR9aBgu/NrJdx1+TzBIpfcDr1legfgu5ZHzPZHwjdU02GQQC0Fbb71Uv+aTYPtPIw==
X-Received: by 2002:a17:90b:1d06:b0:1ec:cd94:539b with SMTP id on6-20020a17090b1d0600b001eccd94539bmr21206358pjb.215.1656419581577;
        Tue, 28 Jun 2022 05:33:01 -0700 (PDT)
Received: from [10.255.246.56] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id bh2-20020a056a02020200b0040d2aea1643sm8992742pgb.29.2022.06.28.05.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:33:00 -0700 (PDT)
Message-ID: <b1addf39-d272-322b-ed4e-79328b51f5af@bytedance.com>
Date:   Tue, 28 Jun 2022 20:32:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4] sched/fair: combine detach into dequeue when migrating
 task
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220620133608.78498-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220620133608.78498-1-zhouchengming@bytedance.com>
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

Hello, friendly ping...

Thanks.

On 2022/6/20 21:36, Chengming Zhou wrote:
> When we are migrating task out of the CPU, we can combine detach and
> propagation into dequeue_entity() to save the detach_entity_cfs_rq()
> -> propagate_entity_cfs_rq() call in detach_entity_cfs_rq() in
> migrate_task_rq_fair().
> 
> This optimization is like combining DO_ATTACH in the enqueue_entity()
> when migrating task to the CPU.
> 
> So we don't have to traverse the CFS tree extra time to do the
> detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, which
> wouldn't be called anymore with this patch's change.
> 
> Copied from Dietmar's much clearer comment:
> 
> detach_task()
>   deactivate_task()
>     dequeue_task_fair()
>       for_each_sched_entity(se)
>         dequeue_entity()
>           update_load_avg() /* (1) */
> 
>   set_task_cpu()
>     migrate_task_rq_fair()
>       /* called detach_entity_cfs_rq() before the patch (2) */
> 
> This patch save the propagate_entity_cfs_rq(&p->se) call from (2)
> by doing the detach_entity_load_avg(), update_tg_load_avg() for
> a migrating task inside (1) (the task being the first se in the loop)
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v4:
>  - change the commit message a little.
>  - remove the forward declaration of detach_entity_cfs_rq()
>  - remove verbose comments in code.
> 
> v3:
>  - change to use task_on_rq_migrating() and put Dietmar's much clearer
>    description in the commit message. Thanks!
> 
> v2:
>  - fix !CONFIG_SMP build error
> ---
>  kernel/sched/fair.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8bed75757e65..31d53c11e244 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3931,6 +3931,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  #define UPDATE_TG	0x1
>  #define SKIP_AGE_LOAD	0x2
>  #define DO_ATTACH	0x4
> +#define DO_DETACH	0x8
>  
>  /* Update task and its cfs_rq load average */
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> @@ -3948,7 +3949,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
>  	decayed |= propagate_entity_load_avg(se);
>  
> -	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> +	if (flags & DO_DETACH) {
> +		/*
> +		 * DO_DETACH means we're here from dequeue_entity()
> +		 * and we are migrating task out of the CPU.
> +		 */
> +		detach_entity_load_avg(cfs_rq, se);
> +		update_tg_load_avg(cfs_rq);
> +	} else if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>  
>  		/*
>  		 * DO_ATTACH means we're here from enqueue_entity().
> @@ -4241,6 +4249,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  #define UPDATE_TG	0x0
>  #define SKIP_AGE_LOAD	0x0
>  #define DO_ATTACH	0x0
> +#define DO_DETACH	0x0
>  
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> @@ -4460,6 +4469,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  static void
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> +	int action = UPDATE_TG;
> +
> +	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> +		action |= DO_DETACH;
> +
>  	/*
>  	 * Update run-time statistics of the 'current'.
>  	 */
> @@ -4473,7 +4487,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 *   - For group entity, update its weight to reflect the new share
>  	 *     of its group cfs_rq.
>  	 */
> -	update_load_avg(cfs_rq, se, UPDATE_TG);
> +	update_load_avg(cfs_rq, se, action);
>  	se_update_runnable(se);
>  
>  	update_stats_dequeue_fair(cfs_rq, se, flags);
> @@ -6938,8 +6952,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	return new_cpu;
>  }
>  
> -static void detach_entity_cfs_rq(struct sched_entity *se);
> -
>  /*
>   * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
>   * cfs_rq_of(p) references at time of call are still valid and identify the
> @@ -6973,15 +6985,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		se->vruntime -= min_vruntime;
>  	}
>  
> -	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> -		/*
> -		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
> -		 * rq->lock and can modify state directly.
> -		 */
> -		lockdep_assert_rq_held(task_rq(p));
> -		detach_entity_cfs_rq(&p->se);
> -
> -	} else {
> +	if (!task_on_rq_migrating(p)) {
>  		/*
>  		 * We are supposed to update the task to "current" time, then
>  		 * its up to date and ready to go to new CPU/cfs_rq. But we
