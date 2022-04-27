Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26889510E33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356781AbiD0Bk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbiD0Bk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:40:26 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67E3389B;
        Tue, 26 Apr 2022 18:37:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651023434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5COhc69ni87t4Utb0njn2GZupM3M1z5y8iXfy2AtfM=;
        b=fqiScsW8Q3L2UayIYd+DDD/vMUuNTwnD3vuhei+ybfK38V/caccV/177HVWH8c3dkpX/G2
        6nLR4WvQRstLUBei1Uuh3WpNw8MSbnHcW2Re5p0lQz1DEedzxEx66blG13lHPgMcHnPTdP
        FQ9lpanIIAdtELrDhc70hBXgIsSKLUc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 09/12] md/raid5: Keep a reference to last stripe_head
 for batch
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-10-logang@deltatee.com>
Message-ID: <56208e2a-5035-eb8e-c468-70b4dae66d5c@linux.dev>
Date:   Wed, 27 Apr 2022 09:36:59 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 3:54 AM, Logan Gunthorpe wrote:
> When batching, every stripe head has to find the previous stripe head to
> add to the batch list. This involves taking the hash lock which is
> highly contended during IO.
>
> Instead of finding the previous stripe_head each time, store a
> reference to the previous stripe_head in a pointer so that it doesn't
> require taking the contended lock another time.
>
> The reference to the previous stripe must be released before scheduling
> and waiting for work to get done. Otherwise, it can hold up
> raid5_activate_delayed() and deadlock.
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 51 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 0c250cc3bfff..28ea7b9b6ab6 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -843,7 +843,8 @@ static bool stripe_can_batch(struct stripe_head *sh)
>   }
>   
>   /* we only do back search */
> -static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh)
> +static void stripe_add_to_batch_list(struct r5conf *conf,
> +		struct stripe_head *sh, struct stripe_head *last_sh)

Nit, from stripe_add_to_batch_list's view, I think "head_sh" makes more 
sense than
"last_sh".

>   {
>   	struct stripe_head *head;
>   	sector_t head_sector, tmp_sec;
> @@ -856,15 +857,20 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
>   		return;
>   	head_sector = sh->sector - RAID5_STRIPE_SECTORS(conf);
>   
> -	hash = stripe_hash_locks_hash(conf, head_sector);
> -	spin_lock_irq(conf->hash_locks + hash);
> -	head = find_get_stripe(conf, head_sector, conf->generation, hash);
> -	spin_unlock_irq(conf->hash_locks + hash);
> -
> -	if (!head)
> -		return;
> -	if (!stripe_can_batch(head))
> -		goto out;
> +	if (last_sh && head_sector == last_sh->sector) {
> +		head = last_sh;
> +		atomic_inc(&head->count);
> +	} else {
> +		hash = stripe_hash_locks_hash(conf, head_sector);
> +		spin_lock_irq(conf->hash_locks + hash);
> +		head = find_get_stripe(conf, head_sector, conf->generation,
> +				       hash);
> +		spin_unlock_irq(conf->hash_locks + hash);
> +		if (!head)
> +			return;
> +		if (!stripe_can_batch(head))
> +			goto out;
> +	}
>   
>   	lock_two_stripes(head, sh);
>   	/* clear_batch_ready clear the flag */
> @@ -5800,6 +5806,7 @@ enum stripe_result {
>   
>   struct stripe_request_ctx {
>   	bool do_flush;
> +	struct stripe_head *batch_last;
>   };
>   
>   static enum stripe_result make_stripe_request(struct mddev *mddev,
> @@ -5889,8 +5896,13 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
>   		return STRIPE_SCHEDULE_AND_RETRY;
>   	}
>   
> -	if (stripe_can_batch(sh))
> -		stripe_add_to_batch_list(conf, sh);
> +	if (stripe_can_batch(sh)) {
> +		stripe_add_to_batch_list(conf, sh, ctx->batch_last);
> +		if (ctx->batch_last)
> +			raid5_release_stripe(ctx->batch_last);
> +		atomic_inc(&sh->count);
> +		ctx->batch_last = sh;
> +	}
>   
>   	if (ctx->do_flush) {
>   		set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
> @@ -5979,6 +5991,18 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   		} else if (res == STRIPE_RETRY) {
>   			continue;
>   		} else if (res == STRIPE_SCHEDULE_AND_RETRY) {
> +			/*
> +			 * Must release the reference to batch_last before
> +			 * scheduling and waiting for work to be done,
> +			 * otherwise the batch_last stripe head could prevent
> +			 * raid5_activate_delayed() from making progress
> +			 * and thus deadlocking.
> +			 */
> +			if (ctx.batch_last) {
> +				raid5_release_stripe(ctx.batch_last);
> +				ctx.batch_last = NULL;
> +			}
> +
>   			schedule();
>   			prepare_to_wait(&conf->wait_for_overlap, &w,
>   					TASK_UNINTERRUPTIBLE);
> @@ -5990,6 +6014,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   
>   	finish_wait(&conf->wait_for_overlap, &w);
>   
> +	if (ctx.batch_last)
> +		raid5_release_stripe(ctx.batch_last);
> +
>   	if (rw == WRITE)
>   		md_write_end(mddev);
>   	bio_endio(bi);

Otherwise looks good, Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
