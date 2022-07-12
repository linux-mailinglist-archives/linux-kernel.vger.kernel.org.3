Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520D9571B28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiGLN0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGLN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:26:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF6AB6B2;
        Tue, 12 Jul 2022 06:26:45 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lj1gh3gm4zkWtf;
        Tue, 12 Jul 2022 21:24:32 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 21:26:43 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 21:26:42 +0800
Subject: Re: [PATCH RFC v3 2/3] sbitmap: fix invalid wakeup on the wrong
 waitqueue
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
CC:     <axboe@kernel.dk>, <asml.silence@gmail.com>, <osandov@fb.com>,
        <kbusch@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
 <20220710042200.20936-3-yukuai1@huaweicloud.com>
 <20220711142623.haam2wks36xa5nde@quack3.lan>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <f755a9ad-6f0c-b675-c3ff-e4da930a8af8@huawei.com>
Date:   Tue, 12 Jul 2022 21:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220711142623.haam2wks36xa5nde@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ÔÚ 2022/07/11 22:26, Jan Kara Ð´µÀ:
> On Sun 10-07-22 12:21:59, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> For example, 2 * wake_batch tags are put, while only wake_batch threads
>> are woken:
>>
>> __sbq_wake_up
>>   atomic_cmpxchg -> reset wait_cnt
>> 			__sbq_wake_up -> decrease wait_cnt
>> 			...
>> 			__sbq_wake_up -> wait_cnt is decreased to 0 again
>> 			 atomic_cmpxchg
>> 			 sbq_index_atomic_inc -> increase wake_index
>> 			 wake_up_nr -> wake up and waitqueue might be empty
>>   sbq_index_atomic_inc -> increase again, one waitqueue is skipped
>>   wake_up_nr -> invalid wake up because old wakequeue might be empty
>>
>> To fix the problem, increasing 'wake_index' before resetting 'wait_cnt'.
>>
>> Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> This patch and the following one look sane to me but please merge them to a
> single patch. They fix the same race of two concurrent wakers just with a
> slightly different timing so there isn't a point in having two patches for
> this (in particular changes in this patch are difficult to reason about
> when we know the result is still buggy).

Ok, I'll merge them.

Thanks,
Kuai
> 
> 								Honza
> 
>> ---
>>   lib/sbitmap.c | 45 +++++++++++++++++++++++----------------------
>>   1 file changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index b46fce1beb3a..57095dd88a33 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -616,32 +616,33 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>>   		return false;
>>   
>>   	wait_cnt = atomic_dec_return(&ws->wait_cnt);
>> -	if (wait_cnt <= 0) {
>> -		int ret;
>> +	if (wait_cnt > 0)
>> +		return false;
>>   
>> -		wake_batch = READ_ONCE(sbq->wake_batch);
>> +	/*
>> +	 * For concurrent callers of this, callers should call this function
>> +	 * again to wakeup a new batch on a different 'ws'.
>> +	 */
>> +	if (wait_cnt < 0)
>> +		return true;
>>   
>> -		/*
>> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
>> -		 * ensure that we see the batch size update before the wait
>> -		 * count is reset.
>> -		 */
>> -		smp_mb__before_atomic();
>> +	wake_batch = READ_ONCE(sbq->wake_batch);
>>   
>> -		/*
>> -		 * For concurrent callers of this, the one that failed the
>> -		 * atomic_cmpxhcg() race should call this function again
>> -		 * to wakeup a new batch on a different 'ws'.
>> -		 */
>> -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
>> -		if (ret == wait_cnt) {
>> -			sbq_index_atomic_inc(&sbq->wake_index);
>> -			wake_up_nr(&ws->wait, wake_batch);
>> -			return false;
>> -		}
>> +	/*
>> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
>> +	 * ensure that we see the batch size update before the wait
>> +	 * count is reset.
>> +	 */
>> +	smp_mb__before_atomic();
>>   
>> -		return true;
>> -	}
>> +	/*
>> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
>> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
>> +	 * invalid wakeup on the old waitqueue.
>> +	 */
>> +	sbq_index_atomic_inc(&sbq->wake_index);
>> +	atomic_set(&ws->wait_cnt, wake_batch);
>> +	wake_up_nr(&ws->wait, wake_batch);
>>   
>>   	return false;
>>   }
>> -- 
>> 2.31.1
>>
