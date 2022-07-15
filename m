Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2E576346
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiGON7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiGON7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:59:24 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15918BEE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:23 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id x9-20020a4ac589000000b004356ccc63efso896854oop.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmN5vZN/krTVYfsavcGk8WwebH0j/DqeS7sGA8C1Ozs=;
        b=KRNVWAsXguRj1fOUfoVYotTEnW7ouSLcXdVbczsjaR7SdtZpWUUK8uGIq4eAzx4BpX
         OD7Zb7h3vjCYGQX5qT5k7UIOrZt0iCPz5czdj1gcWHg/cgoZJnnMnK+avBfLm+UI2DdW
         crPEMsGcBMjTvIlJ5fELIpxnyjBvKkmrQrfVzJNG7BXxniTEwV2aMEmWOOXLE69f6Ch0
         MIewZFs4rihwSYY23mMiwAbaq5Kr21BN/MArPhRwppH0pomPdG7yc0EtU73t7Aq+3O8F
         RNNWlhw7bp2fLgsKDtjSB3cAJtvgIFi9ng4v1Jc9l4t+T3XoG31kDnPV3tRzOhjpGBVA
         KWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmN5vZN/krTVYfsavcGk8WwebH0j/DqeS7sGA8C1Ozs=;
        b=wFBXV/iM5Y/YSU6G1Hq/pe9k+xgsaRPxYVzE1YqH5Mx3Bm5QNBxsdUWi3/wY0cH8Rf
         N6rDAUu7hYkrJa5oH+UF/dzYbPaO4qA+QGSBfRDsCvZbmTMiIBLDatEj6SBuVPOzG7Xa
         CLPKzx49eE6friMf2rIeNF98cXI1WN6Ikrl1kdG9Ui0ag/aVe1AkB0IQR6NYpPvqKxc+
         jjcD4uvTUrNkuNwTVqWZ8aE87ewHWVr2ZQSgRuByu1TZezaQwxpoWNacJQ/D2wm9nne/
         +NOa+kHz2FwoK9OboU7xvvtfhEQiJcUS+pXqhdx5MWskC8FYyX3Z5N4H32WTgOPSHGLR
         XofA==
X-Gm-Message-State: AJIora9wr28XJ9NytNIjDPXT2z72b8lEr77wMaRzVjNyl9/TCMRTjUhq
        d9JISDZkJZi05U2OitOdUta9X9CPDCkQLyVf5uVr+g==
X-Google-Smtp-Source: AGRyM1vUK933GDT5UP0WVhsSmUyvv+YpR9uC9PhV9r55540k2trF66OdFzqqgFRYrbh42arxCWxPrs4MUmMbdQzWVBk=
X-Received: by 2002:a4a:d4ce:0:b0:435:71d5:9bf7 with SMTP id
 r14-20020a4ad4ce000000b0043571d59bf7mr3019637oos.0.1657893562126; Fri, 15 Jul
 2022 06:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-6-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-6-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 15 Jul 2022 14:58:46 +0100
Message-ID: <CA+EHjTwfe761uWSYLf__mcDYaGCSQOvheQy8iwWkSjJ1z=OcFA@mail.gmail.com>
Subject: Re: [PATCH v4 05/18] arm64: stacktrace: Factor out common unwind()
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
> Move unwind() to stacktrace/common.h, and as a result
> the kernel unwind_next() to asm/stacktrace.h. This allow
> reusing unwind() in the implementation of the nVHE HYP
> stack unwinder, later in the series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


>  arch/arm64/include/asm/stacktrace.h        | 51 ++++++++++++++++
>  arch/arm64/include/asm/stacktrace/common.h | 19 ++++++
>  arch/arm64/kernel/stacktrace.c             | 67 ----------------------
>  3 files changed, 70 insertions(+), 67 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index a4f8b84fb459..4fa07f0f913d 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -11,6 +11,7 @@
>  #include <linux/llist.h>
>
>  #include <asm/memory.h>
> +#include <asm/pointer_auth.h>
>  #include <asm/ptrace.h>
>  #include <asm/sdei.h>
>
> @@ -78,4 +79,54 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>
>         return false;
>  }
> +
> +/*
> + * Unwind from one frame record (A) to the next frame record (B).
> + *
> + * We terminate early if the location of B indicates a malformed chain of frame
> + * records (e.g. a cycle), determined based on the location and fp value of A
> + * and the location (but not the fp value) of B.
> + */
> +static inline int notrace unwind_next(struct unwind_state *state)
> +{
> +       struct task_struct *tsk = state->task;
> +       unsigned long fp = state->fp;
> +       struct stack_info info;
> +       int err;
> +
> +       /* Final frame; nothing to unwind */
> +       if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
> +               return -ENOENT;
> +
> +       err = unwind_next_common(state, &info, NULL);
> +       if (err)
> +               return err;
> +
> +       state->pc = ptrauth_strip_insn_pac(state->pc);
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +       if (tsk->ret_stack &&
> +               (state->pc == (unsigned long)return_to_handler)) {
> +               unsigned long orig_pc;
> +               /*
> +                * This is a case where function graph tracer has
> +                * modified a return address (LR) in a stack frame
> +                * to hook a function return.
> +                * So replace it to an original value.
> +                */
> +               orig_pc = ftrace_graph_ret_addr(tsk, NULL, state->pc,
> +                                               (void *)state->fp);
> +               if (WARN_ON_ONCE(state->pc == orig_pc))
> +                       return -EINVAL;
> +               state->pc = orig_pc;
> +       }
> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +#ifdef CONFIG_KRETPROBES
> +       if (is_kretprobe_trampoline(state->pc))
> +               state->pc = kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr_cur);
> +#endif
> +
> +       return 0;
> +}
> +NOKPROBE_SYMBOL(unwind_next);
>  #endif /* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index 5f5d74a286f3..f86efe71479d 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
> +#include <linux/kprobes.h>
>  #include <linux/types.h>
>
>  enum stack_type {
> @@ -69,6 +70,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>                                        unsigned long sp, unsigned long size,
>                                        struct stack_info *info);
>
> +static inline int unwind_next(struct unwind_state *state);
> +
>  static inline bool on_stack(unsigned long sp, unsigned long size,
>                             unsigned long low, unsigned long high,
>                             enum stack_type type, struct stack_info *info)
> @@ -192,4 +195,20 @@ static inline int unwind_next_common(struct unwind_state *state,
>
>         return 0;
>  }
> +
> +static inline void notrace unwind(struct unwind_state *state,
> +                                 stack_trace_consume_fn consume_entry,
> +                                 void *cookie)
> +{
> +       while (1) {
> +               int ret;
> +
> +               if (!consume_entry(cookie, state->pc))
> +                       break;
> +               ret = unwind_next(state);
> +               if (ret < 0)
> +                       break;
> +       }
> +}
> +NOKPROBE_SYMBOL(unwind);
>  #endif /* __ASM_STACKTRACE_COMMON_H */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index eef3cf6bf2d7..9fa60ee48499 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -7,14 +7,12 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/ftrace.h>
> -#include <linux/kprobes.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/stacktrace.h>
>
>  #include <asm/irq.h>
> -#include <asm/pointer_auth.h>
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
>
> @@ -69,71 +67,6 @@ static inline void unwind_init_from_task(struct unwind_state *state,
>         state->pc = thread_saved_pc(task);
>  }
>
> -/*
> - * Unwind from one frame record (A) to the next frame record (B).
> - *
> - * We terminate early if the location of B indicates a malformed chain of frame
> - * records (e.g. a cycle), determined based on the location and fp value of A
> - * and the location (but not the fp value) of B.
> - */
> -static int notrace unwind_next(struct unwind_state *state)
> -{
> -       struct task_struct *tsk = state->task;
> -       unsigned long fp = state->fp;
> -       struct stack_info info;
> -       int err;
> -
> -       /* Final frame; nothing to unwind */
> -       if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
> -               return -ENOENT;
> -
> -       err = unwind_next_common(state, &info, NULL);
> -       if (err)
> -               return err;
> -
> -       state->pc = ptrauth_strip_insn_pac(state->pc);
> -
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -       if (tsk->ret_stack &&
> -               (state->pc == (unsigned long)return_to_handler)) {
> -               unsigned long orig_pc;
> -               /*
> -                * This is a case where function graph tracer has
> -                * modified a return address (LR) in a stack frame
> -                * to hook a function return.
> -                * So replace it to an original value.
> -                */
> -               orig_pc = ftrace_graph_ret_addr(tsk, NULL, state->pc,
> -                                               (void *)state->fp);
> -               if (WARN_ON_ONCE(state->pc == orig_pc))
> -                       return -EINVAL;
> -               state->pc = orig_pc;
> -       }
> -#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> -#ifdef CONFIG_KRETPROBES
> -       if (is_kretprobe_trampoline(state->pc))
> -               state->pc = kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr_cur);
> -#endif
> -
> -       return 0;
> -}
> -NOKPROBE_SYMBOL(unwind_next);
> -
> -static void notrace unwind(struct unwind_state *state,
> -                          stack_trace_consume_fn consume_entry, void *cookie)
> -{
> -       while (1) {
> -               int ret;
> -
> -               if (!consume_entry(cookie, state->pc))
> -                       break;
> -               ret = unwind_next(state);
> -               if (ret < 0)
> -                       break;
> -       }
> -}
> -NOKPROBE_SYMBOL(unwind);
> -
>  static bool dump_backtrace_entry(void *arg, unsigned long where)
>  {
>         char *loglvl = arg;
> --
> 2.37.0.170.g444d1eabd0-goog
>
