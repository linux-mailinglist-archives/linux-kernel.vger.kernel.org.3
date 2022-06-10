Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8F545BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbiFJF4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiFJF4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:56:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C533344;
        Thu,  9 Jun 2022 22:56:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6394D67373; Fri, 10 Jun 2022 07:56:08 +0200 (CEST)
Date:   Fri, 10 Jun 2022 07:56:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220610055608.GA24221@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <20220610004308.1903626-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610004308.1903626-3-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:43:07AM +0200, Heiko Stuebner wrote:
> +config RISCV_ISA_ZICBOM
> +	bool "Zicbom extension support for non-coherent dma operation"
> +	select ARCH_HAS_DMA_PREP_COHERENT
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> +	select ARCH_HAS_SETUP_DMA_OPS
> +	select DMA_DIRECT_REMAP
> +	select RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZICBOM extension

Overly long line here.

> +	   (Cache Block Management Operations) and enable its usage.
> +
> +	   If you don't know what to do here, say Y.

But more importantly I think the whole text here is not very helpful.
What users care about is non-coherent DMA support.  What extension is
used for that is rather secondary.  Also please capitalize DMA.

> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;
> +	case DMA_FROM_DEVICE:
> +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;
> +	case DMA_BIDIRECTIONAL:
> +		ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;
> +	default:
> +		break;
> +	}

Pleae avoid all these crazy long lines.  and use a logical variable
for the virtual address.  And why do you pass that virtual address
as an unsigned long to ALT_CMO_OP?  You're going to make your life
much easier if you simply always pass a pointer.

Last but not last, does in RISC-V clean mean writeback and flush mean
writeback plus invalidate?  If so the code is correct, but the choice
of names in the RISC-V spec is extremely unfortunate.

> +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		break;
> +	case DMA_FROM_DEVICE:
> +	case DMA_BIDIRECTIONAL:
> +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;
> +	default:
> +		break;
> +	}
> +}

Same comment here and in few other places.

> +
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +	void *flush_addr = page_address(page);
> +
> +	memset(flush_addr, 0, size);
> +	ALT_CMO_OP(FLUSH, (unsigned long)flush_addr, size, riscv_cbom_block_size);
> +}

arch_dma_prep_coherent should never zero the memory, that is left
for the upper layers.`

> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +		const struct iommu_ops *iommu, bool coherent)
> +{
> +	/* If a specific device is dma-coherent, set it here */

This comment isn't all that useful.

> +	dev->dma_coherent = coherent;
> +}

But more importantly, this assums that once this code is built all
devices are non-coherent by default.  I.e. with this patch applied
and the config option enabled we'll now suddenly start doing cache
management operations or setups that didn't do it before.
