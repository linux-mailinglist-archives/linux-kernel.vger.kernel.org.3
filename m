Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D05510E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356984AbiD0B4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356978AbiD0B4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:56:33 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC2FE5D2;
        Tue, 26 Apr 2022 18:53:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651024403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9OJAJ+VWS+nkDw471oltmZA8ASzZzfxknB1OTs/0Yc=;
        b=MeWuCZM+tNSEl8NWdJ61UgByFG/nGiTRAITfgH6MhxkKsPh+nRYwSRR0rDm20mEsxW8BAj
        qTAuuUEVAG4gNEWBNzUK7XnOsTsrKZWu7uv7yYHz4lRzhMwXUyBu2GJuH1BqT0H12ScS3J
        OvQdLZyOgDFd+M1DTzP8hisApnc1Seg=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 11/12] md/raid5: Check all disks in a stripe_head for
 reshape progress
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-12-logang@deltatee.com>
Message-ID: <7f61aacd-d378-092c-1291-f2aaf42a5537@linux.dev>
Date:   Wed, 27 Apr 2022 09:53:16 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-12-logang@deltatee.com>
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
> When testing if a previous stripe has had reshape expand past it, use
> the earliest or latest logical sector in all the disks for that stripe
> head. This will allow adding multiple disks at a time in a subesquent
> patch.
>
> To do this cleaner, refactor the check into a helper function called
> stripe_ahead_of_reshape().
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 55 ++++++++++++++++++++++++++++++++++------------
>   1 file changed, 41 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 1fa82d8fa89e..40a25c4b80bd 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5823,6 +5823,42 @@ static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
>   		return sector >= reshape_sector;
>   }
>   
> +static bool range_ahead_of_reshape(struct mddev *mddev, sector_t min,
> +				   sector_t max, sector_t reshape_sector)
> +{
> +	if (mddev->reshape_backwards)
> +		return max < reshape_sector;
> +	else
> +		return min >= reshape_sector;
> +}
> +
> +static bool stripe_ahead_of_reshape(struct mddev *mddev, struct r5conf *conf,
> +				    struct stripe_head *sh)
> +{
> +	sector_t max_sector = 0, min_sector = MaxSector;
> +	bool ret = false;
> +	int dd_idx;
> +
> +	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
> +		if (dd_idx == sh->pd_idx)
> +			continue;
> +
> +		min_sector = min(min_sector, sh->dev[dd_idx].sector);
> +		max_sector = min(max_sector, sh->dev[dd_idx].sector);
> +	}
> +
> +	spin_lock_irq(&conf->device_lock);
> +
> +	if (!range_ahead_of_reshape(mddev, min_sector, max_sector,
> +				     conf->reshape_progress))
> +		/* mismatch, need to try again */
> +		ret = true;

I think we can just open code range_ahead_of_reshape.

And seems the above is not same as below original checking which compare
logical_sector with reshape_progress. Is it intentional or am I miss 
something?

...

> -		int must_retry = 0;
> -		spin_lock_irq(&conf->device_lock);
> -		if (!ahead_of_reshape(mddev, logical_sector,
> -				      conf->reshape_progress))
> -			/* mismatch, need to try again */
> -			must_retry = 1;
> -		spin_unlock_irq(&conf->device_lock);
> -		if (must_retry) {
> -			raid5_release_stripe(sh);
> -			return STRIPE_SCHEDULE_AND_RETRY;
> -		}
> +		raid5_release_stripe(sh);
> +		return STRIPE_SCHEDULE_AND_RETRY;
>   	}
>   
>   	if (read_seqcount_retry(&conf->gen_lock, seq)) {

Thanks,
Guoqing
