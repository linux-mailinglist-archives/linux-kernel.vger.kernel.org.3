Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56C8567AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiGEXrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGEXru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154D12A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 16:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C167B81A4F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD04C341D8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657064866;
        bh=ptichBaM2hD9wP7dMdNt41FsibNjXNpggiC/v5NP4zE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LPLjR2SO6GjtryO2kpwqDUIVVn6VmRHsNDts5wJGlZSIgKa6MjIqF45PDKHsfcEbR
         V61uQHUI2ihtZo1Ik+Mt9TJ4Upr5ucB4iZevnxLnKiE+DaLGDtow3x/oIYo6oAzTUA
         hbHUXa32mfXxDvfMalvbeo5Vy53AbLVKfSNkNBSQXoHwyKYdLRbMoM0I/z6p9q5trn
         PJQUjjFujaiTudSm6s5eWHpuMuoWYhTg1EhhubzdH+RIpTkguyc8qzL/BC/MwpPVmt
         kcVKtfwXAKF1XCbuIS/z9e0wKNKLDpLLzyiQZS2XbpQlcGDKZ2ZMi5gkz83Iy2XCaQ
         KGTWyy/KslSHA==
Received: by mail-vk1-f176.google.com with SMTP id b81so6658014vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 16:47:46 -0700 (PDT)
X-Gm-Message-State: AJIora+gUXDXWGNKwPwdwgGMx4uw0V9D9IME/ljEZLJOoko0MMjRmwce
        ifx5PK0CVdiNO3LHMWU74p7294sXHm+EcCo8NWY=
X-Google-Smtp-Source: AGRyM1u5pZJPyso1b/BUEYEUSXxPoEToHFgbDKPN5EdhOCOcuGTVk1OrkUZtHzYuywVinZDnN+rsMZoSeiUsM3lqXxI=
X-Received: by 2002:a1f:1b4b:0:b0:36c:bc20:3982 with SMTP id
 b72-20020a1f1b4b000000b0036cbc203982mr21618553vkb.8.1657064865584; Tue, 05
 Jul 2022 16:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220620201530.3929352-1-daolu@rivosinc.com> <CAKh7v-TfWBRiB6Jf0ke4Er68i_pVbvMtR-Xvvy=bdbJO4tKHvg@mail.gmail.com>
In-Reply-To: <CAKh7v-TfWBRiB6Jf0ke4Er68i_pVbvMtR-Xvvy=bdbJO4tKHvg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 6 Jul 2022 07:47:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRr1eY+rZetLn+X4DCukPmFbhTPTpmifdD2LbtTwFTRJg@mail.gmail.com>
Message-ID: <CAJF2gTRr1eY+rZetLn+X4DCukPmFbhTPTpmifdD2LbtTwFTRJg@mail.gmail.com>
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
To:     Dao Lu <daolu@rivosinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
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
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Jul 6, 2022 at 12:57 AM Dao Lu <daolu@rivosinc.com> wrote:
>
> ping
>
> On Mon, Jun 20, 2022 at 1:15 PM Dao Lu <daolu@rivosinc.com> wrote:
> >
> > Implement support for the ZiHintPause extension.
> >
> > The PAUSE instruction is a HINT that indicates the current hart=E2=80=
=99s rate
> > of instruction retirement should be temporarily reduced or paused.
> >
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > ---
> >
> > v1 -> v2:
> >  Remove the usage of static branch, use PAUSE if toolchain supports it
> > v2 -> v3:
> >  Added the static branch back, cpu_relax() behavior is kept the same fo=
r
> > systems that do not support ZiHintPause
> > v3 -> v4:
> >  Adopted the newly added unified static keys for extensions
> > ---
> >  arch/riscv/Makefile                     |  4 ++++
> >  arch/riscv/include/asm/hwcap.h          |  5 +++++
> >  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
> >  arch/riscv/kernel/cpu.c                 |  1 +
> >  arch/riscv/kernel/cpufeature.c          |  1 +
> >  5 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 34cf8a598617..6ddacc6f44b9 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)    :=3D $(riscv-ma=
rch-y)c
> >  toolchain-need-zicsr-zifencei :=3D $(call cc-option-yn, -march=3D$(ris=
cv-march-y)_zicsr_zifencei)
> >  riscv-march-$(toolchain-need-zicsr-zifencei) :=3D $(riscv-march-y)_zic=
sr_zifencei
> >
> > +# Check if the toolchain supports Zihintpause extension
> > +toolchain-supports-zihintpause :=3D $(call cc-option-yn, -march=3D$(ri=
scv-march-y)_zihintpause)
> > +riscv-march-$(toolchain-supports-zihintpause) :=3D $(riscv-march-y)_zi=
hintpause
> > +
> >  KBUILD_CFLAGS +=3D -march=3D$(subst fd,,$(riscv-march-y))
> >  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index e48eebdd2631..dc47019a0b38 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -8,6 +8,7 @@
> >  #ifndef _ASM_RISCV_HWCAP_H
> >  #define _ASM_RISCV_HWCAP_H
> >
> > +#include <asm/errno.h>
> >  #include <linux/bits.h>
> >  #include <uapi/asm/hwcap.h>
> >
> > @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
> >  enum riscv_isa_ext_id {
> >         RISCV_ISA_EXT_SSCOFPMF =3D RISCV_ISA_EXT_BASE,
> >         RISCV_ISA_EXT_SVPBMT,
> > +       RISCV_ISA_EXT_ZIHINTPAUSE,
> >         RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> >  };
> >
> > @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
> >   */
> >  enum riscv_isa_ext_key {
> >         RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> > +       RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> >         RISCV_ISA_EXT_KEY_MAX,
> >  };
> >
> > @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
> >                 return RISCV_ISA_EXT_KEY_FPU;
> >         case RISCV_ISA_EXT_d:
> >                 return RISCV_ISA_EXT_KEY_FPU;
> > +       case RISCV_ISA_EXT_ZIHINTPAUSE:
> > +               return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> >         default:
> >                 return -EINVAL;
> >         }
> > diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/inclu=
de/asm/vdso/processor.h
> > index 134388cbaaa1..1e4f8b4aef79 100644
> > --- a/arch/riscv/include/asm/vdso/processor.h
> > +++ b/arch/riscv/include/asm/vdso/processor.h
> > @@ -4,15 +4,30 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > +#include <linux/jump_label.h>
> >  #include <asm/barrier.h>
> > +#include <asm/hwcap.h>
> >
> >  static inline void cpu_relax(void)
> >  {
> > +       if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY=
_ZIHINTPAUSE])) {
> >  #ifdef __riscv_muldiv
> > -       int dummy;
> > -       /* In lieu of a halt instruction, induce a long-latency stall. =
*/
> > -       __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> > +               int dummy;
> > +               /* In lieu of a halt instruction, induce a long-latency=
 stall. */
> > +               __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dumm=
y));
> >  #endif
> > +       } else {
> > +               /*
> > +                * Reduce instruction retirement.
> > +                * This assumes the PC changes.
> > +                */
> > +#ifdef __riscv_zihintpause
> > +               __asm__ __volatile__ ("pause");
> > +#else
> > +               /* Encoding of the pause instruction */
> > +               __asm__ __volatile__ (".4byte 0x100000F");
> > +#endif
> > +       }
> >         barrier();
> >  }
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index fba9e9f46a8c..a123e92b14dd 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >  static struct riscv_isa_ext_data isa_ext_arr[] =3D {
> >         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +       __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 1b3ec44e25f5..708df2c0bc34 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
> >                         } else {
> >                                 SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_E=
XT_SSCOFPMF);
> >                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT=
_SVPBMT);
> > +                               SET_ISA_EXT_MAP("zihintpause", RISCV_IS=
A_EXT_ZIHINTPAUSE);
> >                         }
> >  #undef SET_ISA_EXT_MAP
> >                 }
> > --
> > 2.25.1
> >



--=20
Best Regards
 Guo Ren
