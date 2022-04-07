Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A764F8A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiDGU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiDGU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:59:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B14915D146
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:57:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so6742059pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CKYV2+BOeygabDWWYM3k9yKXDg5LNdMlEhRMDocH4vM=;
        b=sNy6P7Z9PPHEij16rq25DMXRwWaR2YxbobbeZTREOTz9H+CGo4KgEu4tsp0tLJ5mJX
         HOOe7KTzWrfYIe6ijUGgF1mYdtKnNW+rsuwI4s853Bh4FXJhg1GXGaHgLGSqImjp6eSg
         KH1jSYJqfZeXjkYiRZWh/eqszpyJb4205humllhG91AdZ0uxdIYm745L6u+E75Vclm/k
         9T81FE3LAb++gmSk0L4l91wcFkuUnAWubkZKwyofZlSqXLuS+ImqfQULAwHKrL73tep/
         5hf3UwrI2bqmA6qtpgpBJvMSrdVl+hdRoifVaNNnWnecOCzz/C/2dB+ZhLlq9H/uTnBX
         XtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CKYV2+BOeygabDWWYM3k9yKXDg5LNdMlEhRMDocH4vM=;
        b=f/jSKuyVaHHLqU637pFd+eNM9v4b1j+NHfBweVLTOetSJlnokohLfeA+pEyAeZAGlM
         j/YtllGKNVLe+utApzeqF6SV4rScpiYSBvt7BIc4qFqjFGF8TrLiQyqj9oUjD6IJ9GDm
         lBtB/vflbojbf6xxYUn+N+FeY1+po7U1/rLHqvxZQqtKSwy7nkdOTZgezymAxUuM/M6b
         FoCT/ySUlSS2qAjfu0oiSetyj3SBFMr7XnfrQQKjdfXBPMyQZDvjIoKZcVkilBUsT8iY
         7P1XCVFaAdqWuQ3x8bKk23vhn05qD1YZTjyU1KoOJpNP1H/OT3saxYIQheJ8T0eJ1PWN
         dDWA==
X-Gm-Message-State: AOAM531P/l6mgxDEWKfboyvIuE9LDXgAfnprVwPNC+eJnqb9R102NUnp
        D8bkGfQCHSq4AOX86lPpWGeVdw==
X-Google-Smtp-Source: ABdhPJwiLuFOp9QQv0Cr0pBDuRj68HPy20U93X0oj9/Qcu8kU7dTRL62dOEwPehpd8r+byA7KS9KQA==
X-Received: by 2002:a17:90a:b903:b0:1ca:be37:1d41 with SMTP id p3-20020a17090ab90300b001cabe371d41mr18127082pjr.9.1649365056380;
        Thu, 07 Apr 2022 13:57:36 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:ca7d:71e3:d0a7:79b7])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm10218686pjb.30.2022.04.07.13.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:57:34 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH 1/2] sched/fair: Fix cfs_rq_clock_pelt() for throttled
 cfs_rq
References: <20220407021729.16655-1-zhouchengming@bytedance.com>
Date:   Thu, 07 Apr 2022 13:57:26 -0700
In-Reply-To: <20220407021729.16655-1-zhouchengming@bytedance.com> (Chengming
        Zhou's message of "Thu, 7 Apr 2022 10:17:28 +0800")
Message-ID: <xm26tub4vcg9.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chengming Zhou <zhouchengming@bytedance.com> writes:

> Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
> change to use rq_clock_pelt() instead of rq_clock_task(), we should also
> use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
> accounting.

I think this patch is indeed what we want, despite the confusing
interactions between pelt slowdown+skipping and throttle_clock_task
trying to freeze time.

I think it would be slightly better to rename
throttled_clock_task(_time) to be clock_pelt rather than clock_task, but
that's minor.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..e6fa5d1141b4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4846,7 +4846,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>  
>  	cfs_rq->throttle_count--;
>  	if (!cfs_rq->throttle_count) {
> -		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
> +		cfs_rq->throttled_clock_task_time += rq_clock_pelt(rq) -
>  					     cfs_rq->throttled_clock_task;
>  
>  		/* Add cfs_rq with load or one or more already running entities to the list */
> @@ -4864,7 +4864,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>  
>  	/* group is entering throttled state, stop time */
>  	if (!cfs_rq->throttle_count) {
> -		cfs_rq->throttled_clock_task = rq_clock_task(rq);
> +		cfs_rq->throttled_clock_task = rq_clock_pelt(rq);
>  		list_del_leaf_cfs_rq(cfs_rq);
>  	}
>  	cfs_rq->throttle_count++;
> @@ -5308,7 +5308,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
>  	pcfs_rq = tg->parent->cfs_rq[cpu];
>  
>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
> -	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
> +	cfs_rq->throttled_clock_task = rq_clock_pelt(cpu_rq(cpu));
>  }
>  
>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
