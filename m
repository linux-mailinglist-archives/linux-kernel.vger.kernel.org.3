Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622024E7857
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376449AbiCYPrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359833AbiCYPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:47:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8249FB6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:45:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so3782380pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F2J3GRPHB3G37m0ntYbX1A7mRb63xwXTzcw/0LCmzK8=;
        b=j6v83UP12RlVDLnoGbuNC2AikhhfeVc1PN0fe9TNAwaGJ5rJkhKi7Vro0U/dmVKeVi
         Qe3JVOftAAqXYpi4iStHHzIkzuAVPYtZGKbbkBuktPa4d04OYaZWjP/Wsujdon8GODQ3
         X5JyOj4aGJzRRLe9fnMPT7cjI2f9GFzeFberELPxVH7RFf7MqgerX7KkO/BQeLZXdefU
         WL3ARwaDXPX/bXtmqJ6uhocanO/LxKKfcLfYiQntLf2/FxSBZLlMTpEN6bs9jbzPGS00
         JjvbPHjha6iROQxRkxJGu8twqyrZqxOGiARsSa/k36AbIAAbPFd5z+a1hIqW4KQfpM95
         Iasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F2J3GRPHB3G37m0ntYbX1A7mRb63xwXTzcw/0LCmzK8=;
        b=YAxpFxS8SLdTXvjLPiWyIAvaYzx5vTuAiuwIIvINSmiYaEDG007CN3uhAgEq8AIryV
         3xJMvf3PGALdPcMSifZLmJRxxeilBblzmpgY1LYe9xESlhHFqZH1atetMECf9XL7hJZD
         NDcvw4KLyQlMpUXW13qsqg3DT9ywjp1egBaI+0lKoPGDd462LI9IK+07Pa7qZ+/Aytm6
         BNwMzgwwKzX2UHyWvH0rzF8jK5SlZI9tVgLUlTadkEOCS+ViHf/GU4xvpbPTvam574jt
         P8j7tQuduD//qLOkyJ+u4+Kp5bADaaebtDfRi40TNfymGsZJhSCJvJHsKl0IaUrUifq9
         viGg==
X-Gm-Message-State: AOAM531Wk36Vhppk0m7qDJCAeN+bYSH2iHyf3uOOeErKmrSnzbgTEYkg
        r6rGtptz9hi4u14QUrlhApKQRQ==
X-Google-Smtp-Source: ABdhPJy1IH0xR6q+NdfrflvwbkEwDLQ6JNxFY6j7nyMR/Q0sr+m0LEFyaXK4MlTzcul6OEbQhRpTAA==
X-Received: by 2002:a17:903:2c5:b0:14f:4a29:1f64 with SMTP id s5-20020a17090302c500b0014f4a291f64mr12456396plk.90.1648223126332;
        Fri, 25 Mar 2022 08:45:26 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6a:5860:910b:f668:2c72:7b7? ([2409:8a28:e6a:5860:910b:f668:2c72:7b7])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm6498824pjp.9.2022.03.25.08.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:45:25 -0700 (PDT)
Message-ID: <40a084b1-b9ca-77a0-2b1d-56b9c2ec660f@bytedance.com>
Date:   Fri, 25 Mar 2022 23:45:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v3 3/5] perf/core: Don't need
 event_filter_match in merge_sched_in()
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
 <20220325035318.42168-4-zhouchengming@bytedance.com>
 <a1d1389f-b1f3-cd34-ccef-0657fc1fa4f4@linux.intel.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <a1d1389f-b1f3-cd34-ccef-0657fc1fa4f4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/25 23:11, Liang, Kan wrote:
> 
> 
> On 3/24/2022 11:53 PM, Chengming Zhou wrote:
>> There is one obselete comment in perf_cgroup_switch(), since
>> we don't use event_filter_match() when event_sched_out().
>>
>> Then found we needn't to use event_filter_match() in
>> merge_sched_in() too. Because now we use the perf_event groups
>> RB-tree to get the exact matched perf_events, don't need to
>> go through the event_filter_match() to check if matched again.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>   kernel/events/core.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index dd985c77bc37..225d408deb1a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -856,7 +856,8 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>>               cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>>               /*
>>                * must not be done before ctxswout due
>> -             * to event_filter_match() in event_sched_out()
>> +             * to update_cgrp_time_from_cpuctx() in
>> +             * ctx_sched_out()
>>                */
>>               cpuctx->cgrp = NULL;
>>           }
>> @@ -3804,9 +3805,6 @@ static int merge_sched_in(struct perf_event *event, void *data)
>>       if (event->state <= PERF_EVENT_STATE_OFF)
>>           return 0;
>>   -    if (!event_filter_match(event))
>> -        return 0;
>> -
> 
> Both X86 and Arm implemented PMU specific filter_match callback for the hybrid system. I think the check is still required at least for the hybrid system.
> 

Ah, I ignored this point, will fix it.

Thanks.

> 
> Thanks,
> Kan
>>       if (group_can_go_on(event, cpuctx, *can_add_hw)) {
>>           if (!group_sched_in(event, cpuctx, ctx))
>>               list_add_tail(&event->active_list, get_event_list(event));
