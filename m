Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1FE559458
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiFXHt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXHt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:49:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E40522D0;
        Fri, 24 Jun 2022 00:49:24 -0700 (PDT)
Received: from p508fdadf.dip0.t-ipconnect.de ([80.143.218.223] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o4e3z-0007Di-1E; Fri, 24 Jun 2022 09:49:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 3/4] riscv: Implement Zicbom-based cache management operations
Date:   Fri, 24 Jun 2022 09:49:09 +0200
Message-ID: <4357313.8hb0ThOEGa@phil>
In-Reply-To: <20220620061607.GB10485@lst.de>
References: <20220619203212.3604485-1-heiko@sntech.de> <20220619203212.3604485-4-heiko@sntech.de> <20220620061607.GB10485@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am Montag, 20. Juni 2022, 08:16:07 CEST schrieb Christoph Hellwig:
> On Sun, Jun 19, 2022 at 10:32:11PM +0200, Heiko Stuebner wrote:
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > +#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> > +#endif
> 
> This needs to be greater or equal to riscv_cbom_block_size, but the
> core code requires a compile time constant here.  So we'll need a big
> fat comment here, and panic if riscv_cbom_block_size is >
> L1_CACHE_BYTES/ARCH_DMA_MINALIGN in the code that queries
> riscv_cbom_block_size.

ARM people also had this nice WARN_TAINT to warn when the similar
case happens on ARM64 and the ARCH_DMA_MINALIGN is smaller than
the register value so I've added a similar mechanism.

I've read numerous mails from Torvalds over time that panic-ing should
only ever be the very very last resort, so that WARN_TAINT looks like
a less drastic option while still generating that big warning to users.


> Note that the arm64 folks are looking into making this variable or
> killing it off in this current form, so things might be getting better
> soon.
> 
> > +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> > +			      enum dma_data_direction dir)
> > +{
> > +	void *vaddr = phys_to_virt(paddr);
> > +
> > +	switch (dir) {
> > +	case DMA_TO_DEVICE:
> > +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> > +		break;
> > +	case DMA_FROM_DEVICE:
> > +		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> > +		break;
> 
> For this also see:
> 
> https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/
> 
> and
> 
> https://lore.kernel.org/linux-arm-kernel/20220610151228.4562-1-will@kernel.org/T/

so from that discussion, it looks like a "clean" should happen here to
prevent stale bytes (not written to by the dma transfer itself) in the
buffer area I guess.

I'll give that a spin :-)

> > +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +		const struct iommu_ops *iommu, bool coherent)
> > +{
> > +	dev->dma_coherent = coherent;
> > +}
> 
> This probably wants a sanity check warn if coherent if false without
> any support for cache flushing as that will cause data corruption.

I've added a riscv_noncoherent_supported() call that will track that
"somebody" implemented non-coherence functionality from their
setup function (zicbom_probe, thead_errata-probe) and a matching
second WARN_TAINT in arch_setup_dma_ops() when coherent value
and availability of non-coherence handling is not matched.

Heiko




