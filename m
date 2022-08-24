Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6059F458
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiHXHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiHXHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:30:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1F13E17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:29:57 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCHk073VHzmVCK;
        Wed, 24 Aug 2022 15:27:36 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:29:41 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:29:40 +0800
Message-ID: <e99506e7-cf6f-609c-8a28-e92dacf65d73@huawei.com>
Date:   Wed, 24 Aug 2022 15:29:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] sched: Add update_current_exec_runtime helper
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220824065326.10583-1-shangxiaojing@huawei.com>
 <YwXHeHQnvRFxS1ct@worktop.programming.kicks-ass.net>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <YwXHeHQnvRFxS1ct@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/24 14:38, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 02:53:26PM +0800, Shang XiaoJing wrote:
>
> In general I like, however:
>
>> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
>> index d04073a93eb4..027068779126 100644
>> --- a/kernel/sched/stop_task.c
>> +++ b/kernel/sched/stop_task.c
>> @@ -80,11 +80,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
>>   	schedstat_set(curr->stats.exec_max,
>>   		      max(curr->stats.exec_max, delta_exec));
>>   
>> -	curr->se.sum_exec_runtime += delta_exec;
>> -	account_group_exec_runtime(curr, delta_exec);
>> -
>> -	curr->se.exec_start = rq_clock_task(rq);
>> -	cgroup_account_cputime(curr, delta_exec);
>> +	update_current_exec_runtime(curr, rq_clock_task(rq), delta_exec);
>>   }
> This already has a rq_clock_task() invocation; please fix it to call it
> once -- pre-existing issue, but if we're cleaning up we should clean up,
> right :-)

Right, the redundant invocation of rq_clock_task() will be removed in v2.


Thanks :-) ,

Shang XiaoJing

