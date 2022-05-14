Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B970527048
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiENJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiENJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:30:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D66FD14;
        Sat, 14 May 2022 02:30:02 -0700 (PDT)
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L0g8k0YVNzCsXn;
        Sat, 14 May 2022 17:25:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 14 May 2022 17:30:00 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 14 May 2022 17:29:59 +0800
Subject: Re: [PATCH -next v2] block: update nsecs[] in part_stat_show() and
 diskstats_show()
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <bvanassche@acm.org>, <hch@infradead.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220415080605.3178553-1-yukuai3@huawei.com>
 <e2d25ea9-3b23-267f-2ed0-ee405a6f8864@huawei.com>
 <4573a3f0-c86e-d684-06c8-f195744a5892@huawei.com>
Message-ID: <76cba167-d2c4-8105-a04d-5e74eab2592f@huawei.com>
Date:   Sat, 14 May 2022 17:29:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4573a3f0-c86e-d684-06c8-f195744a5892@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping ...

在 2022/05/05 8:58, yukuai (C) 写道:
> friendly ping ...
> 
> 在 2022/04/24 10:43, yukuai (C) 写道:
>> friendly ping ...
>>
>> 在 2022/04/15 16:06, Yu Kuai 写道:
>>> commit 86d7331299fd("block: update io_ticks when io hang") fixed that
>>> %util will be zero for iostat when io is hanged, however, avgqu-sz is
>>> still zero while it represents the number of io that are hunged. On the
>>> other hand, for some slow device, if an io is started before and done
>>> after diskstats is read, the avgqu-sz will be miscalculated.
>>>
>>> To fix the problem, update 'nsecs[]' when part_stat_show() or
>>> diskstats_show() is called. In order to do that, add 'stat_time' in
>>> struct block_device and 'rq_stat_time' in struct request to record the
>>> time. And during iteration, update 'nsecs[]' for each inflight request.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>> Changes in v2:
>>>   - remove other cleanup patches.
>>>
>>>   block/bdev.c              |  2 ++
>>>   block/blk-mq.c            | 62 ++++++++++++++++++++++++++++++++++++++-
>>>   block/blk-mq.h            |  2 ++
>>>   block/genhd.c             | 62 +++++++++++++++++++++++++--------------
>>>   include/linux/blk-mq.h    |  2 ++
>>>   include/linux/blk_types.h |  5 ++++
>>>   6 files changed, 112 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/block/bdev.c b/block/bdev.c
>>> index 7bf88e591aaf..da0471f7492d 100644
>>> --- a/block/bdev.c
>>> +++ b/block/bdev.c
>>> @@ -487,9 +487,11 @@ struct block_device *bdev_alloc(struct gendisk 
>>> *disk, u8 partno)
>>>       bdev = I_BDEV(inode);
>>>       mutex_init(&bdev->bd_fsfreeze_mutex);
>>>       spin_lock_init(&bdev->bd_size_lock);
>>> +    spin_lock_init(&bdev->bd_stat_lock);
>>>       bdev->bd_partno = partno;
>>>       bdev->bd_inode = inode;
>>>       bdev->bd_queue = disk->queue;
>>> +    bdev->stat_time = 0;
>>>       bdev->bd_stats = alloc_percpu(struct disk_stats);
>>>       if (!bdev->bd_stats) {
>>>           iput(inode);
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 3fe3226aad1b..ebb4db535794 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -128,6 +128,48 @@ struct mq_inflight {
>>>       unsigned int inflight[2];
>>>   };
>>> +static bool blk_mq_check_inflight_with_stat(struct request *rq, void 
>>> *priv,
>>> +                        bool reserved)
>>> +{
>>> +    struct mq_inflight *mi = priv;
>>> +
>>> +    if ((!mi->part->bd_partno || rq->part == mi->part) &&
>>> +        blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
>>> +        u64 stat_time;
>>> +
>>> +        mi->inflight[rq_data_dir(rq)]++;
>>> +        if (!rq->part)
>>> +            return true;
>>> +
>>> +        stat_time = READ_ONCE(rq->stat_time_ns);
>>> +        /*
>>> +         * This might fail if 'req->stat_time_ns' is updated in
>>> +         * blk_account_io_done().
>>> +         */
>>> +        if (likely(cmpxchg(&rq->stat_time_ns, stat_time,
>>> +                rq->part->stat_time) == stat_time)) {
>>> +            int sgrp = op_stat_group(req_op(rq));
>>> +            u64 duation = stat_time ?
>>> +                rq->part->stat_time - stat_time :
>>> +                rq->part->stat_time - rq->start_time_ns;
>>> +
>>> +            part_stat_add(rq->part, nsecs[sgrp], duation);
>>> +        }
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +unsigned int blk_mq_in_flight_with_stat(struct request_queue *q,
>>> +                    struct block_device *part)
>>> +{
>>> +    struct mq_inflight mi = { .part = part };
>>> +
>>> +    blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_with_stat, 
>>> &mi);
>>> +
>>> +    return mi.inflight[0] + mi.inflight[1];
>>> +}
>>> +
>>>   static bool blk_mq_check_inflight(struct request *rq, void *priv,
>>>                     bool reserved)
>>>   {
>>> @@ -369,6 +411,7 @@ static struct request *blk_mq_rq_ctx_init(struct 
>>> blk_mq_alloc_data *data,
>>>           rq->start_time_ns = ktime_get_ns();
>>>       else
>>>           rq->start_time_ns = 0;
>>> +    rq->stat_time_ns = 0;
>>>       rq->part = NULL;
>>>   #ifdef CONFIG_BLK_RQ_ALLOC_TIME
>>>       rq->alloc_time_ns = alloc_time_ns;
>>> @@ -870,7 +913,24 @@ static void __blk_account_io_done(struct request 
>>> *req, u64 now)
>>>       part_stat_lock();
>>>       update_io_ticks(req->part, jiffies, true);
>>>       part_stat_inc(req->part, ios[sgrp]);
>>> -    part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
>>> +
>>> +    if (queue_is_mq(req->q)) {
>>> +        u64 stat_time = READ_ONCE(req->stat_time_ns);
>>> +
>>> +        /*
>>> +         * This might fail if 'req->stat_time_ns' is updated during
>>> +         * blk_mq_check_inflight_with_stat().
>>> +         */
>>> +        if (likely(cmpxchg(&req->stat_time_ns, stat_time, now) ==
>>> +                   stat_time)) {
>>> +            u64 duation = stat_time ? now - stat_time :
>>> +                          now - req->start_time_ns;
>>> +
>>> +            part_stat_add(req->part, nsecs[sgrp], duation);
>>> +        }
>>> +    } else {
>>> +        part_stat_add(req->part, nsecs[sgrp], now - 
>>> req->start_time_ns);
>>> +    }
>>>       part_stat_unlock();
>>>   }
>>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>>> index 9bad3057c1f3..e6c2c523c8de 100644
>>> --- a/block/blk-mq.h
>>> +++ b/block/blk-mq.h
>>> @@ -193,6 +193,8 @@ unsigned int blk_mq_in_flight(struct 
>>> request_queue *q,
>>>           struct block_device *part);
>>>   void blk_mq_in_flight_rw(struct request_queue *q, struct 
>>> block_device *part,
>>>           unsigned int inflight[2]);
>>> +unsigned int blk_mq_in_flight_with_stat(struct request_queue *q,
>>> +        struct block_device *part);
>>>   static inline void blk_mq_put_dispatch_budget(struct request_queue *q,
>>>                             int budget_token)
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index b8b6759d670f..36144fe8872b 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -932,25 +932,52 @@ ssize_t part_size_show(struct device *dev,
>>>       return sprintf(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev)));
>>>   }
>>> -ssize_t part_stat_show(struct device *dev,
>>> -               struct device_attribute *attr, char *buf)
>>> +static inline void part_set_stat_time(struct block_device *part)
>>> +{
>>> +    u64 now = ktime_get_ns();
>>> +
>>> +again:
>>> +    part->stat_time = now;
>>> +
>>> +    if (part->bd_partno) {
>>> +        part = bdev_whole(part);
>>> +        goto again;
>>> +    }
>>> +}
>>> +
>>> +static inline void part_get_stat_info(struct block_device *bdev,
>>> +                      struct disk_stats *stat,
>>> +                      unsigned int *inflight)
>>>   {
>>> -    struct block_device *bdev = dev_to_bdev(dev);
>>>       struct request_queue *q = bdev_get_queue(bdev);
>>> -    struct disk_stats stat;
>>> -    unsigned int inflight;
>>> -    if (queue_is_mq(q))
>>> -        inflight = blk_mq_in_flight(q, bdev);
>>> -    else
>>> -        inflight = part_in_flight(bdev);
>>> +    if (queue_is_mq(q)) {
>>> +        part_stat_lock();
>>> +        spin_lock(&bdev->bd_stat_lock);
>>> +        part_set_stat_time(bdev);
>>> +        *inflight = blk_mq_in_flight_with_stat(q, bdev);
>>> +        spin_unlock(&bdev->bd_stat_lock);
>>> +        part_stat_unlock();
>>> +    } else {
>>> +        *inflight = part_in_flight(bdev);
>>> +    }
>>> -    if (inflight) {
>>> +    if (*inflight) {
>>>           part_stat_lock();
>>>           update_io_ticks(bdev, jiffies, true);
>>>           part_stat_unlock();
>>>       }
>>> -    part_stat_read_all(bdev, &stat);
>>> +    part_stat_read_all(bdev, stat);
>>> +}
>>> +
>>> +ssize_t part_stat_show(struct device *dev,
>>> +               struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct block_device *bdev = dev_to_bdev(dev);
>>> +    struct disk_stats stat;
>>> +    unsigned int inflight;
>>> +
>>> +    part_get_stat_info(bdev, &stat, &inflight);
>>>       return sprintf(buf,
>>>           "%8lu %8lu %8llu %8u "
>>>           "%8lu %8lu %8llu %8u "
>>> @@ -1239,17 +1266,8 @@ static int diskstats_show(struct seq_file 
>>> *seqf, void *v)
>>>       xa_for_each(&gp->part_tbl, idx, hd) {
>>>           if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
>>>               continue;
>>> -        if (queue_is_mq(gp->queue))
>>> -            inflight = blk_mq_in_flight(gp->queue, hd);
>>> -        else
>>> -            inflight = part_in_flight(hd);
>>> -
>>> -        if (inflight) {
>>> -            part_stat_lock();
>>> -            update_io_ticks(hd, jiffies, true);
>>> -            part_stat_unlock();
>>> -        }
>>> -        part_stat_read_all(hd, &stat);
>>> +
>>> +        part_get_stat_info(hd, &stat, &inflight);
>>>           seq_printf(seqf, "%4d %7d %pg "
>>>                  "%lu %lu %lu %u "
>>>                  "%lu %lu %lu %u "
>>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>>> index 7aa5c54901a9..387e475fedd4 100644
>>> --- a/include/linux/blk-mq.h
>>> +++ b/include/linux/blk-mq.h
>>> @@ -108,6 +108,8 @@ struct request {
>>>       u64 start_time_ns;
>>>       /* Time that I/O was submitted to the device. */
>>>       u64 io_start_time_ns;
>>> +    /* Time that I/O was counted in part_get_stat_info(). */
>>> +    u64 stat_time_ns;
>>>   #ifdef CONFIG_BLK_WBT
>>>       unsigned short wbt_flags;
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 046a34c81ec4..4014b0c0ef16 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -65,6 +65,11 @@ struct block_device {
>>>       struct super_block    *bd_fsfreeze_sb;
>>>       struct partition_meta_info *bd_meta_info;
>>> +
>>> +    /* Prevent part_get_stat_info() to be called concurrently */
>>> +    spinlock_t        bd_stat_lock;
>>> +    /* Will be set when part_get_stat_info() is called */
>>> +    u64            stat_time;
>>>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>>>       bool            bd_make_it_fail;
>>>   #endif
>>>
