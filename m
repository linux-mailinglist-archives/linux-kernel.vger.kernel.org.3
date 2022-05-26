Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13B5534AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbiEZHfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEZHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:35:29 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359095494
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:35:27 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id l32so1524008ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lq2mT/z36TTERjhSMQY/YGBnpj+e+SOGoCr8PZ2RBeY=;
        b=TmyGdGayBn+WaAftSvipCS+g4FXfDR0ivQcC+55KtZ5VrthH4CNpsL5enX52geX0UN
         hwYFx2Myv8czw25tHI2IIOQn+Y3bamb/l0WCPbSkRXSgbMZOv1gUVk9V3w8ji48caEwG
         +R0OwJ7NAMLDjMbkhfAsCUBJ1DBIyPL9EI1Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lq2mT/z36TTERjhSMQY/YGBnpj+e+SOGoCr8PZ2RBeY=;
        b=KkMcWs12GdBVDDsX30J1OlRtVK1Q2dNrERkn/behtZCDiDBraQJa0CrLj2/oAeUwSR
         iR1rd44aPSpA7B47Pym48NZZOLxoI7IfIkgvnL9xjjmqWJPqyd4qblRYP71vIg8gk7F+
         j1kBojni005eWmpVWpNOFe+DMnhczYeNvBWIbewra/ZZgE/yQ71zBuDhGnHh6Zja8DMs
         DXh04IHGMx+Pm9aDjpEl502JVgSO1OV2ubd5ga682c7gHYfH2sSqQONQD7nv36A+cE7i
         7Bu0y29RKGBtbqykC5m92LikKxfDOHZfHj1OArZQIuj1W73/sjh1Y4u94VNQGaLx+Bb4
         ilrw==
X-Gm-Message-State: AOAM530wPuwdP6Ua1SC9g2oDeJA/mkOIRDfWur+bSmic19U9aU09bNQQ
        KJ9H1t0cPJdijkUA8yTkyr1YD1m1GFQO7NSu6nsF
X-Google-Smtp-Source: ABdhPJzbHFPaT1uxINBkv0WQDLx8ufC4x17Ec2dg8FMYgsPPHvim7AMTvfOvUCddwHDAdzCImkVO89rWZ6u7JhmYlII=
X-Received: by 2002:a25:316:0:b0:654:a65f:def4 with SMTP id
 22-20020a250316000000b00654a65fdef4mr9863793ybd.429.1653550527091; Thu, 26
 May 2022 00:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220523235057.123882-1-atishp@rivosinc.com> <20220523235057.123882-10-atishp@rivosinc.com>
 <CANzO1D3o2iMV45hJW3-xWFtXW9g-iOO2EsrSUFzm_wDdMBNBSw@mail.gmail.com>
In-Reply-To: <CANzO1D3o2iMV45hJW3-xWFtXW9g-iOO2EsrSUFzm_wDdMBNBSw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 26 May 2022 00:35:16 -0700
Message-ID: <CAOnJCUL0_R18GY3b00tcW3Pez49McuYBL0+Lan2h-w7x1LuOYA@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] target/riscv: Simplify counter predicate function
To:     Frank Chang <frank.chang@sifive.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Bin Meng <bmeng.cn@gmail.com>,
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

On Wed, May 25, 2022 at 3:24 AM Frank Chang <frank.chang@sifive.com> wrote:
>
> On Tue, May 24, 2022 at 8:02 AM Atish Patra <atishp@rivosinc.com> wrote:
>>
>> All the hpmcounters and the fixed counters (CY, IR, TM) can be represented
>> as a unified counter. Thus, the predicate function doesn't need handle each
>> case separately.
>>
>> Simplify the predicate function so that we just handle things differently
>> between RV32/RV64 and S/HS mode.
>>
>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>  target/riscv/csr.c | 111 ++++-----------------------------------------
>>  1 file changed, 10 insertions(+), 101 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 723b52d836d3..e229f53c674d 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -74,6 +74,7 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
>>      CPUState *cs = env_cpu(env);
>>      RISCVCPU *cpu = RISCV_CPU(cs);
>>      int ctr_index;
>> +    target_ulong ctr_mask;
>>      int base_csrno = CSR_CYCLE;
>>      bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
>>
>> @@ -82,122 +83,30 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
>>          base_csrno += 0x80;
>>      }
>>      ctr_index = csrno - base_csrno;
>> +    ctr_mask = BIT(ctr_index);
>>
>>      if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
>>          (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
>>          goto skip_ext_pmu_check;
>>      }
>>
>> -    if ((!cpu->cfg.pmu_num || !(cpu->pmu_avail_ctrs & BIT(ctr_index)))) {
>> +    if ((!cpu->cfg.pmu_num || !(cpu->pmu_avail_ctrs & ctr_mask))) {
>>          /* No counter is enabled in PMU or the counter is out of range */
>>          return RISCV_EXCP_ILLEGAL_INST;
>>      }
>>
>>  skip_ext_pmu_check:
>>
>> -    if (env->priv == PRV_S) {
>> -        switch (csrno) {
>> -        case CSR_CYCLE:
>> -            if (!get_field(env->mcounteren, COUNTEREN_CY)) {
>> -                return RISCV_EXCP_ILLEGAL_INST;
>> -            }
>> -            break;
>> -        case CSR_TIME:
>> -            if (!get_field(env->mcounteren, COUNTEREN_TM)) {
>> -                return RISCV_EXCP_ILLEGAL_INST;
>> -            }
>> -            break;
>> -        case CSR_INSTRET:
>> -            if (!get_field(env->mcounteren, COUNTEREN_IR)) {
>> -                return RISCV_EXCP_ILLEGAL_INST;
>> -            }
>> -            break;
>> -        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
>> -            if (!get_field(env->mcounteren, 1 << ctr_index)) {
>> -                return RISCV_EXCP_ILLEGAL_INST;
>> -            }
>> -            break;
>> -        }
>> -        if (rv32) {
>> -            switch (csrno) {
>> -            case CSR_CYCLEH:
>> -                if (!get_field(env->mcounteren, COUNTEREN_CY)) {
>> -                    return RISCV_EXCP_ILLEGAL_INST;
>> -                }
>> -                break;
>> -            case CSR_TIMEH:
>> -                if (!get_field(env->mcounteren, COUNTEREN_TM)) {
>> -                    return RISCV_EXCP_ILLEGAL_INST;
>> -                }
>> -                break;
>> -            case CSR_INSTRETH:
>> -                if (!get_field(env->mcounteren, COUNTEREN_IR)) {
>> -                    return RISCV_EXCP_ILLEGAL_INST;
>> -                }
>> -                break;
>> -            case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
>> -                if (!get_field(env->mcounteren, 1 << ctr_index)) {
>> -                    return RISCV_EXCP_ILLEGAL_INST;
>> -                }
>> -                break;
>> -            }
>> -        }
>> +    if ((env->priv == PRV_S) && (!get_field(env->mcounteren, ctr_mask))) {
>
>
> Should we also check PRV_U against env->scounteren here?
>

Ahh yes. That's required while hpmcounter is being accessed from the
userspace. Good catch. Thanks. Will fix it.

> Regards,
> Frank Chang
>
>>
>> +        return RISCV_EXCP_ILLEGAL_INST;
>>      }
>>
>>      if (riscv_cpu_virt_enabled(env)) {
>> -        switch (csrno) {
>> -        case CSR_CYCLE:
>> -            if (!get_field(env->hcounteren, COUNTEREN_CY) &&
>> -                get_field(env->mcounteren, COUNTEREN_CY)) {
>> -                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -            }
>> -            break;
>> -        case CSR_TIME:
>> -            if (!get_field(env->hcounteren, COUNTEREN_TM) &&
>> -                get_field(env->mcounteren, COUNTEREN_TM)) {
>> -                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -            }
>> -            break;
>> -        case CSR_INSTRET:
>> -            if (!get_field(env->hcounteren, COUNTEREN_IR) &&
>> -                get_field(env->mcounteren, COUNTEREN_IR)) {
>> -                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -            }
>> -            break;
>> -        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
>> -            if (!get_field(env->hcounteren, 1 << ctr_index) &&
>> -                 get_field(env->mcounteren, 1 << ctr_index)) {
>> -                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -            }
>> -            break;
>> -        }
>> -        if (rv32) {
>> -            switch (csrno) {
>> -            case CSR_CYCLEH:
>> -                if (!get_field(env->hcounteren, COUNTEREN_CY) &&
>> -                    get_field(env->mcounteren, COUNTEREN_CY)) {
>> -                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -                }
>> -                break;
>> -            case CSR_TIMEH:
>> -                if (!get_field(env->hcounteren, COUNTEREN_TM) &&
>> -                    get_field(env->mcounteren, COUNTEREN_TM)) {
>> -                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -                }
>> -                break;
>> -            case CSR_INSTRETH:
>> -                if (!get_field(env->hcounteren, COUNTEREN_IR) &&
>> -                    get_field(env->mcounteren, COUNTEREN_IR)) {
>> -                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -                }
>> -                break;
>> -            case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
>> -                if (!get_field(env->hcounteren, 1 << ctr_index) &&
>> -                     get_field(env->mcounteren, 1 << ctr_index)) {
>> -                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> -                }
>> -                break;
>> -            }
>> +        if (!get_field(env->mcounteren, ctr_mask)) {
>> +            /* The bit must be set in mcountern for HS mode access */
>> +            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>> +        } else if (!get_field(env->hcounteren, ctr_mask)) {
>> +            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>>          }
>>      }
>>  #endif
>> --
>> 2.25.1
>>
>>


-- 
Regards,
Atish
