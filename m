Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D841A469A19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbhLFPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:05:37 -0500
Received: from foss.arm.com ([217.140.110.172]:59676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345449AbhLFPEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:04:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C093CED1;
        Mon,  6 Dec 2021 07:00:56 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B0D3F5A1;
        Mon,  6 Dec 2021 07:00:54 -0800 (PST)
Message-ID: <ddcdde8c-5118-048e-d5f8-6b8bc860947d@arm.com>
Date:   Mon, 6 Dec 2021 15:00:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH] provide per numa cma with an initial default size
Content-Language: en-GB
To:     Jay Chen <jkchen@linux.alibaba.com>, hch@lst.de,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     zhangliguang@linux.alibaba.com
References: <20211130074556.11091-1-jkchen@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211130074556.11091-1-jkchen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Barry ]

On 2021-11-30 07:45, Jay Chen wrote:
>    In the actual production environment, when we open
> cma and per numa cma, if we do not increase the per
> numa size configuration in cmdline, we find that our
> performance has dropped by 20%.
>    Through analysis, we found that the default size of
> per numa is 0, which causes the driver to allocate
> memory from cma, which affects performance. Therefore,
> we think we need to provide a default size.

Looking back at some of the review discussions, I think it may have been 
intentional that per-node areas are not allocated by default, since it's 
the kind of thing that really wants to be tuned to the particular system 
and workload, and as such it seemed reasonable to expect users to 
provide a value on the command line if they wanted the feature. That's 
certainly what the Kconfig text implies.

Thanks,
Robin.

> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> ---
>   kernel/dma/contiguous.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..3bef8bf371d9 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -99,7 +99,7 @@ early_param("cma", early_cma);
>   #ifdef CONFIG_DMA_PERNUMA_CMA
>   
>   static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> -static phys_addr_t pernuma_size_bytes __initdata;
> +static phys_addr_t pernuma_size_bytes __initdata = size_bytes;
>   
>   static int __init early_cma_pernuma(char *p)
>   {
> 
