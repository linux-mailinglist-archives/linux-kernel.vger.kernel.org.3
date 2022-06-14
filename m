Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0408554B21C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiFNNPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiFNNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:15:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F24369FA;
        Tue, 14 Jun 2022 06:15:40 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LMpn60vbzzjY3r;
        Tue, 14 Jun 2022 21:14:34 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 21:15:38 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 21:15:37 +0800
Subject: Re: [PATCH -next] blk-mq: fix boot time regression for scsi drives
 with multiple hctx
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <djeffery@redhat.com>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220614071410.3571204-1-yukuai3@huawei.com>
 <Yqg5QxSM+lub8DY0@T590>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <01cb0e49-1154-33db-f572-3960c972fe08@huawei.com>
Date:   Tue, 14 Jun 2022 21:15:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yqg5QxSM+lub8DY0@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/06/14 15:31, Ming Lei Ð´µÀ:
> On Tue, Jun 14, 2022 at 03:14:10PM +0800, Yu Kuai wrote:
>> We found that boot time is increased for about 8s after upgrading kernel
>> from v4.19 to v5.10(megaraid-sas is used in the environment).
> 
> But 'blk-mq: clearing flush request reference in tags->rqs[]' was merged
> to v5.14, :-)
Hi,

Yes, but this patch is applied to 5.10 stable, thus we backport in our
v5.10. Sorry that I didn't mention that.

> 
>>
>> Following is where the extra time is spent:
>>
>> 
>>   __scsi_remove_device
>>    blk_cleanup_queue
>>     blk_mq_exit_queue
>>      blk_mq_exit_hw_queues
>>       blk_mq_exit_hctx
>>        blk_mq_clear_flush_rq_mapping -> function latency is 0.1ms
> 
> So queue_depth looks pretty long, is it 4k?
No, in the environment, it's just 32, and nr_hw_queues is 128, which
means each blk_cleanup_queue() will cost about 10-20 ms.

> 
> But if it is 0.1ms, how can the 8sec delay be caused? That requires 80K hw queues
> for making so long, so I guess there must be other delay added by the feature
> of BLK_MQ_F_TAG_HCTX_SHARED.

Please see details in the reasons 2), scsi scan will call
__scsi_remove_device() a lot of times(each host, each channel, each
target).
> 
>>         cmpxchg
>>
>> There are three reasons:
>> 1) megaraid-sas is using multiple hctxs in v5.10, thus blk_mq_exit_hctx()
>> will be called much more times in v5.10 compared to v4.19.
>> 2) scsi will scan for each target thus __scsi_remove_device() will be
>> called for many times.
>> 3) blk_mq_clear_flush_rq_mapping() is introduced after v4.19, it will
>> call cmpxchg() for each request, and function latency is abount 0.1ms.
>>
>> Since that blk_mq_clear_flush_rq_mapping() will only be called while the
>> queue is freezed already, which means there is no inflight request,
>> it's safe to set NULL for 'tags->rqs[]' directly instead of using
>> cmpxchg(). Tests show that with this change, function latency of
>> blk_mq_clear_flush_rq_mapping() is about 1us, and boot time is not
>> increased.
> 
> tags is shared among all LUNs attached to the host, so freezing single
> request queue here means nothing, so your patch doesn't work.

You'are right, I forgot about that tags can be shared.

> 
> Please test the following patch, and see if it can improve boot delay for
> your case.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9bf950983c7..1463076a527c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3443,8 +3443,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>   	if (blk_mq_hw_queue_mapped(hctx))
>   		blk_mq_tag_idle(hctx);
>   
> -	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
> -			set->queue_depth, flush_rq);
> +	if (blk_queue_init_done(q))
> +		blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
> +				set->queue_depth, flush_rq);
>   	if (set->ops->exit_request)
>   		set->ops->exit_request(set, flush_rq, hctx_idx);
>   

Thanks for the patch, I test it and boot delay is fixed.

Kuai
> 
> 
> Thanks,
> Ming
> 
> .
> 
