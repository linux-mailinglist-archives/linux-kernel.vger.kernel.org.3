Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75C52B21E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiERGH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiERGHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:07:55 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5ABC6E53
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:07:53 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef5380669cso12947417b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8EoHwLtoWgAzhL6bjsjXMCzgccn+hgkgxp8uH15gvM=;
        b=QePO0oMZ/3vgi1XJyTZbVj36cuixpNHyOY2C0ADXEhRb4KosEbEFe80pWN1ktmYhSB
         RBgmP/z9JeKmnoNRLarPCOo+fBGBNwmE7g0H094UanvAPbXNYULX5qz8JgKJeLRGTF4x
         MdCRYlB3wywlyp40HDRWqnfjzZEpJhei8YjF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8EoHwLtoWgAzhL6bjsjXMCzgccn+hgkgxp8uH15gvM=;
        b=R86h7X5GDNILZ2EMqALDt9MvHFtFLANzMLs66ALXz6ROf1XyMYheZHHawcMihzo8y1
         iBygoK/hSCRWHYhHDqPIVnWI+BL5UPIOS7g3Qk2r/NU+QaRN+71QYxjrS4DKcICVTGsj
         380oOj4rFETLGlcQ7PDzHLebAJs/dbOfhtazXAvXW9dOQ7vP7rqgPC+FeJTaBvuAM8lx
         uvRq0khSd9FUcKURzX/KqA0dHGK8vJvoLUxn6swHq+F6hFpHtGRpiXxOid9aoLmerLR6
         +9GJ7Zn3AXOvGbewMQnaAxXyPmRxfsIZapFeFBlh0wcRQ5sJ+AJvS39iwUJ0f78Qzks/
         Z2og==
X-Gm-Message-State: AOAM530xq2e98SQv2BNhsP5mZ+TQnr5SGxjBCRpanJnEXyB5vvcTO7pF
        rPnHuEaZUaXfnuB5bLrlpG1emEdDzS7cs8pTcKCd
X-Google-Smtp-Source: ABdhPJyZo6XenCFjeWaIxT5afeYivI5W4okofr/2nkdqpCDMbj9OBU8iwGOzdG3p1aKcHmDLXREKSo3Kr/VqWoLBgWk=
X-Received: by 2002:a81:dd07:0:b0:2eb:f701:286e with SMTP id
 e7-20020a81dd07000000b002ebf701286emr28215624ywn.341.1652854072212; Tue, 17
 May 2022 23:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220511215956.2351243-1-atishp@rivosinc.com> <20220511215956.2351243-8-atishp@rivosinc.com>
 <CANzO1D28K+QeJF4q4mD7ZYH+0H=KTFWtSwfQ4KoV4onKX4-j3Q@mail.gmail.com>
 <CAHBxVyG9BRGHLgbLZ7p8eg1oK7k_z8OAvAygQnQ68gMMk8K7bg@mail.gmail.com> <CAE_xrPgz4mxhDx88P_67SfKoxsNPL4gDNLA0vrWwTMcz3qsatQ@mail.gmail.com>
In-Reply-To: <CAE_xrPgz4mxhDx88P_67SfKoxsNPL4gDNLA0vrWwTMcz3qsatQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 17 May 2022 23:07:41 -0700
Message-ID: <CAOnJCUKNFEjdpzht6SWZGBSZKB+pO3PbBVv3BrwnxwV1S6_rLg@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] target/riscv: Support mcycle/minstret write operation
To:     Frank Chang <frank.chang@sifive.com>
Cc:     Atish Kumar Patra <atishp@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
        "open list:RISC-V" <qemu-riscv@nongnu.org>
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

On Sat, May 14, 2022 at 12:46 AM Frank Chang <frank.chang@sifive.com> wrote:
>
> On Fri, May 13, 2022 at 11:58 PM Atish Kumar Patra <atishp@rivosinc.com> wrote:
>>
>> On Thu, May 12, 2022 at 11:29 PM Frank Chang <frank.chang@sifive.com> wrote:
>> >
>> > On Thu, May 12, 2022 at 6:01 AM Atish Patra <atishp@rivosinc.com> wrote:
>> >>
>> >> From: Atish Patra <atish.patra@wdc.com>
>> >>
>> >> mcycle/minstret are actually WARL registers and can be written with any
>> >> given value. With SBI PMU extension, it will be used to store a initial
>> >> value provided from supervisor OS. The Qemu also need prohibit the counter
>> >> increment if mcountinhibit is set.
>> >>
>> >> Support mcycle/minstret through generic counter infrastructure.
>> >>
>> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> >> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> >> ---
>> >>  target/riscv/cpu.h       |  23 ++++--
>> >>  target/riscv/csr.c       | 157 ++++++++++++++++++++++++++++-----------
>> >>  target/riscv/machine.c   |  25 ++++++-
>> >>  target/riscv/meson.build |   3 +-
>> >>  target/riscv/pmu.c       |  32 ++++++++
>> >>  target/riscv/pmu.h       |  28 +++++++
>> >>  6 files changed, 214 insertions(+), 54 deletions(-)
>> >>  create mode 100644 target/riscv/pmu.c
>> >>  create mode 100644 target/riscv/pmu.h
>> >>
>> >> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> >> index 32cdd9070be5..f60072e0fd3d 100644
>> >> --- a/target/riscv/cpu.h
>> >> +++ b/target/riscv/cpu.h
>> >> @@ -111,7 +111,7 @@ typedef struct CPUArchState CPURISCVState;
>> >>  #endif
>> >>
>> >>  #define RV_VLEN_MAX 1024
>> >> -#define RV_MAX_MHPMEVENTS 29
>> >> +#define RV_MAX_MHPMEVENTS 32
>> >>  #define RV_MAX_MHPMCOUNTERS 32
>> >>
>> >>  FIELD(VTYPE, VLMUL, 0, 3)
>> >> @@ -121,6 +121,18 @@ FIELD(VTYPE, VMA, 7, 1)
>> >>  FIELD(VTYPE, VEDIV, 8, 2)
>> >>  FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
>> >>
>> >> +typedef struct PMUCTRState {
>> >> +    /* Current value of a counter */
>> >> +    target_ulong mhpmcounter_val;
>> >> +    /* Current value of a counter in RV32*/
>> >> +    target_ulong mhpmcounterh_val;
>> >> +    /* Snapshot values of counter */
>> >> +    target_ulong mhpmcounter_prev;
>> >> +    /* Snapshort value of a counter in RV32 */
>> >> +    target_ulong mhpmcounterh_prev;
>> >> +    bool started;
>> >> +} PMUCTRState;
>> >> +
>> >>  struct CPUArchState {
>> >>      target_ulong gpr[32];
>> >>      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
>> >> @@ -273,13 +285,10 @@ struct CPUArchState {
>> >>
>> >>      target_ulong mcountinhibit;
>> >>
>> >> -    /* PMU counter configured values */
>> >> -    target_ulong mhpmcounter_val[RV_MAX_MHPMCOUNTERS];
>> >> -
>> >> -    /* for RV32 */
>> >> -    target_ulong mhpmcounterh_val[RV_MAX_MHPMCOUNTERS];
>> >> +    /* PMU counter state */
>> >> +    PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
>> >>
>> >> -    /* PMU event selector configured values */
>> >> +    /* PMU event selector configured values. First three are unused*/
>> >>      target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
>> >>
>> >>      target_ulong sscratch;
>> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> >> index 87aa601e5ddb..c050ed2e2c1b 100644
>> >> --- a/target/riscv/csr.c
>> >> +++ b/target/riscv/csr.c
>> >> @@ -21,6 +21,7 @@
>> >>  #include "qemu/log.h"
>> >>  #include "qemu/timer.h"
>> >>  #include "cpu.h"
>> >> +#include "pmu.h"
>> >>  #include "qemu/main-loop.h"
>> >>  #include "exec/exec-all.h"
>> >>  #include "sysemu/cpu-timers.h"
>> >> @@ -597,34 +598,28 @@ static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
>> >>  }
>> >>
>> >>  /* User Timers and Counters */
>> >> -static RISCVException read_instret(CPURISCVState *env, int csrno,
>> >> -                                   target_ulong *val)
>> >> +static target_ulong get_ticks(bool shift)
>> >>  {
>> >> +    int64_t val;
>> >> +    target_ulong result;
>> >> +
>> >>  #if !defined(CONFIG_USER_ONLY)
>> >>      if (icount_enabled()) {
>> >> -        *val = icount_get();
>> >> +        val = icount_get();
>> >>      } else {
>> >> -        *val = cpu_get_host_ticks();
>> >> +        val = cpu_get_host_ticks();
>> >>      }
>> >>  #else
>> >> -    *val = cpu_get_host_ticks();
>> >> +    val = cpu_get_host_ticks();
>> >>  #endif
>> >> -    return RISCV_EXCP_NONE;
>> >> -}
>> >>
>> >> -static RISCVException read_instreth(CPURISCVState *env, int csrno,
>> >> -                                    target_ulong *val)
>> >> -{
>> >> -#if !defined(CONFIG_USER_ONLY)
>> >> -    if (icount_enabled()) {
>> >> -        *val = icount_get() >> 32;
>> >> +    if (shift) {
>> >> +        result = val >> 32;
>> >>      } else {
>> >> -        *val = cpu_get_host_ticks() >> 32;
>> >> +        result = val;
>> >>      }
>> >> -#else
>> >> -    *val = cpu_get_host_ticks() >> 32;
>> >> -#endif
>> >> -    return RISCV_EXCP_NONE;
>> >> +
>> >> +    return result;
>> >>  }
>> >>
>> >>  #if defined(CONFIG_USER_ONLY)
>> >> @@ -642,11 +637,23 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
>> >>      return RISCV_EXCP_NONE;
>> >>  }
>> >>
>> >> +static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
>> >> +{
>> >> +    *val = get_ticks(false);
>> >> +    return RISCV_EXCP_NONE;
>> >> +}
>> >> +
>> >> +static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
>> >> +{
>> >> +    *val = get_ticks(true);
>> >> +    return RISCV_EXCP_NONE;
>> >> +}
>> >> +
>> >>  #else /* CONFIG_USER_ONLY */
>> >>
>> >>  static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
>> >>  {
>> >> -    int evt_index = csrno - CSR_MHPMEVENT3;
>> >> +    int evt_index = csrno - CSR_MCOUNTINHIBIT;
>> >>
>> >>      *val = env->mhpmevent_val[evt_index];
>> >>
>> >> @@ -655,7 +662,7 @@ static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
>> >>
>> >>  static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
>> >>  {
>> >> -    int evt_index = csrno - CSR_MHPMEVENT3;
>> >> +    int evt_index = csrno - CSR_MCOUNTINHIBIT;
>> >>
>> >>      env->mhpmevent_val[evt_index] = val;
>> >>
>> >> @@ -664,52 +671,102 @@ static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
>> >>
>> >>  static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
>> >>  {
>> >> -    int ctr_index = csrno - CSR_MHPMCOUNTER3 + 3;
>> >> +    int ctr_idx = csrno - CSR_MCYCLE;
>> >> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>> >>
>> >> -    env->mhpmcounter_val[ctr_index] = val;
>> >> +    counter->mhpmcounter_val = val;
>> >> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>> >> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> >> +        counter->mhpmcounter_prev = get_ticks(false);
>> >> +    } else {
>> >> +        /* Other counters can keep incrementing from the given value */
>> >> +        counter->mhpmcounter_prev = val;
>> >> +    }
>> >>
>> >>      return RISCV_EXCP_NONE;
>> >>  }
>> >>
>> >>  static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
>> >>  {
>> >> -    int ctr_index = csrno - CSR_MHPMCOUNTER3H + 3;
>> >> +    int ctr_idx = csrno - CSR_MCYCLEH;
>> >> +    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>> >>
>> >> -    env->mhpmcounterh_val[ctr_index] = val;
>> >> +    counter->mhpmcounterh_val = val;
>> >> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>> >> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> >> +        counter->mhpmcounterh_prev = get_ticks(true);
>> >> +    } else {
>> >> +        counter->mhpmcounterh_prev = val;
>> >> +    }
>> >> +
>> >> +    return RISCV_EXCP_NONE;
>> >> +}
>> >> +
>> >> +static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>> >> +                                         bool upper_half, uint32_t ctr_idx)
>> >> +{
>> >> +    PMUCTRState counter = env->pmu_ctrs[ctr_idx];
>> >> +    target_ulong ctr_prev = upper_half ? counter.mhpmcounterh_prev :
>> >> +                                         counter.mhpmcounter_prev;
>> >> +    target_ulong ctr_val = upper_half ? counter.mhpmcounterh_val :
>> >> +                                        counter.mhpmcounter_val;
>> >> +
>> >> +    if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>> >> +        /**
>> >> +         * Counter should not increment if inhibit bit is set. We can't really
>> >> +         * stop the icount counting. Just return the counter value written by
>> >> +         * the supervisor to indicate that counter was not incremented.
>> >> +         */
>> >> +        if (!counter.started) {
>> >> +            *val = ctr_val;
>> >> +            return RISCV_EXCP_NONE;
>> >> +        } else {
>> >> +            /* Mark that the counter has been stopped */
>> >> +            counter.started = false;
>> >> +        }
>> >> +    }
>> >> +
>> >> +
>> >> +    /**
>> >> +     * The kernel computes the perf delta by subtracting the current value from
>> >> +     * the value it initialized previously (ctr_val).
>> >> +     */
>> >> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>> >> +        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> >> +        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
>> >> +    } else {
>> >> +        *val = ctr_val;
>> >> +    }
>> >>
>> >>      return RISCV_EXCP_NONE;
>> >>  }
>> >>
>> >>  static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
>> >>  {
>> >> -    int ctr_index;
>> >> +    uint16_t ctr_index;
>> >>
>> >>      if (env->priv == PRV_M) {
>> >> -        ctr_index = csrno - CSR_MHPMCOUNTER3 + 3;
>> >> +        ctr_index = csrno - CSR_MCYCLE;
>> >>
>> >>      } else {
>> >> -        ctr_index = csrno - CSR_HPMCOUNTER3 + 3;
>> >> +        ctr_index = csrno - CSR_CYCLE;
>> >>      }
>> >
>> >
>> > Hi Atish,
>> >
>> > According to spec:
>> > "The RDCYCLE pseudoinstruction reads the low XLEN bits of the cycle CSR
>> > which holds a count of the number of clock cycles executed by the
>> > processor core on which the hart is running from an arbitrary start time in the past."
>> >
>> > However, the counter index calculation here would have the issue.
>> > For example, if RDCYCLE instruction is executed in M-mode:
>> > CYCLE csrno is: 0xc00, but MCYCLE csrno is: 0xb00
>> > "csrno - CSR_MCYCLE" would result in the invalidate value: 0x100,
>> > which is out of the counter array's bound.
>> >
>>
>> Why does somebody want to invoke RDCYCLE in M-mode ? IIRC, it's not
>> used anywhere
>> currently. I understand rdtime use case but don't know why do you want
>> to run RDCYCLE.
>
>
> Hi Atish,
>
> That's just a random program and I think it tries to be portable in both U-mode and M-mode.
> Does RISC-V spec have any limitation on executing RDCYCLE instruction in M-mode?
>

I am not aware of any such limitation.

> Regards,
> Frank Chang
>
>>
>> > Will it be easier to just check against csrno instead of the current privileged mode?
>> >
>>
>> Anyways, we can move to csrno range check to calculate the offset
>> instead of the priv mode.
>> I am fine with that. I just want to understand the use case. If it is
>> just for completeness and cover
>> edge cases, that's fine too.
>>
>> > And I think the same issue also occurs for:
>> > HPMCOUNTER3 ~ HPMCOUNTER31.
>>
>> Again what is the use case for reading  HPMCOUNTER3-HPMCOUNTER31 in M-mode
>> when you MHPMCOUNTERX available ?
>>
>> >
>> > Regards,
>> > Frank Chang
>> >
>> >>
>> >> -    *val = env->mhpmcounter_val[ctr_index];
>> >>
>> >> -    return RISCV_EXCP_NONE;
>> >> +    return riscv_pmu_read_ctr(env, val, false, ctr_index);
>> >>  }
>> >>
>> >>  static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
>> >>  {
>> >> -    int ctr_index;
>> >> +    uint16_t ctr_index;
>> >>
>> >>      if (env->priv == PRV_M) {
>> >> -        ctr_index = csrno - CSR_MHPMCOUNTER3H + 3;
>> >> +        ctr_index = csrno - CSR_MCYCLEH;
>> >>      } else {
>> >> -        ctr_index = csrno - CSR_HPMCOUNTER3H + 3;
>> >> +        ctr_index = csrno - CSR_CYCLEH;
>> >>      }
>> >>
>> >> -    *val = env->mhpmcounterh_val[ctr_index];
>> >> -
>> >> -    return RISCV_EXCP_NONE;
>> >> +    return riscv_pmu_read_ctr(env, val, true, ctr_index);
>> >>  }
>> >>
>> >> -
>> >>  static RISCVException read_time(CPURISCVState *env, int csrno,
>> >>                                  target_ulong *val)
>> >>  {
>> >> @@ -1564,11 +1621,23 @@ static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
>> >>  static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>> >>                                            target_ulong val)
>> >>  {
>> >> +    int cidx;
>> >> +    PMUCTRState *counter;
>> >> +
>> >>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
>> >>          return RISCV_EXCP_ILLEGAL_INST;
>> >>      }
>> >>
>> >>      env->mcountinhibit = val;
>> >> +
>> >> +    /* Check if any other counter is also monitoring cycles/instructions */
>> >> +    for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
>> >> +        if (!get_field(env->mcountinhibit, BIT(cidx))) {
>> >> +            counter = &env->pmu_ctrs[cidx];
>> >> +            counter->started = true;
>> >> +        }
>> >> +    }
>> >> +
>> >>      return RISCV_EXCP_NONE;
>> >>  }
>> >>
>> >> @@ -3526,10 +3595,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>> >>      [CSR_VLENB]    = { "vlenb",    vs,    read_vlenb,
>> >>                                            .min_priv_ver = PRIV_VERSION_1_12_0 },
>> >>      /* User Timers and Counters */
>> >> -    [CSR_CYCLE]    = { "cycle",    ctr,    read_instret  },
>> >> -    [CSR_INSTRET]  = { "instret",  ctr,    read_instret  },
>> >> -    [CSR_CYCLEH]   = { "cycleh",   ctr32,  read_instreth },
>> >> -    [CSR_INSTRETH] = { "instreth", ctr32,  read_instreth },
>> >> +    [CSR_CYCLE]    = { "cycle",    ctr,    read_hpmcounter  },
>> >> +    [CSR_INSTRET]  = { "instret",  ctr,    read_hpmcounter  },
>> >> +    [CSR_CYCLEH]   = { "cycleh",   ctr32,  read_hpmcounterh },
>> >> +    [CSR_INSTRETH] = { "instreth", ctr32,  read_hpmcounterh },
>> >>
>> >>      /*
>> >>       * In privileged mode, the monitor will have to emulate TIME CSRs only if
>> >> @@ -3543,10 +3612,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>> >>
>> >>  #if !defined(CONFIG_USER_ONLY)
>> >>      /* Machine Timers and Counters */
>> >> -    [CSR_MCYCLE]    = { "mcycle",    any,   read_instret  },
>> >> -    [CSR_MINSTRET]  = { "minstret",  any,   read_instret  },
>> >> -    [CSR_MCYCLEH]   = { "mcycleh",   any32, read_instreth },
>> >> -    [CSR_MINSTRETH] = { "minstreth", any32, read_instreth },
>> >> +    [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter, write_mhpmcounter},
>> >> +    [CSR_MINSTRET]  = { "minstret",  any,   read_hpmcounter, write_mhpmcounter},
>> >> +    [CSR_MCYCLEH]   = { "mcycleh",   any32, read_hpmcounterh, write_mhpmcounterh},
>> >> +    [CSR_MINSTRETH] = { "minstreth", any32, read_hpmcounterh, write_mhpmcounterh},
>> >>
>> >>      /* Machine Information Registers */
>> >>      [CSR_MVENDORID] = { "mvendorid", any,   read_mvendorid },
>> >> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> >> index 99193c85bb97..dc182ca81119 100644
>> >> --- a/target/riscv/machine.c
>> >> +++ b/target/riscv/machine.c
>> >> @@ -279,7 +279,28 @@ static const VMStateDescription vmstate_envcfg = {
>> >>          VMSTATE_UINT64(env.menvcfg, RISCVCPU),
>> >>          VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
>> >>          VMSTATE_UINT64(env.henvcfg, RISCVCPU),
>> >> +        VMSTATE_END_OF_LIST()
>> >> +    }
>> >> +};
>> >> +
>> >> +static bool pmu_needed(void *opaque)
>> >> +{
>> >> +    RISCVCPU *cpu = opaque;
>> >>
>> >> +    return cpu->cfg.pmu_num;
>> >> +}
>> >> +
>> >> +static const VMStateDescription vmstate_pmu_ctr_state = {
>> >> +    .name = "cpu/pmu",
>> >> +    .version_id = 1,
>> >> +    .minimum_version_id = 1,
>> >> +    .needed = pmu_needed,
>> >> +    .fields = (VMStateField[]) {
>> >> +        VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
>> >> +        VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
>> >> +        VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
>> >> +        VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
>> >> +        VMSTATE_BOOL(started, PMUCTRState),
>> >>          VMSTATE_END_OF_LIST()
>> >>      }
>> >>  };
>> >> @@ -331,8 +352,8 @@ const VMStateDescription vmstate_riscv_cpu = {
>> >>          VMSTATE_UINTTL(env.scounteren, RISCVCPU),
>> >>          VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
>> >>          VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
>> >> -        VMSTATE_UINTTL_ARRAY(env.mhpmcounter_val, RISCVCPU, RV_MAX_MHPMCOUNTERS),
>> >> -        VMSTATE_UINTTL_ARRAY(env.mhpmcounterh_val, RISCVCPU, RV_MAX_MHPMCOUNTERS),
>> >> +        VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
>> >> +                             vmstate_pmu_ctr_state, PMUCTRState),
>> >>          VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
>> >>          VMSTATE_UINTTL(env.sscratch, RISCVCPU),
>> >>          VMSTATE_UINTTL(env.mscratch, RISCVCPU),
>> >> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
>> >> index 096249f3a30f..2c1975e72c4e 100644
>> >> --- a/target/riscv/meson.build
>> >> +++ b/target/riscv/meson.build
>> >> @@ -30,7 +30,8 @@ riscv_softmmu_ss.add(files(
>> >>    'pmp.c',
>> >>    'debug.c',
>> >>    'monitor.c',
>> >> -  'machine.c'
>> >> +  'machine.c',
>> >> +  'pmu.c'
>> >>  ))
>> >>
>> >>  target_arch += {'riscv': riscv_ss}
>> >> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
>> >> new file mode 100644
>> >> index 000000000000..000fe8da45ef
>> >> --- /dev/null
>> >> +++ b/target/riscv/pmu.c
>> >> @@ -0,0 +1,32 @@
>> >> +/*
>> >> + * RISC-V PMU file.
>> >> + *
>> >> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify it
>> >> + * under the terms and conditions of the GNU General Public License,
>> >> + * version 2 or later, as published by the Free Software Foundation.
>> >> + *
>> >> + * This program is distributed in the hope it will be useful, but WITHOUT
>> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> >> + * more details.
>> >> + *
>> >> + * You should have received a copy of the GNU General Public License along with
>> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> >> + */
>> >> +
>> >> +#include "qemu/osdep.h"
>> >> +#include "cpu.h"
>> >> +#include "pmu.h"
>> >> +
>> >> +bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>> >> +                                        uint32_t target_ctr)
>> >> +{
>> >> +    return (target_ctr == 0) ? true : false;
>> >> +}
>> >> +
>> >> +bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>> >> +{
>> >> +    return (target_ctr == 2) ? true : false;
>> >> +}
>> >> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
>> >> new file mode 100644
>> >> index 000000000000..58a5bc3a4089
>> >> --- /dev/null
>> >> +++ b/target/riscv/pmu.h
>> >> @@ -0,0 +1,28 @@
>> >> +/*
>> >> + * RISC-V PMU header file.
>> >> + *
>> >> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify it
>> >> + * under the terms and conditions of the GNU General Public License,
>> >> + * version 2 or later, as published by the Free Software Foundation.
>> >> + *
>> >> + * This program is distributed in the hope it will be useful, but WITHOUT
>> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> >> + * more details.
>> >> + *
>> >> + * You should have received a copy of the GNU General Public License along with
>> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> >> + */
>> >> +
>> >> +#include "qemu/osdep.h"
>> >> +#include "qemu/log.h"
>> >> +#include "cpu.h"
>> >> +#include "qemu/main-loop.h"
>> >> +#include "exec/exec-all.h"
>> >> +
>> >> +bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>> >> +                                        uint32_t target_ctr);
>> >> +bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>> >> +                                  uint32_t target_ctr);
>> >> --
>> >> 2.25.1
>> >>
>> >>



-- 
Regards,
Atish
