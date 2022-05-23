Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7010D5314B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiEWPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiEWPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:08:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D475C74D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:08:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so21841132wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ys4XdVscv5VNlcHHCYpLwgVZ+X8P1XO1ISLGENGjWOQ=;
        b=BjX2AvhJL3a02i3+eGBxYQWW6FMsRR6Yrw5epDlnSmm4uVdIfmQG/bBKQ5CXnKJehC
         gtN1AFqiK55TTf7VuHoIvbUZl3DuWzeGARd+XPNlKkTp4JPYZlb6SRbke/i8x3o0uHHU
         +2EXNbvx2pVc1LY/DNgXEFgUMDFGP3IqFiOKR82Q0bimMXPKgTkPBFqWW27RGtupMw00
         mZs6wkMjwJc+2Xs5uLu1CMxKi3ocrm5uTL4olmG7jKmysExazGkgyfYQv/Fd70CQhiyf
         /NrIXUtXCURW8JEtBCkUAC2dxCuo2XnWQaVXRQflZPuYCtUSqXaSlHrUaE77P6Zi/U3t
         Kkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ys4XdVscv5VNlcHHCYpLwgVZ+X8P1XO1ISLGENGjWOQ=;
        b=Vh6Kcw5axyWc6WEuDbPe07k2kp90q13I9+YLlRmjWUBW8+51HhzO5cJ/lHCVPKzhF+
         ypnQFkC+0XtThdXTiI9f9DOAaEQjk3o/G8YV8VijzpWZKfF+rvX2y3T3V8l7HQh0eetJ
         KWUEYaV8Sr3jfyK0OrpC8B40ebC1WzUASKGsZyrvPaYgCaQZTjgI678XjY1dCrb2MwFZ
         Prb6b+KyrEActWPrQ93pK4n9BepsrfeWV6xTIsrllNhGnpZFvggj7afqrzCxubNfdswv
         8NgQxdXxdVhfGMR+Yd9prGcOLBa0UZKt8bw/kK3Ag8qrrh5m2eQr1zQECDJJJ5eHUoJQ
         SvWA==
X-Gm-Message-State: AOAM530m7VKkHy/T858alOYf4OgF3jC8sGJw0OsfFCL3uvcV4YiyL/Rv
        8/LJUa8asG5APrOJvdc7Ed/HamqD3aLZnU2dpUAmDA==
X-Google-Smtp-Source: ABdhPJwKTbFlVMufZx9p5Z+x6LafUNHGnWotQYTTznqHO3KKhRIyZY9h5NSg25siQNu+a6YhKz9oUQE0cz4QQh+rVlo=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr19522626wrz.690.1653318479248; Mon, 23
 May 2022 08:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220522153543.2656-1-jszhang@kernel.org> <20220522153543.2656-2-jszhang@kernel.org>
In-Reply-To: <20220522153543.2656-2-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 23 May 2022 20:37:47 +0530
Message-ID: <CAAhSdy0Z7fqfNd7PGPmbRum=Yiu8ziRbjefF3NHeqihSKSS8SQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: introduce unified static key mechanism for
 ISA extensions
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 9:14 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently, riscv has several extensions which may not be supported on
> all riscv platforms, for example, FPU and so on. To support unified
> kernel Image style, we need to check whether the feature is supported
> or not. If the check sits at hot code path, then performance will be
> impacted a lot. static key can be used to solve the issue. In the past,
> FPU support has been converted to use static key mechanism. I believe
> we will have similar cases in the future.
>
> This patch tries to add an unified mechanism to use static keys for
> some ISA extensions by implementing an array of default-false static keys
> and enabling them when detected.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/hwcap.h | 25 +++++++++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c |  7 +++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0734e42f74f2..d3e113fe7366 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -12,6 +12,7 @@
>  #include <uapi/asm/hwcap.h>
>
>  #ifndef __ASSEMBLY__
> +#include <linux/jump_label.h>
>  /*
>   * This yields a mask that user programs can use to figure out what
>   * instruction set this cpu supports.
> @@ -55,6 +56,16 @@ enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>
> +/*
> + * This enum represents the logical ID for each RISC-V ISA extension static
> + * keys. We can use static key to optimize code path if some ISA extensions
> + * are available.
> + */
> +enum riscv_isa_ext_key {
> +       RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> +       RISCV_ISA_EXT_KEY_MAX,
> +};
> +
>  struct riscv_isa_ext_data {
>         /* Name of the extension displayed to userspace via /proc/cpuinfo */
>         char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> @@ -62,6 +73,20 @@ struct riscv_isa_ext_data {
>         unsigned int isa_ext_id;
>  };
>
> +extern struct static_key_false riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_MAX];
> +
> +static __always_inline int riscv_isa_ext2key(int num)
> +{
> +       switch (num) {
> +       case RISCV_ISA_EXT_f:
> +               return RISCV_ISA_EXT_KEY_FPU;
> +       case RISCV_ISA_EXT_d:
> +               return RISCV_ISA_EXT_KEY_FPU;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>
>  #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..89f886b35357 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -24,6 +24,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  #ifdef CONFIG_FPU
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
> +__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> +EXPORT_SYMBOL(riscv_isa_ext_keys);
>
>  /**
>   * riscv_isa_extension_base() - Get base extension word
> @@ -232,6 +234,11 @@ void __init riscv_fill_hwcap(void)
>                         print_str[j++] = (char)('a' + i);
>         pr_info("riscv: ELF capabilities %s\n", print_str);
>
> +       for_each_set_bit(i, riscv_isa, RISCV_ISA_EXT_MAX) {
> +               j = riscv_isa_ext2key(i);
> +               if (j >= 0)
> +                       static_branch_enable(&riscv_isa_ext_keys[j]);
> +       }
>  #ifdef CONFIG_FPU
>         if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
>                 static_branch_enable(&cpu_hwcap_fpu);
> --
> 2.34.1
>
