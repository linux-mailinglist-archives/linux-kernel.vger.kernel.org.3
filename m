Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F94E9B40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiC1PmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiC1PmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:42:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99543AF2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:40:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p17so15051806plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V4B3cVDWrbbBKoT42lJtYAJc9SI6UbkqzMPjtyZrOXA=;
        b=ziNrZpqPGEUvPrM+evh8rrhBOuM9dhfu3BOPTD4Jw0izY2WtaFLWGyWy1j0LeKGpZH
         0okej7ka7uOedEdOm4dNf9KdwF8biNfeZKEATn2/wsxRC6OkWyBRktITvM/PvGeucm7P
         8OsDef7qAdfFtPtpsxmQVDrtOhC9X/3uyqHN0fkcbZqO7vjK/9uLiCcK1TU2ZEvXphOD
         3ZM92yTyuBoW2WsKWw3S1E/qzAo26MehONTq/N9pYBHmZkgQBUqM/Fnxr8ZTZu76XEMX
         JJNzBPezIou1i0rGvw93d8JH4NjAw47yYRz58pt7g94/HgU7YftzQRNZMD9kTXQxbPiH
         7K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V4B3cVDWrbbBKoT42lJtYAJc9SI6UbkqzMPjtyZrOXA=;
        b=xv7bvGgwZM9i0NotoN6JtTpRjCOOvatDNrjBtGDw6uJvtEOFaguByMgeT7Ay9yHEmc
         x3aqMeEINmzWAvb5vQ4BpvWCNgqOYrN9GCcUMvoXJ/RVDwx6hHXDF8RK80+zDACxTRei
         8G8arT55NoIIdLfdqaARsqW0Vv95vCS9vV7hmutRm33EeWbDDz//1XxAusvV0X88+6ih
         r91ixOwvFnmzMDAKOygnnExUsSvRt46CyNbvqk/9ElctIBzZ1nvqLgCHid0qQYszIAgW
         ImXA+kn4Bk02ovbVmqLjkw1GJgR1gWXT6Rw4KwJrc/ASKOMMl5Kxv+7u4c6zNYFa9oN2
         7jFQ==
X-Gm-Message-State: AOAM531DATrGZmjg9+DnflR1Dpt3jcjxNVhnfv47AJkr2xaPPbcRLNRc
        LpsTmGexJ4gxETCuqX+VvzZp3A==
X-Google-Smtp-Source: ABdhPJz9rkRGO+wvNnjR2JcGlVBRNs1B1ZTC+2RzVjDVXj+wq+mNsWXNqMkDenQ0W7Rw/roHN9NEvQ==
X-Received: by 2002:a17:902:a981:b0:156:229d:6834 with SMTP id bh1-20020a170902a98100b00156229d6834mr1514119plb.128.1648482032388;
        Mon, 28 Mar 2022 08:40:32 -0700 (PDT)
Received: from [10.254.141.91] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm16771124pfk.88.2022.03.28.08.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 08:40:31 -0700 (PDT)
Message-ID: <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
Date:   Mon, 28 Mar 2022 23:40:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
 <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/28 23:17, Peter Zijlstra wrote:
> On Mon, Mar 28, 2022 at 09:50:05PM +0800, Chengming Zhou wrote:
>> On 2022/3/28 21:20, Peter Zijlstra wrote:
>>> On Mon, Mar 28, 2022 at 07:07:51PM +0800, Chengming Zhou wrote:
>>>> With nohz_full enabled on cpu, the scheduler_tick() will be stopped
>>>> when only one CFS task left on rq.
>>>>
>>>> scheduler_tick()
>>>>   task_tick_fair()
>>>>     entity_tick()
>>>>       update_curr()
>>>>         account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped
>>>>
>>>> So that running task can't account its runtime periodically, but
>>>> the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
>>>> periodically. Later in one period, the task would account very
>>>> big delta_exec, which cause the cfs_rq to be throttled for a
>>>> long time.
>>>>
>>>> There are two solutions for the problem, the first is that we
>>>> can check in sched_can_stop_tick() if current task's cfs_rq
>>>> have runtime_enabled, in which case we don't stop tick. But
>>>> it will make nohz_full almost useless in cloud environment
>>>> that every container has the cpu bandwidth control setting.
>>>
>>> How is NOHZ_FULL useful in that environment to begin with? If you set
>>> bandwidth crap, the expectation is that there is overcommit, which more
>>> or less assumes lots of scheduling, presumably VMs or somesuch crud.
>>>
>>> So how does NOHZ_FULL make sense?
>>
>> Yes, we have scheduled some VMs in cgroups on the host, which
>> enabled NOHZ_FULL to reduce the interference of tick to vcpu task
>> if it's the only task running on cpu.
>>
>> This problem will however throttle it wrongly, even if it hasn't
>> used up its quota.
>>
>> Do you suggest that we shouldn't stop tick when the current task's
>> cfs_rq has runtime_enabled ?
> 
> I'm not suggesting anything just yet as I'm not sure I understand things
> well enough. I'm just wondering if NOHZ_FULL makes sense for you since
> NOHZ_FULL makes system entry/exit so much more expensive.

Ok, I see. It seems a normal use-case that run VMs on system with NOHZ_FULL
enabled, and set bandwidth for overcommit. At some times, the cpu will
stop tick when low load.

> 
> NOHZ_FULL is for use-cases that 'never' intend to go into the kernel,
> your use-case actively relies on going into the kernel. Hence the
> confusion.

In fact, I put a testcase at the end of git message, in which only run
a userspace loop workload:

cd /sys/fs/cgroup
echo "+cpu" > cgroup.subtree_control

mkdir test
echo "105000 100000" > test/cpu.max

echo $$ > test/cgroup.procs
taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled

Thanks.

