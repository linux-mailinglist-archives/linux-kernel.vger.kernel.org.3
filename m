Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB3506627
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349534AbiDSHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242669AbiDSHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:46:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AFA23BF6;
        Tue, 19 Apr 2022 00:44:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so13375920wrc.0;
        Tue, 19 Apr 2022 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Td4Hy43R6SEG1pSO6X3vGzswl7vCz1dgDqCHGi0vEko=;
        b=amXfhlUYJ0+KM8IxEq4FT8n4km/zvVadqRbfTjwrztbRO8AjAy9ooKFJu1tnjVihT5
         bNW2u/auAZA6P2JiXMtrqZsk9sN73gFbu6/60Ls4TV0dm1xmqSEy6ouZ2Q75O8byGRQW
         6caopDBH0jU7rXoaf/3OXByzjLbC/UmnEJUkGl+3qFDw7clw2haCYusMnkmFH8tnyBcc
         tcQ4Bus1Nk2FSeEUUGyx/V9lHEJSKO9IYx1hgRshvUZ0bspAaH/FdX6EfmH7Wt5yqTpu
         Nq8i9BdrOq01JnXs1TQK6oCGq0KED0opFguEMn0wJ0/1ByIF9DuIhlN/g+DoRBlVWPu7
         xRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Td4Hy43R6SEG1pSO6X3vGzswl7vCz1dgDqCHGi0vEko=;
        b=peAx1Vs6OFcmmRnSY/TiyGdTvSX7GJZrY8m+pdFUmiV+mm1fuue0ahubIIbg6zWV3X
         SUJr2bQvWwXpM90hFEtyunButRMHoM6zewAC6ffhhBSjSqeFJCHwXq1AFQo4f76XWejN
         EyaMYhIIHK/QQQMHWnqjzyFrUyLUXIJMV0VgffBRqC8NleQphjmeHXaPV2tcFSE3AVTA
         6SyT1q3QuezPcCdUeSqJHArMsyFqub76vD3JtkW/KoGljCC41XecagUUPCHQDcZrbcpW
         ktYDOP/FBHSccywbC8wFOrxwxSNSYDy414jRcfMxBJxjOGLWK+K4LlL2y56vtPiwTtUY
         CcIw==
X-Gm-Message-State: AOAM533HXNCRE0CviQ7+y+ZobDUnEUv1t+xsJyha/jAIjWEFVQ4u+G9S
        hbOCxnD15/XyQk6yzsA4Jo8=
X-Google-Smtp-Source: ABdhPJyPmfPsbf+yNodLgTbvOFCNxRsuD75a/3auxzXxSukB3FUe2LejoxHw+cdrH2+O79tXHPG8Ow==
X-Received: by 2002:a5d:6650:0:b0:207:ac24:a825 with SMTP id f16-20020a5d6650000000b00207ac24a825mr10545728wrw.97.1650354246817;
        Tue, 19 Apr 2022 00:44:06 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l8-20020a5d5608000000b00207ab405d15sm11882256wrv.42.2022.04.19.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 00:44:06 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:44:04 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
Message-ID: <Yl5oRPuNC3w+UI0q@Red>
References: <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
 <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
 <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
 <YlvTkfIO9Oz3ib5i@Red>
 <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
 <YlxP26dklDj2y+cP@Red>
 <CAJF2gTQNBVBGqbtHckwtB59wjrPoN-Li32BcUJpLahaYDnU3WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQNBVBGqbtHckwtB59wjrPoN-Li32BcUJpLahaYDnU3WQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 18, 2022 at 06:50:57AM +0800, Guo Ren a écrit :
> On Mon, Apr 18, 2022 at 1:35 AM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > Le Sun, Apr 17, 2022 at 04:49:34PM +0800, Guo Ren a écrit :
> > > On Sun, Apr 17, 2022 at 4:45 PM Corentin Labbe
> > > <clabbe.montjoie@gmail.com> wrote:
> > > >
> > > > Le Sun, Apr 17, 2022 at 10:17:34AM +0800, Guo Ren a écrit :
> > > > > On Sun, Apr 17, 2022 at 3:32 AM Corentin Labbe
> > > > > <clabbe.montjoie@gmail.com> wrote:
> > > > > >
> > > > > > Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a écrit :
> > > > > > > On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > > > > > > > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a écrit :
> > > > > > > >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > > > > > > >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
> > > > > > > >>>> This series is based on the alternatives changes done in my svpbmt series
> > > > > > > >>>> and thus also depends on Atish's isa-extension parsing series.
> > > > > > > >>>>
> > > > > > > >>>> It implements using the cache-management instructions from the  Zicbom-
> > > > > > > >>>> extension to handle cache flush, etc actions on platforms needing them.
> > > > > > > >>>>
> > > > > > > >>>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> > > > > > > >>>> different set of cache instructions. But while they are different,
> > > > > > > >>>> instructions they provide the same functionality, so a variant can
> > > > > > > >>>> easly hook into the existing alternatives mechanism on those.
> > > > > > > >>>>
> > > > > > > >>>>
> > > > > > > >>>
> > > > > > > >>> Hello
> > > > > > > >>>
> > > > > > > >>> I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
> > > > > > > >>>
> > > > > > > >>> I am hitting a buffer corruption problem with DMA.
> > > > > > > >>> The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
> > > > > > > >>> In fact the buffer is not overran by device but by dma_map_single() operation.
> > > > > > > >>>
> > > > > > > >>> The following small code show the problem:
> > > > > > > >>>
> > > > > > > >>> dma_addr_t dma;
> > > > > > > >>> u8 *buf;
> > > > > > > >>> #define BSIZE 2048
> > > > > > > >>> #define DMASIZE 16
> > > > > > > >>>
> > > > > > > >>> buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > > > > > > >>> for (i = 0; i < BSIZE; i++)
> > > > > > > >>>     buf[i] = 0xFE;
> > > > > > > >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> > > > > > > >>> dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> > > > > > > >>
> > > > > > > >> This function (through dma_direct_map_page()) ends up calling
> > > > > > > >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
> > > > > > > >> cache. This is the same thing other architectures do (at least arm, arm64,
> > > > > > > >> openrisc, and powerpc). So this appears to be working as intended.
> > > > > > > >
> > > > > > > > This behavour is not present at least on ARM and ARM64.
> > > > > > > > The sample code I provided does not corrupt the buffer on them.
> > > > > > >
> > > > > > > That can be explained by the 0xFE bytes having been flushed to DRAM already in
> > > > > > > your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes were still in
> > > > > > > a dirty cache line. The cache topology and implementation is totally different
> > > > > > > across the SoCs, so this is not too surprising.
> > > > > > >
> > > > > > > Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are doing a
> > > > > > > unidirectional DMA transfer from the device into that buffer. So the contents of
> > > > > > > the buffer are "undefined" until the DMA transfer completes. If you are also
> > > > > > > writing data into the buffer from the CPU side, then you need DMA_BIDIRECTIONAL.
> > > > > > >
> > > > > > > Regards,
> > > > > > > Samuel
> > > > > >
> > > > > > +CC crypto mailing list + maintainer
> > > > > >
> > > > > > My problem is that crypto selftest, for each buffer where I need to do a cipher operation,
> > > > > > concat a poison buffer to check that device does write beyond buffer.
> > > > > >
> > > > > > But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and crypto selftests fails thinking my device did a buffer overrun.
> > > > > >
> > > > > > So you mean that on SoC D1, this crypto API check strategy is impossible ?
> > > > >
> > > > > I think you could try to replace all CLEAN & INVAL ops with FLUSH ops
> > > > > for the testing. (All cache block-aligned data from the device for the
> > > > > CPU should be invalided.)
> > > > >
> > > >
> > > > With:
> > > > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > > > index 2c124bcc1932..608483522e05 100644
> > > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > > @@ -21,7 +21,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_dire
> > > >                 ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size);
> > > >                 break;
> > > >         case DMA_FROM_DEVICE:
> > > > -               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
> > > > +               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
> > > >                 break;
> > > >         case DMA_BIDIRECTIONAL:
> > > >                 ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
> > > >
> > > >
> > > > The crypto self test works and I got no more buffer corruption.
> > > No, No ... it's not a solution. That means your driver has a problem.
> > > From device, we only need INVAL enough.
> > >
> >
> > For me, my driver works fine, the problem came from dma_map_sg(), probably I didnt explain right, I restart.
> >
> > Example:
> > crypto self test send to my driver an AES cipher operation of 16 bytes inside a SG, but the original buffer is greater (said 32 for the example).
> > So the first 16 bytes are used by the SG and the last 16 bytes are a poisoned buffer (with value 0xFE) to check driver do not write beyong the normal operation of 16 bytes (and beyond the SG length).
> >
> > Doing the dma_map_sg(FROM_DEVICE) on the SG corrupt the whole buffer.
> > My driver write normally via DMA the first 16 bytes.
> > Crypto API check the last bytes, no more 0xFE, so it fail believing my driver wrote beyond the first 16 bytes.
> >
> > But even If I disable my hardware operation, the buffer is still corrupted. (See my sample code which just do dma_map/dma_unmap)
> >
> > So the problem is the dma_map(FROM_DEVICE) which change buffer content.
> >
> > So if this behavour is normal on D1 SoC, how to fix the crypto self tests ?
> Actually, FLUSH is safe for all, but more expensive. Can you tell me
> which arm SOC are you using? And which version of linux is running on
> your arm SOC?
> 

The SOC is Allwinner D1 (RiscV).
I am testing linux from https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip

