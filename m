Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EFC53132B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiEWPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiEWPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:08:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB115C75C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:08:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e28so21210896wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItmOvQlJYrSM4iWYsCl26IX50qJOEZAdJld7IVn+tno=;
        b=LsRuUDeOP1ovU54Dh18ebFB16BExOoHwxIDcfdVVL4ZqEZ7P0dV/akxSzJQw6+0ysJ
         xICyWob4dPqfM1q/NWHMH9dsdjh2CpYDFJgjnKBDjLtDP5M+lhfLt2NJp+xxyhu5QWaO
         tdalyOStVL89wsfoE9JMIW3jTf4IQaPurgIH1M92jeIRBolhvDSCBYPRiOf2b0qvtpp2
         lzJ4AMiNEjSWfe76/LxKcXViUjCgcKoZuTrm3yLLGT9JAysy42C/xz04UrnnRxMqTlTD
         6Z2He18cfJq1KfIVt8I3Y7xrbKp3LpIohcFdtBUiyTSYIvJJ3VQQ7XFtP5ASnmX169bj
         RW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItmOvQlJYrSM4iWYsCl26IX50qJOEZAdJld7IVn+tno=;
        b=vE9WcGazELqiD/aIPuSmuzGEK87WvAHhw9GQbI3R3qu2zMO22cwSWpZwqf2Ye7W+t2
         bmxmkeQyPeQWD+9iFwTPkZdE8nUKRwpQdVTHDQ4b/Ad0opq/m0W0v2dJk6+ufEEQeMHM
         m1O9/IcdfyWncsqfNWYMoU7YwRti/iov5RxrulX10PBR2y68gJHHFrQv6ixjpkNqiK3N
         i+46kCrvbWhZ6RMVbx3YYwPbae82+p5SI8VXlqbojglE/Kp/UH/VrGNEBMNtulrOVakK
         0FhAWlUnmczd/9gVIkt6pnF2vI6XMTnD3DLUhMbXA4A4Nj+87RR4JwF21tBjYTZhBsY/
         2p4Q==
X-Gm-Message-State: AOAM530CO4Kir0nUXhGdWg413akJsp7e1lKzM+NFU0So6JVdflc01sv/
        QKIUKQX7gxNWDccS1JsePQdygWJTeJka5aIdeBukPQ==
X-Google-Smtp-Source: ABdhPJx1e94Ti+/mNHRd3xRYlgW0W6+8SRz7GMAuSCGBs5ejjusMofOeZunmCSg3wni9uefjakk2/CCrLVm8hNTcLlc=
X-Received: by 2002:a05:6000:1f18:b0:20f:e61b:520e with SMTP id
 bv24-20020a0560001f1800b0020fe61b520emr2900622wrb.214.1653318512593; Mon, 23
 May 2022 08:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220522153543.2656-1-jszhang@kernel.org> <20220522153543.2656-3-jszhang@kernel.org>
In-Reply-To: <20220522153543.2656-3-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 23 May 2022 20:38:20 +0530
Message-ID: <CAAhSdy0nTPbEa21-xttic2CfsMBa6BBEfa+y2MgT46aCPjQTsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: switch has_fpu() to the unified static key mechanism
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 9:14 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> This is to use the unified static key mechanism instead of putting
> static key related here and there.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
