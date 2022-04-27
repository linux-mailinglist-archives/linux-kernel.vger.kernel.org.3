Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F128F510DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356749AbiD0Bgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiD0Bgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:36:31 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA97A66F0;
        Tue, 26 Apr 2022 18:33:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651023200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJ0BYmUwc/GyjdfAIE3jQLZkoojPVXvCARqqGbjwuhI=;
        b=VekbOKndbBZSPe69eANEz0i4Jp5bu/OsmUNFMrj6PkwtL6feGlCe9MJDj4fKEg0EpRQ7gA
        ViDP+77LDffjwNQiN+T8flEwt2+k06HFUlDohHmq132/EQ84r6kIm4Fqw0GqnZTAfapZgL
        SnRbvB1uL+z5M56TCelPjnV5MN7k6f0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 03/12] md/raid5: Move stripe_add_to_batch_list() call
 out of add_stripe_bio()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-4-logang@deltatee.com>
Message-ID: <fb442f7c-aa5c-96ed-05af-336f83f77da7@linux.dev>
Date:   Wed, 27 Apr 2022 09:33:06 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-4-logang@deltatee.com>
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
> stripe_add_to_batch_list() is better done in the loop in make_request
> instead of inside add_stripe_bio(). This is clearer and allows for
> storing the batch_head state outside the loop in a subsequent patch.
>
> The call to add_stripe_bio() in retry_aligned_read() is for read
> and batching only applies to write. So it's impossible for batching
> to happen at that call site.
>
> No functional changes intended.
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> ---
>   drivers/md/raid5.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index cda6857e6207..8e1ece5ce984 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -3534,8 +3534,6 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
>   	}
>   	spin_unlock_irq(&sh->stripe_lock);
>   
> -	if (stripe_can_batch(sh))
> -		stripe_add_to_batch_list(conf, sh);
>   	return 1;
>   
>    overlap:
> @@ -5955,6 +5953,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   			goto retry;
>   		}
>   
> +		if (stripe_can_batch(sh))
> +			stripe_add_to_batch_list(conf, sh);
> +
>   		if (do_flush) {
>   			set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
>   			/* we only need flush for one stripe */


Reviewed-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
