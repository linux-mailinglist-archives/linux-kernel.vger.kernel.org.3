Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1D526C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384645AbiEMVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384652AbiEMVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:16:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A92FFF7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:16:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso102760637b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MRtO0/Q9M+/YZltuvI+O6gptQdPEm7Chns62TBTJqlc=;
        b=XsaKL/zxEjiTu7bLIUanqsf5HUSHvBat2+niQNEEe7sWSGi5nCS81ON4Sk80OIdusO
         VWOauFKsK+sOP1mBCWVBrLxtnmsVrQntMWn7YwzXpLegvvq+wjPBmDo2CqHQYl/YU//l
         oOLn20hynM9LECB8QSe/1i1gZ3NilEwPE5KPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MRtO0/Q9M+/YZltuvI+O6gptQdPEm7Chns62TBTJqlc=;
        b=t31U6eaZYVXIUPGl9nYis288OsBXj5BPMGr4zEoh2lRQIJgzP+s395u00482XIggPz
         v9o/BezXRTKLLGJc9aOvzcRhbjknwqiRJXp9WzaEtX403SmhcSt2y6g6mBx70LYz4dus
         XsiSYIs5rocR2UwMpTg8eBGGSrGSTwptWZjfpFJWRFrxs9oucDEv1kzbPTuftLjqBQCq
         k/uWEr0Z4x0C/RrEOGeJyZKIcvmZHoZ8d00drUHraHszAtmIzCCudpek7p1jGoiXBvY7
         rYfiUzpUdPpdey1FC7XNbXt+A1eKQXXRDz/z62gj0ijK7pwkr9wo3I8b24t6LvhyoFY6
         kJUQ==
X-Gm-Message-State: AOAM531RqypVSUlL2toMOVgDr0W/9OUXCcyULEEjg6vItVYpDraB7CkW
        J7sUJXYComWV2ZEUFE8QjdXOPmPbkenCK6P5movk
X-Google-Smtp-Source: ABdhPJykpwd6++Qrr66Y1B5RF+cba9dVJSWF8myhIJOtMwmcDp+XjSshI91XllrQqxdsxNvOIt02QPk+u9pSluSBgnQ=
X-Received: by 2002:a81:1196:0:b0:2f8:ccab:8807 with SMTP id
 144-20020a811196000000b002f8ccab8807mr7766773ywr.58.1652476580686; Fri, 13
 May 2022 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220512033045.1101909-1-daolu@rivosinc.com> <689ad3c4-0365-bd27-4873-bff8dbe6591b@sholland.org>
 <CAOnJCUJbsrCfjsfBgBMuA5E_h+yhOCjE4rSKYvxv1meQGDwZgA@mail.gmail.com>
In-Reply-To: <CAOnJCUJbsrCfjsfBgBMuA5E_h+yhOCjE4rSKYvxv1meQGDwZgA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 13 May 2022 14:16:09 -0700
Message-ID: <CAOnJCUJzFE-QWcGZGw9-BHb6teoXEX_m+H1-p=RY-UFbppcCYA@mail.gmail.com>
Subject: Re: [PATCH] arch/riscv: Add Zihintpause extension support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Dao Lu <daolu@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Fri, May 13, 2022 at 12:09 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, May 12, 2022 at 6:06 PM Samuel Holland <samuel@sholland.org> wrot=
e:
> >
> > On 5/11/22 10:30 PM, Dao Lu wrote:
> > > This patch:
> > >   1. Build with _zihintpause if the toolchain has support for it
> > >   2. Detects if the platform supports the extension
> >
> > This instruction is a hint, meaning it is a harmless no-op if the exten=
sion is
> > unsupported by the CPU. So we can use it as long as the compiler suppor=
ts it.
> > There is no need to probe for it at runtime.
> >
>
> Is it guaranteed that the hardware won't throw any error if it sees a
> fence instruction with
> (pred=3DW, succ=3D0, fm=3D0, rd=3Dx0, and rs1=3Dx0.) ? I couldn't find an=
ything
> specific related to this in the spec.
>

Never mind. I found this

"The FENCE encoding currently has nine non-trivial combinations of the
four bits PR, PW, SR,
and SW, plus one extra encoding FENCE.TSO which facilitates mapping of
=E2=80=9Cacquire+release=E2=80=9D or
RVTSO semantics. The remaining seven combinations have empty
predecessor and/or successor
sets and hence are no-ops."

However, we still need the extension availability check to preserve
the older platform's behavior.
Currently, the stall in cpu_relax is caused by the div. Without the
extension probe, it will just execute
"nop" which was not the earlier behavior.

> I think using the static key mechanism provides backward compatibility
> without any runtime impact.
>
> > Regards,
> > Samuel
> >
> > >   3. Use PAUSE for cpu_relax if both toolchain and the platform suppo=
rt it
> > >
> > > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > > ---
> > >  arch/riscv/Makefile                     |  4 ++++
> > >  arch/riscv/include/asm/hwcap.h          |  1 +
> > >  arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
> > >  arch/riscv/kernel/cpu.c                 |  1 +
> > >  arch/riscv/kernel/cpufeature.c          |  7 +++++++
> > >  5 files changed, 29 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 7d81102cffd4..900a8fda1a2d 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  :=3D $(riscv-ma=
rch-y)c
> > >  toolchain-need-zicsr-zifencei :=3D $(call cc-option-yn, -march=3D$(r=
iscv-march-y)_zicsr_zifencei)
> > >  riscv-march-$(toolchain-need-zicsr-zifencei) :=3D $(riscv-march-y)_z=
icsr_zifencei
> > >
> > > +# Check if the toolchain supports Zihintpause extension
> > > +toolchain-supports-zihintpause :=3D $(call cc-option-yn, -march=3D$(=
riscv-march-y)_zihintpause)
> > > +riscv-march-$(toolchain-supports-zihintpause) :=3D $(riscv-march-y)_=
zihintpause
> > > +
> > >  KBUILD_CFLAGS +=3D -march=3D$(subst fd,,$(riscv-march-y))
> > >  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
> > >
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/=
hwcap.h
> > > index 0734e42f74f2..caa9ee5459b4 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
> > >   */
> > >  enum riscv_isa_ext_id {
> > >       RISCV_ISA_EXT_SSCOFPMF =3D RISCV_ISA_EXT_BASE,
> > > +     RISCV_ISA_EXT_ZIHINTPAUSE,
> > >       RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> > >  };
> > >
> > > diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/inc=
lude/asm/vdso/processor.h
> > > index 134388cbaaa1..106b35ba8cac 100644
> > > --- a/arch/riscv/include/asm/vdso/processor.h
> > > +++ b/arch/riscv/include/asm/vdso/processor.h
> > > @@ -4,15 +4,28 @@
> > >
> > >  #ifndef __ASSEMBLY__
> > >
> > > +#include <linux/jump_label.h>
> > >  #include <asm/barrier.h>
> > > +#include <asm/hwcap.h>
> > >
> > > +extern struct static_key_false riscv_pause_available;
> > >  static inline void cpu_relax(void)
> > >  {
> > > +     if (!static_branch_likely(&riscv_pause_available)) {
> > >  #ifdef __riscv_muldiv
> > > -     int dummy;
> > > -     /* In lieu of a halt instruction, induce a long-latency stall. =
*/
> > > -     __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> > > +             int dummy;
> > > +             /* In lieu of a halt instruction, induce a long-latency=
 stall. */
> > > +             __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dumm=
y));
> > >  #endif
> > > +     } else {
> > > +#ifdef __riscv_zihintpause
> > > +             /*
> > > +              * Reduce instruction retirement.
> > > +              * This assumes the PC changes.
> > > +              */
> > > +             __asm__ __volatile__ ("pause");
> > > +#endif
> > > +     }
> > >       barrier();
> > >  }
> > >
> > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > index ccb617791e56..89e563e9c4cc 100644
> > > --- a/arch/riscv/kernel/cpu.c
> > > +++ b/arch/riscv/kernel/cpu.c
> > > @@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node=
)
> > >   */
> > >  static struct riscv_isa_ext_data isa_ext_arr[] =3D {
> > >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > > +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> > >       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> > >  };
> > >
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 1b2d42d7f589..327c19507dbb 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -24,6 +24,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX)=
 __read_mostly;
> > >  #ifdef CONFIG_FPU
> > >  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> > >  #endif
> > > +DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
> > > +EXPORT_SYMBOL_GPL(riscv_pause_available);
> > >
> > >  /**
> > >   * riscv_isa_extension_base() - Get base extension word
> > > @@ -192,6 +194,7 @@ void __init riscv_fill_hwcap(void)
> > >                               set_bit(*ext - 'a', this_isa);
> > >                       } else {
> > >                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_E=
XT_SSCOFPMF);
> > > +                             SET_ISA_EXT_MAP("zihintpause", RISCV_IS=
A_EXT_ZIHINTPAUSE);
> > >                       }
> > >  #undef SET_ISA_EXT_MAP
> > >               }
> > > @@ -213,6 +216,10 @@ void __init riscv_fill_hwcap(void)
> > >
> > >       }
> > >
> > > +     if (__riscv_isa_extension_available(riscv_isa, RISCV_ISA_EXT_ZI=
HINTPAUSE)) {
> > > +             static_branch_enable(&riscv_pause_available);
> > > +     }
> > > +
> > >       /* We don't support systems with F but without D, so mask those=
 out
> > >        * here. */
> > >       if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HW=
CAP_ISA_D)) {
> > >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



--=20
Regards,
Atish
