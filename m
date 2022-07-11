Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9551F570C13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiGKUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKUjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:39:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E8DFA7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:39:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31caffa4a45so61537617b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tgao7UaaDt/zCf+jX3ApL4sHCcBbuTaY4KeXN5lOVYA=;
        b=LJq6iZ3zFH6oSmz8Dhh6LUDzTwxFjQIGr0UXgza45SL/R4monaUXD0ZBVda33/dzgA
         F29hgrY91ChwHT/91+h4yHD+xXzQrwY7GOBLlAEGY79MMqeQ1hcmWJ+uNK3HUmoLCRVj
         +iBiBnegxn4dlRpCkdj4jIAw7WYrWDQQQB6Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tgao7UaaDt/zCf+jX3ApL4sHCcBbuTaY4KeXN5lOVYA=;
        b=k25yyH8xZXf+MT0+FSPs7SdMA1peDZ/g+RrQAUqib5uH5K0VEBp3VbLRUv7AGE0r7Y
         zoyNFRfD6Uuj7kUlEYGD56sa7C2k10dr0/I+zaXLeU2jgU0Y1kFIV2p8bEixYAE6Oc0S
         4wONceOIwdPdGcONDADn80MSi4i3V/TKgu/adnZXcP5uCnImgQC6h1bmXniHRK0nhspx
         Ocm2JKJSdKDs0qAItBht9W3j7NAGUPpg8ZTOL+/FM0GFJfV2FDstbkLU+6kXZsuCzGRy
         yCY1U3XQQ0Z8kvQuJB5BmVOYlMVXMvCDbn5REMTOmZLHGosOePqhoIPD29eoo+rd+Tax
         7TiQ==
X-Gm-Message-State: AJIora9w1zsVLRIbmimtblXqJBrNq0ACqPHsQBAZQy4b9Lc2MkqgEwEN
        LM4YJ1vfOchPJqpfT+zgSmf36OPa9AyXNPuDn7GoT7C6RQ==
X-Google-Smtp-Source: AGRyM1tUiWPuYI3f+PHbDzTskStbiQ3MpIsGOcLuxKwKHU5/CzcXhcZq8xJqeNoLxOUtwe+Fr081dMmGbtwm1CMh+B4=
X-Received: by 2002:a81:1514:0:b0:31c:a84b:350a with SMTP id
 20-20020a811514000000b0031ca84b350amr21755746ywv.400.1657571963548; Mon, 11
 Jul 2022 13:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220620201530.3929352-1-daolu@rivosinc.com>
In-Reply-To: <20220620201530.3929352-1-daolu@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 11 Jul 2022 13:39:12 -0700
Message-ID: <CAOnJCUJnN0LjADDHRSrr6R7saNxYft9BN36K5SK-2utupTGzFQ@mail.gmail.com>
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
To:     Dao Lu <daolu@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

LGTM.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
