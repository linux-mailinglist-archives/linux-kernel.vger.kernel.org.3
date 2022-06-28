Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DF55C657
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbiF1LDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbiF1LDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:03:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C91AF01
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A022B81DD2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09003C341CA;
        Tue, 28 Jun 2022 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414187;
        bh=uTdZoZ1skcBJGBohuXIOVKRZtrAs0MBBTX+3FECPSPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTFnpETkyGVGCIM4IT+CvqMTRBxfyUH2ihtD+Z6y8Fzhuz4K6ByL17dn/JqWo8U52
         cnkKJSbGRShN9x+q28qb8+1m77QJFbv3jW+QYoE88uZmQ34rBdSvSZLN26Xvqs+3tQ
         cYVl5Fhu2urVJCiAdyRBsC++ERu6xrPgJOcZygVO/x+neqyExKrH9fDG9FZlQZpnlQ
         lcM6W3Mr7Olw/eiFcb1Iw6w8fAd+Qub5SNLeXBHghqtoR0eltM1t/2O+TAJ2Wy1snX
         YViUPVJ/3BWwr8PTT1a3nX6ZjKV/Xx3yAuq9ED4fBURDkfXglUOus9Ay1UiiqnduEk
         KmS0ChAUYW93A==
Date:   Tue, 28 Jun 2022 12:03:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com, darren@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, xuqiang36@huawei.com
Subject: Re: [PATCH v5] memblock,arm64: Expand the static memblock memory
 table
Message-ID: <20220628110301.GA23703@willie-the-truck>
References: <20220615102742.96450-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615102742.96450-1-zhouguanghui1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:27:42AM +0000, Zhou Guanghui wrote:
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

nit: s/REGTIONS/REGIONS/

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

For the arm64 bit:

Acked-by: Will Deacon <will@kernel.org>

I'm assuming Andrew will pick this up, but please yell if you'd prefer it
to go via the arm64 tree.

Will
