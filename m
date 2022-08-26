Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408495A21B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbiHZHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245250AbiHZHX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:23:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF2D31D9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:23:56 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDWVr63VqzGpq2;
        Fri, 26 Aug 2022 15:22:12 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:23:54 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:23:53 +0800
Message-ID: <93f6bfae-7c2c-69e5-720c-89ba63e3a3fe@huawei.com>
Date:   Fri, 26 Aug 2022 15:23:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] sched/deadline: Add compare_task_rq helper
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220826031143.9501-1-shangxiaojing@huawei.com>
 <c5d40522-037d-e324-697b-23e5e4686d58@redhat.com>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <c5d40522-037d-e324-697b-23e5e4686d58@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


On 2022/8/26 15:10, Daniel Bristot de Oliveira wrote:
> On 8/26/22 05:11, Shang XiaoJing wrote:
>> Wrap repeated code in helper function compare_task_rq, which return true
>> if there is no deadline task on the rq at all, or task's deadline
>> earlier than the rq.
>>
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   kernel/sched/deadline.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index d116d2b9d2f9..4a40a462717c 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -1810,6 +1810,13 @@ static void yield_task_dl(struct rq *rq)
>>   
>>   #ifdef CONFIG_SMP
> I see the value of this helper, but "compare_task_rq" is making things more confuse.
>
> Choose a more descriptive name, like, dl_task_is_earliest_deadline() ?

ok, i'll find a better name, or take your advice directly in v2.

>> +static inline bool compare_task_rq(struct task_struct *p, struct rq *rq)
>> +{
>> +	return (!rq->dl.dl_nr_running ||
>> +		dl_time_before(p->dl.deadline,
>> +			       rq->dl.earliest_dl.curr));
>> +}
>> +
> -- Daniel

Thanks :-) ,

Shang XiaoJing

