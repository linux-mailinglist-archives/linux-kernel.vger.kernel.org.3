Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D39576334
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiGON5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGON5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:57:21 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660D66ADF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:57:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v19-20020a9d69d3000000b0061c78772699so3520388oto.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XHahTg74pR+fkQl0PaxFy6RUNnpsVoD/zCOueSWNd8=;
        b=p0HgT3PGyYvztwjwFj8z7NtqUsPnYsp1YPiFfmRvUtVULL4G7D1ndsRl1PS00SN5Ks
         hQjVLUaVDF8R14z7XHQlO+nxs62MkNjaW3YtFcjdM0bxfQmudN7M3ZJOn2qEQXrm7ktr
         bCE2S/3KNkMgMdasia903BH9il6g57PwJmI4afERGUCRlkj+/w8K+NQkap3trsXZ+M2l
         ehO3RXXas0BQ9JA4hyrp2pChEvjnqVx+vS7cYwIVOu+/3lGjmSR4UQettA0MhEa7qSjT
         yCou3YB5b3kbAH5OX8HYMYjQdn5yTWFxj0o2q2ycr+JvFBxs5jegRVI5V2+DSVwbFFhf
         lRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XHahTg74pR+fkQl0PaxFy6RUNnpsVoD/zCOueSWNd8=;
        b=4MtnPYNFgTHXsj3pDH3Zm2BRqJFpAMkKPv7rswQQtzm0cyk2Oi9nqq1v5BFCk46JIS
         Phjae94ucIN2O53lsKZWWOM/n06Kmeitp3R8Fp7rC8grQO2/f2JE0Ee+Klem0uS2pB1u
         z58GuIqh6hPMlV3NXCj18yUyAkOXAgoRr1+STZ18f6PJGUxOYiLefgqm75r2IHHWgwK6
         ePO1/WWJmHhQ+jerVzYVaF96oa/JX8frs+25dmONEEvfWcn8xoQ1rnv14knZn6YRNv84
         V6vavzzVBgA40JgKzuKETY11mvjT0lI0oVtbfD/lOAZb72Uer1lfWk0MIxX4yZm6oZwE
         wAjg==
X-Gm-Message-State: AJIora9VKTtWloWdpeCQvG+/N8+wVEbuU6DyF+8XQVNIQF+KS4XUl4Io
        oeE7tkKmSdtBnVkBm/We1XaTacGFdgYRhVt899/ZHQ==
X-Google-Smtp-Source: AGRyM1ugZdhz9Xe3Y3Svns/5bQ2HVTfV3rH4NMXhH9+Km8OrNBqqEwuj2Jd9a5eYcmQWqrKgUATY9xPEup6CwisER5Q=
X-Received: by 2002:a9d:5f1a:0:b0:61c:50a1:df3 with SMTP id
 f26-20020a9d5f1a000000b0061c50a10df3mr5414193oti.102.1657893439804; Fri, 15
 Jul 2022 06:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-5-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-5-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 15 Jul 2022 14:56:44 +0100
Message-ID: <CA+EHjTzv9VFnp+6kCw0pMuUxqXtmthujg7ga=Fkexz9jEq29LA@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] arm64: stacktrace: Handle frame pointer from
 different address spaces
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

On Fri, Jul 15, 2022 at 7:11 AM 'Kalesh Singh' via kernel-team
<kernel-team@android.com> wrote:
>
> The unwinder code is made reusable so that it can be used to
> unwind various types of stacks. One usecase is unwinding the
> nVHE hyp stack from the host (EL1) in non-protected mode. This
> means that the unwinder must be able to tracnslate HYP stack

s/tracnslate/translate

> addresses to kernel addresses.
>
> Add a callback (stack_trace_translate_fp_fn) to allow specifying
> the translation function.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/stacktrace/common.h | 26 ++++++++++++++++++++--
>  arch/arm64/kernel/stacktrace.c             |  2 +-
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index 0c5cbfdb56b5..5f5d74a286f3 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -123,9 +123,22 @@ static inline void unwind_init_common(struct unwind_state *state,
>         state->prev_fp = 0;
>         state->prev_type = STACK_TYPE_UNKNOWN;
>  }
> +/**
> + * stack_trace_translate_fp_fn() - Translates a non-kernel frame pointer to
> + * a kernel address.
> + *
> + * @fp:   the frame pointer to be updated to it's kernel address.
> + * @type: the stack type associated with frame pointer @fp
> + *
> + * Returns true and success and @fp is updated to the corresponding
> + * kernel virtual address; otherwise returns false.
> + */

Please add a newline before the new block.

Also, something which you have done in comment blocks in this patch as
well as future patches (so I won't mention them again) is use the
opening comment mark /** , which is meant for kernel-doc comments
(https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html).
However, this block, and many if not most of the others don't seem to
be conformant (scripts/kernel-doc -v -none
arch/arm64/include/asm/stacktrace/common.h).

I think the easiest thing to do is to format them as a normal block: /*.


> +typedef bool (*stack_trace_translate_fp_fn)(unsigned long *fp,
> +                                           enum stack_type type);
>
>  static inline int unwind_next_common(struct unwind_state *state,
> -                                    struct stack_info *info)
> +                                    struct stack_info *info,
> +                                    stack_trace_translate_fp_fn translate_fp)
>  {
>         struct task_struct *tsk = state->task;
>         unsigned long fp = state->fp;
> @@ -159,13 +172,22 @@ static inline int unwind_next_common(struct unwind_state *state,
>                 __set_bit(state->prev_type, state->stacks_done);
>         }
>
> +       /* Record fp as prev_fp before attempting to get the next fp */
> +       state->prev_fp = fp;
> +
> +       /*
> +        * If fp is not from the current address space perform the necessary
> +        * translation before dereferencing it to get the next fp.
> +        */
> +       if (translate_fp && !translate_fp(&fp, info->type))
> +               return -EINVAL;
> +

A call to unwind_next_common could fail having updated state->prev_fp
as well as state->stacks_done. I think that it might be better to
rework it so that there aren't any side effects should a call fail.

Thanks,
/fuad





>         /*
>          * Record this frame record's values and location. The prev_fp and
>          * prev_type are only meaningful to the next unwind_next() invocation.
>          */
>         state->fp = READ_ONCE(*(unsigned long *)(fp));
>         state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
> -       state->prev_fp = fp;
>         state->prev_type = info->type;
>
>         return 0;
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
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
