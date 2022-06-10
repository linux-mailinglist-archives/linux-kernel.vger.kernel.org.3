Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6D5464ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiFJK7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiFJK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:57:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A9333A0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:55:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e11so23548907pfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y4vJn9JD/v4XAqxJoe5tQSVYfc+CgMucvAzhkuK7td4=;
        b=s7u9ZSRFTqAzntL1QmWlHUyTW/kEN6wXagskhgQiyq5ykWDdAAxoy0YVvko7UazeRL
         Xncrn16TCtFZralobXmGpSOEXmIdB7ZhgWUrT69iBivF9HVgeTO3PcwVNEY9qtA2ut9i
         QiGLtEP5fcm/C3w901mcvlbYr0lB3T86A8jBACNHPA25l8vzheG4wOj2uW7wh2v4xcks
         sfVINqZiWS1wv6w5rH+sPpSmvpOAj/d51pPFsiFSdbb9BPlXKKUQJGLPSwJPCH3WUPS5
         AQkaG7es0S8nHzvLu4XS+LbYGacYyjuzs8zDCM+9hfUj2V6qHJ1f4irxivAueOqcYsKf
         vOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y4vJn9JD/v4XAqxJoe5tQSVYfc+CgMucvAzhkuK7td4=;
        b=rZrKWeoAVEQcmbbtgB3uuf9XTHNWFZkXd2Bl275AAUy/oNvO320PfWDz0ZaPmPlNK3
         ghHaFJkgolTqFS3Ml+/PErYVDj2zT3AI23AAzwbx92XctR/JBdKENhRQ8zg8fxoIV99H
         8xKw6RGGVErE6Luz0ON3PqmEgamDqX6VBbpmXbCxxBe+a2sczKOCq/2YCbO3YZH3E/7Q
         2uMw5vWbnHBKf6YTE57HQoXXWsgxAhpTozypFmgbPrft46PLMjjCGr+LeNtzGvBZEamA
         o5Hb4jqN/EHPLIsRTDu+goa+gJ+BzhWnxWlOlxFWNmEBcIlHUkdmWLAsWiGqJ1AJeFWT
         hGag==
X-Gm-Message-State: AOAM533OI3UVfazeaKsZ/BsyHHUfvjZOdicQspfQXZ5S3H660KOjeaUX
        EW6v3yAU5d/9xmLhHQESJ58fzQ==
X-Google-Smtp-Source: ABdhPJwktL4cz4zXA/Sinmc7n2/lpinMG3UbxaAe07eCftAl1qrfVFS44a+rU9lB4V9T+ovU1zYpTg==
X-Received: by 2002:a05:6a00:1a8f:b0:51c:2f82:cdba with SMTP id e15-20020a056a001a8f00b0051c2f82cdbamr21547357pfv.85.1654858536707;
        Fri, 10 Jun 2022 03:55:36 -0700 (PDT)
Received: from [10.4.211.96] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id h184-20020a6283c1000000b0051ba0ee30cbsm18950845pfe.128.2022.06.10.03.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:55:36 -0700 (PDT)
Message-ID: <c787d2c1-aa28-2f44-48ef-e706e6c8cb2b@bytedance.com>
Date:   Fri, 10 Jun 2022 18:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH v2] sched/fair: combine detach into dequeue
 when migrating task
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220609035326.91544-1-zhouchengming@bytedance.com>
 <67c7e9ea-1d3b-39f0-c1b6-4940ed45844d@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <67c7e9ea-1d3b-39f0-c1b6-4940ed45844d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/6/10 18:49, Dietmar Eggemann wrote:
> On 09/06/2022 05:53, Chengming Zhou wrote:
>> When we are migrating task out of the CPU, we can combine detach
>> into dequeue_entity() to save the independent detach_entity_cfs_rq()
>> in migrate_task_rq_fair().
>>
>> This optimization is like combining DO_ATTACH in the enqueue_entity()
>> when migrating task to the CPU.
>>
>> So we don't have to traverse the CFS tree twice to do these load
>> detach and propagation.
> 
> By `propagation` you refer to the detach_entity_cfs_rq() ->
> propagate_entity_cfs_rq() call?
> This one wouldn't be called anymore with your change.

Yes.

> 
> [...]
> 
>> @@ -4426,6 +4435,14 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>>  static void
>>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>  {
>> +	int action = UPDATE_TG;
>> +
>> +	/*
>> +	 * If we are migrating task from the CPU, detach load_avg when dequeue.
>> +	 */
>> +	if (entity_is_task(se) && task_of(se)->on_rq == TASK_ON_RQ_MIGRATING)
> 
> - if (entity_is_task(se) && task_of(se)->on_rq == TASK_ON_RQ_MIGRATING)
> + if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))

Better, will do.

> 
>> +		action |= DO_DETACH;
> 
> With the `entity_is_task(se)` you make sure we only call
> detach_entity_load_avg() and update_tg_load_avg() for the se
> representing the task itself (and not taskgroups the task might run in).
> So IMHO this looks good.
> 
> You save the propagate_entity_cfs_rq(&p->se) call from (2) by doing the
> detach_entity_load_avg(), update_tg_load_avg() for a migrating task
> inside (1) (the task being the first se in the loop )
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

Thanks for the description, it's clearer, I should put it in the commit message.

> 
> [...]
> 
>> @@ -6940,15 +6957,10 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>  		se->vruntime -= min_vruntime;
>>  	}
>>  
>> -	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
>> -		/*
>> -		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
>> -		 * rq->lock and can modify state directly.
>> -		 */
>> -		lockdep_assert_rq_held(task_rq(p));
>> -		detach_entity_cfs_rq(&p->se);
>> -
>> -	} else {
>> +	/*
>> +	 * In case of TASK_ON_RQ_MIGRATING we already detach in dequeue_entity.
>> +	 */
>> +	if (p->on_rq != TASK_ON_RQ_MIGRATING) {
> 
> - if (p->on_rq != TASK_ON_RQ_MIGRATING) {
> + if (!task_on_rq_migrating(p)) {

Will do. Thanks!

> 
> [...]
