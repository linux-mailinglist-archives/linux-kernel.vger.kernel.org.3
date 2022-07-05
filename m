Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962135674E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiGEQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiGEQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:57:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C617A9A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:57:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fz10so6657214pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=suog/Gt5RDjFtkrl4zqgyYgxAM6ZJ7RwwJ+iiXEHGDA=;
        b=30WT+a+ickLPvR0veV/l7naQmoMAChOHusPk+6991l1bwpbrJJB+icKscul1hvjrmN
         Cp++i+Shtv56uPjoH0gZegia9ZbDKgFN0/lH3BRHga5spXjA+dE8vNqoag530DqDYvf3
         5cY8A/AG4h2VRn9lC/0mZNQG5JZvh9MNOFUd8I0A5BWTKon0uF1o0hHLnx54as9C8oMJ
         O/w00lHYVBHqgFBaNDw1NZVE0qXYXCedHh3da0Q/jC89Sffvg/b0TngUKAC/EDx2Lyt9
         zo2sJ+V0XlXjRMR8kjkHVWbs1TVdyxvs3gJin5a1jfi0DeQ4McYCrqyUYcnKpCOsmiPN
         PtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=suog/Gt5RDjFtkrl4zqgyYgxAM6ZJ7RwwJ+iiXEHGDA=;
        b=j7mwQzH/cEsRJCCE3n8xZwwgFNzV+cskRx1dHVyg6Mua3nqv93xdJehNVC8h67r3Uj
         hF90/jcT3F9KF82AYeBBPruE6Vz9d1D1kOlcdb5WJz8oLGdYH+5pjzurtCHjVw5WGTu8
         GNMrC1xeg9mKMXmkHrYfnXmCszJul0RAaf4Zr42X2VZZN/jPLawvGBDZHRUpT9aohj7n
         mzpg+ediWM62ewy5iONLGApCIJfI1yRBGIlb/JlH7yEzo1VbAu8w97dBEK7hoP9WFC7A
         nkDavNcPlfDyOieNleixEkO+xW+yvwbSwKNYh5JK7+27MI30siM57fs0V4jtqD98gqAx
         q48Q==
X-Gm-Message-State: AJIora87kbvV/ofYmvgWaP6FFPEMwKw8jRjf43HpVwDD44PB4FA2mTZ5
        gJYLI5CHyVmr815m0J3jV7mpett7luqCNdA1kpaALv3iynQ=
X-Google-Smtp-Source: AGRyM1uQ3O1qx4NqOTNb5IarEbJ7DDPPdjkSvs285qAyDb0Ss+FWbljh2cbwuNY3UcJeaV7x711QLVGfZhtEnvk8mns=
X-Received: by 2002:a17:902:e544:b0:16b:fcbe:7ba1 with SMTP id
 n4-20020a170902e54400b0016bfcbe7ba1mr517528plf.130.1657040241622; Tue, 05 Jul
 2022 09:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220620201530.3929352-1-daolu@rivosinc.com>
In-Reply-To: <20220620201530.3929352-1-daolu@rivosinc.com>
From:   Dao Lu <daolu@rivosinc.com>
Date:   Tue, 5 Jul 2022 09:57:11 -0700
Message-ID: <CAKh7v-TfWBRiB6Jf0ke4Er68i_pVbvMtR-Xvvy=bdbJO4tKHvg@mail.gmail.com>
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Yury Norov <yury.norov@gmail.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On Mon, Jun 20, 2022 at 1:15 PM Dao Lu <daolu@rivosinc.com> wrote:
>
> Implement support for the ZiHintPause extension.
>
> The PAUSE instruction is a HINT that indicates the current hart=E2=80=99s=
 rate
> of instruction retirement should be temporarily reduced or paused.
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
>
> v1 -> v2:
>  Remove the usage of static branch, use PAUSE if toolchain supports it
> v2 -> v3:
>  Added the static branch back, cpu_relax() behavior is kept the same for
> systems that do not support ZiHintPause
> v3 -> v4:
>  Adopted the newly added unified static keys for extensions
> ---
>  arch/riscv/Makefile                     |  4 ++++
>  arch/riscv/include/asm/hwcap.h          |  5 +++++
>  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
>  arch/riscv/kernel/cpu.c                 |  1 +
>  arch/riscv/kernel/cpufeature.c          |  1 +
>  5 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..6ddacc6f44b9 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)    :=3D $(riscv-marc=
h-y)c
>  toolchain-need-zicsr-zifencei :=3D $(call cc-option-yn, -march=3D$(riscv=
-march-y)_zicsr_zifencei)
>  riscv-march-$(toolchain-need-zicsr-zifencei) :=3D $(riscv-march-y)_zicsr=
_zifencei
>
> +# Check if the toolchain supports Zihintpause extension
> +toolchain-supports-zihintpause :=3D $(call cc-option-yn, -march=3D$(risc=
v-march-y)_zihintpause)
> +riscv-march-$(toolchain-supports-zihintpause) :=3D $(riscv-march-y)_zihi=
ntpause
> +
>  KBUILD_CFLAGS +=3D -march=3D$(subst fd,,$(riscv-march-y))
>  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e48eebdd2631..dc47019a0b38 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_RISCV_HWCAP_H
>  #define _ASM_RISCV_HWCAP_H
>
> +#include <asm/errno.h>
>  #include <linux/bits.h>
>  #include <uapi/asm/hwcap.h>
>
> @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
>  enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_SSCOFPMF =3D RISCV_ISA_EXT_BASE,
>         RISCV_ISA_EXT_SVPBMT,
> +       RISCV_ISA_EXT_ZIHINTPAUSE,
>         RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
>  };
>
> @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
>   */
>  enum riscv_isa_ext_key {
>         RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> +       RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>         RISCV_ISA_EXT_KEY_MAX,
>  };
>
> @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
>                 return RISCV_ISA_EXT_KEY_FPU;
>         case RISCV_ISA_EXT_d:
>                 return RISCV_ISA_EXT_KEY_FPU;
> +       case RISCV_ISA_EXT_ZIHINTPAUSE:
> +               return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>         default:
>                 return -EINVAL;
>         }
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include=
/asm/vdso/processor.h
> index 134388cbaaa1..1e4f8b4aef79 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -4,15 +4,30 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/jump_label.h>
>  #include <asm/barrier.h>
> +#include <asm/hwcap.h>
>
>  static inline void cpu_relax(void)
>  {
> +       if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_Z=
IHINTPAUSE])) {
>  #ifdef __riscv_muldiv
> -       int dummy;
> -       /* In lieu of a halt instruction, induce a long-latency stall. */
> -       __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> +               int dummy;
> +               /* In lieu of a halt instruction, induce a long-latency s=
tall. */
> +               __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy)=
);
>  #endif
> +       } else {
> +               /*
> +                * Reduce instruction retirement.
> +                * This assumes the PC changes.
> +                */
> +#ifdef __riscv_zihintpause
> +               __asm__ __volatile__ ("pause");
> +#else
> +               /* Encoding of the pause instruction */
> +               __asm__ __volatile__ (".4byte 0x100000F");
> +#endif
> +       }
>         barrier();
>  }
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..a123e92b14dd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>  static struct riscv_isa_ext_data isa_ext_arr[] =3D {
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +       __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1b3ec44e25f5..708df2c0bc34 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
>                         } else {
>                                 SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT=
_SSCOFPMF);
>                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_S=
VPBMT);
> +                               SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_=
EXT_ZIHINTPAUSE);
>                         }
>  #undef SET_ISA_EXT_MAP
>                 }
> --
> 2.25.1
>
