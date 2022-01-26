Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85449CAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiAZNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiAZNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:32:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F229C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:32:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v74so19387703pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nMBvi5vcbT732F6x9peOkHOA9SbwLFs0OskyzfLNBnA=;
        b=SqSGZBNIILEKDpe08UErfIrmsa/aDFHdxuizXq5o9t7R1J6hLcD9RA9CWJyb7nCdMG
         xiYuiwWmrfeSg/st30zK7wDt5O7dJoffiSCU+XhkJa0F57gi7CrI8JkpvRXLKAH1KvXM
         oLNrt4EtHLHh8YEEH/Lv7Yp0Zesumyx6hVZPy1MzV75NygAWw70BSp+/E8cqOh4pIRfE
         fXbz4A5TymezpZMKibabT/wWhN9vUJO0ibIU77Lx5erG5YlmJXzG1maIQW6PAb5SvtAb
         9EN+f2bMQd5XDCbtn8U+oyY0Tcf8/ZwvbzVLjtMJv56muEP1BDfk+Fttr1qOTyeV7rIS
         eUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nMBvi5vcbT732F6x9peOkHOA9SbwLFs0OskyzfLNBnA=;
        b=7a+Vi+HnXEdRXe9GIAUWi3uKQ81M5oIIoxsIGdINUZl3CrL6jDae3t2XzzZJfSeChU
         DQOpfVx/8Pl9cwKszU03H7oJnw6MTirja1fYe65DOrHtvKgIq9QNuV/YTUupdKDdOC/p
         evMXVtvulNtHjIWvVfrKzXoVb4ATMRV6JPLPeVBRELIYZ5HmIhMbqUHqjSBCP6TNowPc
         ZYN74MHNCI7Re6+xDs8K3OYsCNBsge88J9pwgvweTYW5I5Z8XZ9old+GHF/RwmCpvDr3
         /dWalTP0X1QnQz1k35OgWdMDA1TzjzvR6UV1yVk8prt1sFM/Tr+fm022er3SAKLTXOZf
         9F2g==
X-Gm-Message-State: AOAM533IRY+DSgCV42Chv+srWcBg8zORZgTdZpVRhcgG97ZUKGnRuVEt
        HyBWbJY4BZxm7gZuOzBQHukI6v2GdRrPbQ2SIs3grg==
X-Google-Smtp-Source: ABdhPJw0WFHnpeRR41G/b/yjctBBabIqantvKZt06RO4J3uCStHnYg+a15BTp3KIpS4HnU7OdoNLCmISNt/LLQIvwUU=
X-Received: by 2002:a63:e5c:: with SMTP id 28mr2389661pgo.506.1643203974490;
 Wed, 26 Jan 2022 05:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-7-atishp@rivosinc.com>
 <CAAhSdy3gayK2rW5Kztje_V33S87dWw0fDuHOLJqKvNL=irNkOQ@mail.gmail.com>
 <CAPqJEFpVBp3bFd+bR-DwHKD=yFo4Sog5TCU8JLJFoGc-y_VteA@mail.gmail.com> <CAOnJCUK5MwF-T0TqGtZqmj+dEfV0gb7R82of0YgmWjBCmgh8VQ@mail.gmail.com>
In-Reply-To: <CAOnJCUK5MwF-T0TqGtZqmj+dEfV0gb7R82of0YgmWjBCmgh8VQ@mail.gmail.com>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Wed, 26 Jan 2022 21:32:42 +0800
Message-ID: <CAPqJEFr5qn=Ut=Vm22-Z+1KmCLj7KL7uGDM5rmwVFDDBC2oR+g@mail.gmail.com>
Subject: Re: [v5 6/9] RISC-V: Add perf platform driver based on SBI PMU extension
To:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Wed, Jan 26, 2022 at 4:20 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Jan 25, 2022 at 6:42 AM Eric Lin <eric.lin@sifive.com> wrote:
> >
> > Hi Atish,
> >
> > > On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> =
wrote:
> > > >
> > > > From: Atish Patra <atish.patra@wdc.com>
> > > >
> > > > RISC-V SBI specification added a PMU extension that allows to confi=
gure
> > > > start/stop any pmu counter. The RISC-V perf can use most of the gen=
eric
> > > > perf features except interrupt overflow and event filtering based o=
n
> > > > privilege mode which will be added in future.
> > > >
> > > > It also allows to monitor a handful of firmware counters that can p=
rovide
> > > > insights into firmware activity during a performance analysis.
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > ---
> > > >  drivers/perf/Kconfig         |  10 +
> > > >  drivers/perf/Makefile        |   1 +
> > > >  drivers/perf/riscv_pmu.c     |   2 +
> > > >  drivers/perf/riscv_pmu_sbi.c | 558 +++++++++++++++++++++++++++++++=
++++
> > > >  4 files changed, 571 insertions(+)
> > > >  create mode 100644 drivers/perf/riscv_pmu_sbi.c
> > > >
> > > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > > index 6bd12663c8d3..b2b78bd34df4 100644
> > > > --- a/drivers/perf/Kconfig
> > > > +++ b/drivers/perf/Kconfig
> > > > @@ -76,6 +76,16 @@ config RISCV_PMU_LEGACY
> > > >           of cycle/instruction counter and doesn't support counter =
overflow,
> > > >           or programmable counters. It will be removed in future.
> > > >
> > > > +config RISCV_PMU_SBI
> > > > +       depends on RISCV_PMU && RISCV_SBI
> > > > +       bool "RISC-V PMU based on SBI PMU extension"
> > > > +       default y
> > > > +       help
> > > > +         Say y if you want to use the CPU performance monitor
> > > > +         using SBI PMU extension on RISC-V based systems. This opt=
ion provides
> > > > +         full perf feature support i.e. counter overflow, privileg=
e mode
> > > > +         filtering, counter configuration.
> > > > +
> > > >  config ARM_PMU_ACPI
> > > >         depends on ARM_PMU && ACPI
> > > >         def_bool y
> > > > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > > > index e8aa666a9d28..7bcac4b5a983 100644
> > > > --- a/drivers/perf/Makefile
> > > > +++ b/drivers/perf/Makefile
> > > > @@ -13,6 +13,7 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > > >  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > > >  ifeq ($(CONFIG_RISCV_PMU), y)
> > > >  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
> > > > +obj-$(CONFIG_RISCV_PMU_SBI) +=3D riscv_pmu_sbi.o
> > > >  endif
> > > >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> > > >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> > > > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > > > index 83c3e8d085c7..970542a82c4a 100644
> > > > --- a/drivers/perf/riscv_pmu.c
> > > > +++ b/drivers/perf/riscv_pmu.c
> > > > @@ -15,6 +15,8 @@
> > > >  #include <linux/printk.h>
> > > >  #include <linux/smp.h>
> > > >
> > > > +#include <asm/sbi.h>
> > > > +
> > > >  static unsigned long csr_read_num(int csr_num)
> > > >  {
> > > >  #define switchcase_csr_read(__csr_num, __val)          {\
> > > > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_=
sbi.c
> > > > new file mode 100644
> > > > index 000000000000..f078d423a89a
> > > > --- /dev/null
> > > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > > @@ -0,0 +1,558 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * RISC-V performance counter support.
> > > > + *
> > > > + * Copyright (C) 2021 Western Digital Corporation or its affiliate=
s.
> > > > + *
> > > > + * This code is based on ARM perf event code which is in turn base=
d on
> > > > + * sparc64 and x86 code.
> > > > + */
> > > > +
> > >
> > > Add here
> > > #define pr_fmt(fmt) "riscv-pmu-sbi: " fmt
> > >
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/perf/riscv_pmu.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +#include <asm/sbi.h>
> > > > +
> > > > +union sbi_pmu_ctr_info {
> > > > +       unsigned long value;
> > > > +       struct {
> > > > +               unsigned long csr:12;
> > > > +               unsigned long width:6;
> > > > +#if __riscv_xlen =3D=3D 32
> > > > +               unsigned long reserved:13;
> > > > +#else
> > > > +               unsigned long reserved:45;
> > > > +#endif
> > > > +               unsigned long type:1;
> > > > +       };
> > > > +};
> > > > +
> > > > +/**
> > > > + * RISC-V doesn't have hetergenous harts yet. This need to be part=
 of
> > > > + * per_cpu in case of harts with different pmu counters
> > > > + */
> > > > +static union sbi_pmu_ctr_info *pmu_ctr_list;
> > > > +
> > > > +struct pmu_event_data {
> > >
> > > I suggest renaming pmu_event_data to sbi_pmu_event_data
> > > for consistency.
> > >
> > > > +       union {
> > > > +               union {
> > > > +                       struct hw_gen_event {
> > > > +                               uint32_t event_code:16;
> > > > +                               uint32_t event_type:4;
> > > > +                               uint32_t reserved:12;
> > > > +                       } hw_gen_event;
> > > > +                       struct hw_cache_event {
> > > > +                               uint32_t result_id:1;
> > > > +                               uint32_t op_id:2;
> > > > +                               uint32_t cache_id:13;
> > > > +                               uint32_t event_type:4;
> > > > +                               uint32_t reserved:12;
> > > > +                       } hw_cache_event;
> > > > +               };
> > > > +               uint32_t event_idx;
> > > > +       };
> > > > +};
> > > > +
> > > > +static const struct pmu_event_data pmu_hw_event_map[] =3D {
> > > > +       [PERF_COUNT_HW_CPU_CYCLES]              =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
CPU_CYCLES,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
INSTRUCTIONS,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
CACHE_REFERENCES,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_CACHE_MISSES]            =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
CACHE_MISSES,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
BRANCH_INSTRUCTIONS,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_BRANCH_MISSES]           =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
BRANCH_MISSES,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_BUS_CYCLES]              =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
BUS_CYCLES,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
STALLED_CYCLES_FRONTEND,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
STALLED_CYCLES_BACKEND,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +       [PERF_COUNT_HW_REF_CPU_CYCLES]          =3D {.hw_gen_event =
=3D {
> > > > +                                                       SBI_PMU_HW_=
REF_CPU_CYCLES,
> > > > +                                                       SBI_PMU_EVE=
NT_TYPE_HW, 0}},
> > > > +};
> > > > +
> > > > +#define C(x) PERF_COUNT_HW_CACHE_##x
> > > > +static const struct pmu_event_data pmu_cache_event_map[PERF_COUNT_=
HW_CACHE_MAX]
> > > > +[PERF_COUNT_HW_CACHE_OP_MAX]
> > > > +[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
> > > > +       [C(L1D)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(L1D), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_READ), C(L1D), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(L1D), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(L1D), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(L1D), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(L1D), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +       [C(L1I)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(L1I), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS), C(OP_READ),
> > > > +                                       C(L1I), SBI_PMU_EVENT_TYPE_=
CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(L1I), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(L1I), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(L1I), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(L1I), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +       [C(LL)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(LL), SBI_PMU_=
EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_READ), C(LL), SBI_PMU_=
EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(LL), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(LL), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(LL), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(LL), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +       [C(DTLB)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(DTLB), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_READ), C(DTLB), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(DTLB), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(DTLB), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(DTLB), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(DTLB), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +       [C(ITLB)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(ITLB), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_READ), C(ITLB), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(ITLB), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(ITLB), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(ITLB), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(ITLB), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +       [C(BPU)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(BPU), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_READ), C(BPU), SBI_PMU=
_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(BPU), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(BPU), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(BPU), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(BPU), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +       [C(NODE)] =3D {
> > > > +               [C(OP_READ)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_READ), C(NODE), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_READ), C(NODE), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_WRITE)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_WRITE), C(NODE), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_WRITE), C(NODE), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +               [C(OP_PREFETCH)] =3D {
> > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =3D=
 {C(RESULT_ACCESS),
> > > > +                                       C(OP_PREFETCH), C(NODE), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D {=
C(RESULT_MISS),
> > > > +                                       C(OP_PREFETCH), C(NODE), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > +               },
> > > > +       },
> > > > +};
> > > > +
> >
> > Currently, when the user uses the perf list command as below:
> > # perf list
> > List of pre-defined events (to be used in -e):
> >
> >   branch-instructions OR branches         [Hardware event]
> >   branch-misses                                      [Hardware event]
> >   bus-cycles                                            [Hardware event=
]
> >   cache-misses                                       [Hardware event]
> >   cache-references                                 [Hardware event]
> >   cpu-cycles OR cycles                          [Hardware event]
> >   instructions                                          [Hardware event=
]
> >   ref-cycles                                             [Hardware even=
t]
> >   stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
> >   stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
> > ....
> >   L1-dcache-load-misses                            [Hardware cache even=
t]
> >   L1-dcache-loads                                       [Hardware cache=
 event]
> >   L1-dcache-prefetch-misses                      [Hardware cache event]
> >   L1-dcache-prefetches                              [Hardware cache eve=
nt]
> >   L1-dcache-store-misses                           [Hardware cache even=
t]
> >   L1-dcache-stores                                     [Hardware cache =
event]
> >   L1-icache-load-misses                             [Hardware cache eve=
nt]
> >   L1-icache-loads                                       [Hardware cache=
 event]
> >   L1-icache-prefetch-misses                       [Hardware cache event=
]
> >   L1-icache-prefetches                               [Hardware cache ev=
ent]
> > ...
> >
> > it will show all standard hardware and cache events on the perf list.
> > As I understand, the spec didn't define whether the vendor should
> > support all standard hardware and cache events.
> > Vendors may not support all of the standard hardware and cache events.
> > So, if the user uses the unsupported hardware
> > events, it will show <not counted> as a result, which will make the
> > user get confused.
> >
> > May I ask if there is a way for the vendor to dynamically configure
> > supported events or disable unsupported events?
> >
>
> These are standard perf events that are enabled in perf. For vendor
> specific raw events,
> you can tweak the perf tool to do that. Here is the series from Jo=C3=A3o
> M=C3=A1rio to enable those on unmatched.
>
> https://lore.kernel.org/all/20211109102555.16381-1-joao.mario@tecnico.uli=
sboa.pt/
>

Thanks for the information.

For standard hardware and cache events, they are all enabled and
hardcore in the pmu driver.
And current implementation will make the perf list command show all
the standard hardware and cache events.

But vendors may not support all of standard hardware and cache events.
When the user uses a perf list command, the perf tool queries pmu
driver whether standard hardware and cache events
are supported and shown on the list. If the user uses a platform not
supported events on the list,
it will show <not counted> as a result, which makes the user get confused.

As I understand, we can use HW_OP_UNSUPPORTED flag to make it
unsupported as below and the perf list won't show this event
But it still needs to be hardcore in the driver.

@@ -72,9 +75,7 @@ static const struct pmu_event_data pmu_hw_event_map[] =3D=
 {
....
-       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D {.hw_gen_event =3D {
-
SBI_PMU_HW_CACHE_REFERENCES,
-
SBI_PMU_EVENT_TYPE_HW, 0}},
+       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D {.event_idx =3D
HW_OP_UNSUPPORTED},

I'm wondering if there is a way for the vendor to dynamically
configure or disable unsupported standard hardware and cache events?

Thanks,
Eric Lin

> > Thanks,
> > Eric Lin
> >
> > > > +static int pmu_sbi_ctr_get_width(int idx)
> > > > +{
> > > > +       return pmu_ctr_list[idx].width;
> > > > +}
> > > > +
> > > > +static int pmu_sbi_ctr_get_idx(struct perf_event *event)
> > > > +{
> > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > > > +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_event=
s);
> > > > +       struct sbiret ret;
> > > > +       int idx;
> > > > +       uint64_t cbase =3D 0;
> > > > +       uint64_t cmask =3D GENMASK_ULL(rvpmu->num_counters - 1, 0);
> > > > +       unsigned long cflags =3D 0;
> > > > +
> > > > +       if (event->attr.exclude_kernel)
> > > > +               cflags |=3D SBI_PMU_CFG_FLAG_SET_SINH;
> > > > +       else if (event->attr.exclude_user)
> > > > +               cflags |=3D SBI_PMU_CFG_FLAG_SET_UINH;
> > > > +
> > > > +       /* retrieve the available counter index */
> > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATC=
H, cbase, cmask,
> > > > +                       cflags, hwc->event_base, hwc->config, 0);
> > > > +       if (ret.error) {
> > > > +               pr_debug("Not able to find a counter for event %lx =
config %llx\n",
> > > > +                       hwc->event_base, hwc->config);
> > > > +               return sbi_err_map_linux_errno(ret.error);
> > > > +       }
> > > > +
> > > > +       idx =3D ret.value;
> > > > +       if (idx >=3D rvpmu->num_counters || !pmu_ctr_list[idx].valu=
e)
> > > > +               return -ENOENT;
> > > > +
> > > > +       /* Additional sanity check for the counter id */
> > > > +       if (!test_and_set_bit(idx, cpuc->used_event_ctrs))
> > > > +               return idx;
> > > > +       else
> > > > +               return -ENOENT;
> > > > +}
> > > > +
> > > > +static void pmu_sbi_ctr_clear_idx(struct perf_event *event)
> > > > +{
> > > > +
> > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > > > +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_event=
s);
> > > > +       int idx =3D hwc->idx;
> > > > +
> > > > +       clear_bit(idx, cpuc->used_event_ctrs);
> > > > +}
> > > > +
> > > > +static int pmu_event_find_cache(u64 config)
> > > > +{
> > > > +       unsigned int cache_type, cache_op, cache_result, ret;
> > > > +
> > > > +       cache_type =3D (config >>  0) & 0xff;
> > > > +       if (cache_type >=3D PERF_COUNT_HW_CACHE_MAX)
> > > > +               return -EINVAL;
> > > > +
> > > > +       cache_op =3D (config >>  8) & 0xff;
> > > > +       if (cache_op >=3D PERF_COUNT_HW_CACHE_OP_MAX)
> > > > +               return -EINVAL;
> > > > +
> > > > +       cache_result =3D (config >> 16) & 0xff;
> > > > +       if (cache_result >=3D PERF_COUNT_HW_CACHE_RESULT_MAX)
> > > > +               return -EINVAL;
> > > > +
> > > > +       ret =3D pmu_cache_event_map[cache_type][cache_op][cache_res=
ult].event_idx;
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static bool pmu_sbi_is_fw_event(struct perf_event *event)
> > > > +{
> > > > +       u32 type =3D event->attr.type;
> > > > +       u64 config =3D event->attr.config;
> > > > +
> > > > +       if ((type =3D=3D PERF_TYPE_RAW) && ((config >> 63) =3D=3D 1=
))
> > > > +               return true;
> > > > +       else
> > > > +               return false;
> > > > +}
> > > > +
> > > > +static int pmu_sbi_event_map(struct perf_event *event, u64 *econfi=
g)
> > > > +{
> > > > +       u32 type =3D event->attr.type;
> > > > +       u64 config =3D event->attr.config;
> > > > +       int bSoftware;
> > > > +       u64 raw_config_val;
> > > > +       int ret;
> > > > +
> > > > +       switch (type) {
> > > > +       case PERF_TYPE_HARDWARE:
> > > > +               if (config >=3D PERF_COUNT_HW_MAX)
> > > > +                       return -EINVAL;
> > > > +               ret =3D pmu_hw_event_map[event->attr.config].event_=
idx;
> > > > +               break;
> > > > +       case PERF_TYPE_HW_CACHE:
> > > > +               ret =3D pmu_event_find_cache(config);
> > > > +               break;
> > > > +       case PERF_TYPE_RAW:
> > > > +               /*
> > > > +                * As per SBI specification, the upper 16 bits must=
 be unused for
> > > > +                * a raw event. Use the MSB (63b) to distinguish be=
tween hardware
> > > > +                * raw event and firmware events.
> > > > +                */
> > > > +               bSoftware =3D config >> 63;
> > > > +               raw_config_val =3D config & RISCV_PMU_RAW_EVENT_MAS=
K;
> > > > +               if (bSoftware) {
> > > > +                       if (raw_config_val < SBI_PMU_FW_MAX)
> > > > +                               ret =3D (raw_config_val & 0xFFFF) |
> > > > +                                     (SBI_PMU_EVENT_TYPE_FW << 16)=
;
> > > > +                       else
> > > > +                               return -EINVAL;
> > > > +               } else {
> > > > +                       ret =3D RISCV_PMU_RAW_EVENT_IDX;
> > > > +                       *econfig =3D raw_config_val;
> > > > +               }
> > > > +               break;
> > > > +       default:
> > > > +               ret =3D -EINVAL;
> > > > +               break;
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static u64 pmu_sbi_ctr_read(struct perf_event *event)
> > > > +{
> > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > +       int idx =3D hwc->idx;
> > > > +       struct sbiret ret;
> > > > +       union sbi_pmu_ctr_info info;
> > > > +       u64 val =3D 0;
> > > > +
> > > > +       if (pmu_sbi_is_fw_event(event)) {
> > > > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_=
FW_READ,
> > > > +                               hwc->idx, 0, 0, 0, 0, 0);
> > > > +               if (!ret.error)
> > > > +                       val =3D ret.value;
> > > > +       } else {
> > > > +               info =3D pmu_ctr_list[idx];
> > > > +               val =3D riscv_pmu_ctr_read_csr(info.csr);
> > > > +               if (IS_ENABLED(CONFIG_32BIT))
> > > > +                       val =3D ((u64)riscv_pmu_ctr_read_csr(info.c=
sr + 0x80)) << 31 | val;
> > > > +       }
> > > > +
> > > > +       return val;
> > > > +}
> > > > +
> > > > +static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
> > > > +{
> > > > +       struct sbiret ret;
> > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > +       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> > > > +
> > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, h=
wc->idx,
> > > > +                       1, flag, ival, ival >> 32, 0);
> > > > +       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STARTED))
> > > > +               pr_err("Starting counter idx %d failed with error %=
d\n",
> > > > +                       hwc->idx, sbi_err_map_linux_errno(ret.error=
));
> > > > +}
> > > > +
> > > > +static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned lo=
ng flag)
> > > > +{
> > > > +       struct sbiret ret;
> > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > +
> > > > +       //disable IRQ
> > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hw=
c->idx, 1, flag, 0, 0, 0);
> > > > +       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &=
&
> > > > +               flag !=3D SBI_PMU_STOP_FLAG_RESET)
> > > > +               pr_err("Stopping counter idx %d failed with error %=
d\n",
> > > > +                       hwc->idx, sbi_err_map_linux_errno(ret.error=
));
> > > > +}
> > > > +
> > > > +static int pmu_sbi_find_num_ctrs(void)
> > > > +{
> > > > +       struct sbiret ret;
> > > > +
> > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0,=
 0, 0, 0, 0, 0);
> > > > +       if (!ret.error)
> > > > +               return ret.value;
> > > > +       else
> > > > +               return sbi_err_map_linux_errno(ret.error);
> > > > +}
> > > > +
> > > > +static int pmu_sbi_get_ctrinfo(int nctr)
> > > > +{
> > > > +       struct sbiret ret;
> > > > +       int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
> > > > +       union sbi_pmu_ctr_info cinfo;
> > > > +
> > > > +       pmu_ctr_list =3D kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_K=
ERNEL);
> > > > +       if (!pmu_ctr_list)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       for (i =3D 0; i <=3D nctr; i++) {
> > > > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_=
GET_INFO, i, 0, 0, 0, 0, 0);
> > > > +               if (ret.error)
> > > > +                       /* The logical counter ids are not expected=
 to be contiguous */
> > > > +                       continue;
> > > > +               cinfo.value =3D ret.value;
> > > > +               if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> > > > +                       num_fw_ctr++;
> > > > +               else
> > > > +                       num_hw_ctr++;
> > > > +               pmu_ctr_list[i].value =3D cinfo.value;
> > > > +       }
> > > > +
> > > > +       pr_info("There are %d firmware & %d hardware counters avail=
able\n",
> > > > +               num_fw_ctr, num_hw_ctr);
> > >
> > > Replace this with:
> > > pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_=
ctr);
> > >
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_nod=
e *node)
> > > > +{
> > > > +       struct riscv_pmu *pmu =3D hlist_entry_safe(node, struct ris=
cv_pmu, node);
> > > > +
> > > > +       /* Enable the access for TIME csr only from the user mode n=
ow */
> > > > +       csr_write(CSR_SCOUNTEREN, 0x2);
> > > > +
> > > > +       /* Stop all the counters so that they can be enabled from p=
erf */
> > > > +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > > > +                 0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0=
, 0);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *=
node)
> > > > +{
> > > > +       /* Disable all counters access for user mode now */
> > > > +       csr_write(CSR_SCOUNTEREN, 0x0);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int pmu_sbi_device_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct riscv_pmu *pmu =3D NULL;
> > > > +       int num_counters;
> > > > +       int ret;
> > > > +
> > > > +       pr_info("SBI PMU extension is available\n");
> > > > +       /* Notify legacy implementation that SBI pmu is available*/
> > > > +       riscv_pmu_legacy_init(true);
> > > > +       pmu =3D riscv_pmu_alloc();
> > > > +       if (!pmu)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       num_counters =3D pmu_sbi_find_num_ctrs();
> > > > +       if (num_counters < 0) {
> > > > +               pr_err("SBI PMU extension doesn't provide any count=
ers\n");
> > > > +               return -ENODEV;
> > > > +       }
> > > > +
> > > > +       /* cache all the information about counters now */
> > > > +       if (pmu_sbi_get_ctrinfo(num_counters))
> > > > +               return -ENODEV;
> > > > +
> > > > +       pmu->num_counters =3D num_counters;
> > > > +       pmu->ctr_start =3D pmu_sbi_ctr_start;
> > > > +       pmu->ctr_stop =3D pmu_sbi_ctr_stop;
> > > > +       pmu->event_map =3D pmu_sbi_event_map;
> > > > +       pmu->ctr_get_idx =3D pmu_sbi_ctr_get_idx;
> > > > +       pmu->ctr_get_width =3D pmu_sbi_ctr_get_width;
> > > > +       pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> > > > +       pmu->ctr_read =3D pmu_sbi_ctr_read;
> > > > +
> > > > +       ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTI=
NG, &pmu->node);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       ret =3D perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> > > > +       if (ret) {
> > > > +               cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STA=
RTING, &pmu->node);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static struct platform_driver pmu_sbi_driver =3D {
> > > > +       .probe          =3D pmu_sbi_device_probe,
> > > > +       .driver         =3D {
> > > > +               .name   =3D RISCV_PMU_PDEV_NAME,
> > > > +       },
> > > > +};
> > > > +
> > > > +static int __init pmu_sbi_devinit(void)
> > > > +{
> > > > +       int ret;
> > > > +       struct platform_device *pdev;
> > > > +
> > > > +       if (((sbi_major_version() =3D=3D 0) && (sbi_minor_version()=
 < 3)) ||
> > >
> > > Compare SBI version using sbi_spec_version and sbi_mk_version()
> > >
> > > sbi_mk_version() is added by Linux SRST patch.
> > >
> > > > +               sbi_probe_extension(SBI_EXT_PMU) <=3D 0) {
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTIN=
G,
> > > > +                                     "perf/riscv/pmu:starting",
> > > > +                                     pmu_sbi_starting_cpu, pmu_sbi=
_dying_cpu);
> > > > +       if (ret) {
> > > > +               pr_err("CPU hotplug notifier for RISC-V PMU could n=
ot be registered: %d\n",
> > > > +                      ret);
> > >
> > > Drop the "RISC-V PMU" in the pr_err().
> > >
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       ret =3D platform_driver_register(&pmu_sbi_driver);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       pdev =3D platform_device_register_simple(RISCV_PMU_PDEV_NAM=
E, -1, NULL, 0);
> > > > +       if (IS_ERR(pdev)) {
> > > > +               platform_driver_unregister(&pmu_sbi_driver);
> > > > +               return PTR_ERR(pdev);
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +device_initcall(pmu_sbi_devinit)
> > > > --
> > > > 2.33.1
> > > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish
