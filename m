Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B494C42B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiBYKrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiBYKrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:47:06 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549285F44
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:46:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id p8so4330214pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w/XZsR5U4bk6AIH6QpADGOhv0TAfbBN64RGsc62N160=;
        b=umPJ29rPDkbG8vd66olReKLLkSk60RSR9xtgVbjShAtqGoGGnVS3soe8k29hGbtseR
         SQH/XWMxwNxYBb7+CYcfMBb3RpLdgN3zKDPTR+nFbT+R5slWMfykjlsIaLAwwaXnbJ+0
         rtOIgqWmHDbZflADIvfvim74ZmwTgyJqyBzflFsm96LxYHW0bL71z771qiorQpWwyqjV
         lPNZRhhv/M8Z0+NmcLShUUiHjD7I613PqWiOws7SyTxBpFTh9ExI9aFdWeWYO4VoCrwg
         6PAK44lSb1j3ildqgolujuqR83SxyGTQt4QaiF/9XScFW6WDph2Fb6E27CwuU0aX1cVj
         ugKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w/XZsR5U4bk6AIH6QpADGOhv0TAfbBN64RGsc62N160=;
        b=ozRI9JOnsLh/cHteZtIBF7gg//ZKolX5hI69xjHRi7o/ryREXV+UpKFWAI6BS1ZLVn
         0DUmMVh6tu9MXPiWVwFkvHQ6uGS2zXG9l8GtvdaGLHUMf11nrfDoNonaMCKLwQc14I+e
         7+cJiODIDd3TVHR3USNCXTOUuHXyLyKIEjN/ouLiU+Awtwf/HTG1ObCV9u0Prq1IHsJ1
         ADQktPx//qD3A7FbnERgI4veeLcMQgtXUEN9Oyp63QfrQE4epmEuNu9zNw68VDxqxYEL
         E41fAYDJ5IR+CQMq6LosBQkukfgzLCYfaPJlW5sVJAwOaeHS7Fx//XLjNf9f/XgTaS34
         lzCw==
X-Gm-Message-State: AOAM531txwkSx6bSIngfIh1v0Lc207uNLwDvZTB5Z51FMVssg9hiXTwW
        BmmcoCXaoDfXHatbruhKN6OSPg==
X-Google-Smtp-Source: ABdhPJwxjvlqMi7cIZFcxGERhX1+e+n/eoefHIc8QBanJvz5GFTrwUAtFktxaVcr54T6Ei0IUwS0hQ==
X-Received: by 2002:a05:6a00:148f:b0:4bc:fb2d:4b6f with SMTP id v15-20020a056a00148f00b004bcfb2d4b6fmr7036987pfu.62.1645785992824;
        Fri, 25 Feb 2022 02:46:32 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id u37-20020a056a0009a500b004e1414d69besm2791022pfg.151.2022.02.25.02.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 02:46:32 -0800 (PST)
Message-ID: <d4557587-b52c-049d-a0c8-e48aaa8a1c1e@bytedance.com>
Date:   Fri, 25 Feb 2022 18:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
 <9fe00f72-4e2e-38ff-d64a-4ae41e683316@bytedance.com>
 <CAKfTPtD7U7=C8MTLLMtUrGxJFCjpxtU7a_S=HaBhCsZ6SBbVFA@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtD7U7=C8MTLLMtUrGxJFCjpxtU7a_S=HaBhCsZ6SBbVFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 4:29 PM, Vincent Guittot Wrote:
> On Fri, 25 Feb 2022 at 07:46, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/24/22 11:20 PM, Peter Zijlstra Wrote:
>>> On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
>>>> Current load balancing is mainly based on cpu capacity
>>>> and task util, which makes sense in the POV of overall
>>>> throughput. While there still might be some improvement
>>>> can be done by reducing number of overloaded cfs rqs if
>>>> sched-idle or idle rq exists.
>>>
>>> I'm much confused, there is an explicit new-idle balancer and a periodic
>>> idle balancer already there.
>>
>> The two balancers are triggered on the rqs that have no tasks on them,
>> and load_balance() seems don't show a preference for non-idle tasks so
> 
> The load balance will happen at the idle pace if a sched_idle task is
> running on the cpu so you will have an ILB on each cpu that run a
> sched-idle task

I'm afraid I don't quite follow you, since sched-idle balancer doesn't
touch the ILB part, can you elaborate on this? Thanks.

> 
>> there might be possibility that only idle tasks are pulled during load
>> balance while overloaded rqs (rq->cfs.h_nr_running > 1) exist. As a
> 
> There is a LB_MIN feature (disable by default) that filters task with
> very low load ( < 16) which includes sched-idle task which has a max
> load of 3

This feature might not that friendly to the situation that only
sched-idle tasks are running in the system. And this situation
can last more than half a day in our co-location systems in which
the training/batch tasks are placed under idle groups or directly
assigned to SCHED_IDLE.

> 
>> result the normal tasks, mostly latency-critical ones in our case, on
>> that overloaded rq still suffer waiting for each other. I observed this
>> through perf sched.
>>
>> IOW the main difference from the POV of load_balance() between the
>> latency-critical tasks and the idle ones is load.
>>
>> The sched-idle balancer is triggered on the sched-idle rqs periodically
>> and the newly-idle ones. It does a 'fast' pull of non-idle tasks from
>> the overloaded rqs to the sched-idle/idle ones to let the non-idle tasks
>> make full use of cpu resources.
>>
>> The sched-idle balancer only focuses on non-idle tasks' performance, so
>> it can introduce overall load imbalance, and that's why I put it before
>> load_balance().
> 
> According to the very low weight of a sched-idle task, I don't expect
> much imbalance because of sched-idle tasks. But this also depends of
> the number of sched-idle task.
> 
> 
>>
>> Best Regards,
>>          Abel
