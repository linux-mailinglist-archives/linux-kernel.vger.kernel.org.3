Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5024D92DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344580AbiCODMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiCODMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:12:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2412AB6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:11:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h15so26908007wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMzCXIdLqAyGtaz7rlkDmeg46RvpOTj0ly0PLz7MJt0=;
        b=pSKVP9N5ahguUkJjtp7SxHsAXpLuCZX3IzElc4APDhBQsxOEXiyyWYYhsQMCx1pn3p
         WjBzJiqcjzR4STI2FP9gEUCgiLqx5P6Z+2dW6+ReTpSvYzO85sRWMiyzHpYnciB3gp28
         3CzPGZVh8N4wYM5T1mkRCtBJ36HYMNxpOOGrciPAIUmZiSuMkcmCXjXWCDNIPM5R2sMA
         BBkzJhO7qv6q4i8g5z/YdRKu2eBdLuX5zgnXCyXMJPqlBMXVTkHPqEXXSi06dvJLpFFP
         9dY+nJlGFAuURVBJ9kusniyDn3+pCYLynm+0bOX4HKoDXACeBivq9Ac5b6TmOu1KWqZg
         X82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMzCXIdLqAyGtaz7rlkDmeg46RvpOTj0ly0PLz7MJt0=;
        b=gWp0yn2/wehNAO6ULDXkJYR3KF8iSVJOqAcH3mXaTA2h4khaomF+Jv8NyOH/JUcvg+
         +I3E+cdD++9EDjQ6Xi9hrO1h0ZwYTHcgfrGA6izuv2KO7LgY+KctYFKuFRICEACGpfve
         fH/rncArTlqF1MDP0Ay4UVfceM2IzAKLTBEUiVFqXOTfFhUvQouCr7acaGYIhC2NiUft
         TMowErplxsMDROAiug2zO+dSXVnIRiIM6Faxytx00kyKKKI7Le2QHQaz2XpwkkxQNyF0
         pdCXqqqxKay8COvFFS6RRiPKYR5esXsmvdTomt7YuWaKjvH3C7GF7KucE22/pzPE4x4w
         CXLw==
X-Gm-Message-State: AOAM531ElIv+JR/FhIYWD8unjx6qfGcyxMLBdsNbAWbs+0hkVusvBUmo
        oPcYgD+GSsmsMTubxF+9xWDQ+oBro8GpVPYgOhsGIA==
X-Google-Smtp-Source: ABdhPJzZF6NSEHadRn0WzLtO/L7BqiZdjpJJvaXSM7RzJ7jse3Mp+YFHB8JDzSCI/CLynk6yoB+T9SfDP4fW/wOsDP4=
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id
 i5-20020adfb645000000b001e30bab7594mr18998652wre.346.1647313890542; Mon, 14
 Mar 2022 20:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220314203845.832648-1-atishp@rivosinc.com> <20220314203845.832648-7-atishp@rivosinc.com>
In-Reply-To: <20220314203845.832648-7-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Mar 2022 08:41:17 +0530
Message-ID: <CAAhSdy1SvpAOX063OyE3iZwfAwND_QVxTNeLsB0hQtJWH4o9tw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
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
> Currently, the /proc/cpuinfo outputs the entire riscv,isa string which
> is not ideal when we have multiple ISA extensions present in the ISA
> string. Some of them may not be enabled in kernel as well.
> Same goes for the single letter extensions as well which prints the
> entire ISA string. Some of they may not be valid ISA extensions as
> well (e.g 'su')
>
> Parse only the valid & enabled ISA extension and print them.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/hwcap.h |  7 ++++
>  arch/riscv/kernel/cpu.c        | 65 ++++++++++++++++++++++++++++++++--
>  2 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 170bd80da520..691fc9c8099b 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -54,6 +54,13 @@ enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>
> +struct riscv_isa_ext_data {
> +       /* Name of the extension displayed to userspace via /proc/cpuinfo */
> +       char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> +       /* The logical ISA extension ID */
> +       unsigned int isa_ext_id;
> +};
> +
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>
>  #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ad0a7e9f828b..fc115e307ef5 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -6,6 +6,7 @@
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
> +#include <asm/hwcap.h>
>  #include <asm/smp.h>
>  #include <asm/pgtable.h>
>
> @@ -63,12 +64,72 @@ int riscv_of_parent_hartid(struct device_node *node)
>  }
>
>  #ifdef CONFIG_PROC_FS
> +#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> +       {                                                       \
> +               .uprop = #UPROP,                                \
> +               .isa_ext_id = EXTID,                            \
> +       }
> +/**
> + * Here are the ordering rules of extension naming defined by RISC-V
> + * specification :
> + * 1. All extensions should be separated from other multi-letter extensions
> + *    from other multi-letter extensions by an underscore.
> + * 2. The first letter following the 'Z' conventionally indicates the most
> + *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> + *    If multiple 'Z' extensions are named, they should be ordered first
> + *    by category, then alphabetically within a category.
> + * 3. Standard supervisor-level extensions (starts with 'S') should be
> + *    listed after standard unprivileged extensions.  If multiple
> + *    supervisor-level extensions are listed, they should be ordered
> + *    alphabetically.
> + * 4. Non-standard extensions (starts with 'X') must be listed after all
> + *    standard extensions. They must be separated from other multi-letter
> + *    extensions by an underscore.
> + */
> +static struct riscv_isa_ext_data isa_ext_arr[] = {
> +       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> +};
> +
> +static void print_isa_ext(struct seq_file *f)
> +{
> +       struct riscv_isa_ext_data *edata;
> +       int i = 0, arr_sz;
> +
> +       arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
> +
> +       /* No extension support available */
> +       if (arr_sz <= 0)
> +               return;
> +
> +       for (i = 0; i <= arr_sz; i++) {
> +               edata = &isa_ext_arr[i];
> +               if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
> +                       continue;
> +               seq_printf(f, "_%s", edata->uprop);
> +       }
> +}
> +
> +/**
> + * These are the only valid base (single letter) ISA extensions as per the spec.
> + * It also specifies the canonical order in which it appears in the spec.
> + * Some of the extension may just be a place holder for now (B, K, P, J).
> + * This should be updated once corresponding extensions are ratified.
> + */
> +static const char base_riscv_exts[13] = "imafdqcbkjpvh";
>
>  static void print_isa(struct seq_file *f, const char *isa)
>  {
> -       /* Print the entire ISA as it is */
> +       int i;
> +
>         seq_puts(f, "isa\t\t: ");
> -       seq_write(f, isa, strlen(isa));
> +       /* Print the rv[64/32] part */
> +       seq_write(f, isa, 4);
> +       for (i = 0; i < sizeof(base_riscv_exts); i++) {
> +               if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
> +                       /* Print only enabled the base ISA extensions */
> +                       seq_write(f, &base_riscv_exts[i], 1);
> +       }
> +       print_isa_ext(f);
>         seq_puts(f, "\n");
>  }
>
> --
> 2.30.2
>
