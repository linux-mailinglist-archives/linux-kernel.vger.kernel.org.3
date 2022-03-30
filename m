Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72724ECFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351770AbiC3XOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbiC3XOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:14:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765B4A3F8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:12:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so22258353pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=sHR4EcucliUpX7+65qOWS8vP81r34dp/5wb9FsMswWI=;
        b=x9LzSrMwm+OX0LDp8wR/iVTvAirwptvVKFGRsLefAoZx3mxBaC5m3CbbNsq2v9k6rn
         atQrs2BR3hgdPIkyvTsAbkRBsbmxLVS79kMGutu+P3vZfvflL1ScawHcKIHvWYCDiRMP
         kw8Qon7IXj49MvWj6TJG6u/xCJsCUWyNtNtahDQ5AxH/GIgKQmnx/dEMStromPP7YKaW
         TegSDzXqDjpEripUsME1eVjFMnv/KeotMJ2s5VfvM6dO0PALqXQ4gpj55nDNZUIn5bww
         jHcqPj7uMMvPu51qcFKgU3h3cfrv2Vw5ui/7M0sjaSeuQtBWBAykiX400AH/uMbxo5Mi
         Nxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=sHR4EcucliUpX7+65qOWS8vP81r34dp/5wb9FsMswWI=;
        b=k58aMONlxgnT9RhWbdX3WrJB/OVlKPtapUj8tDS7UwjVDuOGqqt5xlVmvskbyqeUcv
         +Vrj3Y+JXu80Q3De6bMlNWrMTU8KLze/ml5oyxCmnexKehTVGed9jyKVlTBWKPwK4U8k
         2NBIdt1RBvm15/2ApgLs6dZYOUJ73lYfLSPi6o1IDuRwsoeZnmWDiiKxd1wvHv9da8Fe
         FZMqyVXZ/d6jv8GIBGCpPIHwtZaKqm0OprEytjp6O06q/jJy6iNyfJKjXm4DitNqI0i8
         S7yimAa+ipQZpKsE5oDn5ur+Pei+y92r1Ok9r8iNR2JoJvR1Mft/BYbZ0+nt3sW+QigG
         1Zmw==
X-Gm-Message-State: AOAM532AFpC8jCylN9tC4A5y5skxWukz4RC+jxhI0RyQPRhdi5FDF6MW
        mS8gj/FhWvaWSYzhv6tEbsbLCA==
X-Google-Smtp-Source: ABdhPJxgLGkVw1UC6zJxMgHsA5hIYCZ2xeLAbZEkfsaQH9aIpoqKFLPDpzpbbxqoOl8PBNy/pdyaaQ==
X-Received: by 2002:a17:902:b10e:b0:156:1bf8:bf26 with SMTP id q14-20020a170902b10e00b001561bf8bf26mr2277287plr.8.1648681938921;
        Wed, 30 Mar 2022 16:12:18 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id ml16-20020a17090b361000b001c6c9141b0csm7303574pjb.45.2022.03.30.16.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 16:12:18 -0700 (PDT)
Date:   Wed, 30 Mar 2022 16:12:18 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 16:12:10 PDT (-0700)
Subject:     Re: [PATCH] riscv: Rename "sp_in_global" to "current_stack_pointer"
In-Reply-To: <mhng-00315cbb-3685-4918-8ea0-539cda5fbc36@palmer-ri-x1c9>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, keescook@chromium.org,
        aou@eecs.berkeley.edu, peterz@infradead.org, jszhang@kernel.org,
        geert@linux-m68k.org, mark.rutland@arm.com, chenhuang5@huawei.com,
        linux-riscv@lists.infradead.org, wangkefeng.wang@huawei.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-82a6e73b-c0b7-4625-8a79-ed481f8b2cf1@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 19:16:28 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 23 Feb 2022 22:04:11 PST (-0800), keescook@chromium.org wrote:
>> To follow the existing per-arch conventions, rename "sp_in_global" to
>> "current_stack_pointer". This will let it be used in non-arch places
>> (like HARDENED_USERCOPY).
>>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Jisheng Zhang <jszhang@kernel.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Chen Huang <chenhuang5@huawei.com>
>> Cc: linux-riscv@lists.infradead.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/riscv/Kconfig               | 1 +
>>  arch/riscv/include/asm/current.h | 2 ++
>>  arch/riscv/kernel/stacktrace.c   | 4 +---
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 5adcbd9b5e88..b120c32697af 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -16,6 +16,7 @@ config RISCV
>>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>>  	select ARCH_HAS_BINFMT_FLAT
>> +	select ARCH_HAS_CURRENT_STACK_POINTER
>>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>>  	select ARCH_HAS_DEBUG_WX
>> diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
>> index 1de233d8e8de..21774d868c65 100644
>> --- a/arch/riscv/include/asm/current.h
>> +++ b/arch/riscv/include/asm/current.h
>> @@ -33,6 +33,8 @@ static __always_inline struct task_struct *get_current(void)
>>
>>  #define current get_current()
>>
>> +register unsigned long current_stack_pointer __asm__("sp");
>> +
>>  #endif /* __ASSEMBLY__ */
>>
>>  #endif /* _ASM_RISCV_CURRENT_H */
>> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>> index 201ee206fb57..278380e2e956 100644
>> --- a/arch/riscv/kernel/stacktrace.c
>> +++ b/arch/riscv/kernel/stacktrace.c
>> @@ -14,8 +14,6 @@
>>
>>  #include <asm/stacktrace.h>
>>
>> -register unsigned long sp_in_global __asm__("sp");
>> -
>>  #ifdef CONFIG_FRAME_POINTER
>>
>>  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>> @@ -77,7 +75,7 @@ void notrace walk_stackframe(struct task_struct *task,
>>  		sp = user_stack_pointer(regs);
>>  		pc = instruction_pointer(regs);
>>  	} else if (task == NULL || task == current) {
>> -		sp = sp_in_global;
>> +		sp = current_stack_pointer;
>>  		pc = (unsigned long)walk_stackframe;
>>  	} else {
>>  		/* task blocked in __switch_to */
>
> Sorry to be slow on this one.  This looks good, but another use of
> sp_in_global snuck into fixes and I don't merge fixes into for-next so
> that makes this a bit of a headache.
>
> There's a bunch of stuff in flight, so I'm going to hold off on this
> until after my first week's merge window PR.  I intend on merging the
> following, which is at palmer/riscv-sp for now (I'll probably just
> cherry-pick that, I usually start basing stuff on Linus' merge of my PR
> and just cherry-pick in single patches).
>
>    commit 7c4f6bb6fb352cfa6028191c2888356b9157a332
>    gpg: Signature made Tue 22 Mar 2022 11:12:19 AM PDT
>    gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
>    gpg:                issuer "palmer@dabbelt.com"
>    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
>    gpg:                 aka "Palmer Dabbelt <palmer@rivosinc.com>" [ultimate]
>    Author: Kees Cook <keescook@chromium.org>
>    Date:   Wed Feb 23 22:04:11 2022 -0800
>
>        riscv: Rename "sp_in_global" to "current_stack_pointer"
>
>        To follow the existing per-arch conventions, rename "sp_in_global" to
>        "current_stack_pointer". This will let it be used in non-arch places
>        (like HARDENED_USERCOPY).
>
>        Signed-off-by: Kees Cook <keescook@chromium.org>
>        Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
>    diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>    index 5adcbd9b5e88..b120c32697af 100644
>    --- a/arch/riscv/Kconfig
>    +++ b/arch/riscv/Kconfig
>    @@ -16,6 +16,7 @@ config RISCV
>     	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>     	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>     	select ARCH_HAS_BINFMT_FLAT
>    +	select ARCH_HAS_CURRENT_STACK_POINTER
>     	select ARCH_HAS_DEBUG_VM_PGTABLE
>     	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>     	select ARCH_HAS_DEBUG_WX
>    diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
>    index 1de233d8e8de..21774d868c65 100644
>    --- a/arch/riscv/include/asm/current.h
>    +++ b/arch/riscv/include/asm/current.h
>    @@ -33,6 +33,8 @@ static __always_inline struct task_struct *get_current(void)
>
>     #define current get_current()
>
>    +register unsigned long current_stack_pointer __asm__("sp");
>    +
>     #endif /* __ASSEMBLY__ */
>
>     #endif /* _ASM_RISCV_CURRENT_H */
>    diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>    index 14d2b53ec322..08d11a53f39e 100644
>    --- a/arch/riscv/kernel/stacktrace.c
>    +++ b/arch/riscv/kernel/stacktrace.c
>    @@ -14,8 +14,6 @@
>
>     #include <asm/stacktrace.h>
>
>    -register unsigned long sp_in_global __asm__("sp");
>    -
>     #ifdef CONFIG_FRAME_POINTER
>
>     void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>    @@ -30,7 +28,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>     		pc = instruction_pointer(regs);
>     	} else if (task == NULL || task == current) {
>     		fp = (unsigned long)__builtin_frame_address(0);
>    -		sp = sp_in_global;
>    +		sp = current_stack_pointer;
>     		pc = (unsigned long)walk_stackframe;
>     	} else {
>     		/* task blocked in __switch_to */
>    @@ -78,7 +76,7 @@ void notrace walk_stackframe(struct task_struct *task,
>     		sp = user_stack_pointer(regs);
>     		pc = instruction_pointer(regs);
>     	} else if (task == NULL || task == current) {
>    -		sp = sp_in_global;
>    +		sp = current_stack_pointer;
>     		pc = (unsigned long)walk_stackframe;
>     	} else {
>     		/* task blocked in __switch_to */
>
> Thanks!

Thanks, this is on for-next.  I put HARDENED_USERCOPY=y test in for SLAB 
and SLUB, not sure if there's anything else that's interesting to test 
(we're missing some bits needed for STACKLEAK).
