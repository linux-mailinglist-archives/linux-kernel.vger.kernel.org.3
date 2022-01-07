Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F1748798D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbiAGPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiAGPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:13:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDCC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:13:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w20so11612242wra.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRWXVVqeT2yMH9OFKjUKf879QdNlFXMuI2vDxLIhIrA=;
        b=VXk4WCQGziswu+VM2czJLmhqnzBpA8E4s5qdkyYPo91024Y5scQ0OB9NGgDWEZtkuL
         D5oictgbbCeLbWt5UlFvCBx662C9Dk/D+dPlewJ+xvDsbxmopmXeFikqEuYjujQ5pyMQ
         C9U4QQFEvqtPdNP32D6CsPONvcKTZa5ofgT4OcuBlCevakTQm4VL+yvtYB8J/9ZNQCO4
         LDgBS5A2ElHT6qZ9c3cv2zzc3joN27n9H63si+C3dPDGW+aTmuf6f+YsZDRU8z4K0BVI
         4b7ZMQVBywqnJ03QmLZzZ9+ryg3gAiDEY6n0BbyDWPUxePDBwdsxX4lJrA8t6o70Wz/s
         77eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRWXVVqeT2yMH9OFKjUKf879QdNlFXMuI2vDxLIhIrA=;
        b=w7kesVAue9ZoNt/HgzICOGPGrvRE04EHGlFjysVy2xrScyzmwv/lrYYfA44NtdAzQv
         ZjNSnnoVevteh6VVnbtwnWqh6sK+TC4De9+W1afQ5V+HAXDQa3FUAY0gJyl+We+IhlY4
         6TcOpNXqTibY8JboJUfdZhF65mzyDA/gcvkIJOPmlYcd4pJQaZKgymLFeIOkNBNl5A5l
         RIPFuUTW8ZS6EwBBx7axFYm7mGtKNEkb4kNedShVU2lwPUOV3PpwdXpHS2EF0GaGVLU2
         Edl/LjRIkOKiHNe9MZqSrlGmkV/eFzm8r3FpL2l8v+VxthEmZzmXcBg20rJS+L/fQJnQ
         tIlQ==
X-Gm-Message-State: AOAM530W2HAa5sep+LCIW0PQ+z1Jr7ZzJwteaI2ouYg+a3E46YnEHEJ2
        xa3V4HDWK1qMvBWYxpJ5I0k9eW3hk5KvMBCE5UkzvXqCxgsrpw==
X-Google-Smtp-Source: ABdhPJwub4Q3b54YQN6p3Bd75DoQbiRyO2WpWifkKFp5sCPoF/b8OV7ao9Za0hJKKOg4cnWb1f2uc0Ov5eCtAVDkn40=
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr54351490wrd.346.1641568394655;
 Fri, 07 Jan 2022 07:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20211228223057.2772727-1-atishp@rivosinc.com> <20211228223057.2772727-2-atishp@rivosinc.com>
In-Reply-To: <20211228223057.2772727-2-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 7 Jan 2022 20:43:02 +0530
Message-ID: <CAAhSdy0S_uJR7jueEpvwMzt4k6yqh4_pS5qdBwyCTjeNwuLPDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] RISC-V: Avoid using per cpu array for ordered booting
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 4:01 AM Atish Patra <atishp@atishpatra.org> wrote:
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
>  arch/riscv/include/asm/cpu_ops_sbi.h | 25 +++++++++++++++++++++++++
>  arch/riscv/kernel/asm-offsets.c      |  3 +++
>  arch/riscv/kernel/cpu_ops_sbi.c      | 23 ++++++++++++++++++++---
>  arch/riscv/kernel/head.S             | 19 ++++++++++---------
>  4 files changed, 58 insertions(+), 12 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h
>
> diff --git a/arch/riscv/include/asm/cpu_ops_sbi.h b/arch/riscv/include/asm/cpu_ops_sbi.h
> new file mode 100644
> index 000000000000..90e2219f5eec
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu_ops_sbi.h
> @@ -0,0 +1,25 @@
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
> +#endif /* ifndef __ASM_CPU_OPS_H */

s/__ASM_CPU_OPS_H /__ASM_CPU_OPS_SBI_H/

> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 253126e4beef..df0519a64eaf 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -12,6 +12,7 @@
>  #include <asm/kvm_host.h>
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
> +#include <asm/cpu_ops_sbi.h>
>
>  void asm_offsets(void);
>
> @@ -468,4 +469,6 @@ void asm_offsets(void)
>         DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
>
>         OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
> +       OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_ptr);
> +       OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
>  }
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

s/paralle/parallel/

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

No need for the rc variable here.

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

Apart from minor nits above, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
