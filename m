Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF434B6925
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiBOKYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:24:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiBOKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:24:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610922B3E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:24:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v12so31289673wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yheAniF0b6YkThnNE53f6BLG90+fIq+Lpxxu/aXM9PQ=;
        b=GLyey6r/f9CmsAcYOpwFsXlueKIOjQtPpUvxSmFinLSUTMJN8YvMxrJ0D9vat3hSpp
         kK5iaUHOP8rUI5Pam3ZQv6YoB45CXbM7o6RWzY1cAmYxgbly5hTZx1W1sL11G6cF+GqN
         PsKBqxxbV9l5oHrBvH1Ykxv9nE/j6p4vrSrFE0oohrT8Df+RSqNrpnKGYd5ibZBGRMWW
         f7IDjZVin7/usCk36NfA4QGpIsI7jUe3TJ3+AWmlEFybvti3+LeOy2ot4acVWCeqchJe
         12ZnWyW6/t6btNNs6rjJglBxkXmHBwfcGybJBBhY36tSg9wLz0xnxuF2Zj4/H370wbO+
         tjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yheAniF0b6YkThnNE53f6BLG90+fIq+Lpxxu/aXM9PQ=;
        b=kzhGFmWKonTNkUmVmfYVqnp+QSld9iIw2G7McsapvM29wLxfZ5L9+QDDsIOUANWwR5
         xrlYkDDUkDc9O6ft/JxnF7Z0Zg8c9JguUKgzbfhGNcnVdFkeZ/8rK1ic//WUPyOupIIN
         NP/eFDGm4nCAOJUJvijaZlu5lj3NrCo8fR3b6m4dXluG/NA+9ybihosdCfk8S0QLeW+u
         TT3HCnIIJc4RfPelr/IAQSfOg5H/0m6NXR2w3AElIpTod38fJjRULtrLvp4QyTXRkb/i
         CQpty4OBMh3SfKf+KVTbTIdASwvYdFXZq/FIjMmuE+/zpY5DhiykWi1SNAe6El6Bq1vn
         iFig==
X-Gm-Message-State: AOAM533ML9IpgIb8jE2P9pRE+1LaPqUHzzeu2qbFMqyIdKBOQp4OAbbr
        kJfiBoTKHWAhuo7N5vzRhqx/A9FsU7M2rDdFtxgKcQ==
X-Google-Smtp-Source: ABdhPJyqchpD0AQQenT8srcc7TOgqmYacME/qw1r4e63mnHDlpWQDpYEVlRB3exN4scEv+KnyIqUsIgMvHibQ8uenyk=
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr2632030wrt.313.1644920646281;
 Tue, 15 Feb 2022 02:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20220215090211.911366-1-atishp@rivosinc.com> <20220215090211.911366-5-atishp@rivosinc.com>
In-Reply-To: <20220215090211.911366-5-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Feb 2022 15:53:54 +0530
Message-ID: <CAAhSdy29nzXFesfeMjY_FkTmTZ4yrHjGxTweBCVn-wFFHnMV=A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] RISC-V: Implement multi-letter ISA extension
 probing framework
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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

On Tue, Feb 15, 2022 at 2:32 PM Atish Patra <atishp@rivosinc.com> wrote:
>
> Multi-letter extensions can be probed using exising
> riscv_isa_extension_available API now. It doesn't support versioning
> right now as there is no use case for it.
> Individual extension specific implementation will be added during
> each extension support.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
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
> index cd9eb34f8d11..af9a57ad3d4e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
>
>         for_each_of_cpu_node(node) {
>                 unsigned long this_hwcap = 0;
> -               unsigned long this_isa = 0;
> +               uint64_t this_isa = 0;

Why not use a bitmap here ?

>
>                 if (riscv_of_processor_hartid(node) < 0)
>                         continue;
> @@ -167,12 +167,22 @@ void __init riscv_fill_hwcap(void)
>                         if (*isa != '_')
>                                 --isa;
>
> +#define SET_ISA_EXT_MAP(name, bit)                                             \

Where is this macro used ?

> +                       do {                                                    \
> +                               if ((ext_end - ext == sizeof(name) - 1) &&      \
> +                                    !memcmp(ext, name, sizeof(name) - 1)) {    \
> +                                       this_isa |= (1UL << bit);               \

You can use set_bit() here when using bitmap.

> +                                       pr_info("Found ISA extension %s", name);\
> +                               }                                               \
> +                       } while (false)                                         \
> +
>                         if (unlikely(ext_err))
>                                 continue;
>                         if (!ext_long) {
>                                 this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
>                                 this_isa |= (1UL << (*ext - 'a'));
>                         }
> +#undef SET_ISA_EXT_MAP
>                 }
>
>                 /*
> @@ -185,10 +195,21 @@ void __init riscv_fill_hwcap(void)
>                 else
>                         elf_hwcap = this_hwcap;
>
> -               if (riscv_isa[0])
> +               if (riscv_isa[0]) {

You can use bitmap_weight() here

> +#if IS_ENABLED(CONFIG_32BIT)
> +                       riscv_isa[0] &= this_isa & 0xFFFFFFFF;
> +                       riscv_isa[1] &= this_isa >> 32;
> +#else
>                         riscv_isa[0] &= this_isa;
> -               else
> +#endif
> +               } else {
> +#if IS_ENABLED(CONFIG_32BIT)
> +                       riscv_isa[0] = this_isa & 0xFFFFFFFF;
> +                       riscv_isa[1] = this_isa >> 32;
> +#else
>                         riscv_isa[0] = this_isa;
> +#endif
> +               }
>         }
>
>         /* We don't support systems with F but without D, so mask those out
> --
> 2.30.2
>

Regards,
Anup
