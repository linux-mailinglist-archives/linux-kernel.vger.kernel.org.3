Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500B0586750
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHAKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHAKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B402FA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0111EB80D10
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8124BC433D7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659349379;
        bh=BKSwx8U9PR4e6nnOIm0TTEnFV2vlK4evNQ/1mSNAFgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jW4bhD5gmC+Or3otls/hkPIm/frA2eq+jLojjdxmjGFNfFd5CtJOpay9zJU5BewiA
         OZ7JJBfVaSp4Czuw9C8NVRhHN2RWI1IktQTIBkLVhAbuvS37mHZ8ZmzCOJxTIi0xPf
         H6VokfFqC7qdHoss6jKxgz6ACm+vJQipFSiK7QBmTGE3Z1Z5Y1UbL928Npz+flMZ5d
         RtRmE6hSsbxTOolXos+1JcZw+8Vo73D2Oh6sC7LrOztNf5uGuKMHNGoWWTKyucJk3U
         vasfbQ8NbBL67Lg5XUFHjf9bbe9qYtLV4heNtqXnkhKVMRvUG6vJB/98EYoU7i2CL+
         bsTNIKEhutyDA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-10ea30a098bso8247324fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:22:59 -0700 (PDT)
X-Gm-Message-State: AJIora+h+ieOoqUqdOdOuIYH7aG+AMV66a3eQ8lVQfeDLbCVSPL8qEBb
        zV9I7RCCzwOr3UMx+k5qevUldbzrQHcNnSs7wHM=
X-Google-Smtp-Source: AGRyM1vgymiJoukjtU+XQTjgJUJcvyKqvQSbqn4sigV2EmQ+KbgnEKZjjZJfoQCbM0gVO2MKvmng78t7BxdH/ex008M=
X-Received: by 2002:a05:6870:b403:b0:10e:7914:adb with SMTP id
 x3-20020a056870b40300b0010e79140adbmr7027705oap.126.1659349378540; Mon, 01
 Aug 2022 03:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220801080418.120311-1-rppt@kernel.org> <20220801080418.120311-5-rppt@kernel.org>
In-Reply-To: <20220801080418.120311-5-rppt@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Aug 2022 12:22:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEnbh97TqboonovvfdwA9GJYjfJDMUCa+AxThX2VFUe7A@mail.gmail.com>
Message-ID: <CAMj1kXEnbh97TqboonovvfdwA9GJYjfJDMUCa+AxThX2VFUe7A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] arm64/mm: remap crash kernel with base pages even
 if rodata_full disabled
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Mon, 1 Aug 2022 at 10:04, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> For server systems it is important to protect crash kernel memory for
> post-mortem analysis. In order to protect this memory it should be mapped
> at PTE level.
>
> When CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled, usage of crash kernel
> essentially forces mapping of the entire linear map with base pages even if
> rodata_full is not set (commit 2687275a5843 ("arm64: Force
> NO_BLOCK_MAPPINGS if crashkernel reservation is required")) and this causes
> performance degradation.
>
> With ZONE_DMA/DMA32 enabled, the crash kernel memory is reserved after
> the linear map is created, but before multiprocessing and multithreading
> are enabled, so it is safe to remap the crash kernel memory with base
> pages as long as the page table entries that would be changed do not map
> the memory that might be accessed during the remapping.
>
> To ensure there are no memory accesses in the range that will be
> remapped, align crash memory reservation to PUD_SIZE boundaries, remap
> the entire PUD-aligned area and than free the memory that was allocated
> beyond the crash_size requested by the user.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/mmu.h |  2 ++
>  arch/arm64/mm/init.c         | 40 ++++++++++++++++++++++++++++++++++--
>  arch/arm64/mm/mmu.c          | 40 +++++++++++++++++++++++++++++++-----
>  3 files changed, 75 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 48f8466a4be9..d9829a7def69 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -71,6 +71,8 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>  extern void mark_linear_text_alias_ro(void);
>  extern bool kaslr_requires_kpti(void);
> +extern int remap_crashkernel(phys_addr_t start, phys_addr_t size,
> +                            phys_addr_t aligned_size);
>
>  #define INIT_MM_CONTEXT(name)  \
>         .pgd = init_pg_dir,
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index fa2260040c0f..be74e091bef7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -40,6 +40,7 @@
>  #include <asm/memory.h>
>  #include <asm/numa.h>
>  #include <asm/sections.h>
> +#include <asm/set_memory.h>
>  #include <asm/setup.h>
>  #include <linux/sizes.h>
>  #include <asm/tlb.h>
> @@ -116,6 +117,38 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>         return 0;
>  }
>
> +static unsigned long long __init
> +reserve_remap_crashkernel(unsigned long long crash_base,
> +                         unsigned long long crash_size,
> +                         unsigned long long crash_max)
> +{
> +       unsigned long long size;
> +
> +       if (!have_zone_dma())
> +               return 0;
> +
> +       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +               return 0;
> +
> +       if (crash_base)
> +               return 0;
> +
> +       size = ALIGN(crash_size, PUD_SIZE);
> +
> +       crash_base = memblock_phys_alloc_range(size, PUD_SIZE, 0, crash_max);
> +       if (!crash_base)
> +               return 0;
> +
> +       if (remap_crashkernel(crash_base, crash_size, size)) {
> +               memblock_phys_free(crash_base, size);
> +               return 0;
> +       }
> +
> +       memblock_phys_free(crash_base + crash_size, size - crash_size);
> +
> +       return crash_base;
> +}
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -162,8 +195,11 @@ static void __init reserve_crashkernel(void)
>         if (crash_base)
>                 crash_max = crash_base + crash_size;
>
> -       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -                                              crash_base, crash_max);
> +       crash_base = reserve_remap_crashkernel(crash_base, crash_size,
> +                                              crash_max);
> +       if (!crash_base)
> +               crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> +                                                      crash_base, crash_max);
>         if (!crash_base) {
>                 pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>                         crash_size);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2f548fb2244c..183936775fab 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -528,10 +528,8 @@ static void __init map_mem(pgd_t *pgdp)
>         memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>
>  #ifdef CONFIG_KEXEC_CORE
> -       if (crash_mem_map) {
> -               if (have_zone_dma())
> -                       flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -               else if (crashk_res.end)
> +       if (crash_mem_map && !have_zone_dma()) {
> +               if (crashk_res.end)
>                         memblock_mark_nomap(crashk_res.start,
>                             resource_size(&crashk_res));
>         }
> @@ -825,7 +823,7 @@ int kern_addr_valid(unsigned long addr)
>         return pfn_valid(pte_pfn(pte));
>  }
>
> -#ifdef CONFIG_MEMORY_HOTPLUG
> +#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_KEXEC_CORE)
>  static void free_hotplug_page_range(struct page *page, size_t size,
>                                     struct vmem_altmap *altmap)
>  {
> @@ -968,7 +966,9 @@ static void unmap_range(unsigned long addr, unsigned long end,
>                 unmap_p4d_range(pgdp, addr, next, free_mapped, altmap);
>         } while (addr = next, addr < end);
>  }
> +#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_KEXEC_CORE  */
>
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static bool pgtable_range_aligned(unsigned long start, unsigned long end,
>                                   unsigned long floor, unsigned long ceiling,
>                                   unsigned long mask)
> @@ -1213,6 +1213,36 @@ void vmemmap_free(unsigned long start, unsigned long end,
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>
> +int __init remap_crashkernel(phys_addr_t start, phys_addr_t size,
> +                            phys_addr_t aligned_size)
> +{
> +#ifdef CONFIG_KEXEC_CORE
> +       phys_addr_t end = start + size;
> +       phys_addr_t aligned_end = start + aligned_size;
> +
> +       if (!IS_ALIGNED(start, PUD_SIZE) || !IS_ALIGNED(aligned_end, PUD_SIZE))
> +               return -EINVAL;
> +
> +       /* Clear PUDs containing crash kernel memory */
> +       unmap_range(__phys_to_virt(start), __phys_to_virt(aligned_end),
> +                   false, NULL);
> +

Why is this safe? This runs after paging_init(), so you are unmapping
a PUD that is live, and could already be in use, no?

> +       /* map crash kernel memory with base pages */
> +       __create_pgd_mapping(swapper_pg_dir, start,  __phys_to_virt(start),
> +                            size, PAGE_KERNEL, early_pgtable_alloc,
> +                            NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS |
> +                            NO_CONT_MAPPINGS);
> +
> +       /* map area from end of crash kernel to PUD end with large pages */
> +       size = aligned_end - end;
> +       if (size)
> +               __create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
> +                                    size, PAGE_KERNEL, early_pgtable_alloc, 0);
> +#endif
> +
> +       return 0;
> +}
> +
>  static inline pud_t *fixmap_pud(unsigned long addr)
>  {
>         pgd_t *pgdp = pgd_offset_k(addr);
> --
> 2.35.3
>
