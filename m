Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD5552D03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348432AbiFUI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348412AbiFUI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:28:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99672101C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:28:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 23so6293771pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lF4UMqVgmez/Cvz/MwfgpmVufoFq93DpK8zD1no54lg=;
        b=gxfnQODIxaI2P56t9c25ICX4fIUo7BBFL9nrdy6GW83t8T2g/EaEtD5J11eO2ptg2X
         VmypwBeMbTSSqZGhcHmCbDHFgSBCx6GNvQfkQD5nbSlte2V8rM7o7KZkBffMcmBiFshz
         BywNFUkfg7llImk1EPB0GoLfDNlL2X1fYiM4+Hzt1zGrISQqewopwgPAE23GLKn37bGq
         41TUi6nS/Dn/3FLV5KWsr/vMuaVllstb1ihFfvscbQxR0WhGz/Hfpmvt8JJ8zg53rdpo
         I5JY7rjrHCcM2DVrG4hZ6xCg5oboxECVGxgf71ptwwUbbZlDyyu4rqdXte7wMUaQLqmo
         eKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lF4UMqVgmez/Cvz/MwfgpmVufoFq93DpK8zD1no54lg=;
        b=aH6Jh+8u31JZ8AawohcENxkZvt05PSc3IkC5YD4Uy8NxFES0ftYSXhGIQcUdRR0XLO
         Ka6lAX6PljaMSxK7kHecYmfyEf3rRA47AU51IryoGT2f7FwIMtdQEzWCU62F9oUJ4+f8
         u+hNZGXMbnqDtfRL9D9p8UojIUJpTG67wcwOS4f3Ndp7xg2zUiqT6YgxnNrou9Y/QLRx
         sSD36eXK8SU56PpfDgNfpA3XflQ712AOlPBr83fuu/7978FKGukC4TAPTRoyk+0ZpRtC
         qHnrv+o/qf1BiiUoa0WMQY3CF4n0d5YcMrkB/w/U8TjlyKLREniJdyTss8N4ml7+G6Ex
         t/HQ==
X-Gm-Message-State: AJIora8AvxIapbsi/QS9Z1aEEXfbPIRTXYp39IAAOy3/SrOOjtPF5rzn
        YMgxVW1DOYxpsxDVzS147VmWt+38a8zUSgqNchM=
X-Google-Smtp-Source: AGRyM1vnN6fyBNcugiRcjRYdmEJH4JLiLob6cJIXou7Xau1bnleg3Ucp1bjkL1HMKEQmFNvzXdAs4WUqpCGLZlAyF6U=
X-Received: by 2002:a05:6a00:1a8f:b0:51c:2f82:cdba with SMTP id
 e15-20020a056a001a8f00b0051c2f82cdbamr29297095pfv.85.1655800121911; Tue, 21
 Jun 2022 01:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220620115549.1529597-1-apatel@ventanamicro.com> <20220621104030.349c570b@redslave.neermore.group>
In-Reply-To: <20220621104030.349c570b@redslave.neermore.group>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Tue, 21 Jun 2022 11:28:05 +0300
Message-ID: <CAEn-LTqaK3pvjkTeNztDF8keJmr=GtMnCOFwZ=v4mHZd7fdMpw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:53 AM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
>
> Hello Anup!
>
> On Mon, 20 Jun 2022 17:25:49 +0530
> Anup Patel <apatel@ventanamicro.com> wrote:
>
> > Identifying the underlying RISC-V implementation can be important
> > for some of the user space applications. For example, the perf tool
> > uses arch specific CPU implementation id (i.e. CPUID) to select a
> > JSON file describing custom perf events on a CPU.
> >
> > Currently, there is no way to identify RISC-V implementation so we
> > add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
>
> Tested on Sifive Unmatched:
>
> localhost / # cat /proc/cpuinfo
> processor       : 0
> hart            : 4
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : sifive,bullet0
> mvendorid       : 0x489
> marchid         : 0x8000000000000007
> mimpid          : 0x20181004
>
> processor       : 1
> hart            : 1
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : sifive,bullet0
> mvendorid       : 0x489
> marchid         : 0x8000000000000007
> mimpid          : 0x20181004
>
> processor       : 2
> hart            : 2
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : sifive,bullet0
> mvendorid       : 0x489
> marchid         : 0x8000000000000007
> mimpid          : 0x20181004
>
> processor       : 3
> hart            : 3
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : sifive,bullet0
> mvendorid       : 0x489
> marchid         : 0x8000000000000007
> mimpid          : 0x20181004
>
> mvendorid, marchid values match the register description in u74 manual.
>
> mimpid seems to be ok, through i can't find exact in U74/Unmatched docs.

SiFive main website -> Products -> Documentation -> U74-MC Core
Complex Manual -> Page 274: B.2 Machine Implementation ID Register
(mimpid).

This mimpid value is not in the table thus it's most likely not part
of a particular U74 generator release. Looking at this value we could
assume that U74 cores within FU740 predates the general availability.

Cheers,
david

>
> Tested-by: Nikita Shubin <n.shubin@yadro.com>
>
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 51
> > +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 51
> > insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index fba9e9f46a8c..c037b8691bbb 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -3,10 +3,13 @@
> >   * Copyright (C) 2012 Regents of the University of California
> >   */
> >
> > +#include <linux/cpu.h>
> >  #include <linux/init.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/of.h>
> > +#include <asm/csr.h>
> >  #include <asm/hwcap.h>
> > +#include <asm/sbi.h>
> >  #include <asm/smp.h>
> >  #include <asm/pgtable.h>
> >
> > @@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node
> > *node) }
> >
> >  #ifdef CONFIG_PROC_FS
> > +
> > +struct riscv_cpuinfo {
> > +     unsigned long mvendorid;
> > +     unsigned long marchid;
> > +     unsigned long mimpid;
> > +};
> > +static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> > +
> > +static int riscv_cpuinfo_starting(unsigned int cpu)
> > +{
> > +     struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> > +
> > +#if defined(CONFIG_RISCV_SBI)
> > +     ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > +     ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> > +     ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> > +#elif defined(CONFIG_RISCV_M_MODE)
> > +     ci->mvendorid = csr_read(CSR_MVENDORID);
> > +     ci->marchid = csr_read(CSR_MARCHID);
> > +     ci->mimpid = csr_read(CSR_MIMPID);
> > +#else
> > +     ci->mvendorid = 0;
> > +     ci->marchid = 0;
> > +     ci->mimpid = 0;
> > +#endif
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init riscv_cpuinfo_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > "riscv/cpuinfo:starting",
> > +                             riscv_cpuinfo_starting, NULL);
> > +     if (ret < 0) {
> > +             pr_err("cpuinfo: failed to register hotplug
> > callbacks.\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +device_initcall(riscv_cpuinfo_init);
> > +
> >  #define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> >       {                                                       \
> >               .uprop = #UPROP,                                \
> > @@ -178,6 +225,7 @@ static int c_show(struct seq_file *m, void *v)
> >  {
> >       unsigned long cpu_id = (unsigned long)v - 1;
> >       struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> > +     struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo,
> > cpu_id); const char *compat, *isa;
> >
> >       seq_printf(m, "processor\t: %lu\n", cpu_id);
> > @@ -188,6 +236,9 @@ static int c_show(struct seq_file *m, void *v)
> >       if (!of_property_read_string(node, "compatible", &compat)
> >           && strcmp(compat, "riscv"))
> >               seq_printf(m, "uarch\t\t: %s\n", compat);
> > +     seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
> > +     seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
> > +     seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
> >       seq_puts(m, "\n");
> >       of_node_put(node);
> >
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
