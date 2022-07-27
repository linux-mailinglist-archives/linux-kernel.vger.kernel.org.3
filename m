Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796B5824E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiG0Kzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiG0Kzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:55:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118923E765
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:55:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 70so15822006pfx.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NwH2wazb67m8SHtqlH7y9TgCFprrSka3vLwtXCOoEz4=;
        b=1FKk1ryMpPV0kycnP8NuMg7A8i/j6pKesCdWoPLhkwKIn88gBPfAoowHMtJTkSaqUi
         sB+p/IftV/nCcPoZn6Uh8lEY8+gdksnWmz2JQKhCxD6L0IjyC36WYFb8mDh4bcFS8dkM
         MxpXAOQPV1DEMQvyYn0bOGb1bcDDqr5H56KMH/F2O2gbw17VB5rZwvXDJ46ICkJgHFMx
         mjOMLBkACPnhx+doBRZddWMVE3lAC4Tn0paXsuAqt4+2qiQyTdXZvonnNOGVijaA0GLt
         P3Dj/ariwLD7KlLTaCHOOO8NtSXpQqrgvUAd/gKEIl2e37d0ohtyyBcGkdb2nKq7IBV+
         r+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NwH2wazb67m8SHtqlH7y9TgCFprrSka3vLwtXCOoEz4=;
        b=60lmYh7KHKZ6A07lW4SiCF4v3zNoqnEBZ1zJR6wsX/Y8g4FURRmYLVN8Xpxq16q7LQ
         T8YQ/lMZi4y2fpnVjJEWiVLRVxhEF98ogjMNKkw3MsMd3ww9WQlivJsM5iENCmIDyWsq
         jPsYnHhd+sHE8Z1XUW+kj+jjUVq4wy5PRmcdaMJckZOMwmAyrQAIpbwAx9pmRAwyHWAN
         zuIa7/DAnSilozObboZrr7DVZmAwGU176qz8zuj+vipNcqGRHIkeiKr9paPvqVmA1KfW
         nPzkUR4IokFiF8H4lR8t5q7Yg7iv8/pr8zfyYBAGVB1NefBlKG/Y/7qiU/20SzIvmQBv
         usiQ==
X-Gm-Message-State: AJIora/kyGTz0VTl0GUL2XJyP9xlOXj7WZm4QMiXEH1ci2v1up18fBeK
        4C9Ra/OFBnVM/5luDA6z+7UoAQ==
X-Google-Smtp-Source: AGRyM1u8Ej+/errzSp7qLiSSX1MK61UCTbu9ZAm7f5IKF/Q4BBQqJyYv5FmCFmiLgVSt6UTM/xcuKA==
X-Received: by 2002:a63:2051:0:b0:412:6d61:ab0a with SMTP id r17-20020a632051000000b004126d61ab0amr19091264pgm.52.1658919337485;
        Wed, 27 Jul 2022 03:55:37 -0700 (PDT)
Received: from [10.4.228.171] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id 63-20020a621942000000b005255263a864sm13453978pfz.169.2022.07.27.03.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:55:37 -0700 (PDT)
Message-ID: <011a2a34-69c4-0d12-0121-92d6f526a23b@bytedance.com>
Date:   Wed, 27 Jul 2022 18:55:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH v2 09/10] sched/fair: stop load tracking when task
 switched_from_fair()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-10-zhouchengming@bytedance.com>
 <CAKfTPtC4r1pon_QxHaa=3r85v4u1DL32_9FbTwL0zBZT017E-g@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtC4r1pon_QxHaa=3r85v4u1DL32_9FbTwL0zBZT017E-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/19 21:20, Vincent Guittot wrote:
> On Wed, 13 Jul 2022 at 06:05, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> The same reason as the previous commit, if we don't reset the
>> sched_avg last_update_time to 0, after a while in switched_to_fair():
>>
>> switched_to_fair
>>   attach_task_cfs_rq
>>     attach_entity_cfs_rq
>>       update_load_avg
>>         __update_load_avg_se(now, cfs_rq, se)
>>
>> The delta (now - sa->last_update_time) will wrongly contribute/decay
>> sched_avg depends on the task running/runnable status at that time.
> 
> I think that we always decay the time spent in !fair class and never contribute
> 
> This one is a bit more complex than the new task one. Generally
> speaking, I would say that we should decay the load while running in
> !fair case because the value becomes less and less relevant over time.
> What's the meaning of pelt values when the task has run seconds as a
> fifo ? The only case that would need a particular attention, is the pi
> boost case but there is no way to now how long is runs and sleep when
> !fair

After thought for a while, I agree with you on that the PELT values become
meaningless after running as a FIFO task. So yes it's best for now to always
decay them when switched_to_fair().

So in the next version:
1. don't set for !fair in post_init_entity_util_avg()
2. keep last_update_time when switched_from_fair()
3. should we still keep SKIP_AGE_LOAD ? I don't understand what's its usage
   in switched_to_fair(). Or should we just delete it?

Thanks!

> 
>>
>> This patch reset it's sched_avg last_update_time to 0, stop load
>> tracking for !fair task, later in switched_to_fair() ->
>> update_load_avg(), we can use its saved sched_avg.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 50f65a2ede32..576028f5a09e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11552,6 +11552,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
>>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>>  {
>>         detach_task_cfs_rq(p);
>> +
>> +#ifdef CONFIG_SMP
>> +       /* Stop load tracking for !fair task */
>> +       p->se.avg.last_update_time = 0;
>> +#endif
>>  }
>>
>>  static void switched_to_fair(struct rq *rq, struct task_struct *p)
>> --
>> 2.36.1
>>
