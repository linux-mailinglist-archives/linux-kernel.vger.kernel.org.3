Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10A58F72C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiHKFFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKFFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:05:53 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705A92CCA6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:05:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 204so26607689yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/EV/6vKBfwB5hGGmbwACRoUY2VnjvKdGK/sVggplOt0=;
        b=SZp0czCs3FP+FA1BlEgSpDvs1bQvp06qb4C2kPdLUTDPYTy2WBrUZg3/a98c3dSrOz
         lGQ9NM5A48i91jEmokx5aCis0sLdi3toGNtRdy1hiPfR31NeTGDH6TECnw0ddgB6S18E
         jMN2VTy4W38RTTNeBe8jQvapDj8jwb1VzFs/EfZLmQn1NJc3Fahb90KOC9VQxTEalV+W
         R2ZcD/OTZ5YeMvEVMqFxUolpWf0oJnQGZwHd1rMKYZutLoZ5uAV+ktX/4R0IN98zMlmx
         5ZbRJctM5wTp7/f9H0HO0TTCCASLuLBd+gAvWY1uBv4ki4MEy4HLNKNxy+D2xKif6ixW
         eYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/EV/6vKBfwB5hGGmbwACRoUY2VnjvKdGK/sVggplOt0=;
        b=e11rrVerJCe2He3TZ682d4W8Ax0reSyQFwF5zPPoj6OgjP1iVfgRzvKnV3vRB2wzIu
         XS3+NQmYHroo0ib2CV1AXqO+9aNFZlx66NSK/b2AH1tMyOE8GW5AHoSM2N1R5gbvExYm
         DtyJ2HxEYlax4tr5GCUzP3tOR4cSXdJcFRgWwceGhWXJoodJwiVaoCvJu7d6ucH2G8A8
         qKHANpWci+FTktjxxsyw+wx7hg5zrJwOhL+PvLIuj35/eryQjf8C8vZut8Nw9jnc+9aw
         /mWeX56K1QQoes2HgRgDUzqWTmYxwBvUKJBzNlx9w116tg436SKHWTTRTjn9DBb+Gla9
         +cmA==
X-Gm-Message-State: ACgBeo1MmBLqf9YO+/ExR86yoqu1LBtdLrBm0CdUK5fEs1reHcE/rBH1
        s6HglUYgKINUj6qiTQhAGKsOG1003nL6YQJgaKHqvQ==
X-Google-Smtp-Source: AA6agR40PCuyaSTI1Uow9nq58N+CsnqePvWW40teJrjRbbony3PdddX4i0iGhgizr7ACr2kj8T7+iXEDrzG/Xhf/nBs=
X-Received: by 2002:a25:abd4:0:b0:67b:db4b:b682 with SMTP id
 v78-20020a25abd4000000b0067bdb4bb682mr16829510ybi.423.1660194351452; Wed, 10
 Aug 2022 22:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220727043829.151794-1-apatel@ventanamicro.com>
In-Reply-To: <20220727043829.151794-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 11 Aug 2022 10:35:39 +0530
Message-ID: <CAAhSdy1rUT6g-VfZUF5aGv0BU0yqvy7eiZ0k=OFp9z88ORnRLw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Nikita Shubin <n.shubin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Jul 27, 2022 at 10:09 AM Anup Patel <apatel@ventanamicro.com> wrote:
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
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Tested-by: Nikita Shubin <n.shubin@yadro.com>

Can this patch be considered for 5.20 ?

Regards,
Anup


> ---
> Changes since v1:
>  - Use IS_ENABLED() to check CONFIG defines
>  - Added RB and TB tags in commit description
> ---
>  arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..04bcc91c91ea 100644
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
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +       ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +       ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +       ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
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
