Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EF9581D97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbiG0C0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiG0C0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:26:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEE2A96D;
        Tue, 26 Jul 2022 19:26:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LsyKt36rGzl2Jl;
        Wed, 27 Jul 2022 10:25:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgD3_9M9ouBipOrwBA--.53742S3;
        Wed, 27 Jul 2022 10:26:06 +0800 (CST)
Subject: Re: [PATCH v3] blk-mq: fix io hung due to missing commit_rqs
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
 <YuCe7e5KapIqzO0S@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1d970dd9-f39c-bc58-bcf4-782eab5db3aa@huaweicloud.com>
Date:   Wed, 27 Jul 2022 10:26:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YuCe7e5KapIqzO0S@T590>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3_9M9ouBipOrwBA--.53742S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFykuw1xCrWUArWUJF4kCrg_yoW5ur1kpF
        WxC3W2kws5tr47tF97Xa17Aa4jvwsxKrW7GryfKw43ZF4UKrWIqrs3Ja13WFyIyFs8uwsF
        gF45XFyYqw1DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ming

ÔÚ 2022/07/27 10:11, Ming Lei Ð´µÀ:
> On Tue, Jul 26, 2022 at 08:22:24PM +0800, Yu Kuai wrote:
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
>>
>> Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
>> it means that request is not queued successfully.
>>
>> Same problem exists in blk_mq_dispatch_rq_list(), 'BLK_STS_*RESOURCE'
>> can't be treated as 'errors' here, fix the problem by calling
>> commit_rqs if queue_rq return 'BLK_STS_*RESOURCE'.
>>
>> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> Changes in v3:
>>   - as poinited out by Ming, v2 will break return value by treating
>>   BLK_STS_*RESOURCE as errors.
>> Changes in v2:
>>   - suggested by Ming, handle blk_mq_dispatch_rq_list() as well.
>>   - change title and modify commit message.
>>
>>   block/blk-mq.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 70177ee74295..7d26b222cbc9 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1931,7 +1931,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>>   	/* If we didn't flush the entire list, we could have told the driver
>>   	 * there was more coming, but that turned out to be a lie.
>>   	 */
>> -	if ((!list_empty(list) || errors) && q->mq_ops->commit_rqs && queued)
>> +	if ((!list_empty(list) || errors || needs_resource ||
>> +	     ret == BLK_STS_DEV_RESOURCE) && q->mq_ops->commit_rqs && queued)
> 
> 'ret == BLK_STS_DEV_RESOURCE' may happen before, but 'ret' could be
> overridden later.

 From what I see, if queue_rq return 'BLK_STS_RESOURCE' or
'BLK_STS_DEV_RESOURCE', the loop will break, so that 'ret' could not
be overridden. 'BLK_STS_ZONE_RESOURCE' can be overridden, however,
needs_resource can cover that case.

Thanks,
Kuai
> 
> Thanks,
> Ming
> 
> .
> 

