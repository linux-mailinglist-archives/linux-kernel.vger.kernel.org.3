Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEE650489B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiDQRiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiDQRiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:38:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9261AD80;
        Sun, 17 Apr 2022 10:35:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r64so7647621wmr.4;
        Sun, 17 Apr 2022 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KMZt2bVJM1zLo0DjhLeNEZmiJ3z7y7UdEFlYZgbQlFo=;
        b=q47vSOyXrisZAu15yZ/0sW7h8Q1Lfy+mVgQNnOiQuxL7ftDD6Mgqi91ddqdMfJTXNQ
         QCggWtKnMC2cOJwFanDTSNBGXgoNwRCZ4W0Ng+/sqKvinwD1rRKcVJir4FfI94iEqgwL
         gJP2tfvpK+Qyzaem3XUao6rcSukVIwBDS1O4ahoRBQi6pHfJDvQlaOxvmElPmoW+oxta
         j1TItDP0/MVQjSZV6zR685EPFhlUEqLab4+f/2p3zWMi9iUQ8vOaOMcVcqwjT5UOB+eJ
         G8ya2Kbe88YDUrbkSwd8a5snLJqn1QjrSl7Bms1Y4MQh6kF+JfXheULQlrb89+PUSyWW
         mdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KMZt2bVJM1zLo0DjhLeNEZmiJ3z7y7UdEFlYZgbQlFo=;
        b=zk/ErCWUM1PaM9MNtSgpdcPkIdSRGTajC/WgFDMtFUPWZnFEIDGgN2JLs2CeDpMM33
         PUQtDbvvQL493wCn7Gj1STjl7FCUYSSOcFnClXcsxJuINHdfqk+jJTIWkJaJC+GIHPFD
         7x1HyKFufi6JzQ/PD+ywvmawlnBF7K/N5P+xwj3Jc5Na6nxsb67NBAEr2c0Se6GTzWmV
         HVQ73gAZ5StOT3F9cjrAyT8MnAufkvquzMnXCkh+hFDwZtE/eRVQQCs5oosq94RQcsAn
         H20m/tfe698QgH9yZ4DMKQvUl/W0MK9Doq2VAL3z2zmHr2KreL4oaeG7Uv8uJI++Ur0V
         nWdQ==
X-Gm-Message-State: AOAM532y8Jk8HAbPjhX6yFmaZYD0cQv/Hrw4GewnyC6++ugNKSrMeSHs
        TfodmnX3VS0lUswKPz+/qts=
X-Google-Smtp-Source: ABdhPJyzBVGsbyJQgmx7ekA8ANp0KKP/jg8CuPLV7HzroOXyLwKn/H/m+WZRFyk65/0ebFnQ9bF/JQ==
X-Received: by 2002:a7b:c016:0:b0:38f:53c2:b8b3 with SMTP id c22-20020a7bc016000000b0038f53c2b8b3mr11677148wmb.13.1650216925713;
        Sun, 17 Apr 2022 10:35:25 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id e1-20020a05600c4e4100b00392910b276esm2954901wmq.9.2022.04.17.10.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:35:25 -0700 (PDT)
Date:   Sun, 17 Apr 2022 19:35:23 +0200
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
Message-ID: <YlxP26dklDj2y+cP@Red>
References: <20220307224620.1933061-1-heiko@sntech.de>
 <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
 <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
 <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
 <YlvTkfIO9Oz3ib5i@Red>
 <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Apr 17, 2022 at 04:49:34PM +0800, Guo Ren a écrit :
> On Sun, Apr 17, 2022 at 4:45 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > Le Sun, Apr 17, 2022 at 10:17:34AM +0800, Guo Ren a écrit :
> > > On Sun, Apr 17, 2022 at 3:32 AM Corentin Labbe
> > > <clabbe.montjoie@gmail.com> wrote:
> > > >
> > > > Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a écrit :
> > > > > On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > > > > > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a écrit :
> > > > > >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > > > > >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
> > > > > >>>> This series is based on the alternatives changes done in my svpbmt series
> > > > > >>>> and thus also depends on Atish's isa-extension parsing series.
> > > > > >>>>
> > > > > >>>> It implements using the cache-management instructions from the  Zicbom-
> > > > > >>>> extension to handle cache flush, etc actions on platforms needing them.
> > > > > >>>>
> > > > > >>>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> > > > > >>>> different set of cache instructions. But while they are different,
> > > > > >>>> instructions they provide the same functionality, so a variant can
> > > > > >>>> easly hook into the existing alternatives mechanism on those.
> > > > > >>>>
> > > > > >>>>
> > > > > >>>
> > > > > >>> Hello
> > > > > >>>
> > > > > >>> I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
> > > > > >>>
> > > > > >>> I am hitting a buffer corruption problem with DMA.
> > > > > >>> The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
> > > > > >>> In fact the buffer is not overran by device but by dma_map_single() operation.
> > > > > >>>
> > > > > >>> The following small code show the problem:
> > > > > >>>
> > > > > >>> dma_addr_t dma;
> > > > > >>> u8 *buf;
> > > > > >>> #define BSIZE 2048
> > > > > >>> #define DMASIZE 16
> > > > > >>>
> > > > > >>> buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > > > > >>> for (i = 0; i < BSIZE; i++)
> > > > > >>>     buf[i] = 0xFE;
> > > > > >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> > > > > >>> dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> > > > > >>
> > > > > >> This function (through dma_direct_map_page()) ends up calling
> > > > > >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
> > > > > >> cache. This is the same thing other architectures do (at least arm, arm64,
> > > > > >> openrisc, and powerpc). So this appears to be working as intended.
> > > > > >
> > > > > > This behavour is not present at least on ARM and ARM64.
> > > > > > The sample code I provided does not corrupt the buffer on them.
> > > > >
> > > > > That can be explained by the 0xFE bytes having been flushed to DRAM already in
> > > > > your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes were still in
> > > > > a dirty cache line. The cache topology and implementation is totally different
> > > > > across the SoCs, so this is not too surprising.
> > > > >
> > > > > Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are doing a
> > > > > unidirectional DMA transfer from the device into that buffer. So the contents of
> > > > > the buffer are "undefined" until the DMA transfer completes. If you are also
> > > > > writing data into the buffer from the CPU side, then you need DMA_BIDIRECTIONAL.
> > > > >
> > > > > Regards,
> > > > > Samuel
> > > >
> > > > +CC crypto mailing list + maintainer
> > > >
> > > > My problem is that crypto selftest, for each buffer where I need to do a cipher operation,
> > > > concat a poison buffer to check that device does write beyond buffer.
> > > >
> > > > But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and crypto selftests fails thinking my device did a buffer overrun.
> > > >
> > > > So you mean that on SoC D1, this crypto API check strategy is impossible ?
> > >
> > > I think you could try to replace all CLEAN & INVAL ops with FLUSH ops
> > > for the testing. (All cache block-aligned data from the device for the
> > > CPU should be invalided.)
> > >
> >
> > With:
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > index 2c124bcc1932..608483522e05 100644
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -21,7 +21,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_dire
> >                 ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size);
> >                 break;
> >         case DMA_FROM_DEVICE:
> > -               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
> > +               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
> >                 break;
> >         case DMA_BIDIRECTIONAL:
> >                 ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
> >
> >
> > The crypto self test works and I got no more buffer corruption.
> No, No ... it's not a solution. That means your driver has a problem.
> From device, we only need INVAL enough.
> 

For me, my driver works fine, the problem came from dma_map_sg(), probably I didnt explain right, I restart.

Example:
crypto self test send to my driver an AES cipher operation of 16 bytes inside a SG, but the original buffer is greater (said 32 for the example).
So the first 16 bytes are used by the SG and the last 16 bytes are a poisoned buffer (with value 0xFE) to check driver do not write beyong the normal operation of 16 bytes (and beyond the SG length).

Doing the dma_map_sg(FROM_DEVICE) on the SG corrupt the whole buffer.
My driver write normally via DMA the first 16 bytes.
Crypto API check the last bytes, no more 0xFE, so it fail believing my driver wrote beyond the first 16 bytes.

But even If I disable my hardware operation, the buffer is still corrupted. (See my sample code which just do dma_map/dma_unmap)

So the problem is the dma_map(FROM_DEVICE) which change buffer content.

So if this behavour is normal on D1 SoC, how to fix the crypto self tests ?
