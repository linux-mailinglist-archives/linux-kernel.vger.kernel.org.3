Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274985756DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbiGNV0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGNV0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:26:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C326AC0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:26:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x184so3000451pfx.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5Uiq0GJnsn+FDRzb6jOWRSJ71sl+wZ69PTXG0mZN1lU=;
        b=rjaa7O5jr3Rq4ZBbXrb7KZzdLIcV9qqJZa5NmVoUv/wV3MkOdLo8VgmgoItSUSGAnV
         6JaY6P+VuJobEMF79aneWzx5VGO0/4QWmfDSYIZZrgL8mMtbmcElLN3fAPefeZ43b+hB
         Gr3/67nquJXQnVBdsx91JItZwLNl0iueaJ+Edkea09IKOEX7UoQkgyBM7A8785Ers+lx
         4r2ehtTKW85JF+YwBIPi+N/lfVVnE9eNwbyJBeKJ5kR9fadvD7G7ylcyJTlH59GY+3gI
         Xuj6QKJa/29xRGlZO8nHCkjD2gWRc9mKFlqT87//zx2alPwiwOmm7fP0c55OyjGCKPzV
         WJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5Uiq0GJnsn+FDRzb6jOWRSJ71sl+wZ69PTXG0mZN1lU=;
        b=MQp4r8m76zsaSGrkv3z3SSFVL5XXm9gRH2y/csrt/LgbJByvXNmxToxCLFY60aHpGh
         vWiK0AXZWwGsv/yLpZgqBKsFTz2EMb6xMwAYcOtx9JTSms3tCmI+Cyby3986i/wfD3QB
         f3/nmzgbfQDxRsIv0tgwhr8x7Mv4x3ORNXszmUYf+8Y0ZriMHJHTAfOf5eq0KkqOxiD0
         bLYDRZ02h5/C0UCL17vAdph4Ilr2Cx6erxjfmVVaw25QSdgoFNiSZQxE3gcl4MUhM87m
         M+WM3SI/jrq6w+8AStpGSIiWCpBU47AMA4OqBbPCgPbZ1Mi8BAQBAzjEmrDM1Msdb6hu
         /AJA==
X-Gm-Message-State: AJIora9EnvvtWLIxsVokKo8dobnHiYIPUzzJ/phSFtveeeHeZdGfTFGp
        M/UXIugidJ0eXX9TlWIdIzSjWw==
X-Google-Smtp-Source: AGRyM1tG8e3jIgDWHu80ncifreV87llJwuiwov21ReO0/D9bdDMfVakLwEeEzPrU6cNLDfIGQ/QlZQ==
X-Received: by 2002:aa7:8ec2:0:b0:52a:d4f5:20b with SMTP id b2-20020aa78ec2000000b0052ad4f5020bmr10158726pfr.71.1657833973389;
        Thu, 14 Jul 2022 14:26:13 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090341cd00b00163e06e1a99sm1987336ple.120.2022.07.14.14.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:26:10 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:26:10 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Jul 2022 14:26:03 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Add CONFIG_{NON,}PORTABLE
In-Reply-To: <20220521193356.26562-1-palmer@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        rdunlap@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        anup@brainfault.org, alexandre.ghiti@canonical.com,
        damien.lemoal@opensource.wdc.com,
        Atish Patra <atishp@rivosinc.com>, axboe@kernel.dk,
        guoren@kernel.org, mchitale@ventanamicro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Message-ID: <mhng-b5cae221-396d-49a6-91b2-362f490ca732@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 12:33:57 PDT (-0700), Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The RISC-V port has collected a handful of options that are
> fundamentally non-portable.  To prevent users from shooting themselves
> in the foot, hide them all behind a config entry that explicitly calls
> out that non-portable binaries may be produced.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes since v2:
>
> * Update the nommu and rv32 defconfigs.  I'm still getting some ugliness
>   like
>
>     $ make.riscv rv32_defconfig
>     *** Default configuration is based on 'defconfig'
>     #
>     # configuration written to .config
>     #
>     Using .config as base
>     Merging ./arch/riscv/configs/32-bit.config
>     Value of CONFIG_PORTABLE is redefined by fragment ./arch/riscv/configs/32-bit.config:
>     Previous value: CONFIG_PORTABLE=y
>     New value: # CONFIG_PORTABLE is not set
>
>     Value of CONFIG_NONPORTABLE is redefined by fragment ./arch/riscv/configs/32-bit.config:
>     Previous value: # CONFIG_NONPORTABLE is not set
>     New value: CONFIG_NONPORTABLE=y
>
>     #
>     # merged configuration written to .config (needs make)
>     #
>     .config:3831:warning: override: ARCH_RV32I changes choice state
>     #
>     # configuration written to .config
>     #
>
>   not sure if there's a better way to do this.
>
> Changes since v1:
>
> * Fix a bunch of spelling mistakes.
> * Move NONPORTABLE under the "Platform type" sub-heading.
> * Fix the rv32i dependency.
>
> ---
>  arch/riscv/Kconfig                            | 28 +++++++++++++++++--
>  arch/riscv/configs/32-bit.config              |  2 ++
>  arch/riscv/configs/nommu_k210_defconfig       |  1 +
>  .../riscv/configs/nommu_k210_sdcard_defconfig |  1 +
>  arch/riscv/configs/nommu_virt_defconfig       |  1 +
>  arch/riscv/configs/rv32_defconfig             |  1 +
>  6 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f863065b478c..cd67b09a80f5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -222,6 +222,21 @@ source "arch/riscv/Kconfig.erratas"
>
>  menu "Platform type"
>
> +config NONPORTABLE
> +	bool "Allow configurations that result in non-portable kernels"
> +	help
> +	  RISC-V kernel binaries are compatible between all known systems
> +	  whenever possible, but there are some use cases that can only be
> +	  satisfied by configurations that result in kernel binaries that are
> +	  not portable between systems.
> +
> +	  Selecting N does not guarantee kernels will be portable to all known
> +	  systems.  Selecting any of the options guarded by NONPORTABLE will
> +	  result in kernel binaries that are unlikely to be portable between
> +	  systems.
> +
> +	  If unsure, say N.
> +
>  choice
>  	prompt "Base ISA"
>  	default ARCH_RV64I
> @@ -231,6 +246,7 @@ choice
>
>  config ARCH_RV32I
>  	bool "RV32I"
> +	depends on NONPORTABLE
>  	select 32BIT
>  	select GENERIC_LIB_ASHLDI3
>  	select GENERIC_LIB_ASHRDI3
> @@ -541,6 +557,7 @@ config STACKPROTECTOR_PER_TASK
>
>  config PHYS_RAM_BASE_FIXED
>  	bool "Explicitly specified physical RAM address"
> +	depends on NONPORTABLE
>  	default n
>
>  config PHYS_RAM_BASE
> @@ -554,7 +571,7 @@ config PHYS_RAM_BASE
>
>  config XIP_KERNEL
>  	bool "Kernel Execute-In-Place from ROM"
> -	depends on MMU && SPARSEMEM
> +	depends on MMU && SPARSEMEM && NONPORTABLE
>  	# This prevents XIP from being enabled by all{yes,mod}config, which
>  	# fail to build since XIP doesn't support large kernels.
>  	depends on !COMPILE_TEST
> @@ -594,9 +611,16 @@ endmenu
>
>  config BUILTIN_DTB
>  	bool
> -	depends on OF
> +	depends on OF && NONPORTABLE
>  	default y if XIP_KERNEL
>
> +config PORTABLE
> +	bool
> +	default !NONPORTABLE
> +	select EFI
> +	select OF
> +	select MMU
> +
>  menu "Power management options"
>
>  source "kernel/power/Kconfig"
> diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
> index 43f41323b67e..f6af0f708df4 100644
> --- a/arch/riscv/configs/32-bit.config
> +++ b/arch/riscv/configs/32-bit.config
> @@ -1,2 +1,4 @@
>  CONFIG_ARCH_RV32I=y
>  CONFIG_32BIT=y
> +# CONFIG_PORTABLE is not set
> +CONFIG_NONPORTABLE=y
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index 2438fa39f8ae..96fe8def644c 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -28,6 +28,7 @@ CONFIG_EMBEDDED=y
>  CONFIG_SLOB=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_CANAAN=y
> +CONFIG_NONPORTABLE=y
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
>  CONFIG_CMDLINE="earlycon console=ttySIF0"
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index 9a133e63ae5b..379740654373 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -20,6 +20,7 @@ CONFIG_EMBEDDED=y
>  CONFIG_SLOB=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_CANAAN=y
> +CONFIG_NONPORTABLE=y
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
>  CONFIG_CMDLINE="earlycon console=ttySIF0 root=/dev/mmcblk0p1 rootwait ro"
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> index 5269fbb6b4fc..1a56eda5ce46 100644
> --- a/arch/riscv/configs/nommu_virt_defconfig
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -25,6 +25,7 @@ CONFIG_EXPERT=y
>  CONFIG_SLOB=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_VIRT=y
> +CONFIG_NONPORTABLE=y
>  CONFIG_SMP=y
>  CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
>  CONFIG_CMDLINE_FORCE=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 7e5efdc3829d..77bdb1d05a88 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -18,6 +18,7 @@ CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> +CONFIG_NONPORTABLE=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y

This is on for-next.
