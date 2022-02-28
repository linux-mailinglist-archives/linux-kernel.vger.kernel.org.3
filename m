Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7601E4C66C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiB1KE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiB1KEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:04:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB072B25B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:03:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d17so14472670wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De2OyZDcwN8o9X6MlMOt7Z7zT/UnfJwRn/VzFf9UnSs=;
        b=fJStaRDEFlrEswt+fpTK2NKKLCysIBk9+9As1XpWnYiXYb6WSBa9HMnYv1oALWt90b
         FWgM/N0s7lfVF4sLe0v2KvjRyHhNeEIwIvYNQsYvW5Vo92TpqFg4oeKlyJvv+Ru/VVeE
         PIOle2bi4UKKxz8KUOAzet02s2pLc2xouIe4Sd5nd4sgiXp0u5P47NozZOMp1ZHITyEg
         eoqOONuIJbEE4jlWLGf5kC4J+nMw8v345/VYKZ2d9o2eV1+JJsxk+mmY9Sro15+rdDHs
         ZY0XJ+Tjpk6hWW9iDbEWHdtNd0Bwt7dQUFK1eTaz9eryP9rbmsRILoDtAkodgUGVolBc
         SEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De2OyZDcwN8o9X6MlMOt7Z7zT/UnfJwRn/VzFf9UnSs=;
        b=d9V0vcD88VM4d0Q/Z/YR53AygTRu5iYzNm9TvgZVoI9isFijuvXX4wptYkI/T39I2h
         S+58maXMp/i7bxa0lYN4JwX0+oqaTrHkevzSDsYEX2ETCnQW/zvaxPkiMxnaQ6YSJ4O8
         6n1mBNJNwQYX9EgyiKmacs1j3//rrFjHGU1yD9qqcdiAPjR2lhhjea4JoM30WpoApmKg
         /FbWOUEnFZGcxqsmJSN09PgQ4EbfTSXOuBCgEZdVevJEo2E7cvIx0YsYCzUwAf4tTAEj
         4WlxBBoOm1HJhzMnF++UiaVUe+AcdeMsZgybNDK9IqLP6JgcZLgK9Eg++yQv78xoa/FY
         YXMg==
X-Gm-Message-State: AOAM533XO9PR9qHOfCtm8XeCHmQezXh35pmoZh/BlikrlgFh1Mc5i3PV
        dVLqH7TE67U9sbgbeJlRh6MTxFxU+B2fzw9NlGUF0A==
X-Google-Smtp-Source: ABdhPJyhFiH8N+Cg9snwWZQcrUZ0PXgXCv096GnXewDUHoL1YMtQ+KNX9d1XOME2w+qCQYNCyJW6ohVu75CUElWR4MU=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr15298582wrz.690.1646042623031; Mon, 28
 Feb 2022 02:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20220222204811.2281949-1-atishp@rivosinc.com> <20220222204811.2281949-3-atishp@rivosinc.com>
In-Reply-To: <20220222204811.2281949-3-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Feb 2022 15:33:24 +0530
Message-ID: <CAAhSdy3EzPugs=-=gSuHbS8XEnxRM-2yyuLLoMfh2+QaciP=hQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] RISC-V: Minimal parser for "riscv, isa" strings
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:18 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> From: Tsukasa OI <research_trasio@irq.a4lg.com>
>
> Current hart ISA ("riscv,isa") parser don't correctly parse:
>
> 1. Multi-letter extensions
> 2. Version numbers
>
> All ISA extensions ratified recently has multi-letter extensions
> (except 'H'). The current "riscv,isa" parser that is easily confused
> by multi-letter extensions and "p" in version numbers can be a huge
> problem for adding new extensions through the device tree.
>
> Leaving it would create incompatible hacks and would make "riscv,isa"
> value unreliable.
>
> This commit implements minimal parser for "riscv,isa" strings.  With this,
> we can safely ignore multi-letter extensions and version numbers.
>
> [Improved commit text and fixed a bug around 's' in base extension]
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> [Fixed workaround for QEMU]
> Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 72 ++++++++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index dd3d57eb4eea..72c5f6ef56b5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/bitmap.h>
> +#include <linux/ctype.h>
>  #include <linux/of.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
> @@ -66,7 +67,7 @@ void __init riscv_fill_hwcap(void)
>         struct device_node *node;
>         const char *isa;
>         char print_str[NUM_ALPHA_EXTS + 1];
> -       size_t i, j, isa_len;
> +       int i, j;
>         static unsigned long isa2hwcap[256] = {0};
>
>         isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
> @@ -92,23 +93,72 @@ void __init riscv_fill_hwcap(void)
>                         continue;
>                 }
>
> -               i = 0;
> -               isa_len = strlen(isa);
>  #if IS_ENABLED(CONFIG_32BIT)
>                 if (!strncmp(isa, "rv32", 4))
> -                       i += 4;
> +                       isa += 4;
>  #elif IS_ENABLED(CONFIG_64BIT)
>                 if (!strncmp(isa, "rv64", 4))
> -                       i += 4;
> +                       isa += 4;
>  #endif
> -               for (; i < isa_len; ++i) {
> -                       this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> +               for (; *isa; ++isa) {
> +                       const char *ext = isa++;
> +                       const char *ext_end = isa;
> +                       bool ext_long = false, ext_err = false;
> +
> +                       switch (*ext) {
> +                       case 's':
> +                               /**
> +                                * Workaround for invalid single-letter 's' & 'u'(QEMU).
> +                                * No need to set the bit in riscv_isa as 's' & 'u' are
> +                                * not valid ISA extensions. It works until multi-letter
> +                                * extension starting with "Su" appears.
> +                                */
> +                               if (ext[-1] != '_' && ext[1] == 'u') {
> +                                       ++isa;
> +                                       ext_err = true;
> +                                       break;
> +                               }
> +                               fallthrough;
> +                       case 'x':
> +                       case 'z':
> +                               ext_long = true;
> +                               /* Multi-letter extension must be delimited */
> +                               for (; *isa && *isa != '_'; ++isa)
> +                                       if (!islower(*isa) && !isdigit(*isa))
> +                                               ext_err = true;
> +                               break;
> +                       default:
> +                               if (unlikely(!islower(*ext))) {
> +                                       ext_err = true;
> +                                       break;
> +                               }
> +                               /* Find next extension */
> +                               if (!isdigit(*isa))
> +                                       break;
> +                               /* Skip the minor version */
> +                               while (isdigit(*++isa))
> +                                       ;
> +                               if (*isa != 'p')
> +                                       break;
> +                               if (!isdigit(*++isa)) {
> +                                       --isa;
> +                                       break;
> +                               }
> +                               /* Skip the major version */
> +                               while (isdigit(*++isa))
> +                                       ;
> +                               break;
> +                       }
> +                       if (*isa != '_')
> +                               --isa;
>                         /*
> -                        * TODO: X, Y and Z extension parsing for Host ISA
> -                        * bitmap will be added in-future.
> +                        * TODO: Full version-aware handling including
> +                        * multi-letter extensions will be added in-future.
>                          */
> -                       if ('a' <= isa[i] && isa[i] < 'x')
> -                               this_isa |= (1UL << (isa[i] - 'a'));
> +                       if (ext_err || ext_long)
> +                               continue;
> +                       this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> +                       this_isa |= (1UL << (*ext - 'a'));
>                 }
>
>                 /*
> --
> 2.30.2
>
