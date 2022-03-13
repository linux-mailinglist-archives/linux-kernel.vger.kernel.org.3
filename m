Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AFD4D78D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 00:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiCMXp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 19:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiCMXp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 19:45:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2738A0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:44:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d62so16273157iog.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y6GoVLUy81HdtypjoVfjZaaJkl3pvlY7l5U9nDab9U=;
        b=QwLaq6hTTwazfXOiSsmqZNItgMiNPPIF5v/VcRYcoPJN3WWYE7bdHvvdWAaqC3OlVz
         oPJGPf66ZBl4A0+VmVY3Tw0RLSKsYm5/HhaLtCl9Vqc71ZBAHlayUdu6s4TrxytdExxm
         KvPSFgLBMVsolLw2zCg8KYT6FfNMEYXCvLIlfKwWV+TeUaIn7n0xxqpF8E7EOu6yFnW3
         ijMsimaSals9IiEfkXplc4KlOizcvlfOhBys83quskTgatcBXVFcmPsrpyFZXeBF2Ku/
         OQwgaRd+ZRunYwVQjuhR0Uk4hJQtMmtlb82wSAnqmZBRG70umgZOVLxIBiPV01rJtvHf
         q2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y6GoVLUy81HdtypjoVfjZaaJkl3pvlY7l5U9nDab9U=;
        b=pLMMFPW9zBuh5iTMnUQHkEqaQIaPZpDiNFtB2DDX/Ji1SRosJx+fa5viw+gp5/L5qR
         RG4tmPsEuV3eBO/Kz9Ss8XlTQmnAyeOMmYDSqA23TmjJDjbyG49mjn00S8QBwMMDxSkw
         kf2Uinnk/GGC8IjKwvkinzU/Cx1P9ld1qGUMzsHFGhmA9q1T9tUOcR3N7RtjTsPngkm1
         i6JjEVxIFGNg4cJnZzrHrrGTfyFQBO7XXbaI3X5qdpBwQvfaQOCpglY7nbXkph+jwJId
         SdZWba8cn3r1WgL3eOkU405UAiDcgA3usBUrs+QoCHSgCz0Oyg0gu9ZbEINxV9xlyvNt
         KhtQ==
X-Gm-Message-State: AOAM532K8fCpBkrzbkaz5Q2JWm4979xs1S78J9hBwGIF2usDb7BJSI7H
        NXQaJz0nl5hyqxD1z4wpjrcI8rySyy5b+KwRGO8=
X-Google-Smtp-Source: ABdhPJxeUMr9fsIxWbNq8YPG7hWDuaKrG8FpeP86LODHC0n6rpPIvhGNr5tMXeV/8gLdZ46qI7Is52Al8WDXVx7fWHg=
X-Received: by 2002:a05:6602:2b8e:b0:5e9:74e7:6b01 with SMTP id
 r14-20020a0566022b8e00b005e974e76b01mr17690829iov.127.1647215058035; Sun, 13
 Mar 2022 16:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
In-Reply-To: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 14 Mar 2022 00:44:07 +0100
Message-ID: <CA+fCnZe-zj8Xqi5ACz0FjRX92b5KnnP=qKCjEck0=mAjV0nohA@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Florian Mayer <fmayer@google.com>
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

On Sat, Mar 12, 2022 at 9:14 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Currently, KASAN always uses the normal stack trace collection routines,
> which rely on the unwinder, when saving alloc and free stack traces.
>
> Instead of invoking the unwinder, collect the stack trace by copying
> frames from the Shadow Call Stack whenever it is enabled. This reduces
> boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.
>
> To avoid potentially leaking PAC pointer tags, strip them when saving
> the stack trace.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Things to consider:
>
> We could integrate shadow stack trace collection into kernel/stacktrace.c
> as e.g. stack_trace_save_shadow(). However, using stack_trace_consume_fn
> leads to invoking a callback on each saved from, which is undesirable.
> The plain copy loop is faster.
>
> We could add a command line flag to switch between stack trace collection
> modes. I noticed that Shadow Call Stack might be missing certain frames
> in stacks originating from a fault that happens in the middle of a
> function. I am not sure if this case is important to handle though.
>
> Looking forward to thoughts and comments.
>
> Thanks!
>
> ---
>  mm/kasan/common.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d9079ec11f31..65a0723370c7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -9,6 +9,7 @@
>   *        Andrey Konovalov <andreyknvl@gmail.com>
>   */
>
> +#include <linux/bits.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/kasan.h>
> @@ -21,6 +22,7 @@
>  #include <linux/printk.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/scs.h>
>  #include <linux/slab.h>
>  #include <linux/stacktrace.h>
>  #include <linux/string.h>
> @@ -30,12 +32,44 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +#define PAC_TAG_RESET(x) (x | GENMASK(63, CONFIG_ARM64_VA_BITS))
> +#else
> +#define PAC_TAG_RESET(x) (x)
> +#endif
> +
> +static unsigned int save_shadow_stack(unsigned long *entries,
> +                                     unsigned int nr_entries)
> +{
> +       unsigned long *scs_sp = task_scs_sp(current);
> +       unsigned long *scs_base = task_scs(current);
> +       unsigned long *frame;
> +       unsigned int i = 0;
> +
> +       for (frame = scs_sp - 1; frame >= scs_base; frame--) {
> +               entries[i++] = PAC_TAG_RESET(*frame);
> +               if (i >= nr_entries)
> +                       break;
> +       }
> +
> +       return i;
> +}
> +#else /* CONFIG_SHADOW_CALL_STACK */
> +static inline unsigned int save_shadow_stack(unsigned long *entries,
> +                                       unsigned int nr_entries) { return 0; }
> +#endif /* CONFIG_SHADOW_CALL_STACK */
> +
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>  {
>         unsigned long entries[KASAN_STACK_DEPTH];
>         unsigned int nr_entries;
>
> -       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> +       if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
> +               nr_entries = save_shadow_stack(entries, ARRAY_SIZE(entries));
> +       else
> +               nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
>         return __stack_depot_save(entries, nr_entries, flags, can_alloc);

Another option here is to instruct stack depot to get the stack from
the Shadow Call Stack. This would avoid copying the frames twice.

>  }
>
> --
> 2.25.1
>
