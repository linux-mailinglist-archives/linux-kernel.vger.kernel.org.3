Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59F7491ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 06:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiARFXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 00:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiARFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 00:23:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A001C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 21:23:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso3011157wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 21:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HArCxtgmaAUtHv2EkJWX43r7m5jT88idzjgN10lSzvg=;
        b=FcJ24fjHTLf6zTemywoAEeEZLg6z+KppHcW/fWc6qgOGHMMNMEqHHUC5SyxgB604+e
         zbXFg3KFkIgMU1O8oiPpWkEy9/IIToAVrwuvYmilDXt5GKlTLpdbrJBs+rbuolJyZo3z
         At3TgzqbV790Mi2jwBrMmsFLUDjUvPRMGeUfKSVvIY3JGbI6WGINj8ut9Ii4b7eUaOA2
         Al9JuXkOX0B9kZIg01sX/lHbp33fBj3HrRcgIeg7S5Ve3likMCmkbw80MAzXoLJhy6m7
         YwDAofQn+PgCA+9s/w9gGcvimGfBp2TMLpBqN1pD5ENVuUEMnbC5xHomoNqMSy4jhars
         IrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HArCxtgmaAUtHv2EkJWX43r7m5jT88idzjgN10lSzvg=;
        b=H6JacpRNSdBhHD7Le/kSnZsciiM9geca0JfhK/LAdGQYIvItcewBMKme0feOH7B3uW
         ME2oQ3dVab8voK94azlgr95d2fwDJtMrYkBh6kq/av5K+NN+QbZUB5Q7DQovHFHN6SPT
         OCztv8EGl+oKdklV7HPDB2gtIGkwTxMoOArBzu9bJBOsPaQVxi4pmU4/h0pEhjjXcd85
         ssoqLd7/J1mL+y+k15p460ItshP2f7usBtD0CFlH2O0M4fhEtY+134lZuiLRLdP9Q5v1
         AMlgE2pihQzK/2a0pQr0TynoXndzzvMxxN4c4ML7PNXygqf4XDjhxbFjGgTJnXme7yiD
         u3Fg==
X-Gm-Message-State: AOAM533Ipwf4TTaO4ubWKuZHxpUF3KeoYoN4u0MQeP67W8s/ZwSCrBHb
        zFWi1QpeYo2d9smJWkfxS4TEdSMKLcHwHp3Or830Sw==
X-Google-Smtp-Source: ABdhPJwVRwrzMl6GQKLqAhaaYxifwRl1R0tSpKmmp7g+cj5TnMk/du5kPQdyodgo5wPc4OgUfyMIIN9wiCdS3n/J/bM=
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr22252928wrx.346.1642483409473;
 Mon, 17 Jan 2022 21:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-5-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-5-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Jan 2022 10:53:17 +0530
Message-ID: <CAAhSdy3RGxM5w8eQ-s0n0-__-S-GgRi98+cO89kRfAFN99a9eA@mail.gmail.com>
Subject: Re: [v5 4/9] RISC-V: Add a simple platform driver for RISC-V legacy perf
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

On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> From: Atish Patra <atish.patra@wdc.com>
>
> The old RISC-V perf implementation allowed counting of only
> cycle/instruction counters using perf. Restore that feature by implementing
> a simple platform driver under a separate config to provide backward
> compatibility. Any existing software stack will continue to work as it is.
> However, it provides an easy way out in future where we can remove the
> legacy driver.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/Kconfig            |  10 +++
>  drivers/perf/Makefile           |   3 +
>  drivers/perf/riscv_pmu_legacy.c | 143 ++++++++++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h  |   6 ++
>  4 files changed, 162 insertions(+)
>  create mode 100644 drivers/perf/riscv_pmu_legacy.c
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 03ca0315df73..6bd12663c8d3 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -66,6 +66,16 @@ config RISCV_PMU
>           PMU functionalities in a core library so that different PMU drivers
>           can reuse it.
>
> +config RISCV_PMU_LEGACY
> +       depends on RISCV_PMU
> +       bool "RISC-V legacy PMU implementation"
> +       default y
> +       help
> +         Say y if you want to use the legacy CPU performance monitor
> +         implementation on RISC-V based systems. This only allows counting
> +         of cycle/instruction counter and doesn't support counter overflow,
> +         or programmable counters. It will be removed in future.
> +
>  config ARM_PMU_ACPI
>         depends on ARM_PMU && ACPI
>         def_bool y
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 76e5c50e24bb..e8aa666a9d28 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -11,6 +11,9 @@ obj-$(CONFIG_HISI_PMU) += hisilicon/
>  obj-$(CONFIG_QCOM_L2_PMU)      += qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>  obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
> +ifeq ($(CONFIG_RISCV_PMU), y)
> +obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
> +endif

RISCV_PMU_LEGACY already depends on RISCV_PMU.

Do you still need this "ifeq ()" check ?

>  obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> new file mode 100644
> index 000000000000..8bb973f2d9f7
> --- /dev/null
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V performance counter support.
> + *
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + *
> + * This implementation is based on old RISC-V perf and ARM perf event code
> + * which are in turn based on sparc64 and x86 code.
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/perf/riscv_pmu.h>
> +#include <linux/platform_device.h>
> +
> +#define RISCV_PMU_LEGACY_CYCLE         0
> +#define RISCV_PMU_LEGACY_INSTRET       1
> +#define RISCV_PMU_LEGACY_NUM_CTR       2
> +
> +bool pmu_init_done;

This should be a static variable.

> +
> +static int pmu_legacy_ctr_get_idx(struct perf_event *event)
> +{
> +       struct perf_event_attr *attr = &event->attr;
> +
> +       if (event->attr.type != PERF_TYPE_HARDWARE)
> +               return -EOPNOTSUPP;
> +       if (attr->config == PERF_COUNT_HW_CPU_CYCLES)
> +               return RISCV_PMU_LEGACY_CYCLE;
> +       else if (attr->config == PERF_COUNT_HW_INSTRUCTIONS)
> +               return RISCV_PMU_LEGACY_INSTRET;
> +       else
> +               return -EOPNOTSUPP;
> +}
> +
> +/* For legacy config & counter index are same */
> +static int pmu_legacy_event_map(struct perf_event *event, u64 *config)
> +{
> +       return pmu_legacy_ctr_get_idx(event);
> +}
> +
> +static u64 pmu_legacy_read_ctr(struct perf_event *event)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       int idx = hwc->idx;
> +       u64 val;
> +
> +       if (idx == RISCV_PMU_LEGACY_CYCLE) {
> +               val = riscv_pmu_ctr_read_csr(CSR_CYCLE);
> +               if (IS_ENABLED(CONFIG_32BIT))
> +                       val = (u64)riscv_pmu_ctr_read_csr(CSR_CYCLEH) << 32 | val;
> +       } else if (idx == RISCV_PMU_LEGACY_INSTRET) {
> +               val = riscv_pmu_ctr_read_csr(CSR_INSTRET);
> +               if (IS_ENABLED(CONFIG_32BIT))
> +                       val = ((u64)riscv_pmu_ctr_read_csr(CSR_INSTRETH)) << 32 | val;
> +       } else
> +               return 0;
> +
> +       return val;
> +}
> +
> +static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       u64 initial_val = pmu_legacy_read_ctr(event);
> +
> +       /**
> +        * The legacy method doesn't really have a start/stop method.
> +        * It also can not update the counter with a initial value.
> +        * But we still need to set the prev_count so that read() can compute
> +        * the delta. Just use the current counter value to set the prev_count.
> +        */
> +       local64_set(&hwc->prev_count, initial_val);
> +}
> +
> +/**
> + * This is just a simple implementation to allow legacy implementations
> + * compatible with new RISC-V PMU driver framework.
> + * This driver only allows reading two counters i.e CYCLE & INSTRET.
> + * However, it can not start or stop the counter. Thus, it is not very useful
> + * will be removed in future.
> + */
> +static void pmu_legacy_init(struct riscv_pmu *pmu)
> +{
> +       pr_info("Legacy PMU implementation is available\n");
> +
> +       pmu->num_counters = RISCV_PMU_LEGACY_NUM_CTR;
> +       pmu->ctr_start = pmu_legacy_ctr_start;
> +       pmu->ctr_stop = NULL;
> +       pmu->event_map = pmu_legacy_event_map;
> +       pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
> +       pmu->ctr_get_width = NULL;
> +       pmu->ctr_clear_idx = NULL;
> +       pmu->ctr_read = pmu_legacy_read_ctr;
> +
> +       perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> +}
> +
> +static int pmu_legacy_device_probe(struct platform_device *pdev)
> +{
> +       struct riscv_pmu *pmu = NULL;
> +
> +       pmu = riscv_pmu_alloc();
> +       if (!pmu)
> +               return -ENOMEM;
> +       pmu_legacy_init(pmu);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver pmu_legacy_driver = {
> +       .probe          = pmu_legacy_device_probe,
> +       .driver         = {
> +               .name   = RISCV_PMU_LEGACY_PDEV_NAME,
> +       },
> +};
> +
> +static int __init riscv_pmu_legacy_devinit(void)
> +{
> +       int ret;
> +       struct platform_device *pdev;
> +
> +       if (likely(pmu_init_done))
> +               return 0;
> +
> +       ret = platform_driver_register(&pmu_legacy_driver);
> +       if (ret)
> +               return ret;
> +
> +       pdev = platform_device_register_simple(RISCV_PMU_LEGACY_PDEV_NAME, -1, NULL, 0);
> +       if (IS_ERR(pdev)) {
> +               platform_driver_unregister(&pmu_legacy_driver);
> +               return PTR_ERR(pdev);
> +       }
> +
> +       return ret;
> +}
> +late_initcall(riscv_pmu_legacy_devinit);
> +
> +void riscv_pmu_legacy_init(bool done)

I would suggest renaming riscv_pmu_legacy_init()
to riscv_pmu_legacy_skip_init().

Also, no need for "done" parameter.

> +{
> +       if (done)
> +               pmu_init_done = true;

I would also suggest renaming "pmu_init_done" to
"legacy_pmu_init_done" or something similar.

> +}
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index 0d8979765d79..52672de540c2 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -22,6 +22,7 @@
>  #define RISCV_MAX_COUNTERS     64
>  #define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
>  #define RISCV_PMU_PDEV_NAME    "riscv-pmu"
> +#define RISCV_PMU_LEGACY_PDEV_NAME     "riscv-pmu-legacy"
>
>  #define RISCV_PMU_STOP_FLAG_RESET 1
>
> @@ -58,6 +59,11 @@ unsigned long riscv_pmu_ctr_read_csr(unsigned long csr);
>  int riscv_pmu_event_set_period(struct perf_event *event);
>  uint64_t riscv_pmu_ctr_get_width_mask(struct perf_event *event);
>  u64 riscv_pmu_event_update(struct perf_event *event);
> +#ifdef CONFIG_RISCV_PMU_LEGACY
> +void riscv_pmu_legacy_init(bool init_done);
> +#else
> +static inline void riscv_pmu_legacy_init(bool init_done) {};
> +#endif
>  struct riscv_pmu *riscv_pmu_alloc(void);
>
>  #endif /* CONFIG_RISCV_PMU */
> --
> 2.33.1
>

Apart from minor comments above, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
