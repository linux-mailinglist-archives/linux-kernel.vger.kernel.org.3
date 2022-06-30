Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A360560E91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiF3BHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiF3BHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7339680
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92EAF61F55
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9650AC34114;
        Thu, 30 Jun 2022 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656551219;
        bh=ADS86hmhn+G273gfWNc4aN140CYL60KTh6QbXWJGJvo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DavTASOoI9td7fwL7mHKPagtz5xyIlnQedTtDOaOvZ6ndzgqlwpx11PlN4c9HIIHS
         xNIV80kui868Wif0OVHp/10ajvogB/Jdeed2JymhxXSHb7EXGK1kqCLWLt65t6IYHV
         0XdUWVCaZSaAvoauiiMPJWJUotNp4Ne8Y2m2Mh2upGDQ5qHqcSsgT+jf/ZNyugLeOZ
         5+ovvrqmfV6JZI1xaHAUOZ4YGo7blBs3TUfNG3hg7yDr1fMiBX7SJFikGkNZpq6Do+
         c4sOsSMVcL5IZOKt1wYNIrlTA6N50dzEE6yipuBa91sxbm0riZJNH38Dv+J4n9Faxr
         z3hAb6Xw4oG9g==
Date:   Wed, 29 Jun 2022 18:06:57 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [PATCH V1 2/2] xen/grant-table: Use unpopulated contiguous pages
 instead of real RAM ones
In-Reply-To: <1655740136-3974-3-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206291756110.4389@ubuntu-linux-20-04-desktop>
References: <1655740136-3974-1-git-send-email-olekstysh@gmail.com> <1655740136-3974-3-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Depends on CONFIG_XEN_UNPOPULATED_ALLOC. If enabled then unpopulated
> contiguous pages will be allocated for grant mapping into instead of
> ballooning out real RAM pages.
> 
> Also fallback to allocate DMAable pages (balloon out real RAM pages)
> if we failed to allocate unpopulated contiguous pages. Use recently
> introduced is_xen_unpopulated_page() in gnttab_dma_free_pages() to know
> what API to use for freeing pages.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Please note, I haven't re-checked yet the use-case where the xen-swiotlb
> is involved (proposed by Stefano):
> https://lore.kernel.org/xen-devel/alpine.DEB.2.22.394.2206031348230.2783803@ubuntu-linux-20-04-desktop/
> I will re-check that for next version and add corresponding comment
> in the code.

Great. The patch looks good so far.


> Changes RFC -> V1:
>    - update commit subject/description
>    - rework to avoid introducing alternative implementation
>      of gnttab_dma_alloc(free)_pages(), use IS_ENABLED()
>    - implement a fallback to real RAM pages if we failed to allocate
>      unpopulated contiguous pages (resolve initial TODO)
>    - update according to the API renaming (s/dma/contiguous)
> ---
>  drivers/xen/grant-table.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 738029d..15e426b 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -1047,6 +1047,23 @@ int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
>  	size_t size;
>  	int i, ret;
>  
> +	if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC)) {
> +		ret = xen_alloc_unpopulated_contiguous_pages(args->dev, args->nr_pages,
> +				args->pages);
> +		if (ret < 0)
> +			goto fallback;
> +
> +		ret = gnttab_pages_set_private(args->nr_pages, args->pages);
> +		if (ret < 0)
> +			goto fail;
> +
> +		args->vaddr = page_to_virt(args->pages[0]);
> +		args->dev_bus_addr = page_to_phys(args->pages[0]);
> +
> +		return ret;
> +	}
> +
> +fallback:
>  	size = args->nr_pages << PAGE_SHIFT;
>  	if (args->coherent)
>  		args->vaddr = dma_alloc_coherent(args->dev, size,
> @@ -1103,6 +1120,13 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
>  
>  	gnttab_pages_clear_private(args->nr_pages, args->pages);
>  
> +	if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC) &&
> +			is_xen_unpopulated_page(args->pages[0])) {
> +		xen_free_unpopulated_contiguous_pages(args->dev, args->nr_pages,
> +				args->pages);
> +		return 0;
> +	}
> +
>  	for (i = 0; i < args->nr_pages; i++)
>  		args->frames[i] = page_to_xen_pfn(args->pages[i]);
>  
> -- 
> 2.7.4
> 
