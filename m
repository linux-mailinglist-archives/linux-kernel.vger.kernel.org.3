Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA82472C90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhLMMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhLMMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:49:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAF1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:49:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so10832203wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iO5vzlIer6fDLM0na/dQ5p5rFP8hEKcj8s5Xpjl6kgY=;
        b=1ZTTzXKH5Xq/6YAoxUA5Kc2BVqvi5x9kyiglHTiwHaKtzCjDFkO7M9lK8bk6atQBJ+
         mI4tnIZpWnIWJuoQSIuWgPlcnk85SiA9UMlOqgnpqNSpIl1Mp9Y+4og2J9cozSxm66hE
         pQO99cPml2YaizauvbEb0oq5FEAYAK8mm9UxWoDL2LQ1VRdrTd6bN+VsWt/T0ud2psaU
         3bP5GQzLiyJ7xGV4OSwo22T6XZ3V5UaE2S6f5seM2kzS6VYO2u7Z9BZvw2y6Nd4Avvtv
         RfPK/R2XtzFsI/Xo7i4UDvTPP6lH+4xGtalynCxhcv8ahJ0vxTfMbHY2uk5lifJ4a3cw
         fxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iO5vzlIer6fDLM0na/dQ5p5rFP8hEKcj8s5Xpjl6kgY=;
        b=OLdndyTzN+SZm3Woa9FuH4rk3COZhAcxjKzgHykCzKElioEn/VhXtR/CqGdM74agWD
         nzXUDDB68DCZ1yunXtfdof39AfO2HhpOy5+4EEBFRmHz+lg9GKjjcvo9i8hm/C4F89Zc
         KSaIT2aOUYm9/MHQ/JlPiLZP/5JRyuxY1w1KVFyQUCTSI026oMs6zqb7t6lqUj56VNqR
         id19mCSIKv7b+hfYPExy0eq9mtD7LsmpCijWGsCTm7ifure7o8wPYe6ZgYsgIgpK6jTe
         jFs5fvQPuLYIHiSKxYi5QjehU+7j/M51HVRJ1vrBr13D6qL0M1wemPf8Lrnn1O+Knlc2
         KWlg==
X-Gm-Message-State: AOAM533FuZDnw5M6+WJT6+/xBNYULwSYxju0eM48zrsTPyTrDKAVV4Ek
        7LwJswT5Yvwh1y5wlZnkMN5CI5T+DOA5pXuaYtSCbg==
X-Google-Smtp-Source: ABdhPJw3LIWsqBsi9zA/gDWa8zURWNMqpMgPLjxX8qetHHIkurbkUF1StBBOKu/1WzjQfQfXd3TbSK1gUlnB9QAZhKY=
X-Received: by 2002:a7b:c256:: with SMTP id b22mr37111462wmj.176.1639399750405;
 Mon, 13 Dec 2021 04:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20211204002038.113653-1-atishp@atishpatra.org> <20211204002038.113653-2-atishp@atishpatra.org>
In-Reply-To: <20211204002038.113653-2-atishp@atishpatra.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 13 Dec 2021 18:18:59 +0530
Message-ID: <CAAhSdy2YsrGSk4P41hneNkJJg6je9fMYV9-py6vim=ZEexigOQ@mail.gmail.com>
Subject: Re: [RFC 1/6] RISC-V: Avoid using per cpu array for ordered booting
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 5:50 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> Currently both order booting and spinwait approach uses a per cpu
> array to update stack & task pointer. This approach will not work for the
> following cases.
> 1. If NR_CPUs are configured to be less than highest hart id.
> 2. A platform has sparse hartid.
>
> This issue can be fixed for ordered booting as the booting cpu brings up
> one cpu at a time using SBI HSM extension which has opaque parameter
> that is unused until now.
>
> Introduce a common secondary boot data structure that can store the stack
> and task pointer. Secondary harts will use this data while booting up
> to setup the sp & tp.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpu_ops_sbi.h | 28 ++++++++++++++++++++++++++++
>  arch/riscv/kernel/cpu_ops_sbi.c      | 23 ++++++++++++++++++++---
>  arch/riscv/kernel/head.S             | 19 ++++++++++---------
>  3 files changed, 58 insertions(+), 12 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h
>
> diff --git a/arch/riscv/include/asm/cpu_ops_sbi.h b/arch/riscv/include/asm/cpu_ops_sbi.h
> new file mode 100644
> index 000000000000..ccb9a6d30486
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu_ops_sbi.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 by Rivos Inc.
> + */
> +#ifndef __ASM_CPU_OPS_SBI_H
> +#define __ASM_CPU_OPS_SBI_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/threads.h>
> +
> +/**
> + * struct sbi_hart_boot_data - Hart specific boot used during booting and
> + *                            cpu hotplug.
> + * @task_ptr: A pointer to the hart specific tp
> + * @stack_ptr: A pointer to the hart specific sp
> + */
> +struct sbi_hart_boot_data {
> +       void *task_ptr;
> +       void *stack_ptr;
> +};
> +#endif
> +
> +#define SBI_HART_BOOT_TASK_PTR_OFFSET (0x00)
> +#define SBI_HART_BOOT_STACK_PTR_OFFSET RISCV_SZPTR

Don't manually create these defines instead generate this
defines at compile time by adding entries in kernel/asm-offsets.c

> +
> +#endif /* ifndef __ASM_CPU_OPS_H */
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 685fae72b7f5..2e7a9dd9c2a7 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -7,13 +7,22 @@
>
>  #include <linux/init.h>
>  #include <linux/mm.h>
> +#include <linux/sched/task_stack.h>
>  #include <asm/cpu_ops.h>
> +#include <asm/cpu_ops_sbi.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
>
>  extern char secondary_start_sbi[];
>  const struct cpu_operations cpu_ops_sbi;
>
> +/*
> + * Ordered booting via HSM brings one cpu at a time. However, cpu hotplug can
> + * be invoked from multiple threads in paralle. Define a per cpu data
> + * to handle that.
> + */
> +DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
> +
>  static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
>                               unsigned long priv)
>  {
> @@ -58,9 +67,17 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
>         int rc;
>         unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
>         int hartid = cpuid_to_hartid_map(cpuid);
> -
> -       cpu_update_secondary_bootdata(cpuid, tidle);
> -       rc = sbi_hsm_hart_start(hartid, boot_addr, 0);
> +       unsigned long hsm_data;
> +       struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
> +
> +       /* Make sure tidle is updated */
> +       smp_mb();
> +       bdata->task_ptr = tidle;
> +       bdata->stack_ptr = task_stack_page(tidle) + THREAD_SIZE;
> +       /* Make sure boot data is updated */
> +       smp_mb();
> +       hsm_data = __pa(bdata);
> +       rc = sbi_hsm_hart_start(hartid, boot_addr, hsm_data);
>
>         return rc;
>  }
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index f52f01ecbeea..40d4c625513c 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -11,6 +11,7 @@
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  #include <asm/csr.h>
> +#include <asm/cpu_ops_sbi.h>
>  #include <asm/hwcap.h>
>  #include <asm/image.h>
>  #include "efi-header.S"
> @@ -167,15 +168,15 @@ secondary_start_sbi:
>         la a3, .Lsecondary_park
>         csrw CSR_TVEC, a3
>
> -       slli a3, a0, LGREG
> -       la a4, __cpu_up_stack_pointer
> -       XIP_FIXUP_OFFSET a4
> -       la a5, __cpu_up_task_pointer
> -       XIP_FIXUP_OFFSET a5
> -       add a4, a3, a4
> -       add a5, a3, a5
> -       REG_L sp, (a4)
> -       REG_L tp, (a5)
> +       /* a0 contains the hartid & a1 contains boot data */
> +       li a2, SBI_HART_BOOT_TASK_PTR_OFFSET
> +       XIP_FIXUP_OFFSET a2
> +       add a2, a2, a1
> +       REG_L tp, (a2)
> +       li a3, SBI_HART_BOOT_STACK_PTR_OFFSET
> +       XIP_FIXUP_OFFSET a3
> +       add a3, a3, a1
> +       REG_L sp, (a3)
>
>         .global secondary_start_common
>  secondary_start_common:
> --
> 2.33.1
>

Regards,
Anup
