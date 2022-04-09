Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF04FA19A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiDICTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiDICTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:19:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BD07E083;
        Fri,  8 Apr 2022 19:17:41 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZzK01qTdzdZXM;
        Sat,  9 Apr 2022 10:17:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:17:38 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 10:17:37 +0800
Subject: Re: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads
 based on required tags
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-9-yukuai3@huawei.com>
 <6470d923-8fa5-cda1-e519-6f890cdcb00a@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <4c322eee-3ad9-812f-a341-aa5e91573912@huawei.com>
Date:   Sat, 9 Apr 2022 10:17:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6470d923-8fa5-cda1-e519-6f890cdcb00a@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

在 2022/04/09 5:13, Bart Van Assche 写道:
> On 4/8/22 00:39, Yu Kuai wrote:
>> +static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned 
>> int nr_tags)
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
> An additional comment: my understanding is that __sbq_wake_up() should 
> wake up exactly `wake_batch` waiters. The above patch changes that into 
> waking up at most `wake_batch` waiters. I think that's wrong.
Hi,

I think the reason to wake up 'wake_batch' waiters is to make sure
wakers will use up 'wake_batch' tags that is just freed, because each
wakers should aquire at least one tag. Thus I think if we can make sure
wakers will use up 'wake_batch' tags, it's ok to wake up less waiters.

Please kindly correct me if I'm wrong.

Thanks,
Kuai
> 
> Bart.
> .
> 
