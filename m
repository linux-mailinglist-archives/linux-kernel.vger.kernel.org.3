Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF54FA19D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiDICVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDICVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:21:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796526133D;
        Fri,  8 Apr 2022 19:19:36 -0700 (PDT)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZzGx0HQ2zBrWn;
        Sat,  9 Apr 2022 10:15:21 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:19:34 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 10:19:33 +0800
Subject: Re: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads
 based on required tags
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-9-yukuai3@huawei.com>
 <5d84c02f-62c6-6418-6629-cebd42dc2ca5@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <37ecdcd6-3130-fb92-295b-fbb23b53148f@huawei.com>
Date:   Sat, 9 Apr 2022 10:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d84c02f-62c6-6418-6629-cebd42dc2ca5@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/04/08 22:31, Bart Van Assche 写道:
> On 4/8/22 00:39, Yu Kuai wrote:
>> Always wake up 'wake_batch' threads will intensify competition and
>> split io won't be issued continuously. Now that how many tags is required
>> is recorded for huge io, it's safe to wake up baed on required tags.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   lib/sbitmap.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 8d01e02ea4b1..eac9fa5c2b4d 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -614,6 +614,26 @@ static inline void sbq_update_preemption(struct 
>> sbitmap_queue *sbq,
>>       WRITE_ONCE(sbq->force_tag_preemption, force);
>>   }
>> +static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned 
>> int nr_tags)
> 
> Consider renaming "get_wake_nr()" into "nr_to_wake_up()".
> 
>> +{
>> +    struct sbq_wait *wait;
>> +    struct wait_queue_entry *entry;
>> +    unsigned int nr = 1;
>> +
>> +    spin_lock_irq(&ws->wait.lock);
>> +    list_for_each_entry(entry, &ws->wait.head, entry) {
>> +        wait = container_of(entry, struct sbq_wait, wait);
>> +        if (nr_tags <= wait->nr_tags)
>> +            break;
>> +
>> +        nr++;
>> +        nr_tags -= wait->nr_tags;
>> +    }
>> +    spin_unlock_irq(&ws->wait.lock);
>> +
>> +    return nr;
>> +}
>> +
>>   static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>>   {
>>       struct sbq_wait_state *ws;
>> @@ -648,7 +668,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>>       smp_mb__before_atomic();
>>       atomic_set(&ws->wait_cnt, wake_batch);
>>       sbq_update_preemption(sbq, wake_batch);
>> -    wake_up_nr(&ws->wait, wake_batch);
>> +    wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
>>       return true;
>>   }
> 
> ws->wait.lock is unlocked after the number of threads to wake up has 
> been computed and is locked again by wake_up_nr(). The ws->wait.head 
> list may be modified after get_wake_nr() returns and before wake_up_nr() 
> is called. Isn't that a race condition?
Hi,

That is a race condition, I was hoping that the problem patch 5 fixed
can cover this.

Thanks,
Kuai
> 
> Thanks,
> 
> Bart.
> .
> 
