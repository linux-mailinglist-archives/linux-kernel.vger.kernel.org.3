Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1F5554A48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiFVMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiFVMqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:46:30 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F0D326D7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:46:28 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 994612D0; Wed, 22 Jun 2022 14:46:26 +0200 (CEST)
Date:   Wed, 22 Jun 2022 14:46:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     yf.wang@mediatek.com
Cc:     Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com,
        Libo Kang <Libo.Kang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>, Ning Li <ning.li@mediatek.com>
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Message-ID: <YrMPG4dIEnFkCbi9@8bytes.org>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530120748.31733-1-yf.wang@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please re-send with

	Robin Murphy <robin.murphy@arm.com>

in Cc.

On Mon, May 30, 2022 at 08:07:45PM +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> When many devices share the same iova domain, iommu_dma_init_domain()
> may be called at the same time. The checking of iovad->start_pfn will
> all get false in iommu_dma_init_domain() and both enter init_iova_domain()
> to do iovad initialization.
> 
> Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.
> 
> Exception backtrace:
> rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
> init_iova_domain() + 180
> iommu_setup_dma_ops() + 260
> arch_setup_dma_ops() + 132
> of_dma_configure_id() + 468
> platform_dma_configure() + 32
> really_probe() + 1168
> driver_probe_device() + 268
> __device_attach_driver() + 524
> __device_attach() + 524
> bus_probe_device() + 64
> deferred_probe_work_func() + 260
> process_one_work() + 580
> worker_thread() + 1076
> kthread() + 332
> ret_from_fork() + 16
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/dma-iommu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..b38c5041eeab 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -63,6 +63,7 @@ struct iommu_dma_cookie {
>  
>  	/* Domain for flush queue callback; NULL if flush queue not in use */
>  	struct iommu_domain		*fq_domain;
> +	struct mutex			mutex;
>  };
>  
>  static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> @@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  	if (!domain->iova_cookie)
>  		return -ENOMEM;
>  
> +	mutex_init(&domain->iova_cookie->mutex);
>  	return 0;
>  }
>  
> @@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	}
>  
>  	/* start_pfn is always nonzero for an already-initialised domain */
> +	mutex_lock(&cookie->mutex);
>  	if (iovad->start_pfn) {
>  		if (1UL << order != iovad->granule ||
>  		    base_pfn != iovad->start_pfn) {
>  			pr_warn("Incompatible range for DMA domain\n");
> -			return -EFAULT;
> +			ret = -EFAULT;
> +			goto done_unlock;
>  		}
>  
> -		return 0;
> +		ret = 0;
> +		goto done_unlock;
>  	}
>  
>  	init_iova_domain(iovad, 1UL << order, base_pfn);
>  	ret = iova_domain_init_rcaches(iovad);
>  	if (ret)
> -		return ret;
> +		goto done_unlock;
>  
>  	/* If the FQ fails we can simply fall back to strict mode */
>  	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
>  		domain->type = IOMMU_DOMAIN_DMA;
>  
> -	return iova_reserve_iommu_regions(dev, domain);
> +	ret = iova_reserve_iommu_regions(dev, domain);
> +
> +done_unlock:
> +	mutex_unlock(&cookie->mutex);
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.18.0
