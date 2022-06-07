Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A673535640
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbiEZW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiEZW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:57:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA85005A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:57:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o80so5299704ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crKPSGDJKfnUdG+gm5l2KnuVS7sAoP6uY2tKjSUMZ2o=;
        b=WHEuN7/hDtTnk2+JJaq1pWNHdktvZgcJCi7SMH5Y9ZtBLirdjsDnD8vBte/Sib9mzk
         1pcf/WyhmFV8V8BVSEWrD2929KDCgUWNe5OdhSqTkPPxnQzIpaVjfEkviRf4wBrFI2cf
         Rhx4fIW/jbFBKMs6Yggm3GZl7qq+9TcyuF48A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crKPSGDJKfnUdG+gm5l2KnuVS7sAoP6uY2tKjSUMZ2o=;
        b=MKqCVZoKgFFTYIOJ8NTCtKWYGC/y7mmdp9JOUg1l+L5wEj5YjPkr2P4GLMzGLxPDc0
         l46JfRLF3mXd+2ExJgccB/3XsOhFbZkLDQXN2jdRWDrBrRvYeLKbiFKcJmeTtD+HuoTF
         mBvyjpLhpbMXrpLg9Qtd95yTqkh0wyU+srEbyGHBIhaZ1G+Y1DQDUsjcjDsourmEPm6p
         nxk0RorC+dwjNsqALMEqcz9LM9cpJR1gshb5xFnsk0FPuQSp6BMVDQnx+paA2v9zp08Y
         E6IQyiPEI5fsRlgqcEqXxxtIXqejGyp8TlTCiqhEdebFfsrxKDXMc8qZpu1zksYFJDl1
         y/kg==
X-Gm-Message-State: AOAM531D9fXWPO6EQUuXa9hnVyAHUzju007l5NXDwgDqUs/IEYiic0lZ
        XG64FWsQFy+KF07jSewSbTVI4DQIq+b0Xek81Xzp
X-Google-Smtp-Source: ABdhPJzsws8jicrHpjr6bHiEqv2dgDSKQK0dYjmPXCEAu0Z7hbn36wyd1eSHZivz4nw8pkoLqqqclSIkRQtmTiy+0OU=
X-Received: by 2002:a25:be82:0:b0:64a:20f1:94fc with SMTP id
 i2-20020a25be82000000b0064a20f194fcmr35405041ybk.538.1653605877125; Thu, 26
 May 2022 15:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com> <20220526101131.2340729-4-sunilvl@ventanamicro.com>
In-Reply-To: <20220526101131.2340729-4-sunilvl@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 26 May 2022 15:57:46 -0700
Message-ID: <CAOnJCU+a7fHisvS55Kj2=4pGapxtf8SvaPZmcnvy16M32tRztw@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] riscv: smp: Support for 64bit hartid
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Sunil V L <sunil.vl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 3:12 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> The hartid can be a 64bit value on RV64 platforms. This patch
> modifies the hartid parameter in riscv_hartid_to_cpuid() as
> unsigned long so that it can hold 64bit value on RV64 platforms.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/include/asm/smp.h | 4 ++--
>  arch/riscv/kernel/smp.c      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 23170c933d73..d3443be7eedc 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -42,7 +42,7 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
>  /* Hook for the generic smp_call_function_single() routine. */
>  void arch_send_call_function_single_ipi(int cpu);
>
> -int riscv_hartid_to_cpuid(int hartid);
> +int riscv_hartid_to_cpuid(unsigned long hartid);
>
>  /* Set custom IPI operations */
>  void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
> @@ -70,7 +70,7 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
>  {
>  }
>
> -static inline int riscv_hartid_to_cpuid(int hartid)
> +static inline int riscv_hartid_to_cpuid(unsigned long hartid)
>  {
>         if (hartid == boot_cpu_hartid)
>                 return 0;
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index b5d30ea92292..018e7dc45df6 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -47,7 +47,7 @@ static struct {
>         unsigned long bits ____cacheline_aligned;
>  } ipi_data[NR_CPUS] __cacheline_aligned;
>
> -int riscv_hartid_to_cpuid(int hartid)
> +int riscv_hartid_to_cpuid(unsigned long hartid)
>  {
>         int i;
>
> @@ -55,7 +55,7 @@ int riscv_hartid_to_cpuid(int hartid)
>                 if (cpuid_to_hartid_map(i) == hartid)
>                         return i;
>
> -       pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
> +       pr_err("Couldn't find cpu id for hartid [%lu]\n", hartid);
>         return -ENOENT;
>  }
>
> --
> 2.25.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
