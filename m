Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7414C671F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiB1Kdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiB1Kdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:33:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40858329A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:33:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D76521063;
        Mon, 28 Feb 2022 02:33:00 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEC333F70D;
        Mon, 28 Feb 2022 02:32:59 -0800 (PST)
Message-ID: <4802e9fd-733f-3246-92f3-05f590e05d37@arm.com>
Date:   Mon, 28 Feb 2022 10:32:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dma-mapping: remove CONFIG_DMA_REMAP
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220227143533.357356-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220227143533.357356-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-27 14:35, Christoph Hellwig wrote:
> CONFIG_DMA_REMAP is used to build a few helpers around the core
> vmalloc code, and to use them in case there is a highmem page in
> dma-direct, and to make dma coherent allocations be able to use
> non-contiguous pages allocations for DMA allocations in the dma-iommu
> layer.
> 
> Right now it needs to be explicitly selected by architectures, and
> is only done so by architectures that require remapping to deal
> with devices that are not DMA coherent.  Make it unconditional for
> builds with CONFIG_MMU as it is very little extra code, but makes
> it much more likely that large DMA allocations succeed on x86.
> 
> This fixes hot plugging a NVMe thunderbolt SSD for me, which tries
> to allocate a 1MB buffer that is otherwise hard to obtain due to
> memory fragmentation on a heavily used laptop.

Simplifying the maze is most welcome, however one thing stands out...

[...]
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50f48e9e45987..fe1682fecdd57 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -269,10 +269,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		/*
>   		 * Depending on the cma= arguments and per-arch setup,
>   		 * dma_alloc_contiguous could return highmem pages.
> -		 * Without remapping there is no way to return them here, so
> -		 * log an error and fail.
> +		 * Without MMU-based remapping there is no way to return them
> +		 * here, so log an error and fail.
>   		 */
> -		if (!IS_ENABLED(CONFIG_DMA_REMAP)) {
> +		if (!IS_ENABLED(CONFIG_MMU)) {
>   			dev_info(dev, "Rejecting highmem page from CMA.\n");
>   			goto out_free_pages;
>   		}

Is it even possible to hit this case now? From a quick look, all the 
architectures defining HIGHMEM either have an explicit dependency on MMU 
or don't allow deselecting it anyway (plus I don't see how HIGHMEM && 
!MMU could work in general), so I'm pretty sure this whole chunk should 
go away now.

With that (or if there *is* some subtle wacky case where PageHighmem() 
can actually return true for !MMU, a comment to remind us in future),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.
