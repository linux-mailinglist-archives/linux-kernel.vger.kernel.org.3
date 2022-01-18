Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E659491EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 06:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiARFCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 00:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiARFCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 00:02:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC3C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 21:02:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c66so24976734wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 21:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1+aC/STIpQ1VxiMCKTPApyfp7uu7Wnsh90RJe3Ry4M=;
        b=NjwYiy2bdfrvOkMYhFF0zuCg21A04xFXgwuh777563vG2YAzbMpuwTgIfb311d9TjB
         /eiOoFLf1E2K+cojAdSjmRoJUwmV6Tc+FhRqITU5PScBvin6FbWU3GVv4jWnhRdK5brS
         zVA5DzzNFqTkADegkPYfuWKs4nBC0aJ3R3P8ywj0ZG+tzCnU/9pQzGVWIDRoaTS4FWwv
         cyQiD0h/gnBesbWjVtRZuKY8oUdzU7dvy/ttOC2Nyq+GpafH5RzEgOthLYvwwhXkJUTL
         /h4YTFviAZU52dpf5bgJaMzLcndHPI8bX7DZsR8Kx3PxYESD/sxNjcVDH+XvliwGTpsa
         26uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1+aC/STIpQ1VxiMCKTPApyfp7uu7Wnsh90RJe3Ry4M=;
        b=XNVdOYUuvjXuP4ZlBJlkrx5ojPfC3tBw7413EzoOCtpkSjzLwD6ieO3m5mKQNZgxql
         0vQjoDDO9ZWm1Qlcwns2xeY5dZ4EsBK0qHZhNT3xBD8Zj1B2jpGJukMMlrRu7XSdJf92
         TZcEQ5ZkqGHlFCqE0ZbZYRAk1TKTMLIMyCjRS0aw35uDGXZPjnLdPiBLeuQjvb6USHqU
         NtsWkvYR3H4lPgSvtenJAhz+daUvXoa3SPub9W6Xv3t4zNTOJvxqCeA5h9Kmy9Nwk5rf
         Rxjm7mvJcgnjH1Q33oDipoXum1dvsUIc/JFE1PCobjSgjaPHhyjFtObwC6vuhg8EGbEi
         SLGg==
X-Gm-Message-State: AOAM5309+Wjx/9SrlnHgFwXs/eW38QVvzdvPAca2l0IkQBoHlwW7JJJH
        9OiYeoZd1Q5ec2TMSuyfYlqJfZKLdRa9lkWJxU4uqA==
X-Google-Smtp-Source: ABdhPJyHF+Iz8cjs9sR6x0pM88zKu4Vs8ZUgAI4AZywcD5svPyfZ0wfqQSJp9/AqC/Hc5D6yUobjGpakdFRnD5VnVA8=
X-Received: by 2002:a1c:a786:: with SMTP id q128mr1624466wme.176.1642482129695;
 Mon, 17 Jan 2022 21:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-4-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-4-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Jan 2022 10:31:57 +0530
Message-ID: <CAAhSdy3YW63VDvN+AS4asqcQcGi9ztJ_H2R0h4JjYQCQXam2+g@mail.gmail.com>
Subject: Re: [v5 3/9] RISC-V: Add a perf core library for pmu drivers
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
> Implement a perf core library that can support all the essential perf
> features in future. It can also accommodate any type of PMU implementation
> in future. Currently, both SBI based perf driver and legacy driver
> implemented uses the library. Most of the common perf functionalities
> are kept in this core library wile PMU specific driver can implement PMU
> specific features. For example, the SBI specific functionality will be
> implemented in the SBI specific driver.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/Kconfig           |  10 +
>  drivers/perf/Makefile          |   1 +
>  drivers/perf/riscv_pmu.c       | 328 +++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h     |   1 +
>  include/linux/perf/riscv_pmu.h |  65 +++++++
>  5 files changed, 405 insertions(+)
>  create mode 100644 drivers/perf/riscv_pmu.c
>  create mode 100644 include/linux/perf/riscv_pmu.h
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 77522e5efe11..03ca0315df73 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -56,6 +56,16 @@ config ARM_PMU
>           Say y if you want to use CPU performance monitors on ARM-based
>           systems.
>
> +config RISCV_PMU
> +       depends on RISCV
> +       bool "RISC-V PMU framework"
> +       default y
> +       help
> +         Say y if you want to use CPU performance monitors on RISCV-based
> +         systems. This provides the core PMU framework that abstracts common
> +         PMU functionalities in a core library so that different PMU drivers
> +         can reuse it.
> +
>  config ARM_PMU_ACPI
>         depends on ARM_PMU && ACPI
>         def_bool y
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 5260b116c7da..76e5c50e24bb 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
>  obj-$(CONFIG_HISI_PMU) += hisilicon/
>  obj-$(CONFIG_QCOM_L2_PMU)      += qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> +obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
>  obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> new file mode 100644
> index 000000000000..83c3e8d085c7
> --- /dev/null
> +++ b/drivers/perf/riscv_pmu.c
> @@ -0,0 +1,328 @@
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
> +#include <linux/cpumask.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/perf/riscv_pmu.h>
> +#include <linux/printk.h>
> +#include <linux/smp.h>
> +
> +static unsigned long csr_read_num(int csr_num)
> +{
> +#define switchcase_csr_read(__csr_num, __val)          {\
> +       case __csr_num:                                 \
> +               __val = csr_read(__csr_num);            \
> +               break; }
> +#define switchcase_csr_read_2(__csr_num, __val)                {\
> +       switchcase_csr_read(__csr_num + 0, __val)        \
> +       switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)                {\
> +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> +       switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)                {\
> +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> +       switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)       {\
> +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> +       switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)       {\
> +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> +       switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +       unsigned long ret = 0;
> +
> +       switch (csr_num) {
> +       switchcase_csr_read_32(CSR_CYCLE, ret)
> +       switchcase_csr_read_32(CSR_CYCLEH, ret)
> +       default :
> +               break;
> +       }
> +
> +       return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +/*
> + * Read the CSR of a corresponding counter.
> + */
> +unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
> +{
> +       if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> +          (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
> +               pr_err("Invalid performance counter csr %lx\n", csr);
> +               return -EINVAL;
> +       }
> +
> +       return csr_read_num(csr);
> +}
> +
> +uint64_t riscv_pmu_ctr_get_width_mask(struct perf_event *event)

Use u64 inplace of uint64_t for consistency.

> +{
> +       int cwidth;
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +
> +       if (!rvpmu->ctr_get_width)
> +       /**
> +        * If the pmu driver doesn't support counter width, set it to default maximum
> +        * allowed by the specification.
> +        */

Improve indentation of this comment block and ensure it does not go
beyond 80 characters.

> +               cwidth = 63;
> +       else {
> +               if (hwc->idx == -1)
> +                       /* Handle init case where idx is not initialized yet */
> +                       cwidth = rvpmu->ctr_get_width(0);
> +               else
> +                       cwidth = rvpmu->ctr_get_width(hwc->idx);
> +       }
> +
> +       return GENMASK_ULL(cwidth, 0);
> +}
> +
> +u64 riscv_pmu_event_update(struct perf_event *event)
> +{
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       u64 prev_raw_count, new_raw_count;
> +       unsigned long cmask;
> +       u64 oldval, delta;
> +
> +       if (!rvpmu->ctr_read)
> +               return 0;
> +
> +       cmask = riscv_pmu_ctr_get_width_mask(event);
> +
> +       do {
> +               prev_raw_count = local64_read(&hwc->prev_count);
> +               new_raw_count = rvpmu->ctr_read(event);
> +               oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +                                        new_raw_count);
> +       } while (oldval != prev_raw_count);
> +
> +       delta = (new_raw_count - prev_raw_count) & cmask;
> +       local64_add(delta, &event->count);
> +       local64_sub(delta, &hwc->period_left);
> +
> +       return delta;
> +}
> +
> +static void riscv_pmu_stop(struct perf_event *event, int flags)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +
> +       WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +
> +       if (!(hwc->state & PERF_HES_STOPPED)) {
> +               if (rvpmu->ctr_stop) {
> +                       rvpmu->ctr_stop(event, 0);
> +                       hwc->state |= PERF_HES_STOPPED;
> +               }
> +               riscv_pmu_event_update(event);
> +               hwc->state |= PERF_HES_UPTODATE;
> +       }
> +}
> +
> +int riscv_pmu_event_set_period(struct perf_event *event)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       s64 left = local64_read(&hwc->period_left);
> +       s64 period = hwc->sample_period;
> +       int overflow = 0;
> +       uint64_t max_period = riscv_pmu_ctr_get_width_mask(event);
> +
> +       if (unlikely(left <= -period)) {
> +               left = period;
> +               local64_set(&hwc->period_left, left);
> +               hwc->last_period = period;
> +               overflow = 1;
> +       }
> +
> +       if (unlikely(left <= 0)) {
> +               left += period;
> +               local64_set(&hwc->period_left, left);
> +               hwc->last_period = period;
> +               overflow = 1;
> +       }
> +
> +       /*
> +        * Limit the maximum period to prevent the counter value
> +        * from overtaking the one we are about to program. In
> +        * effect we are reducing max_period to account for
> +        * interrupt latency (and we are being very conservative).
> +        */
> +       if (left > (max_period >> 1))
> +               left = (max_period >> 1);
> +
> +       local64_set(&hwc->prev_count, (u64)-left);
> +       perf_event_update_userpage(event);
> +
> +       return overflow;
> +}
> +
> +static void riscv_pmu_start(struct perf_event *event, int flags)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +       uint64_t max_period = riscv_pmu_ctr_get_width_mask(event);
> +       u64 init_val;
> +
> +       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> +               return;
> +
> +       if (flags & PERF_EF_RELOAD) {
> +               WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> +
> +               /*
> +                * Set the counter to the period to the next interrupt here,
> +                * if you have any.
> +                */

This comment block is not followed by any code.

Do you expect code to be added in future ?

> +       }
> +
> +       hwc->state = 0;
> +       riscv_pmu_event_set_period(event);
> +       init_val = local64_read(&hwc->prev_count) & max_period;
> +       rvpmu->ctr_start(event, init_val);
> +       perf_event_update_userpage(event);
> +}
> +
> +static int riscv_pmu_add(struct perf_event *event, int flags)
> +{
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
> +       struct hw_perf_event *hwc = &event->hw;
> +       int idx;
> +
> +       idx = rvpmu->ctr_get_idx(event);
> +       if (idx < 0)
> +               return idx;
> +
> +       hwc->idx = idx;
> +       cpuc->events[idx] = event;
> +       cpuc->n_events++;
> +       hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> +       if (flags & PERF_EF_START)
> +               riscv_pmu_start(event, PERF_EF_RELOAD);
> +
> +       /* Propagate our changes to the userspace mapping. */
> +       perf_event_update_userpage(event);
> +
> +       return 0;
> +}
> +
> +static void riscv_pmu_del(struct perf_event *event, int flags)
> +{
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
> +       struct hw_perf_event *hwc = &event->hw;
> +
> +       riscv_pmu_stop(event, PERF_EF_UPDATE);
> +       cpuc->events[hwc->idx] = NULL;
> +       /* The firmware need to reset the counter mapping */
> +       if (rvpmu->ctr_stop)
> +               rvpmu->ctr_stop(event, RISCV_PMU_STOP_FLAG_RESET);
> +       cpuc->n_events--;
> +       if (rvpmu->ctr_clear_idx)
> +               rvpmu->ctr_clear_idx(event);
> +       perf_event_update_userpage(event);
> +       hwc->idx = -1;
> +}
> +
> +static void riscv_pmu_read(struct perf_event *event)
> +{
> +       riscv_pmu_event_update(event);
> +}
> +
> +static int riscv_pmu_event_init(struct perf_event *event)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +       int mapped_event;
> +       u64 event_config = 0;
> +       uint64_t cmask;
> +
> +       hwc->flags = 0;
> +       mapped_event = rvpmu->event_map(event, &event_config);
> +       if (mapped_event < 0) {
> +               pr_debug("event %x:%llx not supported\n", event->attr.type,
> +                        event->attr.config);
> +               return mapped_event;
> +       }
> +
> +       /*
> +        * idx is set to -1 because the index of a general event should not be
> +        * decided until binding to some counter in pmu->add().
> +        * config will contain the information about counter CSR
> +        * the idx will contain the counter index
> +        */
> +       hwc->config = event_config;
> +       hwc->idx = -1;
> +       hwc->event_base = mapped_event;
> +
> +       if (!is_sampling_event(event)) {
> +               /*
> +                * For non-sampling runs, limit the sample_period to half
> +                * of the counter width. That way, the new counter value
> +                * is far less likely to overtake the previous one unless
> +                * you have some serious IRQ latency issues.
> +                */
> +               cmask = riscv_pmu_ctr_get_width_mask(event);
> +               hwc->sample_period  =  cmask >> 1;
> +               hwc->last_period    = hwc->sample_period;
> +               local64_set(&hwc->period_left, hwc->sample_period);
> +       }
> +
> +       return 0;
> +}
> +
> +struct riscv_pmu *riscv_pmu_alloc(void)
> +{
> +       struct riscv_pmu *pmu;
> +       int cpuid, i;
> +       struct cpu_hw_events *cpuc;
> +
> +       pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
> +       if (!pmu)
> +               goto out;
> +
> +       pmu->hw_events = alloc_percpu_gfp(struct cpu_hw_events, GFP_KERNEL);
> +       if (!pmu->hw_events) {
> +               pr_info("failed to allocate per-cpu PMU data.\n");
> +               goto out_free_pmu;
> +       }
> +
> +       for_each_possible_cpu(cpuid) {
> +               cpuc = per_cpu_ptr(pmu->hw_events, cpuid);
> +               cpuc->n_events = 0;
> +               for (i = 0; i < RISCV_MAX_COUNTERS; i++)
> +                       cpuc->events[i] = NULL;
> +       }
> +       pmu->pmu = (struct pmu) {
> +               .event_init     = riscv_pmu_event_init,
> +               .add            = riscv_pmu_add,
> +               .del            = riscv_pmu_del,
> +               .start          = riscv_pmu_start,
> +               .stop           = riscv_pmu_stop,
> +               .read           = riscv_pmu_read,
> +       };
> +
> +       return pmu;
> +
> +out_free_pmu:
> +       kfree(pmu);
> +out:
> +       return NULL;
> +}
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 39cf84a30b9f..1743b8a4624d 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -123,6 +123,7 @@ enum cpuhp_state {
>         CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
>         CPUHP_AP_PERF_ARM_ACPI_STARTING,
>         CPUHP_AP_PERF_ARM_STARTING,
> +       CPUHP_AP_PERF_RISCV_STARTING,

First of all, CPUHP_AP_PERF_RISCV_STARTING should not
be part of this patch.

In general, we should avoid adding RISC-V specific HP state
if CPUHP_AP_ONLINE_DYN is sufficient.

>         CPUHP_AP_ARM_L2X0_STARTING,
>         CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>         CPUHP_AP_ARM_ARCH_TIMER_STARTING,
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> new file mode 100644
> index 000000000000..0d8979765d79
> --- /dev/null
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 SiFive
> + * Copyright (C) 2018 Andes Technology Corporation
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + *
> + */
> +
> +#ifndef _ASM_RISCV_PERF_EVENT_H
> +#define _ASM_RISCV_PERF_EVENT_H
> +
> +#include <linux/perf_event.h>
> +#include <linux/ptrace.h>
> +#include <linux/interrupt.h>
> +
> +#ifdef CONFIG_RISCV_PMU
> +
> +/*
> + * The RISCV_MAX_COUNTERS parameter should be specified.
> + */
> +
> +#define RISCV_MAX_COUNTERS     64
> +#define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
> +#define RISCV_PMU_PDEV_NAME    "riscv-pmu"
> +
> +#define RISCV_PMU_STOP_FLAG_RESET 1
> +
> +struct cpu_hw_events {
> +       /* currently enabled events */
> +       int                     n_events;
> +       /* currently enabled events */
> +       struct perf_event       *events[RISCV_MAX_COUNTERS];
> +       /* currently enabled counters */
> +       DECLARE_BITMAP(used_event_ctrs, RISCV_MAX_COUNTERS);
> +};
> +
> +struct riscv_pmu {
> +       struct pmu      pmu;
> +       char            *name;
> +
> +       irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> +
> +       int             num_counters;
> +       u64             (*ctr_read)(struct perf_event *event);
> +       int             (*ctr_get_idx)(struct perf_event *event);
> +       int             (*ctr_get_width)(int idx);
> +       void            (*ctr_clear_idx)(struct perf_event *event);
> +       void            (*ctr_start)(struct perf_event *event, u64 init_val);
> +       void            (*ctr_stop)(struct perf_event *event, unsigned long flag);
> +       int             (*event_map)(struct perf_event *event, u64 *config);
> +
> +       struct cpu_hw_events    __percpu *hw_events;
> +       struct hlist_node       node;
> +};
> +
> +#define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))
> +unsigned long riscv_pmu_ctr_read_csr(unsigned long csr);
> +int riscv_pmu_event_set_period(struct perf_event *event);
> +uint64_t riscv_pmu_ctr_get_width_mask(struct perf_event *event);
> +u64 riscv_pmu_event_update(struct perf_event *event);
> +struct riscv_pmu *riscv_pmu_alloc(void);
> +
> +#endif /* CONFIG_RISCV_PMU */
> +
> +#endif /* _ASM_RISCV_PERF_EVENT_H */
> --
> 2.33.1
>

Apart from minor comments above, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
