Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E498151F334
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiEIELR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiEIEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:05:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A080BCB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:02:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q23so17648685wra.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJ8dF+QuMh/vx+O3NBUHJR6SAWNkIGtKyfjSID7EqTw=;
        b=IX/c5ofu+DaFlsi1jnFUDRl9XdZl1WZC81pKbYDuudzHveM/7WM6xfecMOUF5qp/iP
         UI8sJlVCvDQJu4iXYlGVoDOJXtKSYhHLsGvFIYwo3t6mpuvLyL4SV/GZQbxEks1xNIik
         A/qsIaxlFtb/rI8wddI/qlhzy3/XROR+J8pR7mQbtFI6eHQzZYEs+sP90pMRgb+sRhp5
         YJCdYq+H61DwmHMO7UzpMOcUl8XhU9PiZk4YpDRb9UcxYoryYMhDzlhL+kACPoMnypAn
         AqZq9MyceQ9jp3u40/eYgQYwNrKBLDrDFr4SaoFZxV+PWZMggMarlyz5+v6APJ8c5DEV
         Caug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJ8dF+QuMh/vx+O3NBUHJR6SAWNkIGtKyfjSID7EqTw=;
        b=Z9RwVrVD6EMkB4cPPi1neFt1+LuE31Vj2Sv17+IV7zlx4v9eU/Tt9FGCxtXTjvoppv
         z/BRvQEiQtBaGy3mv0/wWivVaO6Q1/PtIcEGGY7G5+VF7PwYjLhu69ZIMPOtkoqhnkvv
         4HI9Yyf2gxdVp3fOHKFQ/2anhJdjl+IxazkUEsA2BrgQTowLqSdeVc3DYga19UftJmpi
         bd1OEHuX29t0ajU5u8HP3ZFabJ6cu/QeLRM60SIuSLY84x3DhfDwI48l2TUgQkGPzK7Q
         iMCr/8jfK9S+zBfrEd4zUD48gvc4uE2bnu1xtLfvM/qy8+LdUQ7a4BuopNdU0s2VMzod
         BCKg==
X-Gm-Message-State: AOAM530mpy9Iuv5nnAjg97Gn6u9dBrAYeB7tAF6TfRt63hv+T+BnbpvY
        ZSb32pOJpZVIAbBwB1Qix2tQEuuM+t8iWQBiQc+YoQ==
X-Google-Smtp-Source: ABdhPJxcZSyW1JpOeqlyUitgRFAErha6IKy2Qp5nxrezznBtFQsIryCYlE9BooGVgCcE5TEryK/szudYVHViUtmnsoM=
X-Received: by 2002:a5d:6d0d:0:b0:20c:530c:1681 with SMTP id
 e13-20020a5d6d0d000000b0020c530c1681mr11940881wrq.214.1652068918822; Sun, 08
 May 2022 21:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220508160749.984-1-jszhang@kernel.org> <20220508160749.984-4-jszhang@kernel.org>
In-Reply-To: <20220508160749.984-4-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 09:31:47 +0530
Message-ID: <CAAhSdy32C59ULdP7KNNgy08jF5vUbvYoF6_n+kAopJfiLsJQFw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] riscv: replace has_fpu() with system_supports_fpu()
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 9:46 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> This is to use the unified cpus_have_{final|const}_cap() instead of
> putting static key related here and there.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/cpufeature.h | 5 +++++
>  arch/riscv/include/asm/switch_to.h  | 9 ++-------
>  arch/riscv/kernel/cpufeature.c      | 8 ++------
>  arch/riscv/kernel/process.c         | 2 +-
>  arch/riscv/kernel/signal.c          | 4 ++--
>  5 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index d80ddd2f3b49..634a653c7fa2 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -91,4 +91,9 @@ static inline void cpus_set_cap(unsigned int num)
>         }
>  }
>
> +static inline bool system_supports_fpu(void)
> +{
> +       return IS_ENABLED(CONFIG_FPU) && !cpus_have_final_cap(RISCV_HAS_NO_FPU);

This should be checking for "f" and "d" ISA extensions since "FPU" is
not an ISA extension name.

> +}
> +
>  #endif
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 0a3f4f95c555..362cb18d12d5 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -8,6 +8,7 @@
>
>  #include <linux/jump_label.h>
>  #include <linux/sched/task_stack.h>
> +#include <asm/cpufeature.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> @@ -56,13 +57,7 @@ static inline void __switch_to_aux(struct task_struct *prev,
>         fstate_restore(next, task_pt_regs(next));
>  }
>
> -extern struct static_key_false cpu_hwcap_fpu;
> -static __always_inline bool has_fpu(void)
> -{
> -       return static_branch_likely(&cpu_hwcap_fpu);
> -}
>  #else
> -static __always_inline bool has_fpu(void) { return false; }
>  #define fstate_save(task, regs) do { } while (0)
>  #define fstate_restore(task, regs) do { } while (0)
>  #define __switch_to_aux(__prev, __next) do { } while (0)
> @@ -75,7 +70,7 @@ extern struct task_struct *__switch_to(struct task_struct *,
>  do {                                                   \
>         struct task_struct *__prev = (prev);            \
>         struct task_struct *__next = (next);            \
> -       if (has_fpu())                                  \
> +       if (system_supports_fpu())                                      \
>                 __switch_to_aux(__prev, __next);        \
>         ((last) = __switch_to(__prev, __next));         \
>  } while (0)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index e6c72cad0c1c..1edf3c3f8f62 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -22,10 +22,6 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>
> -#ifdef CONFIG_FPU
> -__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> -#endif
> -
>  DECLARE_BITMAP(cpu_hwcaps, RISCV_NCAPS);
>  EXPORT_SYMBOL(cpu_hwcaps);
>
> @@ -254,8 +250,8 @@ void __init riscv_fill_hwcap(void)
>         pr_info("riscv: ELF capabilities %s\n", print_str);
>
>  #ifdef CONFIG_FPU
> -       if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
> -               static_branch_enable(&cpu_hwcap_fpu);
> +       if (!(elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)))
> +               cpus_set_cap(RISCV_HAS_NO_FPU);
>  #endif
>         enable_cpu_capabilities();
>         static_branch_enable(&riscv_const_caps_ready);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 504b496787aa..c9cd0b42299e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -88,7 +88,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>         unsigned long sp)
>  {
>         regs->status = SR_PIE;
> -       if (has_fpu()) {
> +       if (system_supports_fpu()) {
>                 regs->status |= SR_FS_INITIAL;
>                 /*
>                  * Restore the initial value to the FP register
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 9f4e59f80551..96aa593a989e 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -90,7 +90,7 @@ static long restore_sigcontext(struct pt_regs *regs,
>         /* sc_regs is structured the same as the start of pt_regs */
>         err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
>         /* Restore the floating-point state. */
> -       if (has_fpu())
> +       if (system_supports_fpu())
>                 err |= restore_fp_state(regs, &sc->sc_fpregs);
>         return err;
>  }
> @@ -143,7 +143,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>         /* sc_regs is structured the same as the start of pt_regs */
>         err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
>         /* Save the floating-point state. */
> -       if (has_fpu())
> +       if (system_supports_fpu())
>                 err |= save_fp_state(regs, &sc->sc_fpregs);
>         return err;
>  }
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
