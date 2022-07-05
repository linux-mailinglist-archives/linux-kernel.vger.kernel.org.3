Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5EB5662E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiGEGBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:01:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34CBCA5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:01:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q8so776711ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mO1q+AWOSmLKTy8jFw+7zUucWH/oMAIflCU4/IXPUEQ=;
        b=nydiw4CsMIXOqQF0Q0V7VG9j5KEtagzaxVeGzpQx5ZnwqPEenxq2dLenDT/yQWGkek
         RdN81TPW7gNccq3WGqvyCo6cfsGsJDWl+1jDYGH6ZMCU9b/QW1ePa927WeMVHwARTTZp
         SOxazPY0DnnCmGmTIYPYB4a4g0VYpaoYBXaJhvBC5R3Lu1E6/qhkWHVpZHbvITwp7lHP
         DGUQDb6+h2qkU3IU3+mxkmle+ID7HzGRGpR+hLmn1jQmggxSqTV3oh/rEeTkZpCyu2QN
         LxrDu+XcMaRT7oGo2vttmEiAIKWZzcyWQyz+rbnQJfyM6G7Wd89jKefqs6bVkYmILaaq
         wXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mO1q+AWOSmLKTy8jFw+7zUucWH/oMAIflCU4/IXPUEQ=;
        b=WMV8hNA/iwFeQzQtFsSt4rYW3f/iTsXaADm1fN5br0E5QndH1LXDxyHt5AH/0rVLZ7
         Zy/PnDlj+lb1mLBgTZNBDqLVLm21OKN6rRz0WDfXQ/+haGM4moyIW4WtXqQaHeO3wixI
         yrPMSZLanlpATKZbq9HegsP4FQQLSeBmzz55WzPShuck6yZQxmigQKlq9QMiAByNrRmr
         Dd5+rCgRiNGYkxRudYPbqdaZj2O6K40KJe5W+du8o7Jeo6rXSo0OSiXGrkoofwuuZmm0
         aldjVIlOCRq83taQi1v2DIrUebOFa+2248xjJ0V6m5Af7iK2QRpf1PyQUyxoFcl8oeCY
         exZw==
X-Gm-Message-State: AJIora+0CTQcpZWITotr5Qb4vfhlRR1uGuZFDvuZEBHEYsEKHyyoocWC
        y4BsrL1Qn8BKjkzEY7fang2emwoRi6tXsW6ebQZTxQ==
X-Google-Smtp-Source: AGRyM1sXsXu70dFHDJMygyKu5nMBdFdft7e+/mqDfFUNTdkdr/Bvx1qGPyCW17qsE4pgNzTfuWe3aNAZHrbToYA4x44=
X-Received: by 2002:a05:651c:12cb:b0:25b:fa3f:c3f with SMTP id
 11-20020a05651c12cb00b0025bfa3f0c3fmr15115234lje.364.1657000878771; Mon, 04
 Jul 2022 23:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
In-Reply-To: <20220418105305.1196665-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 5 Jul 2022 11:31:07 +0530
Message-ID: <CAK9=C2VQPm=pLSRM_k+8MFGdfriNmP+PLgQtCHvUuRJDN77ZMg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] RISC-V IPI Improvements
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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

Hi Marc and Thomas,

Just a friendly ping ...

On Mon, Apr 18, 2022 at 4:23 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> This series aims to improve IPI support in Linux RISC-V in following ways:
>  1) Treat IPIs as normal per-CPU interrupts instead of having custom RISC-V
>     specific hooks. This also makes Linux RISC-V IPI support aligned with
>     other architectures.
>  2) Remote TLB flushes and icache flushes should prefer local IPIs instead
>     of SBI calls whenever we have specialized hardware (such as RISC-V AIA
>     IMSIC and RISC-V SWI) which allows S-mode software to directly inject
>     IPIs without any assistance from M-mode runtime firmware.
>
> These patches were originally part of the "Linux RISC-V ACLINT Support"
> series but this now a separate series so that it can be merged independently
> of the "Linux RISC-V ACLINT Support" series.
> (Refer, https://lore.kernel.org/lkml/20211007123632.697666-1-anup.patel@wdc.com/)
>
> These patches are also a preparatory patches for the up-coming:
>  1) Linux RISC-V AIA support
>  2) KVM RISC-V TLB flush improvements
>  3) Linux RISC-V SWI support
>
> These patches can also be found in riscv_ipi_imp_v6 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v5:
>  - Rebased on Linux-5.18-rc3
>  - Used kernel doc style in PATCH3
>  - Removed redundant loop in ipi_mux_process() of PATCH3
>  - Removed "RISC-V" prefix form ipi_mux_chip.name of PATCH3
>  - Removed use of "this patch" in PATCH3 commit description
>  - Addressed few other nit comments in PATCH3
>
> Changes since v4:
>  - Rebased on Linux-5.17
>  - Includes new PATCH3 which adds mechanism to multiplex a single HW IPI
>
> Changes since v3:
>  - Rebased on Linux-5.17-rc6
>  - Updated PATCH2 to not export riscv_set_intc_hwnode_fn()
>  - Simplified riscv_intc_hwnode() in PATCH2
>
> Changes since v2:
>  - Rebased on Linux-5.17-rc4
>  - Updated PATCH2 to not create synthetic INTC fwnode and instead provide
>    a function which allows drivers to directly discover INTC fwnode
>
> Changes since v1:
>  - Use synthetic fwnode for INTC instead of irq_set_default_host() in PATCH2
>
> Anup Patel (7):
>   RISC-V: Clear SIP bit only when using SBI IPI operations
>   irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
>   genirq: Add mechanism to multiplex a single HW IPI
>   RISC-V: Treat IPIs as normal Linux IRQs
>   RISC-V: Allow marking IPIs as suitable for remote FENCEs
>   RISC-V: Use IPIs for remote TLB flush when possible
>   RISC-V: Use IPIs for remote icache flush when possible

Any further comments on this series ?

Regards,
Anup

>
>  arch/riscv/Kconfig                |   2 +
>  arch/riscv/include/asm/irq.h      |   4 +
>  arch/riscv/include/asm/sbi.h      |   2 +
>  arch/riscv/include/asm/smp.h      |  49 +++++---
>  arch/riscv/kernel/Makefile        |   1 +
>  arch/riscv/kernel/cpu-hotplug.c   |   3 +-
>  arch/riscv/kernel/irq.c           |  21 +++-
>  arch/riscv/kernel/sbi-ipi.c       |  60 +++++++++
>  arch/riscv/kernel/sbi.c           |  11 --
>  arch/riscv/kernel/smp.c           | 164 +++++++++++++------------
>  arch/riscv/kernel/smpboot.c       |   5 +-
>  arch/riscv/mm/cacheflush.c        |   5 +-
>  arch/riscv/mm/tlbflush.c          |  93 +++++++++++---
>  drivers/clocksource/timer-clint.c |  41 +++++--
>  drivers/irqchip/irq-riscv-intc.c  |  60 ++++-----
>  include/linux/irq.h               |  11 ++
>  kernel/irq/Kconfig                |   4 +
>  kernel/irq/Makefile               |   1 +
>  kernel/irq/ipi-mux.c              | 197 ++++++++++++++++++++++++++++++
>  19 files changed, 567 insertions(+), 167 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi-ipi.c
>  create mode 100644 kernel/irq/ipi-mux.c
>
> --
> 2.25.1
>
