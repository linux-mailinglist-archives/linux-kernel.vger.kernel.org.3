Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B24531489
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiEWOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiEWOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:41:47 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601513CFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:41:46 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id q135so25791793ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BW04Z/gvjhs+P0ULzNLfp7O87Y9+RbJCN4YeRs8+SKY=;
        b=Soew57xnpel8YQd6sx781+vJHHd45Egx09p1KxaLo9hydn+G/B6Ok28cIxvAcIQKD/
         1wl3bJ16TuctScAkxIiEr0SItslhTXK2cptNI8aWG7eps/8Ki4/mh7Hxeeg7YZ3oGF6A
         /ZllW2ex8dBGPYn4/Os+85gZ4AHiTtkgC3HGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BW04Z/gvjhs+P0ULzNLfp7O87Y9+RbJCN4YeRs8+SKY=;
        b=TT4iBZgUyFcPF/Zx0851iEG7m0zEwc952OOBM/HJjrsCtHje860EWnmjw0Zuw1XkE8
         QHKORBSAFryPoOZ3QLxX4sgm5fs9LCaPN3WIISsw7y3vyWliebNj5B2yVO/8y3//M0yu
         iR7ebFyAKEZ68g9gEZn7/S67l/olr94mca8KL7c9TkQLrPKW3mqTit50z0PI4eHxbF8L
         +yWXltRTPbnQ3iL/5iXDOGmgrph40si1r2UNRXk/1A/HlFJ/9UL17tVtbdXOiXibPZa3
         fqV/yjhr3dtOqjPXEG8U0t5bSbnmYdBL3e/bXnQMOHMLSBQk/V0Oq4lQM+L1M8joOPPL
         qx2Q==
X-Gm-Message-State: AOAM532CzUgB3GJaRzDqkJ1BoICoUqIwL30cDmgfDf2qzcaSy7tAUt51
        mJliewG4fHyS3H3+p9XWeyLszn/tZ2eN/oGUh0pbHPBmYw==
X-Google-Smtp-Source: ABdhPJx9n8niQElJxbz6DJ61kucg+5EyeHTacZxxEMowuLTsGrUEdcGplrZrbAMZ1qlMPazwasGdO0i7lkLSij8v6Ig=
X-Received: by 2002:a25:aa30:0:b0:64d:ebad:538d with SMTP id
 s45-20020a25aa30000000b0064debad538dmr23509454ybi.603.1653316905947; Mon, 23
 May 2022 07:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220522153543.2656-1-jszhang@kernel.org> <20220522153543.2656-3-jszhang@kernel.org>
In-Reply-To: <20220522153543.2656-3-jszhang@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 23 May 2022 07:41:35 -0700
Message-ID: <CAOnJCU+2MgHaEOFK9_0Unb1GjnLP-Ge-B-C_Ndwj8aF2NxfpeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: switch has_fpu() to the unified static key mechanism
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

On Sun, May 22, 2022 at 8:44 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> This is to use the unified static key mechanism instead of putting
> static key related here and there.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/switch_to.h | 4 ++--
>  arch/riscv/kernel/cpufeature.c     | 7 -------
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 0a3f4f95c555..11463489fec6 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -8,6 +8,7 @@
>
>  #include <linux/jump_label.h>
>  #include <linux/sched/task_stack.h>
> +#include <asm/hwcap.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> @@ -56,10 +57,9 @@ static inline void __switch_to_aux(struct task_struct *prev,
>         fstate_restore(next, task_pt_regs(next));
>  }
>
> -extern struct static_key_false cpu_hwcap_fpu;
>  static __always_inline bool has_fpu(void)
>  {
> -       return static_branch_likely(&cpu_hwcap_fpu);
> +       return static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_FPU]);
>  }
>  #else
>  static __always_inline bool has_fpu(void) { return false; }
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 89f886b35357..0235391be84b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -21,9 +21,6 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>
> -#ifdef CONFIG_FPU
> -__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> -#endif
>  __ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>  EXPORT_SYMBOL(riscv_isa_ext_keys);
>
> @@ -239,8 +236,4 @@ void __init riscv_fill_hwcap(void)
>                 if (j >= 0)
>                         static_branch_enable(&riscv_isa_ext_keys[j]);
>         }
> -#ifdef CONFIG_FPU
> -       if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
> -               static_branch_enable(&cpu_hwcap_fpu);
> -#endif
>  }
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
