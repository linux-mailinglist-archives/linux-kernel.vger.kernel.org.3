Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3024D321F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiCIPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiCIPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:49:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FE45D760D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:48:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5472A1688;
        Wed,  9 Mar 2022 07:48:11 -0800 (PST)
Received: from [10.57.41.254] (unknown [10.57.41.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC7B3F7F5;
        Wed,  9 Mar 2022 07:48:08 -0800 (PST)
Message-ID: <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com>
Date:   Wed, 9 Mar 2022 15:48:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220309144138.360482-1-arnd@kernel.org>
 <20220309144138.360482-2-arnd@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220309144138.360482-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-09 14:40, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is possible to build MMU-less kernels for Cortex-M base
> microcrontrollers as well as a couple of older platforms that
> have not been converted to CONFIG_ARCH_MULTIPLATFORM,
> specifically ep93xx, footbridge, dove, sa1100 and s3c24xx.
> 
> It seems unlikely that anybody has tested those configurations
> in recent years, as even building them is frequently broken.
> A patch I submitted caused another build time regression
> in this configuration. I sent a patch for that, but it seems
> better to also remove the option entirely, leaving ARMv7-M
> as the only supported Arm NOMMU target for simplicity.

In that case, it would probably make sense to garbage-collect all the 
configs, setup code and other stuff relating to older MMU-less CPU cores 
like ARM1156, ARM940, etc. at the same time.

Robin.

> This addresses several build failures in randconfig builds that
> have accumulated over the years.
> 
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If there are no objections, I'd apply this patch to the soc
> tree for 5.18 as a cleanup.
> ---
>   arch/arm/Kconfig                              | 34 +++++++------------
>   .../mach-footbridge/include/mach/hardware.h   | 20 ++++-------
>   arch/arm/mach-footbridge/include/mach/io.h    | 20 -----------
>   arch/arm/mach-integrator/hardware.h           |  5 ---
>   4 files changed, 20 insertions(+), 59 deletions(-)
>   delete mode 100644 arch/arm/mach-footbridge/include/mach/io.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5f0b40bab4fb..d184377ce2ae 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -304,6 +304,17 @@ config MMU
>   	  Select if you want MMU-based virtualised addressing space
>   	  support by paged memory management. If unsure, say 'Y'.
>   
> +config ARM_SINGLE_ARMV7M
> +	def_bool !MMU
> +	select ARM_NVIC
> +	select AUTO_ZRELADDR
> +	select TIMER_OF
> +	select COMMON_CLK
> +	select CPU_V7M
> +	select NO_IOPORT_MAP
> +	select SPARSE_IRQ
> +	select USE_OF
> +
>   config ARCH_MMAP_RND_BITS_MIN
>   	default 8
>   
> @@ -318,12 +329,11 @@ config ARCH_MMAP_RND_BITS_MAX
>   #
>   choice
>   	prompt "ARM system type"
> -	default ARM_SINGLE_ARMV7M if !MMU
> -	default ARCH_MULTIPLATFORM if MMU
> +	depends on MMU
> +	default ARCH_MULTIPLATFORM
>   
>   config ARCH_MULTIPLATFORM
>   	bool "Allow multiple platforms to be selected"
> -	depends on MMU
>   	select ARCH_FLATMEM_ENABLE
>   	select ARCH_SPARSEMEM_ENABLE
>   	select ARCH_SELECT_MEMORY_MODEL
> @@ -337,18 +347,6 @@ config ARCH_MULTIPLATFORM
>   	select SPARSE_IRQ
>   	select USE_OF
>   
> -config ARM_SINGLE_ARMV7M
> -	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
> -	depends on !MMU
> -	select ARM_NVIC
> -	select AUTO_ZRELADDR
> -	select TIMER_OF
> -	select COMMON_CLK
> -	select CPU_V7M
> -	select NO_IOPORT_MAP
> -	select SPARSE_IRQ
> -	select USE_OF
> -
>   config ARCH_EP93XX
>   	bool "EP93xx-based"
>   	select ARCH_SPARSEMEM_ENABLE
> @@ -367,7 +365,6 @@ config ARCH_FOOTBRIDGE
>   	bool "FootBridge"
>   	select CPU_SA110
>   	select FOOTBRIDGE
> -	select NEED_MACH_IO_H if !MMU
>   	select NEED_MACH_MEMORY_H
>   	help
>   	  Support for systems based on the DC21285 companion chip
> @@ -375,7 +372,6 @@ config ARCH_FOOTBRIDGE
>   
>   config ARCH_IOP32X
>   	bool "IOP32x-based"
> -	depends on MMU
>   	select CPU_XSCALE
>   	select GPIO_IOP
>   	select GPIOLIB
> @@ -387,7 +383,6 @@ config ARCH_IOP32X
>   
>   config ARCH_IXP4XX
>   	bool "IXP4xx-based"
> -	depends on MMU
>   	select ARCH_SUPPORTS_BIG_ENDIAN
>   	select ARM_PATCH_PHYS_VIRT
>   	select CPU_XSCALE
> @@ -418,7 +413,6 @@ config ARCH_DOVE
>   
>   config ARCH_PXA
>   	bool "PXA2xx/PXA3xx-based"
> -	depends on MMU
>   	select ARCH_MTD_XIP
>   	select ARM_CPU_SUSPEND if PM
>   	select AUTO_ZRELADDR
> @@ -437,7 +431,6 @@ config ARCH_PXA
>   
>   config ARCH_RPC
>   	bool "RiscPC"
> -	depends on MMU
>   	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
>   	select ARCH_ACORN
>   	select ARCH_MAY_HAVE_PC_FDC
> @@ -493,7 +486,6 @@ config ARCH_S3C24XX
>   
>   config ARCH_OMAP1
>   	bool "TI OMAP1"
> -	depends on MMU
>   	select ARCH_OMAP
>   	select CLKSRC_MMIO
>   	select GENERIC_IRQ_CHIP
> diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
> index ecaf6e7388d9..985ad3a95671 100644
> --- a/arch/arm/mach-footbridge/include/mach/hardware.h
> +++ b/arch/arm/mach-footbridge/include/mach/hardware.h
> @@ -21,32 +21,26 @@
>    * 0xf0000000	0x80000000	16MB	ISA memory
>    */
>   
> -#ifdef CONFIG_MMU
> -#define MMU_IO(a, b)	(a)
> -#else
> -#define MMU_IO(a, b)	(b)
> -#endif
> -
>   #define XBUS_SIZE		0x00100000
> -#define XBUS_BASE		MMU_IO(0xff800000, 0x40000000)
> +#define XBUS_BASE		0xff800000
>   
>   #define ARMCSR_SIZE		0x00100000
> -#define ARMCSR_BASE		MMU_IO(0xfe000000, 0x42000000)
> +#define ARMCSR_BASE		0xfe000000
>   
>   #define WFLUSH_SIZE		0x00100000
> -#define WFLUSH_BASE		MMU_IO(0xfd000000, 0x78000000)
> +#define WFLUSH_BASE		0xfd000000
>   
>   #define PCIIACK_SIZE		0x00100000
> -#define PCIIACK_BASE		MMU_IO(0xfc000000, 0x79000000)
> +#define PCIIACK_BASE		0xfc000000
>   
>   #define PCICFG1_SIZE		0x01000000
> -#define PCICFG1_BASE		MMU_IO(0xfb000000, 0x7a000000)
> +#define PCICFG1_BASE		0xfb000000
>   
>   #define PCICFG0_SIZE		0x01000000
> -#define PCICFG0_BASE		MMU_IO(0xfa000000, 0x7b000000)
> +#define PCICFG0_BASE		0xfa000000
>   
>   #define PCIMEM_SIZE		0x01000000
> -#define PCIMEM_BASE		MMU_IO(0xf0000000, 0x80000000)
> +#define PCIMEM_BASE		0xf0000000
>   
>   #define XBUS_CS2		0x40012000
>   
> diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
> deleted file mode 100644
> index 4e18b921373f..000000000000
> --- a/arch/arm/mach-footbridge/include/mach/io.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-footbridge/include/mach/io.h
> - *
> - *  Copyright (C) 1997-1999 Russell King
> - *
> - *  Modifications:
> - *   06-12-1997	RMK	Created.
> - *   07-04-1999	RMK	Major cleanup
> - */
> -#ifndef __ASM_ARM_ARCH_IO_H
> -#define __ASM_ARM_ARCH_IO_H
> -
> -/*
> - * Translation of various i/o addresses to host addresses for !CONFIG_MMU
> - */
> -#define PCIO_BASE       0x7c000000
> -#define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
> -
> -#endif
> diff --git a/arch/arm/mach-integrator/hardware.h b/arch/arm/mach-integrator/hardware.h
> index 4d6ade3dd4ee..81ce09e3ad45 100644
> --- a/arch/arm/mach-integrator/hardware.h
> +++ b/arch/arm/mach-integrator/hardware.h
> @@ -16,12 +16,7 @@
>   #define IO_START		INTEGRATOR_HDR_BASE        // PA of IO
>   
>   /* macro to get at IO space when running virtually */
> -#ifdef CONFIG_MMU
>   #define IO_ADDRESS(x)	(((x) & 0x000fffff) | (((x) >> 4) & 0x0ff00000) | IO_BASE)
> -#else
> -#define IO_ADDRESS(x)	(x)
> -#endif
> -
>   #define __io_address(n)		((void __iomem *)IO_ADDRESS(n))
>   
>   /*
