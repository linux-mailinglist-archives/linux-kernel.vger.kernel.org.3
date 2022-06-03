Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFCF53D321
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbiFCVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFCVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693328713
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A0B61B04
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB51C385A9;
        Fri,  3 Jun 2022 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654291142;
        bh=d1Q9IPKvjPok8OAnN8PoPnUQadcNmLlAPGerCI7jOBM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=L65XZnLU73fFbHiQ3HoNW52hsUxf9wZWVQr+vBMiuBwt/iIssaNOSaeWuzM14O7L5
         NFgJ3Lv9JzFl3/SWM+DJ/tosGwEb5jDEFxwPcVc5x2414DnhuEuq8FzOG+bA29TtZV
         kugUY/cxExetrr3OfBTvmj5+kpt3LPhpaHqtpbwKReJtLaKpfd28cLFGOLaOeVm50R
         6FN8NVG8v3f+Z5CSQE/KsYTNI/iFsOv9Tnvj5muUWnepDJVbb30pjvA4TgGKBvWXJC
         1kLBk96A7GMGF6SMp37Xdwy5z+Kth8tEviWn/h3P3ozj+d2uyeGRYS0DWti4DZSYj9
         CcY7anQdJYB3A==
Date:   Fri, 3 Jun 2022 14:19:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 2/2] xen/grant-table: Use unpopulated DMAable pages
 instead of real RAM ones
In-Reply-To: <1652810658-27810-3-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206031348230.2783803@ubuntu-linux-20-04-desktop>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com> <1652810658-27810-3-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Depends on CONFIG_XEN_UNPOPULATED_ALLOC. If enabled then unpopulated
> DMAable (contiguous) pages will be allocated for grant mapping into
> instead of ballooning out real RAM pages.
> 
> TODO: Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages()
> fails.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  drivers/xen/grant-table.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 8ccccac..2bb4392 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -864,6 +864,25 @@ EXPORT_SYMBOL_GPL(gnttab_free_pages);
>   */
>  int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
>  {
> +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
> +	int ret;

This is an alternative implementation of the same function. If we are
going to use #ifdef, then I would #ifdef the entire function, rather
than just the body. Otherwise within the function body we can use
IS_ENABLED.


> +	ret = xen_alloc_unpopulated_dma_pages(args->dev, args->nr_pages,
> +			args->pages);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = gnttab_pages_set_private(args->nr_pages, args->pages);
> +	if (ret < 0) {
> +		gnttab_dma_free_pages(args);

it should xen_free_unpopulated_dma_pages ?


> +		return ret;
> +	}
> +
> +	args->vaddr = page_to_virt(args->pages[0]);
> +	args->dev_bus_addr = page_to_phys(args->pages[0]);

There are two things to note here. 

The first thing to note is that normally we would call pfn_to_bfn to
retrieve the dev_bus_addr of a page because pfn_to_bfn takes into
account foreign mappings. However, these are freshly allocated pages
without foreign mappings, so page_to_phys/dma should be sufficient.


The second has to do with physical addresses and DMA addresses. The
functions are called gnttab_dma_alloc_pages and
xen_alloc_unpopulated_dma_pages which make you think we are retrieving a
DMA address here. However, to get a DMA address we need to call
page_to_dma rather than page_to_phys.

page_to_dma takes into account special offsets that some devices have
when accessing memory. There are real cases on ARM where the physical
address != DMA address, e.g. RPi4.

However, to call page_to_dma you need to specify as first argument the
DMA-capable device that is expected to use those pages for DMA (e.g. an
ethernet device or a MMC controller.) While the args->dev we have in
gnttab_dma_alloc_pages is the gntdev_miscdev.

So this interface cannot actually be used to allocate memory that is
supposed to be DMA-able by a DMA-capable device, such as an ethernet
device.

But I think that should be fine because the memory is meant to be used
by a userspace PV backend for grant mappings. If any of those mappings
end up being used for actual DMA in the kernel they should go through the
drivers/xen/swiotlb-xen.c and xen_phys_to_dma should be called, which
ends up calling page_to_dma as appropriate.

It would be good to double-check that the above is correct and, if so,
maybe add a short in-code comment about it:

/*
 * These are not actually DMA addresses but regular physical addresses.
 * If these pages end up being used in a DMA operation then the
 * swiotlb-xen functions are called and xen_phys_to_dma takes care of
 * the address translations:
 *
 * - from gfn to bfn in case of foreign mappings
 * - from physical to DMA addresses in case the two are different for a
 *   given DMA-mastering device
 */



> +	return ret;
> +#else
>  	unsigned long pfn, start_pfn;
>  	size_t size;
>  	int i, ret;
> @@ -910,6 +929,7 @@ int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
>  fail:
>  	gnttab_dma_free_pages(args);
>  	return ret;
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
>  
> @@ -919,6 +939,12 @@ EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
>   */
>  int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
>  {
> +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
> +	gnttab_pages_clear_private(args->nr_pages, args->pages);
> +	xen_free_unpopulated_dma_pages(args->dev, args->nr_pages, args->pages);
> +
> +	return 0;
> +#else
>  	size_t size;
>  	int i, ret;
>  
> @@ -946,6 +972,7 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
>  		dma_free_wc(args->dev, size,
>  			    args->vaddr, args->dev_bus_addr);
>  	return ret;
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
>  #endif
> -- 
> 2.7.4
> 
