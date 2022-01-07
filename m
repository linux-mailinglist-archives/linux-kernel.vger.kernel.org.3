Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8F487756
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbiAGMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:06:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4370 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiAGMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:06:02 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVhdD29r4z67k2V;
        Fri,  7 Jan 2022 20:01:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 13:05:46 +0100
Received: from [10.47.89.210] (10.47.89.210) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 12:05:46 +0000
Subject: Re: [PATCH -next v3] blk-mq: fix tag_get wait task can't be awakened
To:     qiulaibin <qiulaibin@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220106133432.989177-1-qiulaibin@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1430d56b-ed99-6c30-85e2-11d0a8a40a12@huawei.com>
Date:   Fri, 7 Jan 2022 12:05:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220106133432.989177-1-qiulaibin@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.210]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 13:34, qiulaibin wrote:
> In case of shared tags, there might be more than one hctx which
> allocates tag from single tags,

how about "allocates from the same tags"?

> and each hctx is limited to allocate at
> most:
>          hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
> 
> tag idle detection is lazy, and may be delayed for 30sec, so there
> could be just one real active hctx(queue) but all others are actually
> idle and still accounted as active because of the lazy idle detection.
> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
> forever on this real active hctx.
> 
> Fix this by recalculating wake_batch when inc or dec active_queues.
> 
> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>   block/blk-mq-tag.c      | 32 ++++++++++++++++++++++++++++++--
>   include/linux/sbitmap.h | 11 +++++++++++
>   lib/sbitmap.c           | 22 +++++++++++++++++++---
>   3 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index e55a6834c9a6..e59ebf89c1bf 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -16,6 +16,21 @@
>   #include "blk-mq-sched.h"
>   #include "blk-mq-tag.h"
>   
> +/*
> + * Recalculate wakeup batch when tag is shared by hctx.
> + */
> +static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
> +		unsigned int users)
> +{
> +	if (!users)
> +		return;
> +
> +	sbitmap_queue_recalculate_wake_batch(&tags->bitmap_tags,
> +			users);
> +	sbitmap_queue_recalculate_wake_batch(&tags->breserved_tags,
> +			users);
> +}
> +
>   /*
>    * If a previously inactive queue goes active, bump the active user count.
>    * We need to do this before try to allocate driver tag, then even if fail
> @@ -24,16 +39,25 @@
>    */
>   bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   {
> +	unsigned int users;
>   	if (blk_mq_is_shared_tags(hctx->flags)) {
>   		struct request_queue *q = hctx->queue;
>   
>   		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) &&
> -		    !test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> +		    !test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>   			atomic_inc(&hctx->tags->active_queues);
> +
> +			users = atomic_read(&hctx->tags->active_queues);
> +			blk_mq_update_wake_batch(hctx->tags, users);
> +		}
>   	} else {
>   		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
> -		    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +		    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
>   			atomic_inc(&hctx->tags->active_queues);
> +
> +			users = atomic_read(&hctx->tags->active_queues);

atomic_inc_return() can do inc and read together

> +			blk_mq_update_wake_batch(hctx->tags, users);
> +		}

there seems to be more duplicated code here now, as we do the same in 
both legs of the if-else statement.

>   	}
>   
>   	return true;
> @@ -56,6 +80,7 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
>   void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct blk_mq_tags *tags = hctx->tags;
> +	unsigned int users;
>   
>   	if (blk_mq_is_shared_tags(hctx->flags)) {
>   		struct request_queue *q = hctx->queue;
> @@ -70,6 +95,9 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>   
>   	atomic_dec(&tags->active_queues);
>   
> +	users = atomic_read(&hctx->tags->active_queues);

as above, atomic_dec_return()

> +	blk_mq_update_wake_batch(hctx->tags, users);
> +
>   	blk_mq_tag_wakeup_all(tags, false);
>   }
>   
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index fc0357a6e19b..e1fced98dfca 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -415,6 +415,17 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
>   	sbitmap_free(&sbq->sb);
>   }
>   
> +/**
> + * sbitmap_queue_recalculate_wake_batch() - Recalculate wake batch
> + * @sbq: Bitmap queue to Recalculate wake batch.

/s/Recalculate /recalculate/



> + * @users: Number of shares.
> + *
> + * Like sbitmap_queue_update_wake_batch(), this will calculate wake batch
> + * by depth. This interface is for sharing tags.

we have concept of shared tags (flag BLK_MQ_F_TAG_HCTX_SHARED) and queue 
shared tags (flag BLK_MQ_F_TAG_QUEUE_SHARED) - please be careful in the 
terminology

> + */
> +void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int users);
> +
>   /**
>    * sbitmap_queue_resize() - Resize a &struct sbitmap_queue.
>    * @sbq: Bitmap queue to resize.
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 2709ab825499..94b3272effd8 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -457,10 +457,9 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
>   
> -static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> -					    unsigned int depth)
> +static inline void __sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int wake_batch)
>   {
> -	unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
>   	int i;
>   
>   	if (sbq->wake_batch != wake_batch) {
> @@ -476,6 +475,23 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
>   	}
>   }
>   
> +static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int depth)
> +{
> +	unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
> +
> +	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
> +}
> +
> +void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int users)
> +{
> +	unsigned int wake_batch = clamp_t(unsigned int,
> +			(sbq->sb.depth + users - 1) / users, 4U, SBQ_WAKE_BATCH);
> +	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
> +}
> +EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
> +
>   void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
>   {
>   	sbitmap_queue_update_wake_batch(sbq, depth);
> 

