Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B18490BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiAQP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiAQP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:58:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED07DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:58:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso539770wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMQ44xfujpahHAUaaT++HkQRE8rhySLjfegLrOv4t0E=;
        b=PWQKGHs3TdRfrYXpizxCOByOhxJCsFSz+0FJ3/arQiYxfY3HgAddYyHsBp5u/D2z8k
         jkbvg2GwZuXkJD1nLuqSuhnJ+uUgvZWHnRtc8v5mH8jGcARhno3Lw3O6wQrutU9dSPs1
         f0BLMoqfZW6W6iN9AF95J4pX/Piw6O2UtZT1WribZvRfEXq4lxy4kLE/KlYNT6asKOcr
         MzasqRU7x6jMC7R4+RzNUiDXVQnWYiU01jd7fvLMnYlxslZuaCbZjDKf9YDzT09TLQxk
         j+7qmNU+M2uxlqG6/MZQVvpDudqMSaL1J0nBekvgI71wb6AvP8InxUyobUO6HszQ4T0U
         Bm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMQ44xfujpahHAUaaT++HkQRE8rhySLjfegLrOv4t0E=;
        b=K1LuLaRGox6YiHxNLRnPcpkh31WNktrg8pGpT5EFM7jEaDA/jQ75FiSDU/lgvwXLRq
         Oc4YWcnwpseIWXNc8gpplv3UfC7XMl0pDuNRvywWOamWPLoQ+lcQVQbk2nE2vDEe/x0n
         n3/doYqD+xM0/oko6U5BnoBgoOzNco1HGimVDKK17y4RGIDuZWURTnnKT7VjINXkOKBl
         mWXfBSjLzazwvXGGcyd8hrR9ZZjBq+67Pfv2u/U04ng4VeZSEvnTPcfBcIb/CoIMlTuB
         zK95Tn8c+HWnfW2f08r+CMGqCsrxCHwXCu9C9MzoT82JqQ4R3zwmtT8+UcKzlxeLKz4E
         0zVA==
X-Gm-Message-State: AOAM533vxO5wF97bhHRC9ALVkG2cyHotShIgDfI3c04BKpwtLmGAbWUI
        plUaF+pyg6+v5JwwW40f6Kn+Sq+uGRuezWcqC4B0iQXZX7w=
X-Google-Smtp-Source: ABdhPJwrsRVo8++pZRT72Ow77hKxSaRDlwKkFvubQJ9hi9P/jwUVW5GwKzE1eUw4WkhGR0w9SKSbNGaISXjVAFe1Dsk=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr19698030wre.313.1642435094172;
 Mon, 17 Jan 2022 07:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-2-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-2-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Jan 2022 21:28:03 +0530
Message-ID: <CAAhSdy2wJXniCcFRWee6UGQpSRHdamnp45qdDXT=O05z7B8Mnw@mail.gmail.com>
Subject: Re: [v5 1/9] RISC-V: Remove the current perf implementation
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
> The current perf implementation in RISC-V is not very useful as it can not
> count any events other than cycle/instructions. Moreover, perf record
> can not be used or the events can not be started or stopped.
>
> Remove the implementation now for a better platform driver in future
> that will implement most of the missing functionality.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/Kconfig                  |  13 -
>  arch/riscv/include/asm/perf_event.h |  72 -----
>  arch/riscv/kernel/Makefile          |   1 -
>  arch/riscv/kernel/perf_event.c      | 485 ----------------------------
>  4 files changed, 571 deletions(-)
>  delete mode 100644 arch/riscv/kernel/perf_event.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c79955655fa4..c4afe2c8ff03 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -360,19 +360,6 @@ config RISCV_ISA_C
>
>            If you don't know what to do here, say Y.
>
> -menu "supported PMU type"
> -       depends on PERF_EVENTS
> -
> -config RISCV_BASE_PMU
> -       bool "Base Performance Monitoring Unit"
> -       def_bool y
> -       help
> -         A base PMU that serves as a reference implementation and has limited
> -         feature of perf.  It can run on any RISC-V machines so serves as the
> -         fallback, but this option can also be disable to reduce kernel size.
> -
> -endmenu
> -
>  config FPU
>         bool "FPU support"
>         default y
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 062efd3a1d5d..d42c901f9a97 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -9,77 +9,5 @@
>  #define _ASM_RISCV_PERF_EVENT_H
>
>  #include <linux/perf_event.h>
> -#include <linux/ptrace.h>
> -#include <linux/interrupt.h>
> -
> -#ifdef CONFIG_RISCV_BASE_PMU
> -#define RISCV_BASE_COUNTERS    2
> -
> -/*
> - * The RISCV_MAX_COUNTERS parameter should be specified.
> - */
> -
> -#define RISCV_MAX_COUNTERS     2
> -
> -/*
> - * These are the indexes of bits in counteren register *minus* 1,
> - * except for cycle.  It would be coherent if it can directly mapped
> - * to counteren bit definition, but there is a *time* register at
> - * counteren[1].  Per-cpu structure is scarce resource here.
> - *
> - * According to the spec, an implementation can support counter up to
> - * mhpmcounter31, but many high-end processors has at most 6 general
> - * PMCs, we give the definition to MHPMCOUNTER8 here.
> - */
> -#define RISCV_PMU_CYCLE                0
> -#define RISCV_PMU_INSTRET      1
> -#define RISCV_PMU_MHPMCOUNTER3 2
> -#define RISCV_PMU_MHPMCOUNTER4 3
> -#define RISCV_PMU_MHPMCOUNTER5 4
> -#define RISCV_PMU_MHPMCOUNTER6 5
> -#define RISCV_PMU_MHPMCOUNTER7 6
> -#define RISCV_PMU_MHPMCOUNTER8 7
> -
> -#define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
> -
> -struct cpu_hw_events {
> -       /* # currently enabled events*/
> -       int                     n_events;
> -       /* currently enabled events */
> -       struct perf_event       *events[RISCV_MAX_COUNTERS];
> -       /* vendor-defined PMU data */
> -       void                    *platform;
> -};
> -
> -struct riscv_pmu {
> -       struct pmu      *pmu;
> -
> -       /* generic hw/cache events table */
> -       const int       *hw_events;
> -       const int       (*cache_events)[PERF_COUNT_HW_CACHE_MAX]
> -                                      [PERF_COUNT_HW_CACHE_OP_MAX]
> -                                      [PERF_COUNT_HW_CACHE_RESULT_MAX];
> -       /* method used to map hw/cache events */
> -       int             (*map_hw_event)(u64 config);
> -       int             (*map_cache_event)(u64 config);
> -
> -       /* max generic hw events in map */
> -       int             max_events;
> -       /* number total counters, 2(base) + x(general) */
> -       int             num_counters;
> -       /* the width of the counter */
> -       int             counter_width;
> -
> -       /* vendor-defined PMU features */
> -       void            *platform;
> -
> -       irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> -       int             irq;
> -};
> -
> -#endif
> -#ifdef CONFIG_PERF_EVENTS
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
> -#endif
> -
>  #endif /* _ASM_RISCV_PERF_EVENT_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 3397ddac1a30..e66870a4422f 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,7 +50,6 @@ obj-$(CONFIG_MODULE_SECTIONS) += module-sections.o
>  obj-$(CONFIG_FUNCTION_TRACER)  += mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)   += mcount-dyn.o
>
> -obj-$(CONFIG_RISCV_BASE_PMU)   += perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                += sbi.o
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> deleted file mode 100644
> index c835f0362d94..000000000000
> --- a/arch/riscv/kernel/perf_event.c
> +++ /dev/null
> @@ -1,485 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2008 Thomas Gleixner <tglx@linutronix.de>
> - * Copyright (C) 2008-2009 Red Hat, Inc., Ingo Molnar
> - * Copyright (C) 2009 Jaswinder Singh Rajput
> - * Copyright (C) 2009 Advanced Micro Devices, Inc., Robert Richter
> - * Copyright (C) 2008-2009 Red Hat, Inc., Peter Zijlstra
> - * Copyright (C) 2009 Intel Corporation, <markus.t.metzger@intel.com>
> - * Copyright (C) 2009 Google, Inc., Stephane Eranian
> - * Copyright 2014 Tilera Corporation. All Rights Reserved.
> - * Copyright (C) 2018 Andes Technology Corporation
> - *
> - * Perf_events support for RISC-V platforms.
> - *
> - * Since the spec. (as of now, Priv-Spec 1.10) does not provide enough
> - * functionality for perf event to fully work, this file provides
> - * the very basic framework only.
> - *
> - * For platform portings, please check Documentations/riscv/pmu.txt.
> - *
> - * The Copyright line includes x86 and tile ones.
> - */
> -
> -#include <linux/kprobes.h>
> -#include <linux/kernel.h>
> -#include <linux/kdebug.h>
> -#include <linux/mutex.h>
> -#include <linux/bitmap.h>
> -#include <linux/irq.h>
> -#include <linux/perf_event.h>
> -#include <linux/atomic.h>
> -#include <linux/of.h>
> -#include <asm/perf_event.h>
> -
> -static const struct riscv_pmu *riscv_pmu __read_mostly;
> -static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
> -
> -/*
> - * Hardware & cache maps and their methods
> - */
> -
> -static const int riscv_hw_event_map[] = {
> -       [PERF_COUNT_HW_CPU_CYCLES]              = RISCV_PMU_CYCLE,
> -       [PERF_COUNT_HW_INSTRUCTIONS]            = RISCV_PMU_INSTRET,
> -       [PERF_COUNT_HW_CACHE_REFERENCES]        = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_CACHE_MISSES]            = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_BRANCH_MISSES]           = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_BUS_CYCLES]              = RISCV_OP_UNSUPP,
> -};
> -
> -#define C(x) PERF_COUNT_HW_CACHE_##x
> -static const int riscv_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> -[PERF_COUNT_HW_CACHE_OP_MAX]
> -[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> -       [C(L1D)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(L1I)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(LL)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(DTLB)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] =  RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] =  RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(ITLB)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(BPU)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -};
> -
> -static int riscv_map_hw_event(u64 config)
> -{
> -       if (config >= riscv_pmu->max_events)
> -               return -EINVAL;
> -
> -       return riscv_pmu->hw_events[config];
> -}
> -
> -static int riscv_map_cache_decode(u64 config, unsigned int *type,
> -                          unsigned int *op, unsigned int *result)
> -{
> -       return -ENOENT;
> -}
> -
> -static int riscv_map_cache_event(u64 config)
> -{
> -       unsigned int type, op, result;
> -       int err = -ENOENT;
> -               int code;
> -
> -       err = riscv_map_cache_decode(config, &type, &op, &result);
> -       if (!riscv_pmu->cache_events || err)
> -               return err;
> -
> -       if (type >= PERF_COUNT_HW_CACHE_MAX ||
> -           op >= PERF_COUNT_HW_CACHE_OP_MAX ||
> -           result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
> -               return -EINVAL;
> -
> -       code = (*riscv_pmu->cache_events)[type][op][result];
> -       if (code == RISCV_OP_UNSUPP)
> -               return -EINVAL;
> -
> -       return code;
> -}
> -
> -/*
> - * Low-level functions: reading/writing counters
> - */
> -
> -static inline u64 read_counter(int idx)
> -{
> -       u64 val = 0;
> -
> -       switch (idx) {
> -       case RISCV_PMU_CYCLE:
> -               val = csr_read(CSR_CYCLE);
> -               break;
> -       case RISCV_PMU_INSTRET:
> -               val = csr_read(CSR_INSTRET);
> -               break;
> -       default:
> -               WARN_ON_ONCE(idx < 0 || idx > RISCV_MAX_COUNTERS);
> -               return -EINVAL;
> -       }
> -
> -       return val;
> -}
> -
> -static inline void write_counter(int idx, u64 value)
> -{
> -       /* currently not supported */
> -       WARN_ON_ONCE(1);
> -}
> -
> -/*
> - * pmu->read: read and update the counter
> - *
> - * Other architectures' implementation often have a xxx_perf_event_update
> - * routine, which can return counter values when called in the IRQ, but
> - * return void when being called by the pmu->read method.
> - */
> -static void riscv_pmu_read(struct perf_event *event)
> -{
> -       struct hw_perf_event *hwc = &event->hw;
> -       u64 prev_raw_count, new_raw_count;
> -       u64 oldval;
> -       int idx = hwc->idx;
> -       u64 delta;
> -
> -       do {
> -               prev_raw_count = local64_read(&hwc->prev_count);
> -               new_raw_count = read_counter(idx);
> -
> -               oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> -                                        new_raw_count);
> -       } while (oldval != prev_raw_count);
> -
> -       /*
> -        * delta is the value to update the counter we maintain in the kernel.
> -        */
> -       delta = (new_raw_count - prev_raw_count) &
> -               ((1ULL << riscv_pmu->counter_width) - 1);
> -       local64_add(delta, &event->count);
> -       /*
> -        * Something like local64_sub(delta, &hwc->period_left) here is
> -        * needed if there is an interrupt for perf.
> -        */
> -}
> -
> -/*
> - * State transition functions:
> - *
> - * stop()/start() & add()/del()
> - */
> -
> -/*
> - * pmu->stop: stop the counter
> - */
> -static void riscv_pmu_stop(struct perf_event *event, int flags)
> -{
> -       struct hw_perf_event *hwc = &event->hw;
> -
> -       WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> -       hwc->state |= PERF_HES_STOPPED;
> -
> -       if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> -               riscv_pmu->pmu->read(event);
> -               hwc->state |= PERF_HES_UPTODATE;
> -       }
> -}
> -
> -/*
> - * pmu->start: start the event.
> - */
> -static void riscv_pmu_start(struct perf_event *event, int flags)
> -{
> -       struct hw_perf_event *hwc = &event->hw;
> -
> -       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> -               return;
> -
> -       if (flags & PERF_EF_RELOAD) {
> -               WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> -
> -               /*
> -                * Set the counter to the period to the next interrupt here,
> -                * if you have any.
> -                */
> -       }
> -
> -       hwc->state = 0;
> -       perf_event_update_userpage(event);
> -
> -       /*
> -        * Since we cannot write to counters, this serves as an initialization
> -        * to the delta-mechanism in pmu->read(); otherwise, the delta would be
> -        * wrong when pmu->read is called for the first time.
> -        */
> -       local64_set(&hwc->prev_count, read_counter(hwc->idx));
> -}
> -
> -/*
> - * pmu->add: add the event to PMU.
> - */
> -static int riscv_pmu_add(struct perf_event *event, int flags)
> -{
> -       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -       struct hw_perf_event *hwc = &event->hw;
> -
> -       if (cpuc->n_events == riscv_pmu->num_counters)
> -               return -ENOSPC;
> -
> -       /*
> -        * We don't have general conunters, so no binding-event-to-counter
> -        * process here.
> -        *
> -        * Indexing using hwc->config generally not works, since config may
> -        * contain extra information, but here the only info we have in
> -        * hwc->config is the event index.
> -        */
> -       hwc->idx = hwc->config;
> -       cpuc->events[hwc->idx] = event;
> -       cpuc->n_events++;
> -
> -       hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> -
> -       if (flags & PERF_EF_START)
> -               riscv_pmu->pmu->start(event, PERF_EF_RELOAD);
> -
> -       return 0;
> -}
> -
> -/*
> - * pmu->del: delete the event from PMU.
> - */
> -static void riscv_pmu_del(struct perf_event *event, int flags)
> -{
> -       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -       struct hw_perf_event *hwc = &event->hw;
> -
> -       cpuc->events[hwc->idx] = NULL;
> -       cpuc->n_events--;
> -       riscv_pmu->pmu->stop(event, PERF_EF_UPDATE);
> -       perf_event_update_userpage(event);
> -}
> -
> -/*
> - * Interrupt: a skeletion for reference.
> - */
> -
> -static DEFINE_MUTEX(pmc_reserve_mutex);
> -
> -static irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
> -{
> -       return IRQ_NONE;
> -}
> -
> -static int reserve_pmc_hardware(void)
> -{
> -       int err = 0;
> -
> -       mutex_lock(&pmc_reserve_mutex);
> -       if (riscv_pmu->irq >= 0 && riscv_pmu->handle_irq) {
> -               err = request_irq(riscv_pmu->irq, riscv_pmu->handle_irq,
> -                                 IRQF_PERCPU, "riscv-base-perf", NULL);
> -       }
> -       mutex_unlock(&pmc_reserve_mutex);
> -
> -       return err;
> -}
> -
> -static void release_pmc_hardware(void)
> -{
> -       mutex_lock(&pmc_reserve_mutex);
> -       if (riscv_pmu->irq >= 0)
> -               free_irq(riscv_pmu->irq, NULL);
> -       mutex_unlock(&pmc_reserve_mutex);
> -}
> -
> -/*
> - * Event Initialization/Finalization
> - */
> -
> -static atomic_t riscv_active_events = ATOMIC_INIT(0);
> -
> -static void riscv_event_destroy(struct perf_event *event)
> -{
> -       if (atomic_dec_return(&riscv_active_events) == 0)
> -               release_pmc_hardware();
> -}
> -
> -static int riscv_event_init(struct perf_event *event)
> -{
> -       struct perf_event_attr *attr = &event->attr;
> -       struct hw_perf_event *hwc = &event->hw;
> -       int err;
> -       int code;
> -
> -       if (atomic_inc_return(&riscv_active_events) == 1) {
> -               err = reserve_pmc_hardware();
> -
> -               if (err) {
> -                       pr_warn("PMC hardware not available\n");
> -                       atomic_dec(&riscv_active_events);
> -                       return -EBUSY;
> -               }
> -       }
> -
> -       switch (event->attr.type) {
> -       case PERF_TYPE_HARDWARE:
> -               code = riscv_pmu->map_hw_event(attr->config);
> -               break;
> -       case PERF_TYPE_HW_CACHE:
> -               code = riscv_pmu->map_cache_event(attr->config);
> -               break;
> -       case PERF_TYPE_RAW:
> -               return -EOPNOTSUPP;
> -       default:
> -               return -ENOENT;
> -       }
> -
> -       event->destroy = riscv_event_destroy;
> -       if (code < 0) {
> -               event->destroy(event);
> -               return code;
> -       }
> -
> -       /*
> -        * idx is set to -1 because the index of a general event should not be
> -        * decided until binding to some counter in pmu->add().
> -        *
> -        * But since we don't have such support, later in pmu->add(), we just
> -        * use hwc->config as the index instead.
> -        */
> -       hwc->config = code;
> -       hwc->idx = -1;
> -
> -       return 0;
> -}
> -
> -/*
> - * Initialization
> - */
> -
> -static struct pmu min_pmu = {
> -       .name           = "riscv-base",
> -       .event_init     = riscv_event_init,
> -       .add            = riscv_pmu_add,
> -       .del            = riscv_pmu_del,
> -       .start          = riscv_pmu_start,
> -       .stop           = riscv_pmu_stop,
> -       .read           = riscv_pmu_read,
> -};
> -
> -static const struct riscv_pmu riscv_base_pmu = {
> -       .pmu = &min_pmu,
> -       .max_events = ARRAY_SIZE(riscv_hw_event_map),
> -       .map_hw_event = riscv_map_hw_event,
> -       .hw_events = riscv_hw_event_map,
> -       .map_cache_event = riscv_map_cache_event,
> -       .cache_events = &riscv_cache_event_map,
> -       .counter_width = 63,
> -       .num_counters = RISCV_BASE_COUNTERS + 0,
> -       .handle_irq = &riscv_base_pmu_handle_irq,
> -
> -       /* This means this PMU has no IRQ. */
> -       .irq = -1,
> -};
> -
> -static const struct of_device_id riscv_pmu_of_ids[] = {
> -       {.compatible = "riscv,base-pmu",        .data = &riscv_base_pmu},
> -       { /* sentinel value */ }
> -};
> -
> -static int __init init_hw_perf_events(void)
> -{
> -       struct device_node *node = of_find_node_by_type(NULL, "pmu");
> -       const struct of_device_id *of_id;
> -
> -       riscv_pmu = &riscv_base_pmu;
> -
> -       if (node) {
> -               of_id = of_match_node(riscv_pmu_of_ids, node);
> -
> -               if (of_id)
> -                       riscv_pmu = of_id->data;
> -               of_node_put(node);
> -       }
> -
> -       perf_pmu_register(riscv_pmu->pmu, "cpu", PERF_TYPE_RAW);
> -       return 0;
> -}
> -arch_initcall(init_hw_perf_events);
> --
> 2.33.1
>
