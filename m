Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7174AD979
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiBHNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbiBHMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:49:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B8C03FEC0;
        Tue,  8 Feb 2022 04:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1082B81AEE;
        Tue,  8 Feb 2022 12:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1CDC36AE2;
        Tue,  8 Feb 2022 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644324579;
        bh=0n1tSbHGXQRN3Sm9t1TdK+VKkpyIaGj7yXjkA1XeR8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PmxRX3fFyESQfmX1d9x5XYkCI0ms3ReygkYI8sae7khFo1L5ZcHnWyk/jQVUhSj+v
         Wr9i6RfOxlIT/uINBi5QvK7pfWqFdG1JysR1gGNA2RvANm6fr3jSurh/BEu7jS4Y7T
         9oIdXIX/IZROp8gU5eQ8LSIBlxvpwm/1th0xmuv5EhPBzihMFXJFYNmzf4uhhbv3Ts
         GfQQ4MDfx0/aEx/BfOCNdXyEgV9I/dLmplmi4bireCREAj4chK5/KXXOTxFhiJ86Go
         SNntGi4nqJjVFwq2VSjkd0npuuwy0vwe6zRKiVVpp17a+RU9fkLchm5vzMrWgX11Ha
         w8ETbGd+wJ+bQ==
Received: by mail-wr1-f52.google.com with SMTP id f17so30584630wrx.1;
        Tue, 08 Feb 2022 04:49:39 -0800 (PST)
X-Gm-Message-State: AOAM532dn12W0ZA1M/MduzW5niOsxdX3MOYMJ0fdMjpx7jPTaVQgrgFn
        vbywmggTHpBtYZog1o2U0iT+dVERI9ObnP+rJuU=
X-Google-Smtp-Source: ABdhPJzoyVBYULQ0Fua/eWADY0DsDt4BT5S47X2cvHGkFyMcI+N8rZKbjpqb0HaIxoaKlzO1YYPrVYc5d6FqX/xl8Uk=
X-Received: by 2002:a5d:568f:: with SMTP id f15mr306677wrv.407.1644324577741;
 Tue, 08 Feb 2022 04:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20220203083658.559803-1-arnd@kernel.org> <CAMj1kXG5W4nTXP5fXLmWhNfsQ_WigKbhdZz5yh1MNqE_VcD1TA@mail.gmail.com>
In-Reply-To: <CAMj1kXG5W4nTXP5fXLmWhNfsQ_WigKbhdZz5yh1MNqE_VcD1TA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 8 Feb 2022 13:49:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1GeHV4Mj6rcnAY7y0351r-A7imsyWevKfE_qwHMz0D1g@mail.gmail.com>
Message-ID: <CAK8P3a1GeHV4Mj6rcnAY7y0351r-A7imsyWevKfE_qwHMz0D1g@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: sa1100/assabet: move dmabounce hack to ohci driver
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Thu, Feb 3, 2022 at 9:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 3 Feb 2022 at 09:38, Arnd Bergmann <arnd@kernel.org> wrote:
>
> > There are two main downsides:
> >
> >  - rather than using a dynamically sized pool, this buffer needs
> >    to be allocated at probe time using a fixed size. Without
> >    having any idea of what it should be, I picked a size of
> >    64KB, which is between what the other two OHCI front-ends use
> >    in their SRAM. If anyone has a better idea what that size
> >    is reasonable, this can be trivially changed.
> >
>
> I suppose this is a problem if the driver falls back to ordinary DRAM
> once the allocation runs out?

From what I can tell, there is no such fallback. If the localmem_pool
runs out, the allocation fails, which may cause other problems, but
it never falls back to the wrong DMA address.

> >  - Previously, only USB transfers to unaddressable memory needed
> >    to go through the bounce buffer, now all of them do, which may
> >    impact runtime performance for USB endpoints that do a lot of
> >    transfers.
> >
> > On the upside, the local_mem support uses write-combining buffers,
> > which should be a bit faster for transfers to the device compared to
> > normal uncached coherent memory as used in dmabounce.
> >
>
> Talking from past experience using this trick on a NXP ARM9 SoC ~10
> years ago, using on-chip SRAM for USB DMA likely results in a
> significant performance boost, even without write combining, although
> the exact scenario obviously matters.

Right, that makes sense, but it won't help here because there is
no SRAM. One detail  I noticed is that the localmem pool normally
gets mapped as WC, which is what I did in the new code as well, but
dma_alloc_flags(..., DMA_ATTR_WRITE_COMBINE) does not always
honor this flag. I think it will do it here because a GFP_KERNEL
allocation should be served by the remap_allocator, while
GFP_ATOMIC allocations would be served by pool_allocator_alloc(),
which ignores the flag.

        Arnd
