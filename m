Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7622B5823D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiG0KHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiG0KH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:07:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4CB1C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:07:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so23463546wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41fQ447csC/Sul1qlYvawlHHS0vJEi7xV/QYB1Ga0pc=;
        b=HSUOtBxm7FJI/iSIhq6yiARyBJP7rol9gTL95UdtEHjLZ6X5uXsnoVuJZh8vjocOyt
         YxkhYRUEwgFzXYYTTo/Z42Xf6JyMem9hHiUfJo5HsFHLKvJmA0tkR9BINENxI/OAWqN3
         fybWoyMz/Twv/jHlgnzsDfVORKBxgC1uOEt3cQmSRA7qtTIdeBO+K5X7qfvhJUR50E8Q
         7zdso1Y6UkeiQ7zyY4hMJX7MM+7/vn0K7no7dJCT7et1rykhvUsFgJ+UjLpx/1cc2nLC
         fkU3evBQHEuDUG96FCvoBMMXnBjlZ5soA5epTpD9YtyhX8FgBJAILRRMEvlE3ntD4CUw
         U/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41fQ447csC/Sul1qlYvawlHHS0vJEi7xV/QYB1Ga0pc=;
        b=hI+D2X2D9hiCTfzsYxTq202sEDpwKK96F1DiI9rv1P3qCRxcgStsf6lVemytAWWWp+
         LhrZPU+5+heV7uY9AXwCo98nl6gAov9bi8sfZpDDYMPcxtbtbo6wp+kOk0YB738oAbdj
         kO2kvVsXD15XVM0BNT6FkQ3gnsT22tyJ7ofc6Am278vXlsAcgGRfWD3+RWFJbC8uRuqr
         8hrQfnslsmn5WP++7N6lhZDgi9j+8cN5YkZNNfVoB7WQaAAeNfOFkZtyltDgXETIqLgc
         LFW3dRo/53MOmZjxzvcvT3W5oNyyB1yNRrfdHWaQSrPxet6+siQ216hrbMHBqbUSOoch
         4+GQ==
X-Gm-Message-State: AJIora+0/49HrMWlIxwl+iknrA/TOf4+xtKbjqsKZK3lQxc/yxDG3QOe
        v67uxNNJ8aa0ixGUyWcily8GNCEZ7erXwCjFx+fgY9laSDHj/Q==
X-Google-Smtp-Source: AGRyM1vR/TLTvBF0z8CpxsqcCxYhhvhTXAxCMf1szlEtvDyyIxvQ3yV+uvZzcCLFx9fz2Ov7XLMjvdH5WUdQQK3wChQ=
X-Received: by 2002:a05:6000:224:b0:21e:7efc:c506 with SMTP id
 l4-20020a056000022400b0021e7efcc506mr11349213wrz.313.1658916443377; Wed, 27
 Jul 2022 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220727043829.151794-1-apatel@ventanamicro.com> <724f176b-02f1-b171-726f-16158c650896@codethink.co.uk>
In-Reply-To: <724f176b-02f1-b171-726f-16158c650896@codethink.co.uk>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Jul 2022 15:36:33 +0530
Message-ID: <CAAhSdy1tnTDv0AVyo=5FD=aE070ds6qYGGhdup+8jUqr3M66qA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org, Nikita Shubin <n.shubin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 2:25 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 27/07/2022 05:38, Anup Patel wrote:
> > Identifying the underlying RISC-V implementation can be important
> > for some of the user space applications. For example, the perf tool
> > uses arch specific CPU implementation id (i.e. CPUID) to select a
> > JSON file describing custom perf events on a CPU.
> >
> > Currently, there is no way to identify RISC-V implementation so we
> > add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Tested-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> > Changes since v1:
> >   - Use IS_ENABLED() to check CONFIG defines
> >   - Added RB and TB tags in commit description
> > ---
> >   arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index fba9e9f46a8c..04bcc91c91ea 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -3,10 +3,13 @@
> >    * Copyright (C) 2012 Regents of the University of California
> >    */
> >
> > +#include <linux/cpu.h>
> >   #include <linux/init.h>
> >   #include <linux/seq_file.h>
> >   #include <linux/of.h>
> > +#include <asm/csr.h>
> >   #include <asm/hwcap.h>
> > +#include <asm/sbi.h>
> >   #include <asm/smp.h>
> >   #include <asm/pgtable.h>
> >
> > @@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node *node)
> >   }
> >
> >   #ifdef CONFIG_PROC_FS
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
> > +#if IS_ENABLED(CONFIG_RISCV_SBI)
> > +     ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > +     ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> > +     ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>
> how about:
>
>         if (IS_ENABLED(CONFIG_RISCV_SBI)) {
>                 ...
>         } ... {
>
> or maybe even:
>
>
>         if (IS_ENABLED(CONFIG_RISCV_SBI)) {
>                 if (sbi_spec_is_0_1()) {
>                         ...
>                 }
>         } ... {
>
> would mean better compile coverage (at the slight exepnese of
> having "false" sbi_spec_is_0_1() implemenation

Most of the sbi_xyz() functions are not available for NoMMU
kernel so using "if (IS_ENABLED())" results in compile error.

>
> > +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > +     ci->mvendorid = csr_read(CSR_MVENDORID);
> > +     ci->marchid = csr_read(CSR_MARCHID);
> > +     ci->mimpid = csr_read(CSR_MIMPID);
> > +#else
> > +     ci->mvendorid = 0;
> > +     ci->marchid = 0;
> > +     ci->mimpid = 0;
> > +#endif
>
> Would it be easier to zero out all the fields first and then fill them
> in if supported?

Clearing out fields before "#if" ladder results in dead assignments.

Regards,
Anup

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init riscv_cpuinfo_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/cpuinfo:starting",
> > +                             riscv_cpuinfo_starting, NULL);
> > +     if (ret < 0) {
> > +             pr_err("cpuinfo: failed to register hotplug callbacks.\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +device_initcall(riscv_cpuinfo_init);
> > +
> >   #define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> >       {                                                       \
> >               .uprop = #UPROP,                                \
> > @@ -178,6 +225,7 @@ static int c_show(struct seq_file *m, void *v)
> >   {
> >       unsigned long cpu_id = (unsigned long)v - 1;
> >       struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> > +     struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
> >       const char *compat, *isa;
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
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
