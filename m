Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A624D92D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiCODKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiCODKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:10:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354512A8C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:09:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h15so26903624wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7g0K54nVLUTeFY+Xiq13+Lcl23/G9XSsoGzliKSx0N0=;
        b=aOwohZrc2UJGtL5DFjR0H3NtcWGZNigBz5f79Ll5nvrQr2V7ER7sOTahWSqOlExHv2
         hGCZ4vVGRL3owxOUGUtW/YbNVAx4SczJ9rlvd9iRCI4H98VGda7Q7codlaHwUED9arjx
         POie1YTd5NVz1MloBrFYKSK6zjwgyuOo8d6osOD05OLz8xyhf7jtnm0OjPaE/8WBkYJU
         KKcd8/s7hjOipaepas9lVRBRhhEBmhp/yWIlJ5xStAVa2IE/qzL/N7F6ewELKyu3OQFq
         P1zNzzF1hOxUB7uOGSkXeGMZs7OBhdn9YTX5z4bWLI8AX3S0S2zcLaU+MZoVmbMihvZB
         1sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7g0K54nVLUTeFY+Xiq13+Lcl23/G9XSsoGzliKSx0N0=;
        b=CAR/afB/LuZTXV/XBSfLusixpiJOk0pmsxZQw7T6qfAhiKjeeRDi+9g0TDVEbJTY3E
         fg2bq7G/2YNqfswhzX9xpDmUN7yhSo5ki/0N9Y1Uupodh3P2IW4G9+nf7s9VlKU1Q9Gd
         5XtFKvwm+GTHZltXOVV85ZhYi76OXKU+wnrFna51zwx//iO4RKE8mZ0mQ1XHB5KNyTJ9
         x6J0eeNMdcP+lN+WfcWB8t4TwYwCkTWAZjQBM88bkRux2jrhjLef/yIrn4sULQTLfoGX
         JftviY/3GcHBTTYo7A/IjUrZErRdW3FDK9c9PIF0akr1X/sap6lB9katElt9OUaLX6dg
         Ci9Q==
X-Gm-Message-State: AOAM530HtIx2LtLTJmJxYhocXCKi9qgoD6nkMnHX0P3V+gsYrGAeVFYx
        dZsKg/ZXxsc2Q5Oy3hLPShXpC8thUBgAmmO0l6byvg==
X-Google-Smtp-Source: ABdhPJxrZ9uUPr/2beAT1DxtmsZj50aZ8qJ86HDlV7xe2tV7yaAy+bjEFVuM/aweUE6mfUpFYYSJVTMTCsNk0kVM/HE=
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id
 i5-20020adfb645000000b001e30bab7594mr18994102wre.346.1647313758874; Mon, 14
 Mar 2022 20:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220314203845.832648-1-atishp@rivosinc.com> <20220314203845.832648-5-atishp@rivosinc.com>
In-Reply-To: <20220314203845.832648-5-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Mar 2022 08:39:05 +0530
Message-ID: <CAAhSdy2kcFKC2-QTE28dujcBKybo_dxKrc+_+m3s97cr2mvxzg@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] RISC-V: Implement multi-letter ISA extension
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 2:09 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> Multi-letter extensions can be probed using exising
> riscv_isa_extension_available API now. It doesn't support versioning
> right now as there is no use case for it.
> Individual extension specific implementation will be added during
> each extension support.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 22 ++++++++++++++++------
>  2 files changed, 34 insertions(+), 6 deletions(-)
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
> index b0df7eff47f7..3455fdfd680e 100644
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
> @@ -172,12 +173,20 @@ void __init riscv_fill_hwcap(void)
>                         if (*isa != '_')
>                                 --isa;
>
> +#define SET_ISA_EXT_MAP(name, bit)                                             \
> +                       do {                                                    \
> +                               if ((ext_end - ext == sizeof(name) - 1) &&      \
> +                                    !memcmp(ext, name, sizeof(name) - 1))      \
> +                                       set_bit(bit, this_isa);                 \
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
> @@ -190,10 +199,11 @@ void __init riscv_fill_hwcap(void)
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
> @@ -207,7 +217,7 @@ void __init riscv_fill_hwcap(void)
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
