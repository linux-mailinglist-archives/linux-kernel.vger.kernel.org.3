Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9743B57083F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiGKQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:25:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7695E300
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:25:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so8857746pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=BPhJH0MLoINdfm+rNmFxczEpiCfv79Umthkksu8H/nE=;
        b=4E1vSjWhn3rCJNEAcf8j8dtnRVVsX9kiNmn8NL7YezF4+w1raZiDkMAm2jb2M9uzLu
         p8yCWXX0rnYf1L2J2WjAZqGa69ckfC+tOMRLcKZN+qyAKOKN42zqqGsisXopPj3qD6jN
         Qt2BBHJyUAfVeJIK/KqhVFNFbmR9DABCsEYYDrYFnV4xYSIT8e5xiZfJGbhjDz4kW4aW
         mWZCj+M0dGdFHL5xIMcKcz3RSapEyD+FddCo1p4IuykVlI660ixvQU0ZO+UiI/fX0In1
         Tu1uO1YB3Hb0gRki8oVUYw3ldePac4hBI/ZDtAnp1mPpjc88dEKmCby6M2LWkRlq+ksV
         8hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=BPhJH0MLoINdfm+rNmFxczEpiCfv79Umthkksu8H/nE=;
        b=Ue66s58zjrpr1PrwS4gs+/PwNPCrHbhNiC38LkjqTSVRc8/Z4YRYYkMtHMAoLY4Q96
         zR4bRLjUj6eWJojukUV+Lc7rgaqznyJo3XSKJF+SfsHhfaitXGZWhVNzM704LdWCLsNS
         xeXyYAZ3lN83ZnQkln77V/TgWt+o69XcT+2H6S/vPZhWp3Qef3C1n5NcLs29Vv63lpyQ
         HRuZuBfucDBA+n14TBaJGdYvR6bjG2EmFhxLiXwDii1WX71NPXvsIN6Az7dZAN4VKJw8
         yID2BkZJuTv7iuQPemD0QY/Wcb8YrlDxBdC5ObNCAV1D0HGxNgumip4VbwtsrKkj25vN
         DiSQ==
X-Gm-Message-State: AJIora8JrG0PYR1SidqqzT8DLTFBhF1BdmkA/u4IPSgIicAg9xAe4Ptd
        e0JTFf0TT+eZWts/Li4zW5sIkw==
X-Google-Smtp-Source: AGRyM1slVwI0IPIfQ0RoRe6poKikBoXu8NPgJZ9WmMXOqJuONkVoZsnCsPWKqFc+uMzf47XF7zJ4bA==
X-Received: by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id e6-20020a170902ef4600b00168bac32fd4mr19360903plx.132.1657556713303;
        Mon, 11 Jul 2022 09:25:13 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79409000000b005284e98304csm4928155pfo.205.2022.07.11.09.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:25:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
X-Google-Original-From: Chengming Zhou <chengming.zhou@linux.dev>
Message-ID: <e93b5c38-0291-d6e4-811a-9aed3d6e0f87@linux.dev>
Date:   Tue, 12 Jul 2022 00:25:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH 3/8] sched/fair: remove redundant
 cpu_cgrp_subsys->fork()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
 <20220709151353.32883-4-zhouchengming@bytedance.com>
 <YsvSpyrJxNv7jsQz@hirez.programming.kicks-ass.net>
 <a41b3436-6875-d3aa-a110-6c438c97126e@bytedance.com>
 <YswrSi46s+XLD18R@hirez.programming.kicks-ass.net>
In-Reply-To: <YswrSi46s+XLD18R@hirez.programming.kicks-ass.net>
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

On 2022/7/11 21:53, Peter Zijlstra wrote:
> On Mon, Jul 11, 2022 at 09:02:07PM +0800, Chengming Zhou wrote:
>> On 2022/7/11 15:35, Peter Zijlstra wrote:
>>> On Sat, Jul 09, 2022 at 11:13:48PM +0800, Chengming Zhou wrote:
>>>> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
>>>> in cgroup_post_fork().
>>>>
>>>> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
>>>> has already set task group for the new fair task in sched_cgroup_fork(),
>>>> so cpu_cgrp_subsys->fork() can be removed.
>>>>
>>>>   cgroup_can_fork()	--> pin parent's sched_task_group
>>>>   sched_cgroup_fork()
>>>>     __set_task_cpu	--> set task group
>>>>   cgroup_post_fork()
>>>>     ss->fork() := cpu_cgroup_fork()	--> set again
>>>>
>>>> After this patch's change, task_change_group_fair() only need to
>>>> care about task cgroup migration, make the code much simplier.
>>>
>>> This:
>>>
>>>> This patch also move the task se depth setting to set_task_rq(), which
>>>> will set correct depth for the new task se in sched_cgroup_fork().
>>>>
>>>> The se depth setting in attach_entity_cfs_rq() is removed since
>>>> set_task_rq() is a better place to do this when task moves across
>>>> CPUs/groups.
>>>
>>> really should have been it's own patch. And this actually scares me. Did
>>> you test with priority inheritance bumping the task to FIFO while things
>>> change?
>>>
>>> This has nothing to do with fork().
>>
>> Ok, will put this in another patch, so this patch still need this line:
>>
>>   p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>>
>> in set_task_rq() to set depth for new forked task.
> 
> That would suggest you ordered your patches wrong.

Yeah, I understand now, should put this se depth change before..

> 
>> I didn't test with "priority inheritance bumping the task to FIFO" case,
>> do you mean the rt_mutex_setprio() bump a fair task to FIFO?
>>
>> Sorry, I don't get how removing depth setting in attach_entity_cfs_rq()
>> affect that. Could you explain more so I can test it?
> 
> Well, if you look at the commit that introduced that code:
> 
>   eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")
> 
> then it's clear that the original problem was the task temporarily not
> being in the fair class. The most common way for that to be so is
> through PI.

Thanks for the hint, I read that commit, should be no problem if we have
se depth setting in set_task_rq().

That problem was we only maintain task se depth in task_move_group_fair(),
if a !fair task move task group, its se depth will not be updated, so
that commit fix the problem by update se depth in switched_to_fair().

In this patch we maintain se depth setting in set_task_rq(), which will be
called when CPU/cgroup change, so its depth will always be correct. So it's
ok to remove task se depth setting in attach_entity_cfs_rq().

Thanks.


> 
