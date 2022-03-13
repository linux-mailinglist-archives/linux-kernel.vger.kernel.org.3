Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23474D7702
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiCMRAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiCMRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:00:52 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80E2C668
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:59:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q11so15657611iod.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKA+BAzUTFl+hnrRa9zqREom7b/VJAytojV31ApXxMs=;
        b=Hq45Dc3ilxe+x7mjO5aQoBpqz1qdLzbAKbtDJGuBTXp6RcWN7bL2WbQj+gpT42I+oh
         4hbZQ68XEcgsBKm9aF22hK2rVllA5qJR6AW7PjDAuyAB63rUI/rIOLl6Ea+K4/QjAYw0
         W3BGDCrM/KNcGfo7bBYdny2jlgdh1feM2ksg2N42K4ijVSWvuemvV2rnkstKnv68FgQp
         BUFB1EwjvgfMbHIhDNBmUH3CuAnbo2Xhzf6ApbGMLG2oUXuKi4NxeDLA+/d6v1lkeQ8V
         mKmjkaHLypNMfr2gr/FcV8iXiqim8EktqOgkyLB34q/tRvyQIhsGwj1z7N93LzGtDGOI
         YUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKA+BAzUTFl+hnrRa9zqREom7b/VJAytojV31ApXxMs=;
        b=o56fUSLA/tac12N/qgL+EGYNCqAXHOxSbUzdbd0BmfaSGWqUuskeRAyhYOXjBn+zAG
         MlPKfd9SUclRyIcW+VjL9wtmy+w1lEbvqDbAl2rAfyLUtjM9RXcEFCZj9E63RHcga3ux
         MGLuf0obS15CMVZhqDKp3hNVdy7ape/6uSDap/PFCOMUw1JlOpc7VjmaL/XvvQf7KX6U
         64BcN4KxMh6u11NuLsJaKzwz+1DdPJotPhbPkRJMgRqJDHIqtGAA4Kd6CHVXq2wNPRlP
         12TYcFPrFBLy5YWTJnYuFWwSbS7WrcEUAAL8O/YyW1yOKr0Ek1HaSzFbcvlFE1A7BDHD
         zsSg==
X-Gm-Message-State: AOAM531+OVlJlEnAAlCm0YzqVetzoS2LIsbN3cJ3NJ5nCok98bUVN58Z
        qO3ohzYhVNse2y0gEBBXC6WigZKy7f70Jb8seiM=
X-Google-Smtp-Source: ABdhPJwr/gg3/MsQUikmJAMYdtrOWiwA9deTGWCWDqlpJQmrK/d9nxW9PDNL/Zb4zgMlss0N4zZsX2t/6xa/DzAQ5wc=
X-Received: by 2002:a05:6638:d85:b0:317:d2f5:8f1d with SMTP id
 l5-20020a0566380d8500b00317d2f58f1dmr18097708jaj.117.1647190784476; Sun, 13
 Mar 2022 09:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
In-Reply-To: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 13 Mar 2022 17:59:33 +0100
Message-ID: <CA+fCnZfstj6V8JQJEvt2RfZ3Snc2Gnvo0uOYHqPh4LA=BHDdzw@mail.gmail.com>
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
>  }
>
> --
> 2.25.1
>

CC Florian
