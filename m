Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B05301A0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbiEVHdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbiEVHdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:33:24 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F713BBF6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:33:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ec42eae76bso120724397b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pesXPNx/Q+LkyGC2G6a4mEcdtswlqCibLEjGfoAcaaM=;
        b=l3n22jSViyQmkbqULtIU4toqqsIvYxj0DLnbM8qlKeL6z1o6AccdaQxqVdVjpYIoPb
         efyRW+UCEO6INY+5411QwiXx9DMSPB3pZoIe9jRh21F0KplJmkH25JBRfGIqQxZdbIVO
         mzln7BBnH/6RScZN044BXG9xa47vYazntURco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pesXPNx/Q+LkyGC2G6a4mEcdtswlqCibLEjGfoAcaaM=;
        b=5l0Xr3NdquAHbhiAvh9WMQHhLCuaZvc4zi9zQgGJsGwX1slHxSkFUB8X4D8dpjGK5d
         kkVlvaIQ3E1g+vu5PcwQygPd/gJDL7dAXaV6fRTnl0OsB3YcuDkeFDeTeNGkl1gug7X4
         cudy3VQwHWXRp3A0cbxVWYjtYKCu7m00SWsxzLUSHYRKxhkkW5hguoAxSoUr23sFgIY7
         fGRQPBgs9ZrIcAVdNTaGkYrQaELUZ1AxDRhZt03DYq0vZpqrM5maMYpizaDFOqUaGQo3
         kwh3luVr9Kq2dF1nnahTkIeFXbq6l/6hBrbA8yNey3c/x1W/BVyP8FSIU2iOrZrNFFLk
         ig/A==
X-Gm-Message-State: AOAM530CjlmEW7nJmJJCrHoDp/oxUaB9sIqGUCIMpEQgzPFM5VE2ETY2
        KSqwrwSXQWsorriIDYQKEbg24lXuZ1AssfDWDsyn
X-Google-Smtp-Source: ABdhPJwY0E/JZfP4w+tD03WSMJ6az9j2LZ2XB9LZ01T8gUgkeoRVtV0LCPF4jvGjdMy/bYam1s6yGNYwM9HYX0zN0Bk=
X-Received: by 2002:a0d:e88c:0:b0:2fe:da96:1b77 with SMTP id
 r134-20020a0de88c000000b002feda961b77mr17730906ywe.262.1653204802756; Sun, 22
 May 2022 00:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220517184453.3558-1-jszhang@kernel.org> <20220517184453.3558-2-jszhang@kernel.org>
In-Reply-To: <20220517184453.3558-2-jszhang@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 22 May 2022 00:33:12 -0700
Message-ID: <CAOnJCU+aRoLRUjbum3o8N8J63vW+Y2974TjBueE__7PQAeJCQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: introduce unified static key mechanism for ISA extensions
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

On Tue, May 17, 2022 at 11:53 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently, riscv has several extensions which may not be supported on
> all riscv platforms, for example, FPU and so on. To support unified
> kernel Image style, we need to check whether the feature is supported

/s/suportted/supported


> or not. If the check sits at hot code path, then performance will be
> impacted a lot. static key can be used to solve the issue. In the past
> FPU support has been converted to use static key mechanism. I believe
> we will have similar cases in the future.
>
> this patch tries to add an unified mechanism to use static keys for
> some ISA extensions by implementing an array of default-false static keys
> and enabling them when detected.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/hwcap.h | 40 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c |  7 ++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0734e42f74f2..b0433d2b880d 100644
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
> @@ -62,6 +73,35 @@ struct riscv_isa_ext_data {
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
> +/*
> + * @num must be a compile-time constant.
> + */
> +static __always_inline bool riscv_isa_have_key_extension(int num)
> +{
> +       if (RISCV_ISA_EXT_ID_MAX <= num)
> +               return false;
> +
> +       num = riscv_isa_ext2key(num);
 > +       if (RISCV_ISA_EXT_KEY_MAX <= num || num < 0)
> +               return false;
> +

Why do you need the additional check in the hot path ?
riscv_isa_ext_keys array can be directly accessed at the caller
instead of calling this function.

> +       return static_branch_likely(&riscv_isa_ext_keys[num]);
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


--
Regards,
Atish
