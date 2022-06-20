Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518625518C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiFTMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiFTMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:24:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEEA17A81;
        Mon, 20 Jun 2022 05:24:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3CB8721A0A;
        Mon, 20 Jun 2022 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655727854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szjcwut6+QuopwIICvzKkCtk+pFZeTRdHGKl9VaIjCY=;
        b=BgRhqo7Wd27/xG/RV2ZpbrV8CxXXQNEpVKEwCAmxAzTwdOUVsdMcaSVhX/TVsW96UaKlFG
        4XyqFVBSnPMLQa0njpmBr3D2UvWf2E+uKB/ShuF5YcSiGPUte11cix5pmBZtxBBe9ar4IQ
        RhI3GB0Iwc/9M6nusfDF8zMfXkmx4TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655727854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szjcwut6+QuopwIICvzKkCtk+pFZeTRdHGKl9VaIjCY=;
        b=lrFFDTDamcUVK6o34xZ7QfUOkL6f6LLudz25a2Omcm3xltpgiciAxO+2mN0CCRMf2K0sGb
        7J8tHYGW133OOjBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 200952C161;
        Mon, 20 Jun 2022 12:24:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA801A0636; Mon, 20 Jun 2022 14:24:13 +0200 (CEST)
Date:   Mon, 20 Jun 2022 14:24:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC -next] sbitmap: fix possible io hung due to lost
 wakeups
Message-ID: <20220620122413.2fewshn5u6t2y4oi@quack3.lan>
References: <20220617141125.3024491-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617141125.3024491-1-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-06-22 22:11:25, Yu Kuai wrote:
> Currently, same waitqueue might be woken up continuously:
> 
> __sbq_wake_up		__sbq_wake_up
>  sbq_wake_ptr -> assume	0
> 			 sbq_wake_ptr -> 0
>  atomic_dec_return
> 			atomic_dec_return
>  atomic_cmpxchg -> succeed
> 			 atomic_cmpxchg -> failed
> 			  return true
> 
> 			__sbq_wake_up
> 			 sbq_wake_ptr
> 			  atomic_read(&sbq->wake_index) -> still 0
>  sbq_index_atomic_inc -> inc to 1
> 			  if (waitqueue_active(&ws->wait))
> 			   if (wake_index != atomic_read(&sbq->wake_index))
> 			    atomic_set -> reset from 1 to 0
>  wake_up_nr -> wake up first waitqueue
> 			    // continue to wake up in first waitqueue
> 
> What's worse, io hung is possible in theory because wakeups might be
> missed. For example, 2 * wake_batch tags are put, while only wake_batch
> threads are worken:
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
> To fix the problem, refactor to make sure waitqueues will be woken up
> one by one,
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

So as far as I can tell your patch does not completely fix this race. See
below:

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index ae4fd4de9ebe..dc2959cb188c 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -574,66 +574,69 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>  
> -static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
> +static void sbq_update_wake_index(struct sbitmap_queue *sbq,
> +				  int old_wake_index)
>  {
>  	int i, wake_index;
> -
> -	if (!atomic_read(&sbq->ws_active))
> -		return NULL;
> +	struct sbq_wait_state *ws;
>  
>  	wake_index = atomic_read(&sbq->wake_index);
> -	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
> -		struct sbq_wait_state *ws = &sbq->ws[wake_index];
> +	if (old_wake_index != wake_index)
> +		return;
>  
> +	for (i = 1; i < SBQ_WAIT_QUEUES; i++) {
> +		wake_index = sbq_index_inc(wake_index);
> +		ws = &sbq->ws[wake_index];
> +		/* Find the next active waitqueue in round robin manner */
>  		if (waitqueue_active(&ws->wait)) {
> -			if (wake_index != atomic_read(&sbq->wake_index))
> -				atomic_set(&sbq->wake_index, wake_index);
> -			return ws;
> +			atomic_cmpxchg(&sbq->wake_index, old_wake_index,
> +				       wake_index);
> +			return;
>  		}
> -
> -		wake_index = sbq_index_inc(wake_index);
>  	}
> -
> -	return NULL;
>  }
>  
>  static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  {
>  	struct sbq_wait_state *ws;
>  	unsigned int wake_batch;
> -	int wait_cnt;
> +	int wait_cnt, wake_index;
>  
> -	ws = sbq_wake_ptr(sbq);
> -	if (!ws)
> +	if (!atomic_read(&sbq->ws_active))
>  		return false;
>  
> -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> -	if (wait_cnt <= 0) {
> -		int ret;
> -
> -		wake_batch = READ_ONCE(sbq->wake_batch);
> -
> -		/*
> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
> -		 * ensure that we see the batch size update before the wait
> -		 * count is reset.
> -		 */
> -		smp_mb__before_atomic();
> +	wake_index = atomic_read(&sbq->wake_index);
> +	ws = &sbq->ws[wake_index];
> +	/*
> +	 * This can only happen in the first wakeup when sbitmap waitqueues
> +	 * are no longer idle.
> +	 */
> +	if (!waitqueue_active(&ws->wait)) {
> +		sbq_update_wake_index(sbq, wake_index);
> +		return true;
> +	}
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
> +	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> +	if (wait_cnt > 0)
> +		return false;

The following race is still possible:

CPU1					CPU2
__sbq_wake_up				__sbq_wake_up
  wake_index = atomic_read(&sbq->wake_index);
					  wake_index = atomic_read(&sbq->wake_index);

  if (!waitqueue_active(&ws->wait)) -> not taken
					  if (!waitqueue_active(&ws->wait)) -> not taken
  wait_cnt = atomic_dec_return(&ws->wait_cnt);
  /* decremented to 0 now */
  if (wait_cnt > 0) -> not taken
  sbq_update_wake_index(sbq, wake_index);
  if (wait_cnt < 0) -> not taken
  ...
  atomic_set(&ws->wait_cnt, wake_batch);
  wake_up_nr(&ws->wait, wake_batch);
					  wait_cnt = atomic_dec_return(&ws->wait_cnt);
					  /*
					   * decremented to wake_batch - 1 but
					   * there are no tasks waiting anymore
					   * so the wakeup should have gone
					   * to a different waitqueue.
					   */

I have an idea how to fix all these lost wakeups, I'll try to code it
whether it would look usable...

								Honza
  
> +	sbq_update_wake_index(sbq, wake_index);
> +	/*
> +	 * Concurrent callers should call this function again
> +	 * to wakeup a new batch on a different 'ws'.
> +	 */
> +	if (wait_cnt < 0)
>  		return true;
> -	}
> +
> +	wake_batch = READ_ONCE(sbq->wake_batch);
> +	/*
> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> +	 * ensure that we see the batch size update before the wait
> +	 * count is reset.
> +	 */
> +	smp_mb__before_atomic();
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
