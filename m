Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15958A7CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbiHEIKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiHEIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:10:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C174E28;
        Fri,  5 Aug 2022 01:09:54 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LzdSs1ktGzWfKZ;
        Fri,  5 Aug 2022 16:05:49 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 16:09:25 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 16:09:24 +0800
Subject: Re: [PATCH v4 0/2] rcu: Display registers of self-detected stall as
 far as possible
To:     <paulmck@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20220804023420.1663-1-thunder.leizhen@huawei.com>
 <20220804180958.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5da6eaf0-6570-caff-4eec-79d73b4f5062@huawei.com>
Date:   Fri, 5 Aug 2022 16:09:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220804180958.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/5 2:09, Paul E. McKenney wrote:
> On Thu, Aug 04, 2022 at 10:34:18AM +0800, Zhen Lei wrote:
>> v3 --> v4:
>> 1. To avoid undo/redo, merge patch 1-2 in v3 into one.
>>
>> v2 --> v3:
>> 1. Patch 1 Add trigger_single_cpu_backtrace(cpu) in synchronize_rcu_expedited_wait()
>>    Subsequently, we can see that all callers of dump_cpu_task() try
>>    trigger_single_cpu_backtrace() first. Then I do the cleanup in Patch 2.
>> 2. Patch 3, as Paul E. McKenney's suggestion, push the code into dump_cpu_task().
>>
>> For newcomers:
>> Currently, dump_cpu_task() is mainly used by RCU, in order to dump the
>> stack traces of the current task of the specified CPU when a rcu stall
>> is detected.
>>
>> For architectures that do not support NMI interrupts, registers is not
>> printed when rcu stall is self-detected. This patch series improve it.
> 
> Thank you!  I have queued both for further testing and review.  I had
> to rebase them to the -rcu tree's "dev" branch.  There was one trivial
> conflict, but could you please check the resulting commits, both for
> my wordsmithing and to make sure that your changes still work in your
> environment?  (I do not have access to that sort of hardware.)

Your description is much clearer than mine, thanks. I will test it
tomorrow, the international network speed is too slow during the day.

> 
> In the future, could you please send your patches against the -rcu
> tree's "dev" branch?

Okay, no problem. I'll do it next time.

> 
> 							Thanx, Paul
> 
>> v2:
>> https://lkml.org/lkml/2022/7/27/1800
>>
>> Zhen Lei (2):
>>   sched/debug: Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task()
>>   sched/debug: Show the registers of 'current' in dump_cpu_task()
>>
>>  kernel/rcu/tree_stall.h |  8 +++-----
>>  kernel/sched/core.c     | 14 ++++++++++++++
>>  kernel/smp.c            |  3 +--
>>  3 files changed, 18 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
