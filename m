Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6F47D05C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbhLVKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:55:33 -0500
Received: from foss.arm.com ([217.140.110.172]:43632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244311AbhLVKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:55:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D481FB;
        Wed, 22 Dec 2021 02:55:32 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FAF13F5A1;
        Wed, 22 Dec 2021 02:55:31 -0800 (PST)
Message-ID: <bd8f7c86-983a-58fa-460c-7e361df66cec@arm.com>
Date:   Wed, 22 Dec 2021 10:55:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] Swiotlb: remove a duplicate include
Content-Language: en-GB
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     kernel@vivo.com
References: <20211222025416.3505-1-guozhengkui@vivo.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211222025416.3505-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-22 02:54, Guo Zhengkui wrote:
> Remove a duplicate "#include <linux/io.h>". The deleted one in line 43
> is under "#ifdef CONFIG_DMA_RESTRICTED_POOL". However, there is already
> one in line 53 with no conditional compile.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   kernel/dma/swiotlb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1b0501fd3e0e..8c091626ca35 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -33,21 +33,20 @@
>   #include <linux/ctype.h>
>   #include <linux/highmem.h>
>   #include <linux/gfp.h>
>   #include <linux/scatterlist.h>
>   #include <linux/cc_platform.h>
>   #include <linux/set_memory.h>
>   #ifdef CONFIG_DEBUG_FS
>   #include <linux/debugfs.h>
>   #endif
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
> -#include <linux/io.h>
>   #include <linux/of.h>
>   #include <linux/of_fdt.h>
>   #include <linux/of_reserved_mem.h>
>   #include <linux/slab.h>
>   #endif
>   
>   #include <asm/io.h>

By the same token we don't need this one either - as a general rule, 
linux/* headers can be assumed to include their asm/* equivalent, and 
that is certainly true for io.h.

>   #include <asm/dma.h>
>   
>   #include <linux/io.h>

TBH, now that I'm looking, the whole lot is a mess and I'm sure there's 
more legacy cruft that doesn't need to be here. If I remember, I might 
have a crack at a cleanup once rc1 is out.

Robin.
