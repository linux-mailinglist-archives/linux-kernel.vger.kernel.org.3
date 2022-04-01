Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AF4EE8AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiDAG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbiDAG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59191C6816
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E782D60EFD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57182C340F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648796184;
        bh=tmzuiXwE0YoCVxocrcXOwxCPWalAk7sv3NhfTwDfAgc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n8UTUSdZ4B/Q5FObugZadVAKu4c7uwaJ7PQ5ME6SVhV1p8qjrtO3cdRUaa0SzRXi9
         63eU1efNrY57i9elJVMaMHvOEZe55atW0uMc0PKq5/IMKRToWNXoBabCnUPUlZSoEm
         o1W2ar/aUXHLkDDSJ7n1SnMkEbeJmncVD4ifp+yxD9WO7M9OAVl9ATzwcTdoD/CmQ5
         Yhsh5qFatwvtxB4xolwILzSH2tbtVu/7gx6d4FFkZcoiwKtrU7+1aT4YzJ7tjBxIB8
         d+DOmeFjCta2dEisvRcuCilGQevNIH/sMtnyiJjOQaac8316QjgIqwbE0g5pud4oA6
         /l4ZnpNa0/zFA==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2e68c95e0f9so23244357b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:56:24 -0700 (PDT)
X-Gm-Message-State: AOAM53314nSXajxRg4KGdZ5AdoLNXvdNuhO8POXuMaEJ9zH+ALl7uwFV
        wEwaqerVCUlmJrVOPc8rDC9Pb7wNS3IgiZHj398=
X-Google-Smtp-Source: ABdhPJzK/b7Hju7SnqNeAG1y6dWgvMDJnuOCRMrTT1avoROj7gRMnyg8XnjNT7Bzuak+k/h59U+jR6DgKmc+7b35F84=
X-Received: by 2002:a81:79cc:0:b0:2e9:d3bd:b4e8 with SMTP id
 u195-20020a8179cc000000b002e9d3bdb4e8mr8798314ywc.93.1648796183378; Thu, 31
 Mar 2022 23:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220401041615.3296387-1-jcmvbkbc@gmail.com> <CAK8P3a19-qtAg8GD8a9nG4ZPuyoDi3n39+zvHcRV-YdPJbJfKA@mail.gmail.com>
In-Reply-To: <CAK8P3a19-qtAg8GD8a9nG4ZPuyoDi3n39+zvHcRV-YdPJbJfKA@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Fri, 1 Apr 2022 09:55:56 +0300
X-Gmail-Original-Message-ID: <CAFCwf10hm4+WOa9JTNLTnEGtOGScOVu+PAXbk2=r+14u8d68VA@mail.gmail.com>
Message-ID: <CAFCwf10hm4+WOa9JTNLTnEGtOGScOVu+PAXbk2=r+14u8d68VA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix build warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Ohad Sharabi <osharabi@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Apr 1, 2022 at 6:16 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > allmodconfig build fails on ARCH=xtensa with the following message:
> >
> >   drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer
> >         to integer of different size [-Werror=pointer-to-int-cast]
> >         (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> >
> > Fix it by adding intermediate conversion to uintptr_t as in other places
> > in that driver.
> >
> > Fixes: e8458e20e0a3 ("habanalabs: make sure device mem alloc is page aligned")
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  drivers/misc/habanalabs/common/memory.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> > index e008d82e4ba3..f0d373171d2a 100644
> > --- a/drivers/misc/habanalabs/common/memory.c
> > +++ b/drivers/misc/habanalabs/common/memory.c
> > @@ -150,9 +150,9 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >                 for (i = 0 ; i < num_pgs ; i++) {
> >                         if (is_power_of_2(page_size))
> >                                 phys_pg_pack->pages[i] =
> > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > -                                                                               page_size, NULL,
> > -                                                                               page_size);
> > +                                       (u64)(uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
> > +                                                                                page_size, NULL,
> > +                                                                                page_size);
> >                         else
> >                                 phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
> >                                                                                 page_size);
>
> This addresses the warning, but I suspect there is still a problem in the code:
> The description of that member lists it as '@pages: the physical page array',
> but it is actually a kernel virtual address that gets passed to it. Since this
> is a 'u64' member, it is hard to tell what type it actually is.
>
> gen_pool_dma_alloc_align() returns both a virtual address and a dma (bus)
> address. The dma address is ignored here, which makes me wonder why
> this interface is used in the first place.
>
> I can see four possible things that may be going on here:
>
> - if the pages[] array is meant to be a kernel virtual address, it should be
>   changed from a 'u64' to a normal pointer, with the cast removed.
>
> - if the pages[] array is meant to be a physical address, as documented,
>   it should be assigned using virt_to_phys() on the pointer, with a warning
>   that this must not be used a as a dma address (which can easily get
>   confused with a phys address as the binary representation is often the
>   same in the absence of an iommu). In this case, it should also be
>   changed to a phys_addr_t.
>
> - if the pages[] array is meant to be a dma address, it should be changed
>   to a dma_addr_t, and passed as the third argument to
>   gen_pool_dma_alloc_align() in order to return the correct address.
>
> - if there is a 'u64' member that is used for two (or all three) of the above
>   depending on context, it should be replaced with either multiple
>   struct members or a union.
>
> Looking at other uses of the pages[] array, I see a dma_addr_t assigned
> to it in init_phys_pg_pack_from_userptr(), but map_phys_pg_pack() and
> alloc_sgt_from_device_pages appear to treat it as a cpu-physical phys_addr_t
> rather than a device address again.
>
>         Arnd

Hi,
We use gen_pool in this function to manage our device memory
allocations (this is why it is called alloc_device_memory).

Basically, we initialize the genpool with the total size of the device memory,
and each bit represents a page according to a fixed page size, which
is dependent on asic type.
The addresses represent the physical address of the device memory, as
our device sees them.
As these addresses are not accessible from the host, it is appropriate
to hold them in u64, imo.

For future asics which will support multiple page sizes, we need to
use the gen_pool_dma_alloc_align() variant,
because then we need the allocation to be aligned to the page size as
requested by the user per allocation.

We ignore the DMA address because this is device memory, not host memory.
Therefore, our device's dma engine addresses the memory using the
virtual memory addresses we assign to it in our device's MMU.

Having said that, I'm wondering whether gen_pool_first_fit_align() can
also work here, which might be less confusing.

Oded
