Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0F571B20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiGLNZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiGLNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:25:32 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A68E4ED;
        Tue, 12 Jul 2022 06:25:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Lj1gd1sHjzKHnx;
        Tue, 12 Jul 2022 21:24:29 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgAHamlGds1iag20Ag--.36943S3;
        Tue, 12 Jul 2022 21:25:27 +0800 (CST)
Subject: Re: [PATCH RFC v3 1/3] sbitmap: fix that same waitqueue can be woken
 up continuously
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
 <20220710042200.20936-2-yukuai1@huaweicloud.com>
 <20220711142009.jz2ilqrxjgtwuvq6@quack3.lan>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0369ea84-f9ac-4992-5f1e-4f44d373b65d@huaweicloud.com>
Date:   Tue, 12 Jul 2022 21:25:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220711142009.jz2ilqrxjgtwuvq6@quack3.lan>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAHamlGds1iag20Ag--.36943S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw45tr1DKw1fGryxJF1UZFb_yoW5CF4Upa
        1UWFyvyF48tFy2kws2qF1UAw1YkwnFgr9rGr4rK3WjkrnrKr4ftr9Y9rs8ur18ZFsrCay8
        JF47tFZxWr4jqFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ÔÚ 2022/07/11 22:20, Jan Kara Ð´µÀ:
> On Sun 10-07-22 12:21:58, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> __sbq_wake_up		__sbq_wake_up
>>   sbq_wake_ptr -> assume	0
>> 			 sbq_wake_ptr -> 0
>>   atomic_dec_return
>> 			atomic_dec_return
>>   atomic_cmpxchg -> succeed
>> 			 atomic_cmpxchg -> failed
>> 			  return true
>>
>> 			__sbq_wake_up
>> 			 sbq_wake_ptr
>> 			  atomic_read(&sbq->wake_index) -> still 0
>>   sbq_index_atomic_inc -> inc to 1
>> 			  if (waitqueue_active(&ws->wait))
>> 			   if (wake_index != atomic_read(&sbq->wake_index))
>> 			    atomic_set -> reset from 1 to 0
>>   wake_up_nr -> wake up first waitqueue
>> 			    // continue to wake up in first waitqueue
>>
>> Fix the problem by using atomic_cmpxchg() instead of atomic_set()
>> to update 'wake_index'.
>>
>> Fixes: 417232880c8a ("sbitmap: Replace cmpxchg with xchg")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> I don't think this patch is really needed after the following patches.  As
> I see it, wake_index is just a performance optimization (plus a fairness
> improvement) but in principle the code in sbq_wake_ptr() is always prone to
> races as the waitqueue it returns needn't have any waiters by the time we
> return. So for correctness the check-and-retry loop needs to happen at
> higher level than inside sbq_wake_ptr() and occasional wrong setting of
> wake_index will result only in a bit of unfairness and more scanning
> looking for suitable waitqueue but I don't think that really justifies the
> cost of atomic operations in cmpxchg loop...

It's right this patch just improve fairness. However, in hevyload tests
I found that the 'wrong setting of wake_index' can happen frequently,
for consequence, some waitqueue can be empty while some waitqueue have
a lot of waiters.

There shoud be lots of work to fix unfairness throughly, I can remove
this patch for now.

Thanks,
Kuai
> 
> 								Honza
>> ---
>>   lib/sbitmap.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 29eb0484215a..b46fce1beb3a 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -579,19 +579,24 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>>   
>>   static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>>   {
>> -	int i, wake_index;
>> +	int i, wake_index, old_wake_index;
>>   
>> +again:
>>   	if (!atomic_read(&sbq->ws_active))
>>   		return NULL;
>>   
>> -	wake_index = atomic_read(&sbq->wake_index);
>> +	old_wake_index = wake_index = atomic_read(&sbq->wake_index);
>>   	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>>   		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>>   
>>   		if (waitqueue_active(&ws->wait)) {
>> -			if (wake_index != atomic_read(&sbq->wake_index))
>> -				atomic_set(&sbq->wake_index, wake_index);
>> -			return ws;
>> +			if (wake_index == old_wake_index)
>> +				return ws;
>> +
>> +			if (atomic_cmpxchg(&sbq->wake_index, old_wake_index,
>> +					   wake_index) == old_wake_index)
>> +				return ws;
>> +			goto again;
>>   		}
>>   
>>   		wake_index = sbq_index_inc(wake_index);
>> -- 
>> 2.31.1
>>

