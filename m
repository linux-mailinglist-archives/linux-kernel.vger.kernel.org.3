Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE764FE2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351854AbiDLNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiDLNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:35:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E072E12AF9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:33:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9264A150C;
        Tue, 12 Apr 2022 06:33:10 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8BD3F70D;
        Tue, 12 Apr 2022 06:33:09 -0700 (PDT)
Message-ID: <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
Date:   Tue, 12 Apr 2022 14:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Content-Language: en-GB
To:     Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     m.szyprowski@samsung.com, hch@lst.de,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <20220412113805.3210-1-chao.gao@intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220412113805.3210-1-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:38 pm, Chao Gao wrote:
> When we looked into FIO performance with swiotlb enabled in VM, we found
> swiotlb_bounce() is always called one more time than expected for each DMA
> read request.
> 
> It turns out that the bounce buffer is copied to original DMA buffer twice
> after the completion of a DMA request (one is done by in
> dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
> But the content in bounce buffer actually doesn't change between the two
> rounds of copy. So, one round of copy is redundant.
> 
> Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
> skip the memory copy in it.

It's still a little suboptimal and non-obvious to call into SWIOTLB 
twice though - even better might be for SWIOTLB to call 
arch_sync_dma_for_cpu() at the appropriate place internally, then put 
the dma_direct_sync in an else path here. I'm really not sure why we 
have the current disparity between map and unmap in this regard... :/

Robin.

> This fix increases FIO 64KB sequential read throughput in a guest with
> swiotlb=force by 5.6%.
> 
> Reported-by: Wang Zhaoyang1 <zhaoyang1.wang@intel.com>
> Reported-by: Gao Liang <liang.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   kernel/dma/direct.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 4632b0f4f72e..8a6cd53dbe8c 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -114,6 +114,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
>   		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
>   
>   	if (unlikely(is_swiotlb_buffer(dev, phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(dev, phys, size, dir,
> +					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
>   }
>   #endif /* _KERNEL_DMA_DIRECT_H */
