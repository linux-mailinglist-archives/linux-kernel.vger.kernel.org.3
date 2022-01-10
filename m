Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3F488DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiAJBVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:21:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16693 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiAJBVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:21:09 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JXGCK6ttgzVfmC;
        Mon, 10 Jan 2022 09:17:33 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:20:33 +0800
Subject: Re: [PATCH -next] sched: Use struct_size() helper in
 task_numa_group()
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20220107025212.177040-1-xiujianfeng@huawei.com>
 <20220107093617.56e218dc@gandalf.local.home>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <263460ee-c97f-73cf-fcbc-e47eb0e2905f@huawei.com>
Date:   Mon, 10 Jan 2022 09:20:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220107093617.56e218dc@gandalf.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/1/7 22:36, Steven Rostedt Ð´µÀ:
> On Fri, 7 Jan 2022 10:52:12 +0800
> Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
>> Make use of struct_size() helper instead of an open-coded calculation.
>> There is no functional change in this patch.
>>
>> Link: https://github.com/KSPP/linux/issues/160
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   kernel/sched/fair.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 095b0aa378df..265e37be0c92 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2437,11 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
>>   	int i;
>>   
>>   	if (unlikely(!deref_curr_numa_group(p))) {
>> -		unsigned int size = sizeof(struct numa_group) +
>> -				    NR_NUMA_HINT_FAULT_STATS *
>> -				    nr_node_ids * sizeof(unsigned long);
>> -
>> -		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
>> +		grp = kzalloc(struct_size(grp, faults, NR_NUMA_HINT_FAULT_STATS * nr_node_ids),
>> +			      GFP_KERNEL | __GFP_NOWARN);
> I just replied yesterday. Keep the size variable. The above is too much for
> a kzalloc().

thanks, I may missed your reply mail, I'll modify and resend this patch.

>
> -- Steve
>
>
>
>
>>   		if (!grp)
>>   			return;
>>   
> .
