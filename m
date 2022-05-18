Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E452AFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiERBRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiERBRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:17:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E62FFF4;
        Tue, 17 May 2022 18:17:26 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2w781N17zhZ6w;
        Wed, 18 May 2022 09:16:36 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 09:17:24 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 09:17:24 +0800
Subject: Re: [PATCH -next v2 2/2] block, bfq: make bfq_has_work() more
 accurate
To:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
 <20220513023507.2625717-3-yukuai3@huawei.com>
 <20220516095620.ge5gxmwrnbanfqea@quack3.lan>
 <740D270D-8723-4399-82CC-26CD861843D7@linaro.org>
 <22FEB802-2872-45A7-8ED8-2DE7D0D5E6CD@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <54d06657-a5e2-a94d-c9af-2f10900e7f32@huawei.com>
Date:   Wed, 18 May 2022 09:17:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <22FEB802-2872-45A7-8ED8-2DE7D0D5E6CD@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/05/17 23:06, Paolo Valente Ð´µÀ:
> 
> 
>> Il giorno 17 mag 2022, alle ore 16:21, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>>
>>
>>> Il giorno 16 mag 2022, alle ore 11:56, Jan Kara <jack@suse.cz> ha scritto:
>>>
>>> On Fri 13-05-22 10:35:07, Yu Kuai wrote:
>>>> bfq_has_work() is using busy_queues currently, which is not accurate
>>>> because bfq_queue is busy doesn't represent that it has requests. Since
>>>> bfqd aready has a counter 'queued' to record how many requests are in
>>>> bfq, use it instead of busy_queues.
>>>>
>>
>> The number of requests queued is not equal to the number of busy
>> queues (it is >=).
> 
> No, sorry. It is actually != in general.
Hi, Paolo

I'm aware that number of requests queued is not equal to the number of
busy queues, and that is the motivation of this patch.

> 
> In particular, if queued == 0 but there are busy queues (although
> still waiting for I/O to arrive), then responding that there is no
> work caused blk-mq to stop asking, and hence an I/O freeze.  IOW I/O
> eventually arrives for a busy queue, but blk-mq does not ask for a new
> request any longer.  But maybe things have changed around bfq since
> then.

The problem is that if queued == 0 while there are busy queues, is there
any point to return true in bfq_has_work() ? IMO, it will only cause
unecessary run queue. And if new request arrives,
blk_mq_sched_insert_request() will trigger a run queue.

Thanks,
Kuai
> 
> Paolo
> 
>>   If this patch is based on this assumption then
>> unfortunately it is wrong :(
>>
>> Paolo
>>
>>>> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
>>>> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Looks good. Feel free to add:
>>>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>
>>> 								Honza
>>>
>>>> ---
>>>> block/bfq-iosched.c | 16 ++++++++++++----
>>>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 61750696e87f..740dd83853a6 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -2210,7 +2210,11 @@ static void bfq_add_request(struct request *rq)
>>>>
>>>> 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
>>>> 	bfqq->queued[rq_is_sync(rq)]++;
>>>> -	bfqd->queued++;
>>>> +	/*
>>>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
>>>> +	 * may be read without holding the lock in bfq_has_work().
>>>> +	 */
>>>> +	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
>>>>
>>>> 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
>>>> 		bfq_check_waker(bfqd, bfqq, now_ns);
>>>> @@ -2402,7 +2406,11 @@ static void bfq_remove_request(struct request_queue *q,
>>>> 	if (rq->queuelist.prev != &rq->queuelist)
>>>> 		list_del_init(&rq->queuelist);
>>>> 	bfqq->queued[sync]--;
>>>> -	bfqd->queued--;
>>>> +	/*
>>>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
>>>> +	 * may be read without holding the lock in bfq_has_work().
>>>> +	 */
>>>> +	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
>>>> 	elv_rb_del(&bfqq->sort_list, rq);
>>>>
>>>> 	elv_rqhash_del(q, rq);
>>>> @@ -5063,11 +5071,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
>>>> 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>>>>
>>>> 	/*
>>>> -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
>>>> +	 * Avoiding lock: a race on bfqd->queued should cause at
>>>> 	 * most a call to dispatch for nothing
>>>> 	 */
>>>> 	return !list_empty_careful(&bfqd->dispatch) ||
>>>> -		bfq_tot_busy_queues(bfqd) > 0;
>>>> +		READ_ONCE(bfqd->queued);
>>>> }
>>>>
>>>> static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>>> -- 
>>>> 2.31.1
>>>>
>>> -- 
>>> Jan Kara <jack@suse.com>
>>> SUSE Labs, CR
>>
> 
> .
> 
