Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449E53122E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiEWOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiEWOmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:42:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41032AC44
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:42:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id q135so25791793ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4mxW9+NVwxMICOw3jO9PrjfCAz9jdp3jsvfj227EPg=;
        b=EF0GWx8UNYIYNstiWdAmmkdSzkdJYO99EBTTmNPqf1cB1FdvlufPxll84nE5B5/zkz
         bT3Bo38zrmJLcsYVkqfwEwSTOG8x+vi535RCGyzCXP+B8sLqVxi9RU+EdXfPzXhncodb
         K13fFKDMMgegVRT60+A69ITgSsQ8Wy8FkzviA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4mxW9+NVwxMICOw3jO9PrjfCAz9jdp3jsvfj227EPg=;
        b=7AG5n2uW/Yw242eBLcUtAqTiY4Itns1tSWCiBLUoVim8YsmIhu2EuYEZoyRBg2GC6x
         wPLCe1N0an32x7uU7rp6QvgNUoyt2y2VOKHM+PJFnG/+sLLZSNdaqk34sY7VAVFYo4YU
         DXkQqRuFNjjwwV+3HEaz6hZHryFPI2VFqCN2qgbfLuDQqECc/QFerK9JHUCIkbDJcygt
         ZqqyR07xkNtX+lLokcnK2EegSYOUdCHTVHg53I4YINgLjpVL6Fnwdjr7427gS7s4O1A2
         a1pCagRzE6ad6ngqwVVezkteeMK2HZmqpUKWA6ejVISP9YHC00PNYjS3jS57gQGDxzYJ
         A/eg==
X-Gm-Message-State: AOAM531EP432bE3/imEF3yx64DNEPOPzhkNMQAkExhsWiOkw/eeWc0IW
        tu1l2M3IYSqjXBqGugrirAQWLrJv7s8LwCH+RSfW
X-Google-Smtp-Source: ABdhPJzPyzEnfurzkCwkKWDtQQF4jnYD50VKSEntRgx7xMi7Pjar3xLLr31w71++FsTvo2uChRIhtO6raAx2YYhcoEQ=
X-Received: by 2002:a25:be82:0:b0:64a:20f1:94fc with SMTP id
 i2-20020a25be82000000b0064a20f194fcmr20826851ybk.538.1653316936001; Mon, 23
 May 2022 07:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220522153543.2656-1-jszhang@kernel.org> <20220522153543.2656-2-jszhang@kernel.org>
In-Reply-To: <20220522153543.2656-2-jszhang@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 23 May 2022 07:42:04 -0700
Message-ID: <CAOnJCUJUBZ=G+nhoz06aNjSLsWQDcePnCSJiS4z4wg-ncY5cRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: introduce unified static key mechanism for
 ISA extensions
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 8:44 AM Jisheng Zhang <jszhang@kernel.org> wrote:
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


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
