Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2A4EE196
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbiCaTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiCaTYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:24:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7C1D67C4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:22:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c7so1236871wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tvkeAECg5z7P2Yhw4AF53foh56J6sFwJKc3SN8wX7/k=;
        b=gEspNI5K28r/ePirzPGZE1nDsIxAZ4NMSL1m9eoDolBpwHNpbs5TcHvzBWlV/RqnCj
         3/AjIdPXId4O8YDQqR/mbcAroIIW74QFA39Hr4BwApLINn7STtoRCphAWPGDWBuy/fwI
         wBtL1Ef1fI41hrAOeYkI2QQUGqs8MgLjJokqpZ2EUdbWXqPn5ONn79xOp0jOs05PQH4S
         HaGMS6f813Oo2fO9aMLk7HnCV/tuV3JHfauZvxN0m/BrcHgtmzHky+aso2DQxx6B8jTQ
         JtYJdLlUfGSjjXkBhmWvKuhbXhP72ovFXJyJzCTGLAm45UYMgYMUSqE3SrMAxDhRQwiY
         Hnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tvkeAECg5z7P2Yhw4AF53foh56J6sFwJKc3SN8wX7/k=;
        b=G/TM/KLQSxrbvzo1hGRgZ09S0hZMg7UPDnZf3C+10YcOUpb3QA38NxK2Fq/e6E8bb4
         t8KjxTlx8HuYGWsEunQGZG2mElY/s2rGCfk9sVsDNQPHWFnfFOG0Ugcoe79FBQMma7Gy
         7naP31tJU7ed6dzr7PK5upTIHCsWfYPOVvcKw7EjtNqBpBqg6H0bgV7kWe63qrWBboOx
         VdrOEkEZ4eeZw9KnhfOZ05k6Yui5KRdUjnysmRQUDFBlLRHJt2LlP34omKTx1NsWFug/
         C79UWh1LN/1YLRvk+sSOmeURzlIlEj3E7NzHJ9PD/vVJr8Wfqq35+EIza8po2XIPxaQA
         61BQ==
X-Gm-Message-State: AOAM530fufIXJbTBqAz/CkqiHQPXuQt6JKRJvDAaJFpkkAIeSNOeUKna
        dH4hY3v8S8kFYO6sI7O6O4E3EZbjmLWbeL1g0Z+t2w==
X-Google-Smtp-Source: ABdhPJz+NPDlLSy8JNuEy8mvqQOrZuasFpdLbUIUb7NAbEKRCCqaXvLxW5/BwonZVWEPwzFa480bMBhWkY/jH043RBs=
X-Received: by 2002:a5d:6d52:0:b0:1f0:73eb:23b9 with SMTP id
 k18-20020a5d6d52000000b001f073eb23b9mr5106681wri.649.1648754536233; Thu, 31
 Mar 2022 12:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
 <20220314200148.2695206-8-kaleshsingh@google.com> <CA+EHjTwQRUCjvcMHNe1f0kPBdU=vS+f2+e_eefhnJDR4s73cQA@mail.gmail.com>
In-Reply-To: <CA+EHjTwQRUCjvcMHNe1f0kPBdU=vS+f2+e_eefhnJDR4s73cQA@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 31 Mar 2022 12:22:05 -0700
Message-ID: <CAC_TJveNRaDFcQGo9-eqKa3=1DnuVDs4U+ye795VcJ1ozVkMyg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] KVM: arm64: Unwind and dump nVHE HYP stacktrace
To:     Fuad Tabba <tabba@google.com>, Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 1:52 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
> On Mon, Mar 14, 2022 at 8:06 PM Kalesh Singh <kaleshsingh@google.com> wro=
te:
> >
> > Unwind the stack in EL1, when CONFIG_NVHE_EL2_DEBUG is enabled.
> > This is possible because CONFIG_NVHE_EL2_DEBUG disables the host
> > stage-2 protection on hyp_panic(), allowing the host to access
> > the hypervisor stack pages in EL1.


Hi everyone,

There has been expressed interest in having hypervisor stack unwinding
in production Android builds.

The current design targets NVHE_EL2_DEBUG enabled builds and is not
suitable for production environments, since this config disables host
stage-2 protection on hyp_panic() which breaks security guarantees.
The benefit of this approach is that the stack unwinding can happen at
EL1 and allows us to reuse most of the unwinding logic from the host
kernel unwinder.

Proposal for how this can be done without disabling host stage-2 protection=
:
  - The host allocates a "panic_info" page and shares it with the hyperviso=
r.
  - On hyp_panic(), the hypervisor can unwind and dump its stack
addresses to the shared page.
  - The host can read out this information and symbolize these addresses.

This would allow for getting hyp stack traces in production while
preserving the security model. The downside being that the core
unwinding logic would be duplicated at EL2.

Are there any objections to making this change?

Mark Rutland, I=E2=80=99m interested to hear your thoughts on this?

Thanks,
Kalesh


> >
> > A simple stack overflow test produces the following output:
> >
> > [  580.376051][  T412] kvm: nVHE hyp panic at: ffffffc0116145c4!
> > [  580.378034][  T412] kvm [412]: nVHE HYP call trace:
> > [  580.378591][  T412] kvm [412]:  [<ffffffc011614934>]
> > [  580.378993][  T412] kvm [412]:  [<ffffffc01160fa48>]
> > [  580.379386][  T412] kvm [412]:  [<ffffffc0116145dc>]  // Non-termina=
ting recursive call
> > [  580.379772][  T412] kvm [412]:  [<ffffffc0116145dc>]
> > [  580.380158][  T412] kvm [412]:  [<ffffffc0116145dc>]
> > [  580.380544][  T412] kvm [412]:  [<ffffffc0116145dc>]
> > [  580.380928][  T412] kvm [412]:  [<ffffffc0116145dc>]
> > . . .
> >
> > Since nVHE hyp symbols are not included by kallsyms to avoid issues
> > with aliasing, we fallback to the vmlinux addresses. Symbolizing the
> > addresses is handled in the next patch in this series.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
>
> Thanks,
> /fuad
>
>
>
> > ---
> >
> > Changes in v4:
> >   - Update commit text and struct kvm_nvhe_panic_info kernel-doc commen=
t
> >     to clarify that CONFIG_NVHE_EL2_DEBUG only disables the host stage-=
2
> >     protection on hyp_panic(), per Fuad
> >   - Update NVHE_EL2_DEBUG Kconfig description to clarify that the
> >     hypervisor stack trace is printed when hyp_panic() is called, per F=
uad
> >
> > Changes in v3:
> >   - The nvhe hyp stack unwinder now makes use of the core logic from th=
e
> >     regular kernel unwinder to avoid duplication, per Mark
> >
> > Changes in v2:
> >   - Add cpu_prepare_nvhe_panic_info()
> >   - Move updating the panic info to hyp_panic(), so that unwinding also
> >     works for conventional nVHE Hyp-mode.
> >
> >
> >  arch/arm64/include/asm/kvm_asm.h    |  20 +++
> >  arch/arm64/include/asm/stacktrace.h |  12 ++
> >  arch/arm64/kernel/stacktrace.c      | 210 +++++++++++++++++++++++++---
> >  arch/arm64/kvm/Kconfig              |   5 +-
> >  arch/arm64/kvm/arm.c                |   2 +-
> >  arch/arm64/kvm/handle_exit.c        |   3 +
> >  arch/arm64/kvm/hyp/nvhe/switch.c    |  18 +++
> >  7 files changed, 244 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/=
kvm_asm.h
> > index 2e277f2ed671..4abcf93c6662 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -176,6 +176,26 @@ struct kvm_nvhe_init_params {
> >         unsigned long vtcr;
> >  };
> >
> > +#ifdef CONFIG_NVHE_EL2_DEBUG
> > +/**
> > + * struct kvm_nvhe_panic_info - nVHE hypervisor panic info.
> > + * @hyp_stack_base:             hyp VA of the hyp_stack base.
> > + * @hyp_overflow_stack_base:    hyp VA of the hyp_overflow_stack base.
> > + * @fp:                         hyp FP where the backtrace begins.
> > + * @pc:                         hyp PC where the backtrace begins.
> > + *
> > + * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
> > + * hyp_panic. This is possible because CONFIG_NVHE_EL2_DEBUG disables
> > + * the host stage 2 protection on hyp_panic(). See: __hyp_do_panic()
> > + */
> > +struct kvm_nvhe_panic_info {
> > +       unsigned long hyp_stack_base;
> > +       unsigned long hyp_overflow_stack_base;
> > +       unsigned long fp;
> > +       unsigned long pc;
> > +};
> > +#endif /* CONFIG_NVHE_EL2_DEBUG */
> > +
> >  /* Translate a kernel address @ptr into its equivalent linear mapping =
*/
> >  #define kvm_ksym_ref(ptr)                                             =
 \
> >         ({                                                             =
 \
> > diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/a=
sm/stacktrace.h
> > index e77cdef9ca29..18611a51cf14 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -22,6 +22,10 @@ enum stack_type {
> >         STACK_TYPE_OVERFLOW,
> >         STACK_TYPE_SDEI_NORMAL,
> >         STACK_TYPE_SDEI_CRITICAL,
> > +#ifdef CONFIG_NVHE_EL2_DEBUG
> > +       STACK_TYPE_KVM_NVHE_HYP,
> > +       STACK_TYPE_KVM_NVHE_OVERFLOW,
> > +#endif /* CONFIG_NVHE_EL2_DEBUG */
> >         __NR_STACK_TYPES
> >  };
> >
> > @@ -147,4 +151,12 @@ static inline bool on_accessible_stack(const struc=
t task_struct *tsk,
> >         return false;
> >  }
> >
> > +#ifdef CONFIG_NVHE_EL2_DEBUG
> > +void kvm_nvhe_dump_backtrace(unsigned long hyp_offset);
> > +#else
> > +static inline void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
> > +{
> > +}
> > +#endif /* CONFIG_NVHE_EL2_DEBUG */
> > +
> >  #endif /* __ASM_STACKTRACE_H */
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktr=
ace.c
> > index e4103e085681..6ec85cb69b1f 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -15,6 +15,8 @@
> >
> >  #include <asm/irq.h>
> >  #include <asm/pointer_auth.h>
> > +#include <asm/kvm_asm.h>
> > +#include <asm/kvm_hyp.h>
> >  #include <asm/stack_pointer.h>
> >  #include <asm/stacktrace.h>
> >
> > @@ -64,26 +66,15 @@ NOKPROBE_SYMBOL(start_backtrace);
> >   * records (e.g. a cycle), determined based on the location and fp val=
ue of A
> >   * and the location (but not the fp value) of B.
> >   */
> > -static int notrace unwind_frame(struct task_struct *tsk,
> > -                               struct stackframe *frame)
> > +static int notrace __unwind_frame(struct stackframe *frame, struct sta=
ck_info *info,
> > +               unsigned long (*translate_fp)(unsigned long, enum stack=
_type))
> >  {
> >         unsigned long fp =3D frame->fp;
> > -       struct stack_info info;
> > -
> > -       if (!tsk)
> > -               tsk =3D current;
> > -
> > -       /* Final frame; nothing to unwind */
> > -       if (fp =3D=3D (unsigned long)task_pt_regs(tsk)->stackframe)
> > -               return -ENOENT;
> >
> >         if (fp & 0x7)
> >                 return -EINVAL;
> >
> > -       if (!on_accessible_stack(tsk, fp, 16, &info))
> > -               return -EINVAL;
> > -
> > -       if (test_bit(info.type, frame->stacks_done))
> > +       if (test_bit(info->type, frame->stacks_done))
> >                 return -EINVAL;
> >
> >         /*
> > @@ -94,28 +85,62 @@ static int notrace unwind_frame(struct task_struct =
*tsk,
> >          *
> >          * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
> >          * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
> > +        * KVM_NVHE_HYP -> KVM_NVHE_OVERFLOW
> >          *
> >          * ... but the nesting itself is strict. Once we transition fro=
m one
> >          * stack to another, it's never valid to unwind back to that fi=
rst
> >          * stack.
> >          */
> > -       if (info.type =3D=3D frame->prev_type) {
> > +       if (info->type =3D=3D frame->prev_type) {
> >                 if (fp <=3D frame->prev_fp)
> >                         return -EINVAL;
> >         } else {
> >                 set_bit(frame->prev_type, frame->stacks_done);
> >         }
> >
> > +       /* Record fp as prev_fp before attempting to get the next fp */
> > +       frame->prev_fp =3D fp;
> > +
> > +       /*
> > +        * If fp is not from the current address space perform the
> > +        * necessary translation before dereferencing it to get next fp=
.
> > +        */
> > +       if (translate_fp)
> > +               fp =3D translate_fp(fp, info->type);
> > +       if (!fp)
> > +               return -EINVAL;
> > +
> >         /*
> >          * Record this frame record's values and location. The prev_fp =
and
> > -        * prev_type are only meaningful to the next unwind_frame() inv=
ocation.
> > +        * prev_type are only meaningful to the next __unwind_frame() i=
nvocation.
> >          */
> >         frame->fp =3D READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> >         frame->pc =3D READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> > -       frame->prev_fp =3D fp;
> > -       frame->prev_type =3D info.type;
> > -
> >         frame->pc =3D ptrauth_strip_insn_pac(frame->pc);
> > +       frame->prev_type =3D info->type;
> > +
> > +       return 0;
> > +}
> > +
> > +static int notrace unwind_frame(struct task_struct *tsk, struct stackf=
rame *frame)
> > +{
> > +       unsigned long fp =3D frame->fp;
> > +       struct stack_info info;
> > +       int err;
> > +
> > +       if (!tsk)
> > +               tsk =3D current;
> > +
> > +       /* Final frame; nothing to unwind */
> > +       if (fp =3D=3D (unsigned long)task_pt_regs(tsk)->stackframe)
> > +               return -ENOENT;
> > +
> > +       if (!on_accessible_stack(tsk, fp, 16, &info))
> > +               return -EINVAL;
> > +
> > +       err =3D __unwind_frame(frame, &info, NULL);
> > +       if (err)
> > +               return err;
> >
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >         if (tsk->ret_stack &&
> > @@ -143,20 +168,27 @@ static int notrace unwind_frame(struct task_struc=
t *tsk,
> >  }
> >  NOKPROBE_SYMBOL(unwind_frame);
> >
> > -static void notrace walk_stackframe(struct task_struct *tsk,
> > -                                   struct stackframe *frame,
> > -                                   bool (*fn)(void *, unsigned long), =
void *data)
> > +static void notrace __walk_stackframe(struct task_struct *tsk, struct =
stackframe *frame,
> > +               bool (*fn)(void *, unsigned long), void *data,
> > +               int (*unwind_frame_fn)(struct task_struct *tsk, struct =
stackframe *frame))
> >  {
> >         while (1) {
> >                 int ret;
> >
> >                 if (!fn(data, frame->pc))
> >                         break;
> > -               ret =3D unwind_frame(tsk, frame);
> > +               ret =3D unwind_frame_fn(tsk, frame);
> >                 if (ret < 0)
> >                         break;
> >         }
> >  }
> > +
> > +static void notrace walk_stackframe(struct task_struct *tsk,
> > +                                   struct stackframe *frame,
> > +                                   bool (*fn)(void *, unsigned long), =
void *data)
> > +{
> > +       __walk_stackframe(tsk, frame, fn, data, unwind_frame);
> > +}
> >  NOKPROBE_SYMBOL(walk_stackframe);
> >
> >  static bool dump_backtrace_entry(void *arg, unsigned long where)
> > @@ -210,3 +242,135 @@ noinline notrace void arch_stack_walk(stack_trace=
_consume_fn consume_entry,
> >
> >         walk_stackframe(task, &frame, consume_entry, cookie);
> >  }
> > +
> > +#ifdef CONFIG_NVHE_EL2_DEBUG
> > +DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> > +DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_o=
verflow_stack);
> > +DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
> > +
> > +static inline bool kvm_nvhe_on_overflow_stack(unsigned long sp, unsign=
ed long size,
> > +                                struct stack_info *info)
> > +{
> > +       struct kvm_nvhe_panic_info *panic_info =3D this_cpu_ptr_nvhe_sy=
m(kvm_panic_info);
> > +       unsigned long low =3D (unsigned long)panic_info->hyp_overflow_s=
tack_base;
> > +       unsigned long high =3D low + PAGE_SIZE;
> > +
> > +       return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_OVERFL=
OW, info);
> > +}
> > +
> > +static inline bool kvm_nvhe_on_hyp_stack(unsigned long sp, unsigned lo=
ng size,
> > +                                struct stack_info *info)
> > +{
> > +       struct kvm_nvhe_panic_info *panic_info =3D this_cpu_ptr_nvhe_sy=
m(kvm_panic_info);
> > +       unsigned long low =3D (unsigned long)panic_info->hyp_stack_base=
;
> > +       unsigned long high =3D low + PAGE_SIZE;
> > +
> > +       return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_HYP, i=
nfo);
> > +}
> > +
> > +static inline bool kvm_nvhe_on_accessible_stack(unsigned long sp, unsi=
gned long size,
> > +                                      struct stack_info *info)
> > +{
> > +       if (info)
> > +               info->type =3D STACK_TYPE_UNKNOWN;
> > +
> > +       if (kvm_nvhe_on_hyp_stack(sp, size, info))
> > +               return true;
> > +       if (kvm_nvhe_on_overflow_stack(sp, size, info))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> > +static unsigned long kvm_nvhe_hyp_stack_kern_va(unsigned long addr)
> > +{
> > +       struct kvm_nvhe_panic_info *panic_info =3D this_cpu_ptr_nvhe_sy=
m(kvm_panic_info);
> > +       unsigned long hyp_base, kern_base, hyp_offset;
> > +
> > +       hyp_base =3D (unsigned long)panic_info->hyp_stack_base;
> > +       hyp_offset =3D addr - hyp_base;
> > +
> > +       kern_base =3D (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_p=
age);
> > +
> > +       return kern_base + hyp_offset;
> > +}
> > +
> > +static unsigned long kvm_nvhe_overflow_stack_kern_va(unsigned long add=
r)
> > +{
> > +       struct kvm_nvhe_panic_info *panic_info =3D this_cpu_ptr_nvhe_sy=
m(kvm_panic_info);
> > +       unsigned long hyp_base, kern_base, hyp_offset;
> > +
> > +       hyp_base =3D (unsigned long)panic_info->hyp_overflow_stack_base=
;
> > +       hyp_offset =3D addr - hyp_base;
> > +
> > +       kern_base =3D (unsigned long)this_cpu_ptr_nvhe_sym(hyp_overflow=
_stack);
> > +
> > +       return kern_base + hyp_offset;
> > +}
> > +
> > +/*
> > + * Convert KVM nVHE hypervisor stack VA to a kernel VA.
> > + *
> > + * The nVHE hypervisor stack is mapped in the flexible 'private' VA ra=
nge, to allow
> > + * for guard pages below the stack. Consequently, the fixed offset add=
ress
> > + * translation macros won't work here.
> > + *
> > + * The kernel VA is calculated as an offset from the kernel VA of the =
hypervisor
> > + * stack base. See: kvm_nvhe_hyp_stack_kern_va(),  kvm_nvhe_overflow_s=
tack_kern_va()
> > + */
> > +static unsigned long kvm_nvhe_stack_kern_va(unsigned long addr,
> > +                                       enum stack_type type)
> > +{
> > +       switch (type) {
> > +       case STACK_TYPE_KVM_NVHE_HYP:
> > +               return kvm_nvhe_hyp_stack_kern_va(addr);
> > +       case STACK_TYPE_KVM_NVHE_OVERFLOW:
> > +               return kvm_nvhe_overflow_stack_kern_va(addr);
> > +       default:
> > +               return 0UL;
> > +       }
> > +}
> > +
> > +static int notrace kvm_nvhe_unwind_frame(struct task_struct *tsk,
> > +                                       struct stackframe *frame)
> > +{
> > +       struct stack_info info;
> > +
> > +       if (!kvm_nvhe_on_accessible_stack(frame->fp, 16, &info))
> > +               return -EINVAL;
> > +
> > +       return  __unwind_frame(frame, &info, kvm_nvhe_stack_kern_va);
> > +}
> > +
> > +static bool kvm_nvhe_dump_backtrace_entry(void *arg, unsigned long whe=
re)
> > +{
> > +       unsigned long va_mask =3D GENMASK_ULL(vabits_actual - 1, 0);
> > +       unsigned long hyp_offset =3D (unsigned long)arg;
> > +
> > +       where &=3D va_mask;       /* Mask tags */
> > +       where +=3D hyp_offset;    /* Convert to kern addr */
> > +
> > +       kvm_err("[<%016lx>] %pB\n", where, (void *)where);
> > +
> > +       return true;
> > +}
> > +
> > +static void notrace kvm_nvhe_walk_stackframe(struct task_struct *tsk,
> > +                                   struct stackframe *frame,
> > +                                   bool (*fn)(void *, unsigned long), =
void *data)
> > +{
> > +       __walk_stackframe(tsk, frame, fn, data, kvm_nvhe_unwind_frame);
> > +}
> > +
> > +void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
> > +{
> > +       struct kvm_nvhe_panic_info *panic_info =3D this_cpu_ptr_nvhe_sy=
m(kvm_panic_info);
> > +       struct stackframe frame;
> > +
> > +       start_backtrace(&frame, panic_info->fp, panic_info->pc);
> > +       pr_err("nVHE HYP call trace:\n");
> > +       kvm_nvhe_walk_stackframe(NULL, &frame, kvm_nvhe_dump_backtrace_=
entry,
> > +                                       (void *)hyp_offset);
> > +       pr_err("---- end of nVHE HYP call trace ----\n");
> > +}
> > +#endif /* CONFIG_NVHE_EL2_DEBUG */
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 8a5fbbf084df..a7be4ef35fbf 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -51,8 +51,9 @@ config NVHE_EL2_DEBUG
> >         depends on KVM
> >         help
> >           Say Y here to enable the debug mode for the non-VHE KVM EL2 o=
bject.
> > -         Failure reports will BUG() in the hypervisor. This is intende=
d for
> > -         local EL2 hypervisor development.
> > +         Failure reports will BUG() in the hypervisor; and calls to hy=
p_panic()
> > +         will result in printing the hypervisor call stack.
> > +         This is intended for local EL2 hypervisor development.
> >
> >           If unsure, say N.
> >
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 72be7e695d8d..c7216ce1d55c 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialize=
d);
> >
> >  DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
> >
> > -static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> > +DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> >  unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
> >  DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params)=
;
> >
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.=
c
> > index e3140abd2e2e..ff69dff33700 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -17,6 +17,7 @@
> >  #include <asm/kvm_emulate.h>
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/debug-monitors.h>
> > +#include <asm/stacktrace.h>
> >  #include <asm/traps.h>
> >
> >  #include <kvm/arm_hypercalls.h>
> > @@ -326,6 +327,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 e=
sr, u64 spsr,
> >                 kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp=
_offset);
> >         }
> >
> > +       kvm_nvhe_dump_backtrace(hyp_offset);
> > +
> >         /*
> >          * Hyp has panicked and we're going to handle that by panicking=
 the
> >          * kernel. The kernel offset will be revealed in the panic so w=
e're
> > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe=
/switch.c
> > index efc20273a352..b8ecffc47424 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > @@ -37,6 +37,22 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
> >  #ifdef CONFIG_NVHE_EL2_DEBUG
> >  DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_st=
ack)
> >         __aligned(16);
> > +DEFINE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
> > +
> > +static inline void cpu_prepare_nvhe_panic_info(void)
> > +{
> > +       struct kvm_nvhe_panic_info *panic_info =3D this_cpu_ptr(&kvm_pa=
nic_info);
> > +       struct kvm_nvhe_init_params *params =3D this_cpu_ptr(&kvm_init_=
params);
> > +
> > +       panic_info->hyp_stack_base =3D (unsigned long)(params->stack_hy=
p_va - PAGE_SIZE);
> > +       panic_info->hyp_overflow_stack_base =3D (unsigned long)this_cpu=
_ptr(hyp_overflow_stack);
> > +       panic_info->fp =3D (unsigned long)__builtin_frame_address(0);
> > +       panic_info->pc =3D _THIS_IP_;
> > +}
> > + #else
> > +static inline void cpu_prepare_nvhe_panic_info(void)
> > +{
> > +}
> >  #endif
> >
> >  static void __activate_traps(struct kvm_vcpu *vcpu)
> > @@ -360,6 +376,8 @@ asmlinkage void __noreturn hyp_panic(void)
> >         struct kvm_cpu_context *host_ctxt;
> >         struct kvm_vcpu *vcpu;
> >
> > +       cpu_prepare_nvhe_panic_info();
> > +
> >         host_ctxt =3D &this_cpu_ptr(&kvm_host_data)->host_ctxt;
> >         vcpu =3D host_ctxt->__hyp_running_vcpu;
> >
> > --
> > 2.35.1.723.g4982287a31-goog
> >
