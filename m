Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071F24A6507
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiBAT2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiBAT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:28:04 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7973AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:28:04 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id bi36so7943825vkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJL5UhCYMJmx1pFTGrnqwQ1k/3weq8fpqF3eWI9gm3A=;
        b=GnT98Hmbt7HXksyxzW5qrAfPVlHa8MKInVY0Gz45quwHa3oj8rga9oACpe0khKj0ek
         H1X1X1G4IOAHnGkHSxxLK9Nen6IBD+ONi3stPCinwzTTI2biQnlPfZ/FBCH4wu1mXuZE
         ulZ8klImGRe26RIKc9PrCv+QbvUli/AfL+EzgDnJNd5U5KQfTcZmKIuTKErtlja8qwql
         uJVTwlOeKzk7ZhmRF/lEN+UeaOgAAXpU4XYsXlJGllWCXggdtfCD2A7zzzIaVrUFNryf
         2CjydciXlP08uZoI6Nxk3T+j33T+nJ5neQsKnbZhjxzrF/ROl6tffn/tSjQZkH9ZrZHs
         e/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJL5UhCYMJmx1pFTGrnqwQ1k/3weq8fpqF3eWI9gm3A=;
        b=t4eoyP+DAfRn+v416pu6HMcCTUpMkyTCh97fdztm2hPLCQ39VUvahFENKlm4YqOU4b
         Q6rnZUjD0p1zx6BeSariOZraWKVM39pWiJN1Vi7NZr48oW01t9ExR7kvcqVikZ32JQxP
         EfOGmkNRyErtsy2D6idrss4KEEc9OKCHhu1R/qVzWcdeaucSpgd6jg+aM8+k9ye9UoRb
         eRgPUjfATmucDLPtTbJK8INLzSEMzhGUK6ngbZg/ZZsnOEG/6KEiiNN4S22KOVNzE9Xl
         8U11ViyIoGFmSF+CMQiMIG7fe+J7PrKjCBU0YSYA5cQKbXFH/OQ2ZHJlHkfT+Kf8ieIe
         Ryug==
X-Gm-Message-State: AOAM531YnkZs4ylr579DF2YXyPKpxjGsbUM6izwk6IuRi7iGJIFfB80b
        wP/s20fj/YTIFEO88q+N4aNma4Z+qmkB2oxbbkexiQ==
X-Google-Smtp-Source: ABdhPJzdcuAFf229DNhyi7CxKph53ikMqzcCkUMKf+esjt65Hdw6kp5bQQk08yDDY9qm176rzmEfV8RRp8cKHRojOgg=
X-Received: by 2002:a05:6122:4f3:: with SMTP id s19mr10764299vkf.32.1643743683569;
 Tue, 01 Feb 2022 11:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20220201143425.19907-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20220201143425.19907-1-mathieu.desnoyers@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 1 Feb 2022 11:28:01 -0800
Message-ID: <CAFTs51XUwhPJ9BzygJPD0pWFEEwu6hSnO7r=-i8B8R6x0oK6CA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] rseq: extend struct rseq with numa node id
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, Feb 1, 2022 at 6:34 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Adding the NUMA node id to struct rseq is a straightforward thing to do,
> and a good way to figure out if anything in the user-space ecosystem
> prevents extending struct rseq.
>
> This NUMA node id field allows memory allocators such as tcmalloc to
> take advantage of fast access to the current NUMA node id to perform
> NUMA-aware memory allocation.
>
> It can also be useful for implementing fast-paths for NUMA-aware
> user-space mutexes.
>
> It also allows implementing getcpu(2) purely in user-space.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/sched.h       |  4 ++
>  include/trace/events/rseq.h |  4 +-
>  include/uapi/linux/rseq.h   | 24 +++++++++++
>  kernel/ptrace.c             |  2 +-
>  kernel/rseq.c               | 82 ++++++++++++++++++++++++++-----------
>  5 files changed, 89 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 508b91d57470..838c9e0b4cae 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1291,6 +1291,7 @@ struct task_struct {
>
>  #ifdef CONFIG_RSEQ
>         struct rseq __user *rseq;
> +       u32 rseq_len;
>         u32 rseq_sig;
>         /*
>          * RmW on rseq_event_mask must be performed atomically
> @@ -2260,10 +2261,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>  {
>         if (clone_flags & CLONE_VM) {
>                 t->rseq = NULL;
> +               t->rseq_len = 0;
>                 t->rseq_sig = 0;
>                 t->rseq_event_mask = 0;
>         } else {
>                 t->rseq = current->rseq;
> +               t->rseq_len = current->rseq_len;
>                 t->rseq_sig = current->rseq_sig;
>                 t->rseq_event_mask = current->rseq_event_mask;
>         }
> @@ -2272,6 +2275,7 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>  static inline void rseq_execve(struct task_struct *t)
>  {
>         t->rseq = NULL;
> +       t->rseq_len = 0;
>         t->rseq_sig = 0;
>         t->rseq_event_mask = 0;
>  }
> diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
> index a04a64bc1a00..6bd442697354 100644
> --- a/include/trace/events/rseq.h
> +++ b/include/trace/events/rseq.h
> @@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
>
>         TP_STRUCT__entry(
>                 __field(s32, cpu_id)
> +               __field(s32, node_id)
>         ),
>
>         TP_fast_assign(
>                 __entry->cpu_id = raw_smp_processor_id();
> +               __entry->node_id = cpu_to_node(raw_smp_processor_id());
>         ),
>
> -       TP_printk("cpu_id=%d", __entry->cpu_id)
> +       TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
>  );
>
>  TRACE_EVENT(rseq_ip_fixup,
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index 77ee207623a9..386c25b5bbdb 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -130,6 +130,30 @@ struct rseq {
>          *     this thread.
>          */
>         __u32 flags;
> +
> +       __u32 padding1[3];

I don't fully understand why this padding is needed here. The comment
below sounds like there was something in "the original rseq API", but
was later removed, as this patch clearly adds padding after flags, but
even the first rseq patch had 'flags' as the last field in struct
rseq...

Also have you considered adding an explicit 'version' field, or
something more sophisticated than 'len'? I remember about a year ago
you had an rfc patch(set) addressing rseq versioning, but I don't
think it got merged? You had some concerns about using 'len' then...

> +
> +       /*
> +        * This is the end of the original rseq ABI.
> +        * This is a valid end of rseq ABI for the purpose of rseq registration
> +        * rseq_len.
> +        * The original rseq ABI use "sizeof(struct rseq)" on registration,
> +        * thus requiring the padding above.
> +        */
> +
> +       /*
> +        * Restartable sequences node_id field. Updated by the kernel. Read by
> +        * user-space with single-copy atomicity semantics. This field should
> +        * only be read by the thread which registered this data structure.
> +        * Aligned on 32-bit. Contains the current NUMA node ID.
> +        */
> +       __u32 node_id;
> +
> +       /*
> +        * This is a valid end of rseq ABI for the purpose of rseq registration
> +        * rseq_len. Use the offset immediately after the node_id field as
> +        * rseq_len.
> +        */
>  } __attribute__((aligned(4 * sizeof(__u64))));
>
>  #endif /* _UAPI_LINUX_RSEQ_H */
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index eea265082e97..f5edde5b7805 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -800,7 +800,7 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
>  {
>         struct ptrace_rseq_configuration conf = {
>                 .rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> -               .rseq_abi_size = sizeof(*task->rseq),
> +               .rseq_abi_size = task->rseq_len,
>                 .signature = task->rseq_sig,
>                 .flags = 0,
>         };
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 97ac20b4f738..13f6d0419f31 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -81,15 +81,25 @@
>   *   F1. <failure>
>   */
>
> -static int rseq_update_cpu_id(struct task_struct *t)
> +static int rseq_update_cpu_node_id(struct task_struct *t)
>  {
> -       u32 cpu_id = raw_smp_processor_id();
>         struct rseq __user *rseq = t->rseq;
> +       u32 cpu_id = raw_smp_processor_id();
> +       u32 node_id = cpu_to_node(cpu_id);
>
> -       if (!user_write_access_begin(rseq, sizeof(*rseq)))
> +       if (!user_write_access_begin(rseq, t->rseq_len))
>                 goto efault;
> -       unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
> -       unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
> +       switch (t->rseq_len) {
> +       case offsetofend(struct rseq, node_id):
> +               unsafe_put_user(node_id, &rseq->node_id, efault_end);
> +               fallthrough;
> +       case offsetofend(struct rseq, padding1):
> +               unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
> +               unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
> +               break;
> +       default:
> +               goto efault_end;
> +       }
>         user_write_access_end();
>         trace_rseq_update(t);
>         return 0;
> @@ -100,22 +110,35 @@ static int rseq_update_cpu_id(struct task_struct *t)
>         return -EFAULT;
>  }
>
> -static int rseq_reset_rseq_cpu_id(struct task_struct *t)
> +static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
>  {
> -       u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
> +       u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
>
> -       /*
> -        * Reset cpu_id_start to its initial state (0).
> -        */
> -       if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
> -               return -EFAULT;
> -       /*
> -        * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
> -        * in after unregistration can figure out that rseq needs to be
> -        * registered again.
> -        */
> -       if (put_user(cpu_id, &t->rseq->cpu_id))
> -               return -EFAULT;
> +       switch (t->rseq_len) {
> +       case offsetofend(struct rseq, node_id):
> +               /*
> +                * Reset node_id to its initial state (0).
> +                */
> +               if (put_user(node_id, &t->rseq->node_id))
> +                       return -EFAULT;
> +               fallthrough;
> +       case offsetofend(struct rseq, padding1):
> +               /*
> +                * Reset cpu_id_start to its initial state (0).
> +                */
> +               if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
> +                       return -EFAULT;
> +               /*
> +                * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user
> +                * coming in after unregistration can figure out that rseq
> +                * needs to be registered again.
> +                */
> +               if (put_user(cpu_id, &t->rseq->cpu_id))
> +                       return -EFAULT;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>         return 0;
>  }
>
> @@ -293,7 +316,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>                 if (unlikely(ret < 0))
>                         goto error;
>         }
> -       if (unlikely(rseq_update_cpu_id(t)))
> +       if (unlikely(rseq_update_cpu_node_id(t)))
>                 goto error;
>         return;
>
> @@ -336,15 +359,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>                 /* Unregister rseq for current thread. */
>                 if (current->rseq != rseq || !current->rseq)
>                         return -EINVAL;
> -               if (rseq_len != sizeof(*rseq))
> +               if (rseq_len != current->rseq_len)
>                         return -EINVAL;
>                 if (current->rseq_sig != sig)
>                         return -EPERM;
> -               ret = rseq_reset_rseq_cpu_id(current);
> +               ret = rseq_reset_rseq_cpu_node_id(current);
>                 if (ret)
>                         return ret;
>                 current->rseq = NULL;
>                 current->rseq_sig = 0;
> +               current->rseq_len = 0;
>                 return 0;
>         }
>
> @@ -357,7 +381,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>                  * the provided address differs from the prior
>                  * one.
>                  */
> -               if (current->rseq != rseq || rseq_len != sizeof(*rseq))
> +               if (current->rseq != rseq || rseq_len != current->rseq_len)
>                         return -EINVAL;
>                 if (current->rseq_sig != sig)
>                         return -EPERM;
> @@ -369,12 +393,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>          * If there was no rseq previously registered,
>          * ensure the provided rseq is properly aligned and valid.
>          */
> -       if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
> -           rseq_len != sizeof(*rseq))
> +       if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)))
>                 return -EINVAL;
> +       switch (rseq_len) {
> +       case offsetofend(struct rseq, node_id):
> +               fallthrough;
> +       case offsetofend(struct rseq, padding1):
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>         if (!access_ok(rseq, rseq_len))
>                 return -EFAULT;
>         current->rseq = rseq;
> +       current->rseq_len = rseq_len;
>         current->rseq_sig = sig;
>         /*
>          * If rseq was previously inactive, and has just been
> --
> 2.17.1
>
