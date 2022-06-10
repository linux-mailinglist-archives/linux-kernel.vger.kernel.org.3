Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB0547063
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 02:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350650AbiFJXz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiFJXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16744A0D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4EB261E1D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53EBC34114;
        Fri, 10 Jun 2022 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654905353;
        bh=PlxS3We0GdjvIOX2k5kRle3oBLQPYE2copSxEUBjiCE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=e9MFev+ELzkkT08dn92q8sS/Kd47fC9pAvCBRCz9e26GbRXhrfwisf8908zziERxw
         KHcjGSXKKNVJ40jcxbxKerTv3ucB8IOGqtNlDHAosZ7pcWvFIHbNq1ekks8PIURuGz
         dt3k3JBCaehqBlEIqtkssdBmQnCJbL3I5cS0FHVxos+Q4t7kaNCdKgDdu+lQwFxOjI
         jaUjfLTme3PKgNddTPXufGtJcmq/ftmgTTf7UHGFNlSNYQrZoCzFKXM/ORyu9VrCke
         X8b/EJewUfytquvcmxaFxH3jyTVPsX8YZjKxym772t2SsAyD+wHiNCVX8OH9o8U0G4
         S8cEXBze6uuKA==
Date:   Fri, 10 Jun 2022 16:55:52 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 2/2] xen/grant-table: Use unpopulated DMAable pages
 instead of real RAM ones
In-Reply-To: <7f886dfb-2b42-bc70-d55f-14ecd8144e3e@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206101644210.756493@ubuntu-linux-20-04-desktop>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com> <1652810658-27810-3-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.22.394.2206031348230.2783803@ubuntu-linux-20-04-desktop> <7f886dfb-2b42-bc70-d55f-14ecd8144e3e@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1025708553-1654904664=:756493"
Content-ID: <alpine.DEB.2.22.394.2206101644500.756493@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1025708553-1654904664=:756493
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2206101644501.756493@ubuntu-linux-20-04-desktop>

On Thu, 9 Jun 2022, Oleksandr wrote:
> On 04.06.22 00:19, Stefano Stabellini wrote:
> Hello Stefano
> 
> Thank you for having a look and sorry for the late response.
> 
> > On Tue, 17 May 2022, Oleksandr Tyshchenko wrote:
> > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > 
> > > Depends on CONFIG_XEN_UNPOPULATED_ALLOC. If enabled then unpopulated
> > > DMAable (contiguous) pages will be allocated for grant mapping into
> > > instead of ballooning out real RAM pages.
> > > 
> > > TODO: Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages()
> > > fails.
> > > 
> > > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > ---
> > >   drivers/xen/grant-table.c | 27 +++++++++++++++++++++++++++
> > >   1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> > > index 8ccccac..2bb4392 100644
> > > --- a/drivers/xen/grant-table.c
> > > +++ b/drivers/xen/grant-table.c
> > > @@ -864,6 +864,25 @@ EXPORT_SYMBOL_GPL(gnttab_free_pages);
> > >    */
> > >   int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
> > >   {
> > > +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
> > > +	int ret;
> > This is an alternative implementation of the same function.
> 
> Currently, yes.
> 
> 
> >   If we are
> > going to use #ifdef, then I would #ifdef the entire function, rather
> > than just the body. Otherwise within the function body we can use
> > IS_ENABLED.
> 
> 
> Good point. Note, there is one missing thing in current patch which is
> described in TODO.
> 
> "Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages() fails."  So I
> will likely use IS_ENABLED within the function body.
> 
> If CONFIG_XEN_UNPOPULATED_ALLOC is enabled then gnttab_dma_alloc_pages() will
> try to call xen_alloc_unpopulated_dma_pages() the first and if fails then
> fallback to allocate RAM pages and balloon them out.
> 
> One moment is not entirely clear to me. If we use fallback in
> gnttab_dma_alloc_pages() then we must use fallback in gnttab_dma_free_pages()
> as well, we cannot use xen_free_unpopulated_dma_pages() for real RAM pages.
> The question is how to pass this information to the gnttab_dma_free_pages()?
> The first idea which comes to mind is to add a flag to struct
> gnttab_dma_alloc_args...
 
You can check if the page is within the mhp_range range or part of
iomem_resource? If not, you can free it as a normal page.

If we do this, then the fallback is better implemented in
unpopulated-alloc.c because that is the one that is aware about
page addresses.

 
 
> > > +	ret = xen_alloc_unpopulated_dma_pages(args->dev, args->nr_pages,
> > > +			args->pages);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = gnttab_pages_set_private(args->nr_pages, args->pages);
> > > +	if (ret < 0) {
> > > +		gnttab_dma_free_pages(args);
> > it should xen_free_unpopulated_dma_pages ?
> 
> Besides calling the xen_free_unpopulated_dma_pages(), we also need to call
> gnttab_pages_clear_private() here, this is what gnttab_dma_free_pages() is
> doing.
> 
> I can change to call both function instead:
> 
>     gnttab_pages_clear_private(args->nr_pages, args->pages);
>     xen_free_unpopulated_dma_pages(args->dev, args->nr_pages, args->pages);
> 
> Shall I?

No, leave it as is. I didn't realize that gnttab_pages_set_private can
fail half-way through.

 
> > 
> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	args->vaddr = page_to_virt(args->pages[0]);
> > > +	args->dev_bus_addr = page_to_phys(args->pages[0]);
> > There are two things to note here.
> > 
> > The first thing to note is that normally we would call pfn_to_bfn to
> > retrieve the dev_bus_addr of a page because pfn_to_bfn takes into
> > account foreign mappings. However, these are freshly allocated pages
> > without foreign mappings, so page_to_phys/dma should be sufficient.
> 
> agree
> 
> 
> > 
> > 
> > The second has to do with physical addresses and DMA addresses. The
> > functions are called gnttab_dma_alloc_pages and
> > xen_alloc_unpopulated_dma_pages which make you think we are retrieving a
> > DMA address here. However, to get a DMA address we need to call
> > page_to_dma rather than page_to_phys.
> > 
> > page_to_dma takes into account special offsets that some devices have
> > when accessing memory. There are real cases on ARM where the physical
> > address != DMA address, e.g. RPi4.
> 
> I got it. Now I am in doubt whether it would be better to name the API:
> 
> xen_alloc_unpopulated_cma_pages()
> 
> or
> 
> xen_alloc_unpopulated_contiguous_pages()
> 
> What do you think?

Yeah actually I think it is better to stay away from "dma" in the name.
I like xen_alloc_unpopulated_contiguous_pages().
 
 
> > However, to call page_to_dma you need to specify as first argument the
> > DMA-capable device that is expected to use those pages for DMA (e.g. an
> > ethernet device or a MMC controller.) While the args->dev we have in
> > gnttab_dma_alloc_pages is the gntdev_miscdev.
> 
> agree
> 
> As I understand, at this time it is unknown for what exactly device these
> pages are supposed to be used at the end.
> 
> For now, it is only known that these pages to be used by userspace PV backend
> for grant mappings.

Yeah
 

> > So this interface cannot actually be used to allocate memory that is
> > supposed to be DMA-able by a DMA-capable device, such as an ethernet
> > device.
> 
> agree
> 
> 
> > 
> > But I think that should be fine because the memory is meant to be used
> > by a userspace PV backend for grant mappings. If any of those mappings
> > end up being used for actual DMA in the kernel they should go through the
> > drivers/xen/swiotlb-xen.c and xen_phys_to_dma should be called, which
> > ends up calling page_to_dma as appropriate.
> > 
> > It would be good to double-check that the above is correct and, if so,
> > maybe add a short in-code comment about it:
> > 
> > /*
> >   * These are not actually DMA addresses but regular physical addresses.
> >   * If these pages end up being used in a DMA operation then the
> >   * swiotlb-xen functions are called and xen_phys_to_dma takes care of
> >   * the address translations:
> >   *
> >   * - from gfn to bfn in case of foreign mappings
> >   * - from physical to DMA addresses in case the two are different for a
> >   *   given DMA-mastering device
> >   */
> 
> I agree this needs to be re-checked. But, there is one moment here, if
> userspace PV backend runs in other than Dom0 domain (non 1:1 mapped domain),
> the xen-swiotlb seems not to be in use then? How to be in this case?
 
In that case, an IOMMU is required. If an IOMMU is setup correct, then
the gfn->bfn translation is not necessary because it is done
automatically by the IOMMU. That is because when the foreign page is
mapped in the domain, the mapping also applies to the IOMMU pagetable.

So the device is going to do DMA to "gfn" and the IOMMU will translate
it to the right "mfn", the one corresponding to "bfn".

The physical to DMA address should be done automatically by the default
(non-swiotlb_xen) dma_ops in Linux. E.g.
kernel/dma/direct.c:dma_direct_map_sg correctly calls
dma_direct_map_page, which calls phys_to_dma.
 
 
 
> > > +	return ret;
> > > +#else
> > >   	unsigned long pfn, start_pfn;
> > >   	size_t size;
> > >   	int i, ret;
> > > @@ -910,6 +929,7 @@ int gnttab_dma_alloc_pages(struct
> > > gnttab_dma_alloc_args *args)
> > >   fail:
> > >   	gnttab_dma_free_pages(args);
> > >   	return ret;
> > > +#endif
> > >   }
> > >   EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
> > >   @@ -919,6 +939,12 @@ EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
> > >    */
> > >   int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
> > >   {
> > > +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
> > > +	gnttab_pages_clear_private(args->nr_pages, args->pages);
> > > +	xen_free_unpopulated_dma_pages(args->dev, args->nr_pages,
> > > args->pages);
> > > +
> > > +	return 0;
> > > +#else
> > >   	size_t size;
> > >   	int i, ret;
> > >   @@ -946,6 +972,7 @@ int gnttab_dma_free_pages(struct
> > > gnttab_dma_alloc_args *args)
> > >   		dma_free_wc(args->dev, size,
> > >   			    args->vaddr, args->dev_bus_addr);
> > >   	return ret;
> > > +#endif
> > >   }
> > >   EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
> > >   #endif
> > > -- 
> > > 2.7.4
> > > 
--8323329-1025708553-1654904664=:756493--
