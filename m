Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5B58707B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiHASsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiHASsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:48:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AE8522BC5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:48:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE8F139F;
        Mon,  1 Aug 2022 11:48:01 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EFDF3F67D;
        Mon,  1 Aug 2022 11:47:58 -0700 (PDT)
Message-ID: <15735fab-e53d-e95d-84f8-ae2e435dbb78@arm.com>
Date:   Mon, 1 Aug 2022 19:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma-debug: Fix overflow issue in bucket_find_contain
Content-Language: en-GB
To:     yf.wang@mediatek.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>
References: <20220730114146.32669-1-yf.wang@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220730114146.32669-1-yf.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-30 12:41, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> There are two issue:
> 1. If max_rang is set to 0xFFFF_FFFF, and __hash_bucket_find always
> returns NULL, the rang will be accumulated. When rang is accumulated
> to 0xFFFF_E000, after executing rang += (1 << HASH_FN_SHIFT) again,
> rang will overflow to 0, making it impossible to exit the while loop.
> 2. dev_addr reduce maybe overflow.
> 
> So, add range and dev_addr check to avoid overflow.
> 
> Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   kernel/dma/debug.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index ad731f7858c9..9d7d54cd4c63 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -352,6 +352,7 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
>   
>   	unsigned int max_range = dma_get_max_seg_size(ref->dev);
>   	struct dma_debug_entry *entry, index = *ref;
> +	unsigned int shift = (1 << HASH_FN_SHIFT);
>   	unsigned int range = 0;
>   
>   	while (range <= max_range) {
> @@ -360,12 +361,15 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
>   		if (entry)
>   			return entry;
>   
> +		if (max_range - range < shift || index.dev_addr < shift)
> +			return NULL;

This seems a bit clunky since the first condition here effectively makes 
the loop condition redundant.

FWIW I found the whole "range" business here rather hard to make sense 
of - personally I'd calculate a lower bound for the address then just 
iterate down to that, but maybe that's just me :/

Otherwise, at the very least we should be capping max_range so that the 
loop doesn't go beyond HASH_SIZE iterations and pointlessly search the 
same buckets more than once - it's stupid to even *get* to the point of 
having to worry about that overflowing. Whether we really care about 
dev_addr underflow is then another matter.

Really it would seem even more logical to make this a lower-level 
function that can walk round the dma_entry_hash array directly and not 
have to monkey about with the fake "index" entry at all, but cleaning up 
the almost-unnecessary amount of internal abstractions here is maybe 
more work than it's worth at this point.

Robin.

> +
>   		/*
>   		 * Nothing found, go back a hash bucket
>   		 */
>   		put_hash_bucket(*bucket, *flags);
> -		range          += (1 << HASH_FN_SHIFT);
> -		index.dev_addr -= (1 << HASH_FN_SHIFT);
> +		range          += shift;
> +		index.dev_addr -= shift;
>   		*bucket = get_hash_bucket(&index, flags);
>   	}
>   
