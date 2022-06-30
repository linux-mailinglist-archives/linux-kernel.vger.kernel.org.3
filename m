Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC08560F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiF3DFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiF3DFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9193C4BF;
        Wed, 29 Jun 2022 20:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA5961033;
        Thu, 30 Jun 2022 03:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ACDC385A2;
        Thu, 30 Jun 2022 03:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656558301;
        bh=f71N3CyLEkjrrrfgB+T6ejRQkPnQ4qpBPjvwg7ZXCUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gPKilkN2qMRWoAm3lIi8oj15z9EmhsQExiclYODpuz/J3+M2rFEAN+A3qLBWlRJ22
         zFdGGq58Ky5z2HsGmpYfp4r/0Rx9hKMVhQKnpfZyX/p8HeSM2RhsI0TDJhGWRg5DpY
         xyAA3sGV9r+0tfWvAaov3yPnRDgrDWZik/r9wVewlH3Ui8MaZG9jhwaNZoXbbSy9ws
         ZjCL70N6sbzTvqysZI9/fGyBNAIWDMlzwPkIjtEHpxEF3dGJa3r4qosKeoIZHlBojX
         KZ9adEhkVd0qdW5+ruZlYshLVUUu5VQvsyYfUiRw7WQUuNifXoNHYKM5NSIqE5EFLz
         n5PB/GdB/y5Vg==
Received: by mail-vk1-f170.google.com with SMTP id j15so8365611vkp.5;
        Wed, 29 Jun 2022 20:05:01 -0700 (PDT)
X-Gm-Message-State: AJIora/O4TIPqaVPg1dn5C1erIll1dxx7g35lam1PeP5rB8ByZfj0Ztl
        V6yh7S6cWhfbEp8haQHK2UOVf40f1bMST6737nU=
X-Google-Smtp-Source: AGRyM1sC8pETo6ILy6WuQHPf/CL+h90qiWslGUQcdYbj6WLPzvCMX4ozFqZnlcIRxLX1LPI2KJZPh8i1hwcqDnO5Xk4=
X-Received: by 2002:a1f:1bc8:0:b0:36c:a88c:961a with SMTP id
 b191-20020a1f1bc8000000b0036ca88c961amr6521146vkb.2.1656558300483; Wed, 29
 Jun 2022 20:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220629215944.397952-1-heiko@sntech.de> <20220629215944.397952-5-heiko@sntech.de>
In-Reply-To: <20220629215944.397952-5-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 30 Jun 2022 11:04:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTkWgnkNdng=En+g84EYxUi1BMpzsQW9Y0+-_Xhqbuogg@mail.gmail.com>
Message-ID: <CAJF2gTTkWgnkNdng=En+g84EYxUi1BMpzsQW9Y0+-_Xhqbuogg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] riscv: implement cache-management errata for
 T-Head SoCs
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Jun 30, 2022 at 6:00 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
>
> Add an errata for it next to the generic dma coherency ops.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> Tested-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/riscv/Kconfig.erratas           | 11 +++++++
>  arch/riscv/errata/thead/errata.c     | 20 ++++++++++++
>  arch/riscv/include/asm/errata_list.h | 48 +++++++++++++++++++++++++---
>  3 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 457ac72c9b36..3223e533fd87 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -55,4 +55,15 @@ config ERRATA_THEAD_PBMT
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD_CMO
> +       bool "Apply T-Head cache management errata"
> +       depends on ERRATA_THEAD
> +       select RISCV_DMA_NONCOHERENT
> +       default y
> +       help
> +         This will apply the cache management errata to handle the
> +         non-standard handling on non-coherent operations on T-Head SoCs.
> +
> +         If you don't know what to do here, say "Y".
> +
>  endmenu
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 852283460fb9..cf6bd44db656 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -29,6 +29,23 @@ static bool errata_probe_pbmt(unsigned int stage,
>         return false;
>  }
>
> +static bool errata_probe_cmo(unsigned int stage,
> +                            unsigned long arch_id, unsigned long impid)
> +{
> +#ifdef CONFIG_ERRATA_THEAD_CMO
> +       if (arch_id != 0 || impid != 0)
> +               return false;
> +
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               return false;
> +
> +       riscv_noncoherent_supported();
> +       return true;
> +#else
> +       return false;
> +#endif
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>                               unsigned long archid, unsigned long impid)
>  {
> @@ -37,6 +54,9 @@ static u32 thead_errata_probe(unsigned int stage,
>         if (errata_probe_pbmt(stage, archid, impid))
>                 cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
>
> +       if (errata_probe_cmo(stage, archid, impid))
> +               cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
> +
>         return cpu_req_errata;
>  }
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 79d89aeeaa6c..19a771085781 100644
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
> @@ -88,17 +89,54 @@ asm volatile(ALTERNATIVE(                                           \
>  #define ALT_THEAD_PMA(_val)
>  #endif
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
> +#define THEAD_inval_A0 ".long 0x0265000b"
> +#define THEAD_clean_A0 ".long 0x0245000b"
> +#define THEAD_flush_A0 ".long 0x0275000b"
> +#define THEAD_SYNC_S   ".long 0x0190000b"
> +
>  #define ALT_CMO_OP(_op, _start, _size, _cachesize)                     \
> -asm volatile(ALTERNATIVE(                                              \
> -       __nops(5),                                                      \
> +asm volatile(ALTERNATIVE_2(                                            \
> +       __nops(6),                                                      \
>         "mv a0, %1\n\t"                                                 \
>         "j 2f\n\t"                                                      \
>         "3:\n\t"                                                        \
>         "cbo." __stringify(_op) " (a0)\n\t"                             \
>         "add a0, a0, %0\n\t"                                            \
>         "2:\n\t"                                                        \
> -       "bltu a0, %2, 3b\n\t", 0,                                       \
> -               CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM)             \
> +       "bltu a0, %2, 3b\n\t"                                           \
> +       "nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,           \
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
>             "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),       \
>             "r"((unsigned long)(_start) + (_size))                      \
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
