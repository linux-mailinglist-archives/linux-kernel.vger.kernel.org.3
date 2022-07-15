Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C9576341
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiGON7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiGON7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:59:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C32AF0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:16 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-fe023ab520so6268695fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcsiyFdNFlbE2rwHs7o7QvxeNqnz8T+pUXB7pzwL5zw=;
        b=HtL3JWOJOghzPqgLPB7YqHgA2lckvHP41fn/FCQZM8i011Y+6JWlkGM9nBv8NJvuya
         I+4qWfkE6/iIRdKoOTEJQ6YpTJYPyfVT4+xw/CWNNl/vAUd1m2YgEI1q4EOP97BaRoRQ
         QyRM1pUwmCrI9FMKqk2ZD5mJFuzkR7MAD2/nQLpMwcz5yR7Y0NjqEiZADEcyN46BHxe7
         PHD+44GBS1HVr+jboVL3Egb7fMAz64mWyw92QlwNCKeIXr43kiIRWxrbrghl8NQcFCJH
         Wdsw+7VIQmesZZcJHDxuZdoBMNQ9zSIozirctEKwX6C7rhLkSHrs2ZSR1XJqxtFeuWyz
         HlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcsiyFdNFlbE2rwHs7o7QvxeNqnz8T+pUXB7pzwL5zw=;
        b=ZJxBS+K6Ao0zbT4rXZ4hdv2+br+mz4fTK+40XjKEXLgSuiGqr8GLtBQw9rU0dsMdkB
         pTYibAW+R1sCvCXnVWaWlRkA6kaJHdltHfBWKv+xGeq30frCC41pTakg1APnS0lFGyvs
         VhvEKwZFgz+smslsnbJqJ0rCciqLG9dKzXUJCPjsI+X1zDYQrj9KlLwsrvqK7V2/NUxN
         dnVfY86r3xju0kngO4tD4xZ3ZYJlQmZw6Z8M8YZvYSN7cUER0k3+NxYS2MotrZN7Wy4n
         5R5XNf4ND4Rh2ckIf879KoPi/+Fi2svuhwFjaxSw0awPN9zZMZIFKNfosRRJu9VE9hZd
         XDRg==
X-Gm-Message-State: AJIora8l+NNyqkJ9D0udvAzdeQnzGyJlYbk9x4vqG5IyLrV/5UL0/Zhi
        piWlAAmNJrUm6CNzlAVGOWYHSJSoROXexmauG9L82w==
X-Google-Smtp-Source: AGRyM1vN9stDDiwyjYZaFj2tqJauPKZ02qkA+d7Xw+uXJrgYM9JMcfdEH00b7lz//bn2BiUohjo1Tz2Dib5qBtar/No=
X-Received: by 2002:a05:6871:890:b0:10b:f3eb:b45d with SMTP id
 r16-20020a056871089000b0010bf3ebb45dmr7916926oaq.294.1657893555927; Fri, 15
 Jul 2022 06:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-4-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-4-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 15 Jul 2022 14:58:40 +0100
Message-ID: <CA+EHjTyDbH=7Bqo61CEadSKRsRHKsSWQcf=kbx5T_Fsj0-bL4g@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] arm64: stacktrace: Factor out unwind_next_common()
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
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

Hi Kalesh,

On Fri, Jul 15, 2022 at 7:11 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Move common unwind_next logic to stacktrace/common.h. This allows
> reusing the code in the implementation the nVHE hypervisor stack
> unwinder, later in this series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>  arch/arm64/include/asm/stacktrace/common.h | 50 ++++++++++++++++++++++
>  arch/arm64/kernel/stacktrace.c             | 41 ++----------------
>  2 files changed, 54 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index f58b786460d3..0c5cbfdb56b5 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -65,6 +65,10 @@ struct unwind_state {
>  static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>                                      struct stack_info *info);
>
> +static inline bool on_accessible_stack(const struct task_struct *tsk,
> +                                      unsigned long sp, unsigned long size,
> +                                      struct stack_info *info);
> +
>  static inline bool on_stack(unsigned long sp, unsigned long size,
>                             unsigned long low, unsigned long high,
>                             enum stack_type type, struct stack_info *info)
> @@ -120,4 +124,50 @@ static inline void unwind_init_common(struct unwind_state *state,
>         state->prev_type = STACK_TYPE_UNKNOWN;
>  }
>
> +static inline int unwind_next_common(struct unwind_state *state,
> +                                    struct stack_info *info)
> +{
> +       struct task_struct *tsk = state->task;
> +       unsigned long fp = state->fp;
> +
> +       if (fp & 0x7)
> +               return -EINVAL;
> +
> +       if (!on_accessible_stack(tsk, fp, 16, info))
> +               return -EINVAL;
> +
> +       if (test_bit(info->type, state->stacks_done))
> +               return -EINVAL;
> +
> +       /*
> +        * As stacks grow downward, any valid record on the same stack must be
> +        * at a strictly higher address than the prior record.
> +        *
> +        * Stacks can nest in several valid orders, e.g.
> +        *
> +        * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
> +        * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
> +        *
> +        * ... but the nesting itself is strict. Once we transition from one
> +        * stack to another, it's never valid to unwind back to that first
> +        * stack.
> +        */
> +       if (info->type == state->prev_type) {
> +               if (fp <= state->prev_fp)
> +                       return -EINVAL;
> +       } else {
> +               __set_bit(state->prev_type, state->stacks_done);
> +       }
> +
> +       /*
> +        * Record this frame record's values and location. The prev_fp and
> +        * prev_type are only meaningful to the next unwind_next() invocation.
> +        */
> +       state->fp = READ_ONCE(*(unsigned long *)(fp));
> +       state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
> +       state->prev_fp = fp;
> +       state->prev_type = info->type;
> +
> +       return 0;
> +}
>  #endif /* __ASM_STACKTRACE_COMMON_H */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 94a5dd2ab8fd..834851939364 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -81,48 +81,15 @@ static int notrace unwind_next(struct unwind_state *state)
>         struct task_struct *tsk = state->task;
>         unsigned long fp = state->fp;
>         struct stack_info info;
> +       int err;
>
>         /* Final frame; nothing to unwind */
>         if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
>                 return -ENOENT;
>
> -       if (fp & 0x7)
> -               return -EINVAL;
> -
> -       if (!on_accessible_stack(tsk, fp, 16, &info))
> -               return -EINVAL;
> -
> -       if (test_bit(info.type, state->stacks_done))
> -               return -EINVAL;
> -
> -       /*
> -        * As stacks grow downward, any valid record on the same stack must be
> -        * at a strictly higher address than the prior record.
> -        *
> -        * Stacks can nest in several valid orders, e.g.
> -        *
> -        * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
> -        * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
> -        *
> -        * ... but the nesting itself is strict. Once we transition from one
> -        * stack to another, it's never valid to unwind back to that first
> -        * stack.
> -        */
> -       if (info.type == state->prev_type) {
> -               if (fp <= state->prev_fp)
> -                       return -EINVAL;
> -       } else {
> -               __set_bit(state->prev_type, state->stacks_done);
> -       }
> -
> -       /*
> -        * Record this frame record's values and location. The prev_fp and
> -        * prev_type are only meaningful to the next unwind_next() invocation.
> -        */
> -       state->fp = READ_ONCE(*(unsigned long *)(fp));
> -       state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
> -       state->prev_fp = fp;
> -       state->prev_type = info.type;
> +       err = unwind_next_common(state, &info);
> +       if (err)
> +               return err;
>
>         state->pc = ptrauth_strip_insn_pac(state->pc);
>
> --
> 2.37.0.170.g444d1eabd0-goog
>
