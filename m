Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECE44AD9FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiBHNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350440AbiBHNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:36:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C57C03FED0;
        Tue,  8 Feb 2022 05:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D8E3CE1A3E;
        Tue,  8 Feb 2022 13:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F36C340F3;
        Tue,  8 Feb 2022 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644327356;
        bh=u79a7xGuIOnAI0hmeTWqkoFHjcZXOZRDz+/R4oy2k1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mynva61oT3uZHMDFA069MvSDpcsyx1yMlXE/p+xa6vXqTHok4+/N7a/xNVtabTCFm
         In2iYnW4vzK/uESK3I9urNHZtMxi1fB9fkN2IQf4jAamEuLuzovvObTU+FDDg+9BTs
         s+qv+o6otTmMXtoMALrySTUxZXad4qLAAb6wOk9YCwCRtHkqQg7+WviieSIok1mneq
         SH3auuQApRKdyj6gH7VRcPUx3pUkHuOLQ/vnqX/jNGXFsCXQ4u8uTjmuqI03rYsrKZ
         AN8XP8Flm/7UjqWFefbbpP2ihy7dJvOKg+3rWDopxCX+nhVpYy8fWA4YmcgXU1ukT8
         uRh9tnDM5k9/A==
Received: by mail-wm1-f41.google.com with SMTP id v129so8644702wme.2;
        Tue, 08 Feb 2022 05:35:56 -0800 (PST)
X-Gm-Message-State: AOAM533RApj/RWWQhmah+WlKoQLAQcnWgW4vx5N7uFLZklkjcuqax0YA
        ZuoSqeS51eAlSo81K3b1TvIiXHHL0y9GDJCwZC4=
X-Google-Smtp-Source: ABdhPJwhL/oOOSs5ddtm4cjVywRdX/vv8D4K4D7Cs1AgelJH4RPgbhf1fkVoFXF1pKq0071dZJCgc6DVhHV7AxenYm4=
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr1204593wmq.106.1644327354967;
 Tue, 08 Feb 2022 05:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20220203083658.559803-1-arnd@kernel.org> <CAMj1kXG5W4nTXP5fXLmWhNfsQ_WigKbhdZz5yh1MNqE_VcD1TA@mail.gmail.com>
 <CAK8P3a1GeHV4Mj6rcnAY7y0351r-A7imsyWevKfE_qwHMz0D1g@mail.gmail.com>
In-Reply-To: <CAK8P3a1GeHV4Mj6rcnAY7y0351r-A7imsyWevKfE_qwHMz0D1g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 8 Feb 2022 14:35:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEB95mWGMNDC0LsOXm4o89tbAK83wF1ZBfK5jEozGw9ZA@mail.gmail.com>
Message-ID: <CAMj1kXEB95mWGMNDC0LsOXm4o89tbAK83wF1ZBfK5jEozGw9ZA@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: sa1100/assabet: move dmabounce hack to ohci driver
To:     Arnd Bergmann <arnd@kernel.org>
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

On Tue, 8 Feb 2022 at 13:49, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Feb 3, 2022 at 9:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 3 Feb 2022 at 09:38, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > > There are two main downsides:
> > >
> > >  - rather than using a dynamically sized pool, this buffer needs
> > >    to be allocated at probe time using a fixed size. Without
> > >    having any idea of what it should be, I picked a size of
> > >    64KB, which is between what the other two OHCI front-ends use
> > >    in their SRAM. If anyone has a better idea what that size
> > >    is reasonable, this can be trivially changed.
> > >
> >
> > I suppose this is a problem if the driver falls back to ordinary DRAM
> > once the allocation runs out?
>
> From what I can tell, there is no such fallback. If the localmem_pool
> runs out, the allocation fails, which may cause other problems, but
> it never falls back to the wrong DMA address.
>

OK that is the least bad outcome I suppose.

> > >  - Previously, only USB transfers to unaddressable memory needed
> > >    to go through the bounce buffer, now all of them do, which may
> > >    impact runtime performance for USB endpoints that do a lot of
> > >    transfers.
> > >
> > > On the upside, the local_mem support uses write-combining buffers,
> > > which should be a bit faster for transfers to the device compared to
> > > normal uncached coherent memory as used in dmabounce.
> > >
> >
> > Talking from past experience using this trick on a NXP ARM9 SoC ~10
> > years ago, using on-chip SRAM for USB DMA likely results in a
> > significant performance boost, even without write combining, although
> > the exact scenario obviously matters.
>
> Right, that makes sense, but it won't help here because there is
> no SRAM. One detail  I noticed is that the localmem pool normally
> gets mapped as WC, which is what I did in the new code as well, but
> dma_alloc_flags(..., DMA_ATTR_WRITE_COMBINE) does not always
> honor this flag. I think it will do it here because a GFP_KERNEL
> allocation should be served by the remap_allocator, while
> GFP_ATOMIC allocations would be served by pool_allocator_alloc(),
> which ignores the flag.
>

Ah yes, ignore me. For some reason, I thought this was about on-chip SRAM.
