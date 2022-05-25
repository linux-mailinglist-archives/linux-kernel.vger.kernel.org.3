Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A85345F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbiEYVpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiEYVpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:45:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538CB41EE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:45:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z11so92355pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IN7B1Qc2wQvKxwG75W2PmFzu/kAYmOIH2ON1vtcnH3I=;
        b=nCMUhgnyQce2lMMZ3bdjYejIOHX3m22pUeVsgAvPSzBFX2WkZCLfTQ4vhyMTfDsUDM
         R+KW8HaSM9ENcBMw96xmd1GpUK3M2bkg/SvBdp7OaoVK+5OdP9Dpwkb+TKfcVPiZp74w
         vy0fRsftC/z4ZllL09J4wQc7cI9rvXoCh3gcyVzzyjTMEKQM+45cwGpGaDcYbJ/o70HE
         KTUpLEVrpMb7/8UqoRF3rdb37oLgr9njTTupgFpPnldBr+56BFxsDmQ5Xkis+RWo9zgh
         hoe2WvU1C+NoExPdzzlV/yxXS3YQ9T0jZmy1rk5vgoQHR3sy72UYi1Mx8kzNHrhWhPbA
         FuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IN7B1Qc2wQvKxwG75W2PmFzu/kAYmOIH2ON1vtcnH3I=;
        b=TD/RC9xncbHsApcpJAtcat/U0J/Ciw8DlsFNol6kja8bOXaiGJEDYKiqXhugiYyswH
         FUYtdK9bj4xOw2bM78kkPxt0NYdxBuHAnR8yyR1kZCsGWHcRZO31RkArEltd6LoS4IzO
         wfOrO8fYgW8VSkoCdgGi3aapgAN2nE833bIEnugWIVVYbCA+xfHyZjZlx0UGQwn//dNT
         oyprdRfHHSwmOw2UpaUGGZWwL9TR1HdPJ2dgKDwICVrepy+83d2h23k/HC5S5PlFZwUN
         qLIVJZx8ZfJfIWjmAm9gg5xXljCdnGK98ZyiOfgn1D6Rsjk81I0764g5FCpI06XjLlak
         n2Jg==
X-Gm-Message-State: AOAM53205A2cJ85CGt7KskniFAZqEa+Q0qSqa7aQHw4oMTAfE5Pg9U6X
        yW2UWQ6ZnS625zo+lzAtEqryIw==
X-Google-Smtp-Source: ABdhPJydPIEdq20LuZGkb+rUGUKaOiDkAhLz7ObNc/JyBOQIBagoJ7vjQ+qDXCfTWr7cnXmk76fFNQ==
X-Received: by 2002:a17:902:f551:b0:162:de7f:76b6 with SMTP id h17-20020a170902f55100b00162de7f76b6mr7544542plf.77.1653515135300;
        Wed, 25 May 2022 14:45:35 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b0015e8d4eb263sm10050965plk.173.2022.05.25.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:45:33 -0700 (PDT)
Date:   Wed, 25 May 2022 14:45:33 -0700 (PDT)
X-Google-Original-Date: Wed, 25 May 2022 14:45:30 PDT (-0700)
Subject:     Re: [PATCH v2 3/4] RISC-V: Split out the XIP fixups into their own file
In-Reply-To: <CAJF2gTTC4V_vSFFranTB6PZrHK08J8KygjfACxfQ91POpRtY-Q@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, rdunlap@infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        vincent.chen@sifive.com, Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org
Message-ID: <mhng-46c58a80-5b65-4a22-91fa-884bb5df49bc@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 23:45:23 PDT (-0700), guoren@kernel.org wrote:
> On Thu, Apr 21, 2022 at 2:48 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> This was broken by the original refactoring (as the XIP definitions
>> depend on <asm/pgtable.h>) and then more broken by the merge (as I
>> accidentally took the old version).  This fixes both breakages, while
>> also pulling this out of <asm/asm.h> to avoid polluting most assembly
>> files with the XIP fixups.
>>
>> Fixes: bee7fbc38579 ("RISC-V CPU Idle Support")
>> Fixes: 63b13e64a829 ("RISC-V: Add arch functions for non-retentive suspend entry/exit")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/asm.h       | 26 ------------------------
>>  arch/riscv/include/asm/xip_fixup.h | 32 ++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/head.S           |  1 +
>>  arch/riscv/kernel/suspend_entry.S  |  1 +
>>  4 files changed, 34 insertions(+), 26 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/xip_fixup.h
>>
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index 8c2549b16ac0..618d7c5af1a2 100644
>> --- a/arch/riscv/include/asm/asm.h
>> +++ b/arch/riscv/include/asm/asm.h
>> @@ -67,30 +67,4 @@
>>  #error "Unexpected __SIZEOF_SHORT__"
>>  #endif
>>
>> -#ifdef __ASSEMBLY__
>> -
>> -/* Common assembly source macros */
>> -
>> -#ifdef CONFIG_XIP_KERNEL
>> -.macro XIP_FIXUP_OFFSET reg
>> -       REG_L t0, _xip_fixup
>> -       add \reg, \reg, t0
>> -.endm
>> -.macro XIP_FIXUP_FLASH_OFFSET reg
>> -       la t1, __data_loc
>> -       REG_L t1, _xip_phys_offset
>> -       sub \reg, \reg, t1
>> -       add \reg, \reg, t0
>> -.endm
>> -_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
>> -_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
>> -#else
>> -.macro XIP_FIXUP_OFFSET reg
>> -.endm
>> -.macro XIP_FIXUP_FLASH_OFFSET reg
>> -.endm
>> -#endif /* CONFIG_XIP_KERNEL */
>> -
>> -#endif /* __ASSEMBLY__ */
>> -
>>  #endif /* _ASM_RISCV_ASM_H */
>> diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
>> new file mode 100644
>> index 000000000000..0d0754305324
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/xip_fixup.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * XIP fixup macros, only useful in assembly.
>> + */
>> +#ifndef _ASM_RISCV_XIP_FIXUP_H
>> +#define _ASM_RISCV_XIP_FIXUP_H
>> +
>> +#include <linux/pgtable.h>
>> +
>> +#ifdef CONFIG_XIP_KERNEL
>> +.macro XIP_FIXUP_OFFSET reg
>> +        REG_L t0, _xip_fixup
>> +        add \reg, \reg, t0
>> +.endm
>> +.macro XIP_FIXUP_FLASH_OFFSET reg
>> +        la t1, __data_loc
>> +        li t0, XIP_OFFSET_MASK
>> +        and t1, t1, t0
>> +        li t1, XIP_OFFSET
> I still prefer the style:
> REG_L t1, _xip_phys_offset
> ...
> _xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
>
> Because it's more clear and has the same style as your _xip_fixup.

Thanks, not quite shure how I pulled the old version over.  I've fixed 
this one up.

> Others:
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
>> +        sub t0, t0, t1
>> +        sub \reg, \reg, t0
>> +.endm
> -.endm
>> +
>> +_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
>> +#else
>> +.macro XIP_FIXUP_OFFSET reg
>> +.endm
>> +.macro XIP_FIXUP_FLASH_OFFSET reg
>> +.endm
>> +#endif /* CONFIG_XIP_KERNEL */
>> +
>> +#endif
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 893b8bb69391..822c33aa7f45 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -14,6 +14,7 @@
>>  #include <asm/hwcap.h>
>>  #include <asm/image.h>
>> +#include <asm/xip_fixup.h>
>>  #include "efi-header.S"
>>
>>  __HEAD
>> diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
>> index 4b07b809a2b8..aafcca58c19d 100644
>> --- a/arch/riscv/kernel/suspend_entry.S
>> +++ b/arch/riscv/kernel/suspend_entry.S
>> @@ -8,6 +8,7 @@
>>  #include <asm/asm.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/csr.h>
>> +#include <asm/xip_fixup.h>
>>
>>         .text
>>         .altmacro
>> --
>> 2.34.1
>>
