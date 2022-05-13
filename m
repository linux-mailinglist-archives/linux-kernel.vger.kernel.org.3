Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94584525C37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377667AbiEMHJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359683AbiEMHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:09:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35029BC7D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:09:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v59so13766198ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZCi80rSWSaWljJIiTWfg9yEo+Fxng+76D2ncosO4CQ=;
        b=V9YdKa+SALRwTY7iubDWZyaBm1XHeAjdscWdQFBcKyRNLA9yFyC+thvQNGU85FLvgr
         TZroI8BVWP9JGqOaNlf2lVp7K87zzK9CM2+TdOQo7wL+W5X1vbzm4a0Iz++AMtT3aZK7
         eb7KVxBGzP8QUGBmiMZDHZQS496kuYr4UwNEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZCi80rSWSaWljJIiTWfg9yEo+Fxng+76D2ncosO4CQ=;
        b=wF+sVooJY33wV/D4y/DbvqivkG5lg9gj3vTyfVr08o7aTyJCC+cyFarY4EF5LAsO5/
         KhrM1WbE1tiKsRT2AsFTs/HiMdb1MKpu/dJhxRMCRrUZBLky3fQSFa8u/v/LCUo9FvxN
         LyOomu9AkgVY8ejvQ9WRtp5iZFODQIOKWX7QIu+Pa9WGAM6L2Tbl5EzuMkBkA91Zr5Ft
         08nWLN7bYUiMmbOKfEX9ZGebygwsI9ZEoyjixyu/QWxYXhTsCWp5dN0jcsOfSR6cHg+Y
         5WCnMW9vtcMdfe2LTx00BHQhfTC9qQ/nKqDBVxHg8Iguv0B5iN88/xOr76qNgoo0h2Gg
         xOcQ==
X-Gm-Message-State: AOAM533onh7yEtBuqTijVYo4RIJJyp/94IVpR2O+O30k4Bn8WGoFAhDF
        3BjFRHuT/uSLzyPMRMHA+SJIftm1Lle2+t3NAEcQ
X-Google-Smtp-Source: ABdhPJxSAyQDEsCyxhdl+i5Eez6Kj9nvcDlaPv0osm4ipMdlMzIqAFbx5LjMZ7IR+o8zItpRV/XEoj1wLxOdJfFZgR4=
X-Received: by 2002:a05:6902:124b:b0:64b:8730:fd06 with SMTP id
 t11-20020a056902124b00b0064b8730fd06mr2462623ybu.289.1652425784594; Fri, 13
 May 2022 00:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220512033045.1101909-1-daolu@rivosinc.com> <689ad3c4-0365-bd27-4873-bff8dbe6591b@sholland.org>
In-Reply-To: <689ad3c4-0365-bd27-4873-bff8dbe6591b@sholland.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 13 May 2022 00:09:33 -0700
Message-ID: <CAOnJCUJbsrCfjsfBgBMuA5E_h+yhOCjE4rSKYvxv1meQGDwZgA@mail.gmail.com>
Subject: Re: [PATCH] arch/riscv: Add Zihintpause extension support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Dao Lu <daolu@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Thu, May 12, 2022 at 6:06 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 5/11/22 10:30 PM, Dao Lu wrote:
> > This patch:
> >   1. Build with _zihintpause if the toolchain has support for it
> >   2. Detects if the platform supports the extension
>
> This instruction is a hint, meaning it is a harmless no-op if the extension is
> unsupported by the CPU. So we can use it as long as the compiler supports it.
> There is no need to probe for it at runtime.
>

Is it guaranteed that the hardware won't throw any error if it sees a
fence instruction with
(pred=W, succ=0, fm=0, rd=x0, and rs1=x0.) ? I couldn't find anything
specific related to this in the spec.

I think using the static key mechanism provides backward compatibility
without any runtime impact.

> Regards,
> Samuel
>
> >   3. Use PAUSE for cpu_relax if both toolchain and the platform support it
> >
> > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > ---
> >  arch/riscv/Makefile                     |  4 ++++
> >  arch/riscv/include/asm/hwcap.h          |  1 +
> >  arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
> >  arch/riscv/kernel/cpu.c                 |  1 +
> >  arch/riscv/kernel/cpufeature.c          |  7 +++++++
> >  5 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 7d81102cffd4..900a8fda1a2d 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  := $(riscv-march-y)c
> >  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
> >  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
> >
> > +# Check if the toolchain supports Zihintpause extension
> > +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> > +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> > +
> >  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
> >  KBUILD_AFLAGS += -march=$(riscv-march-y)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 0734e42f74f2..caa9ee5459b4 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
> >   */
> >  enum riscv_isa_ext_id {
> >       RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> > +     RISCV_ISA_EXT_ZIHINTPAUSE,
> >       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> >  };
> >
> > diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> > index 134388cbaaa1..106b35ba8cac 100644
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
> > -     __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> > +             int dummy;
> > +             /* In lieu of a halt instruction, induce a long-latency stall. */
> > +             __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >  #endif
> > +     } else {
> > +#ifdef __riscv_zihintpause
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
> > index ccb617791e56..89e563e9c4cc 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >   */
> >  static struct riscv_isa_ext_data isa_ext_arr[] = {
> >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 1b2d42d7f589..327c19507dbb 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -24,6 +24,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >  #ifdef CONFIG_FPU
> >  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> >  #endif
> > +DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
> > +EXPORT_SYMBOL_GPL(riscv_pause_available);
> >
> >  /**
> >   * riscv_isa_extension_base() - Get base extension word
> > @@ -192,6 +194,7 @@ void __init riscv_fill_hwcap(void)
> >                               set_bit(*ext - 'a', this_isa);
> >                       } else {
> >                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> > +                             SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> >                       }
> >  #undef SET_ISA_EXT_MAP
> >               }
> > @@ -213,6 +216,10 @@ void __init riscv_fill_hwcap(void)
> >
> >       }
> >
> > +     if (__riscv_isa_extension_available(riscv_isa, RISCV_ISA_EXT_ZIHINTPAUSE)) {
> > +             static_branch_enable(&riscv_pause_available);
> > +     }
> > +
> >       /* We don't support systems with F but without D, so mask those out
> >        * here. */
> >       if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> >
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
