Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0A504746
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiDQIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiDQIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E303B3;
        Sun, 17 Apr 2022 01:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C94A61179;
        Sun, 17 Apr 2022 08:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B42AC385AC;
        Sun, 17 Apr 2022 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650185386;
        bh=iqaxMFM3cYKwlA/IAnWiV8E2ISGqOdaBcPl+s4Z4EFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZN7F9fihzfdvl59d2QDDnMTqqiMdPQukHbVsuA4xlXA02NG5NGlUkX3J48W6tpMop
         2hh72D8MYPw57+Pjz+LXmfAUQDqjGaMmCGb8MwCH5NyuHMXwNG98uL+nRZKlbEvHl8
         1KB8bBu/vtAbdTEHRrR7g4CoWBrnhEBCV02R/pJeeX/yp8aPs+pJSlUpMqujEuGRW8
         /p67rTsYW5PC7nidCw4TOsuPUmylmswjeXnOjB/W0PQL/yv2g7/KhGKb8MCvbupc/A
         kJO20SKbTjlWDW6aWYHDEsN6QzkV3XGnD9om6jP3jYU58hQ6q+zXzphAuWuoFIVRym
         oXwGj0j6NUEQA==
Received: by mail-vk1-f179.google.com with SMTP id c4so5098847vkq.9;
        Sun, 17 Apr 2022 01:49:46 -0700 (PDT)
X-Gm-Message-State: AOAM531owDALx8vB7RyNPZV+hYpaqKyxxHUJieBc3SYjTNJ4zQJdxPrS
        +eUaQtlPeWL+/PFo8ByBNLwNyGPRsZf/3pdtdCI=
X-Google-Smtp-Source: ABdhPJxpmYlU8zsrvZqkexAACBkf1OGxuZ/DVZQMF78y5+ZDzoKYkD60G10mw6vsE2NXQwp3zpqfVvAjGHJ9C45ab8A=
X-Received: by 2002:a1f:1b07:0:b0:348:f10f:82b2 with SMTP id
 b7-20020a1f1b07000000b00348f10f82b2mr1461848vkb.8.1650185385515; Sun, 17 Apr
 2022 01:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220307224620.1933061-1-heiko@sntech.de> <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org> <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org> <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com> <YlvTkfIO9Oz3ib5i@Red>
In-Reply-To: <YlvTkfIO9Oz3ib5i@Red>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Apr 2022 16:49:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
Message-ID: <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 4:45 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Le Sun, Apr 17, 2022 at 10:17:34AM +0800, Guo Ren a =C3=A9crit :
> > On Sun, Apr 17, 2022 at 3:32 AM Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> > >
> > > Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a =C3=A9crit=
 :
> > > > On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > > > > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a =C3=A9=
crit :
> > > > >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > > > >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a =C3=
=A9crit :
> > > > >>>> This series is based on the alternatives changes done in my sv=
pbmt series
> > > > >>>> and thus also depends on Atish's isa-extension parsing series.
> > > > >>>>
> > > > >>>> It implements using the cache-management instructions from the=
  Zicbom-
> > > > >>>> extension to handle cache flush, etc actions on platforms need=
ing them.
> > > > >>>>
> > > > >>>> SoCs using cpu cores from T-Head like the Allwinne D1 implemen=
t a
> > > > >>>> different set of cache instructions. But while they are differ=
ent,
> > > > >>>> instructions they provide the same functionality, so a variant=
 can
> > > > >>>> easly hook into the existing alternatives mechanism on those.
> > > > >>>>
> > > > >>>>
> > > > >>>
> > > > >>> Hello
> > > > >>>
> > > > >>> I am testing https://github.com/smaeul/linux.git branch:origin/=
riscv/d1-wip which contain this serie.
> > > > >>>
> > > > >>> I am hitting a buffer corruption problem with DMA.
> > > > >>> The sun8i-ce crypto driver fail self tests due to "device overr=
an destination buffer".
> > > > >>> In fact the buffer is not overran by device but by dma_map_sing=
le() operation.
> > > > >>>
> > > > >>> The following small code show the problem:
> > > > >>>
> > > > >>> dma_addr_t dma;
> > > > >>> u8 *buf;
> > > > >>> #define BSIZE 2048
> > > > >>> #define DMASIZE 16
> > > > >>>
> > > > >>> buf =3D kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > > > >>> for (i =3D 0; i < BSIZE; i++)
> > > > >>>     buf[i] =3D 0xFE;
> > > > >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4,=
 buf, 256, false);
> > > > >>> dma =3D dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> > > > >>
> > > > >> This function (through dma_direct_map_page()) ends up calling
> > > > >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which inval=
idates the CPU's
> > > > >> cache. This is the same thing other architectures do (at least a=
rm, arm64,
> > > > >> openrisc, and powerpc). So this appears to be working as intende=
d.
> > > > >
> > > > > This behavour is not present at least on ARM and ARM64.
> > > > > The sample code I provided does not corrupt the buffer on them.
> > > >
> > > > That can be explained by the 0xFE bytes having been flushed to DRAM=
 already in
> > > > your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes =
were still in
> > > > a dirty cache line. The cache topology and implementation is totall=
y different
> > > > across the SoCs, so this is not too surprising.
> > > >
> > > > Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are do=
ing a
> > > > unidirectional DMA transfer from the device into that buffer. So th=
e contents of
> > > > the buffer are "undefined" until the DMA transfer completes. If you=
 are also
> > > > writing data into the buffer from the CPU side, then you need DMA_B=
IDIRECTIONAL.
> > > >
> > > > Regards,
> > > > Samuel
> > >
> > > +CC crypto mailing list + maintainer
> > >
> > > My problem is that crypto selftest, for each buffer where I need to d=
o a cipher operation,
> > > concat a poison buffer to check that device does write beyond buffer.
> > >
> > > But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and crypt=
o selftests fails thinking my device did a buffer overrun.
> > >
> > > So you mean that on SoC D1, this crypto API check strategy is impossi=
ble ?
> >
> > I think you could try to replace all CLEAN & INVAL ops with FLUSH ops
> > for the testing. (All cache block-aligned data from the device for the
> > CPU should be invalided.)
> >
>
> With:
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index 2c124bcc1932..608483522e05 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -21,7 +21,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t=
 size, enum dma_data_dire
>                 ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), siz=
e);
>                 break;
>         case DMA_FROM_DEVICE:
> -               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), siz=
e);
> +               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), siz=
e);
>                 break;
>         case DMA_BIDIRECTIONAL:
>                 ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), siz=
e);
>
>
> The crypto self test works and I got no more buffer corruption.
No, No ... it's not a solution. That means your driver has a problem.
From device, we only need INVAL enough.

>
> Thanks



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
