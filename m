Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709DA54596E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbiFJBFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiFJBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:05:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32856121CD3;
        Thu,  9 Jun 2022 18:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AE80B830E0;
        Fri, 10 Jun 2022 01:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DB3C341C8;
        Fri, 10 Jun 2022 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654823103;
        bh=/JC6vRMK2ZMUmpDTejrqQFKw3KBDFhYrGRZvxyI3Gnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hl6g5cuDd5GW2SWS7IJlWE/4OxwP82iGTAgNEKahvpfDguRObw6Zi+lH4HAGzDIVA
         VsZEwc406nlehGbxXOVjPZP1Nk24B2gjo5GgKiLruSlwoBcVkTsEiV0aOox0dqIz2Q
         1TZgKqt3C8OFBYCs7ddqyxjyRrbJwYz3azwsv2oWPvkCQvOi2PkKrJPPADWtBKbuce
         iUpvk6pjzc0JoGSbsPlbE8XxCseAgCFCOo9DmVeCYb//DDcOXckRVtgzV67R7LHc3m
         Cs/GIeuBAUpGTupgWu3Sk+aMPBDr/ehTUDEXRh+iZw6zUUjbOwaSAVuLn0pPOlGSFy
         cm0I4vMQQDjVg==
Received: by mail-vk1-f171.google.com with SMTP id b81so11057280vkf.1;
        Thu, 09 Jun 2022 18:05:03 -0700 (PDT)
X-Gm-Message-State: AOAM530nuW3XKBYxDpH+qPvG+iSZBGTDTh7Fv3WAy/5HTwrVRRWYVVHC
        +nkrH6SuKKgSk7dUn1TUQT2XxXb1A0hNZ6RwQbI=
X-Google-Smtp-Source: ABdhPJzu6lV9dlwNZCZNDB6Y3nGPVvQw9XuVm1a5UwCEqrbJuwP69IoQknN4yGrF/guPUdzhyz0XjabRgd278Q/YBqM=
X-Received: by 2002:ac5:c1c9:0:b0:35c:bd7c:2deb with SMTP id
 g9-20020ac5c1c9000000b0035cbd7c2debmr17712241vkk.2.1654823102633; Thu, 09 Jun
 2022 18:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220610004308.1903626-1-heiko@sntech.de> <20220610004308.1903626-4-heiko@sntech.de>
In-Reply-To: <20220610004308.1903626-4-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 10 Jun 2022 09:04:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQGwa_-sN0gm_Kt01b_4j12AYustAGVKmrSsfpSDYfL_Q@mail.gmail.com>
Message-ID: <CAJF2gTQGwa_-sN0gm_Kt01b_4j12AYustAGVKmrSsfpSDYfL_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: implement cache-management errata for T-Head SoCs
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
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, Jun 10, 2022 at 8:43 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
>
> Add an errata for it next to the generic dma coherency ops.
>
> Tested-by: Samuel Holland <samuel@sholland.org>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas           | 10 ++++++
>  arch/riscv/errata/thead/errata.c     | 15 +++++++++
>  arch/riscv/include/asm/errata_list.h | 48 +++++++++++++++++++++++++---
>  3 files changed, 68 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 457ac72c9b36..4a390035abc7 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -55,4 +55,14 @@ config ERRATA_THEAD_PBMT
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
> index b37b6fedd53b..a3b3612d19df 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -27,6 +27,18 @@ static bool errata_probe_pbmt(unsigned int stage,
>         return false;
>  }
>
> +static bool errata_probe_cmo(unsigned int stage,
> +                            unsigned long arch_id, unsigned long impid)
> +{
> +       if (arch_id != 0 || impid != 0)
> +               return false;
> +
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               return false;
> +
> +       return true;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>                               unsigned long archid, unsigned long impid)
>  {
> @@ -35,6 +47,9 @@ static u32 thead_errata_probe(unsigned int stage,
>         if (errata_probe_pbmt(stage, archid, impid))
>                 cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
>
> +       if (errata_probe_cmo(stage, archid, impid))
> +                cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
> +
>         return cpu_req_errata;
>  }
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 2e80a75b5241..a48605d55c3c 100644
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
> @@ -105,17 +106,54 @@ asm volatile(ALTERNATIVE(                                         \
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
> -       __nops(5),                                                      \
> +asm volatile(ALTERNATIVE_2(                                            \
> +       __nops(6),                                                      \
>         "mv a0, %1\n\t"                                                 \
>         "j 2f\n\t"                                                      \
>         "3:\n\t"                                                        \
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
>             "r"(ALIGN((_start) + (_size), (_cachesize)))                \
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
