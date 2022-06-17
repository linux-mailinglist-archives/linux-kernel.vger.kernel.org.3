Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575754FB27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382486AbiFQQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiFQQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:35:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CF4739B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:35:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d13so4292017plh.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YC4lHPVY+NpHj3GKC25ozKimf28WFmpvKhW7LG+BTy8=;
        b=UsxyjyMoLjBPKYKC3U2zf532HFCp04b5+9o9WujpjaYtYQf+8vWwqXRK1bK7kGqDvk
         tgPnltWu4COg7LTZpq8kRcB8gpxorwCbp4SnSXkNWWYYbOmlrnqyD1G8ai9wvE6SiiMJ
         3P+yE/xhOgzjwkeQ/230iRZ1yEHyg0vA4BqGyaycZuxmZgvCSTKaQVMAW48Y/dvRXSQu
         ak36qYhHA5Ic+O6Lg9fjWV+mk/krYzVDdv3r1LrkSl5tONmsKxWsTGWtkjN3wvDddNT3
         HLXeW87raNT+eeZz3H4S0r6qksCmTY+KNYSaiKV2mPsxuCnRraUd/mku2blH6ekOnkMq
         MQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YC4lHPVY+NpHj3GKC25ozKimf28WFmpvKhW7LG+BTy8=;
        b=67KofJfZmuD+Zmw0ooiUCXQdPvFZ5CYw5sIYXcNNNlIopPkqH8gEALRYLuvQmcfdeL
         tbPfk5z2GRs0zZ69wfuUeu/dQKjEAC1ut/TjcOjNZOwgFCir0i7sD+V7VRXO2ePOUxEl
         9ROoJa2FH0m8X4U7u3EvUGghCvtRh+FiYOtvT3WD7MkIc61dNIQZOb/Rq+QEBalMUg8i
         84/4IQ3XwdO1qdpYX3sEEZIxC4m7f3O8M9E8XBEm+s1lpiRNHaPERc4C3KaiZeTKaAQV
         ex+k7WlKuSKRfxi3SYm6u/Qkz9yTsRxfniKPUMlRLupxwKI8IF+tJCK5dsM2FdqYsFaX
         1/dg==
X-Gm-Message-State: AJIora/aLV7CBmM9kUA4zFH6A5Ifoms1OdwZtzBhfx4kYWxWbiqCD+uv
        if7TZnif1RoOWBvAyCU76tSWWFon1XkvrA0c3feTAw==
X-Google-Smtp-Source: AGRyM1sN0DcOFBiV+zxTkpfPAqlvlWi7aS2OR55Qj/QMUtyPp2fnRrdwjyOz3nP/haPqOGfi6GtpJrWH31oSMj7lAEs=
X-Received: by 2002:a17:90b:4382:b0:1ea:f4b6:1e29 with SMTP id
 in2-20020a17090b438200b001eaf4b61e29mr8933813pjb.159.1655483731236; Fri, 17
 Jun 2022 09:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220615211415.3111271-1-daolu@rivosinc.com> <6b52cc2c-7bc5-5015-b7a6-4c13bb4789f7@sholland.org>
In-Reply-To: <6b52cc2c-7bc5-5015-b7a6-4c13bb4789f7@sholland.org>
From:   Dao Lu <daolu@rivosinc.com>
Date:   Fri, 17 Jun 2022 09:35:20 -0700
Message-ID: <CAKh7v-QB4+UHjmtmBNQBojx8jB6fDT0WCvjPSPwFU0K_4wqbdg@mail.gmail.com>
Subject: Re: [PATCH v3] arch/riscv: add Zihintpause support
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Wei Fu <wefu@redhat.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
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

Will look at rebasing to use the unified static key mechanism for
the next version.

Regards,
Dao

On Thu, Jun 16, 2022 at 8:49 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 6/15/22 4:14 PM, Dao Lu wrote:
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
> >  Added the static branch back, cpu_relax() behavior is unchanged if eit=
her the
> > system or the toolchain does not support ZiHintPause
> > ---
> >  arch/riscv/Makefile                     |  4 ++++
> >  arch/riscv/include/asm/hwcap.h          |  1 +
> >  arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
> >  arch/riscv/kernel/cpu.c                 |  1 +
> >  arch/riscv/kernel/cpufeature.c          |  8 ++++++++
> >  5 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 34cf8a598617..6ddacc6f44b9 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  :=3D $(riscv-marc=
h-y)c
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
> > index 4e2486881840..f24f4f8c9144 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -53,6 +53,7 @@ extern unsigned long elf_hwcap;
> >  enum riscv_isa_ext_id {
> >       RISCV_ISA_EXT_SSCOFPMF =3D RISCV_ISA_EXT_BASE,
> >       RISCV_ISA_EXT_SVPBMT,
> > +     RISCV_ISA_EXT_ZIHINTPAUSE,
> >       RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> >  };
> >
> > diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/inclu=
de/asm/vdso/processor.h
> > index 134388cbaaa1..314ec17c40d8 100644
> > --- a/arch/riscv/include/asm/vdso/processor.h
> > +++ b/arch/riscv/include/asm/vdso/processor.h
> > @@ -4,15 +4,28 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > +#include <linux/jump_label.h>
> >  #include <asm/barrier.h>
> > +#include <asm/hwcap.h>
> >
> > +extern struct static_key_false riscv_pause_available;
> >  static inline void cpu_relax(void)
> >  {
> > +     if (!static_branch_likely(&riscv_pause_available)) {
> >  #ifdef __riscv_muldiv
> > -     int dummy;
> > -     /* In lieu of a halt instruction, induce a long-latency stall. */
> > -     __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> > +             int dummy;
> > +             /* In lieu of a halt instruction, induce a long-latency s=
tall. */
> > +             __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy)=
);
> >  #endif
> > +#ifdef __riscv_zihintpause
> > +     } else {
> > +             /*
> > +              * Reduce instruction retirement.
> > +              * This assumes the PC changes.
> > +              */
> > +             __asm__ __volatile__ ("pause");
> > +#endif
> > +     }
> >       barrier();
> >  }
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index fba9e9f46a8c..a123e92b14dd 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >  static struct riscv_isa_ext_data isa_ext_arr[] =3D {
> >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index a6f62a6d1edd..78c284c487e8 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -30,6 +30,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) _=
_read_mostly;
> >  #ifdef CONFIG_FPU
> >  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> >  #endif
> > +DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
> > +EXPORT_SYMBOL_GPL(riscv_pause_available);
>
> This patch should probably be rebased to use the unified static key
> mechanism[1], since that patch has now been merged.
>
> Regards,
> Samuel
>
> [1]: https://lore.kernel.org/linux-riscv/20220522153543.2656-2-jszhang@ke=
rnel.org/
