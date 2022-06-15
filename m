Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2054BEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiFOAvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiFOAvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:51:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ADA4C424
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7076194A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE10C3411B;
        Wed, 15 Jun 2022 00:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655254298;
        bh=zYDarweJh7/bEePUo2Am4AELnMD53gnyz/vvlfofoc4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=b/rQn2i+978Z0a7/w74jSGbY8T1i2C6Orf0JFjyIxM8/0K7vIwcdhH1Ef6LHy+XWB
         gsvmy26fC+vMxf2xCY7i7k2Jdlr/3IlyIChS5S2gr7Tt9N3pN3q1sHdnYLau+dnRfu
         p0PnxLdsko2QUrKXMw0kPGHdVc2E8w3t66GNW9U+/vfBmNpOZAAQFovCNsFQ6VOfnW
         jV1toIBMy/jSB0PRPahqNwZA1fBpoHLDiPM9VuUuNy608w9ysYBvc1Uiae5KM1IeRE
         KLkPM1X7SkXz0NSNxd/ZbUYPXCiwi/WoiQdM1tkEuwg9yi75a9jz5OamH1K3Axhw4X
         1/Ip6QaTaaq1Q==
Date:   Tue, 14 Jun 2022 17:51:37 -0700 (PDT)
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
In-Reply-To: <1266f8cb-bbd6-d952-3108-89665ce76fec@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206141748150.1837490@ubuntu-linux-20-04-desktop>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com> <1652810658-27810-3-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.22.394.2206031348230.2783803@ubuntu-linux-20-04-desktop> <7f886dfb-2b42-bc70-d55f-14ecd8144e3e@gmail.com>
 <alpine.DEB.2.22.394.2206101644210.756493@ubuntu-linux-20-04-desktop> <1266f8cb-bbd6-d952-3108-89665ce76fec@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1366514938-1655254298=:1837490"
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

--8323329-1366514938-1655254298=:1837490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Jun 2022, Oleksandr wrote:
> On 11.06.22 02:55, Stefano Stabellini wrote:
> 
> Hello Stefano
> 
> > On Thu, 9 Jun 2022, Oleksandr wrote:
> > > On 04.06.22 00:19, Stefano Stabellini wrote:
> > > Hello Stefano
> > > 
> > > Thank you for having a look and sorry for the late response.
> > > 
> > > > On Tue, 17 May 2022, Oleksandr Tyshchenko wrote:
> > > > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > > > 
> > > > > Depends on CONFIG_XEN_UNPOPULATED_ALLOC. If enabled then unpopulated
> > > > > DMAable (contiguous) pages will be allocated for grant mapping into
> > > > > instead of ballooning out real RAM pages.
> > > > > 
> > > > > TODO: Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages()
> > > > > fails.
> > > > > 
> > > > > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > > > ---
> > > > >    drivers/xen/grant-table.c | 27 +++++++++++++++++++++++++++
> > > > >    1 file changed, 27 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> > > > > index 8ccccac..2bb4392 100644
> > > > > --- a/drivers/xen/grant-table.c
> > > > > +++ b/drivers/xen/grant-table.c
> > > > > @@ -864,6 +864,25 @@ EXPORT_SYMBOL_GPL(gnttab_free_pages);
> > > > >     */
> > > > >    int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
> > > > >    {
> > > > > +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
> > > > > +	int ret;
> > > > This is an alternative implementation of the same function.
> > > Currently, yes.
> > > 
> > > 
> > > >    If we are
> > > > going to use #ifdef, then I would #ifdef the entire function, rather
> > > > than just the body. Otherwise within the function body we can use
> > > > IS_ENABLED.
> > > 
> > > Good point. Note, there is one missing thing in current patch which is
> > > described in TODO.
> > > 
> > > "Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages() fails." 
> > > So I
> > > will likely use IS_ENABLED within the function body.
> > > 
> > > If CONFIG_XEN_UNPOPULATED_ALLOC is enabled then gnttab_dma_alloc_pages()
> > > will
> > > try to call xen_alloc_unpopulated_dma_pages() the first and if fails then
> > > fallback to allocate RAM pages and balloon them out.
> > > 
> > > One moment is not entirely clear to me. If we use fallback in
> > > gnttab_dma_alloc_pages() then we must use fallback in
> > > gnttab_dma_free_pages()
> > > as well, we cannot use xen_free_unpopulated_dma_pages() for real RAM
> > > pages.
> > > The question is how to pass this information to the
> > > gnttab_dma_free_pages()?
> > > The first idea which comes to mind is to add a flag to struct
> > > gnttab_dma_alloc_args...
> >   You can check if the page is within the mhp_range range or part of
> > iomem_resource? If not, you can free it as a normal page.
> > 
> > If we do this, then the fallback is better implemented in
> > unpopulated-alloc.c because that is the one that is aware about
> > page addresses.
> 
> 
> I got your idea and agree this can work technically. Or if we finally decide
> to use the second option (use "dma_pool" for all) in the first patch
> "[RFC PATCH 1/2] xen/unpopulated-alloc: Introduce helpers for DMA allocations"
> then we will likely be able to check whether a page in question
> is within a "dma_pool" using gen_pool_has_addr().
> 
> I am still wondering, can we avoid the fallback implementation in
> unpopulated-alloc.c.
> Because for that purpose we will need to pull more code into
> unpopulated-alloc.c (to be more precise, almost everything which
> gnttab_dma_free_pages() already has except gnttab_pages_clear_private()) and
> pass more arguments to xen_free_unpopulated_dma_pages(). Also I might mistake,
> but having a fallback split between grant-table.c (to allocate RAM pages in
> gnttab_dma_alloc_pages()) and unpopulated-alloc.c (to free RAM pages in
> xen_free_unpopulated_dma_pages()) would look a bit weird.
> 
> I see two possible options for the fallback implementation in grant-table.c:
> 1. (less preferable) by introducing new flag in struct gnttab_dma_alloc_args
> 2. (more preferable) by guessing unpopulated (non real RAM) page using
> is_zone_device_page(), etc
> 
> 
> For example, with the second option the resulting code will look quite simple
> (only build tested):
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 738029d..3bda71f 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -1047,6 +1047,23 @@ int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args
> *args)
>         size_t size;
>         int i, ret;
> 
> +       if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC)) {
> +               ret = xen_alloc_unpopulated_dma_pages(args->dev,
> args->nr_pages,
> +                               args->pages);
> +               if (ret < 0)
> +                       goto fallback;
> +
> +               ret = gnttab_pages_set_private(args->nr_pages, args->pages);
> +               if (ret < 0)
> +                       goto fail;
> +
> +               args->vaddr = page_to_virt(args->pages[0]);
> +               args->dev_bus_addr = page_to_phys(args->pages[0]);
> +
> +               return ret;
> +       }
> +
> +fallback:
>         size = args->nr_pages << PAGE_SHIFT;
>         if (args->coherent)
>                 args->vaddr = dma_alloc_coherent(args->dev, size,
> @@ -1103,6 +1120,12 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args
> *args)
> 
>         gnttab_pages_clear_private(args->nr_pages, args->pages);
> 
> +       if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC) &&
> +                       is_zone_device_page(args->pages[0])) {
> +               xen_free_unpopulated_dma_pages(args->dev, args->nr_pages,
> args->pages);
> +               return 0;
> +       }
> +
>         for (i = 0; i < args->nr_pages; i++)
>                 args->frames[i] = page_to_xen_pfn(args->pages[i]);
> 
> 
> What do you think?
 
I have another idea. Why don't we introduce a function implemented in
drivers/xen/unpopulated-alloc.c called is_xen_unpopulated_page() and
call it from here? is_xen_unpopulated_page can be implemented by using
gen_pool_has_addr.
--8323329-1366514938-1655254298=:1837490--
