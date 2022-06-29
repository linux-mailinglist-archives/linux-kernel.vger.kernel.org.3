Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE155F3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiF2DIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF2DIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:08:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9EE1101E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:08:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D9B152B;
        Tue, 28 Jun 2022 20:08:47 -0700 (PDT)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBA83F5A1;
        Tue, 28 Jun 2022 20:08:43 -0700 (PDT)
Message-ID: <1a29ad01-92b0-ed4f-55d6-f2a94d610ab1@arm.com>
Date:   Wed, 29 Jun 2022 08:38:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] memblock,arm64: Expand the static memblock memory
 table
Content-Language: en-US
To:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        akpm@linux-foundation.org, rppt@kernel.org, will@kernel.org,
        darren@os.amperecomputing.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, xuqiang36@huawei.com
References: <20220615102742.96450-1-zhouguanghui1@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220615102742.96450-1-zhouguanghui1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/22 15:57, Zhou Guanghui wrote:
> In a system(Huawei Ascend ARM64 SoC) using HBM, a multi-bit ECC error
> occurs, and the BIOS will mark the corresponding area (for example, 2 MB)
> as unusable. When the system restarts next time, these areas are not
> reported or reported as EFI_UNUSABLE_MEMORY. Both cases lead to an
> increase in the number of memblocks, whereas EFI_UNUSABLE_MEMORY
> leads to a larger number of memblocks.
> 
> For example, if the EFI_UNUSABLE_MEMORY type is reported:
> ...
> memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 0x0000000000a00000 bytes on node 7 flags: 0x0
> memory[0x95]    [0x0000200836800000-0x00002008369fffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 0x0000000048200000 bytes on node 7 flags: 0x0
> memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 0x0000000350000000 bytes on node 6 flags: 0x0
> memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 0x0000000000600000 bytes on node 6 flags: 0x0
> memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 0x00000003ff600000 bytes on node 6 flags: 0x0
> memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 0x000000002fe00000 bytes on node 6 flags: 0x0
> ...
> 
> The EFI memory map is parsed to construct the memblock arrays before
> the memblock arrays can be resized. As the result, memory regions
> beyond INIT_MEMBLOCK_REGIONS are lost.
> 
> Add a new macro INIT_MEMBLOCK_MEMORY_REGTIONS to replace
> INIT_MEMBLOCK_REGTIONS to define the size of the static memblock.memory
> array.
> 
> Allow overriding memblock.memory array size with architecture defined
> INIT_MEMBLOCK_MEMORY_REGIONS and make arm64 to set
> INIT_MEMBLOCK_MEMORY_REGIONS to 1024 when CONFIG_EFI is enabled.
> 
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Darren Hart <darren@os.amperecomputing.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/memory.h |  9 +++++++++
>  mm/memblock.c                   | 14 +++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0af70d9abede..ce8614fa376a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -364,6 +364,15 @@ void dump_mem_limit(void);
>  # define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
>  #endif
>  
> +/*
> + * memory regions which marked with flag MEMBLOCK_NOMAP(for example, the memory
> + * of the EFI_UNUSABLE_MEMORY type) may divide a continuous memory block into
> + * multiple parts. As a result, the number of memory regions is large.
> + */
> +#ifdef CONFIG_EFI
> +#define INIT_MEMBLOCK_MEMORY_REGIONS	(INIT_MEMBLOCK_REGIONS * 8)
> +#endif
> +
>  #include <asm-generic/memory_model.h>
>  
>  #endif /* __ASM_MEMORY_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8e56..7c63571a69d7 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -29,6 +29,10 @@
>  # define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>  #endif
>  
> +#ifndef INIT_MEMBLOCK_MEMORY_REGIONS
> +#define INIT_MEMBLOCK_MEMORY_REGIONS		INIT_MEMBLOCK_REGIONS
> +#endif
> +
>  /**
>   * DOC: memblock overview
>   *
> @@ -55,9 +59,9 @@
>   * the allocator metadata. The "memory" and "reserved" types are nicely
>   * wrapped with struct memblock. This structure is statically
>   * initialized at build time. The region arrays are initially sized to
> - * %INIT_MEMBLOCK_REGIONS for "memory" and %INIT_MEMBLOCK_RESERVED_REGIONS
> - * for "reserved". The region array for "physmem" is initially sized to
> - * %INIT_PHYSMEM_REGIONS.
> + * %INIT_MEMBLOCK_MEMORY_REGIONS for "memory" and
> + * %INIT_MEMBLOCK_RESERVED_REGIONS for "reserved". The region array
> + * for "physmem" is initially sized to %INIT_PHYSMEM_REGIONS.
>   * The memblock_allow_resize() enables automatic resizing of the region
>   * arrays during addition of new regions. This feature should be used
>   * with care so that memory allocated for the region array will not
> @@ -102,7 +106,7 @@ unsigned long min_low_pfn;
>  unsigned long max_pfn;
>  unsigned long long max_possible_pfn;
>  
> -static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
> +static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_MEMORY_REGIONS] __initdata_memblock;
>  static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>  static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS];
> @@ -111,7 +115,7 @@ static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS
>  struct memblock memblock __initdata_memblock = {
>  	.memory.regions		= memblock_memory_init_regions,
>  	.memory.cnt		= 1,	/* empty dummy entry */
> -	.memory.max		= INIT_MEMBLOCK_REGIONS,
> +	.memory.max		= INIT_MEMBLOCK_MEMORY_REGIONS,
>  	.memory.name		= "memory",
>  
>  	.reserved.regions	= memblock_reserved_init_regions,
