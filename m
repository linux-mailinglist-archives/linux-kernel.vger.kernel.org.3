Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60F7477AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhLPRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:41:00 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40468 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhLPRk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:40:59 -0500
Received: by mail-oi1-f177.google.com with SMTP id bk14so37487297oib.7;
        Thu, 16 Dec 2021 09:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvM4pWL0Gw/4g/v0OOWEpHn5Lyoi5nrgGLBD7DlESpc=;
        b=fNfPNurOC9nkZ9fMokkaGw5Fe/7LBVgC6PCmfhSD8axrIassXJyvoqxzC6GWnBN1kM
         Be3HOt+WMme1khD0XSmmna2uZNHhPUDIrUgonHcanW79ycBQCDt8qM8AoEZx3faGPz/f
         XA8SsSSU0JE9/zWb8074wK8DdmwMPi6bKLLqrKUjuOv7qN/K0CQP1hKBFrrYijL5nj2o
         mZvoLMh7uD0qLcVlATmMJ1k536mwFJABJ70YsYifx/1nVNtmubzv5ExvO9q13OHpg41U
         Wkl+0VmgtW9V6oPtUJ8Yzr841MvM/VL4EqoSzr7P3DPZfwPrrpwTgNh9NMyB9T2RozZ1
         iftw==
X-Gm-Message-State: AOAM53196gJZorNija9pwN4dcAP0efZKF1rDx8sX6+ZrTDkuJkANoLef
        OZSPf1gEwCu190THUYxANpmY8mwxAtY/Kik06xQ=
X-Google-Smtp-Source: ABdhPJwRqLneoxuZhlcf26QcE7ye4XoGD9N01aDroI4AA2nuGlbXM2oXjaOnJHbZt9luEda0lIuhxXP3YcZmAt7SgXo=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr4947095oih.51.1639676458870;
 Thu, 16 Dec 2021 09:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com> <20211130123641.1449041-4-ray.huang@amd.com>
In-Reply-To: <20211130123641.1449041-4-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Dec 2021 18:40:47 +0100
Message-ID: <CAJZ5v0iTnQYpj6aZBa8ZqUQN-TJCK0GLRhK1-mdXEX1iPpkjxA@mail.gmail.com>
Subject: Re: [PATCH v5 03/22] ACPI: CPPC: implement support for SystemIO registers
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
>
> From: Steven Noonan <steven@valvesoftware.com>
>
> According to the ACPI v6.2 (and later) specification, SystemIO can be
> used for _CPC registers. This teaches cppc_acpi how to handle such
> registers.
>
> This patch was tested using the amd_pstate driver on my Zephyrus G15
> (model GA503QS) using the current version 410 BIOS, which uses
> a SystemIO register for the HighestPerformance element in _CPC.
>
> Signed-off-by: Steven Noonan <steven@valvesoftware.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 46 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a85c351589be..ca62c3dc9899 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -746,9 +746,24 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                                                 goto out_free;
>                                         cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
>                                 }
> +                       } else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +                               if (gas_t->access_width < 1 || gas_t->access_width > 3) {
> +                                       /* 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit. SystemIO doesn't

The comment format is not in agreement with the kernel coding style.

> +                                        * implement 64-bit registers.
> +                                        */
> +                                       pr_debug("Invalid access width %d for SystemIO register\n",
> +                                               gas_t->access_width);
> +                                       goto out_free;
> +                               }
> +                               if (gas_t->address & ~0xFFFFULL) {

It would be good to define a symbol for this mask and use it here
instead of the raw vaue.

> +                                       /* SystemIO registers use 16-bit integer addresses */
> +                                       pr_debug("Invalid IO port %llu for SystemIO register\n",
> +                                               gas_t->address);
> +                                       goto out_free;
> +                               }
>                         } else {
>                                 if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
> -                                       /* Support only PCC ,SYS MEM and FFH type regs */
> +                                       /* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
>                                         pr_debug("Unsupported register type: %d\n", gas_t->space_id);
>                                         goto out_free;
>                                 }
> @@ -923,7 +938,20 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>         }
>
>         *val = 0;
> -       if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> +
> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +               u32 width = 8 << (reg->access_width - 1);
> +               acpi_status status;
> +
> +               status = acpi_os_read_port((acpi_io_address)reg->address, (u32 *)val, width);
> +
> +               if (status != AE_OK) {

Please use ACPI_FAILURE() here and in the analogous check and below.

> +                       pr_debug("Error: Failed to read SystemIO port %llx\n", reg->address);
> +                       return -EFAULT;
> +               }
> +
> +               return 0;
> +       } else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
>                 vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>         else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 vaddr = reg_res->sys_mem_vaddr;
> @@ -962,7 +990,19 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>
> -       if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +               u32 width = 8 << (reg->access_width - 1);
> +               acpi_status status;
> +
> +               status = acpi_os_write_port((acpi_io_address)reg->address, (u32)val, width);
> +
> +               if (status != AE_OK) {
> +                       pr_debug("Error: Failed to write SystemIO port %llx\n", reg->address);
> +                       return -EFAULT;
> +               }
> +
> +               return 0;
> +       } else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
>                 vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>         else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 vaddr = reg_res->sys_mem_vaddr;
> --
