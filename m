Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365944C66DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiB1KIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiB1KIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:08:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249955B1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:07:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j22so14474232wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHItwHQRCJw3/NMLFZ4U+CA8KLZhljQy1y08UpaRHGE=;
        b=eJ4T+s0axsTzcZo2yAVf8S1U/UZXWxjtMh3dZP5HH4wb1mDPGEBIGdfpblep8Jjs69
         auBvja0pCIJ19GA/5fPSwITYytbv/iUZuJNIYV5+wkYmku5m4vYvCjirnMxcyD+jSfdf
         4BSJwAHE3vt6Ig9o1OgHndyolDqT9jWKLI+x1hGQHHiqnq7LW8O2nwUQ+bTndl5jqyQN
         cnYbu5A+N1JuMD966rWFxbtfgL0ESbGVIFZX02EX95tJ0UX+KZtLdjpiLCG4EbNs/2xG
         dOqpfGz/BZKcW2wPb1tMk/Ab37QB1nQERmXJsePEQD27+2I7gZBg18Udyu9Ck1DddfVF
         zJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHItwHQRCJw3/NMLFZ4U+CA8KLZhljQy1y08UpaRHGE=;
        b=c6AiRSPQUlLVKE9H817Ooyac4f6br2vfFXiG7B1W/AJfBVszBrluvE4DNgMlkwFGfv
         t8XENfD6F68rtGF2IAEv+3qGMIUri/1+IQFRfcO3/17aLCuZeWoYOryV7WB94BD4eP0D
         d7Md686j4qf+kdFh/Eosh/4DFymOx5M7y3QQZGBJmmrtf87V5BIk39b+UZkE+XOqId4m
         JCHTiOMM3kVDXKwR/uCMCdLkHe6o50W/aCsGj2Y1HvsrpQd9KxfB8l7nHnY0L++bNsvy
         LhbqCdnOXMhmbUwhSbrIIXd//Z3X/Jumf79F0aIUGawJDFRgO5S5DVhAK/SpRN9tZzVT
         Dzig==
X-Gm-Message-State: AOAM5309niyfDeSpW0n3Tht/Qd3awUZRpouux3YlR27AiKmJvLsT6G+K
        jYF6qVzM6LtXeaeo2FMfY/r54RKzj8BewWfmouQzTw==
X-Google-Smtp-Source: ABdhPJwa/2mVO/hnHC1nb3fS0NE1tRwUImbMZuoSpkI70GnKbPqqIZlH8WtycBejFXxGIAXrXRdjpzDeYSnR/lrT0J4=
X-Received: by 2002:a5d:64a8:0:b0:1ef:f99c:8c12 with SMTP id
 m8-20020a5d64a8000000b001eff99c8c12mr188308wrp.214.1646042869613; Mon, 28 Feb
 2022 02:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20220222204811.2281949-1-atishp@rivosinc.com> <20220222204811.2281949-7-atishp@rivosinc.com>
In-Reply-To: <20220222204811.2281949-7-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Feb 2022 15:37:31 +0530
Message-ID: <CAAhSdy3SrHsDLt87uPwOHWDM0QtEg6Do7Zw_ymM52dOVbEz12Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
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

On Wed, Feb 23, 2022 at 2:18 AM Atish Patra <atishp@rivosinc.com> wrote:
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

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/hwcap.h |  7 +++++
>  arch/riscv/kernel/cpu.c        | 51 ++++++++++++++++++++++++++++++++--
>  2 files changed, 56 insertions(+), 2 deletions(-)
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
> index ad0a7e9f828b..031ad15a059f 100644
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
> @@ -63,12 +64,57 @@ int riscv_of_parent_hartid(struct device_node *node)
>  }
>
>  #ifdef CONFIG_PROC_FS
> +#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> +       {                                                       \
> +               .uprop = #UPROP,                                \
> +               .isa_ext_id = EXTID,                            \
> +       }
> +
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
> +       seq_puts(f, "isa-ext\t\t: ");
> +       for (i = 0; i <= arr_sz; i++) {
> +               edata = &isa_ext_arr[i];
> +               if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
> +                       continue;
> +               seq_printf(f, "%s ", edata->uprop);
> +       }
> +       seq_puts(f, "\n");
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
>         seq_puts(f, "\n");
>  }
>
> @@ -115,6 +161,7 @@ static int c_show(struct seq_file *m, void *v)
>         seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>         if (!of_property_read_string(node, "riscv,isa", &isa))
>                 print_isa(m, isa);
> +       print_isa_ext(m);
>         print_mmu(m);
>         if (!of_property_read_string(node, "compatible", &compat)
>             && strcmp(compat, "riscv"))
> --
> 2.30.2
>
