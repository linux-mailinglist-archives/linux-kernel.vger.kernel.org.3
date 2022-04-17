Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02E4504616
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 04:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiDQCU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiDQCUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 22:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBCE39B86;
        Sat, 16 Apr 2022 19:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C104B80817;
        Sun, 17 Apr 2022 02:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBE2C385A3;
        Sun, 17 Apr 2022 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650161866;
        bh=bx2uLNy9kh6NXUmk/gZMiJhVwfpmY33EmUzJDhYYLxc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B9wu3Ycc3o7Ldj2TQeodyCsifUWXfZOzuU9T5dPbWiSCUbV2rK1OhPAKQ9tY7hkUM
         5BF1oXnwJpI1KPM5lcVdTEcVGQ/nW1hIkoaDMU+s/xS1oqz/ljgVl9g8fnA9Sl4rVT
         Q7HqOqtSDFqCTZd7fypi8qkV9nbNfA4hIY4kRfZ1bahEH9w2xQBwg6VmasQZIhrDi1
         rDhZ8nbPCu4SiaKsYgsAXusNlCo4XzPB8Uhzz8mmduqiDC4PnGiZpbf0Z9CuIyJImt
         pBYnW3q8Cld7cn46oYqGaiCpMyN0tN0PHZhQpKknDTJZtTgP/IvO5BVhllSi3OZzhv
         BsymVgZdE2y2Q==
Received: by mail-vs1-f52.google.com with SMTP id 190so4153265vse.8;
        Sat, 16 Apr 2022 19:17:45 -0700 (PDT)
X-Gm-Message-State: AOAM531o3BDgZbduzLHnmcZODSdhDZB+9D1Zmc8TvOPO77tUFcLeh1rB
        DGnAtsSdDJe354yYqK5DyZvK7oh7g3g1/emAy4E=
X-Google-Smtp-Source: ABdhPJwDwPGwTQMvBZ6WuWvZF9H6Zem3ZXbT8gq+nWkq6deMkmC/owhEVrj6n5M9PYzPHIfmQVFje28KIU6QWRlnLnM=
X-Received: by 2002:a05:6102:38d1:b0:325:aff9:358 with SMTP id
 k17-20020a05610238d100b00325aff90358mr1493945vst.8.1650161864963; Sat, 16 Apr
 2022 19:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220307224620.1933061-1-heiko@sntech.de> <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org> <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org> <YlsZxVjgt3ZNQ7Ub@Red>
In-Reply-To: <YlsZxVjgt3ZNQ7Ub@Red>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Apr 2022 10:17:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
Message-ID: <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
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

On Sun, Apr 17, 2022 at 3:32 AM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a =C3=A9crit :
> > On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a =C3=A9crit=
 :
> > >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a =C3=A9cr=
it :
> > >>>> This series is based on the alternatives changes done in my svpbmt=
 series
> > >>>> and thus also depends on Atish's isa-extension parsing series.
> > >>>>
> > >>>> It implements using the cache-management instructions from the  Zi=
cbom-
> > >>>> extension to handle cache flush, etc actions on platforms needing =
them.
> > >>>>
> > >>>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> > >>>> different set of cache instructions. But while they are different,
> > >>>> instructions they provide the same functionality, so a variant can
> > >>>> easly hook into the existing alternatives mechanism on those.
> > >>>>
> > >>>>
> > >>>
> > >>> Hello
> > >>>
> > >>> I am testing https://github.com/smaeul/linux.git branch:origin/risc=
v/d1-wip which contain this serie.
> > >>>
> > >>> I am hitting a buffer corruption problem with DMA.
> > >>> The sun8i-ce crypto driver fail self tests due to "device overran d=
estination buffer".
> > >>> In fact the buffer is not overran by device but by dma_map_single()=
 operation.
> > >>>
> > >>> The following small code show the problem:
> > >>>
> > >>> dma_addr_t dma;
> > >>> u8 *buf;
> > >>> #define BSIZE 2048
> > >>> #define DMASIZE 16
> > >>>
> > >>> buf =3D kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > >>> for (i =3D 0; i < BSIZE; i++)
> > >>>     buf[i] =3D 0xFE;
> > >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf=
, 256, false);
> > >>> dma =3D dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> > >>
> > >> This function (through dma_direct_map_page()) ends up calling
> > >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidat=
es the CPU's
> > >> cache. This is the same thing other architectures do (at least arm, =
arm64,
> > >> openrisc, and powerpc). So this appears to be working as intended.
> > >
> > > This behavour is not present at least on ARM and ARM64.
> > > The sample code I provided does not corrupt the buffer on them.
> >
> > That can be explained by the 0xFE bytes having been flushed to DRAM alr=
eady in
> > your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes were=
 still in
> > a dirty cache line. The cache topology and implementation is totally di=
fferent
> > across the SoCs, so this is not too surprising.
> >
> > Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are doing =
a
> > unidirectional DMA transfer from the device into that buffer. So the co=
ntents of
> > the buffer are "undefined" until the DMA transfer completes. If you are=
 also
> > writing data into the buffer from the CPU side, then you need DMA_BIDIR=
ECTIONAL.
> >
> > Regards,
> > Samuel
>
> +CC crypto mailing list + maintainer
>
> My problem is that crypto selftest, for each buffer where I need to do a =
cipher operation,
> concat a poison buffer to check that device does write beyond buffer.
>
> But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and crypto se=
lftests fails thinking my device did a buffer overrun.
>
> So you mean that on SoC D1, this crypto API check strategy is impossible =
?

I think you could try to replace all CLEAN & INVAL ops with FLUSH ops
for the testing. (All cache block-aligned data from the device for the
CPU should be invalided.)

+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum
dma_data_direction dir)
+{
+ switch (dir) {
+ case DMA_TO_DEVICE:
+ ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size);
+ break;
+ case DMA_FROM_DEVICE:
+ ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
+ break;
+ case DMA_BIDIRECTIONAL:
+ ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
+ break;
+ default:
+ break;
+ }
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum
dma_data_direction dir)
+{
+ switch (dir) {
+ case DMA_TO_DEVICE:
+ break;
+ case DMA_FROM_DEVICE:
+ case DMA_BIDIRECTIONAL:
+ ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
+ break;
+ default:
+ break;
+ }
+}



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
