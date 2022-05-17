Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4952A1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbiEQMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbiEQMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:38:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C94BFED
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE743B81850
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64FDC34116;
        Tue, 17 May 2022 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652791133;
        bh=tIADpdIqk/DMHwcrZqTQGsZAeC349U8CBKJCjIVM5dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btPwkau7QMRA+HilFb4hUFG6cyGAtCxMljQc+M7QoUEXh5w/hyIieehwdcm7pW3ln
         EXri19VAxaPwckkjmocMpmxkQ5Jkv0k8RTEtGUZ/UtOY6qVC7dSTAnJoiaOuQUebdL
         fS77N0/7stR2m3o7HaNxBEv97CDDbl5yq3GqcYgLuUtYwndQwraf2HI8HNmb8nOFYZ
         cOSCaLLbfBc4wIb+BZA1CQM20BhA3p8yQZqH09lYTWpDm3saelhuiUEbCLwWTW/Bnd
         VAhZWvcKfpnTTX5n/8UGQ3y8Mazh0xS/FJaMvIz/tNza1Ha9Q+roJn9zm0b4Je2mdb
         Jv9xhdT081I5g==
Date:   Tue, 17 May 2022 15:38:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     akpm@linux-foundation.org, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, xuqiang36@huawei.com
Subject: Re: [PATCH v2] arm64: Expand the static memblock memory table
Message-ID: <YoOXVdjkj8nnUHn6@kernel.org>
References: <20220517114309.10228-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517114309.10228-1-zhouguanghui1@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 17, 2022 at 11:43:09AM +0000, Zhou Guanghui wrote:
> In a system using HBM, a multi-bit ECC error occurs, and the BIOS
> saves the corresponding area (for example, 2 MB). When the system
> restarts next time, these areas are isolated and not reported or
> reported as EFI_UNUSABLE_MEMORY. Both of them lead to an increase
> in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads to
> a larger number of memblocks.

I'd slightly rephrase the description here:

In a system using HBM, a multi-bit ECC error may occur, and the BIOS will
mark the corresponding area (for example, 2 MB)i as unusable.  When the
system restarts next time, these areas are not reported or reported as
EFI_UNUSABLE_MEMORY. Both cases lead to an increase in the number of
memblocks, whereas EFI_UNUSABLE_MEMORY leads to a larger number of
memblocks.
 
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
> If the size of the init memblock regions is exceeded before the
> array size can be resized, the excess memory will be lost.

And here I'd make it something like:

The EFI memory map is parsed to construct the memblock arrays before the
memblock arrays can be resized. As the result, memory regions beyond
INIT_MEMBLOCK_REGIONS are lost.

Allow overriding memblock.memory array size with architecture defined
INIT_MEMBLOCK_MEMORY_REGIONS and make arm64 to set
INIT_MEMBLOCK_MEMORY_REGIONS to 1024 when CONFIG_EFI is enabled.

> 
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

With changelog updates along those lines

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm64/include/asm/memory.h |  9 +++++++++
>  mm/memblock.c                   | 14 +++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0af70d9abede..eda61c0389c4 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -364,6 +364,15 @@ void dump_mem_limit(void);
>  # define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
>  #endif
>  
> +/*
> + * memory regions which marked with flag MEMBLOCK_NOMAP may divide a continuous
> + * memory block into multiple parts. As a result, the number of memory regions
> + * is large.
> + */
> +#ifdef CONFIG_EFI
> +#define INIT_MEMBLOCK_MEMORY_REGIONS	1024
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
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
