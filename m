Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBF509828
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385093AbiDUGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385245AbiDUGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29601571E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A776618EF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0979C385A9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650523535;
        bh=XmD3fQqaE1QlQl0Ou18qxCBJ44u5jN9YANPYrgXv72k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RldMqX8pWXJ6W2sFCHqsanE4bUiFeYzGoN9gjVEIKdz1Rj/rDDXsSaVDLEzVQNitP
         dlJ+pV6DG4h7A83eYzq5CIP5Z2YX/pY+98x/B1kw0/ZOA0RcMepZo3kUekur92G8u3
         unDX9kkfiTkReRIsaxd3ihf9L9AHz3Q8l3+Br4w2AfUo4bLn65DP/zzjgtRfKsbUqk
         Xx7swo10BeiXuaDHjG8dQH/P6B0tVlAE3JPMDZ5pLpqbiGUOLdRP3p+EKri5jy1y9P
         huEaKY2C6jCXlUIpnLJokKziSOP4Cof3j7U05ZNsNqJDskFt8EN6NebC9SaveJeG7J
         tq7CtJrwGcq0w==
Received: by mail-vs1-f43.google.com with SMTP id a127so3688454vsa.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:45:35 -0700 (PDT)
X-Gm-Message-State: AOAM531lBzRt+GpH1tzagaBQkJB52rMPXWOZF6xGLvExLbhO+jg0issc
        mXf1RF2qUbt5UvZpUNAgbg0rshM8PdWskbAwc2o=
X-Google-Smtp-Source: ABdhPJwgS4j0kuWJWgUi1CwuKSCCgbndOQjfivrwEexaVF07XE4uKCHIvpzw0aQ58agZVsBtbxQ5ROA8EOZMpVXYmgI=
X-Received: by 2002:a67:eb03:0:b0:32a:5ccb:21e7 with SMTP id
 a3-20020a67eb03000000b0032a5ccb21e7mr5940061vso.8.1650523534835; Wed, 20 Apr
 2022 23:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220420184056.7886-1-palmer@rivosinc.com> <20220420184056.7886-4-palmer@rivosinc.com>
In-Reply-To: <20220420184056.7886-4-palmer@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Apr 2022 14:45:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTC4V_vSFFranTB6PZrHK08J8KygjfACxfQ91POpRtY-Q@mail.gmail.com>
Message-ID: <CAJF2gTTC4V_vSFFranTB6PZrHK08J8KygjfACxfQ91POpRtY-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] RISC-V: Split out the XIP fixups into their own file
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        jszhang@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
        gatecat@ds0.me, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        =?UTF-8?B?5r2Y5bqG6ZyW?= <panqinglin2020@iscas.ac.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 2:48 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This was broken by the original refactoring (as the XIP definitions
> depend on <asm/pgtable.h>) and then more broken by the merge (as I
> accidentally took the old version).  This fixes both breakages, while
> also pulling this out of <asm/asm.h> to avoid polluting most assembly
> files with the XIP fixups.
>
> Fixes: bee7fbc38579 ("RISC-V CPU Idle Support")
> Fixes: 63b13e64a829 ("RISC-V: Add arch functions for non-retentive suspend entry/exit")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/include/asm/asm.h       | 26 ------------------------
>  arch/riscv/include/asm/xip_fixup.h | 32 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S           |  1 +
>  arch/riscv/kernel/suspend_entry.S  |  1 +
>  4 files changed, 34 insertions(+), 26 deletions(-)
>  create mode 100644 arch/riscv/include/asm/xip_fixup.h
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 8c2549b16ac0..618d7c5af1a2 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -67,30 +67,4 @@
>  #error "Unexpected __SIZEOF_SHORT__"
>  #endif
>
> -#ifdef __ASSEMBLY__
> -
> -/* Common assembly source macros */
> -
> -#ifdef CONFIG_XIP_KERNEL
> -.macro XIP_FIXUP_OFFSET reg
> -       REG_L t0, _xip_fixup
> -       add \reg, \reg, t0
> -.endm
> -.macro XIP_FIXUP_FLASH_OFFSET reg
> -       la t1, __data_loc
> -       REG_L t1, _xip_phys_offset
> -       sub \reg, \reg, t1
> -       add \reg, \reg, t0
> -.endm
> -_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> -_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
> -#else
> -.macro XIP_FIXUP_OFFSET reg
> -.endm
> -.macro XIP_FIXUP_FLASH_OFFSET reg
> -.endm
> -#endif /* CONFIG_XIP_KERNEL */
> -
> -#endif /* __ASSEMBLY__ */
> -
>  #endif /* _ASM_RISCV_ASM_H */
> diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
> new file mode 100644
> index 000000000000..0d0754305324
> --- /dev/null
> +++ b/arch/riscv/include/asm/xip_fixup.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * XIP fixup macros, only useful in assembly.
> + */
> +#ifndef _ASM_RISCV_XIP_FIXUP_H
> +#define _ASM_RISCV_XIP_FIXUP_H
> +
> +#include <linux/pgtable.h>
> +
> +#ifdef CONFIG_XIP_KERNEL
> +.macro XIP_FIXUP_OFFSET reg
> +        REG_L t0, _xip_fixup
> +        add \reg, \reg, t0
> +.endm
> +.macro XIP_FIXUP_FLASH_OFFSET reg
> +        la t1, __data_loc
> +        li t0, XIP_OFFSET_MASK
> +        and t1, t1, t0
> +        li t1, XIP_OFFSET
I still prefer the style:
REG_L t1, _xip_phys_offset
...
_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET

Because it's more clear and has the same style as your _xip_fixup.

Others:
Reviewed-by: Guo Ren <guoren@kernel.org>

> +        sub t0, t0, t1
> +        sub \reg, \reg, t0
> +.endm
-.endm
> +
> +_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> +#else
> +.macro XIP_FIXUP_OFFSET reg
> +.endm
> +.macro XIP_FIXUP_FLASH_OFFSET reg
> +.endm
> +#endif /* CONFIG_XIP_KERNEL */
> +
> +#endif
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 893b8bb69391..822c33aa7f45 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -14,6 +14,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/image.h>
> +#include <asm/xip_fixup.h>
>  #include "efi-header.S"
>
>  __HEAD
> diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
> index 4b07b809a2b8..aafcca58c19d 100644
> --- a/arch/riscv/kernel/suspend_entry.S
> +++ b/arch/riscv/kernel/suspend_entry.S
> @@ -8,6 +8,7 @@
>  #include <asm/asm.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/csr.h>
> +#include <asm/xip_fixup.h>
>
>         .text
>         .altmacro
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
