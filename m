Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354534BAB16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbiBQUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:31:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiBQUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:31:42 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A326FA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:31:25 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id j2so15598445ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdrCI2LwRpxbl9wGOAl4n1XIVj2Fj2khn5uMFexHT3Y=;
        b=D85zyJPy4/GqVSAQrGhMvav4xzS8Dge8OEbQ6PrE3nSUU5l29DVyB/tJl3Vq1M/WAs
         1LjX0/osWoKJ2jugjBfzLo+LkyyHh04go/FUOrSY5mgZ1XumyVwJGXyIuu5mXdialoh+
         NvtTgJNntj3ArfEeZSqG/BUPxd27OKrva69mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdrCI2LwRpxbl9wGOAl4n1XIVj2Fj2khn5uMFexHT3Y=;
        b=03edr50r2FJNv6Jf9n+GQ2mtNNNTdj1sAL/maMM5S7p1pqBoLH5f3Lg5NFmD9lSY/b
         Lnlxf+95FhIfq3/5sOrSihW4ditQxMse1RIAeyq9ymYVWB5syqUfhzAlqtGEfX9CQ641
         go59hs3yDrbnpuC1Yzh8UvCr104Oe7+ClVNPZE6V5lyv671iW6ArsiDLVceGWIxMFVaJ
         JvIoItI100ib08b5f7o+0KmvTIJ9ecA4i56ObpnS+93TtRlxH9gxvIViZWbkpdXGG/Ni
         tat2Mq0sdbOC7Ijpbcj8INsLW17PtfhCMkmgbaz8BIu80i0y2YyK1KARXhopFeIIETYn
         Dspg==
X-Gm-Message-State: AOAM5320fPKvUeABDKMIdNQWAiQfHpbThA0uYnCkp5iHnSoeh4ErME3p
        BG6hs4Rrg1tv/JBbn8dRAQxB6ogmSRKo/3enwQkD
X-Google-Smtp-Source: ABdhPJx7Zc4Xri0kCligRSbT1b+r4J26VVpxP0pQsSE+g/CTVUVgDVGXlzCchOkZTQsZSl7TCoX6cL9fZqGJ2PeF/zM=
X-Received: by 2002:a25:d858:0:b0:623:f93c:7e97 with SMTP id
 p85-20020a25d858000000b00623f93c7e97mr4166828ybg.53.1645129884359; Thu, 17
 Feb 2022 12:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-7-atishp@rivosinc.com>
 <CAAhSdy3gayK2rW5Kztje_V33S87dWw0fDuHOLJqKvNL=irNkOQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3gayK2rW5Kztje_V33S87dWw0fDuHOLJqKvNL=irNkOQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 17 Feb 2022 12:31:13 -0800
Message-ID: <CAOnJCU+ZuGgZZhzE+XOBoKTZQ865v4XLbmECuut4LMS2KPnnyw@mail.gmail.com>
Subject: Re: [v5 6/9] RISC-V: Add perf platform driver based on SBI PMU extension
To:     Anup Patel <anup@brainfault.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:30 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > From: Atish Patra <atish.patra@wdc.com>
> >
> > RISC-V SBI specification added a PMU extension that allows to configure
> > start/stop any pmu counter. The RISC-V perf can use most of the generic
> > perf features except interrupt overflow and event filtering based on
> > privilege mode which will be added in future.
> >
> > It also allows to monitor a handful of firmware counters that can provide
> > insights into firmware activity during a performance analysis.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/Kconfig         |  10 +
> >  drivers/perf/Makefile        |   1 +
> >  drivers/perf/riscv_pmu.c     |   2 +
> >  drivers/perf/riscv_pmu_sbi.c | 558 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 571 insertions(+)
> >  create mode 100644 drivers/perf/riscv_pmu_sbi.c
> >
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 6bd12663c8d3..b2b78bd34df4 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -76,6 +76,16 @@ config RISCV_PMU_LEGACY
> >           of cycle/instruction counter and doesn't support counter overflow,
> >           or programmable counters. It will be removed in future.
> >
> > +config RISCV_PMU_SBI
> > +       depends on RISCV_PMU && RISCV_SBI
> > +       bool "RISC-V PMU based on SBI PMU extension"
> > +       default y
> > +       help
> > +         Say y if you want to use the CPU performance monitor
> > +         using SBI PMU extension on RISC-V based systems. This option provides
> > +         full perf feature support i.e. counter overflow, privilege mode
> > +         filtering, counter configuration.
> > +
> >  config ARM_PMU_ACPI
> >         depends on ARM_PMU && ACPI
> >         def_bool y
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index e8aa666a9d28..7bcac4b5a983 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> >  obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
> >  ifeq ($(CONFIG_RISCV_PMU), y)
> >  obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
> > +obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
> >  endif
> >  obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
> >  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index 83c3e8d085c7..970542a82c4a 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/printk.h>
> >  #include <linux/smp.h>
> >
> > +#include <asm/sbi.h>
> > +
> >  static unsigned long csr_read_num(int csr_num)
> >  {
> >  #define switchcase_csr_read(__csr_num, __val)          {\
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > new file mode 100644
> > index 000000000000..f078d423a89a
> > --- /dev/null
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -0,0 +1,558 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RISC-V performance counter support.
> > + *
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + *
> > + * This code is based on ARM perf event code which is in turn based on
> > + * sparc64 and x86 code.
> > + */
> > +
>
> Add here
> #define pr_fmt(fmt) "riscv-pmu-sbi: " fmt
>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/perf/riscv_pmu.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/sbi.h>
> > +
> > +union sbi_pmu_ctr_info {
> > +       unsigned long value;
> > +       struct {
> > +               unsigned long csr:12;
> > +               unsigned long width:6;
> > +#if __riscv_xlen == 32
> > +               unsigned long reserved:13;
> > +#else
> > +               unsigned long reserved:45;
> > +#endif
> > +               unsigned long type:1;
> > +       };
> > +};
> > +
> > +/**
> > + * RISC-V doesn't have hetergenous harts yet. This need to be part of
> > + * per_cpu in case of harts with different pmu counters
> > + */
> > +static union sbi_pmu_ctr_info *pmu_ctr_list;
> > +
> > +struct pmu_event_data {
>
> I suggest renaming pmu_event_data to sbi_pmu_event_data
> for consistency.
>
> > +       union {
> > +               union {
> > +                       struct hw_gen_event {
> > +                               uint32_t event_code:16;
> > +                               uint32_t event_type:4;
> > +                               uint32_t reserved:12;
> > +                       } hw_gen_event;
> > +                       struct hw_cache_event {
> > +                               uint32_t result_id:1;
> > +                               uint32_t op_id:2;
> > +                               uint32_t cache_id:13;
> > +                               uint32_t event_type:4;
> > +                               uint32_t reserved:12;
> > +                       } hw_cache_event;
> > +               };
> > +               uint32_t event_idx;
> > +       };
> > +};
> > +
> > +static const struct pmu_event_data pmu_hw_event_map[] = {
> > +       [PERF_COUNT_HW_CPU_CYCLES]              = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_CPU_CYCLES,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_INSTRUCTIONS]            = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_INSTRUCTIONS,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_CACHE_REFERENCES]        = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_CACHE_REFERENCES,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_CACHE_MISSES]            = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_CACHE_MISSES,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_BRANCH_INSTRUCTIONS,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_BRANCH_MISSES]           = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_BRANCH_MISSES,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_BUS_CYCLES]              = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_BUS_CYCLES,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_STALLED_CYCLES_FRONTEND,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_STALLED_CYCLES_BACKEND,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +       [PERF_COUNT_HW_REF_CPU_CYCLES]          = {.hw_gen_event = {
> > +                                                       SBI_PMU_HW_REF_CPU_CYCLES,
> > +                                                       SBI_PMU_EVENT_TYPE_HW, 0}},
> > +};
> > +
> > +#define C(x) PERF_COUNT_HW_CACHE_##x
> > +static const struct pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> > +[PERF_COUNT_HW_CACHE_OP_MAX]
> > +[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> > +       [C(L1D)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_READ), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(L1D), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +       [C(L1I)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS), C(OP_READ),
> > +                                       C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(L1I), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +       [C(LL)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_READ), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(LL), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +       [C(DTLB)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_READ), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(DTLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +       [C(ITLB)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_READ), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(ITLB), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +       [C(BPU)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_READ), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(BPU), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +       [C(NODE)] = {
> > +               [C(OP_READ)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_READ), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_READ), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_WRITE)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_WRITE), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_WRITE), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +               [C(OP_PREFETCH)] = {
> > +                       [C(RESULT_ACCESS)] = {.hw_cache_event = {C(RESULT_ACCESS),
> > +                                       C(OP_PREFETCH), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +                       [C(RESULT_MISS)] = {.hw_cache_event = {C(RESULT_MISS),
> > +                                       C(OP_PREFETCH), C(NODE), SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > +               },
> > +       },
> > +};
> > +
> > +static int pmu_sbi_ctr_get_width(int idx)
> > +{
> > +       return pmu_ctr_list[idx].width;
> > +}
> > +
> > +static int pmu_sbi_ctr_get_idx(struct perf_event *event)
> > +{
> > +       struct hw_perf_event *hwc = &event->hw;
> > +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> > +       struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
> > +       struct sbiret ret;
> > +       int idx;
> > +       uint64_t cbase = 0;
> > +       uint64_t cmask = GENMASK_ULL(rvpmu->num_counters - 1, 0);
> > +       unsigned long cflags = 0;
> > +
> > +       if (event->attr.exclude_kernel)
> > +               cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
> > +       else if (event->attr.exclude_user)
> > +               cflags |= SBI_PMU_CFG_FLAG_SET_UINH;
> > +
> > +       /* retrieve the available counter index */
> > +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
> > +                       cflags, hwc->event_base, hwc->config, 0);
> > +       if (ret.error) {
> > +               pr_debug("Not able to find a counter for event %lx config %llx\n",
> > +                       hwc->event_base, hwc->config);
> > +               return sbi_err_map_linux_errno(ret.error);
> > +       }
> > +
> > +       idx = ret.value;
> > +       if (idx >= rvpmu->num_counters || !pmu_ctr_list[idx].value)
> > +               return -ENOENT;
> > +
> > +       /* Additional sanity check for the counter id */
> > +       if (!test_and_set_bit(idx, cpuc->used_event_ctrs))
> > +               return idx;
> > +       else
> > +               return -ENOENT;
> > +}
> > +
> > +static void pmu_sbi_ctr_clear_idx(struct perf_event *event)
> > +{
> > +
> > +       struct hw_perf_event *hwc = &event->hw;
> > +       struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> > +       struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
> > +       int idx = hwc->idx;
> > +
> > +       clear_bit(idx, cpuc->used_event_ctrs);
> > +}
> > +
> > +static int pmu_event_find_cache(u64 config)
> > +{
> > +       unsigned int cache_type, cache_op, cache_result, ret;
> > +
> > +       cache_type = (config >>  0) & 0xff;
> > +       if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
> > +               return -EINVAL;
> > +
> > +       cache_op = (config >>  8) & 0xff;
> > +       if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
> > +               return -EINVAL;
> > +
> > +       cache_result = (config >> 16) & 0xff;
> > +       if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
> > +               return -EINVAL;
> > +
> > +       ret = pmu_cache_event_map[cache_type][cache_op][cache_result].event_idx;
> > +
> > +       return ret;
> > +}
> > +
> > +static bool pmu_sbi_is_fw_event(struct perf_event *event)
> > +{
> > +       u32 type = event->attr.type;
> > +       u64 config = event->attr.config;
> > +
> > +       if ((type == PERF_TYPE_RAW) && ((config >> 63) == 1))
> > +               return true;
> > +       else
> > +               return false;
> > +}
> > +
> > +static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
> > +{
> > +       u32 type = event->attr.type;
> > +       u64 config = event->attr.config;
> > +       int bSoftware;
> > +       u64 raw_config_val;
> > +       int ret;
> > +
> > +       switch (type) {
> > +       case PERF_TYPE_HARDWARE:
> > +               if (config >= PERF_COUNT_HW_MAX)
> > +                       return -EINVAL;
> > +               ret = pmu_hw_event_map[event->attr.config].event_idx;
> > +               break;
> > +       case PERF_TYPE_HW_CACHE:
> > +               ret = pmu_event_find_cache(config);
> > +               break;
> > +       case PERF_TYPE_RAW:
> > +               /*
> > +                * As per SBI specification, the upper 16 bits must be unused for
> > +                * a raw event. Use the MSB (63b) to distinguish between hardware
> > +                * raw event and firmware events.
> > +                */
> > +               bSoftware = config >> 63;
> > +               raw_config_val = config & RISCV_PMU_RAW_EVENT_MASK;
> > +               if (bSoftware) {
> > +                       if (raw_config_val < SBI_PMU_FW_MAX)
> > +                               ret = (raw_config_val & 0xFFFF) |
> > +                                     (SBI_PMU_EVENT_TYPE_FW << 16);
> > +                       else
> > +                               return -EINVAL;
> > +               } else {
> > +                       ret = RISCV_PMU_RAW_EVENT_IDX;
> > +                       *econfig = raw_config_val;
> > +               }
> > +               break;
> > +       default:
> > +               ret = -EINVAL;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static u64 pmu_sbi_ctr_read(struct perf_event *event)
> > +{
> > +       struct hw_perf_event *hwc = &event->hw;
> > +       int idx = hwc->idx;
> > +       struct sbiret ret;
> > +       union sbi_pmu_ctr_info info;
> > +       u64 val = 0;
> > +
> > +       if (pmu_sbi_is_fw_event(event)) {
> > +               ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
> > +                               hwc->idx, 0, 0, 0, 0, 0);
> > +               if (!ret.error)
> > +                       val = ret.value;
> > +       } else {
> > +               info = pmu_ctr_list[idx];
> > +               val = riscv_pmu_ctr_read_csr(info.csr);
> > +               if (IS_ENABLED(CONFIG_32BIT))
> > +                       val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
> > +       }
> > +
> > +       return val;
> > +}
> > +
> > +static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
> > +{
> > +       struct sbiret ret;
> > +       struct hw_perf_event *hwc = &event->hw;
> > +       unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
> > +
> > +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
> > +                       1, flag, ival, ival >> 32, 0);
> > +       if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
> > +               pr_err("Starting counter idx %d failed with error %d\n",
> > +                       hwc->idx, sbi_err_map_linux_errno(ret.error));
> > +}
> > +
> > +static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
> > +{
> > +       struct sbiret ret;
> > +       struct hw_perf_event *hwc = &event->hw;
> > +
> > +       //disable IRQ
> > +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
> > +       if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
> > +               flag != SBI_PMU_STOP_FLAG_RESET)
> > +               pr_err("Stopping counter idx %d failed with error %d\n",
> > +                       hwc->idx, sbi_err_map_linux_errno(ret.error));
> > +}
> > +
> > +static int pmu_sbi_find_num_ctrs(void)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0, 0, 0, 0, 0, 0);
> > +       if (!ret.error)
> > +               return ret.value;
> > +       else
> > +               return sbi_err_map_linux_errno(ret.error);
> > +}
> > +
> > +static int pmu_sbi_get_ctrinfo(int nctr)
> > +{
> > +       struct sbiret ret;
> > +       int i, num_hw_ctr = 0, num_fw_ctr = 0;
> > +       union sbi_pmu_ctr_info cinfo;
> > +
> > +       pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
> > +       if (!pmu_ctr_list)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i <= nctr; i++) {
> > +               ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
> > +               if (ret.error)
> > +                       /* The logical counter ids are not expected to be contiguous */
> > +                       continue;
> > +               cinfo.value = ret.value;
> > +               if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
> > +                       num_fw_ctr++;
> > +               else
> > +                       num_hw_ctr++;
> > +               pmu_ctr_list[i].value = cinfo.value;
> > +       }
> > +
> > +       pr_info("There are %d firmware & %d hardware counters available\n",
> > +               num_fw_ctr, num_hw_ctr);
>
> Replace this with:
> pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
>
> > +
> > +       return 0;
> > +}
> > +
> > +static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
> > +{
> > +       struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
> > +
> > +       /* Enable the access for TIME csr only from the user mode now */
> > +       csr_write(CSR_SCOUNTEREN, 0x2);
> > +
> > +       /* Stop all the counters so that they can be enabled from perf */
> > +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > +                 0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
> > +{
> > +       /* Disable all counters access for user mode now */
> > +       csr_write(CSR_SCOUNTEREN, 0x0);
> > +
> > +       return 0;
> > +}
> > +
> > +static int pmu_sbi_device_probe(struct platform_device *pdev)
> > +{
> > +       struct riscv_pmu *pmu = NULL;
> > +       int num_counters;
> > +       int ret;
> > +
> > +       pr_info("SBI PMU extension is available\n");
> > +       /* Notify legacy implementation that SBI pmu is available*/
> > +       riscv_pmu_legacy_init(true);
> > +       pmu = riscv_pmu_alloc();
> > +       if (!pmu)
> > +               return -ENOMEM;
> > +
> > +       num_counters = pmu_sbi_find_num_ctrs();
> > +       if (num_counters < 0) {
> > +               pr_err("SBI PMU extension doesn't provide any counters\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* cache all the information about counters now */
> > +       if (pmu_sbi_get_ctrinfo(num_counters))
> > +               return -ENODEV;
> > +
> > +       pmu->num_counters = num_counters;
> > +       pmu->ctr_start = pmu_sbi_ctr_start;
> > +       pmu->ctr_stop = pmu_sbi_ctr_stop;
> > +       pmu->event_map = pmu_sbi_event_map;
> > +       pmu->ctr_get_idx = pmu_sbi_ctr_get_idx;
> > +       pmu->ctr_get_width = pmu_sbi_ctr_get_width;
> > +       pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
> > +       pmu->ctr_read = pmu_sbi_ctr_read;
> > +
> > +       ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> > +       if (ret) {
> > +               cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver pmu_sbi_driver = {
> > +       .probe          = pmu_sbi_device_probe,
> > +       .driver         = {
> > +               .name   = RISCV_PMU_PDEV_NAME,
> > +       },
> > +};
> > +
> > +static int __init pmu_sbi_devinit(void)
> > +{
> > +       int ret;
> > +       struct platform_device *pdev;
> > +
> > +       if (((sbi_major_version() == 0) && (sbi_minor_version() < 3)) ||
>
> Compare SBI version using sbi_spec_version and sbi_mk_version()
>
> sbi_mk_version() is added by Linux SRST patch.
>
> > +               sbi_probe_extension(SBI_EXT_PMU) <= 0) {
> > +               return 0;
> > +       }
> > +
> > +       ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
> > +                                     "perf/riscv/pmu:starting",
> > +                                     pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
> > +       if (ret) {
> > +               pr_err("CPU hotplug notifier for RISC-V PMU could not be registered: %d\n",
> > +                      ret);
>
> Drop the "RISC-V PMU" in the pr_err().
>
> > +               return ret;
> > +       }
> > +
> > +       ret = platform_driver_register(&pmu_sbi_driver);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
> > +       if (IS_ERR(pdev)) {
> > +               platform_driver_unregister(&pmu_sbi_driver);
> > +               return PTR_ERR(pdev);
> > +       }
> > +
> > +       return ret;
> > +}
> > +device_initcall(pmu_sbi_devinit)
> > --
> > 2.33.1
> >
>
> Regards,
> Anup

Thanks for the review. I have addressed all the comments.

-- 
Regards,
Atish
