Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7F501851
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiDNQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiDNP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F5E65
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:38:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso6004403pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qq44QcgUTvrM0yR0uIBFO4qbEgfmXFTn9DFwrR1re2U=;
        b=DJcQZgGgCMSdEr73OHf4KjCFWkfmLDjCW6J+MKp7+BvlAxQbpy3LWtQHsiJRMomLKf
         QQy/cDZGSi7hIsxhUMiBI2sSOMqZ94VJvI/zsS2or5jz3Okd9ZEENLtR9gfrUpM0GVt1
         wf5lYwEClRX+nU8oJkVa/PZ6nob4NgW5hiLs929efgHRtERBFzIt/30LvL5O1hf84NLO
         J1aRow7aurhrwwZWPNAfNAdaBqJISM1rd9EWMkjWuFN0GW8inMXzIqEAYbHBU4FruJQq
         4rljZH0IKyhkSVXPeLRNiubyEjXunPkdPDp4YbCCgq/50ckpd/IrjcxSC19Vqx6P+aJH
         QzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qq44QcgUTvrM0yR0uIBFO4qbEgfmXFTn9DFwrR1re2U=;
        b=ow+aUYJxS0+E2LpYoCjWJ35qAKIONERYePNRqRNllFxTz8gVqOt+7cxUP2R/E4hBWJ
         lbr3yG+0pWcmlr4AUWwOCQpkCDSz59ETCgHj/kqCQQjWaLZXw+JuY7S00PidswxEiwGH
         MauftWpWBR99osUHLKDrN1oaoGQGS/2Ff9UhQ5pQ78ISjBmCyzZgCw5zGZtJuGByNm6i
         H1Ak43C+LMcw/nbT2bXyNuesgvT83oy/VUVKGUyiQNv7nc/gxzQXetYjSBF+LE1H7EGe
         O17uVdIngQxpgVKAbKpM70dGqFMe7MfgAV/ShClkoM9LHKfCd73Yffaf/NLKoAtlMdJA
         XGKA==
X-Gm-Message-State: AOAM533JbzYzs4FBv+ogdYt1nEHda25BXYNxyS2hCNbo4RJiCO8p/hFU
        kZqawFV0hIeKdPShLXYGAYX4Tw==
X-Google-Smtp-Source: ABdhPJyhlJFCjRIXFLlqIT5zK8kOE8XYJzsA83tVovosUIggNLpD+sH0kv/J9kuxtWvD3ngjbfHtbg==
X-Received: by 2002:a17:903:2ca:b0:156:f1cc:7cb6 with SMTP id s10-20020a17090302ca00b00156f1cc7cb6mr41777445plk.174.1649950691276;
        Thu, 14 Apr 2022 08:38:11 -0700 (PDT)
Received: from [10.255.214.21] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d14-20020a65620e000000b003a1112c6cbesm1779587pgv.39.2022.04.14.08.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:38:10 -0700 (PDT)
Message-ID: <60cbd089-f514-44eb-a629-62556936be35@bytedance.com>
Date:   Thu, 14 Apr 2022 23:38:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC v2 2/2] sched/fair: introduce sched-idle balance
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abel Wu <wuyun.abel@bytedance.com>
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-3-wuyun.abel@bytedance.com>
 <CABk29NvE=Fmgo4xqQLfy-K8j0hNS-+ppGdYt37yDUnRJiqjZ5w@mail.gmail.com>
 <801da029-6bbe-2a0c-7de0-afffc3d5de02@bytedance.com>
 <CABk29Nu9QTUKHP3cyx3qpiGcNM-PbaSxCvfhvBvOs++67KeXCw@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Nu9QTUKHP3cyx3qpiGcNM-PbaSxCvfhvBvOs++67KeXCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 8:08 AM, Josh Don Wrote:
>>>>    /*
>>>>     * Use locality-friendly rq->overloaded to cache the status of the rq
>>>>     * to minimize the heavy cost on LLC shared data.
>>>> @@ -7837,6 +7867,22 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>           if (kthread_is_per_cpu(p))
>>>>                   return 0;
>>>>
>>>> +       if (unlikely(task_h_idle(p))) {
>>>> +               /*
>>>> +                * Disregard hierarchically idle tasks during sched-idle
>>>> +                * load balancing.
>>>> +                */
>>>> +               if (env->idle == CPU_SCHED_IDLE)
>>>> +                       return 0;
>>>> +       } else if (!static_branch_unlikely(&sched_asym_cpucapacity)) {
>>>> +               /*
>>>> +                * It's not gonna help if stacking non-idle tasks on one
>>>> +                * cpu while leaving some idle.
>>>> +                */
>>>> +               if (cfs_rq_busy(env->src_rq) && !need_pull_cfs_task(env->dst_rq))
>>>> +                       return 0;
>>>
>>> These checks don't involve the task at all, so this kind of check
>>> should be pushed into the more general load balance function. But, I'm
>>> not totally clear on the motivation here. If we have cpu A with 1
>>> non-idle task and 100 idle tasks, and cpu B with 1 non-idle task, we
>>> should definitely try to load balance some of the idle tasks from A to
>>> B. idle tasks _do_ get time to run (although little), and this can add
>>> up and cause antagonism to the non-idle task if there are a lot of
>>> idle threads.
>>
>> CPU_SCHED_IDLE means triggered by sched_idle_balance() in which pulls
>> a non-idle task for the unoccupied cpu from the overloaded ones, so
>> idle tasks are not the target and should be skipped.
>>
>> The second part is: if we have cpu A with 1 non-idle task and 100 idle
>> tasks, and B with >=1 non-idle task, we don't migrate the last non-idle
>> task on A to B.
> 
> It could be possible that we do want to migrate the last non-idle task
> from A to B, if the weight sum of idle tasks on A is very high (easily
> possible with affinity restrictions). So I think we should leave
> regular load balance alone here if it really wants to move the
> non-idle task, and wrap this entire block in an if (env->idle ==
> CPU_SCHED_IDLE).

Makes sense. I will fix it in next version.

Thanks & BR,
Abel

