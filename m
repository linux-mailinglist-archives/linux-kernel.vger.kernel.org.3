Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2576C559A42
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiFXNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFXNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:16:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA850E1C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:16:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTyJq0vxkzkWYH;
        Fri, 24 Jun 2022 21:14:51 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 21:16:05 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 21:16:05 +0800
Message-ID: <409fc8d0-119a-3358-0fc5-99a786a9564a@huawei.com>
Date:   Fri, 24 Jun 2022 21:16:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Perf regression from scheduler load_balance rework in 5.5?
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        David Chen <david.chen@nutanix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
 <CAKfTPtA7wJBROfRkSQV7FzWaWqoaQjSO7iyqBt6AgGsv2OsNSw@mail.gmail.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <CAKfTPtA7wJBROfRkSQV7FzWaWqoaQjSO7iyqBt6AgGsv2OsNSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
在 2022/6/24 16:22, Vincent Guittot 写道:
> On Thu, 23 Jun 2022 at 21:50, David Chen <david.chen@nutanix.com> wrote:
>>
>> Hi,
>>
>> I'm working on upgrading our kernel from 4.14 to 5.10
>> However, I'm seeing performance regression when doing rand read from windows client through smbd
>> with a well cached file.
>>
>> One thing I noticed is that on the new kernel, the smbd thread doing socket I/O tends to stay on
>> the same cpu core as the net_rx softirq, where as in the old kernel it tends to be moved around
>> more randomly. And when they are on the same cpu, it tends to saturate the cpu more and causes
>> performance to drop.
>>
>> For example, here's the duration (ns) the thread spend on each cpu I captured using bpftrace
>> On 4.14:
>> @cputime[7]: 20741458382
>> @cputime[0]: 25219285005
>> @cputime[6]: 30892418441
>> @cputime[5]: 31032404613
>> @cputime[3]: 33511324691
>> @cputime[1]: 35564174562
>> @cputime[4]: 39313421965
>> @cputime[2]: 55779811909 (net_rx cpu)
>>
>> On 5.10:
>> @cputime[3]: 2150554823
>> @cputime[5]: 3294276626
>> @cputime[7]: 4277890448
>> @cputime[4]: 5094586003
>> @cputime[1]: 6058168291
>> @cputime[0]: 14688093441
>> @cputime[6]: 17578229533
>> @cputime[2]: 223473400411 (net_rx cpu)
>>
>> I also tried setting the cpu affinity of the smbd thread away from the net_rx cpu and indeed that
>> seems to bring the perf on par with old kernel.

I observed the same problem for the past two weeks.

>>
>> I noticed that there's scheduler load_balance rework in 5.5, so I did the test on 5.4 and 5.5 and
>> it did show the behavior changed between 5.4 and 5.5.
> 
> Have you tested v5.18 ? several improvements happened since v5.5
> 
>>
>> Anyone know how to work around this?
> 
> Have you enabled IRQ_TIME_ACCOUNTING ?


CONFIG_IRQ_TIME_ACCOUNTING=y.

> 
> When the time spent under interrupt becomes significant, scheduler
> migrate task on another cpu


My board has two cpus, and i used iperf3 to test upload bandwidth，then I saw the same situation，
the iperf3 thread run on the same cpu as the NET_RX softirq.

After debug in find_busiest_group(), i noticed when the cpu(env->idle is CPU_IDLE or CPU_NEWLY_IDLE) try to pull task,
the busiest->group_type == group_fully_busy, busiest->sum_h_nr_running == 1, local->group_type==group_has_spare,
and the loadbalance will failed at find_busiest_group(), as follows:

find_busiest_group():
    ...
    if (busiest->group_type != group_overloaded) {
	....
	if (busiest->sum_h_nr_running == 1)
		goto out_balanced;     ----> loadbalance will returned at here.
....


Thanks,
Qiao


> Vincent>>
>> Thanks,
>> David
> .
> 
