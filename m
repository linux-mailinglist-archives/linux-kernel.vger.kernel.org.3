Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA64E9C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbiC1QhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiC1QhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:37:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E54EA09
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:35:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id b130so11225268pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vk77d+0Kc7DWFXj6xs6aYSWNHloUJ9SME5XaB8pmN0g=;
        b=MVsgivSN2ISec4Pob7oOW99fNO7H6pTfq5sq9jLNLxDpR4WuNXdeLGhtd3Fu42tHOj
         AoT27tQmiZZk+wrjDnd4Ftv3vVo/yto0m8UxjaB/WAW57mOgGRkhQgQIkQQARBat7M1Y
         dnuVfy8aw9hbGZIiGaVCF067aPwVgPx1Wo2Yhg8gyFAux2AmuIAUX+H6Spo1Puh1TM+a
         wYzFQat3v6GvOtZLtwqU6ZFd2zjufMnuvOcSATf2dHFGhn5RWn/olLpdBEKHr8LaL+hD
         WdHvffmw3QxrplHlgPd2IqPP2/5Ewu7blWfrPw2/qcJR+roIH1/tVajAEnAXLlTcLIcC
         RQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vk77d+0Kc7DWFXj6xs6aYSWNHloUJ9SME5XaB8pmN0g=;
        b=QHeYtjLurrxeGDTUpQ/3jEuEVdYQ03cFcqoDfLK1E2ans1/MmjlC70/mkAm++q8So2
         z7QzX2+8Q+tOBZeNEv7tie29vD/FgarZdZiUCKva3+EVH3pX0js5BSSJRv1OwAry7BIO
         5CAleHf/EzW6kHXKw0hXA77TNUK654SgP+ywy8opAa8LHl2Qxgge0yShim664ypamJ6p
         YddoYpKLEM11yma/m81JFaNjXv/T6aoD0Ciq1uFMAnVZZEqYqTO2mGlCH4LG20uFitFJ
         qDBtJyVCL2O7/sjavz9i2jJD74hVrwTgWPtZLRJ056Pb8zDh6YSvj9hZhkDRZr9pMkYt
         lMzA==
X-Gm-Message-State: AOAM532WK9SkIppm6VkZdMhfdg7Jya8d8hvfQYc+eGj/P2oihbPhSsEB
        1AwCaVb4n9iR8LT2oFWz1QGqIw==
X-Google-Smtp-Source: ABdhPJxknusVhxPrxeY+oa20v4VonS+Ltx8QGrc1Yyi+Gao+OuPqoiqyoIfm7iXs2RJIyiQLbKWpHw==
X-Received: by 2002:a62:cd83:0:b0:4fa:7410:6d86 with SMTP id o125-20020a62cd83000000b004fa74106d86mr24579791pfg.52.1648485325297;
        Mon, 28 Mar 2022 09:35:25 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6c:aaa0:b49b:a46e:8f1f:6bcd? ([2409:8a28:e6c:aaa0:b49b:a46e:8f1f:6bcd])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a000bd900b004faae43da95sm15923707pfu.138.2022.03.28.09.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 09:35:24 -0700 (PDT)
Message-ID: <933ecd2d-fe2f-3b52-f2f0-c5b1a132dd81@bytedance.com>
Date:   Tue, 29 Mar 2022 00:35:11 +0800
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
 <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
 <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
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

On 2022/3/28 23:56, Peter Zijlstra wrote:
> On Mon, Mar 28, 2022 at 11:40:25PM +0800, Chengming Zhou wrote:
> 
>>> NOHZ_FULL is for use-cases that 'never' intend to go into the kernel,
>>> your use-case actively relies on going into the kernel. Hence the
>>> confusion.
>>
>> In fact, I put a testcase at the end of git message, in which only run
>> a userspace loop workload:
>>
>> cd /sys/fs/cgroup
>> echo "+cpu" > cgroup.subtree_control
>>
>> mkdir test
>> echo "105000 100000" > test/cpu.max
>>
>> echo $$ > test/cgroup.procs
>> taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled
> 
> Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
> mutually exclusive, use-case wise. So I really don't get why you'd want
> them both.

This problem is found by our VM team, they use bandwidth for overcommit,
share CPUs between two VMs.

> 
> NOHZ_FULL says, "I 'never' intend to go to the kernel"

Like VCPU seldom kvm_exit to the kernel, stop tick is helpful for performance,
since kvm_exit is more expensive.

> 
> bandwidth control says: "I expect to be sharing the system and must be
> interrupted to not consume too much time", which very much implies: "I
> will go into the kernel".

Yes, agree. If the tasks in the task_group used up quota, they have to
go into the kernel to resched out.

> 
> The trade-off we make to make NOHZ_FULL work, makes system enter/exit
> *far* more expensive. There's also people asking to outright kill a task
> that causes entry under NOHZ_FULL.

It's correct that the task under NOHZ_FULL shouldn't often enter/exit.

> 
> So yes, you can configure it, but why does it make sense?

I don't know if other people have the same use-case, or is there other
better way to do VMs overcommit and bandwidth...

Thanks.

