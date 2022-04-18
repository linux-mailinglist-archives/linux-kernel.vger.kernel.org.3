Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA20505BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbiDRPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345764AbiDRPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:51:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BDA39810
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:29:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l3-20020a05600c1d0300b0038ff89c938bso103244wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpoZJEMaDfwGpxsvVFMgbbbkzSzrjetHuWBAngXn7p0=;
        b=WjAwfl4Hxi9AsjZhUx26omH9CbIJExsNxL18rlLcJR2mpASAVkSLjVGy3QgH2eRH6A
         pCLHeP4B9d9+FWcN1MWRFae7G2J5ZTSUVpBl2Lu66WRUlguTL4oGhb1kpBEbgkpTgE4y
         hnzqKFSVw/oGEq+ArCyWKB6hPoH79rfq8rHlPgWqFWGCsf/z48FoQ104cm/b8nCklwaE
         BWuHlIwI5iz6BAUjUGS7pKf+JG4mjGNDNeIOcK/wbbQ+pwjzuABA7rFMx0EHV/lXun4E
         tKj3NlaHW6ZSe5J8zTYjKajaUaFV7b0Q6/EynvHIXwgSTWUwr3UYDtyXYoiLcGFTP33p
         rdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpoZJEMaDfwGpxsvVFMgbbbkzSzrjetHuWBAngXn7p0=;
        b=vbqX0oaTAaCAtCHRDrVSY5l2Vmz22QicMC4jAiQm2WM56G6YxFkkvyn5HEzCXtMAyL
         5W0xllufrc0JJ8EHOgdQjhNO5L1D5p6VzwSqVNvBWDv7YfPqyZD03CokZu+OYaN7s0bH
         mBDPGp1phKkO/gFH8DdQ68ExxofLLY/Zf/rRv5tLKjSG82KAtRR7vQdE7PyMhpOQZijr
         MteKqVfGjlEAScBOB1bbi6S2M3j6jjdXdSM6hCksCd47fVI22St2C/gtaKpQZoohAYxV
         vSUsDlZ/qvbKsm+Xm3Fh2DFs7Icp1/HLXH1YCUkhKDIXbyXWLUnCY6WISmBzcEqgJ1PG
         jpmQ==
X-Gm-Message-State: AOAM532w3vcCjTi7aqBZH5vi0hvageGa72MGfgACd3nqlHvgYps+hG1J
        7rf5KppbnRZPLhJjziTLaWkdHMeF6wjCDEBKiHZzAg==
X-Google-Smtp-Source: ABdhPJzMbjRaGf80CGJ7OM44xoA0Ga5ZVEEvnI9n2JLpycbGrJSTrFsLuS4AKw8EORV6Q+FCKUY7LCjpKGtR0R7LT3s=
X-Received: by 2002:a05:600c:1c91:b0:392:6f01:5069 with SMTP id
 k17-20020a05600c1c9100b003926f015069mr12310836wms.199.1650295761340; Mon, 18
 Apr 2022 08:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220307224620.1933061-1-heiko@sntech.de> <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org> <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org> <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
 <YlvTkfIO9Oz3ib5i@Red> <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
 <YlxP26dklDj2y+cP@Red>
In-Reply-To: <YlxP26dklDj2y+cP@Red>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Mon, 18 Apr 2022 17:29:10 +0200
Message-ID: <CAAeLtUC=eF6hp2V2d7wEWWX=vkEcP8NoPLLz=hUrE4x4Q7u4mw@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>, Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Muellner <cmuellner@linux.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2022 at 19:35, Corentin Labbe <clabbe.montjoie@gmail.com> wr=
ote:
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

Doesn't the DMA_FROM_DEVICE indicate that there are no expected writes
from the CPU to the buffer (and that any modifications to the
underlying cache line can be dropped via an invalidation)?
In other words: does the behavior change when mapping as
DMA_BIDIRECTIONAL =E2=80=94 and: should a map/unmap sequence be used where =
it
is first mapped as DMA_TO_DEVICE when poisoning the buffer and later
as DMA_FROM_DEVICE when in normal operation?

Philipp.

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
