Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80849504744
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiDQIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiDQIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:47:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C213FBF;
        Sun, 17 Apr 2022 01:45:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so7316871wms.0;
        Sun, 17 Apr 2022 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7wWS6noHLcNsU8scVbVVSUAGOxSaanswt4nimge22b8=;
        b=RJg5KyIpRAK0Ho2i/k1FafodyQ9j6XIcg+NURJxgo66fSFH8y/P1U1IwyIeZv2opML
         c45X2rwADSaZoKuR4jbi+gyHJlVL8xFv/9tUHBE8fJ+xjlDKUsPJv9+Aztti9pO6QFaU
         ISRaGaea2S4L+cSoDveGP/xxC+kLLhpXVYczwItDJZ1rSiDY0OKV6zC2dFBnqIpFuaPx
         8hVUO2SNs0knLK7XgdpKmsRlcGSlFvXS9Zod2wFrhxshUrn0/Ia498wvCezAh31ohvFS
         QKWHXLF2VmvgBa/Lwiw0x15TdYhk2EZLniUL6c91LmfJkg38ep4UyZBFPc5V/am1FbMW
         K0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7wWS6noHLcNsU8scVbVVSUAGOxSaanswt4nimge22b8=;
        b=g7NfHVrCd9Wp9PMw3V+HHg9c+hCGVNPxhaGvkDKDaIzGjV3fewnFuPEj3Wus+LdfRh
         lt/wJf+aFAjfMuxtWjrRVpNF5PvxHzDtmcnDylOXyOl2SMq8WLy/K853u/VS0DJf48Kf
         VKq1ZLqFla8ehBTcSU9+fZfmksBcCuyGI9qmG59qDM+uhwXiYAulV2hopyCqJxnGDa93
         5IOgLk7u1GylQq+pm+5EntZUR06WbGn8KL80p8IQziNZXyrNCVSacmR2QSYDHTEmOsCQ
         32fU1+E87ej8+1N0U7zbcSV6iulxd6ZzGPfKqBIxHmiTtZPOuuKp6FRrOXVDF68EHI3S
         uJbQ==
X-Gm-Message-State: AOAM531l0ndrmvpxIxe+gzcCuC5/2WXnafopipuuvr4mk4Wzm/DvaBuS
        XQ4D+Lx+QH5g4OKM0qOAM86ZA6+UBz0=
X-Google-Smtp-Source: ABdhPJy0X7/oCDY4Yf3RbA22FQLnuwgS4px/fhnSP8iHYTFC1msOKWeHpKY6R5yfbWh6eoieriHBXg==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr6287455wmk.58.1650185108105;
        Sun, 17 Apr 2022 01:45:08 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id j36-20020a05600c1c2400b0038ec526a0e3sm16509818wms.9.2022.04.17.01.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 01:45:07 -0700 (PDT)
Date:   Sun, 17 Apr 2022 10:45:05 +0200
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
Message-ID: <YlvTkfIO9Oz3ib5i@Red>
References: <20220307224620.1933061-1-heiko@sntech.de>
 <YllWTN+15CoskNBt@Red>
 <70da24dd-2d03-fc49-151d-daabb315a5f6@sholland.org>
 <YlpxsYREWv/LQ+HY@Red>
 <849a3728-7e84-4f26-0c73-4d68eae9ae01@sholland.org>
 <YlsZxVjgt3ZNQ7Ub@Red>
 <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTSNzLfon7yH3zvOJfYwQnVRvNWW7KygShLqcagRfbyAkg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Apr 17, 2022 at 10:17:34AM +0800, Guo Ren a écrit :
> On Sun, Apr 17, 2022 at 3:32 AM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > Le Sat, Apr 16, 2022 at 12:47:29PM -0500, Samuel Holland a écrit :
> > > On 4/16/22 2:35 AM, Corentin Labbe wrote:
> > > > Le Fri, Apr 15, 2022 at 09:19:23PM -0500, Samuel Holland a écrit :
> > > >> On 4/15/22 6:26 AM, Corentin Labbe wrote:
> > > >>> Le Mon, Mar 07, 2022 at 11:46:18PM +0100, Heiko Stuebner a écrit :
> > > >>>> This series is based on the alternatives changes done in my svpbmt series
> > > >>>> and thus also depends on Atish's isa-extension parsing series.
> > > >>>>
> > > >>>> It implements using the cache-management instructions from the  Zicbom-
> > > >>>> extension to handle cache flush, etc actions on platforms needing them.
> > > >>>>
> > > >>>> SoCs using cpu cores from T-Head like the Allwinne D1 implement a
> > > >>>> different set of cache instructions. But while they are different,
> > > >>>> instructions they provide the same functionality, so a variant can
> > > >>>> easly hook into the existing alternatives mechanism on those.
> > > >>>>
> > > >>>>
> > > >>>
> > > >>> Hello
> > > >>>
> > > >>> I am testing https://github.com/smaeul/linux.git branch:origin/riscv/d1-wip which contain this serie.
> > > >>>
> > > >>> I am hitting a buffer corruption problem with DMA.
> > > >>> The sun8i-ce crypto driver fail self tests due to "device overran destination buffer".
> > > >>> In fact the buffer is not overran by device but by dma_map_single() operation.
> > > >>>
> > > >>> The following small code show the problem:
> > > >>>
> > > >>> dma_addr_t dma;
> > > >>> u8 *buf;
> > > >>> #define BSIZE 2048
> > > >>> #define DMASIZE 16
> > > >>>
> > > >>> buf = kmalloc(BSIZE, GFP_KERNEL | GFP_DMA);
> > > >>> for (i = 0; i < BSIZE; i++)
> > > >>>     buf[i] = 0xFE;
> > > >>> print_hex_dump(KERN_INFO, "DMATEST1:", DUMP_PREFIX_NONE, 16, 4, buf, 256, false);
> > > >>> dma = dma_map_single(ce->dev, buf, DMASIZE, DMA_FROM_DEVICE);
> > > >>
> > > >> This function (through dma_direct_map_page()) ends up calling
> > > >> arch_sync_dma_for_device(..., ..., DMA_FROM_DEVICE), which invalidates the CPU's
> > > >> cache. This is the same thing other architectures do (at least arm, arm64,
> > > >> openrisc, and powerpc). So this appears to be working as intended.
> > > >
> > > > This behavour is not present at least on ARM and ARM64.
> > > > The sample code I provided does not corrupt the buffer on them.
> > >
> > > That can be explained by the 0xFE bytes having been flushed to DRAM already in
> > > your ARM/ARM64 tests, whereas in your riscv64 case, the 0xFE bytes were still in
> > > a dirty cache line. The cache topology and implementation is totally different
> > > across the SoCs, so this is not too surprising.
> > >
> > > Semantically, dma_map_single(..., DMA_FROM_DEVICE) means you are doing a
> > > unidirectional DMA transfer from the device into that buffer. So the contents of
> > > the buffer are "undefined" until the DMA transfer completes. If you are also
> > > writing data into the buffer from the CPU side, then you need DMA_BIDIRECTIONAL.
> > >
> > > Regards,
> > > Samuel
> >
> > +CC crypto mailing list + maintainer
> >
> > My problem is that crypto selftest, for each buffer where I need to do a cipher operation,
> > concat a poison buffer to check that device does write beyond buffer.
> >
> > But the dma_map_sg(FROM_DEVICE) corrupts this poison buffer and crypto selftests fails thinking my device did a buffer overrun.
> >
> > So you mean that on SoC D1, this crypto API check strategy is impossible ?
> 
> I think you could try to replace all CLEAN & INVAL ops with FLUSH ops
> for the testing. (All cache block-aligned data from the device for the
> CPU should be invalided.)
> 

With:
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index 2c124bcc1932..608483522e05 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -21,7 +21,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_dire
                ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size);
                break;
        case DMA_FROM_DEVICE:
-               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
+               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
                break;
        case DMA_BIDIRECTIONAL:
                ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);


The crypto self test works and I got no more buffer corruption.

Thanks
