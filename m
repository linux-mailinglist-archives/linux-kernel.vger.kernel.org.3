Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9608758126F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiGZL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiGZL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:57:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191F23150
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:57:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so11198780wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b1XaIe2pvWP5K0yAx5yjeutw2voVbR8sHlsVHCDajs=;
        b=yMtzTJeqrokV2Tq5n9n0naG9BirUc2w4TdHlJJhVt8ONXCDvE0yFD/l2QV14iAO9DN
         lEyu6vMN4AtNxp7R50TNLxHa1uLikl+YgnwA4Yam2fIXfRmCEf/dio1dyqNYUaWLRLzF
         EfusuE/dxyqTUKBnZco/jPxSBWdRPfTiTj01cPA14iYm0iSePTzYbKrMTlJgifJe9r+D
         wwniCNDsSQCbWS1yl/VtNEb4Lc1f2HAStTf8nyc+lXwwGqBaOtKj0bRhMcXorpPpSde9
         /w4TK23qDBWLZ9HJTOp4iYyyEUyNbJNRuSQOX5Le1KCGD1ZJQtSO1IJifsR7aNHkFVJf
         29Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b1XaIe2pvWP5K0yAx5yjeutw2voVbR8sHlsVHCDajs=;
        b=iGtM4hVyeQhbmLU2z4jsKYy7Ams+MVad3IrLJMFmVgAIeTV7gvijCjHo+VfGZ8rqn6
         FFtqiSJfGpLNBxhLFZC4VB8NO+pGbRqP77MNPJ9fn0nRzcJ6gkO6785kzYTtmKu4sbld
         fB9eiz6lA9Lsh+bYpKlcyuk8GsKaGK/I/TuVLpsmdvdIa5dCeqjxYDiS7zwkSnwnWu68
         PRyAC1a/yR0/VMaUy6z8sbanSfBUSLfmuq7mHv0himFn/+RCF2+lGg0iP5oZKvoH9EwK
         A8+GC5PG5fMhiz8bMX/9dh7zg9biRmkjjLhASRwC9LOi6PBpjIqUNfJEpoO97IUhClOa
         3Z4A==
X-Gm-Message-State: AJIora+R1V6XMTTCeV0zSIOKoOE0NN+J2w4NOvrzCz+VuvbepJ8PuF+j
        Ey9NJGmTmb6I+T4tUE5oJvly4ZNds1CDDKNi7J/Im36C218=
X-Google-Smtp-Source: AGRyM1tCsyWx3aQSXg4PAykzfRvt3l5LMRP2q5eLJSb9++LwDzChr3pObi7mI8aHh7PWgj5oUNFQnXVDtMjSYoqIjDs=
X-Received: by 2002:a05:600c:4fd5:b0:3a3:4664:6d55 with SMTP id
 o21-20020a05600c4fd500b003a346646d55mr12232878wmq.73.1658836634580; Tue, 26
 Jul 2022 04:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220620115549.1529597-1-apatel@ventanamicro.com>
In-Reply-To: <20220620115549.1529597-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 26 Jul 2022 17:27:03 +0530
Message-ID: <CAAhSdy0mHbxQ3QVP9j1==oTG75Z9_T2bDSif-UGKppG+-hoJng@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Mon, Jun 20, 2022 at 5:26 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Identifying the underlying RISC-V implementation can be important
> for some of the user space applications. For example, the perf tool
> uses arch specific CPU implementation id (i.e. CPUID) to select a
> JSON file describing custom perf events on a CPU.
>
> Currently, there is no way to identify RISC-V implementation so we
> add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Can this patch be considered for 5.20 ?

Regards,
Anup

> ---
>  arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..c037b8691bbb 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -3,10 +3,13 @@
>   * Copyright (C) 2012 Regents of the University of California
>   */
>
> +#include <linux/cpu.h>
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
> +#include <asm/csr.h>
>  #include <asm/hwcap.h>
> +#include <asm/sbi.h>
>  #include <asm/smp.h>
>  #include <asm/pgtable.h>
>
> @@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node *node)
>  }
>
>  #ifdef CONFIG_PROC_FS
> +
> +struct riscv_cpuinfo {
> +       unsigned long mvendorid;
> +       unsigned long marchid;
> +       unsigned long mimpid;
> +};
> +static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> +
> +static int riscv_cpuinfo_starting(unsigned int cpu)
> +{
> +       struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if defined(CONFIG_RISCV_SBI)
> +       ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +       ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +       ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> +#elif defined(CONFIG_RISCV_M_MODE)
> +       ci->mvendorid = csr_read(CSR_MVENDORID);
> +       ci->marchid = csr_read(CSR_MARCHID);
> +       ci->mimpid = csr_read(CSR_MIMPID);
> +#else
> +       ci->mvendorid = 0;
> +       ci->marchid = 0;
> +       ci->mimpid = 0;
> +#endif
> +
> +       return 0;
> +}
> +
> +static int __init riscv_cpuinfo_init(void)
> +{
> +       int ret;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/cpuinfo:starting",
> +                               riscv_cpuinfo_starting, NULL);
> +       if (ret < 0) {
> +               pr_err("cpuinfo: failed to register hotplug callbacks.\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +device_initcall(riscv_cpuinfo_init);
> +
>  #define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
>         {                                                       \
>                 .uprop = #UPROP,                                \
> @@ -178,6 +225,7 @@ static int c_show(struct seq_file *m, void *v)
>  {
>         unsigned long cpu_id = (unsigned long)v - 1;
>         struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> +       struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
>         const char *compat, *isa;
>
>         seq_printf(m, "processor\t: %lu\n", cpu_id);
> @@ -188,6 +236,9 @@ static int c_show(struct seq_file *m, void *v)
>         if (!of_property_read_string(node, "compatible", &compat)
>             && strcmp(compat, "riscv"))
>                 seq_printf(m, "uarch\t\t: %s\n", compat);
> +       seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
> +       seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
> +       seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
>         seq_puts(m, "\n");
>         of_node_put(node);
>
> --
> 2.34.1
>
