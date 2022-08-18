Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A785981E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiHRLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244243AbiHRLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:03:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AAC25F7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:03:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q9so103045pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Cmyj8Sze9IZV3xrqqUnygmoWGVPH4EnEtpJZMfvcEZw=;
        b=fkrJEygZ3wh8eVhYL6ClfTOxhfgWFjCyyByAWAXDzo/9DfcFBusl+bGQ6HhQyzxj4K
         //6JEna5NhH5ySWR4pOH9lztAOoITbymHuJT8MEuR+70yH9rKmvgSJuaLodUQWJmRGGP
         bKD5y6D3DiAQfyXQ8lOJwiFG11aCNpvNmYGC4tEqkzrRx9dttJitjrP8UiO6GU51dnZ6
         8Q2ZNLOWfzTYao6hyAYA50Ucra6QgSMpLNstVAaFtkQX59ejatZ0yOCefeDXql1Jw8xD
         gxK6PKdBzxRCSUHSguTFWcRSUmth22aldD26pLyoG8DPxnoObGRff2yRVSF6pJ31aiAn
         5nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Cmyj8Sze9IZV3xrqqUnygmoWGVPH4EnEtpJZMfvcEZw=;
        b=RSZet1IEH98uspB7jyuFGWrhzmWf6Bn7x7hvoRAeAqpWmZlTjL07XfWQflRt9CVYF2
         jxQQYkwW34beHQUMA0estFyK9+/+ICjkhwvm97KfvdUUukuV+y+z5r7nQoazXXo5kMk5
         FyJVnvR53z6+pJz3AiSwSV7EcXaLopQmumNLs3eTDxH8CsTSMaSIbw57GLMnGHHXEz8H
         fc4xY4oVuTMkD3J3e0PlX6ASpmvnIc1HCBS2sKmVXUDrWfAsW5/6pAS9BUTBBswlXH3L
         qJH7GdiKW53BYRCXY9x2X9i00p3CnRs8MEibdokP6noJhf/NABmEGfvPPXkSQQrZRJwi
         PRzA==
X-Gm-Message-State: ACgBeo1QVFhljPcdjCaHKNSS7PQaTqJNbg7ILEDJIsNYJ1Gkrv12zUmH
        Z3c7hz1FHRZDjYkcYUY9zUj8YA==
X-Google-Smtp-Source: AA6agR7bflm6d6muQ0nRMmieKBttYGhd9GpR+zs+WI8xMHyLHGWIKIDogpdCpo3QzRkQDIHkZMz8xA==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:666a with SMTP id t2-20020a056a0021c200b0052bff44666amr2458520pfj.83.1660820597396;
        Thu, 18 Aug 2022 04:03:17 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016befc83c6bsm1104176plb.165.2022.08.18.04.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 04:03:17 -0700 (PDT)
Message-ID: <0df80a63-5d1b-744e-d143-d2b0ccc52cd5@bytedance.com>
Date:   Thu, 18 Aug 2022 19:03:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v5 8/9] sched/fair: defer task sched_avg attach to
 enqueue_entity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org, tj@kernel.org
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
 <20220818034343.87625-9-zhouchengming@bytedance.com>
 <Yv4W5u4+CXir3bjZ@worktop.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yv4W5u4+CXir3bjZ@worktop.programming.kicks-ass.net>
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

On 2022/8/18 18:39, Peter Zijlstra wrote:
> On Thu, Aug 18, 2022 at 11:43:42AM +0800, Chengming Zhou wrote:
>> When wake_up_new_task(), we would use post_init_entity_util_avg()
>> to init util_avg/runnable_avg based on cpu's util_avg at that time,
>> then attach task sched_avg to cfs_rq.
>>
>> Since enqueue_entity() would always attach any unattached task entity,
>> so we can defer this work to enqueue_entity().
>>
>> post_init_entity_util_avg(p)
>>   attach_entity_cfs_rq()  --> (1)
>> activate_task(rq, p)
>>   enqueue_task() := enqueue_task_fair()
>>   enqueue_entity()
>>     update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
>>       if (!se->avg.last_update_time && (flags & DO_ATTACH))
>>         attach_entity_load_avg()  --> (2)
>>
>> This patch defer attach from (1) to (2)
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e0d34ecdabae..aacf38a72714 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -799,8 +799,6 @@ void init_entity_runnable_average(struct sched_entity *se)
>>  	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
>>  }
>>  
>> -static void attach_entity_cfs_rq(struct sched_entity *se);
>> -
>>  /*
>>   * With new tasks being created, their initial util_avgs are extrapolated
>>   * based on the cfs_rq's current util_avg:
>> @@ -863,8 +861,6 @@ void post_init_entity_util_avg(struct task_struct *p)
>>  		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>>  		return;
>>  	}
>> -
>> -	attach_entity_cfs_rq(se);
>>  }
> 
> There are comments with update_cfs_rq_load_avg() and
> remove_entity_load_avg() that seem to rely on post_init_entity_util()
> doing this attach.
> 
> If that is no longer true; at the very least those comments need to be
> updated, but also, I don't immediately see why that's no longer the
> case, so please explain.

This attach in post_init_entity_util() will be done in enqueue_entity()
-> update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH) loop.

So these comments should be updated in the next version.

Thanks!

