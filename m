Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A665788A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiGRRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiGRRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:41:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA82A437
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:40:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so13666096wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6zRFUSc7F7HFxaprFOAEtGKMO9ydiNTrXQX+TszSTw=;
        b=M0Cq5ahTdulz9bhqxWLFTC+u9GWLgImVHLsNRlrTNqHxU112WB+K1dndgN801NtrUX
         MzGwhtk2OWwnKXS1fNzYcCrGcebFHEtGPBXzMfuciSYKiVYSo7yQbiUsctIrpB78TANc
         hqQ5cG4G6Z8xBd1C+e0FeNvdCz0+/iT9uis13t79+JF0RiQKz1bHMamqgQbq4nCutwLF
         Dgk0OqvNzzISQFYIygpVn+dfSOrj0mwGd3HbOAvNtBa7zzhZya82zHi4c+zZz+bf2mg0
         +Ei3NiYA4ndWh/5VbexRmWSheBEx7OQHaUkYtZxgI9YXyKbXo8SQ43iqk9z6zrL8U0fB
         nAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6zRFUSc7F7HFxaprFOAEtGKMO9ydiNTrXQX+TszSTw=;
        b=8MeX/UiHf6Lm41S0DgejJdkdAM82WEfLgP4rxRM2yy+A4VbH7YMEvCX4FNPmjRvxFc
         FwsjYPCj7SJDyfvMuDVZGv1yYX8BOeQyzvAiCj/1a1Ixn6+nzh3ZsN1yEMcx3NNRhmsB
         G7PoJJkYOYcM3cOL/goh0etbcrjaPOetby7+inuaLEwMLW5DYMocXK/lX5/k36cNA0zs
         e+lWQqk4yz4snuVHNEHnsVu1kxKffOMyfQRcJHss6L0rP8LNv1xfvV4L81janDZSNyEU
         yPOMR/DljOYLEl/mVR0odggoJrSN/4U+1j2bdpNozJf22QzYTgbwiHKm7rtMIM7WAEAT
         NxDA==
X-Gm-Message-State: AJIora/AJcytw8DAd2WqLiPtI8plYfuLb8XRetvWxW39oFGSmPfoMbm9
        tb2CeNPODiKzXtjgDlvVm17+ND8llQtA3ehLDDzIkw==
X-Google-Smtp-Source: AGRyM1s8Gw5XYhQ6PVEJJeZUycw4W2Y1+b9cs5I7IMZBJTfOjjNHGYCqj7LSiCxL8tIS35mXTkF0b5QsnaLPxN0QSAM=
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id
 a8-20020a056000050800b0021d4105caf9mr24395791wrf.699.1658166058039; Mon, 18
 Jul 2022 10:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-5-kaleshsingh@google.com> <CA+EHjTzv9VFnp+6kCw0pMuUxqXtmthujg7ga=Fkexz9jEq29LA@mail.gmail.com>
In-Reply-To: <CA+EHjTzv9VFnp+6kCw0pMuUxqXtmthujg7ga=Fkexz9jEq29LA@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 10:40:47 -0700
Message-ID: <CAC_TJvcNEJerTnnCWpKhEuuzpa6LypW2CLb-zbsCk6Nu59_e=A@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] arm64: stacktrace: Handle frame pointer from
 different address spaces
To:     Fuad Tabba <tabba@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 6:57 AM 'Fuad Tabba' via kernel-team
<kernel-team@android.com> wrote:
>
> Hi Kalesh,
>
> On Fri, Jul 15, 2022 at 7:11 AM 'Kalesh Singh' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > The unwinder code is made reusable so that it can be used to
> > unwind various types of stacks. One usecase is unwinding the
> > nVHE hyp stack from the host (EL1) in non-protected mode. This
> > means that the unwinder must be able to tracnslate HYP stack
>
> s/tracnslate/translate
>
> > addresses to kernel addresses.
> >
> > Add a callback (stack_trace_translate_fp_fn) to allow specifying
> > the translation function.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/stacktrace/common.h | 26 ++++++++++++++++++++--
> >  arch/arm64/kernel/stacktrace.c             |  2 +-
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> > index 0c5cbfdb56b5..5f5d74a286f3 100644
> > --- a/arch/arm64/include/asm/stacktrace/common.h
> > +++ b/arch/arm64/include/asm/stacktrace/common.h
> > @@ -123,9 +123,22 @@ static inline void unwind_init_common(struct unwind_state *state,
> >         state->prev_fp = 0;
> >         state->prev_type = STACK_TYPE_UNKNOWN;
> >  }
> > +/**
> > + * stack_trace_translate_fp_fn() - Translates a non-kernel frame pointer to
> > + * a kernel address.
> > + *
> > + * @fp:   the frame pointer to be updated to it's kernel address.
> > + * @type: the stack type associated with frame pointer @fp
> > + *
> > + * Returns true and success and @fp is updated to the corresponding
> > + * kernel virtual address; otherwise returns false.
> > + */
>
> Please add a newline before the new block.
>
> Also, something which you have done in comment blocks in this patch as
> well as future patches (so I won't mention them again) is use the
> opening comment mark /** , which is meant for kernel-doc comments
> (https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html).
> However, this block, and many if not most of the others don't seem to
> be conformant (scripts/kernel-doc -v -none
> arch/arm64/include/asm/stacktrace/common.h).
>
> I think the easiest thing to do is to format them as a normal block: /*.
>
>
> > +typedef bool (*stack_trace_translate_fp_fn)(unsigned long *fp,
> > +                                           enum stack_type type);
> >
> >  static inline int unwind_next_common(struct unwind_state *state,
> > -                                    struct stack_info *info)
> > +                                    struct stack_info *info,
> > +                                    stack_trace_translate_fp_fn translate_fp)
> >  {
> >         struct task_struct *tsk = state->task;
> >         unsigned long fp = state->fp;
> > @@ -159,13 +172,22 @@ static inline int unwind_next_common(struct unwind_state *state,
> >                 __set_bit(state->prev_type, state->stacks_done);
> >         }
> >
> > +       /* Record fp as prev_fp before attempting to get the next fp */
> > +       state->prev_fp = fp;
> > +
> > +       /*
> > +        * If fp is not from the current address space perform the necessary
> > +        * translation before dereferencing it to get the next fp.
> > +        */
> > +       if (translate_fp && !translate_fp(&fp, info->type))
> > +               return -EINVAL;
> > +
>
> A call to unwind_next_common could fail having updated state->prev_fp
> as well as state->stacks_done. I think that it might be better to
> rework it so that there aren't any side effects should a call fail.

Hi Fuad,

Thanks for the comments. I'll address them in the next version.

--Kalesh

>
> Thanks,
> /fuad
>
>
>
>
>
> >         /*
> >          * Record this frame record's values and location. The prev_fp and
> >          * prev_type are only meaningful to the next unwind_next() invocation.
> >          */
> >         state->fp = READ_ONCE(*(unsigned long *)(fp));
> >         state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
> > -       state->prev_fp = fp;
> >         state->prev_type = info->type;
> >
> >         return 0;
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 834851939364..eef3cf6bf2d7 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -87,7 +87,7 @@ static int notrace unwind_next(struct unwind_state *state)
> >         if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
> >                 return -ENOENT;
> >
> > -       err = unwind_next_common(state, &info);
> > +       err = unwind_next_common(state, &info, NULL);
> >         if (err)
> >                 return err;
> >
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
