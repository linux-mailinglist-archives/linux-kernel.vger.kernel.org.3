Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770FD4FE2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355928AbiDLN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356237AbiDLN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:26:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A29F43
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649769713; x=1681305713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K10aPqsXZD4QBwO3VmQYeC0CYp3r9bJXTTZCH/ubYRg=;
  b=B1RHb143ANeQEW8AObmztQGfvAhg+lIfSa3Y3JYaXsrElRAmw+n3Hwo4
   R0Z7e5X3ZF6dS+NU5IZTds+pUikledlddWAlRxMmoJqru9VrdtNt8bYYx
   Pn15c4sXH9vOhtJS6cFphkegD8RpfyFW5jzqLc+K9OMdaGf53aAinamjo
   QMxfpZS/cRu6GQvMn3I4mVAf4P3zar0VvwUniJLnZ3eYt0uq1T8EPVInO
   dUTMrTT2OECejZ1oXGv2CTl9bXC5T9Zu6AiuyDrG/r//vw5CLbHlPVZoa
   N5CDEZywGDiU+zuuchOzTHZXcl39GYs+aRU3fc4sp+WMsLWF0xPjpgSfU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261220817"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261220817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:21:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="551708376"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:21:41 -0700
Date:   Tue, 12 Apr 2022 21:21:37 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220412132132.GA18002@gao-cwp>
References: <20220412113805.3210-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412113805.3210-1-chao.gao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 07:38:05PM +0800, Chao Gao wrote:
>When we looked into FIO performance with swiotlb enabled in VM, we found
>swiotlb_bounce() is always called one more time than expected for each DMA
>read request.
>
>It turns out that the bounce buffer is copied to original DMA buffer twice
>after the completion of a DMA request (one is done by in
>dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
>But the content in bounce buffer actually doesn't change between the two
>rounds of copy. So, one round of copy is redundant.
>
>Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
>skip the memory copy in it.
>
>This fix increases FIO 64KB sequential read throughput in a guest with
>swiotlb=force by 5.6%.
>

Sorry. A fixes tag is missing:

Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")

>Reported-by: Wang Zhaoyang1 <zhaoyang1.wang@intel.com>
>Reported-by: Gao Liang <liang.gao@intel.com>
>Signed-off-by: Chao Gao <chao.gao@intel.com>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>---
> kernel/dma/direct.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>index 4632b0f4f72e..8a6cd53dbe8c 100644
>--- a/kernel/dma/direct.h
>+++ b/kernel/dma/direct.h
>@@ -114,6 +114,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
> 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> 
> 	if (unlikely(is_swiotlb_buffer(dev, phys)))
>-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
>+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
> }
> #endif /* _KERNEL_DMA_DIRECT_H */
>-- 
>2.25.1
>
