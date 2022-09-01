Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C35A89C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIAAW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIAAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:22:54 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5156EDF4D2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:22:52 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id A80C526EF48; Thu,  1 Sep 2022 02:15:01 +0200 (CEST)
Date:   Thu, 1 Sep 2022 02:15:01 +0200
From:   Janne Grunau <j@jannau.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>,
        Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iommu/io-pgtable: Move Apple DART support to its
 own file
Message-ID: <20220901001501.GC10102@jannau.net>
References: <20220621071848.14834-1-j@jannau.net>
 <20220621071848.14834-3-j@jannau.net>
 <0076bef7-9d3c-b5e9-00dc-a350f96e9e5f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0076bef7-9d3c-b5e9-00dc-a350f96e9e5f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-27 16:09:23 +0100, Robin Murphy wrote:
> On 2022-06-21 08:18, Janne Grunau wrote:
> > The pte format used by the DARTs found in the Apple M1 (t8103) is not
> > fully compatible with io-pgtable-arm. The 24 MSB are used for subpage
> > protection (mapping only parts of page) and conflict with the address
> > mask. In addition bit 1 is not available for tagging entries but disables
> > subpage protection. Subpage protection could be useful to support a CPU
> > granule of 4k with the fixed IOMMU page size of 16k.
> > 
> > The DARTs found on Apple M1 Pro/Max/Ultra use another different pte
> > format which is even less compatible. To support an output address size
> > of 42 bit the address is shifted down by 4. Subpage protection is
> > mandatory and bit 1 signifies uncached mappings used by the display
> > controller.
> > 
> > It would be advantageous to share code for all known Apple DART
> > variants to support common features. The page table allocator for DARTs
> > is less complex since it uses a two levels of translation table without
> > support for huge pages.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > 
> > ---
> > 
> > Changes in v3:
> > - move APPLE_DART to its own io-pgtable implementation, copied from
> >    io-pgtable-arm and simplified
> > 
> > Changes in v2:
> > - add APPLE_DART2 io-pgtable format
> > 
> >   MAINTAINERS                     |   1 +
> >   drivers/iommu/Kconfig           |   1 -
> >   drivers/iommu/Makefile          |   2 +-
> >   drivers/iommu/io-pgtable-arm.c  |  63 ----
> >   drivers/iommu/io-pgtable-dart.c | 580 ++++++++++++++++++++++++++++++++
> >   drivers/iommu/io-pgtable.c      |   2 +
> >   6 files changed, 584 insertions(+), 65 deletions(-)
> >   create mode 100644 drivers/iommu/io-pgtable-dart.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1fc9ead83d2a..028b7e31e589 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1848,6 +1848,7 @@ F:	drivers/clk/clk-apple-nco.c
> >   F:	drivers/i2c/busses/i2c-pasemi-core.c
> >   F:	drivers/i2c/busses/i2c-pasemi-platform.c
> >   F:	drivers/iommu/apple-dart.c
> > +F:	drivers/iommu/io-pgtable-dart.c
> >   F:	drivers/irqchip/irq-apple-aic.c
> >   F:	drivers/mailbox/apple-mailbox.c
> >   F:	drivers/nvme/host/apple.c
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index c79a0df090c0..ed6d8260f330 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -294,7 +294,6 @@ config APPLE_DART
> >   	tristate "Apple DART IOMMU Support"
> >   	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
> >   	select IOMMU_API
> > -	select IOMMU_IO_PGTABLE_LPAE
> 
> You still need to select the base IO_PGTABLE. FWIW I think that's probably
> the only crucial issue here - lots more comments below, but they're
> primarily things that could all be unpicked later.

fixed locally. io-pgtable-dart / dart build is now splitted to allow 
building dart as module.

> >   	default ARCH_APPLE
> >   	help
> >   	  Support for Apple DART (Device Address Resolution Table) IOMMUs
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 44475a9b3eea..bd68c93bbd62 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -29,4 +29,4 @@ obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> >   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> >   obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
> >   obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
> > -obj-$(CONFIG_APPLE_DART) += apple-dart.o
> > +obj-$(CONFIG_APPLE_DART) += apple-dart.o io-pgtable-dart.o
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 94ff319ae8ac..d7f5e23da643 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -130,9 +130,6 @@
> >   #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
> >   #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
> > -#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
> > -#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> > -
> >   /* IOPTE accessors */
> >   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> > @@ -406,15 +403,6 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> >   {
> >   	arm_lpae_iopte pte;
> > -	if (data->iop.fmt == APPLE_DART) {
> > -		pte = 0;
> > -		if (!(prot & IOMMU_WRITE))
> > -			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> > -		if (!(prot & IOMMU_READ))
> > -			pte |= APPLE_DART_PTE_PROT_NO_READ;
> > -		return pte;
> > -	}
> > -
> >   	if (data->iop.fmt == ARM_64_LPAE_S1 ||
> >   	    data->iop.fmt == ARM_32_LPAE_S1) {
> >   		pte = ARM_LPAE_PTE_nG;
> > @@ -1107,52 +1095,6 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> >   	return NULL;
> >   }
> > -static struct io_pgtable *
> > -apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > -{
> > -	struct arm_lpae_io_pgtable *data;
> > -	int i;
> > -
> > -	if (cfg->oas > 36)
> > -		return NULL;
> > -
> > -	data = arm_lpae_alloc_pgtable(cfg);
> > -	if (!data)
> > -		return NULL;
> > -
> > -	/*
> > -	 * The table format itself always uses two levels, but the total VA
> > -	 * space is mapped by four separate tables, making the MMIO registers
> > -	 * an effective "level 1". For simplicity, though, we treat this
> > -	 * equivalently to LPAE stage 2 concatenation at level 2, with the
> > -	 * additional TTBRs each just pointing at consecutive pages.
> > -	 */
> > -	if (data->start_level < 1)
> > -		goto out_free_data;
> > -	if (data->start_level == 1 && data->pgd_bits > 2)
> > -		goto out_free_data;
> > -	if (data->start_level > 1)
> > -		data->pgd_bits = 0;
> > -	data->start_level = 2;
> > -	cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
> > -	data->pgd_bits += data->bits_per_level;
> > -
> > -	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
> > -					   cfg);
> > -	if (!data->pgd)
> > -		goto out_free_data;
> > -
> > -	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i)
> > -		cfg->apple_dart_cfg.ttbr[i] =
> > -			virt_to_phys(data->pgd + i * ARM_LPAE_GRANULE(data));
> > -
> > -	return &data->iop;
> > -
> > -out_free_data:
> > -	kfree(data);
> > -	return NULL;
> > -}
> > -
> >   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
> >   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
> >   	.free	= arm_lpae_free_pgtable,
> > @@ -1178,11 +1120,6 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
> >   	.free	= arm_lpae_free_pgtable,
> >   };
> > -struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
> > -	.alloc	= apple_dart_alloc_pgtable,
> > -	.free	= arm_lpae_free_pgtable,
> > -};
> > -
> >   #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
> >   static struct io_pgtable_cfg *cfg_cookie __initdata;
> > diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
> > new file mode 100644
> > index 000000000000..0c5222942c65
> > --- /dev/null
> > +++ b/drivers/iommu/io-pgtable-dart.c
> > @@ -0,0 +1,580 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Apple DART page table allocator.
> > + *
> > + * Copyright (C) 2022 The Asahi Linux Contributors
> > + *
> > + * Based on io-pgtable-arm.
> > + *
> > + * Copyright (C) 2014 ARM Limited
> > + *
> > + * Author: Will Deacon <will.deacon@arm.com>
> > + */
> > +
> > +#define pr_fmt(fmt)	"dart io-pgtable: " fmt
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/bitops.h>
> > +#include <linux/io-pgtable.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sizes.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#include <asm/barrier.h>
> > +
> > +#define DART_MAX_ADDR_BITS		52
> 
> Surely 36, no?
> 
> > +#define DART_MAX_LEVELS		3
> 
> It might be simpler in the long run to drop the awkward pretence and handle
> these in their "native" form of multiple 2-level tables.

ack, removed the recursive map, unmap and translation
 
> > +
> > +/* Struct accessors */
> > +#define io_pgtable_to_data(x)						\
> > +	container_of((x), struct dart_io_pgtable, iop)
> > +
> > +#define io_pgtable_ops_to_data(x)					\
> > +	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
> > +
> > +/*
> > + * Calculate the right shift amount to get to the portion describing level l
> > + * in a virtual address mapped by the pagetable in d.
> > + */
> > +#define DART_LVL_SHIFT(l, d)						\
> > +	(((DART_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> > +	ilog2(sizeof(dart_iopte)))
> > +
> > +#define DART_GRANULE(d)						\
> > +	(sizeof(dart_iopte) << (d)->bits_per_level)
> > +#define DART_PGD_SIZE(d)					\
> > +	(sizeof(dart_iopte) << (d)->pgd_bits)
> > +
> > +#define DART_PTES_PER_TABLE(d)					\
> > +	(DART_GRANULE(d) >> ilog2(sizeof(dart_iopte)))
> > +
> > +/*
> > + * Calculate the index at level l used to map virtual address a using the
> > + * pagetable in d.
> > + */
> > +#define DART_PGD_IDX(l, d)						\
> > +	((l) == (d)->start_level ? (d)->pgd_bits - (d)->bits_per_level : 0)
> > +
> > +#define DART_LVL_IDX(a, l, d)						\
> > +	(((u64)(a) >> DART_LVL_SHIFT(l, d)) &				\
> > +	 ((1 << ((d)->bits_per_level + DART_PGD_IDX(l, d))) - 1))
> > +
> > +/* Calculate the block/page mapping size at level l for pagetable in d. */
> > +#define DART_BLOCK_SIZE(l, d)	(1ULL << DART_LVL_SHIFT(l, d))
> 
> If you don't actually have block mappings, much of the above is really more
> complicated than you need.

removed

> > +
> > +#define APPLE_DART1_PADDR_MASK	GENMASK_ULL(35, 12)
> > +
> > +/* Apple DART1 protection bits */
> > +#define APPLE_DART1_PTE_PROT_NO_READ	BIT(8)
> > +#define APPLE_DART1_PTE_PROT_NO_WRITE	BIT(7)
> > +#define APPLE_DART1_PTE_PROT_SP_DIS	BIT(1)
> > +
> > +/* marks PTE as valid */
> > +#define APPLE_DART_PTE_VALID		BIT(0)
> > +
> > +/* IOPTE accessors */
> > +#define iopte_deref(pte, d) __va(iopte_to_paddr(pte, d))
> > +
> > +struct dart_io_pgtable {
> > +	struct io_pgtable	iop;
> > +
> > +	int			pgd_bits;
> > +	int			start_level;
> 
> If you don't have a variable number of levels, this is a constant.

removed

> > +	int			bits_per_level;
> > +
> > +	void			*pgd;
> > +};
> > +
> > +typedef u64 dart_iopte;
> > +
> > +static inline bool iopte_leaf(dart_iopte pte, int lvl,
> > +			      enum io_pgtable_fmt fmt)
> > +{
> > +	return (lvl == (DART_MAX_LEVELS - 1)) && (pte & APPLE_DART_PTE_VALID);
> > +}
> > +
> > +static dart_iopte paddr_to_iopte(phys_addr_t paddr,
> > +				     struct dart_io_pgtable *data)
> > +{
> > +	return paddr & APPLE_DART1_PADDR_MASK;
> > +}
> > +
> > +static phys_addr_t iopte_to_paddr(dart_iopte pte,
> > +				  struct dart_io_pgtable *data)
> > +{
> > +	return pte & APPLE_DART1_PADDR_MASK;
> > +}
> > +
> > +static void *__dart_alloc_pages(size_t size, gfp_t gfp,
> > +				    struct io_pgtable_cfg *cfg)
> > +{
> > +	struct device *dev = cfg->iommu_dev;
> > +	int order = get_order(size);
> > +	struct page *p;
> > +
> > +	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> > +	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
> > +			     gfp | __GFP_ZERO, order);
> > +	if (!p)
> > +		return NULL;
> > +
> > +	return page_address(p);
> > +}
> > +
> > +static void __dart_free_pages(void *pages, size_t size)
> > +{
> > +	free_pages((unsigned long)pages, get_order(size));
> > +}
> > +
> > +static void __dart_init_pte(struct dart_io_pgtable *data,
> > +				phys_addr_t paddr, dart_iopte prot,
> > +				int lvl, int num_entries, dart_iopte *ptep)
> > +{
> > +	dart_iopte pte = prot;
> > +	size_t sz = DART_BLOCK_SIZE(lvl, data);
> > +	int i;
> > +
> > +	if (lvl == DART_MAX_LEVELS - 1)
> > +		pte |= APPLE_DART1_PTE_PROT_SP_DIS;
> > +
> > +	pte |= APPLE_DART_PTE_VALID;
> > +
> > +	for (i = 0; i < num_entries; i++)
> > +		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
> > +}
> > +
> > +static int dart_init_pte(struct dart_io_pgtable *data,
> > +			     unsigned long iova, phys_addr_t paddr,
> > +			     dart_iopte prot, int lvl, int num_entries,
> > +			     dart_iopte *ptep)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < num_entries; i++)
> > +		if (iopte_leaf(ptep[i], lvl, data->iop.fmt)) {
> > +			/* We require an unmap first */
> > +			WARN_ON(iopte_leaf(ptep[i], lvl, data->iop.fmt));
> > +			return -EEXIST;
> > +		}
> > +
> > +	__dart_init_pte(data, paddr, prot, lvl, num_entries, ptep);
> > +	return 0;
> > +}
> > +
> > +static dart_iopte dart_install_table(dart_iopte *table,
> > +					     dart_iopte *ptep,
> > +					     dart_iopte curr,
> > +					     struct dart_io_pgtable *data)
> > +{
> > +	dart_iopte old, new;
> > +
> > +	new = paddr_to_iopte(__pa(table), data) | APPLE_DART_PTE_VALID;
> > +
> > +	/*
> > +	 * Ensure the table itself is visible before its PTE can be.
> > +	 * Whilst we could get away with cmpxchg64_release below, this
> > +	 * doesn't have any ordering semantics when !CONFIG_SMP.
> > +	 */
> > +	dma_wmb();
> > +
> > +	old = cmpxchg64_relaxed(ptep, curr, new);
> > +
> > +	return old;
> > +}
> > +
> > +static int __dart_map(struct dart_io_pgtable *data, unsigned long iova,
> > +			  phys_addr_t paddr, size_t size, size_t pgcount,
> > +			  dart_iopte prot, int lvl, dart_iopte *ptep,
> > +			  gfp_t gfp, size_t *mapped)
> > +{
> > +	dart_iopte *cptep, pte;
> > +	size_t block_size = DART_BLOCK_SIZE(lvl, data);
> > +	size_t tblsz = DART_GRANULE(data);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +	int ret = 0, num_entries, max_entries, map_idx_start;
> > +
> > +	/* Find our entry at the current level */
> > +	map_idx_start = DART_LVL_IDX(iova, lvl, data);
> > +	ptep += map_idx_start;
> > +
> > +	/* If we can install a leaf entry at this level, then do so */
> > +	if (size == block_size) {
> 
> It's a bit confusing to retain this logic when it's reduced to a rather
> long-winded obfuscatiuon of "if (lvl == 2)".

simplified due to a rewrite to a non-recursive form.

> > +		max_entries = DART_PTES_PER_TABLE(data) - map_idx_start;
> > +		num_entries = min_t(int, pgcount, max_entries);
> > +		ret = dart_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
> > +		if (!ret && mapped)
> > +			*mapped += num_entries * size;
> > +
> > +		return ret;
> > +	}
> > +
> > +	/* We can't allocate tables at the final level */
> > +	if (WARN_ON(lvl >= DART_MAX_LEVELS - 1))
> > +		return -EINVAL;
> > +
> > +	/* Grab a pointer to the next level */
> > +	pte = READ_ONCE(*ptep);
> > +	if (!pte) {
> > +		cptep = __dart_alloc_pages(tblsz, gfp, cfg);
> > +		if (!cptep)
> > +			return -ENOMEM;
> > +
> > +		pte = dart_install_table(cptep, ptep, 0, data);
> > +		if (pte)
> > +			__dart_free_pages(cptep, tblsz);
> > +	}
> > +
> > +	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
> > +		cptep = iopte_deref(pte, data);
> > +	} else if (pte) {
> > +		/* We require an unmap first */
> > +		WARN_ON(pte);
> 
> Similarly, you can't ever even get here, since the iopte_leaf() above can
> never be true. It would be significantly simpler to swap the two halves of
> this function and lose the recursion. The things you need to do at each
> level - resolve the pgd, look up or allocate the l1 table, install the l2
> pte - have almost no functional overlap, so simple procedural code would be
> far more suitable.

yes, done

> > +		return -EEXIST;
> > +	}
> > +
> > +	/* Rinse, repeat */
> > +	return __dart_map(data, iova, paddr, size, pgcount, prot, lvl + 1,
> > +			      cptep, gfp, mapped);
> > +}
> > +
> > +static dart_iopte dart_prot_to_pte(struct dart_io_pgtable *data,
> > +					   int prot)
> > +{
> > +	dart_iopte pte = 0;
> > +
> > +	if (!(prot & IOMMU_WRITE))
> > +		pte |= APPLE_DART1_PTE_PROT_NO_WRITE;
> > +	if (!(prot & IOMMU_READ))
> > +		pte |= APPLE_DART1_PTE_PROT_NO_READ;
> > +
> > +	return pte;
> > +}
> > +
> > +static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
> > +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> > +			      int iommu_prot, gfp_t gfp, size_t *mapped)
> > +{
> > +	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +	dart_iopte *ptep = data->pgd;
> > +	int ret, lvl = data->start_level;
> > +	dart_iopte prot;
> > +	long iaext = (s64)iova >> cfg->ias;
> 
> Do you have a split address space?

no, removed

> > +	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize))
> 
> Or effectively, "pgsize != cfg->pgsize_bitmap".

done

> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(iaext || paddr >> cfg->oas))
> > +		return -ERANGE;
> > +
> > +	/* If no access, then nothing to do */
> > +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> > +		return 0;
> > +
> > +	prot = dart_prot_to_pte(data, iommu_prot);
> > +	ret = __dart_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
> > +			     ptep, gfp, mapped);
> > +	/*
> > +	 * Synchronise all PTE updates for the new mapping before there's
> > +	 * a chance for anything to kick off a table walk for the new iova.
> > +	 */
> > +	wmb();
> > +
> > +	return ret;
> > +}
> > +
> > +static int dart_map(struct io_pgtable_ops *ops, unsigned long iova,
> > +			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
> > +{
> > +	return dart_map_pages(ops, iova, paddr, size, 1, iommu_prot, gfp,
> > +				  NULL);
> > +}
> 
> There's no user for these wrappers, surely?

I didn't realize those are optional, removed
 
> > +static void __dart_free_pgtable(struct dart_io_pgtable *data, int lvl,
> > +				    dart_iopte *ptep)
> > +{
> > +	dart_iopte *start, *end;
> > +	unsigned long table_size;
> > +
> > +	if (lvl == data->start_level)
> > +		table_size = DART_PGD_SIZE(data);
> > +	else
> > +		table_size = DART_GRANULE(data);
> > +
> > +	start = ptep;
> > +
> > +	/* Only leaf entries at the last level */
> > +	if (lvl == DART_MAX_LEVELS - 1)
> > +		end = ptep;
> > +	else
> > +		end = (void *)ptep + table_size;
> > +
> > +	while (ptep != end) {
> > +		dart_iopte pte = *ptep++;
> > +
> > +		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
> > +			continue;
> > +
> > +		__dart_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> > +	}
> > +
> > +	__dart_free_pages(start, table_size);
> > +}
> > +
> > +static size_t __dart_unmap(struct dart_io_pgtable *data,
> > +			       struct iommu_iotlb_gather *gather,
> > +			       unsigned long iova, size_t size, size_t pgcount,
> > +			       int lvl, dart_iopte *ptep)
> > +{
> > +	dart_iopte pte;
> > +	struct io_pgtable *iop = &data->iop;
> > +	int i = 0, num_entries, max_entries, unmap_idx_start;
> > +
> > +	/* Something went horribly wrong and we ran out of page table */
> > +	if (WARN_ON(lvl == DART_MAX_LEVELS))
> > +		return 0;
> > +
> > +	unmap_idx_start = DART_LVL_IDX(iova, lvl, data);
> > +	ptep += unmap_idx_start;
> > +	pte = READ_ONCE(*ptep);
> > +	if (WARN_ON(!pte))
> > +		return 0;
> > +
> > +	/* If the size matches this level, we're in the right place */
> > +	if (size == DART_BLOCK_SIZE(lvl, data)) {
> > +		max_entries = DART_PTES_PER_TABLE(data) - unmap_idx_start;
> > +		num_entries = min_t(int, pgcount, max_entries);
> > +
> > +		while (i < num_entries) {
> > +			pte = READ_ONCE(*ptep);
> > +			if (WARN_ON(!pte))
> > +				break;
> > +
> > +			/* clear pte */
> > +			*ptep = 0;
> > +
> > +			if (!iopte_leaf(pte, lvl, iop->fmt)) {
> 
> Again, this can't ever happen, and being non-recursive would let you see the
> wood for the trees. I suppose you could in principle still optimise for the
> case of "pgcount == DART_PTES_PER_TABLE" with a slightly different code
> structure, but I highly doubt it's worth the bother.

removed

> > +				/* Also flush any partial walks */
> > +				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
> > +							  DART_GRANULE(data));
> > +				__dart_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> > +			} else if (!iommu_iotlb_gather_queued(gather)) {
> > +				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
> > +			}
> > +
> > +			ptep++;
> > +			i++;
> > +		}
> > +
> > +		return i * size;
> > +	}
> > +
> > +	/* Keep on walkin' */
> > +	ptep = iopte_deref(pte, data);
> > +	return __dart_unmap(data, gather, iova, size, pgcount, lvl + 1, ptep);
> > +}
> > +
> > +static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
> > +				   size_t pgsize, size_t pgcount,
> > +				   struct iommu_iotlb_gather *gather)
> > +{
> > +	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +	dart_iopte *ptep = data->pgd;
> > +	long iaext = (s64)iova >> cfg->ias;
> > +
> > +	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
> > +		return 0;
> > +
> > +	if (WARN_ON(iaext))
> > +		return 0;
> > +
> > +	return __dart_unmap(data, gather, iova, pgsize, pgcount,
> > +				data->start_level, ptep);
> > +}
> > +
> > +static size_t dart_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> > +			     size_t size, struct iommu_iotlb_gather *gather)
> > +{
> > +	return dart_unmap_pages(ops, iova, size, 1, gather);
> > +}
> > +
> > +static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
> > +					 unsigned long iova)
> > +{
> > +	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	dart_iopte pte, *ptep = data->pgd;
> > +	int lvl = data->start_level;
> > +
> > +	do {
> > +		/* Valid IOPTE pointer? */
> > +		if (!ptep)
> > +			return 0;
> > +
> > +		/* Grab the IOPTE we're interested in */
> > +		ptep += DART_LVL_IDX(iova, lvl, data);
> > +		pte = READ_ONCE(*ptep);
> > +
> > +		/* Valid entry? */
> > +		if (!pte)
> > +			return 0;
> > +
> > +		/* Leaf entry? */
> > +		if (iopte_leaf(pte, lvl, data->iop.fmt))
> > +			goto found_translation;
> > +
> > +		/* Take it to the next level */
> > +		ptep = iopte_deref(pte, data);
> > +	} while (++lvl < DART_MAX_LEVELS);
> 
> I imagine the compiler can unroll this loop already, but once again I'd
> argue that it's probably more readable to spell out the pgd and table
> lookups directly. When you have a fixed number of levels to walk, and know
> that you'll never find a valid translation before the last one, life is *so*
> much easier.

Agreed, much easier to follow and a net reduction in code size despite 
the "unrolling"

> > +
> > +	/* Ran out of page tables to walk */
> > +	return 0;
> > +
> > +found_translation:
> > +	iova &= (DART_BLOCK_SIZE(lvl, data) - 1);
> > +	return iopte_to_paddr(pte, data) | iova;
> > +}
> > +
> > +static void dart_restrict_pgsizes(struct io_pgtable_cfg *cfg)
> > +{
> > +	unsigned long granule, page_sizes;
> > +	unsigned int max_addr_bits = 48;
> > +
> > +	/*
> > +	 * We need to restrict the supported page sizes to match the
> > +	 * translation regime for a particular granule. Aim to match
> > +	 * the CPU page size if possible, otherwise prefer smaller sizes.
> > +	 * While we're at it, restrict the block sizes to match the
> > +	 * chosen granule.
> > +	 */
> > +	if (cfg->pgsize_bitmap & PAGE_SIZE)
> > +		granule = PAGE_SIZE;
> > +	else if (cfg->pgsize_bitmap & ~PAGE_MASK)
> > +		granule = 1UL << __fls(cfg->pgsize_bitmap & ~PAGE_MASK);
> > +	else if (cfg->pgsize_bitmap & PAGE_MASK)
> > +		granule = 1UL << __ffs(cfg->pgsize_bitmap & PAGE_MASK);
> > +	else
> > +		granule = 0;
> > +
> > +	switch (granule) {
> > +	case SZ_4K:
> > +		page_sizes = (SZ_4K | SZ_2M | SZ_1G);
> > +		break;
> > +	case SZ_16K:
> > +		page_sizes = (SZ_16K | SZ_32M);
> > +		break;
> > +	default:
> > +		page_sizes = 0;
> > +	}
> > +
> > +	cfg->pgsize_bitmap &= page_sizes;
> > +	cfg->ias = min(cfg->ias, max_addr_bits);
> > +	cfg->oas = min(cfg->oas, max_addr_bits);
> 
> Why is any of this here?
> 
> > +}
> > +
> > +static struct dart_io_pgtable *
> > +dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
> > +{
> > +	struct dart_io_pgtable *data;
> > +	int bits_per_level, levels, va_bits, pg_shift;
> > +
> > +	dart_restrict_pgsizes(cfg);
> > +
> > +	if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K)))
> > +		return NULL;
> > +
> > +	if (cfg->ias > DART_MAX_ADDR_BITS)
> > +		return NULL;
> > +
> > +	if (cfg->oas > DART_MAX_ADDR_BITS)
> > +		return NULL;
> 
> You already checked this in the caller below.
> 
> > +	pg_shift = __ffs(cfg->pgsize_bitmap);
> > +	bits_per_level = pg_shift - ilog2(sizeof(dart_iopte));
> > +
> > +	va_bits = cfg->ias - pg_shift;
> > +	levels = DIV_ROUND_UP(va_bits, bits_per_level);
> > +	if (levels > DART_MAX_LEVELS)
> > +		return NULL;
> > +
> > +	data = kmalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return NULL;
> > +
> > +	data->bits_per_level = bits_per_level;
> > +	data->start_level = DART_MAX_LEVELS - levels;
> > +
> > +	/* Calculate the actual size of our pgd (without concatenation) */
> > +	data->pgd_bits = va_bits - (data->bits_per_level * (levels - 1));
> > +
> > +	data->iop.ops = (struct io_pgtable_ops) {
> > +		.map		= dart_map,
> > +		.map_pages	= dart_map_pages,
> > +		.unmap		= dart_unmap,
> > +		.unmap_pages	= dart_unmap_pages,
> > +		.iova_to_phys	= dart_iova_to_phys,
> > +	};
> > +
> > +	return data;
> > +}
> > +
> > +static struct io_pgtable *
> > +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +	struct dart_io_pgtable *data;
> > +	int i;
> > +
> > +	if (!cfg->coherent_walk)
> > +		return NULL;
> > +
> > +	if (cfg->oas > 36)
> > +		return NULL;
> > +
> > +	data = dart_alloc_pgtable(cfg);
> > +	if (!data)
> > +		return NULL;
> > +
> > +	/*
> > +	 * The table format itself always uses two levels, but the total VA
> > +	 * space is mapped by four separate tables, making the MMIO registers
> > +	 * an effective "level 1". For simplicity, though, we treat this
> > +	 * equivalently to LPAE stage 2 concatenation at level 2, with the
> > +	 * additional TTBRs each just pointing at consecutive pages.
> > +	 */
> > +	if (data->start_level == 0 && data->pgd_bits > 2)
> > +		goto out_free_data;
> > +	if (data->start_level > 0)
> > +		data->pgd_bits = 0;
> > +	data->start_level = 1;
> > +	cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
> > +	data->pgd_bits += data->bits_per_level;
> > +
> > +	data->pgd = __dart_alloc_pages(DART_PGD_SIZE(data), GFP_KERNEL,
> > +					   cfg);
> > +	if (!data->pgd)
> > +		goto out_free_data;
> 
> If recursive map/unmap goes away then you'll also be free to drop the forced
> concatenation and allocate pgds individually, which should then have further
> knock-on simplification effects elsewhere, primarily __dart_free_pgtable() I
> think.

Done although I seemed to have missed the simplification. for 16k iommu 
pages the concatenation should have been never used as a single table 
holds enoough address space. DART in the M2 has only one TTBR. Those two 
additional bits extend the address space for 4k pages to 32-bit.

> 
> Still, for the split from io-pgtable-arm, and with the Kconfig fixed,
> 
> Acked-by: Robin Murphy <rpbin.murphy@arm.com>

thanks

Janne
