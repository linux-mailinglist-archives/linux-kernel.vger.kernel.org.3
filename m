Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA15A8031
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiHaOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiHaOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A96A1A7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661956188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hOKA0J+Gze7ibgR1O0zmGKi7pVRAsasaHfLN6LCL+QE=;
        b=Y1fWmExkpl4Z7N0KO3iQkDrrHzrNLwDe5Nt+ijrj/SkW2IKQSXA1OTHirb/8oQZ0ZVVew+
        wgIGGFIjPtiyt2yxcux0qi+l+tT+lvK7wUjG9epGDfxTXc0Npv0qW6qlMUV4zlBH7GqdLj
        czzoGPG1dbnbNnQXX+PBhwYz+In3Tdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-1E3RyGB2NTuucO9X0r2ygg-1; Wed, 31 Aug 2022 10:29:45 -0400
X-MC-Unique: 1E3RyGB2NTuucO9X0r2ygg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6E8F85A58B;
        Wed, 31 Aug 2022 14:29:44 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C27B640C141D;
        Wed, 31 Aug 2022 14:29:42 +0000 (UTC)
Date:   Wed, 31 Aug 2022 22:29:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ardb@kernel.org,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw8PvF5d2uuWy6Cl@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/22 at 10:37am, Mike Rapoport wrote:
> On Sun, Aug 28, 2022 at 08:55:44AM +0800, Baoquan He wrote:
> > Problem:
> > =======
> > On arm64, block and section mapping is supported to build page tables.
> > However, currently it enforces to take base page mapping for the whole
> > linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> > crashkernel kernel parameter is set. This will cause longer time of the
> > linear mapping process during bootup and severe performance degradation
> > during running time.
> > 
> > Root cause:
> > ==========
> > On arm64, crashkernel reservation relies on knowing the upper limit of
> > low memory zone because it needs to reserve memory in the zone so that
> > devices' DMA addressing in kdump kernel can be satisfied. However, the
> > limit on arm64 is variant. And the upper limit can only be decided late
> > till bootmem_init() is called.
> > 
> > And we need to map the crashkernel region with base page granularity when
> > doing linear mapping, because kdump needs to protect the crashkernel region
> > via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> > support well on splitting the built block or section mapping due to some
> > cpu reststriction [1]. And unfortunately, the linear mapping is done before
> > bootmem_init().
> > 
> > To resolve the above conflict on arm64, the compromise is enforcing to
> > take base page mapping for the entire linear mapping if crashkernel is
> > set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> > performance is sacrificed.
> > 
> > Solution:
> > =========
> > To fix the problem, we should always take 4G as the crashkernel low
> > memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
> > With this, we don't need to defer the crashkernel reservation till
> > bootmem_init() is called to set the arm64_dma_phys_limit. As long as
> > memblock init is done, we can conclude what is the upper limit of low
> > memory zone.
> > 
> > 1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
> >   limit = PHYS_ADDR_MAX+1  (Corner cases)
> 
> Why these are corner cases? 
> The case when CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled is the
> simplest one because it does not require the whole dancing around
> arm64_dma_phys_limit initialization.
> 
> And AFAIK, memblock_start_of_DRAM() > 4G is not uncommon on arm64, but it
> does not matter for device DMA addressing.

Thanks for reviewing.

I could be wrong and have misunderstanding about corner case.

With my understanding, both ZONE_DMA and ZONE_DMA32 are enabled by
default in kernel. And on distros, I believe they are on too. The both
ZONE_DMA and ZONE_DMA32 disabled case should only exist on one specific
product, and the memblock_start_of_DRAM() > 4G case too. At least, I
haven't seen one in our LAB. What I thought the non generic as corner
case could be wrong. I will change that phrasing.

mm/Kconfig:
config ZONE_DMA
        bool "Support DMA zone" if ARCH_HAS_ZONE_DMA_SET
        default y if ARM64 || X86

config ZONE_DMA32
        bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
        depends on !X86_32
        default y if ARM64

> 
> The actual corner cases are systems with ZONE_DMA/DMA32 and with <32 bits
> limit for device DMA addressing (e.g RPi 4). I think the changelog should

Right, RPi4's 30bit DMA addressing device is corner case.

> mention that to use kdump on these devices user must specify
> crashkernel=X@Y 

Makes sense. I will add words in log, and add sentences to
mention that in code comment or some place of document.
Thanks for advice.

> 
> > 2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
> >    limit = 4G  (generic case)
> > 
> > [1]
> > https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/arm64/mm/init.c | 24 ++++++++++++++----------
> >  arch/arm64/mm/mmu.c  | 38 ++++++++++++++++++++++----------------
> >  2 files changed, 36 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index b9af30be813e..8ae55afdd11c 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -90,10 +90,22 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
> >  phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> >  #endif
> 
> Please also update the comment above this hunk.

Sure, will do.

> 
> > +static phys_addr_t __init crash_addr_low_max(void)
> > +{
> > +	phys_addr_t low_mem_mask = U32_MAX;
> > +	phys_addr_t phys_start = memblock_start_of_DRAM();
> > +
> > +	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> > +	     (phys_start > U32_MAX))
> > +		low_mem_mask = PHYS_ADDR_MAX;
> > +
> > +	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;
> 
> Since RAM frequently starts on non-zero address the limit for systems with
> ZONE_DMA/DMA32 should be memblock_start_of_DRAM() + 4G. There is no need to

It may not be right for memblock_start_of_DRAM(). On most of arm64
servers I ever tested, their memblock usually starts from a higher
address, but not zero which is like x86. E.g below memory ranges printed
on an ampere-mtsnow-altra system, the starting addr is 0x83000000. With
my understanding, DMA addressing bits correspond to the cpu logical
address range devices can address. So memblock_start_of_DRAM() + 4G
seems not right for normal system, and not right for system which
starting physical address is above 4G. I refer to max_zone_phys() of
arch/arm64/mm/init.c when implementing crash_addr_low_max(). Please
correct me if I am wrong.

[  +0.000000] Zone ranges:
[  +0.000000]   DMA      [mem 0x0000000088300000-0x00000000ffffffff]
[  +0.000000]   DMA32    empty
[  +0.000000]   Normal   [mem 0x0000000100000000-0x00000817ffffffff]
[  +0.000000]   Device   empty
[  +0.000000] Movable zone start for each node
[  +0.000000] Early memory node ranges
[  +0.000000]   node   0: [mem 0x0000000088300000-0x00000000883fffff]
[  +0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
[  +0.000000]   node   0: [mem 0x0000000092000000-0x0000000093ffffff]
[  +0.000000]   node   0: [mem 0x0000000094000000-0x00000000ebc18fff]
[  +0.000000]   node   0: [mem 0x00000000ebc19000-0x00000000ebfbcfff]
[  +0.000000]   node   0: [mem 0x00000000ebfbd000-0x00000000ebfbdfff]
[  +0.000000]   node   0: [mem 0x00000000ebfbe000-0x00000000ebfbffff]
[  +0.000000]   node   0: [mem 0x00000000ebfc0000-0x00000000ec1dffff]
[  +0.000000]   node   0: [mem 0x00000000ec1e0000-0x00000000ec1effff]
[  +0.000000]   node   0: [mem 0x00000000ec1f0000-0x00000000ee5effff]
[  +0.000000]   node   0: [mem 0x00000000ee5f0000-0x00000000f765ffff]
[  +0.000000]   node   0: [mem 0x00000000f7660000-0x00000000f784ffff]
[  +0.000000]   node   0: [mem 0x00000000f7850000-0x00000000f7fdffff]
[  +0.000000]   node   0: [mem 0x00000000f7fe0000-0x00000000ffc8efff]
[  +0.000000]   node   0: [mem 0x00000000ffc8f000-0x00000000ffc8ffff]
[  +0.000000]   node   0: [mem 0x00000000ffc90000-0x00000000ffffffff]
[  +0.000000]   node   0: [mem 0x0000080000000000-0x000008007fffffff]
[  +0.000000]   node   0: [mem 0x0000080100000000-0x00000817ffffffff]

> take into the account the end of DRAM, memblock allocation will take care
> of that. I'd suggest to simplify crash_addr_low_max() to be
> 
> static phys_addr_t __init crash_addr_low_max(void)
> {
>       if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
>               return memblock_start_of_DRAM() + SZ_4G;
> 
>       return PHYS_ADDR_MAX;
> }
> 
> > +}
> > +
> >  /* Current arm64 boot protocol requires 2MB alignment */
> >  #define CRASH_ALIGN                        SZ_2M
> >  
> > -#define CRASH_ADDR_LOW_MAX         arm64_dma_phys_limit
> > +#define CRASH_ADDR_LOW_MAX         crash_addr_low_max()
> 
> With introduction of crash_addr_low_max() I think it's better to get rid of
> the CRASH_ADDR_LOW_MAX and use local variables in reserve_crashkernel() and
> reserve_crashkernel_low() that would get initialized to
> crash_addr_low_max().

CRASH_ADDR_LOW_MAX is introduced because we expected to make the
crashkernel reservation code generic and move into kernel/crash_core.c.
The original plan is to deduplicate the x86_64 and arm64 part, seems
it's hard to do now since arm64 has specific handling different than
x86. I think we can remove it now and can add it back if possible.

> 
> Besides, #ifdef around arm64_dma_phys_limit declaration can go away because
> this variable will be used only after it is initialized in
> zone_sizes_init().

Right, I will clean it up. Thanks again for careful reviewing.

> 
> >  #define CRASH_ADDR_HIGH_MAX                (PHYS_MASK + 1)
> >  
> >  static int __init reserve_crashkernel_low(unsigned long long low_size)
> > @@ -389,8 +401,7 @@ void __init arm64_memblock_init(void)
> >  
> >     early_init_fdt_scan_reserved_mem();
> >  
> > -   if (!defer_reserve_crashkernel())
> > -           reserve_crashkernel();
> > +   reserve_crashkernel();
> >  
> >     high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >  }
> > @@ -434,13 +445,6 @@ void __init bootmem_init(void)
> >      */
> >     dma_contiguous_reserve(arm64_dma_phys_limit);
> >  
> > -   /*
> > -    * request_standard_resources() depends on crashkernel's memory being
> > -    * reserved, so do it here.
> > -    */
> > -   if (defer_reserve_crashkernel())
> > -           reserve_crashkernel();
> > -
> >     memblock_dump_all();
> >  }
> >  
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index e7ad44585f40..cdd338fa2115 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -547,13 +547,12 @@ static void __init map_mem(pgd_t *pgdp)
> >     memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> >  
> >  #ifdef CONFIG_KEXEC_CORE
> > -   if (crash_mem_map) {
> > -           if (defer_reserve_crashkernel())
> > -                   flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > -           else if (crashk_res.end)
> > -                   memblock_mark_nomap(crashk_res.start,
> > -                       resource_size(&crashk_res));
> > -   }
> > +   if (crashk_res.end)
> > +           memblock_mark_nomap(crashk_res.start,
> > +                               resource_size(&crashk_res));
> > +   if (crashk_low_res.end)
> > +           memblock_mark_nomap(crashk_low_res.start,
> > +                               resource_size(&crashk_low_res));
> >  #endif
> >  
> >     /* map all the memory banks */
> > @@ -589,16 +588,23 @@ static void __init map_mem(pgd_t *pgdp)
> >      * through /sys/kernel/kexec_crash_size interface.
> >      */
> >  #ifdef CONFIG_KEXEC_CORE
> > -   if (crash_mem_map && !defer_reserve_crashkernel()) {
> > -           if (crashk_res.end) {
> > -                   __map_memblock(pgdp, crashk_res.start,
> > -                                  crashk_res.end + 1,
> > -                                  PAGE_KERNEL,
> > -                                  NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > -                   memblock_clear_nomap(crashk_res.start,
> > -                                        resource_size(&crashk_res));
> > -           }
> > +   if (crashk_res.end) {
> > +           __map_memblock(pgdp, crashk_res.start,
> > +                          crashk_res.end + 1,
> > +                          PAGE_KERNEL,
> > +                          NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > +           memblock_clear_nomap(crashk_res.start,
> > +                                resource_size(&crashk_res));
> >     }
> > +
> >  #endif
> >  }
> >  
> > -- 
> > 2.34.1
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

