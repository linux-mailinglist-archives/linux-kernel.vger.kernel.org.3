Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE35735E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiGMMAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiGMMAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:00:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6EF5114
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:00:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s21so11656608pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=OnXt52/Zp2ft6yRsPQtGQKdmFR+mM5FPT8XBS7HJCCE=;
        b=jt2qxK6K7RpYaFKuLqExwmk4dp2M1rU7vWp2h9+Ag8gjWOek21MXE1SS59CMcyeD2D
         PrMsUTdyOZGUicIFNp9a68jANV/qF66kXNQa/1Ltanvr3Vdl3liHHD3d6+J7obK7m44q
         WdJ6oNiMyHoJVzTqcKocLTcWOCgbk/gHWvh10iRXl3noXmIRk7w7l59gxpxmkEzzOo+S
         xSqMuwRV4/GeG6qQitDKMxgjWSnclcojbQHPus3QORDvoNP5P16rfGlTDvyqqhXfaQlq
         9ivRelko48xfz53G90MTRqv0kgQxqjiF5JLf/fQ9lZpjLp47SoQgT8bBfacdjpyRZ9I6
         aAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=OnXt52/Zp2ft6yRsPQtGQKdmFR+mM5FPT8XBS7HJCCE=;
        b=X8mnM80o5Z/eipr6pY+qx4mE4TTFCjZq8HDQ5QQQb2fLrhSW0QI6RDE7mkJSVdlvoq
         aknAQXCILp4lsQnmWMMtl/leZzGhdAU9zAukv14J4cUwR6Yz3Fbxtz0ZRXq/LXLXuVcy
         00TmDNbXkCf6YliwPQUWD7ioEDceOnt2OXPt8ENk37piJXb1OgzKziij1c/g2LHvLOMi
         xa4JONmaSAKGOzYnVK+JY9s06o+hqCIYYCyXaEtNRfKWmqXMOQDZoMyh5Za21uRT3s4R
         M6y4B8NbM5TJxnokbusKrZzpv25Ql9ThIES5x87HJnz8hzf/WRQrlEDomJIqn7R+28ZO
         Oe6w==
X-Gm-Message-State: AJIora8PqvrpIRbR84WN5fcVxrnxz9f+LR+fatOTU12X+P6MmohU0IkN
        IRi3oLfuK2Yenz6qgfLPzzR8jrOLXRCmGQ==
X-Google-Smtp-Source: AGRyM1uNphEJ93H5zZO964IdBpWdVH2jHHra+7zFZ5yJEFhkRY53P6l2ZRvXu5ftyV2No8AXZLWjZw==
X-Received: by 2002:a17:90b:a05:b0:1ef:8f7c:6343 with SMTP id gg5-20020a17090b0a0500b001ef8f7c6343mr9992901pjb.241.1657713601956;
        Wed, 13 Jul 2022 05:00:01 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b0016c6e360ff2sm1575692plg.132.2022.07.13.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:00:01 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Date:   Wed, 13 Jul 2022 19:22:06 +0800
In-reply-to: <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
Message-ID: <m2y1wxi5qh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lai Jiangshan <jiangshanlai@gmail.com> writes:

> CC Peter.
> Peter has changed the CPU binding code in workqueue.c.
>
> I'm not understanding the problem enough, if kthread_bind_mask() is buggy
> in workqueue.c, it would be buggy in other places too.
>

It's not the bug of to use kthread_bind_mask(), other than we set the
bad pool->attrs->cpumask to this kthread.

>
> On 2022/7/7 17:05, Schspa Shi wrote:
>
>>   -	if (worker->rescue_wq)
>> -		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>> +	if (worker->rescue_wq) {
>> +		if (pool->flags & POOL_DISASSOCIATED)
>> +			set_cpus_allowed_ptr(worker->task, cpu_active_mask);
>> +		else
>> +			set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>> +	}
>>   
>
> For unbound pools (which also has POOL_DISASSOCIATED), pool->attrs->cpumask
> should be used if pool->attrs->cpumask has active cpu.
>

In this case pool->attrs->cpumask have no active cpu, the cpu for this
pool have offlined already.

The bug will occurs when the cpu have called the workqueue_offline_cpu
form cpu unplug, and create a new worker which will running on a offline
cpu.

>
>> +
>> +	mutex_lock(&wq_pool_attach_mutex);
>> +	if ((pool->flags & POOL_DISASSOCIATED)) {
>> +		/* We can't call get_online_cpus, there will be deadlock
>> +		 * cpu_active_mask will no change, because we have
>> +		 * wq_pool_attach_mutex hold.
>> +		 **/
>> +		kthread_bind_mask(worker->task, cpu_active_mask);
>> +	} else {
>> +		kthread_bind_mask(worker->task, pool->attrs->cpumask);
>> +	}
>> +	mutex_unlock(&wq_pool_attach_mutex);
>
>
> For unbound pools, pool->attrs->cpumask should be used if pool->attrs->cpumask
> has active cpu.
>
> wq_pool_attach_mutex is held here and in worker_attach_to_pool() which smells bad.
>

Yes, this will be changed, I have make a new patch , to move the
thread bind to worker_attach_to_pool, via set_cpus_allowed_ptr.

>
>
> The change is complex.  And if kthread_bind_mask() can't work as expected here,
> the change I prefer would be:
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 4056f2a3f9d5..1ad8aef5fe98 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1862,6 +1862,12 @@ static void worker_attach_to_pool(struct worker *worker,
>  {
>  	mutex_lock(&wq_pool_attach_mutex);
>
> +	/*
> +	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> +	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> +	 */
> +	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +

This will succeed in this case, set_cpus_allowed_ptr will use
cpu_online_mask to verify the cpumask is valid, but in this case,
the cpu_state is between cpu_online and cpu_active. And this
modification doesn't solve the problem I'm having.

>  	/*
>  	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>  	 * stable across this function.  See the comments above the flag
> @@ -1872,9 +1877,6 @@ static void worker_attach_to_pool(struct worker *worker,
>  	else
>  		kthread_set_per_cpu(worker->task, pool->cpu);
>
> -	if (worker->rescue_wq)
> -		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> -
>  	list_add_tail(&worker->node, &pool->workers);
>  	worker->pool = pool;
>
> @@ -1952,7 +1954,7 @@ static struct worker *create_worker(struct worker_pool *pool)
>  		goto fail;
>
>  	set_user_nice(worker->task, pool->attrs->nice);
> -	kthread_bind_mask(worker->task, pool->attrs->cpumask);
> +	worker->flags |= PF_NO_SETAFFINITY;
>
>  	/* successful, attach the worker to the pool */
>  	worker_attach_to_pool(worker, pool);
> @@ -4270,7 +4272,7 @@ static int init_rescuer(struct workqueue_struct *wq)
>  	}
>
>  	wq->rescuer = rescuer;
> -	kthread_bind_mask(rescuer->task, cpu_possible_mask);
> +	rescuer->flags |= PF_NO_SETAFFINITY;
>  	wake_up_process(rescuer->task);
>
>  	return 0;
>
>
> It is untested.  It effectively reverts the commit 640f17c82460e
> ("workqueue: Restrict affinity change to rescuer").
> It avoids using kthread_bind_mask().

I will upload a new patchset to remove the extra &wq_pool_attach_mutex
and add a timing diagram to make this question clearer.

-- 
BRs
Schspa Shi
