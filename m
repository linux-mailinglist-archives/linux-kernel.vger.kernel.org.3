Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F854E78CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376449AbiCYQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiCYQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:21:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD660CFD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:20:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so11546602wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrT/Gfta9ayAz5i+jL/y9ElxdSo91RpzNXqSya94wrg=;
        b=a5MdCaogKyvo148U+GxtppxlJDqVnJGSPtNtV82lOeBxEP74LuxKeL8cStI63s+qNR
         MAIBh8gRP2IB/j7KMEAdesXCD8Ul2oWFsjdUJjRYlJdn8SU9UP85k6vUkhdIkOUWxPky
         gcyR+8ewxQxcwQUF0sdFYe8NI8Z68B+TMUVJp0W7wVQA7M/F8SsANPVPBjRusRmnXTs9
         AYsE/xqaQlF0q0dJIqswEichVIlxVzlz7twcgJhMUeJZYU3FBmcATPz6kBDOUUkTokkT
         O2aUkoFB4nrzrvJuVdgZIKpG3THkrj0nOhI0Et516MRvZ/T0ys6KAys9VMAi7Axj3nCQ
         qATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrT/Gfta9ayAz5i+jL/y9ElxdSo91RpzNXqSya94wrg=;
        b=Z/njkv2DMUjHQs4+411QlIt9ercVf2TcxKYM7xzRB+ei5qRzpneUENPgxwcNMsAwhg
         nGcm6Epq19lDZLG6ZIOKc45JpUiujPZalY1xqbmKZTl2ogh9fgW6RRZi/9qXjlA/UjHe
         hA3+ilDYCRF10tEeeRfm3QciPVOSMd6f4VyedJck8OOnB0K+3In6bAuyuvN59vBmAXFS
         Lc59SyAhbiELxWgtpdnlDzaQbS1BeFYzb0IOET51IX2hIqxilwNFi4ZC8VjaT9smgRhW
         3/ocQvEqMMlCqrBKebEe0EDgTRIE6Xd3oZBkIre/Ru+34MKARgqOjtUAnOYmqjFjq4LE
         mFHg==
X-Gm-Message-State: AOAM530uBszZVntnD01wHScM6y1EQRGtoIZIZ2NooKxrMS0ROilv5HjI
        MrLAv2NEym4iK8WLpiXVln2uKVTEc8X757/0MYYQ6g==
X-Google-Smtp-Source: ABdhPJxUlhn4ueP1Y49vAsQkUIAoirqNMxqiS9ywbsEg1w2ooWzRie3nl7s0xL7JWpUypLb4GqohWQQORkCO90uxSdA=
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id
 i5-20020adfb645000000b001e30bab7594mr9725421wre.346.1648225214688; Fri, 25
 Mar 2022 09:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220307224620.1933061-1-heiko@sntech.de> <20220307224620.1933061-2-heiko@sntech.de>
In-Reply-To: <20220307224620.1933061-2-heiko@sntech.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 25 Mar 2022 21:50:03 +0530
Message-ID: <CAAhSdy2FR3eSAYgcCtoo9wDe9XXwoPk_Anf17mqy_T1C6_3Hog@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Implement Zicbom-based cache management operations
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 4:16 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The Zicbom ISA-extension was ratified in november 2021
> and introduces instructions for dcache invalidate, clean
> and flush operations.
>
> Implement cache management operations based on them.
>
> Of course not all cores will support this, so implement an
> alternative-based mechanism that replaces empty instructions
> with ones done around Zicbom instructions.
>
> We're using prebuild instructions for the Zicbom instructions
> for now, to not require a bleeding-edge compiler (gcc-12)
> for these somewhat simple instructions.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                   |  8 ++++
>  arch/riscv/include/asm/errata_list.h | 37 ++++++++++++++++-
>  arch/riscv/include/asm/hwcap.h       |  1 +
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       | 17 ++++++++
>  arch/riscv/mm/Makefile               |  1 +
>  arch/riscv/mm/dma-noncoherent.c      | 61 ++++++++++++++++++++++++++++
>  7 files changed, 125 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/mm/dma-noncoherent.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5adcbd9b5e88..d3a1cd41c203 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -208,6 +208,14 @@ config PGTABLE_LEVELS
>  config LOCKDEP_SUPPORT
>         def_bool y
>
> +config RISCV_DMA_NONCOHERENT
> +       bool "Support non-coherent dma operation"
> +       select ARCH_HAS_DMA_PREP_COHERENT
> +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +       select ARCH_HAS_SYNC_DMA_FOR_CPU
> +       select ARCH_HAS_SETUP_DMA_OPS
> +       select DMA_DIRECT_REMAP
> +
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.erratas"
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 4fac46b82c16..7a2dd61af24d 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -20,7 +20,8 @@
>  #endif
>
>  #define        CPUFEATURE_SVPBMT 0
> -#define        CPUFEATURE_NUMBER 1
> +#define        CPUFEATURE_CMO 1
> +#define        CPUFEATURE_NUMBER 2
>
>  #ifdef __ASSEMBLY__
>
> @@ -86,6 +87,40 @@ asm volatile(ALTERNATIVE(                                                            \
>  #define ALT_THEAD_PMA(_val)
>  #endif
>
> +/*
> + * cbo.clean rs1
> + * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *    0...01     rs1       010      00000  0001111
> + *
> + * cbo.flush rs1
> + * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *    0...10     rs1       010      00000  0001111
> + *
> + * cbo.inval rs1
> + * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *    0...00     rs1       010      00000  0001111
> + */
> +#define CBO_INVAL_A0   ".long 0x15200F"
> +#define CBO_CLEAN_A0   ".long 0x25200F"
> +#define CBO_FLUSH_A0   ".long 0x05200F"
> +
> +#define ALT_CMO_OP(_op, _start, _size)                                                 \
> +asm volatile(ALTERNATIVE(                                                              \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop",                                                                          \
> +       "mv a0, %1\n\t"                                                                 \
> +       "j 2f\n\t"                                                                      \
> +       "3:\n\t"                                                                        \
> +       CBO_##_op##_A0 "\n\t"                                                           \
> +       "addi a0, a0, %0\n\t"                                                           \
> +       "2:\n\t"                                                                        \
> +       "bltu a0, %2, 3b\n\t", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT)         \
> +       : : "I"(L1_CACHE_BYTES), "r"((_start) & ~(L1_CACHE_BYTES - 1)),                 \
> +           "r"(ALIGN((_start) + (_size), L1_CACHE_BYTES)))

Why not use a global variable (e.g. riscv_cbom_block_size) representing
exact cbom block size instead of L1_CACHE_BYTES ?

The default value of riscv_cbom_block_size can be L1_CACHE_BYTES
which can be overridden at boot-time using optional "riscv,cbom-block-size"
DT property.

The rationale here is that if underlying RISC-V implementation has cbom
block size smaller than L1_CACHE_BYTES then it will result in incomplete
cbom range operation. The riscv_cbom_block_size global variable ensures
that the right block size is used at least for cbom operations.

Regards,
Anup

> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 656cd626eb1a..5943d5125a51 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
>   */
>  enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_SVPBMT = RISCV_ISA_EXT_BASE,
> +       RISCV_ISA_EXT_ZICBOM,
>         RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index c582d557e555..dfcf592273a7 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -72,6 +72,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>         __RISCV_ISA_EXT_DATA("svpbmt", RISCV_ISA_EXT_SVPBMT),
> +       __RISCV_ISA_EXT_DATA("zicbom", RISCV_ISA_EXT_ZICBOM),

Drop the quotes around zicbom because __RISCV_ISA_EXT_DATA() will
stringify the first parameter.

>         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 5c5e6e7488ce..0e997fa5524a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -200,6 +200,7 @@ void __init riscv_fill_hwcap(void)
>                                 set_bit(*ext - 'a', this_isa);
>                         } else {
>                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +                               SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>                         }
>  #undef SET_ISA_EXT_MAP
>                 }
> @@ -267,11 +268,27 @@ static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
>         return ret;
>  }
>
> +static bool cpufeature_cmo_check_func(unsigned int stage)
> +{
> +       switch (stage) {
> +       case RISCV_ALTERNATIVES_EARLY_BOOT:
> +               return false;
> +       default:
> +               return riscv_isa_extension_available(NULL, ZICBOM);
> +       }
> +
> +       return false;
> +}
> +
>  static const struct cpufeature_info __initdata_or_module cpufeature_list[CPUFEATURE_NUMBER] = {
>         {
>                 .name = "svpbmt",
>                 .check_func = cpufeature_svpbmt_check_func
>         },
> +       {
> +               .name = "cmo",
> +               .check_func = cpufeature_cmo_check_func
> +       },
>  };
>
>  static u32 __init_or_module cpufeature_probe(unsigned int stage)
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index ac7a25298a04..d76aabf4b94d 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -30,3 +30,4 @@ endif
>  endif
>
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> +obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> new file mode 100644
> index 000000000000..2c124bcc1932
> --- /dev/null
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RISC-V specific functions to support DMA for non-coherent devices
> + *
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/dma-direct.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/libfdt.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +
> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +       switch (dir) {
> +       case DMA_TO_DEVICE:
> +               ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size);
> +               break;
> +       case DMA_FROM_DEVICE:
> +               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
> +               break;
> +       case DMA_BIDIRECTIONAL:
> +               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +       switch (dir) {
> +       case DMA_TO_DEVICE:
> +               break;
> +       case DMA_FROM_DEVICE:
> +       case DMA_BIDIRECTIONAL:
> +               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +       void *flush_addr = page_address(page);
> +
> +       memset(flush_addr, 0, size);
> +       ALT_CMO_OP(FLUSH, (unsigned long)flush_addr, size);
> +}
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +               const struct iommu_ops *iommu, bool coherent)
> +{
> +       /* If a specific device is dma-coherent, set it here */
> +       dev->dma_coherent = coherent;
> +}
> --
> 2.30.2
>
