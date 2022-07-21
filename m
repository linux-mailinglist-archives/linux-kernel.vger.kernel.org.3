Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9A57C84F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiGUJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiGUJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:58:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D915814B0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:03 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u9so1268644oiv.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=922HOs43jADDLlZ+kbLPGVukcElYdtVFtonl3ox1eBk=;
        b=CRL29VsWnaW7UfajvqFr8IUaq+Usy/I1MAzJ/6NSQCCfBdUG2uFpznfU4nF+E5EEL7
         0n520y581CNOOiYMuyTryzcs8aNGl0N8qUVBSqTX3gWU6DA6fixQNkR5SXXRlis03G0I
         t3BQVRclAbElk+f15/597Mp5etOAUMt3zi5Y3+Sy27JzsQfvQKKkZG9QSisOa4HzmWPA
         3UvKdUarhKYnIKRPe/udYK8yFJQPAN4qw8c6cCi1oL4nZRSmicSS8NCqIzdDTxQj/a9t
         CX/uvKWVATWLteU+1WjVk9hie4z0zZfi+vc2UK8oLN4SoBGQPnPgDc0ar5Yd5fW3JN5k
         tPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=922HOs43jADDLlZ+kbLPGVukcElYdtVFtonl3ox1eBk=;
        b=Ph5MJ9uR4U2RoedluZXWI/+3uvs5zk8cESc966HyThaRqES7YG/bxPCeDMslCtvNlF
         WniGpw0k5/TNNN9JbSgorKuOfMbqmPUKB6c8+QRoXAGLHU3sHZTdBY7YuPXaBqxIlU1r
         C0N3YfWFfjvfXyH4DIV4gDhNO/MJNwZTTm1aqmlTrT6xgkPnnvFvhmAx5ktNKb+ClIC2
         t0LejQm0crljCRMyZAguctJiFCoBetCjVgJWO8i5ksbxh7Lotwfzk5dnBVm1D/KFqMwd
         UPrWrHwyCgoIl+XyNYD2kQfLBB21Uo2IMPiGwZpIA/Kq21r9wQ99WXiYfgd0MyUSctRi
         m3xA==
X-Gm-Message-State: AJIora9d3hQkspcjLiaI5m+ZwJfqRvnw0j9bB6MCEwHWwRuSVp0rhAaW
        tTQ1pgBY99GPpKucE+7aIbxMacKPMWV4C19GHqP0iA==
X-Google-Smtp-Source: AGRyM1tFc8U7bBM5qNf2MkAsegfPZllChk75m7DCjf49ukC0noL9viy/ruQiv6reR8B24k4toofoCb2IVxgRJkTEZ/k=
X-Received: by 2002:a05:6808:1596:b0:337:8c17:b17f with SMTP id
 t22-20020a056808159600b003378c17b17fmr4487728oiw.294.1658397482410; Thu, 21
 Jul 2022 02:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-5-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-5-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:57:26 +0100
Message-ID: <CA+EHjTxJbG754ghqD9WkY0hyk54Ti_eG4irmVbCzKy50DBLvjA@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] arm64: stacktrace: Handle frame pointer from
 different address spaces
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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


On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> The unwinder code is made reusable so that it can be used to
> unwind various types of stacks. One usecase is unwinding the
> nVHE hyp stack from the host (EL1) in non-protected mode. This
> means that the unwinder must be able to translate HYP stack
> addresses to kernel addresses.
>
> Add a callback (stack_trace_translate_fp_fn) to allow specifying
> the translation function.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v5:
>   - Fix typo in commit text, per Fuad
>   - Update unwind_next_common() to not have side effects on failure, per Fuad
>   - Use regular comment instead of doc comments, per Fuad
>
>  arch/arm64/include/asm/stacktrace/common.h | 29 +++++++++++++++++++---
>  arch/arm64/kernel/stacktrace.c             |  2 +-
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index 0c5cbfdb56b5..e89c8c39858d 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -124,11 +124,25 @@ static inline void unwind_init_common(struct unwind_state *state,
>         state->prev_type = STACK_TYPE_UNKNOWN;
>  }
>
> +/*
> + * stack_trace_translate_fp_fn() - Translates a non-kernel frame pointer to
> + * a kernel address.
> + *
> + * @fp:   the frame pointer to be updated to it's kernel address.

nit: it's -> its

Otherwise

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad





> + * @type: the stack type associated with frame pointer @fp
> + *
> + * Returns true and success and @fp is updated to the corresponding
> + * kernel virtual address; otherwise returns false.
> + */
> +typedef bool (*stack_trace_translate_fp_fn)(unsigned long *fp,
> +                                           enum stack_type type);
> +
>  static inline int unwind_next_common(struct unwind_state *state,
> -                                    struct stack_info *info)
> +                                    struct stack_info *info,
> +                                    stack_trace_translate_fp_fn translate_fp)
>  {
> +       unsigned long fp = state->fp, kern_fp = fp;
>         struct task_struct *tsk = state->task;
> -       unsigned long fp = state->fp;
>
>         if (fp & 0x7)
>                 return -EINVAL;
> @@ -139,6 +153,13 @@ static inline int unwind_next_common(struct unwind_state *state,
>         if (test_bit(info->type, state->stacks_done))
>                 return -EINVAL;
>
> +       /*
> +        * If fp is not from the current address space perform the necessary
> +        * translation before dereferencing it to get the next fp.
> +        */
> +       if (translate_fp && !translate_fp(&kern_fp, info->type))
> +               return -EINVAL;
> +
>         /*
>          * As stacks grow downward, any valid record on the same stack must be
>          * at a strictly higher address than the prior record.
> @@ -163,8 +184,8 @@ static inline int unwind_next_common(struct unwind_state *state,
>          * Record this frame record's values and location. The prev_fp and
>          * prev_type are only meaningful to the next unwind_next() invocation.
>          */
> -       state->fp = READ_ONCE(*(unsigned long *)(fp));
> -       state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
> +       state->fp = READ_ONCE(*(unsigned long *)(kern_fp));
> +       state->pc = READ_ONCE(*(unsigned long *)(kern_fp + 8));
>         state->prev_fp = fp;
>         state->prev_type = info->type;
>
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 834851939364..eef3cf6bf2d7 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -87,7 +87,7 @@ static int notrace unwind_next(struct unwind_state *state)
>         if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
>                 return -ENOENT;
>
> -       err = unwind_next_common(state, &info);
> +       err = unwind_next_common(state, &info, NULL);
>         if (err)
>                 return err;
>
> --
> 2.37.0.170.g444d1eabd0-goog
>
