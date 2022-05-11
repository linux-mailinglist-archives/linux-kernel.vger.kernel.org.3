Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73AF52352F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiEKOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiEKOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:16:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E71A31DDC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:16:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so2123869pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNmriGc3mYEsX/DOKQAZhlgM/5qyiOxj+uNvPOVSX6E=;
        b=dJFk0eZ0YRZTnLaQY6jOuUtHwbWnsVxOeuzVP6OqecX+oubvFaAinlIs5YbU09YtDQ
         +zm/7hD0V3Cbby8YxbsLyCjleI83Mjm/UIKQP2tBVk2E23FZB+qYDJcqrkSlwn+VXa7n
         mHOoE5DzDIdXGqnoo9SQvLzA4yK3F8kBEvsKJeVNEXs3FKbweE/yTSe9la3nRyWp1w0v
         B5RB/dmD+5g/wfC/m3GXDn8l/U7jrFSD3Pb5uu0tNSqL3aGJ2Gd1kcGfDC4pwfsLR+T8
         FqJLuqiawleWUcKK+KEsjGufxRTPgoMkexaMtjAfAHXu0GeXp3EERTWpfTVnJ2kpjolc
         17/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNmriGc3mYEsX/DOKQAZhlgM/5qyiOxj+uNvPOVSX6E=;
        b=qHTcyUnKVPwAaRM4WUoHQNUJXAl951U07yjTLtAnLqfmYQeyzXU7vW9sqGzwle8NLA
         k256w+uJ8TxLAW2OjCMJuRSf6cMWMG6GcWcCi800ZWGdxL6aUoY+VH4iE9StMil7VKHS
         B8kWDUapCR3qCCDrWYdZT4wJJCCEoNI5vaF/nnyKCVjZq7KxkZl6EGD9nFyQGtp/DLdV
         MhaKSxNJc3d9oOQ5e4Oqub3vh3nD61FibRv4GqsBrxhC7OHQ67Jai7Of+ussCOKSrJMA
         f0M1dQysV4ACkTD2yzIFrP54AbAbeJCG985iHj0rw5CLk/mKN0OkWazJcuKUsmZjiEiJ
         6Ohg==
X-Gm-Message-State: AOAM533bMTxK7RCFc+FnKfa/zllqfiDpyPWFLEzLXKELWDcL2aCS7Van
        imIr2oWDfo+oRI0KxG70PeD/4f4Yy0CDhoNkpBU=
X-Google-Smtp-Source: ABdhPJy5GiguOmBUZS164NG7dKfYOQwgvEJAkKP8cY/F7QDfFx598+BlP8GAz5oXzXpophcgAL+CyVjsqV8IU4vvU0w=
X-Received: by 2002:a63:2114:0:b0:3c4:995c:344a with SMTP id
 h20-20020a632114000000b003c4995c344amr21014534pgh.125.1652278580673; Wed, 11
 May 2022 07:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com> <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 11 May 2022 07:15:44 -0700
Message-ID: <CAMe9rOpOKsKZfUpj7dXawv56N5a+x24LQhkhRXwH31GQt5S4=Q@mail.gmail.com>
Subject: Re: [RFCv2 09/10] x86/mm: Add userspace API to enable Linear Address Masking
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 7:29 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Allow to enable Linear Address Masking via ARCH_THREAD_FEATURE_ENABLE
> arch_prctl(2).
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/process.c    | 21 +++++++++++++++-
>  arch/x86/kernel/process.h    |  2 ++
>  arch/x86/kernel/process_64.c | 46 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index cb8fc28f2eae..911c24321312 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -46,6 +46,8 @@
>  #include <asm/proto.h>
>  #include <asm/frame.h>
>  #include <asm/unwind.h>
> +#include <asm/mmu_context.h>
> +#include <asm/compat.h>
>
>  #include "process.h"
>
> @@ -992,7 +994,9 @@ unsigned long __get_wchan(struct task_struct *p)
>  static long thread_feature_prctl(struct task_struct *task, int option,
>                                  unsigned long features)

Since this arch_prctl will also be used for CET,  which supports
32-bit processes,
shouldn't int, instead of long, be used?

>  {
> -       const unsigned long known_features = 0;
> +       const unsigned long known_features =
> +               X86_THREAD_LAM_U48 |
> +               X86_THREAD_LAM_U57;
>
>         if (features & ~known_features)
>                 return -EINVAL;
> @@ -1013,8 +1017,23 @@ static long thread_feature_prctl(struct task_struct *task, int option,
>
>         /* Handle ARCH_THREAD_FEATURE_ENABLE */
>
> +       if (features & (X86_THREAD_LAM_U48 | X86_THREAD_LAM_U57)) {
> +               long ret;
> +
> +               /* LAM is only available in long mode */
> +               if (in_32bit_syscall())
> +                       return -EINVAL;
> +
> +               ret = enable_lam(task, features);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         task->thread.features |= features;
>  out:
> +       /* Update CR3 to get LAM active */
> +       switch_mm(task->mm, task->mm, task);
> +
>         return task->thread.features;
>  }
>
> diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
> index 76b547b83232..b8fa0e599c6e 100644
> --- a/arch/x86/kernel/process.h
> +++ b/arch/x86/kernel/process.h
> @@ -4,6 +4,8 @@
>
>  #include <asm/spec-ctrl.h>
>
> +long enable_lam(struct task_struct *task, unsigned long features);
> +
>  void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
>
>  /*
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index e459253649be..a25c51da7005 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -729,6 +729,52 @@ void set_personality_ia32(bool x32)
>  }
>  EXPORT_SYMBOL_GPL(set_personality_ia32);
>
> +static bool lam_u48_allowed(void)
> +{
> +       struct mm_struct *mm = current->mm;
> +
> +       if (!full_va_allowed(mm))
> +               return true;
> +
> +       return find_vma(mm, DEFAULT_MAP_WINDOW) == NULL;
> +}
> +
> +long enable_lam(struct task_struct *task, unsigned long features)
> +{
> +       features |= task->thread.features;
> +
> +       /* LAM_U48 and LAM_U57 are mutually exclusive */
> +       if ((features & X86_THREAD_LAM_U48) && (features & X86_THREAD_LAM_U57))
> +               return -EINVAL;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +               return -ENXIO;
> +
> +       if (mmap_write_lock_killable(task->mm))
> +               return -EINTR;
> +
> +       if ((features & X86_THREAD_LAM_U48) && !lam_u48_allowed()) {
> +               mmap_write_unlock(task->mm);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Record the most permissive (allowing the widest tags) LAM
> +        * mode to the mm context. It determinates if a mappings above
> +        * 47 bit is allowed for the process.
> +        *
> +        * The mode is also used by a kernel thread when it does work
> +        * on behalf of the process (like async I/O, io_uring, etc.)
> +        */
> +       if (features & X86_THREAD_LAM_U48)
> +               current->mm->context.lam = LAM_U48;
> +       else if (current->mm->context.lam == LAM_NONE)
> +               current->mm->context.lam = LAM_U57;
> +
> +       mmap_write_unlock(task->mm);
> +       return 0;
> +}
> +
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
>  {
> --
> 2.35.1
>


-- 
H.J.
