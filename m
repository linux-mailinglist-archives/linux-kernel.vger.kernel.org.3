Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778F58678F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiHAKdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiHAKdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:33:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A21118
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D658EB80FD4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3C1C433B5;
        Mon,  1 Aug 2022 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659350011;
        bh=7VNuXqWG1Sle6OSt3RY+DA2a2NKbYF53VPjLLgimXms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLJRhp0eqHCv7tMGm2X9WR6sWMAG65VxLYJ8fEHe6zVkPcyk1b0u87o/pee93YtHR
         s1aKzza0MHSEvspQkbcTkumxfsoyod0WaRbaCERNfBtk2XX44o596V4IfRtNd9Xh7C
         43UZqh6fUYbXM0WclBSJmyIsrNkUJ9R3CQszhHl16Igyiku1FpwLWxX3AcBchLUTsm
         u3C+j8nszeQLBszA2o6/IKW3RQ7jTdhWz0NVfD3qDRi/AhgNhvjlPMl8vpM1cfWZq9
         v9/WCiZYt6uR1Ucj5T+bSZkSJiCx4p2sQIYC3Cs3ltAO85OoQ8a9qBEItWZTHkOhNy
         QJDM6bqJ41fpg==
Date:   Mon, 1 Aug 2022 13:33:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 4/4] arm64/mm: remap crash kernel with base pages
 even if rodata_full disabled
Message-ID: <Yuer7MtQdoD0kjgr@kernel.org>
References: <20220801080418.120311-1-rppt@kernel.org>
 <20220801080418.120311-5-rppt@kernel.org>
 <CAMj1kXEnbh97TqboonovvfdwA9GJYjfJDMUCa+AxThX2VFUe7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEnbh97TqboonovvfdwA9GJYjfJDMUCa+AxThX2VFUe7A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:22:47PM +0200, Ard Biesheuvel wrote:
> Hello Mike,
> 
> On Mon, 1 Aug 2022 at 10:04, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > For server systems it is important to protect crash kernel memory for
> > post-mortem analysis. In order to protect this memory it should be mapped
> > at PTE level.
> >
> > When CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled, usage of crash kernel
> > essentially forces mapping of the entire linear map with base pages even if
> > rodata_full is not set (commit 2687275a5843 ("arm64: Force
> > NO_BLOCK_MAPPINGS if crashkernel reservation is required")) and this causes
> > performance degradation.
> >
> > With ZONE_DMA/DMA32 enabled, the crash kernel memory is reserved after
> > the linear map is created, but before multiprocessing and multithreading
> > are enabled, so it is safe to remap the crash kernel memory with base
> > pages as long as the page table entries that would be changed do not map
> > the memory that might be accessed during the remapping.
> >
> > To ensure there are no memory accesses in the range that will be
> > remapped, align crash memory reservation to PUD_SIZE boundaries, remap
> > the entire PUD-aligned area and than free the memory that was allocated
> > beyond the crash_size requested by the user.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/mmu.h |  2 ++
> >  arch/arm64/mm/init.c         | 40 ++++++++++++++++++++++++++++++++++--
> >  arch/arm64/mm/mmu.c          | 40 +++++++++++++++++++++++++++++++-----
> >  3 files changed, 75 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 48f8466a4be9..d9829a7def69 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -71,6 +71,8 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> >  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
> >  extern void mark_linear_text_alias_ro(void);
> >  extern bool kaslr_requires_kpti(void);
> > +extern int remap_crashkernel(phys_addr_t start, phys_addr_t size,
> > +                            phys_addr_t aligned_size);
> >
> >  #define INIT_MM_CONTEXT(name)  \
> >         .pgd = init_pg_dir,
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index fa2260040c0f..be74e091bef7 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/memory.h>
> >  #include <asm/numa.h>
> >  #include <asm/sections.h>
> > +#include <asm/set_memory.h>
> >  #include <asm/setup.h>
> >  #include <linux/sizes.h>
> >  #include <asm/tlb.h>
> > @@ -116,6 +117,38 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >         return 0;
> >  }
> >
> > +static unsigned long long __init
> > +reserve_remap_crashkernel(unsigned long long crash_base,
> > +                         unsigned long long crash_size,
> > +                         unsigned long long crash_max)
> > +{
> > +       unsigned long long size;
> > +
> > +       if (!have_zone_dma())
> > +               return 0;
> > +
> > +       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > +               return 0;
> > +
> > +       if (crash_base)
> > +               return 0;
> > +
> > +       size = ALIGN(crash_size, PUD_SIZE);
> > +
> > +       crash_base = memblock_phys_alloc_range(size, PUD_SIZE, 0, crash_max);
> > +       if (!crash_base)
> > +               return 0;
> > +
> > +       if (remap_crashkernel(crash_base, crash_size, size)) {
> > +               memblock_phys_free(crash_base, size);
> > +               return 0;
> > +       }
> > +
> > +       memblock_phys_free(crash_base + crash_size, size - crash_size);
> > +
> > +       return crash_base;
> > +}
> > +
> >  /*
> >   * reserve_crashkernel() - reserves memory for crash kernel
> >   *
> > @@ -162,8 +195,11 @@ static void __init reserve_crashkernel(void)
> >         if (crash_base)
> >                 crash_max = crash_base + crash_size;
> >
> > -       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > -                                              crash_base, crash_max);
> > +       crash_base = reserve_remap_crashkernel(crash_base, crash_size,
> > +                                              crash_max);
> > +       if (!crash_base)
> > +               crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > +                                                      crash_base, crash_max);
> >         if (!crash_base) {
> >                 pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >                         crash_size);
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 2f548fb2244c..183936775fab 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -528,10 +528,8 @@ static void __init map_mem(pgd_t *pgdp)
> >         memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> >
> >  #ifdef CONFIG_KEXEC_CORE
> > -       if (crash_mem_map) {
> > -               if (have_zone_dma())
> > -                       flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > -               else if (crashk_res.end)
> > +       if (crash_mem_map && !have_zone_dma()) {
> > +               if (crashk_res.end)
> >                         memblock_mark_nomap(crashk_res.start,
> >                             resource_size(&crashk_res));
> >         }
> > @@ -825,7 +823,7 @@ int kern_addr_valid(unsigned long addr)
> >         return pfn_valid(pte_pfn(pte));
> >  }
> >
> > -#ifdef CONFIG_MEMORY_HOTPLUG
> > +#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_KEXEC_CORE)
> >  static void free_hotplug_page_range(struct page *page, size_t size,
> >                                     struct vmem_altmap *altmap)
> >  {
> > @@ -968,7 +966,9 @@ static void unmap_range(unsigned long addr, unsigned long end,
> >                 unmap_p4d_range(pgdp, addr, next, free_mapped, altmap);
> >         } while (addr = next, addr < end);
> >  }
> > +#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_KEXEC_CORE  */
> >
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> >  static bool pgtable_range_aligned(unsigned long start, unsigned long end,
> >                                   unsigned long floor, unsigned long ceiling,
> >                                   unsigned long mask)
> > @@ -1213,6 +1213,36 @@ void vmemmap_free(unsigned long start, unsigned long end,
> >  }
> >  #endif /* CONFIG_MEMORY_HOTPLUG */
> >
> > +int __init remap_crashkernel(phys_addr_t start, phys_addr_t size,
> > +                            phys_addr_t aligned_size)
> > +{
> > +#ifdef CONFIG_KEXEC_CORE
> > +       phys_addr_t end = start + size;
> > +       phys_addr_t aligned_end = start + aligned_size;
> > +
> > +       if (!IS_ALIGNED(start, PUD_SIZE) || !IS_ALIGNED(aligned_end, PUD_SIZE))
> > +               return -EINVAL;
> > +
> > +       /* Clear PUDs containing crash kernel memory */
> > +       unmap_range(__phys_to_virt(start), __phys_to_virt(aligned_end),
> > +                   false, NULL);
> > +
> 
> Why is this safe? This runs after paging_init(), so you are unmapping
> a PUD that is live, and could already be in use, no?

The allocation request for crash kernel is extended to fill the entire PUD
and it is PUD-aligned, so if memblock_phys_alloc() in
reserve_remap_crashkernel() succeeds, the memory returned by it would be
mapped by one ore PUDs and these PUDs will only map that memory.

Since there is no multitasking yet, there is nothing that can access that
memory.
 
> > +       /* map crash kernel memory with base pages */
> > +       __create_pgd_mapping(swapper_pg_dir, start,  __phys_to_virt(start),
> > +                            size, PAGE_KERNEL, early_pgtable_alloc,
> > +                            NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS |
> > +                            NO_CONT_MAPPINGS);
> > +
> > +       /* map area from end of crash kernel to PUD end with large pages */
> > +       size = aligned_end - end;
> > +       if (size)
> > +               __create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
> > +                                    size, PAGE_KERNEL, early_pgtable_alloc, 0);
> > +#endif
> > +
> > +       return 0;
> > +}
> > +
> >  static inline pud_t *fixmap_pud(unsigned long addr)
> >  {
> >         pgd_t *pgdp = pgd_offset_k(addr);
> > --
> > 2.35.3
> >

-- 
Sincerely yours,
Mike.
