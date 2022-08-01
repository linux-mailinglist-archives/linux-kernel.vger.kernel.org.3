Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C6586AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiHAM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiHAM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:27:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E82D7904D0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:07:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 326EC139F;
        Mon,  1 Aug 2022 05:07:18 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6162E3F73B;
        Mon,  1 Aug 2022 05:07:15 -0700 (PDT)
Message-ID: <19a0a508-fb39-8b06-ce0f-ce26767ef57f@arm.com>
Date:   Mon, 1 Aug 2022 13:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma-debug: Remove warning in dma_debug_entry
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
        Miles Chen <miles.chen@mediatek.com>
References: <20220730085657.31977-1-yf.wang@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220730085657.31977-1-yf.wang@mediatek.com>
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

On 2022-07-30 09:56, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> The same physical address can be mapped multiple times, and it is not
> required to have attributes such as DMA_ATTR_SKIP_CPU_SYNC, but
> dma_debug_entry will report an warning if active_cacheline_insert
> returns -EEXIST, which can cause a lot of trouble.
> 
> For example, if two dma engine share the same dma-buf, the two dma
> engine drivers will call the DMA API to map their own dma address
> respectively, which is normal follow, but dma_debug_entry will
> report an warning.
> 
> In addition, if active_cacheline_insert returns -EEXIST, the
> active_cacheline_inc_overlap function already has the logic to
> check overlapping mappings counter, if it exceeded
> ACTIVE_CACHELINE_MAX_OVERLAP overlapping mappings, it already
> has a warning.
> And also, if warning as panic is turned on, it will cause KE.
> 
> So, dma_debug_entry does not need report warning.

I'm sure this has come up before, but I can't remember enough of the 
context to easily search for the previous thread.

In short, this check is not entirely correct, but removing it isn't 
right either, since that would be too much of a step backwards in terms 
of debug coverage IMO. What we need here is to do a bit more work to 
differentiate between mappings of the exact same buffer, which are 
allowed, vs. any other kind of partial overlaps which are still illegal 
and definitely deserve a warning.

Furthermore, even for the valid dma-buf import case I'm not convinced 
that the SKIP_CPU_SYNC check can be dropped either. If one device can 
import a buffer while another device is already accessing it, there are 
definitely combinations of parameters which could lead to potential data 
loss (e.g. a non-coherent DMA_TO_DEVICE mapping during a non-coherent 
DMA_FROM_DEVICE access, a or non-coherent DMA_FROM_DEVICE mapping during 
a coherent DMA_TO_DEVICE access).

Thanks,
Robin.

> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   kernel/dma/debug.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 2caafd13f8aa..ad731f7858c9 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -566,9 +566,6 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>   	if (rc == -ENOMEM) {
>   		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
>   		global_disable = true;
> -	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> -		err_printk(entry->dev, entry,
> -			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
>   	}
>   }
>   
