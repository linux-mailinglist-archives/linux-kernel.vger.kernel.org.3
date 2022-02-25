Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC54C3BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiBYCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A429B2692C3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645756823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l55E8pkQ2P3LKhJVKRYi4sOOVTHPZ0peePJHbMNdgTk=;
        b=VVxJMLdsLoWEl7Xz1NEXOijnUzZqUrbAeTvKW4bd9DTz8msJXrY/OpY7dCoJdeZKcCBaZC
        hjGzR3L1LtLZlBfKhIEW6/cvsJB3Rhd7zfmjJcGTRvLijdVviomywbWo8z3+LivkGVzojz
        0HVkXB/lCCkPjNKzT30IyT8eVnMQz7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-WS-oqy_INgOKW2YZRjMCQw-1; Thu, 24 Feb 2022 21:40:19 -0500
X-MC-Unique: WS-oqy_INgOKW2YZRjMCQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 313AA805742;
        Fri, 25 Feb 2022 02:40:16 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F163C9BEB1;
        Fri, 25 Feb 2022 02:40:12 +0000 (UTC)
Date:   Fri, 25 Feb 2022 10:40:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH RFC] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <YhhBh0ehPjdARU5h@T590>
References: <20220223112601.2902761-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223112601.2902761-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:26:01PM +0800, Yu Kuai wrote:
> blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
> submit_queues through configfs for null_blk), while it might still be
> used from other context(e.g. switch elevator to none):
> 
> t1					t2
> elevator_switch
>  blk_mq_unquiesce_queue
>   blk_mq_run_hw_queues
>    queue_for_each_hw_ctx
>     // assembly code for hctx = (q)->queue_hw_ctx[i]
>     mov    0x48(%rbp),%rdx -> read old queue_hw_ctx
> 
> 					__blk_mq_update_nr_hw_queues
> 					 blk_mq_realloc_hw_ctxs
> 					  hctxs = q->queue_hw_ctx
> 					  q->queue_hw_ctx = new_hctxs
> 					  kfree(hctxs)
>     movslq %ebx,%rax
>     mov    (%rdx,%rax,8),%rdi ->uaf
> 
> This problem was found by code review, and I comfirmed that the concurrent
> scenarios do exist(specifically 'q->queue_hw_ctx' can be changed during
> blk_mq_run_hw_queues), however, the uaf problem hasn't been repoduced yet
> without hacking the kernel.
> 
> Sicne the queue is freezed in __blk_mq_update_nr_hw_queues, fix the
> problem by protecting 'queue_hw_ctx' through rcu where it can be accessed
> without grabbing 'q_usage_counter'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c         |  8 +++++++-
>  include/linux/blk-mq.h |  2 +-
>  include/linux/blkdev.h | 13 ++++++++++++-
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6c59ffe765fd..79367457d555 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3955,7 +3955,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  		if (hctxs)
>  			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
>  			       sizeof(*hctxs));
> -		q->queue_hw_ctx = new_hctxs;
> +
> +		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
> +		/*
> +		 * Make sure reading the old queue_hw_ctx from other
> +		 * context concurrently won't trigger uaf.
> +		 */
> +		synchronize_rcu();
>  		kfree(hctxs);
>  		hctxs = new_hctxs;
>  	}
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d319ffa59354..edcf8ead76c6 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -918,7 +918,7 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
>  
>  #define queue_for_each_hw_ctx(q, hctx, i)				\
>  	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
> -	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
> +	     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
>  
>  #define hctx_for_each_ctx(hctx, ctx, i)					\
>  	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3bfc75a2a450..2018a4dd2028 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -354,7 +354,7 @@ struct request_queue {
>  	unsigned int		queue_depth;
>  
>  	/* hw dispatch queues */
> -	struct blk_mq_hw_ctx	**queue_hw_ctx;
> +	struct blk_mq_hw_ctx __rcu	**queue_hw_ctx;
>  	unsigned int		nr_hw_queues;
>  
>  	/*
> @@ -622,6 +622,17 @@ static inline bool queue_is_mq(struct request_queue *q)
>  	return q->mq_ops;
>  }
>  
> +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	rcu_read_lock();
> +	hctx = *(rcu_dereference(q->queue_hw_ctx) + id);
> +	rcu_read_unlock();
> +
> +	return hctx;
> +}

queue_hctx() should be moved into linux/blk-mq.h, otherwise feel free to
add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Also it should be fine to implement queue_for_each_hw_ctx() as list, then we
can avoid the allocation for q->queue_hw_ctx without extra cost. I will work
toward that direction for improving the code.

Thanks,
Ming

