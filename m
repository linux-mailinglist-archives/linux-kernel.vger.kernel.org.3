Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E801A54835B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiFMJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiFMJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C001114F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8507E61380
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDE2C341CC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655113118;
        bh=M/Tq8yOehWGxB0zCTsA6p0ek349s6TsEfOU83FCzIbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDQ1BUCdME5iFKrmtnyOAacZcjjjRJ+TTrUgkaCVsABZYaWIaJJ78QPhjO6DEGyRv
         /Mo4t8cTTwgRHuQJ4KTem1Ev7GydLXlrLqE2Qd9JYCvWc51YlsyIhrUP7BV6uiBUvM
         KCI09b7iyVO15JLStE8ctcIk4UpCMIrujqFSgMm3Fk43Bqk+n0uX/XEa8/WB7GZAt3
         DZunPbj93Of8I+9bl3+rVlULXrRYbRABqRq/fGDlg15Iwok5ifV1/Vm5MrS+Mcq83P
         /tZGC0QBMXBf8zLj8y/FCn+F1sYVKUrllSxTdeuFtYqcoT5P+E0zA9eIiLjQMP1OwY
         fyrhEpnyNZvkA==
Received: by mail-ot1-f46.google.com with SMTP id a8-20020a05683012c800b0060c027c8afdso3990344otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:38:38 -0700 (PDT)
X-Gm-Message-State: AOAM530wmmTW6J3cOnq20LxdeYcwDIS20JFYoLUkp698aKLslGwCafJ8
        H4/ti28QeDQAyUJbhbqRH6U4Klh20/ECJxcl4oY=
X-Google-Smtp-Source: ABdhPJzMOh9FiBRHo6qHs+aiQIFQXtCW4weZ/HjuRniSyVIfzscVKyqlpBln6BDOP3U3vRyYiMRnr09V9GiRHXa4q+0=
X-Received: by 2002:a9d:37a3:0:b0:60c:5427:1f56 with SMTP id
 x32-20020a9d37a3000000b0060c54271f56mr3095599otb.71.1655113117976; Mon, 13
 Jun 2022 02:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220613091901.730-1-thunder.leizhen@huawei.com>
In-Reply-To: <20220613091901.730-1-thunder.leizhen@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 11:38:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGgH2DpvQ_jRfMG5hSOxiqOqYHqThp_eqk-Yuhe=2dAjA@mail.gmail.com>
Message-ID: <CAMj1kXGgH2DpvQ_jRfMG5hSOxiqOqYHqThp_eqk-Yuhe=2dAjA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Mark the FDT_FIXED sections as shareable
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 at 11:19, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> commit 7a1be318f579 ("ARM: 9012/1: move device tree mapping out of linear
> region") use FDT_FIXED_BASE to map the whole FDT_FIXED_SIZE memory area
> which contains fdt. But it only reserves the exact physical memory that
> fdt occupied. Unfortunately, this mapping is non-shareable. An illegal or
> speculative read access can bring the RAM content from non-fdt zone into
> cache, PIPT makes it to be hit by subsequently read access through
> shareable mapping(such as linear mapping), and the cache consistency
> between cores is lost due to non-shareable property.
>
> |<---------FDT_FIXED_SIZE------>|
> |                               |
>  -------------------------------
> | <non-fdt> | <fdt> | <non-fdt> |
>  -------------------------------
>
> 1. CoreA read <non-fdt> through MT_ROM mapping, the old data is loaded
>    into the cache.
> 2. CoreB write <non-fdt> to update data through linear mapping. CoreA
>    received the notification to invalid the corresponding cachelines, but
>    the property non-shareable makes it to be ignored.
> 3. CoreA read <non-fdt> through linear mapping, cache hit, the old data
>    is read.
>
> To eliminate this risk, add a new memory type MT_MEMORY_RO. Compared to
> MT_ROM, it is shareable and non-executable.
>
> Here's an example:
>   list_del corruption. prev->next should be c0ecbf74, but was c08410dc
>   kernel BUG at lib/list_debug.c:53!
>   ... ...
>   PC is at __list_del_entry_valid+0x58/0x98
>   LR is at __list_del_entry_valid+0x58/0x98
>   psr: 60000093
>   sp : c0ecbf30  ip : 00000000  fp : 00000001
>   r10: c08410d0  r9 : 00000001  r8 : c0825e0c
>   r7 : 20000013  r6 : c08410d0  r5 : c0ecbf74  r4 : c0ecbf74
>   r3 : c0825d08  r2 : 00000000  r1 : df7ce6f4  r0 : 00000044
>   ... ...
>   Stack: (0xc0ecbf30 to 0xc0ecc000)
>   bf20:                                     c0ecbf74 c0164fd0 c0ecbf70 c0165170
>   bf40: c0eca000 c0840c00 c0840c00 c0824500 c0825e0c c0189bbc c088f404 60000013
>   bf60: 60000013 c0e85100 000004ec 00000000 c0ebcdc0 c0ecbf74 c0ecbf74 c0825d08
>   ... ...                                           <  next     prev  >
>   (__list_del_entry_valid) from (__list_del_entry+0xc/0x20)
>   (__list_del_entry) from (finish_swait+0x60/0x7c)
>   (finish_swait) from (rcu_gp_kthread+0x560/0xa20)
>   (rcu_gp_kthread) from (kthread+0x14c/0x15c)
>   (kthread) from (ret_from_fork+0x14/0x24)
>
> The faulty list node to be deleted is a local variable, its address is
> c0ecbf74. The dumped stack shows that 'prev' = c0ecbf74, but its value
> before lib/list_debug.c:53 is c08410dc. A large amount of printing results
> in swapping out the cacheline containing the old data(MT_ROM mapping is
> read only, so the cacheline cannot be dirty), and the subsequent dump
> operation obtains new data from the DDR.
>
> Fixes: 7a1be318f579 ("ARM: 9012/1: move device tree mapping out of linear region")
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Please put this in Russell's patch tracker

As I indicated in my reply to v1, we still need to reduce the the size
of the mapping as well: the non-fdt surplus might cover physical pages
that are NOMAP or mapped with different attributes, and so having a
cacheable, shareable alias could potentially be problematic as well.

I'll propose a patch for that once this lands.

Thanks,


> ---
>  arch/arm/include/asm/mach/map.h |  1 +
>  arch/arm/mm/mmu.c               | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> v1 --> v2:
> As Ard Biesheuvel's suggestion, add a new memory type MT_MEMORY_RO instead of
> add a new memory type MT_ROM_XIP.
>
> diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
> index 92282558caf7cdb..2b8970d8e5a2ff8 100644
> --- a/arch/arm/include/asm/mach/map.h
> +++ b/arch/arm/include/asm/mach/map.h
> @@ -27,6 +27,7 @@ enum {
>         MT_HIGH_VECTORS,
>         MT_MEMORY_RWX,
>         MT_MEMORY_RW,
> +       MT_MEMORY_RO,
>         MT_ROM,
>         MT_MEMORY_RWX_NONCACHED,
>         MT_MEMORY_RW_DTCM,
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 5e2be37a198e29e..cd17e324aa51ea6 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -296,6 +296,13 @@ static struct mem_type mem_types[] __ro_after_init = {
>                 .prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
>                 .domain    = DOMAIN_KERNEL,
>         },
> +       [MT_MEMORY_RO] = {
> +               .prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> +                            L_PTE_XN | L_PTE_RDONLY,
> +               .prot_l1   = PMD_TYPE_TABLE,
> +               .prot_sect = PMD_TYPE_SECT,
> +               .domain    = DOMAIN_KERNEL,
> +       },
>         [MT_ROM] = {
>                 .prot_sect = PMD_TYPE_SECT,
>                 .domain    = DOMAIN_KERNEL,
> @@ -489,6 +496,7 @@ static void __init build_mem_type_table(void)
>
>                         /* Also setup NX memory mapping */
>                         mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_XN;
> +                       mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_XN;
>                 }
>                 if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
>                         /*
> @@ -568,6 +576,7 @@ static void __init build_mem_type_table(void)
>                 mem_types[MT_ROM].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
>                 mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
>                 mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
> +               mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
>  #endif
>
>                 /*
> @@ -587,6 +596,8 @@ static void __init build_mem_type_table(void)
>                         mem_types[MT_MEMORY_RWX].prot_pte |= L_PTE_SHARED;
>                         mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_S;
>                         mem_types[MT_MEMORY_RW].prot_pte |= L_PTE_SHARED;
> +                       mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_S;
> +                       mem_types[MT_MEMORY_RO].prot_pte |= L_PTE_SHARED;
>                         mem_types[MT_MEMORY_DMA_READY].prot_pte |= L_PTE_SHARED;
>                         mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= PMD_SECT_S;
>                         mem_types[MT_MEMORY_RWX_NONCACHED].prot_pte |= L_PTE_SHARED;
> @@ -647,6 +658,8 @@ static void __init build_mem_type_table(void)
>         mem_types[MT_MEMORY_RWX].prot_pte |= kern_pgprot;
>         mem_types[MT_MEMORY_RW].prot_sect |= ecc_mask | cp->pmd;
>         mem_types[MT_MEMORY_RW].prot_pte |= kern_pgprot;
> +       mem_types[MT_MEMORY_RO].prot_sect |= ecc_mask | cp->pmd;
> +       mem_types[MT_MEMORY_RO].prot_pte |= kern_pgprot;
>         mem_types[MT_MEMORY_DMA_READY].prot_pte |= kern_pgprot;
>         mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= ecc_mask;
>         mem_types[MT_ROM].prot_sect |= cp->pmd;
> @@ -1360,7 +1373,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
>                 map.pfn = __phys_to_pfn(__atags_pointer & SECTION_MASK);
>                 map.virtual = FDT_FIXED_BASE;
>                 map.length = FDT_FIXED_SIZE;
> -               map.type = MT_ROM;
> +               map.type = MT_MEMORY_RO;
>                 create_mapping(&map);
>         }
>
> --
> 2.25.1
>
