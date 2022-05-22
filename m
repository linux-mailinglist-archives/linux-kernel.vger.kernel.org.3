Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1D5301CA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiEVIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiEVIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:09:21 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846863F8A2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:09:19 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ec42eae76bso121013417b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0hAY9HQiA5YcGUnoFNg4oflZui2CiIWucOcgRM8PSA=;
        b=WFMORzDa9eAp3MVzlpkTn0tipf/VaJN2V2BYZ57NTDNPAHbIWBLB+vhJBoBfZ81130
         SzVJWhCOJ6T1GR/RrisWW9fJ0SZWT5afOkRjZNNu5tYOyy6gXuiDsfg/rIafiR8mNML8
         n7du7JO8Qxa4Marr4caBjWB+kFdrH8wZ0U8eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0hAY9HQiA5YcGUnoFNg4oflZui2CiIWucOcgRM8PSA=;
        b=xIsAoR9gQ0izF/bkMWL9OWunqhGfQtyo9afjwCoOICRyTDlKkT2GNqm4BBGVlq20l4
         LoyMrdWyEpQgM2lL0rBDiVvegKoGWJK+pSpPppE5znHmuv1m354nPns0Nr7eGk1oQZhy
         H1GVDMJpnT0JCRj0Sqf8bbMg0achl+RbXWZ5ShQQ6oE7eGwQmm99nDWau0Vdst8gC3sT
         wvmxtzb0hG/boCR55HQrpFe7bziLh2G/KAtmfS9eDdOpqPym/HiIU6Ztsr4XdYOtJjfD
         pHhm+JcMHOQnGsfOQwdcNbHr1nebQdfcmoO6HUthZXsxpRykfFfe+xPfAGo64HpAwATr
         MtXg==
X-Gm-Message-State: AOAM531vNFGrfIHeK2m5Q9JcYVlTuOOfcwyPc4Ao8xlnqjtYFtRI/mQG
        TKzcd7R5BV+xiF+3fjw5T2R85trV1BheLeHI9h35
X-Google-Smtp-Source: ABdhPJx7AKfYXL3TgYlEMbJf2Fdkx2iKb3yoWupi6td22Z7Oc8sjBtLyd3b/41vINEkoFeoBuSd0oiB9MxgKEiCdIpo=
X-Received: by 2002:a0d:df58:0:b0:2ff:222d:1a9f with SMTP id
 i85-20020a0ddf58000000b002ff222d1a9fmr18417405ywe.38.1653206958720; Sun, 22
 May 2022 01:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220521193356.26562-1-palmer@rivosinc.com>
In-Reply-To: <20220521193356.26562-1-palmer@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 22 May 2022 01:09:07 -0700
Message-ID: <CAOnJCUKZuXN2Zao_42GVyHFrfZ2UUOA0ZkUF21qWtDsvW-L4JA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Add CONFIG_{NON,}PORTABLE
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        damien.lemoal@opensource.wdc.com,
        Atish Patra <atishp@rivosinc.com>, axboe@kernel.dk,
        Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 1:47 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
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
> +       bool "Allow configurations that result in non-portable kernels"
> +       help
> +         RISC-V kernel binaries are compatible between all known systems
> +         whenever possible, but there are some use cases that can only be
> +         satisfied by configurations that result in kernel binaries that are
> +         not portable between systems.
> +
> +         Selecting N does not guarantee kernels will be portable to all known
> +         systems.  Selecting any of the options guarded by NONPORTABLE will
> +         result in kernel binaries that are unlikely to be portable between
> +         systems.
> +
> +         If unsure, say N.
> +
>  choice
>         prompt "Base ISA"
>         default ARCH_RV64I
> @@ -231,6 +246,7 @@ choice
>
>  config ARCH_RV32I
>         bool "RV32I"
> +       depends on NONPORTABLE
>         select 32BIT
>         select GENERIC_LIB_ASHLDI3
>         select GENERIC_LIB_ASHRDI3
> @@ -541,6 +557,7 @@ config STACKPROTECTOR_PER_TASK
>
>  config PHYS_RAM_BASE_FIXED
>         bool "Explicitly specified physical RAM address"
> +       depends on NONPORTABLE
>         default n
>
>  config PHYS_RAM_BASE
> @@ -554,7 +571,7 @@ config PHYS_RAM_BASE
>
>  config XIP_KERNEL
>         bool "Kernel Execute-In-Place from ROM"
> -       depends on MMU && SPARSEMEM
> +       depends on MMU && SPARSEMEM && NONPORTABLE
>         # This prevents XIP from being enabled by all{yes,mod}config, which
>         # fail to build since XIP doesn't support large kernels.
>         depends on !COMPILE_TEST
> @@ -594,9 +611,16 @@ endmenu
>
>  config BUILTIN_DTB
>         bool
> -       depends on OF
> +       depends on OF && NONPORTABLE
>         default y if XIP_KERNEL
>
> +config PORTABLE
> +       bool
> +       default !NONPORTABLE
> +       select EFI
> +       select OF
> +       select MMU
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
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
