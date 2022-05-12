Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD28524405
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346741AbiELETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiELETn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:19:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25E20132B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:19:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so2266498wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0aBVNuRAGpajsjx3sMG0wC034zTnu3GeXScJ10oPEs=;
        b=4uejWBiNdRUof03Dkk8hcDmwhP+oaTUloU7yqmGOil1QAtW58/wP8UCecVzCrU9TRh
         fvrloSLIFdF53Iy9li/HcUn/OKhq1m898Zz+3Z5rnCWgSs9AnrRK8aEZc1FRhrR8Uwp8
         jZyZwo3Km2XxqKzQnRyU3t4YkARIBz0NrHau8HyhAQ4a94c68z7uw92zz95BLHWFchmK
         1yfmSQSI0o6m2TC7pyIS7j2JQhJ2wnaisWpMCpNSWLlGW3Sx8Isx2RQiEtzgx/mIklIg
         yMs8v2VpHTqcqdLIoBqCDijHmFwPpRKdwKQ90lIM7A1ZXomVtfRmQ6b4CPWkOkW508sR
         rtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0aBVNuRAGpajsjx3sMG0wC034zTnu3GeXScJ10oPEs=;
        b=5wbASb9W5wQHT16No3vb6GwVZ/RGhBGcX8HI0on9a1KupDxoG8KNBQQ49tLXHZTeaw
         KSkBkbknK6swBNi9d8gLTIn2uo5AOV732DpPXsDj+OKLUXxAySoY3a8eFnopLfxbJmAs
         qGkxPFicPrwY5ClohF6dS0jG0nLdtQeJVANSypJercCYJtbNOF85GPugxd7mNSlxis1S
         tNgcTDediXVv4p3ftZkOiXha3ylM63Jdog/h48kGINw80ttDOhafUnEG8Ex1z+UaoZ4f
         D/3J+mn5r/GXAnblhsJD17nyG2937ztPEwLtukQss82QiesLln0S6jAnMJSgxWH2mqi2
         +vwA==
X-Gm-Message-State: AOAM533NmcRuITDNB0oXLRS/MDDn1i3U8u7iOa1EqtNBsHEcHRwX2Ry/
        o14cp1FAoiBe9avVLF3Ko30quUmKbe/dPUnDWrzRBA==
X-Google-Smtp-Source: ABdhPJwQcM11HsUnM9wVX1S+kyG9wEVgZGyU+W9Oq93SZpcNEaeDworGz7PZwImtpn4clL64W3KnkBg6UfJr770k6p0=
X-Received: by 2002:a05:600c:1e13:b0:394:5cdd:e8e6 with SMTP id
 ay19-20020a05600c1e1300b003945cdde8e6mr7896180wmb.108.1652329179902; Wed, 11
 May 2022 21:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220511214132.2281431-1-heiko@sntech.de> <20220511214132.2281431-3-heiko@sntech.de>
In-Reply-To: <20220511214132.2281431-3-heiko@sntech.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 12 May 2022 09:49:27 +0530
Message-ID: <CAAhSdy2ry=EeedBnYVXeKov9p2DFr2aOG-M8nF91hoUH5qPyPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] riscv: Implement Zicbom-based cache management operations
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
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        DTML <devicetree@vger.kernel.org>,
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

On Thu, May 12, 2022 at 3:11 AM Heiko Stuebner <heiko@sntech.de> wrote:
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

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/Kconfig                   | 15 +++++
>  arch/riscv/include/asm/cacheflush.h  |  6 ++
>  arch/riscv/include/asm/errata_list.h | 39 +++++++++++-
>  arch/riscv/include/asm/hwcap.h       |  1 +
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       | 17 +++++
>  arch/riscv/kernel/setup.c            |  2 +
>  arch/riscv/mm/Makefile               |  1 +
>  arch/riscv/mm/dma-noncoherent.c      | 92 ++++++++++++++++++++++++++++
>  9 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/mm/dma-noncoherent.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 65285b980134..532db45367a7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -363,6 +363,21 @@ config RISCV_ISA_SVPBMT
>
>            If you don't know what to do here, say Y.
>
> +config RISCV_ISA_ZICBOM
> +       bool "Zicbom extension support for non-coherent dma operation"
> +       select ARCH_HAS_DMA_PREP_COHERENT
> +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +       select ARCH_HAS_SYNC_DMA_FOR_CPU
> +       select ARCH_HAS_SETUP_DMA_OPS
> +       select DMA_DIRECT_REMAP
> +       select RISCV_ALTERNATIVE
> +       default y
> +       help
> +          Adds support to dynamically detect the presence of the ZICBOM extension
> +          (Cache Block Management Operations) and enable its usage.
> +
> +          If you don't know what to do here, say Y.
> +
>  config FPU
>         bool "FPU support"
>         default y
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 23ff70350992..eb12d014b158 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -42,6 +42,12 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>
>  #endif /* CONFIG_SMP */
>
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +void riscv_init_cbom_blocksize(void);
> +#else
> +static inline void riscv_init_cbom_blocksize(void) { }
> +#endif
> +
>  /*
>   * Bits in sys_riscv_flush_icache()'s flags argument.
>   */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 9e2888dbb5b1..eebcd4415049 100644
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
> @@ -93,6 +94,42 @@ asm volatile(ALTERNATIVE(                                            \
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
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize)                     \
> +asm volatile(ALTERNATIVE(                                              \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop",                                                          \
> +       "mv a0, %1\n\t"                                                 \
> +       "j 2f\n\t"                                                      \
> +       "3:\n\t"                                                        \
> +       CBO_##_op##_A0 "\n\t"                                           \
> +       "add a0, a0, %0\n\t"                                            \
> +       "2:\n\t"                                                        \
> +       "bltu a0, %2, 3b\n\t", 0,                                       \
> +               CPUFEATURE_CMO, CONFIG_RISCV_ISA_ZICBOM)                \
> +       : : "r"(_cachesize),                                            \
> +           "r"(ALIGN((_start), (_cachesize))),                         \
> +           "r"(ALIGN((_start) + (_size), (_cachesize))))
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 4e2486881840..6044e402003d 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -53,6 +53,7 @@ extern unsigned long elf_hwcap;
>  enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
>         RISCV_ISA_EXT_SVPBMT,
> +       RISCV_ISA_EXT_ZICBOM,
>         RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 40c8776aec12..8f6fc15baa8e 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +       __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index dea3ea19deee..db3c02409a4a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
>                         } else {
>                                 SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +                               SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>                         }
>  #undef SET_ISA_EXT_MAP
>                 }
> @@ -265,12 +266,28 @@ static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
>         return false;
>  }
>
> +static bool __init_or_module cpufeature_cmo_check_func(unsigned int stage)
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
>  static const struct cpufeature_info __initdata_or_module
>  cpufeature_list[CPUFEATURE_NUMBER] = {
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
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 9162e9a824d2..cc5bfeba499a 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/crash_dump.h>
>
>  #include <asm/alternative.h>
> +#include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable.h>
> @@ -296,6 +297,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>
>         riscv_fill_hwcap();
> +       riscv_init_cbom_blocksize();
>         apply_boot_alternatives();
>  }
>
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index ac7a25298a04..548f2f3c00e9 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -30,3 +30,4 @@ endif
>  endif
>
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> +obj-$(CONFIG_RISCV_ISA_ZICBOM) += dma-noncoherent.o
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> new file mode 100644
> index 000000000000..99decaa25324
> --- /dev/null
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -0,0 +1,92 @@
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
> +#include <linux/of_device.h>
> +
> +static unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
> +
> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +       switch (dir) {
> +       case DMA_TO_DEVICE:
> +               ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +               break;
> +       case DMA_FROM_DEVICE:
> +               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +               break;
> +       case DMA_BIDIRECTIONAL:
> +               ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
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
> +               ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
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
> +       ALT_CMO_OP(FLUSH, (unsigned long)flush_addr, size, riscv_cbom_block_size);
> +}
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +               const struct iommu_ops *iommu, bool coherent)
> +{
> +       /* If a specific device is dma-coherent, set it here */
> +       dev->dma_coherent = coherent;
> +}
> +
> +void riscv_init_cbom_blocksize(void)
> +{
> +       struct device_node *node;
> +       int ret;
> +       u32 val;
> +
> +       for_each_of_cpu_node(node) {
> +               int hartid = riscv_of_processor_hartid(node);
> +               int cbom_hartid;
> +
> +               if (hartid < 0)
> +                       continue;
> +
> +               /* set block-size for cbom extension if available */
> +               ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> +               if (ret)
> +                       continue;
> +
> +               if (!riscv_cbom_block_size) {
> +                       riscv_cbom_block_size = val;
> +                       cbom_hartid = hartid;
> +               } else {
> +                       if (riscv_cbom_block_size != val)
> +                               pr_warn("cbom-block-size mismatched between harts %d and %d\n",
> +                                       cbom_hartid, hartid);
> +               }
> +       }
> +}
> --
> 2.35.1
>
