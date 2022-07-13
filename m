Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E12573384
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiGMJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiGMJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:53:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829CCF90CB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:53:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so2701330pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iqox5ElpuuJLfeOhCrK3mRieKVQov3zq0OlnwAVVh9E=;
        b=eglvEC3/5079MjgvxFT+uezit/T7cwu5EW/csDGDSdA3+7AfBFqC8QV0fCfIK6Mbg6
         VZty7pzFt9RQWmC8i1R9uQC5ZGU6bGCM6FRhI2iwqpWOVebt2emmeUFxPcClLeQ/HyXd
         5nsfsQXUSorz+b8MAzLSsB0qT7aO9Nokz2LTY1/5M99iH6CeMronAlUPXg3zVycKap/S
         va/wZ4eQhOpYSVh46SiII2hjWKSw2tdn04C9DF/Vfgy31960ZxEZhTzetXKlmibd5NVi
         muEnbi8EP9t7BqstzqUFkASL2DmAbtweTf0zrNpEjeLuhdqIE++ZTnXviMauW47MfKCc
         q0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iqox5ElpuuJLfeOhCrK3mRieKVQov3zq0OlnwAVVh9E=;
        b=EvlOaSqgVTfJZn5TCxrWeoKA9mQZpLxiTBGMxQIYby8nj5QtLrHLvDynG29GeNPm2W
         kBbtdUtS5ZeA/YiCD2oqx+ZAayeIEjxBDX3k4FXaeXZwGVcmPviUAlYjJI5DDmeo5H2X
         J7xcmcXkKEDhKUXI0Wv9kEMEVfe0vXxS0dKCYulKbwcixZwA+ugGou+sJT7WYASm9ckO
         YBLsBG1iXJ9N/VQQxc6bRlKqycRxRKSjrH4lDyjZyGpp/wt3HWcR8R4V2Hf7kbo/00Zv
         5B6eltRUW2j+979Wv6P13WhFUx7v6/rfmnAo7mYFYYCytV0EDAipe5dNrvwk5i9nRIys
         pCZg==
X-Gm-Message-State: AJIora8G1Egya/Cf5VRJYm26bsrtENM/5EZCPuTc53vV1nXbnhIMzHqe
        EyC3lqj0h7zjPS3U1YL+/SU=
X-Google-Smtp-Source: AGRyM1upORHMivF10L9TXCuqHqvv7daddvzN0siBg4zphIcJZAk4dPughWsU/7yEV2H4cmSCS/BVSQ==
X-Received: by 2002:a17:90b:3d82:b0:1f0:5894:7e39 with SMTP id pq2-20020a17090b3d8200b001f058947e39mr2921512pjb.187.1657705982928;
        Wed, 13 Jul 2022 02:53:02 -0700 (PDT)
Received: from [30.46.241.33] ([47.246.98.177])
        by smtp.gmail.com with ESMTPSA id g14-20020aa796ae000000b0052536c695c0sm8640476pfk.170.2022.07.13.02.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:53:02 -0700 (PDT)
Message-ID: <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
Date:   Wed, 13 Jul 2022 17:52:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Peter Zijlstra <peterz@infradead.org>
References: <20220707090501.55483-1-schspa@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <20220707090501.55483-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



CC Peter.
Peter has changed the CPU binding code in workqueue.c.

I'm not understanding the problem enough, if kthread_bind_mask() is buggy
in workqueue.c, it would be buggy in other places too.


On 2022/7/7 17:05, Schspa Shi wrote:

>   
> -	if (worker->rescue_wq)
> -		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	if (worker->rescue_wq) {
> +		if (pool->flags & POOL_DISASSOCIATED)
> +			set_cpus_allowed_ptr(worker->task, cpu_active_mask);
> +		else
> +			set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	}
>   

For unbound pools (which also has POOL_DISASSOCIATED), pool->attrs->cpumask
should be used if pool->attrs->cpumask has active cpu.


> +
> +	mutex_lock(&wq_pool_attach_mutex);
> +	if ((pool->flags & POOL_DISASSOCIATED)) {
> +		/* We can't call get_online_cpus, there will be deadlock
> +		 * cpu_active_mask will no change, because we have
> +		 * wq_pool_attach_mutex hold.
> +		 **/
> +		kthread_bind_mask(worker->task, cpu_active_mask);
> +	} else {
> +		kthread_bind_mask(worker->task, pool->attrs->cpumask);
> +	}
> +	mutex_unlock(&wq_pool_attach_mutex);


For unbound pools, pool->attrs->cpumask should be used if pool->attrs->cpumask
has active cpu.

wq_pool_attach_mutex is held here and in worker_attach_to_pool() which smells bad.



The change is complex.  And if kthread_bind_mask() can't work as expected here,
the change I prefer would be:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4056f2a3f9d5..1ad8aef5fe98 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1862,6 +1862,12 @@ static void worker_attach_to_pool(struct worker *worker,
  {
  	mutex_lock(&wq_pool_attach_mutex);

+	/*
+	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
+	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
+	 */
+	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+
  	/*
  	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
  	 * stable across this function.  See the comments above the flag
@@ -1872,9 +1877,6 @@ static void worker_attach_to_pool(struct worker *worker,
  	else
  		kthread_set_per_cpu(worker->task, pool->cpu);

-	if (worker->rescue_wq)
-		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
-
  	list_add_tail(&worker->node, &pool->workers);
  	worker->pool = pool;

@@ -1952,7 +1954,7 @@ static struct worker *create_worker(struct worker_pool *pool)
  		goto fail;

  	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+	worker->flags |= PF_NO_SETAFFINITY;

  	/* successful, attach the worker to the pool */
  	worker_attach_to_pool(worker, pool);
@@ -4270,7 +4272,7 @@ static int init_rescuer(struct workqueue_struct *wq)
  	}

  	wq->rescuer = rescuer;
-	kthread_bind_mask(rescuer->task, cpu_possible_mask);
+	rescuer->flags |= PF_NO_SETAFFINITY;
  	wake_up_process(rescuer->task);

  	return 0;


It is untested.  It effectively reverts the commit 640f17c82460e
("workqueue: Restrict affinity change to rescuer").
It avoids using kthread_bind_mask().


