Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2D580BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiGZGa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbiGZGaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:30:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440C2602;
        Mon, 25 Jul 2022 23:30:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LsRnk4zq3zKH4k;
        Tue, 26 Jul 2022 14:28:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCH6mnvid9iR3rPBA--.40199S3;
        Tue, 26 Jul 2022 14:30:08 +0800 (CST)
Subject: Re: [PATCH v2] blk-mq: fix io hung due to missing commit_rqs
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220726033519.4002586-1-yukuai1@huaweicloud.com>
 <Yt9rrL62zW2orGys@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c720cb4f-2e74-b319-c7e2-2672f2890ed7@huaweicloud.com>
Date:   Tue, 26 Jul 2022 14:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yt9rrL62zW2orGys@T590>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCH6mnvid9iR3rPBA--.40199S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UKFy3Kw15urWkCF1DGFg_yoW5Ww4rpF
        WfGa15Aa1rtr4jqryxZa17C3W0vanxWrW7GryfKw13Z3WDKrZ2qrs3Jr13WFySkrs8CwsF
        gF1UWryYqw1kurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ming!

ÔÚ 2022/07/26 12:21, Ming Lei Ð´µÀ:
> On Tue, Jul 26, 2022 at 11:35:19AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, in virtio_scsi, if 'bd->last' is not set to true while
>> dispatching request, such io will stay in driver's queue, and driver
>> will wait for block layer to dispatch more rqs. However, if block
>> layer failed to dispatch more rq, it should trigger commit_rqs to
>> inform driver.
>>
>> There is a problem in blk_mq_try_issue_list_directly() that commit_rqs
>> won't be called:
>>
>> // assume that queue_depth is set to 1, list contains two rq
>> blk_mq_try_issue_list_directly
>>   blk_mq_request_issue_directly
>>   // dispatch first rq
>>   // last is false
>>    __blk_mq_try_issue_directly
>>     blk_mq_get_dispatch_budget
>>     // succeed to get first budget
>>     __blk_mq_issue_directly
>>      scsi_queue_rq
>>       cmd->flags |= SCMD_LAST
>>        virtscsi_queuecommand
>>         kick = (sc->flags & SCMD_LAST) != 0
>>         // kick is false, first rq won't issue to disk
>>   queued++
>>
>>   blk_mq_request_issue_directly
>>   // dispatch second rq
>>    __blk_mq_try_issue_directly
>>     blk_mq_get_dispatch_budget
>>     // failed to get second budget
>>   ret == BLK_STS_RESOURCE
>>    blk_mq_request_bypass_insert
>>   // errors is still 0
>>
>>   if (!list_empty(list) || errors && ...)
>>    // won't pass, commit_rqs won't be called
>>
>> In this situation, first rq relied on second rq to dispatch, while
>> second rq relied on first rq to complete, thus they will both hung.
>> And same problem exists in blk_mq_dispatch_rq_list()
>>
>> Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
>> it means that request is not queued successfully.
>>
>> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> Changes in v2:
>>   - suggested by Ming, handle blk_mq_dispatch_rq_list() as well.
>>   - change title and modify commit message.
>>
>>   block/blk-mq.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 70177ee74295..ee1e065fe63f 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1909,6 +1909,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>>   			fallthrough;
>>   		case BLK_STS_DEV_RESOURCE:
>>   			blk_mq_handle_dev_resource(rq, list);
>> +			errors++;
>>   			goto out;
>>   		case BLK_STS_ZONE_RESOURCE:
>>   			/*
>> @@ -1918,6 +1919,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>>   			 */
>>   			blk_mq_handle_zone_resource(rq, &zone_list);
>>   			needs_resource = true;
>> +			errors++;
> 
> But accounting error here may break return value of
> blk_mq_dispatch_rq_list(), see:
> 
> /* Returns true if we did some work AND can potentially do more. */

Yes, you're right. I'll try to fix that in v3.

Thanks,
Kuai
> 

