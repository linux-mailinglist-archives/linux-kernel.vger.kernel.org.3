Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95375547F42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiFMFus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiFMFuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:50:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70D62F4;
        Sun, 12 Jun 2022 22:50:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6161568AA6; Mon, 13 Jun 2022 07:50:29 +0200 (CEST)
Date:   Mon, 13 Jun 2022 07:50:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, hch@lst.de,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220613055029.GA32155@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <20220610004308.1903626-3-heiko@sntech.de> <342e3c12-ebb0-badf-7d4c-c444a2b842b2@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342e3c12-ebb0-badf-7d4c-c444a2b842b2@sholland.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:15:00PM -0500, Samuel Holland wrote:
> > +config RISCV_ISA_ZICBOM
> > +	bool "Zicbom extension support for non-coherent dma operation"
> > +	select ARCH_HAS_DMA_PREP_COHERENT
> > +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> > +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> > +	select ARCH_HAS_SETUP_DMA_OPS
> 
> ARCH_HAS_SETUP_DMA_OPS needs to be separate from the non-coherent DMA option,
> because iommu_setup_dma_ops() will need to be called from arch_setup_dma_ops()
> even on a fully-coherent system. (But this change is not strictly necessary for
> this series.)

It doesn't need to be separate, you can just add another select for
the symbol.

> > +	case DMA_FROM_DEVICE:
> > +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> > +		break;
> 
> arch_sync_dma_for_device(DMA_FROM_DEVICE) is a no-op from the CPU's perspective.
> Invalidating the CPU's cache goes in arch_sync_dma_for_cpu(DMA_FROM_DEVICE).

Only if you guarantee that there is never any speculation.  See:

https://lore.kernel.org/lkml/20180518175004.GF17671@n2100.armlinux.org.uk
