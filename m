Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D444C66D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiB1KHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiB1KHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:07:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D93120D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:06:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so14497470wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LqooFbD0UepBIG6prXN+8kyK/NyEL/Idcp6f94AF1M=;
        b=k2hrUaMUt2NVkW8NtY4W7PWsArl+NO+Q8VGR7GkxNMoGq6Jc+h+yQj1n2WRAxvLvSB
         y5AhRiZHReVZVucvi8SbrUyZ4x6Ko5Aizm19HK/xBAfclIZHtxeqZcWoHsVQNNlU6M1w
         QeVsNXDG+qsYTe/6RPZeVfFt4kHilHU8DdyBMm4nyN4XxB+79Yjq4XF3o+zoj38b0416
         8K0/Aa6kCx8jUEuuYd9MwanlRE6W9fRD+1ACaopeCy/WQllPZPfSLLnR9e95MPjnzYnk
         g86REDza6ucg07PbaAtSVG/Voua3Ms6pvaQgTPuK4Jguie8shFpZEEj1l06IO7J2qPJG
         owgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LqooFbD0UepBIG6prXN+8kyK/NyEL/Idcp6f94AF1M=;
        b=obsytnXbLPn0NYbowMo2zmYh045vGxcCXCEoCvtGfQf+2C6GIXNX6tg25duX/OBNLW
         4xLOWlKYo2pFC0oByWQ8+3JuhsISqdrznN71WMawMn2dv9tWcXWypSKuuAZBPE2uV++J
         bwuXxVY7bsVO+nnNWll+PgapL1fEGyt5RrNZONPaFCA21ejsuql8A2Nd0Q8+WN2IeAYJ
         ZTlW2Zg0BywMFT98NZhJao0dnZMoUhmVhljwokfxsJ+gPaIG27EvwVArTumU26o8kA9u
         sC5A+Rd+LPt6bDmDuyTcPu+bO+lCLT+InCbQIi7AfHBzS5M/nVIEn9lgz+5E6qi5AeG9
         DMXA==
X-Gm-Message-State: AOAM531OIG72HCtV0LYBtPlIK1MEze3sN6IWkwKiWPm4cOVm10YY4sUE
        YMT+vdndk1fTvHXwobgdtApMnvbwV3NO7TPdinooaQ==
X-Google-Smtp-Source: ABdhPJxd17V8bmnStdLPa7R9ZP6/mNKcFJy2MFV5I5Rr2BP8+szOvOsgosih4J9u8zNMYc5HNk/WHlZhvZVBNTIMNWg=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr15310363wrz.690.1646042813246; Mon, 28
 Feb 2022 02:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20220222204811.2281949-1-atishp@rivosinc.com> <20220222204811.2281949-5-atishp@rivosinc.com>
In-Reply-To: <20220222204811.2281949-5-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Feb 2022 15:36:35 +0530
Message-ID: <CAAhSdy1Jcxer9-wTppgqCunW6y4jyv5fnmqJphV7z5mi15P_tg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] RISC-V: Implement multi-letter ISA extension
 probing framework
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:18 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> Multi-letter extensions can be probed using exising
> riscv_isa_extension_available API now. It doesn't support versioning
> right now as there is no use case for it.
> Individual extension specific implementation will be added during
> each extension support.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 24 ++++++++++++++++++------
>  2 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 5ce50468aff1..170bd80da520 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
>  #define RISCV_ISA_EXT_s                ('s' - 'a')
>  #define RISCV_ISA_EXT_u                ('u' - 'a')
>
> +/*
> + * Increse this to higher value as kernel support more ISA extensions.
> + */
>  #define RISCV_ISA_EXT_MAX      64
> +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> +
> +/* The base ID for multi-letter ISA extensions */
> +#define RISCV_ISA_EXT_BASE 26
> +
> +/*
> + * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> + * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
> + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> + * extensions while all the multi-letter extensions should define the next
> + * available logical extension id.
> + */
> +enum riscv_isa_ext_id {
> +       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> +};
>
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b0df7eff47f7..c6693873e95c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
>
>         for_each_of_cpu_node(node) {
>                 unsigned long this_hwcap = 0;
> -               unsigned long this_isa = 0;
> +               DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>
>                 if (riscv_of_processor_hartid(node) < 0)
>                         continue;
> @@ -100,6 +100,7 @@ void __init riscv_fill_hwcap(void)
>                 if (!strncmp(isa, "rv64", 4))
>                         isa += 4;
>  #endif
> +               bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
>                 for (; *isa; ++isa) {
>                         const char *ext = isa++;
>                         const char *ext_end = isa;
> @@ -172,12 +173,22 @@ void __init riscv_fill_hwcap(void)
>                         if (*isa != '_')
>                                 --isa;
>
> +#define SET_ISA_EXT_MAP(name, bit)                                             \
> +                       do {                                                    \
> +                               if ((ext_end - ext == sizeof(name) - 1) &&      \
> +                                    !memcmp(ext, name, sizeof(name) - 1)) {    \
> +                                       set_bit(bit, this_isa);                 \
> +                                       pr_info("Found ISA extension %s", name);\
> +                               }                                               \
> +                       } while (false)                                         \
> +
>                         if (unlikely(ext_err))
>                                 continue;
>                         if (!ext_long) {
>                                 this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> -                               this_isa |= (1UL << (*ext - 'a'));
> +                               set_bit(*ext - 'a', this_isa);
>                         }
> +#undef SET_ISA_EXT_MAP
>                 }
>
>                 /*
> @@ -190,10 +201,11 @@ void __init riscv_fill_hwcap(void)
>                 else
>                         elf_hwcap = this_hwcap;
>
> -               if (riscv_isa[0])
> -                       riscv_isa[0] &= this_isa;
> +               if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
> +                       bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>                 else
> -                       riscv_isa[0] = this_isa;
> +                       bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +
>         }
>
>         /* We don't support systems with F but without D, so mask those out
> @@ -207,7 +219,7 @@ void __init riscv_fill_hwcap(void)
>         for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>                 if (riscv_isa[0] & BIT_MASK(i))
>                         print_str[j++] = (char)('a' + i);
> -       pr_info("riscv: ISA extensions %s\n", print_str);
> +       pr_info("riscv: base ISA extensions %s\n", print_str);
>
>         memset(print_str, 0, sizeof(print_str));
>         for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
> --
> 2.30.2
>
