Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A114D7B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiCNHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiCNHTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:19:07 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8F12605
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:17:57 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso19055615ooc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHOQpg8FkWZ2D9kBQlZqUsUw9/chXLkk2DroGgT0P6g=;
        b=D8uyMk8EnZyrQebikWLVsUrSAQ3/m4z2B+4pBphbGlSeumCFVFgChQOnndtr+hsxbs
         glD2lvbM8w/3KYaxR4/C6UY0oPJkjJMjjZ6+JOcTmE9DFfQ0OmC9vYHb/mfDdSn7g0pA
         7ZRHdmeFlBoEKnuzQ1RujYEop8rvsU5L/lUdlzq50s49dKp7iL1tfGl9bHfjEjftI2Ea
         Hbd1fo1LqSgTkO8bIWg+Ldfl3m0Hs9Sm0v+iFY3CKi754l2YSKRJU3j88E422TsRYu6D
         euIIE/UdykRfsOsp4T7Ev9LSQhzfnIchrMKzYeCg635pg5kOtMHrkurw0DIf5cQLp9J6
         cUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHOQpg8FkWZ2D9kBQlZqUsUw9/chXLkk2DroGgT0P6g=;
        b=CCxDSZf0a4HCibQxsQ//Hf/f18VhCriMsNh6ppM3DvIxxWOQDOk7RDjlFjLHAKDq00
         0ebIDwhdia1zyb11QmbrgArbSCfQcEjqUHyaTXJ1/qZixv8tMud2LC2aFQHX3hKXMhkB
         LCTgNvNTot/iwOdKcsuDwl+sbJSZrlcN0J4gmYq+1Zoi7wAUbHRyokL+cuFmrMW0pOgX
         YBIJ3sAZ7j2yHoaFwkvGwj5O+0GGGVsuLcmd1jLWcV9pQ5yIFhUnwdek/Tszy3X6RINt
         zh6SCDMTFCZWZmd3vOqyWvy+nqrMLLii3NKbGOnYuru/Gz3N3SRL3lYzrMPW95x/o1dd
         b57A==
X-Gm-Message-State: AOAM531n92chH0IemyvF/X0l9JifmnZ+yVOl+u1RGWzTWtbpIZJw2Eaq
        BwYA9lwSDNoPychB7KfXZeFA5o300G2QUgrOBMv3dg==
X-Google-Smtp-Source: ABdhPJxZzWSTp4Q29wwMglz9UECVgKI7boAwwWTzT2TcroMKkNO0G1DuWKP9+Bq4ecaa8ZZg0fmogpTG2qFn/HGkArc=
X-Received: by 2002:a05:6870:9619:b0:d9:a25e:ed55 with SMTP id
 d25-20020a056870961900b000d9a25eed55mr10310764oaq.163.1647242276344; Mon, 14
 Mar 2022 00:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
In-Reply-To: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Mar 2022 08:17:45 +0100
Message-ID: <CACT4Y+ZtahUje36PKfGYLVkb2SawMXOC9aPNwgfNgZ1ujCAVBA@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 12 Mar 2022 at 21:14, <andrey.konovalov@linux.dev> wrote:
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

Just to double-check: interrupt frames are also appended to the the
current task buffer, right?

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
>  }
>
> --
> 2.25.1
>
