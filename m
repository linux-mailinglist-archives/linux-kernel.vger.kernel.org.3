Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A914B7C18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbiBPAu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiBPAu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:50:57 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CBF9540
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:50:45 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y129so1254168ybe.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18yu/FZC6YEfqqlag7jyriW5vrB8+cTbyqFvDzZCLG8=;
        b=m5LQ24g7yrUGMPrnK27dqe7h8K7PMML+kc3AYdjuLbCttuSnZSjrFawQgnI8h8+h1l
         QHs3tnwESiGMBTpQjgxnWPdVydoP9FV7bIXyTkN6uNw1Pzl53BKxnOwqjHf0jDfFwkyK
         kLObIYhW7r6uO/+vuUqzoiBQF6D0T2vJp00PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18yu/FZC6YEfqqlag7jyriW5vrB8+cTbyqFvDzZCLG8=;
        b=tCn2eOovMqEZtJN1fdGvrHAwIrr+kX/oTO3YYNRcgMoChwv2qFfjHtE58nAkfVZ+7Y
         aG424lZbWQcmN6qIZdqStezg+n3n8I35My4RQmTnx7d9d9+Z4jveLz1vHCgd1f9HnPQU
         GLhm169X/fkAbgFoSjz+F6HHfKng/L3SJ43GjJKXztEioF2YaWPxaMIP3xdUV4qs1mqS
         FfK2y3wXTwGkJedxeXyS2NDWZBSPyuNVic0Wc7bfw3YmA5FDmkMH8osbTOuVMHBqw5X4
         7y3OV2ToAA8smwNdTmmnEAjZ8YR7NnD21hyMPD/e8bCioa7rNLBv3P8ID3j1T5bRxJkA
         nmug==
X-Gm-Message-State: AOAM532n6mfQ1hzSNfjOPUzVg+2QcTdtv3TxSftQOq+eBSiKTG5RMjJ2
        C8+q7qpgFogds+zzp4QjE5sU0TOypBi/0LqvgCV6
X-Google-Smtp-Source: ABdhPJx67wiA2c7TRCt7KLNgmAukw1N2cuPI35FME1jEWpQi813t8VWMQWQ8NWmSSyx+WjEjM8rWelbT5PIMS9p4jHE=
X-Received: by 2002:a25:9388:0:b0:61d:6ff8:6472 with SMTP id
 a8-20020a259388000000b0061d6ff86472mr194270ybm.121.1644972644540; Tue, 15 Feb
 2022 16:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com> <20220210054947.170134-2-apatel@ventanamicro.com>
In-Reply-To: <20220210054947.170134-2-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 15 Feb 2022 16:50:33 -0800
Message-ID: <CAOnJCUKyzY_DNWqm32so0MOBcii1QCfF4KTq35Y06erALNx8Ug@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 9:50 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> We force select CPU_PM and provide asm/cpuidle.h so that we can
> use CPU IDLE drivers for Linux RISC-V kernel.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@vetanamicro.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                |  7 +++++++
>  arch/riscv/configs/defconfig      |  1 +
>  arch/riscv/configs/rv32_defconfig |  1 +
>  arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/process.c       |  3 ++-
>  5 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5adcbd9b5e88..76976d12b463 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,6 +46,7 @@ config RISCV
>         select CLONE_BACKWARDS
>         select CLINT_TIMER if !MMU
>         select COMMON_CLK
> +       select CPU_PM if CPU_IDLE
>         select EDAC_SUPPORT
>         select GENERIC_ARCH_TOPOLOGY if SMP
>         select GENERIC_ATOMIC64 if !64BIT
> @@ -547,4 +548,10 @@ source "kernel/power/Kconfig"
>
>  endmenu
>
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>  source "arch/riscv/kvm/Kconfig"
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f120fcc43d0a..a5e0482a4969 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
> +CONFIG_CPU_IDLE=y
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM=m
>  CONFIG_JUMP_LABEL=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 8b56a7f1eb06..d1b87db54d68 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
> +CONFIG_CPU_IDLE=y
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM=m
>  CONFIG_JUMP_LABEL=y
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> new file mode 100644
> index 000000000000..71fdc607d4bc
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021 Allwinner Ltd
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef _ASM_RISCV_CPUIDLE_H
> +#define _ASM_RISCV_CPUIDLE_H
> +
> +#include <asm/barrier.h>
> +#include <asm/processor.h>
> +
> +static inline void cpu_do_idle(void)
> +{
> +       /*
> +        * Add mb() here to ensure that all
> +        * IO/MEM accesses are completed prior
> +        * to entering WFI.
> +        */
> +       mb();
> +       wait_for_interrupt();
> +}
> +
> +#endif
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 03ac3aa611f5..504b496787aa 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -23,6 +23,7 @@
>  #include <asm/string.h>
>  #include <asm/switch_to.h>
>  #include <asm/thread_info.h>
> +#include <asm/cpuidle.h>
>
>  register unsigned long gp_in_global __asm__("gp");
>
> @@ -37,7 +38,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
>
>  void arch_cpu_idle(void)
>  {
> -       wait_for_interrupt();
> +       cpu_do_idle();
>         raw_local_irq_enable();
>  }
>
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
