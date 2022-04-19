Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC6506653
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbiDSHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbiDSHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:55:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA831342;
        Tue, 19 Apr 2022 00:52:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso979528wma.0;
        Tue, 19 Apr 2022 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eZpQIMcf57eQ4Toe30lop11XB/wtE4XfPzcJjOelQAQ=;
        b=ZtBJaerAOEjk+R53uNhpU1wTf+RmUBy2/7sWUosxlIh7R7F9g7AQ6qw9nLavxeC2cK
         kU/CAWn/3GZRLINAGcGerEoooPYKXVHIlb2SiqlpCwmnW3dRfamr1idgDSuV9UFGoWk3
         YDP/1REHzokK8iOWwDy44uY066OU1mApx5+XjgJVP6FIC31ug6At/QQtzhkxnqAhpEsG
         bfUdrTfcsKa1/SdvHYz4PwE9pMT9yBBANBOzNz2AOO0jrQes992FroVBXZXTZsDWopJ5
         uC44V6XX+jhh15uHG0hzY9S7qsTwP+/Vug/z8VV8tkrhwaADfR6cmp5I+3c5q9XZW8Mz
         L9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eZpQIMcf57eQ4Toe30lop11XB/wtE4XfPzcJjOelQAQ=;
        b=Vwe28eqifRAS1JJYSVavsQW3HG86XO66tMEI6BBXiO8OwmJRfLCbQGgPDj8ThvdKOn
         rkIGXV1iw2OU6LfFd+DuaNiuSLnpE4lIvyrrhPcUSy+XcsNNPUYsZR3KFZ1sGVMPWHtI
         uvCARmqQ5N7Rstn+gVbhefCkPqfRq4DqnL/QHcLm5POhVdfkgy4zxdsnWLVDx3JOY5j6
         fuh+pl/0nV9NOAR73Z78lJLeObybcheD3zIAspC2BGDUP4geYZRXD7fjrKNcrBZX2Tot
         opHna5WwDfWd8vCeof5CE4FOk+N7pbHVcTLDFMK9aZOCXEyrETELLJV58NJhJTo7i9vO
         cSOQ==
X-Gm-Message-State: AOAM530fe+JrO42eUnDxbvU3JYErzqxUcDXz3pMpr8TMZ9OEclmt2Y8z
        KsBazmk0JAzST0KDINJplj2SPHRf8LU=
X-Google-Smtp-Source: ABdhPJweuRk6oDVCcwSRhuZjnG9UdFTrsXSCa+eFj3YFe7XBwPmwPUjSO5MQvyDdgW/2DwT8soCYJw==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr18757314wma.140.1650354739543;
        Tue, 19 Apr 2022 00:52:19 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m188-20020a1c26c5000000b0039187bb7e9asm12472904wmm.6.2022.04.19.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 00:52:19 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:52:17 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
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
Subject: Re: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the
 t-head variant
Message-ID: <Yl5qMXCpwmxho/FN@Red>
References: <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
 <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
 <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
 <YlvTkfIO9Oz3ib5i@Red>
 <CAJF2gTQ5rYATTHj2UtwxKw0dpvdHBUAih1RJf0XuGM8b6euZwQ@mail.gmail.com>
 <YlxP26dklDj2y+cP@Red>
 <CAAeLtUC=eF6hp2V2d7wEWWX=vkEcP8NoPLLz=hUrE4x4Q7u4mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAeLtUC=eF6hp2V2d7wEWWX=vkEcP8NoPLLz=hUrE4x4Q7u4mw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 18, 2022 at 05:29:10PM +0200, Philipp Tomsich a écrit :
> On Sun, 17 Apr 2022 at 19:35, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
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
> 
> Doesn't the DMA_FROM_DEVICE indicate that there are no expected writes
> from the CPU to the buffer (and that any modifications to the
> underlying cache line can be dropped via an invalidation)?
> In other words: does the behavior change when mapping as
> DMA_BIDIRECTIONAL — and: should a map/unmap sequence be used where it
> is first mapped as DMA_TO_DEVICE when poisoning the buffer and later
> as DMA_FROM_DEVICE when in normal operation?
> 

There are no cpu writes after the dma_map(FROM_DEVICE).
The buffer is initialized by the cryptoAPI before.
Furtheremore, the buffer corrupted is next to the buffer being mapped.

I verified the size of dma_map_sg() via some debug:
sun8i-ce 3040000.crypto: sun8i_ce_cipher_prepare ecb(aes) cryptlen=16
dma_direct_map_sg:483 SG0 len=16   <- dma_map TO_DEVICE
dma_direct_map_sg:483 SG0 len=16   <- dma_map FROM_DEVICE
need:a47ca9dd e0df4c86 a070af6e 91710dec 
have:a47ca9dd e0df4c86 a070af6e 91710dec
dump whole buffer:
over:a47ca9dd e0df4c86 a070af6e 91710dec
over:ec05e6f2 d542fb77 128b2059 5bf06986 < here we should have 0xFE
alg: skcipher: ecb-aes-sun8i-ce encryption overran dst buffer on test vector 1, cfg=\"random: use_finup src_divs=[<reimport>100.0%@+1604]\"


Note that I tried the following patch:
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4948201065cc..c5b945974441 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -19,6 +19,7 @@
 #include <crypto/aead.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
+#include <linux/cacheflush.h>
 #include <linux/err.h>
 #include <linux/fips.h>
 #include <linux/module.h>
@@ -205,6 +206,7 @@ static void testmgr_free_buf(char *buf[XBUFSIZE])
 static inline void testmgr_poison(void *addr, size_t len)
 {
        memset(addr, TESTMGR_POISON_BYTE, len);
+       flush_icache_range(addr, addr + len);
 }
 
 /* Is the memory region still fully poisoned? */

This patch fixes the problem, but I am not sure this is the rigth way.
A DMA mapping operation corrupting buffer around seems not good.
