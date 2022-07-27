Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE55825EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiG0Lxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiG0Lxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:53:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B76474F7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:53:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bf9so26647648lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D17IrGjqfDknOXwcV65EANowXkYAl11/dUWcANUuskM=;
        b=oVw67IFKfMhTwkj4St44LIOpvrqAZzRqnzv4Y6bOpBCLP1BJqNpuGPO3Uc7xddTl5f
         j5A6Y8WjaPxg/sdXKtxLKAGFjyuZNwIDaRhBgyALOmxuItXIbngCj3GOK1JQvu30Re7+
         r4RD3h5Iak81lXY67URzLu9se5r4YzRWRiKV4ja4WWOi7Sm3fWtDlgzz9ujeab893YDt
         lGPy2fEMzHxGy9y69eduiSsauiQCxXmD5iGx6aiZ5XXSgvF0uABy161+ThPMqxnMXlY7
         bihpQmO442/TV2gnjs+uV/9OYkt1dYFU2GubxhKdlykVWq06MzPO/H1giTFJ7UwN4pDE
         31EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D17IrGjqfDknOXwcV65EANowXkYAl11/dUWcANUuskM=;
        b=28KrSGqX643t7axdvGKxanSXviCydkBW9U3JuooFOOW/dsLVZmlSmk5Sw5+rUJIZWs
         HGopuGvLG4R6zecGzoZ+g42m0/f9VIxpGsKroM+ErGX5rxBDd2ONgwVN/1cr3/rYkVgD
         V2OgQUT591bU8iFAmCyMYKVw6R7hRL3p6pkEq7oWrG+SPh2lut+dBIvA84f0a1zrzqqr
         ZNcsC4Wf9aWuA6+Z2fyvchG5rOzi32vZsopb2DE9EggIgadWxLoaOKeXDjfRZXK0A5Km
         2Y9XKv0kQ+B8UbrfP5IEvoT/WCBM7u9KfbZLvGEUHtC3M9Rglyi4T2WFCIenvCE8gXIB
         TzCg==
X-Gm-Message-State: AJIora/G7JuFY28QpesI8iO4WzhcvGbVjHecc1mnLNU5ddtVAVUSNcd4
        jCC84+LTpv9+2+L7U/lpHOfY64PQwUvYCggwjgCtqw==
X-Google-Smtp-Source: AGRyM1u+OEpVbywXqdYqThd2+8RU5rq/CspyP7SYzjjwWXkCGKFjuZpoPxUSb6FvGHuNiE70BOfGzvpVzIphnOxHoqo=
X-Received: by 2002:a05:6512:2304:b0:48a:c120:88dc with SMTP id
 o4-20020a056512230400b0048ac12088dcmr14529lfu.419.1658922815582; Wed, 27 Jul
 2022 04:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220727043829.151794-1-apatel@ventanamicro.com>
 <724f176b-02f1-b171-726f-16158c650896@codethink.co.uk> <CAAhSdy1tnTDv0AVyo=5FD=aE070ds6qYGGhdup+8jUqr3M66qA@mail.gmail.com>
 <20a94c3c-85ed-2227-458e-60c780fd4ad7@codethink.co.uk>
In-Reply-To: <20a94c3c-85ed-2227-458e-60c780fd4ad7@codethink.co.uk>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 27 Jul 2022 17:23:24 +0530
Message-ID: <CAK9=C2Xoi7zW0evH-q15699vRqQ1UY72C_Z3UpYHMbkgL+efUg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org, Nikita Shubin <n.shubin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 3:42 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 27/07/2022 11:06, Anup Patel wrote:
> > On Wed, Jul 27, 2022 at 2:25 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >>
> >> On 27/07/2022 05:38, Anup Patel wrote:
> >>> Identifying the underlying RISC-V implementation can be important
> >>> for some of the user space applications. For example, the perf tool
> >>> uses arch specific CPU implementation id (i.e. CPUID) to select a
> >>> JSON file describing custom perf events on a CPU.
> >>>
> >>> Currently, there is no way to identify RISC-V implementation so we
> >>> add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
> >>>
> >>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> >>> ---
> >>> Changes since v1:
> >>>    - Use IS_ENABLED() to check CONFIG defines
> >>>    - Added RB and TB tags in commit description
> >>> ---
> >>>    arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
> >>>    1 file changed, 51 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> >>> index fba9e9f46a8c..04bcc91c91ea 100644
> >>> --- a/arch/riscv/kernel/cpu.c
> >>> +++ b/arch/riscv/kernel/cpu.c
> >>> @@ -3,10 +3,13 @@
> >>>     * Copyright (C) 2012 Regents of the University of California
> >>>     */
> >>>
> >>> +#include <linux/cpu.h>
> >>>    #include <linux/init.h>
> >>>    #include <linux/seq_file.h>
> >>>    #include <linux/of.h>
> >>> +#include <asm/csr.h>
> >>>    #include <asm/hwcap.h>
> >>> +#include <asm/sbi.h>
> >>>    #include <asm/smp.h>
> >>>    #include <asm/pgtable.h>
> >>>
> >>> @@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node *node)
> >>>    }
> >>>
> >>>    #ifdef CONFIG_PROC_FS
> >>> +
> >>> +struct riscv_cpuinfo {
> >>> +     unsigned long mvendorid;
> >>> +     unsigned long marchid;
> >>> +     unsigned long mimpid;
> >>> +};
> >>> +static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >>> +
> >>> +static int riscv_cpuinfo_starting(unsigned int cpu)
> >>> +{
> >>> +     struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> >>> +
> >>> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> >>> +     ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> >>> +     ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> >>> +     ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> >>
> >> how about:
> >>
> >>          if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> >>                  ...
> >>          } ... {
> >>
> >> or maybe even:
> >>
> >>
> >>          if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> >>                  if (sbi_spec_is_0_1()) {
> >>                          ...
> >>                  }
> >>          } ... {
> >>
> >> would mean better compile coverage (at the slight exepnese of
> >> having "false" sbi_spec_is_0_1() implemenation
> >
> > Most of the sbi_xyz() functions are not available for NoMMU
> > kernel so using "if (IS_ENABLED())" results in compile error.
>
> How about defining "false" versions for no-mmu case and try
> and avoid these #if mountains?

Well, we are not simplifying anything by moving from a "#if" ladder
to "if ()" ladder. Also, I don't see how the "#if" ladder will grow over
time.

Regards,
Anup

>
> >>
> >>> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> >>> +     ci->mvendorid = csr_read(CSR_MVENDORID);
> >>> +     ci->marchid = csr_read(CSR_MARCHID);
> >>> +     ci->mimpid = csr_read(CSR_MIMPID);
> >>> +#else
> >>> +     ci->mvendorid = 0;
> >>> +     ci->marchid = 0;
> >>> +     ci->mimpid = 0;
> >>> +#endif
> >>
> >> Would it be easier to zero out all the fields first and then fill them
> >> in if supported?
> >
> > Clearing out fields before "#if" ladder results in dead assignments.
>
> Not sure which is worse here, the #if ladder or some possibly dead
> assignments.
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
