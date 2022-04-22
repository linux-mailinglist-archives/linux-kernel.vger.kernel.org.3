Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842250C4D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiDVXZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiDVXYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5C1EE88C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10DFA614BB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81619C385A4;
        Fri, 22 Apr 2022 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650668394;
        bh=M7V1x3+dW0OrON/J4gjnWwch4NqKEpkTbtbZGq9n8Ds=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QohgQHLzztT0SIwKMxTyP1z4XMJ5yxThvDyiQXdXw5R9vEhb1vIQoOPFBA4vMDmp7
         OMXSxeoQZPdSRsYBxP6lNveMG6mN71h9ljeHiyhlpi/JE8n/ahpBv5rA297OdfD3m8
         HHK67H6zwN4EyeCZgH1FN5Uk5vizPpcotPFjYvEbbBSvYm6gGnkuABqm9TF1YeELcW
         dZxik/y3nacGdEG+7JlHx0QMJgfEE4t/k3UBooyvCEvN3vWl00th8B2WdhSt0OXQy3
         GaxYCztJOy1KwmrjIyLwOtFbI06hD3+pGKZrqMWLJyXHiH0diFy04HgYZUZFVIcB/p
         fhGy9MUJZMx3Q==
Date:   Fri, 22 Apr 2022 15:59:53 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Kees Cook <keescook@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V1 1/6] arm/xen: Introduce xen_setup_dma_ops()
In-Reply-To: <1650646263-22047-2-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204221509220.915916@ubuntu-linux-20-04-desktop>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com> <1650646263-22047-2-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> This patch introduces new helper and places it in new header.
> The helper's purpose is to assign any Xen specific DMA ops in
> a single place. For now, we deal with xen-swiotlb DMA ops only.
> The one of the subsequent commits in current series will add
> xen-grant DMA ops case.
> 
> Also re-use the xen_swiotlb_detect() check on Arm32.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes RFC -> V1:
>    - update commit description
>    - move commit to the beginning of the series
>    - move #ifdef CONFIG_XEN from dma-mapping.c to xen-ops.h
> ---
>  arch/arm/include/asm/xen/xen-ops.h   |  1 +
>  arch/arm/mm/dma-mapping.c            |  7 ++-----
>  arch/arm64/include/asm/xen/xen-ops.h |  1 +
>  arch/arm64/mm/dma-mapping.c          |  7 ++-----
>  include/xen/arm/xen-ops.h            | 15 +++++++++++++++
>  5 files changed, 21 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/include/asm/xen/xen-ops.h
>  create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
>  create mode 100644 include/xen/arm/xen-ops.h
> 
> diff --git a/arch/arm/include/asm/xen/xen-ops.h b/arch/arm/include/asm/xen/xen-ops.h
> new file mode 100644
> index 00000000..8d2fa24
> --- /dev/null
> +++ b/arch/arm/include/asm/xen/xen-ops.h
> @@ -0,0 +1 @@
> +#include <xen/arm/xen-ops.h>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 82ffac6..059cce0 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -33,7 +33,7 @@
>  #include <asm/dma-iommu.h>
>  #include <asm/mach/map.h>
>  #include <asm/system_info.h>
> -#include <xen/swiotlb-xen.h>
> +#include <asm/xen/xen-ops.h>
>  
>  #include "dma.h"
>  #include "mm.h"
> @@ -2287,10 +2287,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  	set_dma_ops(dev, dma_ops);
>  
> -#ifdef CONFIG_XEN
> -	if (xen_initial_domain())
> -		dev->dma_ops = &xen_swiotlb_dma_ops;
> -#endif
> +	xen_setup_dma_ops(dev);
>  	dev->archdata.dma_ops_setup = true;
>  }
>  
> diff --git a/arch/arm64/include/asm/xen/xen-ops.h b/arch/arm64/include/asm/xen/xen-ops.h
> new file mode 100644
> index 00000000..8d2fa24
> --- /dev/null
> +++ b/arch/arm64/include/asm/xen/xen-ops.h
> @@ -0,0 +1 @@
> +#include <xen/arm/xen-ops.h>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 6719f9e..6099c81 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -9,9 +9,9 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dma-iommu.h>
>  #include <xen/xen.h>
> -#include <xen/swiotlb-xen.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/xen/xen-ops.h>
>  
>  void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  		enum dma_data_direction dir)
> @@ -52,8 +52,5 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	if (iommu)
>  		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
>  
> -#ifdef CONFIG_XEN
> -	if (xen_swiotlb_detect())
> -		dev->dma_ops = &xen_swiotlb_dma_ops;
> -#endif
> +	xen_setup_dma_ops(dev);
>  }
> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
> new file mode 100644
> index 00000000..288deb1
> --- /dev/null
> +++ b/include/xen/arm/xen-ops.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM_XEN_OPS_H
> +#define _ASM_ARM_XEN_OPS_H
> +
> +#include <xen/swiotlb-xen.h>
> +
> +static inline void xen_setup_dma_ops(struct device *dev)
> +{
> +#ifdef CONFIG_XEN
> +	if (xen_swiotlb_detect())
> +		dev->dma_ops = &xen_swiotlb_dma_ops;
> +#endif
> +}
> +
> +#endif /* _ASM_ARM_XEN_OPS_H */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
