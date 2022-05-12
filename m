Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212552446C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbiELEl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347742AbiELElP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:41:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932453A76
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:41:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so5589626wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcdYqWHUqRf4Mz3kgMux9R5B7ffyNDGfpfPaHK4SM0g=;
        b=DFeUcDo6H2aoV6kYVU1JvbEJ0fuGodd7wNIkeCe0MhRPUeTnvZD9V0dbhGKMnR3dLs
         w8YBKvAwjgUQE4U7grVMrM7nrEWmhOCRqko3Nwzs+kpzWgAlR3ZWAllP/uCYDVveInj3
         dv2F+Qfg/tUt3JAPKeRxqUiMP3vWXLIqy+veroQ6MhkYR/DGilKTSkVwDK5BwNVWvoB0
         bftw0g9FXr0h2G1VBe3SdH7+pKo5Vw5rp6g/T3f8BrRUql84EopPPQw1wfU+XT8rC185
         SZ78qaj/vvLQjkOZt3F+IgjZVf/UpSMB3fGh+bqq4VTAMUOyy4TKPscX3Ux9X8YiJZar
         ONiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcdYqWHUqRf4Mz3kgMux9R5B7ffyNDGfpfPaHK4SM0g=;
        b=HEBwE2GYF3P0l/2dd4qaVR31VTrGYPdfm7L21+LCfBpfgmHV8jOEhEwJCLnKR6AdIX
         vWdzYrupf/h7JWJVhkyn+YDFeili4leNN6yfWvJ5L6pMtWMZcZ05eRh4vePLHAB/qnYn
         jhUmL8TaTlJIvmhVBs5RW7NBSUcuqppPyEmus9zYTGNn9Wf6m8Lm9K2ngaum6NpzZRRJ
         K1YwUzXw7a6vswcvgknVNx3mmqzvjPpxNc6vIOYoVB6daliJ3Goo1Y4umQk18OA1v2WK
         QQs+jD6UQjgGiETTYGBvkPkleruQbMM1DoRlkbR70ruFlUVrC4lqSCJ5epIZ/wb8fX1z
         QnEg==
X-Gm-Message-State: AOAM531YLd3l4y26Qkd5KASCleZ45kb6BONehn7QsGHlUzVRyPCHo7In
        lKIX0S6QAwVN6Pa1ciw/p+1jqjRLRRey9cEIO0DuKQ==
X-Google-Smtp-Source: ABdhPJzFHXexIjbxwrPi8VDw5SUTt3fwk7U1IbTJW8vPrLoeOOXHgzVY7R/ZhvxdoNfTOEiOTbaiPCw7yjXOUoGCILI=
X-Received: by 2002:a5d:6d0d:0:b0:20c:530c:1681 with SMTP id
 e13-20020a5d6d0d000000b0020c530c1681mr25385269wrq.214.1652330470743; Wed, 11
 May 2022 21:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220511214132.2281431-1-heiko@sntech.de> <20220511214132.2281431-4-heiko@sntech.de>
In-Reply-To: <20220511214132.2281431-4-heiko@sntech.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 12 May 2022 10:10:58 +0530
Message-ID: <CAAhSdy1riRoVKz=7N865ZJ6tsPO+diULZ8ctNrqVuXEmgtrqOA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: implement cache-management errata for
 T-Head SoCs
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 3:11 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
>
> Add an errata for it next to the generic dma coherency ops.
>
> Tested-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/Kconfig.erratas           | 10 ++++++
>  arch/riscv/errata/thead/errata.c     |  5 +++
>  arch/riscv/include/asm/errata_list.h | 47 +++++++++++++++++++++++++---
>  3 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index ebfcd5cc6eaf..213629bac5d7 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -54,4 +54,14 @@ config ERRATA_THEAD_PBMT
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD_CMO
> +       bool "Apply T-Head cache management errata"
> +       depends on ERRATA_THEAD && RISCV_ISA_ZICBOM
> +       default y
> +       help
> +         This will apply the cache management errata to handle the
> +         non-standard handling on non-coherent operations on T-Head SoCs.
> +
> +         If you don't know what to do here, say "Y".
> +
>  endmenu
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index e5d75270b99c..9545f43d3504 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -33,6 +33,11 @@ static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
>                 .stage = RISCV_ALTERNATIVES_EARLY_BOOT,
>                 .check_func = errata_mt_check_func
>         },
> +       {
> +               .name = "cache-management",
> +               .stage = RISCV_ALTERNATIVES_BOOT,
> +               .check_func = errata_mt_check_func
> +       },
>  };
>
>  static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index eebcd4415049..1da311fc5126 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -16,7 +16,8 @@
>
>  #ifdef CONFIG_ERRATA_THEAD
>  #define        ERRATA_THEAD_PBMT 0
> -#define        ERRATA_THEAD_NUMBER 1
> +#define        ERRATA_THEAD_CMO 1
> +#define        ERRATA_THEAD_NUMBER 2
>  #endif
>
>  #define        CPUFEATURE_SVPBMT 0
> @@ -111,8 +112,37 @@ asm volatile(ALTERNATIVE(                                          \
>  #define CBO_CLEAN_A0   ".long 0x25200F"
>  #define CBO_FLUSH_A0   ".long 0x05200F"
>
> +/*
> + * dcache.ipa rs1 (invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01010      rs1       000      00000  0001011
> + * dache.iva rs1 (invalida, virtual address)
> + *   0000001    00110      rs1       000      00000  0001011
> + *
> + * dcache.cpa rs1 (clean, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01001      rs1       000      00000  0001011
> + * dcache.cva rs1 (clean, virtual address)
> + *   0000001    00100      rs1       000      00000  0001011
> + *
> + * dcache.cipa rs1 (clean then invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01011      rs1       000      00000  0001011
> + * dcache.civa rs1 (... virtual address)
> + *   0000001    00111      rs1       000      00000  0001011
> + *
> + * sync.s (make sure all cache operations finished)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000000    11001     00000      000      00000  0001011
> + */
> +#define THEAD_INVAL_A0 ".long 0x0265000b"
> +#define THEAD_CLEAN_A0 ".long 0x0245000b"
> +#define THEAD_FLUSH_A0 ".long 0x0275000b"
> +#define THEAD_SYNC_S   ".long 0x0190000b"
> +
>  #define ALT_CMO_OP(_op, _start, _size, _cachesize)                     \
> -asm volatile(ALTERNATIVE(                                              \
> +asm volatile(ALTERNATIVE_2(                                            \
> +       "nop\n\t"                                                       \
>         "nop\n\t"                                                       \
>         "nop\n\t"                                                       \
>         "nop\n\t"                                                       \
> @@ -124,8 +154,17 @@ asm volatile(ALTERNATIVE(                                          \
>         CBO_##_op##_A0 "\n\t"                                           \
>         "add a0, a0, %0\n\t"                                            \
>         "2:\n\t"                                                        \
> -       "bltu a0, %2, 3b\n\t", 0,                                       \
> -               CPUFEATURE_CMO, CONFIG_RISCV_ISA_ZICBOM)                \
> +       "bltu a0, %2, 3b\n\t"                                           \
> +       "nop", 0, CPUFEATURE_CMO, CONFIG_RISCV_ISA_ZICBOM,              \
> +       "mv a0, %1\n\t"                                                 \
> +       "j 2f\n\t"                                                      \
> +       "3:\n\t"                                                        \
> +       THEAD_##_op##_A0 "\n\t"                                         \
> +       "add a0, a0, %0\n\t"                                            \
> +       "2:\n\t"                                                        \
> +       "bltu a0, %2, 3b\n\t"                                           \
> +       THEAD_SYNC_S, THEAD_VENDOR_ID,                                  \
> +                       ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)      \
>         : : "r"(_cachesize),                                            \
>             "r"(ALIGN((_start), (_cachesize))),                         \
>             "r"(ALIGN((_start) + (_size), (_cachesize))))
> --
> 2.35.1
>
