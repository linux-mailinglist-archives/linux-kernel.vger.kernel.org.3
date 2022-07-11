Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D48570584
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGKO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:26:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BA3E777;
        Mon, 11 Jul 2022 07:26:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4981622883;
        Mon, 11 Jul 2022 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657549585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=488ybXHyQ9dTQxv/0NhYicS8m3azVQFOTjaP5asAGEw=;
        b=BxaZfbhRNeSmWsq7zQTbPI6jAcEpVWRK1VlgQEsnRXCs4xQXk3ACp30FlQg6Ws9s0pziXX
        jhMkagbr81VVz8T6iLpbYWn3H89BJfzFXGdkTpYssoZYkXOj8dy72OfYyiIdgdLs/Z104o
        c+AvhPO0OYkhgxLx5zMIL6+UWTr/mME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657549585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=488ybXHyQ9dTQxv/0NhYicS8m3azVQFOTjaP5asAGEw=;
        b=YNR64VJxa20mVAWdeq+KFvh6/4AiC47WSrHuote5zCqrVK+pgD33nhrhUfb0802iAqnbHM
        +rhShpDi0gwmtrAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8E1A2C141;
        Mon, 11 Jul 2022 14:26:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B961A063F; Mon, 11 Jul 2022 16:26:23 +0200 (CEST)
Date:   Mon, 11 Jul 2022 16:26:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        jack@suse.cz, kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC v3 2/3] sbitmap: fix invalid wakeup on the wrong
 waitqueue
Message-ID: <20220711142623.haam2wks36xa5nde@quack3.lan>
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
 <20220710042200.20936-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710042200.20936-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 10-07-22 12:21:59, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> For example, 2 * wake_batch tags are put, while only wake_batch threads
> are woken:
> 
> __sbq_wake_up
>  atomic_cmpxchg -> reset wait_cnt
> 			__sbq_wake_up -> decrease wait_cnt
> 			...
> 			__sbq_wake_up -> wait_cnt is decreased to 0 again
> 			 atomic_cmpxchg
> 			 sbq_index_atomic_inc -> increase wake_index
> 			 wake_up_nr -> wake up and waitqueue might be empty
>  sbq_index_atomic_inc -> increase again, one waitqueue is skipped
>  wake_up_nr -> invalid wake up because old wakequeue might be empty
> 
> To fix the problem, increasing 'wake_index' before resetting 'wait_cnt'.
> 
> Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

This patch and the following one look sane to me but please merge them to a
single patch. They fix the same race of two concurrent wakers just with a
slightly different timing so there isn't a point in having two patches for
this (in particular changes in this patch are difficult to reason about
when we know the result is still buggy).

								Honza

> ---
>  lib/sbitmap.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index b46fce1beb3a..57095dd88a33 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -616,32 +616,33 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  		return false;
>  
>  	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> -	if (wait_cnt <= 0) {
> -		int ret;
> +	if (wait_cnt > 0)
> +		return false;
>  
> -		wake_batch = READ_ONCE(sbq->wake_batch);
> +	/*
> +	 * For concurrent callers of this, callers should call this function
> +	 * again to wakeup a new batch on a different 'ws'.
> +	 */
> +	if (wait_cnt < 0)
> +		return true;
>  
> -		/*
> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
> -		 * ensure that we see the batch size update before the wait
> -		 * count is reset.
> -		 */
> -		smp_mb__before_atomic();
> +	wake_batch = READ_ONCE(sbq->wake_batch);
>  
> -		/*
> -		 * For concurrent callers of this, the one that failed the
> -		 * atomic_cmpxhcg() race should call this function again
> -		 * to wakeup a new batch on a different 'ws'.
> -		 */
> -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
> -		if (ret == wait_cnt) {
> -			sbq_index_atomic_inc(&sbq->wake_index);
> -			wake_up_nr(&ws->wait, wake_batch);
> -			return false;
> -		}
> +	/*
> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> +	 * ensure that we see the batch size update before the wait
> +	 * count is reset.
> +	 */
> +	smp_mb__before_atomic();
>  
> -		return true;
> -	}
> +	/*
> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> +	 * invalid wakeup on the old waitqueue.
> +	 */
> +	sbq_index_atomic_inc(&sbq->wake_index);
> +	atomic_set(&ws->wait_cnt, wake_batch);
> +	wake_up_nr(&ws->wait, wake_batch);
>  
>  	return false;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
