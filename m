Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262D552C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347057AbiFUHhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbiFUHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:37:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874CE1C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:37:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d19so14399828lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyheJD4bAlrZUyrOZt+A8Zzf01u3nd0p7PNq0BkSQPg=;
        b=DsougCXdnJ9//fXVMi81UM/OA1cGshIeJkqJrhKSzVNw1NIKiJ4Q9vlHofpRGGkaRq
         A6hIVLyao9AHHANCZIo87cb9zhjJJ1xPqnICDZKL+GYF4+iQIHxQAmvnxLSS8LBFKVDM
         x/RvFpNgsYT2pdsmihw8nd8IiBYurW+KqwmEoAmu6+SvvMaC0XzvlSSLJlDRZCjENleG
         Y0T+BozcVt2J0evJsQtmYvlLaWyes4TRQFEKPoS6YmdSUpxgddH/DeCgigifm0Z1gtgU
         AjNd3OxOLr1Va4xSSx7iWXVqnDVaImlhk1D6CO1zpz25bUPxi3LR/ohmbNE04RpUG59K
         DNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyheJD4bAlrZUyrOZt+A8Zzf01u3nd0p7PNq0BkSQPg=;
        b=XlMMklQJHqak6zQcYjdLxydLRR7oAFBKrg8rix1vSg+uyJi1uTqyya/7w+tgynZxTB
         IKehS0A8OAkf9P8SoGZfozDEefcv1rEZ+swUpqqDsXpHuy1u34LLsfHgnT5RzENFwYLm
         BIBliwfrAz8ggrJEnqdaL7meU81ow6ZD76SbiP8gEBym02uCEClAr+ch/8yIvUsWU6B2
         nZe3WaOHYdLxGH0TOVTNlhBOi5l+hBxGHFJ+H+UkOUUXDuMNvpKJPO/fy1hSiz8y3cnn
         Bw34I3leQYoPdneMc+kXRAjSHKq6iYp/7HK3hoLYfKS+UHKnMaX8pF3BCusoXiJZp9zx
         t0ew==
X-Gm-Message-State: AJIora/TZOe0PA7cgHKYJtEye5R4tPhUcjo63UbEqoj1reLjasJdyJcp
        hS1/OX2XdEk7UYwE0T+VqCpqYvdU0++u0UMq1nuBNw==
X-Google-Smtp-Source: AGRyM1sYg9IbMSQyU3FZlgEitV/tUOop/c49ZQm9/duohXtdXd4fEoVURd7nS4L3G5Y8nHZagAc/TnboivK4BlVYHGE=
X-Received: by 2002:a05:651c:1988:b0:255:b2ef:6a5b with SMTP id
 bx8-20020a05651c198800b00255b2ef6a5bmr13840428ljb.465.1655797048804; Tue, 21
 Jun 2022 00:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220527113706.24870-1-vbabka@suse.cz> <20220620150249.16814-1-vbabka@suse.cz>
In-Reply-To: <20220620150249.16814-1-vbabka@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Jun 2022 09:37:17 +0200
Message-ID: <CACT4Y+btgY8-GYZbQOoghgfCEHMTd_S=BmNnMQxMTgCU5JztPQ@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: replace CONFIG_STACK_HASH_ORDER with
 automatic sizing
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>,
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

On Mon, 20 Jun 2022 at 17:03, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> As Linus explained [1], setting the stackdepot hash table size as a
> config option is suboptimal, especially as stackdepot becomes a
> dependency of less "expert" subsystems than initially (e.g. DRM,
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
>
> Because KASAN is reported to need the maximum number of buckets even
> with smaller amounts of memory [2], set it as such when kasan_enabled().
>
> If needed, the automatic scaling could be complemented with a boot-time
> kernel parameter, but it feels pointless to add it without a specific
> use case.
>
> [1] https://lore.kernel.org/all/CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CACT4Y+Y4GZfXOru2z5tFPzFdaSUd+GFc6KVL=bsa0+1m197cQQ@mail.gmail.com/
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  lib/Kconfig      |  9 --------
>  lib/stackdepot.c | 59 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index eaaad4d85bf2..986ea474836c 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -685,15 +685,6 @@ config STACKDEPOT_ALWAYS_INIT
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
> index 5ca0d086ef4a..e73fda23388d 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -32,6 +32,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/memblock.h>
> +#include <linux/kasan-enabled.h>
>
>  #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
>
> @@ -145,10 +146,16 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
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
> +static unsigned int stack_hash_order;
> +static unsigned int stack_hash_mask;
> +
>  static bool stack_depot_disable;
>  static struct stack_record **stack_table;
>
> @@ -175,7 +182,7 @@ void __init stack_depot_want_early_init(void)
>
>  int __init stack_depot_early_init(void)
>  {
> -       size_t size;
> +       unsigned long entries = 0;
>
>         /* This is supposed to be called only once, from mm_init() */
>         if (WARN_ON(__stack_depot_early_init_passed))
> @@ -183,13 +190,23 @@ int __init stack_depot_early_init(void)
>
>         __stack_depot_early_init_passed = true;
>
> +       if (kasan_enabled() && !stack_hash_order)
> +               stack_hash_order = STACK_HASH_ORDER_MAX;
> +
>         if (!__stack_depot_want_early_init || stack_depot_disable)
>                 return 0;
>
> -       size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> -       pr_info("Stack Depot early init allocating hash table with memblock_alloc, %zu bytes\n",
> -               size);
> -       stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
> +       if (stack_hash_order)
> +               entries = 1UL <<  stack_hash_order;
> +       stack_table = alloc_large_system_hash("stackdepot",
> +                                               sizeof(struct stack_record *),
> +                                               entries,
> +                                               STACK_HASH_SCALE,
> +                                               HASH_EARLY | HASH_ZERO,
> +                                               NULL,
> +                                               &stack_hash_mask,
> +                                               1UL << STACK_HASH_ORDER_MIN,
> +                                               1UL << STACK_HASH_ORDER_MAX);
>
>         if (!stack_table) {
>                 pr_err("Stack Depot hash table allocation failed, disabling\n");
> @@ -207,13 +224,35 @@ int stack_depot_init(void)
>
>         mutex_lock(&stack_depot_init_mutex);
>         if (!stack_depot_disable && !stack_table) {
> -               pr_info("Stack Depot allocating hash table with kvcalloc\n");
> -               stack_table = kvcalloc(STACK_HASH_SIZE, sizeof(struct stack_record *), GFP_KERNEL);
> +               unsigned long entries;
> +               int scale = STACK_HASH_SCALE;
> +
> +               if (stack_hash_order) {
> +                       entries = 1UL << stack_hash_order;
> +               } else {
> +                       entries = nr_free_buffer_pages();
> +                       entries = roundup_pow_of_two(entries);
> +
> +                       if (scale > PAGE_SHIFT)
> +                               entries >>= (scale - PAGE_SHIFT);
> +                       else
> +                               entries <<= (PAGE_SHIFT - scale);
> +               }
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
> @@ -386,7 +425,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
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
