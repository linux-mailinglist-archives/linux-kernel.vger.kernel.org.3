Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF354CF21
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiFOQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348296AbiFOQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:57:02 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7963E4ECC7;
        Wed, 15 Jun 2022 09:56:56 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o1WJt-0008LU-1G; Wed, 15 Jun 2022 18:56:41 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management operations
Date:   Wed, 15 Jun 2022 18:56:40 +0200
Message-ID: <110361853.nniJfEyVGO@diego>
In-Reply-To: <20220610055608.GA24221@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <20220610004308.1903626-3-heiko@sntech.de> <20220610055608.GA24221@lst.de>
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

Am Freitag, 10. Juni 2022, 07:56:08 CEST schrieb Christoph Hellwig:
> On Fri, Jun 10, 2022 at 02:43:07AM +0200, Heiko Stuebner wrote:
> > +config RISCV_ISA_ZICBOM
> > +	bool "Zicbom extension support for non-coherent dma operation"
> > +	select ARCH_HAS_DMA_PREP_COHERENT
> > +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> > +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> > +	select ARCH_HAS_SETUP_DMA_OPS
> > +	select DMA_DIRECT_REMAP
> > +	select RISCV_ALTERNATIVE
> > +	default y
> > +	help
> > +	   Adds support to dynamically detect the presence of the ZICBOM extension
> 
> Overly long line here.

fixed

> 
> > +	   (Cache Block Management Operations) and enable its usage.
> > +
> > +	   If you don't know what to do here, say Y.
> 
> But more importantly I think the whole text here is not very helpful.
> What users care about is non-coherent DMA support.  What extension is
> used for that is rather secondary.

I guess it might make sense to split that in some way.
I.e. Zicbom provides one implementation for handling non-coherence,
the D1 uses different (but very similar) instructions while the SoC on the
Beagle-V does something completely different.

So I guess it could make sense to have a general DMA_NONCOHERENT option
and which gets selected by the relevant users.

This also fixes the issue that Zicbom needs a very new binutils
but if beagle-v support happens that wouldn't need that.


> Also please capitalize DMA.

fixed

> > +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +	switch (dir) {
> > +	case DMA_TO_DEVICE:
> > +		ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> > +		break;
> > +	case DMA_FROM_DEVICE:
> > +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> > +		break;
> > +	case DMA_BIDIRECTIONAL:
> > +		ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> Pleae avoid all these crazy long lines.  and use a logical variable
> for the virtual address.  And why do you pass that virtual address
> as an unsigned long to ALT_CMO_OP?  You're going to make your life
> much easier if you simply always pass a pointer.

fixed all of those.
And of course you're right, not having the cast when calling ALT_CMO_OP
makes things definitly a lot nicer looking.

> Last but not last, does in RISC-V clean mean writeback and flush mean
> writeback plus invalidate?  If so the code is correct, but the choice
> of names in the RISC-V spec is extremely unfortunate.

clean: 
    makes data [...] visible to a set of non-coherent agents [...] by
    performing a write transfer of a copy of a cache block [...]

flush:
    performs a clean followed by an invalidate

So that's a yes to your question

> > +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +	switch (dir) {
> > +	case DMA_TO_DEVICE:
> > +		break;
> > +	case DMA_FROM_DEVICE:
> > +	case DMA_BIDIRECTIONAL:
> > +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> 
> Same comment here and in few other places.

fixed

> > +
> > +void arch_dma_prep_coherent(struct page *page, size_t size)
> > +{
> > +	void *flush_addr = page_address(page);
> > +
> > +	memset(flush_addr, 0, size);
> > +	ALT_CMO_OP(FLUSH, (unsigned long)flush_addr, size, riscv_cbom_block_size);
> > +}
> 
> arch_dma_prep_coherent should never zero the memory, that is left
> for the upper layers.`

fixed

> > +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +		const struct iommu_ops *iommu, bool coherent)
> > +{
> > +	/* If a specific device is dma-coherent, set it here */
> 
> This comment isn't all that useful.

ok, I've dropped it

> > +	dev->dma_coherent = coherent;
> > +}
> 
> But more importantly, this assums that once this code is built all
> devices are non-coherent by default.  I.e. with this patch applied
> and the config option enabled we'll now suddenly start doing cache
> management operations or setups that didn't do it before.

If I'm reading things correctly [0], the default for those functions
is for those to be empty - but defined in the coherent case.

When you look at the definition of ALT_CMO_OP

#define ALT_CMO_OP(_op, _start, _size, _cachesize)                      \
asm volatile(ALTERNATIVE_2(                                             \
        __nops(6),                                                      \

 you'll see that it's default variant is to do nothing and it doing any
non-coherency voodoo is only patched in if the Zicbom extension
(or T-Head errata) is detected at runtime.

So in the coherent case (with the memset removed as you suggested),
the arch_sync_dma_* and arch_dma_prep_coherent functions end up as
something like

void arch_dma_prep_coherent(struct page *page, size_t size)
{
        void *flush_addr = page_address(page);

        nops(6);
}

which is very mich similar to the defaults [0] I guess, or am I
overlooking something?

Thanks for taking the time for that review
Heiko


[0] https://elixir.bootlin.com/linux/latest/source/include/linux/dma-map-ops.h#L293


