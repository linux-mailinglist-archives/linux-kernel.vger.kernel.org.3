Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66349510DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356693AbiD0BcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbiD0BcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:32:12 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3785669;
        Tue, 26 Apr 2022 18:29:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651022939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIHaNF4527y5Q6cHf2f9Nqj4nsyw93HOagsxqabub9Y=;
        b=ICUhEc2eK9UWupUv/x/Cuz1UaSthfDD5cy9YHCcnZk9Em8EEUaJ95qRC6ys6vlJDZTHhpi
        pTh2qCCuYGjf1omC10b+Cm8VkStGFbFblZ2b4erj/VQLDnXVIyozPCd+qWwFfueqOEzpCr
        Koc1uqN09+z2OQ8leadVYXzKLavPw/Q=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
Message-ID: <2a6d5554-4f71-6476-6d14-031da52005f5@linux.dev>
Date:   Wed, 27 Apr 2022 09:28:33 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> There are a few uses of an ugly ternary operator in raid5_make_request()
> to check if a sector is a head of a reshape sector.
>
> Factor this out into a simple helper called ahead_of_reshape().
>
> This appears to fix the first bio_wouldblock_error() check which appears
> to have comparison operators that didn't match the check below which
> causes a schedule. Besides this, no functional changes intended.
>
> Suggested-by: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7f7d1546b9ba..97b23c18402b 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5787,6 +5787,15 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
>   	bio_endio(bi);
>   }
>   
> +static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
> +			     sector_t reshape_sector)
> +{
> +	if (mddev->reshape_backwards)
> +		return sector < reshape_sector;
> +	else
> +		return sector >= reshape_sector;
> +}

I think it can be an inline function.

> +
>   static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   {
>   	struct r5conf *conf = mddev->private;
> @@ -5843,9 +5852,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
>   	if ((bi->bi_opf & REQ_NOWAIT) &&
>   	    (conf->reshape_progress != MaxSector) &&
> -	    (mddev->reshape_backwards
> -	    ? (logical_sector > conf->reshape_progress && logical_sector <= conf->reshape_safe)
> -	    : (logical_sector >= conf->reshape_safe && logical_sector < conf->reshape_progress))) {
> +	    !ahead_of_reshape(mddev, logical_sector, conf->reshape_progress) &&
> +	    ahead_of_reshape(mddev, logical_sector, conf->reshape_safe)) {

TBH, the previous code is more readable to me though I can live with the 
change.

Thanks,
Guoqing
