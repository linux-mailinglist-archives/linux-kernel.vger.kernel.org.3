Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E25918FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 08:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiHMGAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 02:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiHMGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 02:00:40 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107127B2A;
        Fri, 12 Aug 2022 23:00:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M4VH31lLtzKHCR;
        Sat, 13 Aug 2022 13:59:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgC3oLwEPvdiJuUnAQ--.18533S3;
        Sat, 13 Aug 2022 14:00:36 +0800 (CST)
Subject: Re: [PATCH v3] blk-mq: fix io hung due to missing commit_rqs
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     Ming Lei <ming.lei@redhat.com>, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
 <YuCsNuVuVppgn9FL@T590>
 <1ca6db8a-5780-45c6-064d-dd72c9f274c3@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f2fe1889-e381-e29a-14c7-3e57c4488dca@huaweicloud.com>
Date:   Sat, 13 Aug 2022 14:00:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1ca6db8a-5780-45c6-064d-dd72c9f274c3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3oLwEPvdiJuUnAQ--.18533S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18AFWUXr1UAry8uFyUJrb_yoW8KFW5pF
        s2ka43Jr4Fkr4ktrnFqF1UAFyFgwsrX39rWryxJrWfZrZFkry0gr4xXrnIgFyIkF4kCwnr
        KF45Xr9xZw1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUU
        UU=
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

在 2022/07/29 14:35, Yu Kuai 写道:
> Hi, Jens
> 
> Can you please consider this patch for v5.20?
> 
friendly ping ...
> Thanks,
> Kuai
> 
> 在 2022/07/27 11:08, Ming Lei 写道:
>> On Tue, Jul 26, 2022 at 08:22:24PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Currently, in virtio_scsi, if 'bd->last' is not set to true while
>>> dispatching request, such io will stay in driver's queue, and driver
>>> will wait for block layer to dispatch more rqs. However, if block
>>> layer failed to dispatch more rq, it should trigger commit_rqs to
>>> inform driver.
>>>
>>> There is a problem in blk_mq_try_issue_list_directly() that commit_rqs
>>> won't be called:
>>>
>>> // assume that queue_depth is set to 1, list contains two rq
>>> blk_mq_try_issue_list_directly
>>>   blk_mq_request_issue_directly
>>>   // dispatch first rq
>>>   // last is false
>>>    __blk_mq_try_issue_directly
>>>     blk_mq_get_dispatch_budget
>>>     // succeed to get first budget
>>>     __blk_mq_issue_directly
>>>      scsi_queue_rq
>>>       cmd->flags |= SCMD_LAST
>>>        virtscsi_queuecommand
>>>         kick = (sc->flags & SCMD_LAST) != 0
>>>         // kick is false, first rq won't issue to disk
>>>   queued++
>>>
>>>   blk_mq_request_issue_directly
>>>   // dispatch second rq
>>>    __blk_mq_try_issue_directly
>>>     blk_mq_get_dispatch_budget
>>>     // failed to get second budget
>>>   ret == BLK_STS_RESOURCE
>>>    blk_mq_request_bypass_insert
>>>   // errors is still 0
>>>
>>>   if (!list_empty(list) || errors && ...)
>>>    // won't pass, commit_rqs won't be called
>>>
>>> In this situation, first rq relied on second rq to dispatch, while
>>> second rq relied on first rq to complete, thus they will both hung.
>>>
>>> Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
>>> it means that request is not queued successfully.
>>>
>>> Same problem exists in blk_mq_dispatch_rq_list(), 'BLK_STS_*RESOURCE'
>>> can't be treated as 'errors' here, fix the problem by calling
>>> commit_rqs if queue_rq return 'BLK_STS_*RESOURCE'.
>>>
>>> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>
>> Thanks,
>> Ming
>>
>> .
>>
> 
> .
> 

