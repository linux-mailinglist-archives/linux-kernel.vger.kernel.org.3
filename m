Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78F14D7B23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiCNHDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiCNHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:02:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4840915
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:01:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id u10so28786635ybd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srqCigb1vWPaMd3DOBZQqhVr8vvkskgf2mmVXi17bKI=;
        b=YVTqjtBDJ4WxcYfcPezyITAxXd48JqxPEwgMQyEGSzaVTVXoDmRLS+TkZwcU9Hv26x
         ueylOT3rjV6u/WF2Trf3UrC1cp5DZ3nvYED3Wi4baWQHdmCA5pgs4YbA1FOMxFmCLzeD
         M7VTEmifPzoiWme/HRy6qhNLZPZY6d7W//fyHqBLaFy8JsdWi1m9sxZQX9TJ2RIVD/0y
         OyPmw6Um4C7+dejS8GjBPBoBVSEcu8T/i2aWZ/92+nSbuofOAX3pJGzpqQLKlJMeJ8Na
         dN2nbqPUAtHSnYliwdD4kU8GbxMThMMyd7Hw1DzkSI6nh2tzXgTGOpsXlgTgXlBQszEE
         oWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srqCigb1vWPaMd3DOBZQqhVr8vvkskgf2mmVXi17bKI=;
        b=HjmNWSzHuYMmve4Fjx3Ixx6TOd0mv5GrBZMjO393ei5QnuJlNFcTyFv4rQdJhwCwd6
         bwYGtxYJixWHCVzwZu5M4+smTWtX3KNerHUsISoQidc9XN7zpkG0SVyB8RwzJtYHnM39
         0DUmQeip+PCkwypMlTvVg1r4/KcS2TjwemYrNxTwbG0spRmrd/tnf1yehS0kkxB2ny6V
         NqTSJnqEBDiQm2CEKWa8kqwCmNI65TZlv+mgLGH+r82t1+xD0aboVuprYnGb/7hiuYJz
         rKpjV7IxPGBAy3t022WzwHAPAux6E+AKMsYZihiwc/jBBUusHWXdanQKw0WDbtcESH9U
         +cbQ==
X-Gm-Message-State: AOAM532+PIuL5+1vBPhH1Ybs/gKP8p+d77BWVW+mM90U/Fo4QjlePazP
        M5ROcE0igAcftuN895OqiQw5veGTSCwinTOuyyBK7w==
X-Google-Smtp-Source: ABdhPJzQ+CFHzpFTMac9G+rc/GRSCrnDKbAPdyk6SnRHXO0eMR1ouREWl48CurmtJzBA1/fJiSOAq0fhPWilSWzAlv4=
X-Received: by 2002:a05:6902:24f:b0:62d:69d:c9fc with SMTP id
 k15-20020a056902024f00b0062d069dc9fcmr14878938ybs.87.1647241306986; Mon, 14
 Mar 2022 00:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
In-Reply-To: <57133fafc4d74377a4a08d98e276d58fe4a127dc.1647115974.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Mar 2022 08:00:00 +0100
Message-ID: <CANpmjNNBzVovK=N9b2Lv0VUqpE_4nU+6gqO91_ojVoEbR0C5hA@mail.gmail.com>
Subject: Re: [PATCH] kasan, scs: collect stack traces from shadow stack
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

This is impressive.

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

Why is stack_trace_consume_fn required? This is an internal detail of
arch_stack_walk(), but to implement stack_trace_save_shadow() that's
not used at all.

I think having stack_trace_save_shadow() as you have implemented in
kernel/stacktrace.c or simply in kernel/scs.c itself would be
appropriate.

> We could add a command line flag to switch between stack trace collection
> modes. I noticed that Shadow Call Stack might be missing certain frames
> in stacks originating from a fault that happens in the middle of a
> function. I am not sure if this case is important to handle though.

I think SCS should just work - and if it doesn't, can we fix it? It is
unclear to me what would be a deciding factor to choose between stack
trace collection modes, since it is hard to quantify when and if SCS
doesn't work as intended. So I fear it'd just be an option that's
never used because we don't understand when it's required to be used.

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

This should go into arch/arm64/include/asm/kasan.h, and here it should
then just do

#ifndef PAC_TAG_RESET
#define ...


> +#else
> +#define PAC_TAG_RESET(x) (x)
> +#endif

But perhaps there's a better, more generic location for this macro?

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
