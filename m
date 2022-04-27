Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389A8510E00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356757AbiD0BhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiD0BhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:37:13 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF95EE4C0;
        Tue, 26 Apr 2022 18:34:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651023242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rZC5aVdSXkBLDwWCrl2fIbD+VenQYPFUKlleoOQy8k=;
        b=QBuB6T6/vFlz5C+4+SqhzS1HYXbwJxcHaFTyobt4M2auFMBiyd6vq6lt+HoLKXxO7uCyH8
        j268ij0pE/9fLUGt+ViAJ5g/bTFgQwTLIv/hRlM8K50XKrI7Kk/bpXNMECzH2ykBgYv33M
        SaGR8MJbrkKp6bKmVp+48T7EksnfyF8=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 04/12] md/raid5: Move common stripe count increment
 code into __find_stripe()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-5-logang@deltatee.com>
Message-ID: <8d44a290-cb46-cbbe-6289-14d2cca44c2c@linux.dev>
Date:   Wed, 27 Apr 2022 09:33:52 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-5-logang@deltatee.com>
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
> Both uses of find_stripe() require a fairly complicated dance to
> increment the reference count. Move this into a common find_get_stripe()
> helper.
>
> No functional changes intended.
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 133 ++++++++++++++++++++++-----------------------
>   1 file changed, 65 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8e1ece5ce984..a0946af5b1ac 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -612,7 +612,7 @@ static void init_stripe(struct stripe_head *sh, sector_t sector, int previous)
>   }

...

>   @@ -624,6 +624,49 @@ static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
>   	return NULL;
>   }
>   
> +static struct stripe_head *find_get_stripe(struct r5conf *conf,
> +		sector_t sector, short generation, int hash)
> +{

The subject doesn't match the change, maybe something about " md/raid5: 
factor out common stripe count
increment code into find_get_stripe()", just FYI. Otherwise, it 
generally looks good.

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>


Thanks,
Guoqing
