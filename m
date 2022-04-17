Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227465049DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiDQWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 18:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDQWxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:53:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F88186D7;
        Sun, 17 Apr 2022 15:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E65FB80D8A;
        Sun, 17 Apr 2022 22:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F118AC385B2;
        Sun, 17 Apr 2022 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650235870;
        bh=zDOBgnl70WIG4aT0/2q/PIkF6z5KtIxdOp/pt8dlU/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dAVhbez32nAkSLYSZrjlNemwtBpg+fQmTQ6PKE2TFlAK6tseuEvPZWPztbRhvpwl2
         HfqrgMjkzPhtvCOv1yXzcskq8gQj6tBrMoZ7e++tWxqFB+kHb59nTeCNZpSVGFga7J
         eHozegimtOK6a72np/J9ZF8A46Vws6W7NjOfsfhSmR9pWiC9+6GA3R1NEHBl15p5Qf
         SqVo4ltBKnyBy6tkPgTQmFTejH21csyiN89aqhpf99lvFxLhS1+jSfdX73tUYO8Z8F
         ye7bLc8+SMBi6WiDnBjsLE5N/ZprELa6mAQsMTRrFlyHopPVDeDo7BwFdLOASKbeuo
         ze9Ht9nee0nJA==
Received: by mail-ua1-f49.google.com with SMTP id j9so4284976uap.13;
        Sun, 17 Apr 2022 15:51:09 -0700 (PDT)
X-Gm-Message-State: AOAM533WKy99ydynEnSeGLePdbvqKN8MTloriByJ1leZnpZ2utmeRmpK
        FvYwigELMRzVHOQleB9iBgxO6JYLQmW6GODmG+I=
X-Google-Smtp-Source: ABdhPJw7aQgc63icUNZqiZfJwWpkmdUoUGgVUkjFJv0CVk+/dLfcYcyayKO5MxYuRNO5K1OcRT/3VF9lLjiFo7rFK5U=
X-Received: by 2002:ab0:4306:0:b0:35c:df5b:d7ab with SMTP id
 k6-20020ab04306000000b0035cdf5bd7abmr1809316uak.83.1650235868572; Sun, 17 Apr
 2022 15:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220307224620.1933061-1-heiko@sntech.de> <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org> <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org> <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
 <YlvTkfIO9Oz3ib5i@Red> <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
 <YlxP26dklDj2y+cP@Red>
In-Reply-To: <YlxP26dklDj2y+cP@Red>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 18 Apr 2022 06:50:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQNBVBGqbtHckwtB59wjrPoN-Li32BcUJpLahaYDnU3WQ@mail.gmail.com>
Message-ID: <CAJF2gTQNBVBGqbtHckwtB59wjrPoN-Li32BcUJpLahaYDnU3WQ@mail.gmail.com>
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 1:35 AM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Le Sun, Apr 17, 2022 at 04:49:34PM +0800, Guo Ren a =C3=A9crit :
> > On Sun, Apr 17, 2022 at 4:45 PM Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> > >
> > > Le Sun, Apr 17, 2022 at 10:17:34AM +0800, Guo Ren a =C3=A9crit :
> > > > On Sun, Apr 17, 2022 at 3:32 AM Corentin Labbe
> > > > <clabbe.montjoie@gmail.com> wrote:
> > > > >
> > > > > Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a =C3=A9=
crit :
> > > > > > On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > > > > > > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a =
=C3=A9crit :
> > > > > > >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > > > > > >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a =
=C3=A9crit :
> > > > > > >>>> This series is based on the alternatives changes done in m=
y svpbmt series
> > > > > > >>>> and thus also depends on Atish's isa-extension parsing ser=
ies.
> > > > > > >>>>
> > > > > > >>>> It implements using the cache-management instructions from=
 the  Zicbom-
> > > > > > >>>> extension to handle cache flush, etc actions on platforms =
needing them.
> > > > > > >>>>
> > > > > > >>>> SoCs using cpu cores from T-Head like the Allwinne D1 impl=
ement a
> > > > > > >>>> different set of cache instructions. But while they are di=
fferent,
> > > > > > >>>> instructions they provide the same functionality, so a var=
iant can
> > > > > > >>>> easly hook into the existing alternatives mechanism on tho=
se.
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>
> > > > > > >>> Hello
> > > > > > >>>
> > > > > > >>> I am testing https://github.com/smaeul/linux.git branch:ori=
gin/riscv/d1-wip which contain this serie.
> > > > > > >>>
> > > > > > >>> I am hitting a buffer corruption problem with DMA.
> > > > > > >>> The sun8i-ce crypto driver fail self tests due to "device o=
verran destination buffer".
> > > > > > >>> In fact the buffer is not overran by device but by dma_map_=
single() operation.
> > > > > > >>>
> > > > > > >>> The following small code show the problem:
> > > > > > >>>
> > > > > > >>> dma_addr_t dma;
> > > > > > >>> u8 *buf;
> > > > > > >>> #define BSIZE 2048
> > > > > > >>> #define DMASIZE 16
> > > > > > >>>
> > > > > > >>> buf =3D kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > > > > > >>> for (i =3D 0; i < BSIZE; i++)
> > > > > > >>>     buf[i] =3D 0xFE;
> > > > > > >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16=
, 4, buf, 256, false);
> > > > > > >>> dma =3D dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVI=
CE);
> > > > > > >>
> > > > > > >> This function (through dma_direct_map_page()) ends up callin=
g
> > > > > > >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which i=
nvalidates the CPU's
> > > > > > >> cache. This is the same thing other architectures do (at lea=
st arm, arm64,
> > > > > > >> openrisc, and powerpc). So this appears to be working as int=
ended.
> > > > > > >
> > > > > > > This behavour is not present at least on ARM and ARM64.
> > > > > > > The sample code I provided does not corrupt the buffer on the=
m.
> > > > > >
> > > > > > That can be explained by the 0xFE bytes having been flushed to =
DRAM already in
> > > > > > your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE by=
tes were still in
> > > > > > a dirty cache line. The cache topology and implementation is to=
tally different
> > > > > > across the SoCs, so this is not too surprising.
> > > > > >
> > > > > > Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you ar=
e doing a
> > > > > > unidirectional DMA transfer from the device into that buffer. S=
o the contents of
> > > > > > the buffer are "undefined" until the DMA transfer completes. If=
 you are also
> > > > > > writing data into the buffer from the CPU side, then you need D=
MA_BIDIRECTIONAL.
> > > > > >
> > > > > > Regards,
> > > > > > Samuel
> > > > >
> > > > > +CC crypto mailing list + maintainer
> > > > >
> > > > > My problem is that crypto selftest, for each buffer where I need =
to do a cipher operation,
> > > > > concat a poison buffer to check that device does write beyond buf=
fer.
> > > > >
> > > > > But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and c=
rypto selftests fails thinking my device did a buffer overrun.
> > > > >
> > > > > So you mean that on SoC D1, this crypto API check strategy is imp=
ossible ?
> > > >
> > > > I think you could try to replace all CLEAN & INVAL ops with FLUSH o=
ps
> > > > for the testing. (All cache block-aligned data from the device for =
the
> > > > CPU should be invalided.)
> > > >
> > >
> > > With:
> > > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-nonc=
oherent.c
> > > index 2c124bcc1932..608483522e05 100644
> > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > @@ -21,7 +21,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, si=
ze_t size, enum dma_data_dire
> > >                 ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr),=
 size);
> > >                 break;
> > >         case DMA_FROM_DEVICE:
> > > -               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr),=
 size);
> > > +               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr),=
 size);
> > >                 break;
> > >         case DMA_BIDIRECTIONAL:
> > >                 ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr),=
 size);
> > >
> > >
> > > The crypto self test works and I got no more buffer corruption.
> > No, No ... it's not a solution. That means your driver has a problem.
> > From device, we only need INVAL enough.
> >
>
> For me, my driver works fine, the problem came from dma_map_sg(), probabl=
y I didnt explain right, I restart.
>
> Example:
> crypto self test send to my driver an AES cipher operation of 16 bytes in=
side a SG, but the original buffer is greater (said 32 for the example).
> So the first 16 bytes are used by the SG and the last 16 bytes are a pois=
oned buffer (with value 0xFE) to check driver do not write beyong the norma=
l operation of 16 bytes (and beyond the SG length).
>
> Doing the dma_map_sg(FROM_DEVICE) on the SG corrupt the whole buffer.
> My driver write normally via DMA the first 16 bytes.
> Crypto API check the last bytes, no more 0xFE, so it fail believing my dr=
iver wrote beyond the first 16 bytes.
>
> But even If I disable my hardware operation, the buffer is still corrupte=
d. (See my sample code which just do dma_map/dma_unmap)
>
> So the problem is the dma_map(FROM_DEVICE) which change buffer content.
>
> So if this behavour is normal on D1 SoC, how to fix the crypto self tests=
 ?
Actually, FLUSH is safe for all, but more expensive. Can you tell me
which arm SOC are you using? And which version of linux is running on
your arm SOC?


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
