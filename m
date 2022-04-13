Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA34FFAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiDMQCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F3C826556
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649865631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wn7w2vF9MQR+lrDQeY4ZU+D9MJrKuaExJ1DdBANLOc=;
        b=TWLhu71QLLrDX8iNt9yoGH/pfi3R41UGJHrmSszLZc8rfjtKXt04UpzHMbBun94Qv88BRU
        TQIz6HrVzVPRWttIJvb8N/2A7KXVeApKCYIhbG6b/5GHf+9xy78QqR65l18oV8rssqf929
        MUgkaRy5Gh6SmHBfrNuWrh/xrEH0cT4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-ICqAjVd9NWyOZBymKjYSBw-1; Wed, 13 Apr 2022 12:00:30 -0400
X-MC-Unique: ICqAjVd9NWyOZBymKjYSBw-1
Received: by mail-qv1-f72.google.com with SMTP id o1-20020a0c9001000000b00440e415a3a2so2093421qvo.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+wn7w2vF9MQR+lrDQeY4ZU+D9MJrKuaExJ1DdBANLOc=;
        b=k9WdnJ8c49t3BU/J7G9uroB9AV8U8qO/SJ5eYMGpT0Eh2CMDeOxr21hOirsDsx3f5m
         SDvLJ5BJTl9EaxzyN1mitxy9NqTHHGjeZVa5sBJIcBMctujES4vqnLFvv34ThdF+3Xwb
         zhlTXfKoYBYpGzI2WH06WI84CRlrcDFUIk8xsoC3sDeje7nR7QPjY5LivmkWBT3oy3ZG
         5fM8w1PncveWbLqXzUq3EAgCOW72d+BmjFLQjYVNToFzEKl9PfYGpgF5vcYeZwO1/jGc
         7sP0mYljNEsZr0UpDeGKicA+9WF7rJXqiHEPd/nuUSLbhX5gt5pZj8unU3ISP4VctBaI
         T1Xg==
X-Gm-Message-State: AOAM530/uKAiatGNOpFTOxv0n+usT7D9pjgq+/2eH5tpffYuGCMNOu9/
        9IU1ASugq3Un6DhofgHLURKdlvyCUnuUK7RCUNYO/BeWYjg4KkXlW5r08i8Bx1yexs0B45QGzIs
        yJb6wdTKMlZyfSEfK0uY4IGc7
X-Received: by 2002:a37:9b91:0:b0:69a:48d:54f2 with SMTP id d139-20020a379b91000000b0069a048d54f2mr7313002qke.476.1649865628963;
        Wed, 13 Apr 2022 09:00:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2UEdFboFqgF3H4gDkx/Vl+TBWQAfu1ZXxNGKAvk/rIbXKTFIzr1SNtSN9XvcHOKM0HyG1Pg==
X-Received: by 2002:a37:9b91:0:b0:69a:48d:54f2 with SMTP id d139-20020a379b91000000b0069a048d54f2mr7312965qke.476.1649865628373;
        Wed, 13 Apr 2022 09:00:28 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id f18-20020a05622a1a1200b002eef655b3e3sm5901469qtb.94.2022.04.13.09.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:00:27 -0700 (PDT)
Message-ID: <97a04805-120c-abc1-4e34-01cfdc5ef8fb@redhat.com>
Date:   Wed, 13 Apr 2022 12:00:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
 <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
 <87sfqni77s.ffs@tglx> <YlPPRrGrX2ECe8QY@dhcp22.suse.cz> <87wnfwf4e5.ffs@tglx>
 <YlPv8elVxqa4XZnd@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YlPv8elVxqa4XZnd@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 7ec38194f8e1..be6d65ead7ec 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -632,7 +632,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  	 */
>  	set_bit(MMF_OOM_SKIP, &mm->flags);
>  
> -	/* Drop a reference taken by wake_oom_reaper */
> +	/* Drop a reference taken by queue_oom_repaer */
>  	put_task_struct(tsk);
>  }
>  
> @@ -644,12 +644,12 @@ static int oom_reaper(void *unused)
>  		struct task_struct *tsk = NULL;
>  
>  		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
> -		spin_lock(&oom_reaper_lock);
> +		spin_lock_irq(&oom_reaper_lock);
>  		if (oom_reaper_list != NULL) {
>  			tsk = oom_reaper_list;
>  			oom_reaper_list = tsk->oom_reaper_list;
>  		}
> -		spin_unlock(&oom_reaper_lock);
> +		spin_unlock_irq(&oom_reaper_lock);
>  
>  		if (tsk)
>  			oom_reap_task(tsk);
> @@ -658,22 +658,50 @@ static int oom_reaper(void *unused)
>  	return 0;
>  }
>  
> -static void wake_oom_reaper(struct task_struct *tsk)
> +static void wake_oom_reaper_fn(struct timer_list *timer)
>  {
> -	/* mm is already queued? */
> -	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> -		return;
> +	struct task_struct *tsk = container_of(timer, struct task_struct, oom_reaper_timer);
> +	struct mm_struct *mm = tsk->signal->oom_mm;
> +	unsigned long flags;
>  
> -	get_task_struct(tsk);
> +	/* The victim managed to terminate on its own - see exit_mmap */
> +	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +		put_task_struct(tsk);
> +		return;
> +	}
>  
> -	spin_lock(&oom_reaper_lock);
> +	spin_lock_irqsave(&oom_reaper_lock, flags);
>  	tsk->oom_reaper_list = oom_reaper_list;
>  	oom_reaper_list = tsk;
> -	spin_unlock(&oom_reaper_lock);
> +	spin_unlock_irqrestore(&oom_reaper_lock, flags);
>  	trace_wake_reaper(tsk->pid);
>  	wake_up(&oom_reaper_wait);
>  }
>  
> +/*
> + * Give OOM victims some head room to exit themselves. If they do not exit
> + * on their own the oom reaper is invoked.
> + * The timeout is basically arbitrary and there is no best value to use.
> + * The longer it will be the longer the worst case scenario OOM can
> + * take. The smaller the timeout the more likely the oom_reaper can get
> + * into the way and release resources which could be needed during the
> + * exit path - e.g. futex robust lists can sit in the anonymous memory
> + * which could be reaped and the exit path won't be able to let waiters
> + * know the holding task has terminated.
> + */
> +#define OOM_REAPER_DELAY (2*HZ)
> +static void queue_oom_repaer(struct task_struct *tsk)
> +{
> +	/* mm is already queued? */
> +	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> +		return;
> +
> +	get_task_struct(tsk);
> +	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper_fn, 0);
> +	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	add_timer(&tsk->oom_reaper_timer);
> +}
> +
>  static int __init oom_init(void)
>  {
>  	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
> @@ -681,7 +709,7 @@ static int __init oom_init(void)
>  }
>  subsys_initcall(oom_init)
>  #else
> -static inline void wake_oom_reaper(struct task_struct *tsk)
> +static inline void queue_oom_repaer(struct task_struct *tsk)
>  {
>  }
>  #endif /* CONFIG_MMU */
> @@ -932,7 +960,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	rcu_read_unlock();
>  
>  	if (can_oom_reap)
> -		wake_oom_reaper(victim);
> +		queue_oom_repaer(victim);
>  
>  	mmdrop(mm);
>  	put_task_struct(victim);
> @@ -968,7 +996,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	task_lock(victim);
>  	if (task_will_free_mem(victim)) {
>  		mark_oom_victim(victim);
> -		wake_oom_reaper(victim);
> +		queue_oom_repaer(victim);
>  		task_unlock(victim);
>  		put_task_struct(victim);
>  		return;
> @@ -1067,7 +1095,7 @@ bool out_of_memory(struct oom_control *oc)
>  	 */
>  	if (task_will_free_mem(current)) {
>  		mark_oom_victim(current);
> -		wake_oom_reaper(current);
> +		queue_oom_repaer(current);
>  		return true;
>  	}

Thanks for the code Michal-- It does seem to fix our issue! I will post it after
I finish running it through a few more test cases, and our internal testing suites.

Cheers,
-- Nico

