Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81050836D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376767AbiDTIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376756AbiDTIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:32:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE63C4B5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:29:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id r10so1266581pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=/gMOazwPGCF48oWaubXLl3yTaXSa/SV3Ov0ADwQj0+8=;
        b=N8qFmaJY0yTBSP9E9uWoP8EeQtlj5QzMInXmJ42TLPnNdIksY8FqLABOFhXJmXO2vp
         Zhv1rOfVCCnZfxtQ8AaDRol1ULKbF2Ts2UfcZmhul56+ePeCtqxaUueBpib8pZP7Q3Xo
         9et1cB6XH1QrYa5lMqTR9yeSMHXYotvpAQ3iR+SpSnouKwTzGAOAvUxM/QWtdTHKBK85
         Pkqs0iuHVVubbPAbKJGo1yZTmPu7F8Utej+dnO1zcmuuxSHi0OhlEDhGyAfvKGVtvXBj
         G+0z6vCPwxu1ecS4sUjP3657N+G0WGDtOT1UCHR9/oZ2KLHn0K5A1eEsH2xtVvGUhIeG
         HjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/gMOazwPGCF48oWaubXLl3yTaXSa/SV3Ov0ADwQj0+8=;
        b=14HIfoIFvjT69e2uXIerXxMZN2rr1/yIAZKE5Up9Ow6/PPd2D4g8uGg5UXHaTrR+ra
         bMYlY+WK7wcTUSH3WvmZxpnvuaXv7kzpdhVfC9vUm7lsxWAWdXEijoVjDfcRaO0OltEY
         POuZmqrKV4TzylkQuTbffqkkzEd+TyYImF+KOZUDcGNOsK/OOC5m2kYkha8/91I8UzCA
         XhS2lNX6p/8It2OyCyF83o8Ykb+lES7yFDC49CxtFYN0nQFXQE20Mi32qdqXtblu+PCI
         Xu296DsFiSXNiqkr7O4h5mNXW76tvjrBq5lx4o5PIvFaoWwfbX7/2MZ61ETohuVNFNmg
         odCw==
X-Gm-Message-State: AOAM530uTlELR+nAUmJJXsXk3msThA7VTkpEb/2Qvad/h5vB06VmHWau
        Y3mkAhIel53LGDq5auvATF1nZA==
X-Google-Smtp-Source: ABdhPJy4XY5JdZmVFLkzaVYPIXFZ3tYJdbBKU3WLHTWgVidSJ0yvJsxUsESBVp5bI8QE5p/QOAXOxg==
X-Received: by 2002:a05:6a00:8c8:b0:4fe:ecb:9b8f with SMTP id s8-20020a056a0008c800b004fe0ecb9b8fmr21869634pfu.55.1650443374135;
        Wed, 20 Apr 2022 01:29:34 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b00505bf336385sm18547212pfo.124.2022.04.20.01.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 01:29:33 -0700 (PDT)
Message-ID: <c1e7fc17-b091-1da1-7fa8-0490cc7f7e4b@bytedance.com>
Date:   Wed, 20 Apr 2022 16:29:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [External] Re: [PATCH] sched/core: Avoid obvious double
 update_rq_clock warning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
 <20220419104828.GQ2731@worktop.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20220419104828.GQ2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 6:48 PM, Peter Zijlstra wrote:
> On Mon, Apr 18, 2022 at 05:09:29PM +0800, Hao Jia wrote:
>> When we use raw_spin_rq_lock to acquire the rq lock and have to
>> update the rq clock while holding the lock, the kernel may issue
>> a WARN_DOUBLE_CLOCK warning.
>>
>> Since we directly use raw_spin_rq_lock to acquire rq lock instead of
>> rq_lock, there is no corresponding change to rq->clock_update_flags.
>> In particular, we have obtained the rq lock of other cores,
>> the core rq->clock_update_flags may be RQCF_UPDATED at this time, and
>> then calling update_rq_clock will trigger the WARN_DOUBLE_CLOCK warning.
> 
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>> ---
>>   kernel/sched/deadline.c | 18 +++++++++++-------
>>   kernel/sched/rt.c       | 20 ++++++++++++++++++--
> 
> Very good for keeping them in sync.
> 
>>   2 files changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index fb4255ae0b2c..9207b978cc43 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
> 
>> @@ -2317,16 +2318,14 @@ static int push_dl_task(struct rq *rq)
>>   		goto retry;
>>   	}
>>   
>> +	rq_pin_lock(rq, &srf);
>> +	rq_pin_lock(later_rq, &drf);
>>   	deactivate_task(rq, next_task, 0);
>>   	set_task_cpu(next_task, later_rq->cpu);
>> -
>> -	/*
>> -	 * Update the later_rq clock here, because the clock is used
>> -	 * by the cpufreq_update_util() inside __add_running_bw().
>> -	 */
>> -	update_rq_clock(later_rq);
>> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>> +	activate_task(later_rq, next_task, 0);
>>   	ret = 1;
>> +	rq_unpin_lock(rq, &srf);
>> +	rq_unpin_lock(later_rq, &drf);
>>   
>>   	resched_curr(later_rq);
>>   
> 
>> @@ -2413,11 +2413,15 @@ static void pull_dl_task(struct rq *this_rq)
>>   			if (is_migration_disabled(p)) {
>>   				push_task = get_push_task(src_rq);
>>   			} else {
>> +				rq_pin_lock(this_rq, &this_rf);
>> +				rq_pin_lock(src_rq, &src_rf);
>>   				deactivate_task(src_rq, p, 0);
>>   				set_task_cpu(p, this_cpu);
>>   				activate_task(this_rq, p, 0);
>>   				dmin = p->dl.deadline;
>>   				resched = true;
>> +				rq_unpin_lock(this_rq, &this_rf);
>> +				rq_unpin_lock(src_rq, &src_rf);
>>   			}
>>   
>>   			/* Is there any other task even earlier? */
> 
> I'm really not sure about this part though. This is a bit of a mess. The
> balancer doesn't really need the pinning stuff. I realize you did that
> because we got the clock annotation mixed up with that, but urgh.
> 
> Basically we want double_rq_lock() / double_lock_balance() to clear
> RQCF_UPDATED, right? Perhaps do that directly?
> 
> (maybe with an inline helper and a wee comment?)
> 
> The only immediate problem with this would appear to be that
> _double_rq_lock() behaves differently when it returns 0. Not sure that
> matters.
> 
> Hmm?

Thanks for your review comments.
As you have prompted, the WARN_DOUBLE_CLOCK warning is still triggered 
when _double_rq_lock() returns 0.
Please review the solution below, and based on your review, I will 
submit the v2 patch as soon as possible.
Thanks.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..b73fe46cd6c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -610,10 +610,13 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
         swap(rq1, rq2);

     raw_spin_rq_lock(rq1);
-   if (__rq_lockp(rq1) == __rq_lockp(rq2))
-       return;
+   if (__rq_lockp(rq1) != __rq_lockp(rq2))
+       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);

-   raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+#ifdef CONFIG_SCHED_DEBUG
+   rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+   rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
  }
  #endif

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..9fe506a6b7b4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2544,20 +2544,25 @@ static inline int _double_lock_balance(struct rq 
*this_rq, struct rq *busiest)
     __acquires(this_rq->lock)
  {
     if (__rq_lockp(this_rq) == __rq_lockp(busiest))
-       return 0;
+       goto out;

     if (likely(raw_spin_rq_trylock(busiest)))
-       return 0;
+       goto out;

     if (rq_order_less(this_rq, busiest)) {
         raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
-       return 0;
+       goto out;
+   } else {
+       raw_spin_rq_unlock(this_rq);
+       double_rq_lock(this_rq, busiest);
+       return 1;
     }
-
-   raw_spin_rq_unlock(this_rq);
-   double_rq_lock(this_rq, busiest);
-
-   return 1;
+out:
+#ifdef CONFIG_SCHED_DEBUG
+   this_rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+   busiest->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
+   return 0;
  }

  #endif /* CONFIG_PREEMPTION */
@@ -2644,6 +2649,9 @@ static inline void double_rq_lock(struct rq *rq1, 
struct rq *rq2)
     BUG_ON(rq1 != rq2);
     raw_spin_rq_lock(rq1);
     __acquire(rq2->lock);   /* Fake it out ;) */
+#ifdef CONFIG_SCHED_DEBUG
+   rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
  }
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f259621f4c93..be4baec84430 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -610,10 +610,13 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
>   		swap(rq1, rq2);
>   
>   	raw_spin_rq_lock(rq1);
> -	if (__rq_lockp(rq1) == __rq_lockp(rq2))
> -		return;
> +	if (__rq_lockp(rq1) != __rq_lockp(rq2))
> +		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
>   
> -	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> +#ifdef CONFIG_SCHED_DEBUG
> +	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +#endif
>   }
>   #endif
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8dccb34eb190..3ca8dd5ca17c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2644,6 +2644,10 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
>   	BUG_ON(rq1 != rq2);
>   	raw_spin_rq_lock(rq1);
>   	__acquire(rq2->lock);	/* Fake it out ;) */
> +#ifdef CONFIG_SCHED_DEBUG
> +	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +#endif
>   }
>   
>   /*
