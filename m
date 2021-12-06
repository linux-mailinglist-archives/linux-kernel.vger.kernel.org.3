Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4046908C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhLFG5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhLFG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:57:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEABC0613F8;
        Sun,  5 Dec 2021 22:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PIDad4BiRRHin78sW0jh4LM4NNQD2KtvRec7D495m+s=; b=DR12M2s914TdO5YXtPOXhp1iMY
        5NWb+ye4+7whB+JQBzjf7u/O7FLvjfybOWxdNhLSTFawkiszJpJ6wfzsJZjIrV/LX9BQu2qk0Hr6u
        ElOQRi90V+CUPyXXvoPLXHUEDL1EC7KBXMrLFbbNdxqRlIJoLE2VuaxiaBcJW3o6zyJyDz8tIMiP3
        DOZiZvmyE2TqjIHKzuHTwSG6DJ62jjo+gwE+EL5Dlo9d6xWjNvG7UhQaB5nS6xqgkZYavX0n4DkUW
        yD5Ux6P67e5RcqJ3HPPlsBrxS4N1TlsBIaBH1/hqA31gzq1cd+eAeFgNKa29nQLTIaHOfXsV9+hVk
        wJ43Ndjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu7sj-002i3b-Or; Mon, 06 Dec 2021 06:53:49 +0000
Date:   Sun, 5 Dec 2021 22:53:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya2zfVAwh4aQ7KVd@infradead.org>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
> refcount_t is not as expensive as it used to be, but it's still more
> expensive than the io_uring method of using atomic_t and just checking
> for potential over/underflow.
> 
> This borrows that same implementation, which in turn is based on the
> mm implementation from Linus.

If refcount_t isn't good enough for a normal kernel fast path we have
a problem.  Can we discuss that with the maintainers instead of coming
up with our home grown schemes again?

> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index f78bb39e589e..e4df894189ce 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -229,7 +229,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  	/* release the tag's ownership to the req cloned from */
>  	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>  
> -	if (!refcount_dec_and_test(&flush_rq->ref)) {
> +	if (!req_ref_put_and_test(flush_rq)) {
>  		fq->rq_status = error;
>  		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>  		return;
> @@ -349,7 +349,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  	 * and READ flush_rq->end_io
>  	 */
>  	smp_wmb();
> -	refcount_set(&flush_rq->ref, 1);
> +	req_ref_set(flush_rq, 1);
>  
>  	blk_flush_queue_rq(flush_rq, false);
>  }
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 995336abee33..380e2dd31bfc 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -228,7 +228,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>  
>  	spin_lock_irqsave(&tags->lock, flags);
>  	rq = tags->rqs[bitnr];
> -	if (!rq || rq->tag != bitnr || !refcount_inc_not_zero(&rq->ref))
> +	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
>  		rq = NULL;
>  	spin_unlock_irqrestore(&tags->lock, flags);
>  	return rq;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fa464a3e2f9a..22ec21aa0c22 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -386,7 +386,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	INIT_LIST_HEAD(&rq->queuelist);
>  	/* tag was already set */
>  	WRITE_ONCE(rq->deadline, 0);
> -	refcount_set(&rq->ref, 1);
> +	req_ref_set(rq, 1);
>  
>  	if (rq->rq_flags & RQF_ELV) {
>  		struct elevator_queue *e = data->q->elevator;
> @@ -634,7 +634,7 @@ void blk_mq_free_request(struct request *rq)
>  	rq_qos_done(q, rq);
>  
>  	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
> -	if (refcount_dec_and_test(&rq->ref))
> +	if (req_ref_put_and_test(rq))
>  		__blk_mq_free_request(rq);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_free_request);
> @@ -930,7 +930,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>  		rq_qos_done(rq->q, rq);
>  
>  		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
> -		if (!refcount_dec_and_test(&rq->ref))
> +		if (!req_ref_put_and_test(rq))
>  			continue;
>  
>  		blk_crypto_free_request(rq);
> @@ -1373,7 +1373,7 @@ void blk_mq_put_rq_ref(struct request *rq)
>  {
>  	if (is_flush_rq(rq))
>  		rq->end_io(rq, 0);
> -	else if (refcount_dec_and_test(&rq->ref))
> +	else if (req_ref_put_and_test(rq))
>  		__blk_mq_free_request(rq);
>  }
>  
> @@ -3003,7 +3003,7 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>  			unsigned long rq_addr = (unsigned long)rq;
>  
>  			if (rq_addr >= start && rq_addr < end) {
> -				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> +				WARN_ON_ONCE(req_ref_read(rq) != 0);
>  				cmpxchg(&drv_tags->rqs[i], rq, NULL);
>  			}
>  		}
> @@ -3337,7 +3337,7 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>  	if (!tags)
>  		return;
>  
> -	WARN_ON_ONCE(refcount_read(&flush_rq->ref) != 0);
> +	WARN_ON_ONCE(req_ref_read(flush_rq) != 0);
>  
>  	for (i = 0; i < queue_depth; i++)
>  		cmpxchg(&tags->rqs[i], flush_rq, NULL);
> diff --git a/block/blk.h b/block/blk.h
> index 296411900c55..f869f4b2dec9 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -473,4 +473,35 @@ static inline bool should_fail_request(struct block_device *part,
>  }
>  #endif /* CONFIG_FAIL_MAKE_REQUEST */
>  
> +/*
> + * Optimized request reference counting. Ideally we'd make timeouts be more
> + * clever, as that's the only reason we need references at all... But until
> + * this happens, this is faster than using refcount_t. Also see:
> + *
> + * abc54d634334 ("io_uring: switch to atomic_t for io_kiocb reference count")
> + */
> +#define req_ref_zero_or_close_to_overflow(req)	\
> +	((unsigned int) atomic_read(&(req->ref)) + 127u <= 127u)
> +
> +static inline bool req_ref_inc_not_zero(struct request *req)
> +{
> +	return atomic_inc_not_zero(&req->ref);
> +}
> +
> +static inline bool req_ref_put_and_test(struct request *req)
> +{
> +	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
> +	return atomic_dec_and_test(&req->ref);
> +}
> +
> +static inline void req_ref_set(struct request *req, int value)
> +{
> +	atomic_set(&req->ref, value);
> +}
> +
> +static inline int req_ref_read(struct request *req)
> +{
> +	return atomic_read(&req->ref);
> +}
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index bfc3cc61f653..ecdc049b52fa 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -138,7 +138,7 @@ struct request {
>  	unsigned short ioprio;
>  
>  	enum mq_rq_state state;
> -	refcount_t ref;
> +	atomic_t ref;
>  
>  	unsigned long deadline;
>  
> -- 
> Jens Axboe
> 
---end quoted text---
