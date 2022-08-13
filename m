Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31A591B79
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiHMPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiHMPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841822BCB
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A2C60EDC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E0C433C1;
        Sat, 13 Aug 2022 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660404996;
        bh=aIkHSHxyHwfpffFyo2wXcqTzAgNp9HHRy9jdwm5R2+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tigCy1ZdHbuXYvL7rmE0z2jDiIUUhfp2lQHp1lr5ifcr27+BUHOhIDK4DRwOiXe0B
         3QdP/vL1vHNdQtHlHGT/7pP2u6ZTZaEpfJ8KFdVGW7o4gQWB8luHJ8/mM6EUfloHxr
         5RDLEjFDA0aIJuMvW4FSE44c+XdXbCgOMGqGGwIzHB4AKOs9QzzqhicYjRtubrngRt
         IhiBWHrXYlo8S1CwC4Jwunrut6R1M9SBcGXhRJTTl130QJqMHtfiObm3Hi2/7IfTca
         VoQTjnlkA0wQ1K6wGCgsLf2rrJfWCBd0uTfsa0xWtY1tf0CcizfcVjdqPqtNSq+RH7
         mbzZgqYcNiP8A==
Date:   Sat, 13 Aug 2022 18:36:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/12] arch: mm: rename FORCE_MAX_ZONEORDER to
 ARCH_FORCE_MAX_ORDER
Message-ID: <YvfE9JT5XEPDUcAg@kernel.org>
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811231643.1012912-2-zi.yan@sent.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 07:16:32PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This Kconfig option is used by individual arch to set its desired
> MAX_ORDER. Rename it to reflect its actual use.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-oxnas@groups.io
> Cc: linux-csky@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arc/Kconfig                             | 2 +-
>  arch/arm/Kconfig                             | 2 +-
>  arch/arm/configs/imx_v6_v7_defconfig         | 2 +-
>  arch/arm/configs/milbeaut_m10v_defconfig     | 2 +-
>  arch/arm/configs/oxnas_v6_defconfig          | 2 +-
>  arch/arm/configs/sama7_defconfig             | 2 +-
>  arch/arm64/Kconfig                           | 2 +-
>  arch/csky/Kconfig                            | 2 +-
>  arch/ia64/Kconfig                            | 2 +-
>  arch/ia64/include/asm/sparsemem.h            | 6 +++---
>  arch/m68k/Kconfig.cpu                        | 2 +-
>  arch/mips/Kconfig                            | 2 +-
>  arch/nios2/Kconfig                           | 2 +-
>  arch/powerpc/Kconfig                         | 2 +-
>  arch/powerpc/configs/85xx/ge_imp3a_defconfig | 2 +-
>  arch/powerpc/configs/fsl-emb-nonhw.config    | 2 +-
>  arch/sh/configs/ecovec24_defconfig           | 2 +-
>  arch/sh/mm/Kconfig                           | 2 +-
>  arch/sparc/Kconfig                           | 2 +-
>  arch/xtensa/Kconfig                          | 2 +-
>  include/linux/mmzone.h                       | 4 ++--
>  21 files changed, 24 insertions(+), 24 deletions(-)

This misses arch/loongarch.

Other than that I think its a good cleanup regardless of the rest of the
series.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 9e3653253ef2..d9a13ccf89a3 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -554,7 +554,7 @@ config ARC_BUILTIN_DTB_NAME
>  
>  endmenu	 # "ARC Architecture Configuration"
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	default "12" if ARC_HUGEPAGE_16M
>  	default "11"
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 87badeae3181..e6c8ee56ac52 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1434,7 +1434,7 @@ config ARM_MODULE_PLTS
>  	  Disabling this is usually safe for small single-platform
>  	  configurations. If unsure, say y.
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	default "12" if SOC_AM33XX
>  	default "9" if SA1111
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 01012537a9b9..fb283059daa0 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -31,7 +31,7 @@ CONFIG_SOC_VF610=y
>  CONFIG_SMP=y
>  CONFIG_ARM_PSCI=y
>  CONFIG_HIGHMEM=y
> -CONFIG_FORCE_MAX_ZONEORDER=14
> +CONFIG_ARCH_FORCE_MAX_ORDER=14
>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> index 58810e98de3d..8620061e19a8 100644
> --- a/arch/arm/configs/milbeaut_m10v_defconfig
> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> @@ -26,7 +26,7 @@ CONFIG_THUMB2_KERNEL=y
>  # CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
>  # CONFIG_ARM_PATCH_IDIV is not set
>  CONFIG_HIGHMEM=y
> -CONFIG_FORCE_MAX_ZONEORDER=12
> +CONFIG_ARCH_FORCE_MAX_ORDER=12
>  CONFIG_SECCOMP=y
>  CONFIG_KEXEC=y
>  CONFIG_EFI=y
> diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v6_defconfig
> index 600f78b363dd..5c163a9d1429 100644
> --- a/arch/arm/configs/oxnas_v6_defconfig
> +++ b/arch/arm/configs/oxnas_v6_defconfig
> @@ -12,7 +12,7 @@ CONFIG_ARCH_OXNAS=y
>  CONFIG_MACH_OX820=y
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=16
> -CONFIG_FORCE_MAX_ZONEORDER=12
> +CONFIG_ARCH_FORCE_MAX_ORDER=12
>  CONFIG_SECCOMP=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 0384030d8b25..8b2cf6ddd568 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -19,7 +19,7 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=y
>  # CONFIG_CACHE_L2X0 is not set
>  # CONFIG_ARM_PATCH_IDIV is not set
>  # CONFIG_CPU_SW_DOMAIN_PAN is not set
> -CONFIG_FORCE_MAX_ZONEORDER=15
> +CONFIG_ARCH_FORCE_MAX_ORDER=15
>  CONFIG_UACCESS_WITH_MEMCPY=y
>  # CONFIG_ATAGS is not set
>  CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 571cc234d0b3..c6fcd8746f60 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1401,7 +1401,7 @@ config XEN
>  	help
>  	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int
>  	default "14" if ARM64_64K_PAGES
>  	default "12" if ARM64_16K_PAGES
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 3cbc2dc62baf..adee6ab36862 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -332,7 +332,7 @@ config HIGHMEM
>  	select KMAP_LOCAL
>  	default y
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	default "11"
>  
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 26ac8ea15a9e..c6e06cdc738f 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -200,7 +200,7 @@ config IA64_CYCLONE
>  	  Say Y here to enable support for IBM EXA Cyclone time source.
>  	  If you're unsure, answer N.
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "MAX_ORDER (11 - 17)"  if !HUGETLB_PAGE
>  	range 11 17  if !HUGETLB_PAGE
>  	default "17" if HUGETLB_PAGE
> diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/sparsemem.h
> index 42ed5248fae9..84e8ce387b69 100644
> --- a/arch/ia64/include/asm/sparsemem.h
> +++ b/arch/ia64/include/asm/sparsemem.h
> @@ -11,10 +11,10 @@
>  
>  #define SECTION_SIZE_BITS	(30)
>  #define MAX_PHYSMEM_BITS	(50)
> -#ifdef CONFIG_FORCE_MAX_ZONEORDER
> -#if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
> +#ifdef CONFIG_ARCH_FORCE_MAX_ORDER
> +#if ((CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
>  #undef SECTION_SIZE_BITS
> -#define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> +#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT)
>  #endif
>  #endif
>  
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index e0e9e31339c1..3b2f39508524 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -399,7 +399,7 @@ config SINGLE_MEMORY_CHUNK
>  	  order" to save memory that could be wasted for unused memory map.
>  	  Say N if not sure.
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order" if ADVANCED
>  	depends on !SINGLE_MEMORY_CHUNK
>  	default "11"
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ec21f8999249..70d28976a40d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2140,7 +2140,7 @@ config PAGE_SIZE_64KB
>  
>  endchoice
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
>  	default "14" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 4167f1eb4cd8..a582f72104f3 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -44,7 +44,7 @@ menu "Kernel features"
>  
>  source "kernel/Kconfig.hz"
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	range 9 20
>  	default "11"
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4c466acdc70d..39d71d7701bd 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -845,7 +845,7 @@ config DATA_SHIFT
>  	  in that case. If PIN_TLB is selected, it must be aligned to 8M as
>  	  8M pages will be pinned.
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	range 8 9 if PPC64 && PPC_64K_PAGES
>  	default "9" if PPC64 && PPC_64K_PAGES
> diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
> index f29c166998af..e7672c186325 100644
> --- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
> +++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
> @@ -30,7 +30,7 @@ CONFIG_PREEMPT=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_BINFMT_MISC=m
>  CONFIG_MATH_EMULATION=y
> -CONFIG_FORCE_MAX_ZONEORDER=17
> +CONFIG_ARCH_FORCE_MAX_ORDER=17
>  CONFIG_PCI=y
>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_MSI=y
> diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
> index f14c6dbd7346..ab8a8c4530d9 100644
> --- a/arch/powerpc/configs/fsl-emb-nonhw.config
> +++ b/arch/powerpc/configs/fsl-emb-nonhw.config
> @@ -41,7 +41,7 @@ CONFIG_FIXED_PHY=y
>  CONFIG_FONT_8x16=y
>  CONFIG_FONT_8x8=y
>  CONFIG_FONTS=y
> -CONFIG_FORCE_MAX_ZONEORDER=13
> +CONFIG_ARCH_FORCE_MAX_ORDER=13
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAME_WARN=1024
>  CONFIG_FTL=y
> diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
> index e699e2e04128..b52e14ccb450 100644
> --- a/arch/sh/configs/ecovec24_defconfig
> +++ b/arch/sh/configs/ecovec24_defconfig
> @@ -8,7 +8,7 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_CPU_SUBTYPE_SH7724=y
> -CONFIG_FORCE_MAX_ZONEORDER=12
> +CONFIG_ARCH_FORCE_MAX_ORDER=12
>  CONFIG_MEMORY_SIZE=0x10000000
>  CONFIG_FLATMEM_MANUAL=y
>  CONFIG_SH_ECOVEC=y
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index ba569cfb4368..411fdc0901f7 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -18,7 +18,7 @@ config PAGE_OFFSET
>  	default "0x80000000" if MMU
>  	default "0x00000000"
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	range 9 64 if PAGE_SIZE_16KB
>  	default "9" if PAGE_SIZE_16KB
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 1c852bb530ec..4d3d1af90d52 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -269,7 +269,7 @@ config ARCH_SPARSEMEM_ENABLE
>  config ARCH_SPARSEMEM_DEFAULT
>  	def_bool y if SPARC64
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	default "13"
>  	help
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 12ac277282ba..bcb0c5d2abc2 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -771,7 +771,7 @@ config HIGHMEM
>  
>  	  If unsure, say Y.
>  
> -config FORCE_MAX_ZONEORDER
> +config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
>  	default "11"
>  	help
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8f571dc7c524..ca285ed3c6e0 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -24,10 +24,10 @@
>  #include <asm/page.h>
>  
>  /* Free memory management - zoned buddy allocator.  */
> -#ifndef CONFIG_FORCE_MAX_ZONEORDER
> +#ifndef CONFIG_ARCH_FORCE_MAX_ORDER
>  #define MAX_ORDER 11
>  #else
> -#define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
> +#define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
>  #endif
>  #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
>  
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
