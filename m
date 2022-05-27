Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9F536263
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350780AbiE0MX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352468AbiE0MWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:22:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0E16F906
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:02:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q1so4726043ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqvudJmTK1NuR+GVwPWW+sM4XNkpoIxtq49HohR+1C0=;
        b=Q0LhMW8Q+6etnMqfIAfvvj2A3tAUWm7G4m5DJWoWKjQ6GwLjC9I/oDgZlE2sE5nY9i
         L6xp2Jolur+xelV34963wHNP49gK8NL32KnOk5dGTWsjRrWcgWpC9fFK22W1aGDwkPP1
         fiChbQdyqC1pvxO9KfutYLw0CH+EyvHUNSr5KEEz7LX4dlBiCijF92078equJn3TMx/s
         pXBRDEXgQCFTpK+mKjVlSwSCOJe+4prqTmiIwSwnSM5XTFe/XkBVxSrAJcPfLCRJkD2a
         4/VRUwnuT1yHEt+OYaLLkNSMz+FzqO/JOZYEK3pRFjN8oBDX+TMifJ42uObJx/BSnbpL
         ASFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqvudJmTK1NuR+GVwPWW+sM4XNkpoIxtq49HohR+1C0=;
        b=pNMg/MK2UY1qz5W2CwtPrrJ2aRt+BVI4DNh4CkfRu2fGpRzUPO88woveXcMkYV/h3l
         EIw3xkw+wuZv4qgzGV5i1Bxttlfhc2tYwekm9TAkt0l8Mr6PwxtYvCvQt4yqR0jwGar2
         HvVUKB5BxJvzV+YEAq8FmyYwfe9/+wqVUiHcu3qqAFb1I8bui93ARwiJZlE4Zs0ynzkH
         c+Awd4FIyraIg9E+TQmQNXB6EK8ds0jVGVOClf+PzKZxKoBX5xXQiJA1qHQwckwLgy8a
         4p8wGfxgO44RK935W0764v3q6iJjLCSzIU6YLlUOBTzV9c+qu1L4NDy1Nyxvc2ri1Tm5
         CdVA==
X-Gm-Message-State: AOAM530/trDyw4isQMDbJfYeCaLn/QhKzJgrxqS6oK90fq4P+NiGiYs/
        t9ARmTXbXm/wE5NtGV2Q6IXvbMxfUDFn4i4fehBXHA==
X-Google-Smtp-Source: ABdhPJzcm14jpChbk2Ttq5vqWFIOkcVcKL8h8dzE/DtzNfssdGkkcWIET0XX6ZgFOqfHbC7HC0JYQ7/jdg/X7LH/deo=
X-Received: by 2002:a05:651c:1797:b0:254:1a3a:801a with SMTP id
 bn23-20020a05651c179700b002541a3a801amr5727591ljb.363.1653652970506; Fri, 27
 May 2022 05:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220527113706.24870-1-vbabka@suse.cz> <20220527113706.24870-2-vbabka@suse.cz>
In-Reply-To: <20220527113706.24870-2-vbabka@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 14:02:38 +0200
Message-ID: <CACT4Y+Y4GZfXOru2z5tFPzFdaSUd+GFc6KVL=bsa0+1m197cQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lib/stackdepot: replace CONFIG_STACK_HASH_ORDER
 with automatic sizing
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
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

On Fri, 27 May 2022 at 13:37, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> As Linus explained [1], setting the stackdepot hash table size as a
> config option is suboptimal, especially as stackdepot becomes a
> dependency of less specialized subsystems than initially (e.g. DRM,
> networking, SLUB_DEBUG):
>
> : (a) it introduces a new compile-time question that isn't sane to ask
> : a regular user, but is now exposed to regular users.
>
> : (b) this by default uses 1MB of memory for a feature that didn't in
> : the past, so now if you have small machines you need to make sure you
> : make a special kernel config for them.
>
> Ideally we would employ rhashtable for fully automatic resizing, which
> should be feasible for many of the new users, but problematic for the
> original users with restricted context that call __stack_depot_save()
> with can_alloc == false, i.e. KASAN.
>
> However we can easily remove the config option and scale the hash table
> automatically with system memory. The STACK_HASH_MASK constant becomes
> stack_hash_mask variable and is used only in one mask operation, so the
> overhead should be negligible to none. For early allocation we can
> employ the existing alloc_large_system_hash() function and perform
> similar scaling for the late allocation.
>
> The existing limits of the config option (between 4k and 1M buckets)
> are preserved, and scaling factor is set to one bucket per 16kB memory
> so on 64bit the max 1M buckets (8MB memory) is achieved with 16GB
> system, while a 1GB system will use 512kB.

Hi Vlastimil,

We use KASAN with VMs with 2GB of memory.
If I did the math correctly this will result in 128K entries, while
currently we have CONFIG_STACK_HASH_ORDER=20 even for arm32.
I am actually not sure how full the table gets, but we can fuzz a
large kernel for up to an hour, so we can get lots of stacks (we were
the only known users who routinely overflowed default LOCKDEP tables
:)).

I am not opposed to this in general. And I understand that KASAN Is
different from the other users.
What do you think re allowing CONFIG_STACK_HASH_ORDER=0/is not set
which will mean auto-size, but keeping ability to set exact size as
well?
Or alternatively auto-size if KASAN is not enabled and use a large
table otherwise? But I am not sure if anybody used
CONFIG_STACK_HASH_ORDER to reduce the default size with KASAN...



> If needed, the automatic scaling could be complemented with a boot-time
> kernel parameter, but it feels pointless to add it without a specific
> use case.
>
> [1] https://lore.kernel.org/all/CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com/
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/Kconfig      |  9 ---------
>  lib/stackdepot.c | 47 ++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 6a843639814f..1e7cf7c76ae6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -682,15 +682,6 @@ config STACKDEPOT_ALWAYS_INIT
>         bool
>         select STACKDEPOT
>
> -config STACK_HASH_ORDER
> -       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
> -       range 12 20
> -       default 20
> -       depends on STACKDEPOT
> -       help
> -        Select the hash size as a power of 2 for the stackdepot hash table.
> -        Choose a lower value to reduce the memory impact.
> -
>  config REF_TRACKER
>         bool
>         depends on STACKTRACE_SUPPORT
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ca0d086ef4a..f7b73ddfca77 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -145,10 +145,15 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>         return stack;
>  }
>
> -#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER)
> -#define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
> +/* one hash table bucket entry per 16kB of memory */
> +#define STACK_HASH_SCALE       14
> +/* limited between 4k and 1M buckets */
> +#define STACK_HASH_ORDER_MIN   12
> +#define STACK_HASH_ORDER_MAX   20
>  #define STACK_HASH_SEED 0x9747b28c
>
> +static unsigned int stack_hash_mask;
> +
>  static bool stack_depot_disable;
>  static struct stack_record **stack_table;
>
> @@ -175,8 +180,6 @@ void __init stack_depot_want_early_init(void)
>
>  int __init stack_depot_early_init(void)
>  {
> -       size_t size;
> -
>         /* This is supposed to be called only once, from mm_init() */
>         if (WARN_ON(__stack_depot_early_init_passed))
>                 return 0;
> @@ -186,10 +189,15 @@ int __init stack_depot_early_init(void)
>         if (!__stack_depot_want_early_init || stack_depot_disable)
>                 return 0;
>
> -       size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> -       pr_info("Stack Depot early init allocating hash table with memblock_alloc, %zu bytes\n",
> -               size);
> -       stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
> +       stack_table = alloc_large_system_hash("stackdepot",
> +                                               sizeof(struct stack_record *),
> +                                               0,
> +                                               STACK_HASH_SCALE,
> +                                               HASH_EARLY | HASH_ZERO,
> +                                               NULL,
> +                                               &stack_hash_mask,
> +                                               1UL << STACK_HASH_ORDER_MIN,
> +                                               1UL << STACK_HASH_ORDER_MAX);
>
>         if (!stack_table) {
>                 pr_err("Stack Depot hash table allocation failed, disabling\n");
> @@ -207,13 +215,30 @@ int stack_depot_init(void)
>
>         mutex_lock(&stack_depot_init_mutex);
>         if (!stack_depot_disable && !stack_table) {
> -               pr_info("Stack Depot allocating hash table with kvcalloc\n");
> -               stack_table = kvcalloc(STACK_HASH_SIZE, sizeof(struct stack_record *), GFP_KERNEL);
> +               unsigned long entries;
> +
> +               entries = nr_free_buffer_pages();
> +               entries = roundup_pow_of_two(entries);
> +
> +               if (STACK_HASH_SCALE > PAGE_SHIFT)
> +                       entries >>= (STACK_HASH_SCALE - PAGE_SHIFT);
> +               else
> +                       entries <<= (PAGE_SHIFT - STACK_HASH_SCALE);
> +
> +               if (entries < 1UL << STACK_HASH_ORDER_MIN)
> +                       entries = 1UL << STACK_HASH_ORDER_MIN;
> +               if (entries > 1UL << STACK_HASH_ORDER_MAX)
> +                       entries = 1UL << STACK_HASH_ORDER_MAX;
> +
> +               pr_info("Stack Depot allocating hash table of %lu entries with kvcalloc\n",
> +                               entries);
> +               stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
>                 if (!stack_table) {
>                         pr_err("Stack Depot hash table allocation failed, disabling\n");
>                         stack_depot_disable = true;
>                         ret = -ENOMEM;
>                 }
> +               stack_hash_mask = entries - 1;
>         }
>         mutex_unlock(&stack_depot_init_mutex);
>         return ret;
> @@ -386,7 +411,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                 goto fast_exit;
>
>         hash = hash_stack(entries, nr_entries);
> -       bucket = &stack_table[hash & STACK_HASH_MASK];
> +       bucket = &stack_table[hash & stack_hash_mask];
>
>         /*
>          * Fast path: look the stack trace up without locking.
> --
> 2.36.1
>
