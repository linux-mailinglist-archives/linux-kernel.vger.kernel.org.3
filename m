Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4748D61D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiAMKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:52:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:18428 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbiAMKwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071167; x=1673607167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+3DK8tcDzxN/KnQ4WDFNfYsiYO589Q11iMRonfrLto=;
  b=fCxYUKdHVX4ERE17edP0Jf5HV1qt/HEXQdoI4uOSA1U3Ba9IYE6HTeZH
   N9CJPYxu49Z9Ssfjob1hFAEFkoKuh6WZnhD6IbmKvd6lEBqJN2v8Fvbbr
   K1TzFMt7YIbNNuQASTihcuneW6Gj3cyXV4b9N8U3ipSGMO4paruevoe+E
   G62d6pTyUcf+OyGK71FZcWtsZigungDi/YJLH8VHqNnmqSSJqzIzDpcD3
   Sy7sAVa3JHXM1iFsIs3wVWXFsv8so3ZLlHLzqqV+mlpZ7lfObRN8s17T7
   CTsp2RNUNGLvpXjJERK8+ru/Hnt9emjAv0AMC4c7dNJ3T04a56oi/feS/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242800979"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242800979"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:52:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="473181819"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:52:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7xhb-00AA2N-C2;
        Thu, 13 Jan 2022 12:51:31 +0200
Date:   Thu, 13 Jan 2022 12:51:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, john.garry@huawei.com,
        martin.petersen@oracle.com, hare@suse.de,
        akpm@linux-foundation.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next V5] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <YeAEM5k+KjqTj0iN@smile.fi.intel.com>
References: <20220113025536.1479653-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113025536.1479653-1-qiulaibin@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:55:36AM +0800, Laibin Qiu wrote:
> In case of shared tags, there might be more than one hctx which
> allocates from the same tags, and each hctx is limited to allocate at
> most:
>         hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
> 
> tag idle detection is lazy, and may be delayed for 30sec, so there
> could be just one real active hctx(queue) but all others are actually
> idle and still accounted as active because of the lazy idle detection.
> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
> forever on this real active hctx.
> 
> Fix this by recalculating wake_batch when inc or dec active_queues.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  block/blk-mq-tag.c      | 40 +++++++++++++++++++++++++++++++++-------
>  include/linux/sbitmap.h | 11 +++++++++++
>  lib/sbitmap.c           | 25 ++++++++++++++++++++++---
>  3 files changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index e55a6834c9a6..845f74e8dd7b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -16,6 +16,21 @@
>  #include "blk-mq-sched.h"
>  #include "blk-mq-tag.h"
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
>  /*
>   * If a previously inactive queue goes active, bump the active user count.
>   * We need to do this before try to allocate driver tag, then even if fail
> @@ -24,18 +39,26 @@
>   */
>  bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
> +	unsigned int users;
> +
>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
>  
> -		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) &&
> -		    !test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> -			atomic_inc(&hctx->tags->active_queues);
> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
> +			return true;
> +		}
>  	} else {
> -		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
> -		    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> -			atomic_inc(&hctx->tags->active_queues);
> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
> +			return true;
> +		}
>  	}
>  
> +	users = atomic_inc_return(&hctx->tags->active_queues);
> +
> +	blk_mq_update_wake_batch(hctx->tags, users);
> +
>  	return true;
>  }
>  
> @@ -56,6 +79,7 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
>  void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct blk_mq_tags *tags = hctx->tags;
> +	unsigned int users;
>  
>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
> @@ -68,7 +92,9 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  			return;
>  	}
>  
> -	atomic_dec(&tags->active_queues);
> +	users = atomic_dec_return(&tags->active_queues);
> +
> +	blk_mq_update_wake_batch(tags, users);
>  
>  	blk_mq_tag_wakeup_all(tags, false);
>  }
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index fc0357a6e19b..95df357ec009 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -415,6 +415,17 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
>  	sbitmap_free(&sbq->sb);
>  }
>  
> +/**
> + * sbitmap_queue_recalculate_wake_batch() - Recalculate wake batch
> + * @sbq: Bitmap queue to recalculate wake batch.
> + * @users: Number of shares.
> + *
> + * Like sbitmap_queue_update_wake_batch(), this will calculate wake batch
> + * by depth. This interface is for HCTX shared tags or queue shared tags.
> + */
> +void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int users);
> +
>  /**
>   * sbitmap_queue_resize() - Resize a &struct sbitmap_queue.
>   * @sbq: Bitmap queue to resize.
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 2709ab825499..6220fa67fb7e 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -457,10 +457,9 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
>  
> -static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> -					    unsigned int depth)
> +static inline void __sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int wake_batch)
>  {
> -	unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
>  	int i;
>  
>  	if (sbq->wake_batch != wake_batch) {
> @@ -476,6 +475,26 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
>  	}
>  }
>  
> +static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int depth)
> +{
> +	unsigned int wake_batch;
> +
> +	wake_batch = sbq_calc_wake_batch(sbq, depth);
> +	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
> +}
> +
> +void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
> +					    unsigned int users)
> +{
> +	unsigned int wake_batch;
> +
> +	wake_batch = clamp_val((sbq->sb.depth + users - 1) /
> +			users, 4, SBQ_WAKE_BATCH);
> +	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
> +}
> +EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
> +
>  void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
>  {
>  	sbitmap_queue_update_wake_batch(sbq, depth);
> -- 
> 2.22.0
> 

-- 
With Best Regards,
Andy Shevchenko


