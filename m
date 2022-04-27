Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D448A510E74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357040AbiD0CKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355825AbiD0CKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:10:15 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4925C76;
        Tue, 26 Apr 2022 19:07:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651025222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjPBVknVIOgZRzCgOW+0lSaIne05O2GDh1jZyFHKB7A=;
        b=o6QuC1mOm03nSgHhC7b1sFcbm5JRosDT8t8+0zfC8CwEFs+d31n6mYp9Y2hM9/T7HcnxbR
        9PyEmijkQe0RiE9VHPx5P2k3rcBiMyqKnGNSe7KZ/LBJOCtRdhBzDtnBHlBrh1FxNS7kOi
        LIwNLME4+Q96BQ0Z4zi3pwagjK2iiTw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 12/12] md/raid5: Pivot raid5_make_request()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-13-logang@deltatee.com>
Message-ID: <61411981-6401-aaa7-9d3d-6a9ac1fec4f2@linux.dev>
Date:   Wed, 27 Apr 2022 10:06:58 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-13-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 3:54 AM, Logan Gunthorpe wrote:

> The number of times the lock is taken can be reduced by pivoting
> raid5_make_request() so that it loops through every stripe and then
> loops through every disk in that stripe to see if the bio must be
> added. This reduces the number of times the lock must be taken by
> a factor equal to the number of data disks.
>
> To accomplish this, store the minimum and maxmimum disk sector that
> has already been finished and continue to the next logical sector if
> it is found that the disk sector has already been done. Then add a
> add_all_stripe_bios() to check all the bios for overlap and add them
> all if none of them overlap.
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 92 +++++++++++++++++++++++++++++++++++++++++++---
>   drivers/md/raid5.h |  1 +
>   2 files changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 40a25c4b80bd..f86866cb15be 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -3571,6 +3571,48 @@ static bool add_stripe_bio(struct stripe_head *sh, struct bio *bi,
>   	return true;
>   }
>   
> +static int add_all_stripe_bios(struct stripe_head *sh, struct bio *bi,
> +		sector_t first_logical_sector, sector_t last_sector,
> +		int forwrite, int previous)
> +{
> +	int dd_idx;
> +	int ret = 1;
> +
> +	spin_lock_irq(&sh->stripe_lock);
> +
> +	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
> +		struct r5dev *dev = &sh->dev[dd_idx];
> +
> +		clear_bit(R5_BioReady, &dev->flags);
> +
> +		if (dd_idx == sh->pd_idx)
> +			continue;
> +
> +		if (dev->sector < first_logical_sector ||
> +		    dev->sector >= last_sector)
> +			continue;
> +
> +		if (stripe_bio_overlaps(sh, bi, dd_idx, forwrite)) {
> +			set_bit(R5_Overlap, &dev->flags);
> +			ret = 0;
> +			continue;
> +		}
> +
> +		set_bit(R5_BioReady, &dev->flags);

Is  it possible to just call __add_stripe_bio here? And change above 
"continue"
to "return",

> +	}
> +
> +	if (!ret)
> +		goto out;
> +
> +	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++)
> +		if (test_bit(R5_BioReady, &sh->dev[dd_idx].flags))
> +			__add_stripe_bio(sh, bi, dd_idx, forwrite, previous);

then we don't need another loop here, also no need to introduce another 
flag.
But I am not sure it is feasible, so just FYI.

> +
> +out:
> +	spin_unlock_irq(&sh->stripe_lock);
> +	return ret;
> +}
> +
>   static void end_reshape(struct r5conf *conf);
>   
>   static void stripe_set_idx(sector_t stripe, struct r5conf *conf, int previous,
> @@ -5869,6 +5911,10 @@ enum stripe_result {
>   struct stripe_request_ctx {
>   	bool do_flush;
>   	struct stripe_head *batch_last;
> +	sector_t disk_sector_done;
> +	sector_t start_disk_sector;
> +	bool first_wrap;
> +	sector_t last_sector;
>   };

Could you add some comments to above members if possible?

>   static enum stripe_result make_stripe_request(struct mddev *mddev,
> @@ -5908,6 +5954,36 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
>   
>   	new_sector = raid5_compute_sector(conf, logical_sector, previous,
>   					  &dd_idx, NULL);
> +
> +	/*
> +	 * This is a tricky algorithm to figure out which stripe_heads that
> +	 * have already been visited and exit early if the stripe_head has
> +	 * already been done. (Seeing all disks are added to a stripe_head
> +	 * once in add_all_stripe_bios().
> +	 *
> +	 * To start with, the disk sector of the last stripe that has been
> +	 * completed is stored in ctx->disk_sector_done. If the new_sector is
> +	 * less than this value, the stripe_head has already been done.
> +	 *
> +	 * There's one issue with this: if the request starts in the middle of
> +	 * a chunk, all the stripe heads before the starting offset will be
> +	 * missed. To account for this, set the first_wrap boolean to true
> +	 * if new_sector is less than the starting sector. Clear the
> +	 * boolean once the start sector is hit for the second time.
> +	 * When first_wrap is set, ignore the disk_sector_done.
> +	 */
> +	if (ctx->start_disk_sector == MaxSector) {
> +		ctx->start_disk_sector = new_sector;
> +	} else if (new_sector < ctx->start_disk_sector) {
> +		ctx->first_wrap = true;
> +	} else if (new_sector == ctx->start_disk_sector) {
> +		ctx->first_wrap = false;
> +		ctx->start_disk_sector = 0;
> +		return STRIPE_SUCCESS;
> +	} else if (!ctx->first_wrap && new_sector <= ctx->disk_sector_done) {
> +		return STRIPE_SUCCESS;
> +	}
> +

Hmm, with above tricky algorithm, I guess the point is that we can avoid 
to call below
stripe_add_to_batch_list where has hash_lock contention. If so, maybe we 
can change
stripe_can_batch for the purpose.

>   	if (stripe_can_batch(sh)) {
>   		stripe_add_to_batch_list(conf, sh, ctx->batch_last);
>   		if (ctx->batch_last)
> @@ -5977,8 +6057,10 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
>   static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   {
>   	struct r5conf *conf = mddev->private;
> -	sector_t logical_sector, last_sector;
> -	struct stripe_request_ctx ctx = {};
> +	sector_t logical_sector;
> +	struct stripe_request_ctx ctx = {
> +		.start_disk_sector = MaxSector,
> +	};
>   	const int rw = bio_data_dir(bi);
>   	enum stripe_result res;
>   	DEFINE_WAIT(w);
> @@ -6021,7 +6103,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   	}
>   
>   	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
> -	last_sector = bio_end_sector(bi);
> +	ctx.last_sector = bio_end_sector(bi);
>   	bi->bi_next = NULL;
>   
>   	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
> @@ -6036,7 +6118,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   	}
>   	md_account_bio(mddev, &bi);
>   	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
> -	while (logical_sector < last_sector) {
> +	while (logical_sector < ctx.last_sector) {
>   		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
>   					  bi);
>   		if (res == STRIPE_FAIL) {
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index 638d29863503..e73b58844f83 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -308,6 +308,7 @@ enum r5dev_flags {
>   	R5_Wantwrite,
>   	R5_Overlap,	/* There is a pending overlapping request
>   			 * on this block */
> +	R5_BioReady,    /* The current bio can be added to this disk */

This doesn't seem right to me, since the comment describes bio status 
while others
are probably for r5dev.

Thanks,
Guoqing
