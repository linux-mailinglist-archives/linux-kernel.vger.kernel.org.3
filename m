Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E8514FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378612AbiD2Ptj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378354AbiD2Pth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:49:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCB32ECD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:46:18 -0700 (PDT)
Received: from mail-yw1-f172.google.com ([209.85.128.172]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmU9X-1oBJKT1XTV-00iS2A for <linux-kernel@vger.kernel.org>; Fri, 29 Apr
 2022 17:46:16 +0200
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ef5380669cso89417707b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:46:16 -0700 (PDT)
X-Gm-Message-State: AOAM532HMFt0cI5sNsSlWayJt0EB4KYWC7j3rQb7WUzoc5VQe3nYY3D0
        VCM409XEiY5Jcn0UKbSPn9vosWpGSt50OIUqRqA=
X-Google-Smtp-Source: ABdhPJwpKyKGUbMUzkhYnAbzU29MGVvXsy0RQK647z1D8VTgv9LJsKjehZWfHRDu++cxCmOKgozqOtceX6x4X0izK8M=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr38964620ywd.495.1651247175153; Fri, 29
 Apr 2022 08:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220324175417.1014562-1-f.fainelli@gmail.com>
 <20220324175417.1014562-2-f.fainelli@gmail.com> <YmwBGh5mvuNIgyRY@shell.armlinux.org.uk>
In-Reply-To: <YmwBGh5mvuNIgyRY@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Apr 2022 17:45:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1WrZ0eoi7sJ_7UDMAjUG4VVah48RTdTjC1cPBqFuhy6w@mail.gmail.com>
Message-ID: <CAK8P3a1WrZ0eoi7sJ_7UDMAjUG4VVah48RTdTjC1cPBqFuhy6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Fix off by one in checking DMA zone size
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6NXeUzsmd0HpS9LFz8B9TJkreXqPNGJ18MC3amRzENBpvhIVS7P
 /wrjkVYABTUAEGtbLUMfw0mxn6bjip6jyVv6DbagznXLsGQ2Jn4+nc41RmmorsH6d3q7ROd
 iNxMuljGAnLvNR5qYxvzUw4VSkg+GpaAW75MzcPsQCFBdY3EsHfDPeFhC8/8IWqlBfR0KqM
 M2LVwOH6gpotaSIBWjxLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LY8j+5RFols=:EFFXo4iSC2ahK87owN+eAi
 FlMMaeMprofvdA7ZBDV2NXjak36wWe5O33GNocA1qszKG6RgtMBBAj/lG5JRu8YoC1CldlEox
 kv0G3cNdLDTgewWJX55TB+Wg+uH2A1F7JokrYLyxy3Z3ZxUxQCH2zsgMn/mGizrhDo1gmZ70j
 sZtNJcVu9s9HCm5FaA+2sw+EstQIoGTaRvnkyE41+vSSwsMVMJM7M3eUHl/Mo6mYYM+0sPBqF
 vRAZ2SoB31VUUjJuFh6HjFj8NlPtE6uHXC2PS3hR6zkj1sH2DsjuP+5PbeVO0X7u8s6XdYH00
 jQuzYu8QfTFAmh5Om/IA+QO/2CGdkUkirgdloGzhMCN74s6XvWjmBzegNYMnPNet4KDrKQO0n
 cb1q7lknesJtj5db7LpUr3wviYD0FAKY7B5YKudjnEFwEiHVeQrYdUdU+YwUOFW2x2DMdTtwj
 S0uA4JvFDk2QDdda604t0zBa5P/RHetRn6dsFZ+scWg42CwY4lYXieaX28sQ4BaznLbu5R5jh
 ooKny4D0IyurYM9S/jzMm8EBvIZGsVd1O7LAG3qB57Oxb6ALL88u+QdvKU43QnL9IO2yfBoBj
 OiA6x0q1wFPEFxYj30IEMsyu7TxACZSNtDp3CIVw51bBW/UN9WtFNodjqFb1rUYOqIQx9bF99
 AtaexaSmZSs5gMPOPqykmSZZuk2culhNl2U4Uc1O9wvEjtKamN9V6cslGn7xKEDET+/GV+/Wp
 NWDWdQKG0NIfGCQvSXkxahit9RObnZym4OcjE3hYh4W5RvjFne/hGs7XMQb6148glJnozfrKv
 VAe0R4DKTxBbJLrO+Xtbz1ENKC0ZfY9woWowQXTU1Q0I/X7AT8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 5:15 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Mar 24, 2022 at 10:54:16AM -0700, Florian Fainelli wrote:
> > The maximum DMA address is PAGE_OFFSET + arm_dma_zone_size - 1, fix this
> > by doing the appropriate subtraction.
>
> The question is... is MAX_DMA_ADDRESS inclusive or exclusive. The answer
> is rather indeterminant, unfortunately.
>
> drivers/net/wan/cosa.c: if (b + len >= MAX_DMA_ADDRESS)
>
> So, if the buffer address + buffer length is equal to MAX_DMA_ADDRESS,
> then the buffer is not DMA-able. To me this looks completely wrong.
> It's also completely wrong because 'b' is a "unsigned long" which
> means on 32-bit, this can wrap.

This driver is on its way out and will be removed in 5.19.

> there's a bunch of memblock allocation functions that use
> __pa(MAX_DMA_ADDRESS) as the "min_addr" and if this is a minimum
> address, then surely this means that it is also an exclusive value.
>
> So, I came to the conclusion that MAX_DMA_ADDRESS is supposed to be
> exclusive. In other words, where PAGE_OFFSET + sizeof(ram) if
> sizeof(ram) is the size in bytes of the RAM, limited to the maximum
> addressable virtual address that RAM can be mapped to.
>
> I don't see an inclusive value being correct, at least not for the cases
> I've looekd at.

Looking at the other definitions, I see it's usually either ULONG_MAX (which
is inclusive) or an exclusive limit, same as the existing version on arm:

arch/alpha/include/asm/io.h:#define IDENT_ADDR     0xffff800000000000UL
arch/alpha/include/asm/dma.h:#define MAX_DMA_ADDRESS
(alpha_mv.mv_pci_tbi ?  \
arch/alpha/include/asm/dma.h-                            ~0UL :
IDENT_ADDR + 0x01000000)
arch/arc/include/asm/dma.h:#define MAX_DMA_ADDRESS 0xC0000000
arch/hexagon/include/asm/dma.h:#define MAX_DMA_ADDRESS  (PAGE_OFFSET)
arch/ia64/mm/init.c:unsigned long MAX_DMA_ADDRESS = PAGE_OFFSET + 0x100000000UL;
arch/m68k/include/asm/dma.h:#define MAX_DMA_ADDRESS PAGE_OFFSET
arch/mips/include/asm/dma.h:#define MAX_DMA_ADDRESS             PAGE_OFFSET
arch/mips/include/asm/dma.h:#define MAX_DMA_ADDRESS
(PAGE_OFFSET + 0x01000000)
arch/parisc/include/asm/dma.h:#define MAX_DMA_ADDRESS (~0UL)
arch/powerpc/include/asm/dma.h:#define MAX_DMA_ADDRESS          (~0UL)
arch/s390/include/asm/dma.h:#define MAX_DMA_ADDRESS         0x80000000
arch/sparc/include/asm/dma.h:#define MAX_DMA_ADDRESS  (~0UL)
arch/um/include/asm/dma.h:#define MAX_DMA_ADDRESS (uml_physmem)
arch/x86/include/asm/dma.h:#define MAX_DMA_ADDRESS      (PAGE_OFFSET +
0x1000000)
arch/x86/include/asm/dma.h:#define MAX_DMA_PFN   ((16UL * 1024 * 1024)
>> PAGE_SHIFT)
arch/x86/include/asm/dma.h:#define MAX_DMA_ADDRESS ((unsigned
long)__va(MAX_DMA_PFN << PAGE_SHIFT))

The exceptions are:
arch/xtensa/include/asm/kmem_layout.h:#define XCHAL_KIO_SIZE
         0x10000000
arch/xtensa/include/asm/dma.h:#define MAX_DMA_ADDRESS
(PAGE_OFFSET + XCHAL_KIO_SIZE - 1)
arch/microblaze/include/asm/dma.h:#define MAX_DMA_ADDRESS
(CONFIG_KERNEL_START + memory_size - 1)

        Arnd
