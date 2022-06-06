Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24053E769
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiFFPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbiFFPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:52:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7B1C107
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48779B81A9A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9A0C3411F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654530737;
        bh=JNfglN4TZ3Ga1Y1j0CLkEDe16Ldfqa9ttWOItunPbUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SYio+eGswoGQ4mrY9dqr97kx2Td1NOZmRCjScSqZYm4LOJLuHtXUIZ1FKnOja4t0w
         k+wehzT3SWE2wiiXRRbvNHxLinm8jGLyR63bD/F3aonIfTXulYrX39zrZr0s6ESGUH
         imKawooNO6H7A72aEbLU+1owpUXjQrPv9ADY5GPf0sgh80gsY7oT0l9Hsu7vX84qz3
         zsU+0QWPLOqoe065U7Noo60Q7JGE0QFFIg1VL58omMAq84DlyetT3uvw9e4fPZLZSP
         BquU2f/9diHMSWVJwskB1Pj/b408PjVOCBXI2lxsxaO+zxG5FPMB1gg0Y0UrQkRKa7
         bAU4C0q2Sur9Q==
Received: by mail-oi1-f176.google.com with SMTP id l81so4765574oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:52:16 -0700 (PDT)
X-Gm-Message-State: AOAM5332by9HvYuMzOMlDQCPHo8xNWGb1q1iXCgHKkaZrzTW3mO8BEYL
        Fg7CPmDs8iYzD23loqk8RrHtEbiXeXBQR0JYXaU=
X-Google-Smtp-Source: ABdhPJz04RHdaSFXcfSoyEUmK0UdSU80QU/wwjDu5bmHIX97jOhEuyA77XUZcZb4P6LXzByuaQ7qj/YeQde3+veqgZo=
X-Received: by 2002:a05:6808:f88:b0:32b:d10f:cc6b with SMTP id
 o8-20020a0568080f8800b0032bd10fcc6bmr29207384oiw.228.1654530736144; Mon, 06
 Jun 2022 08:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220606124858.384-1-thunder.leizhen@huawei.com>
In-Reply-To: <20220606124858.384-1-thunder.leizhen@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Jun 2022 17:52:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCbCnV6FGTq2pBosqBTVv3B8WpNnOuiV0eSgvBMO-+8A@mail.gmail.com>
Message-ID: <CAMj1kXGCbCnV6FGTq2pBosqBTVv3B8WpNnOuiV0eSgvBMO-+8A@mail.gmail.com>
Subject: Re: [PATCH] ARM: Mark the FDT_FIXED sections as shareable
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

Hello Zhen Lei,

On Mon, 6 Jun 2022 at 14:49, Zhen Lei <thunder.leizhen@huawei.com> wrote:
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

Thanks for the excellent write-up, and for what must have been a lot
of work to narrow down and diagnose!

> To eliminate this risk, mark the MT_ROM sections as shareable.
>
> The other user of MT_ROM is XIP_KERNEL. XIP allows the kernel to run from
> flash to save RAM space. Not sure if anyone is still using XIP in order to
> save a little memory and not care about performance degradation. Add a new
> memory type MT_ROM_XIP to be compatible with it.
>
> BTW: Another solution is to memblock_reserve() all the sections that fdt
> spans, but this will waste 2-4MiB memory.
>

I agree that we should not add shareable attributes to the memory type
used by XIP kernels for code regions: NOR flash is not usually
integrated in a way that allows it to participate in the coherency
protocol, so that will likely break things.

I think, though, that it would be better to leave MT_ROM alone, and
introduce a new type MT_MEMORY_RO instead, which is wired up in the
right way (see below), so that we get NX attributes, and can use it to
create non-section mappings as well.

Then, as a followup which does not need to go into -stable, we can
reduce the size of the mapping: there is really no need for the
permanent mapping to be section granular - this is only for the early
asm code that is not able to create 2 levels of page tables.


--------------->8-----------------
diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 92282558caf7..2b8970d8e5a2 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -27,6 +27,7 @@ enum {
        MT_HIGH_VECTORS,
        MT_MEMORY_RWX,
        MT_MEMORY_RW,
+       MT_MEMORY_RO,
        MT_ROM,
        MT_MEMORY_RWX_NONCACHED,
        MT_MEMORY_RW_DTCM,
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5e2be37a198e..cd17e324aa51 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -296,6 +296,13 @@ static struct mem_type mem_types[] __ro_after_init = {
                .prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
                .domain    = DOMAIN_KERNEL,
        },
+       [MT_MEMORY_RO] = {
+               .prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+                            L_PTE_XN | L_PTE_RDONLY,
+               .prot_l1   = PMD_TYPE_TABLE,
+               .prot_sect = PMD_TYPE_SECT,
+               .domain    = DOMAIN_KERNEL,
+       },
        [MT_ROM] = {
                .prot_sect = PMD_TYPE_SECT,
                .domain    = DOMAIN_KERNEL,
@@ -489,6 +496,7 @@ static void __init build_mem_type_table(void)

                        /* Also setup NX memory mapping */
                        mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_XN;
+                       mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_XN;
                }
                if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
                        /*
@@ -568,6 +576,7 @@ static void __init build_mem_type_table(void)
                mem_types[MT_ROM].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
                mem_types[MT_MINICLEAN].prot_sect |=
PMD_SECT_APX|PMD_SECT_AP_WRITE;
                mem_types[MT_CACHECLEAN].prot_sect |=
PMD_SECT_APX|PMD_SECT_AP_WRITE;
+               mem_types[MT_MEMORY_RO].prot_sect |=
PMD_SECT_APX|PMD_SECT_AP_WRITE;
 #endif

                /*
@@ -587,6 +596,8 @@ static void __init build_mem_type_table(void)
                        mem_types[MT_MEMORY_RWX].prot_pte |= L_PTE_SHARED;
                        mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_S;
                        mem_types[MT_MEMORY_RW].prot_pte |= L_PTE_SHARED;
+                       mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_S;
+                       mem_types[MT_MEMORY_RO].prot_pte |= L_PTE_SHARED;
                        mem_types[MT_MEMORY_DMA_READY].prot_pte |= L_PTE_SHARED;
                        mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect
|= PMD_SECT_S;
                        mem_types[MT_MEMORY_RWX_NONCACHED].prot_pte |=
L_PTE_SHARED;
@@ -647,6 +658,8 @@ static void __init build_mem_type_table(void)
        mem_types[MT_MEMORY_RWX].prot_pte |= kern_pgprot;
        mem_types[MT_MEMORY_RW].prot_sect |= ecc_mask | cp->pmd;
        mem_types[MT_MEMORY_RW].prot_pte |= kern_pgprot;
+       mem_types[MT_MEMORY_RO].prot_sect |= ecc_mask | cp->pmd;
+       mem_types[MT_MEMORY_RO].prot_pte |= kern_pgprot;
        mem_types[MT_MEMORY_DMA_READY].prot_pte |= kern_pgprot;
        mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= ecc_mask;
        mem_types[MT_ROM].prot_sect |= cp->pmd;
@@ -1360,7 +1373,7 @@ static void __init devicemaps_init(const struct
machine_desc *mdesc)
                map.pfn = __phys_to_pfn(__atags_pointer & SECTION_MASK);
                map.virtual = FDT_FIXED_BASE;
                map.length = FDT_FIXED_SIZE;
-               map.type = MT_ROM;
+               map.type = MT_MEMORY_RO;
                create_mapping(&map);
        }
