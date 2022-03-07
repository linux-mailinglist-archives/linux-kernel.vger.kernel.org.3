Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75724D00BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbiCGOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCGOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:09:54 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AFE66F8D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:09:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g26so31116199ybj.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yk9BdGE0P4qhl7kTJOlzN4O3c8JJe4T1InJDUcBabo=;
        b=B4g1MvdpCEJjzUCjLv5igLIdZpjRxA9oIdPFfJRLD3JitCxFQCJ8h2ZzUK+yhrvVD7
         tpaANJLSgE0iz66eompeUXkipYphAGsLoffZPRvxsgpqFT/k15FXqu0eJKYhaRSgoL2J
         juS8mtIPNt5KjOMwJ+E0nxt9mQtwiATlRz4Eoe/KtomcN/fPcf8d1e2i0Tfq8OmWauz9
         cFS7+UN8tfMabPzzvp3psLtC4lN6ixS0XfJXdVj+R8/KJyamIM2GP4jp7eJypBqWlmG4
         ARxusBD+GeaszzXh7b6iGIoKB/wF7lXozJOaWyxx9rmKpElGj4PGuovTFxEPk9cVzg5/
         8vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yk9BdGE0P4qhl7kTJOlzN4O3c8JJe4T1InJDUcBabo=;
        b=gHTkqdMsQTQ4kPxlDcit+cpzG7WlaQsj2zQq/tPjM9FbF4WiUb/A7rt4XOMI+u5Q7i
         uPHhCnBVV93iwt+b31QCM4yIuyGKMcAZdgDJIGuyDdgkYcTRZu2EGBLFdcNV4Xjjlx66
         O2IyyczSVsKZ6HKlSOvU+89ubxOnhorHeArIeRJ4yd0YlSfPmaauNNg0bwuoKIe84nl9
         VlYjKmqVIMq/9rYgBAiJgv8e75SdLi5jgswknwP6752uBQav1nClI5xwoFWdwAooHoyc
         IY3FwvF9G+hEoivHjqUBN4AuhomUMh1sj8kmcpP4f06xRUOlman2OX8dJfUIdTat/1ZT
         s+2g==
X-Gm-Message-State: AOAM5335iOHAG/OKxTlA04C45pz0awvLvawXvDkCmIRRxpT52hBPfIZk
        C5+RDOMUvU0fDdjzENrMlspGiotLkzXh2Klt8BqAOg==
X-Google-Smtp-Source: ABdhPJx254W9rRRb0U/Y3PdIOLgfsiCQQVMMPYuUynQoKnS4kFv+mwwwzWrUnqWtgqvZfcdq+VDkLc293umr+/lxW8Y=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr8118330ybs.533.1646662139111; Mon, 07
 Mar 2022 06:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20220307074516.6920-1-dtcccc@linux.alibaba.com> <20220307074516.6920-3-dtcccc@linux.alibaba.com>
In-Reply-To: <20220307074516.6920-3-dtcccc@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Mar 2022 15:08:22 +0100
Message-ID: <CANpmjNPu+4VohTfFn6H-jBgL4zE2uexU3dqmks3LJy_chu34pg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kfence: Alloc kfence_pool after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, 7 Mar 2022 at 08:45, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>
> Allow enabling KFENCE after system startup by allocating its pool via the
> page allocator. This provides the flexibility to enable KFENCE even if it
> wasn't enabled at boot time.
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

This looks good, thanks!

Reviewed-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>


> ---
>  mm/kfence/core.c | 111 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 90 insertions(+), 21 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index caa4e84c8b79..f126b53b9b85 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -96,7 +96,7 @@ static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
>  module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
>
>  /* The pool of pages used for guard pages and objects. */
> -char *__kfence_pool __ro_after_init;
> +char *__kfence_pool __read_mostly;
>  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>
>  /*
> @@ -537,17 +537,19 @@ static void rcu_guarded_free(struct rcu_head *h)
>         kfence_guarded_free((void *)meta->addr, meta, false);
>  }
>
> -static bool __init kfence_init_pool(void)
> +/*
> + * Initialization of the KFENCE pool after its allocation.
> + * Returns 0 on success; otherwise returns the address up to
> + * which partial initialization succeeded.
> + */
> +static unsigned long kfence_init_pool(void)
>  {
>         unsigned long addr = (unsigned long)__kfence_pool;
>         struct page *pages;
>         int i;
>
> -       if (!__kfence_pool)
> -               return false;
> -
>         if (!arch_kfence_init_pool())
> -               goto err;
> +               return addr;
>
>         pages = virt_to_page(addr);
>
> @@ -565,7 +567,7 @@ static bool __init kfence_init_pool(void)
>
>                 /* Verify we do not have a compound head page. */
>                 if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
> -                       goto err;
> +                       return addr;
>
>                 __SetPageSlab(&pages[i]);
>         }
> @@ -578,7 +580,7 @@ static bool __init kfence_init_pool(void)
>          */
>         for (i = 0; i < 2; i++) {
>                 if (unlikely(!kfence_protect(addr)))
> -                       goto err;
> +                       return addr;
>
>                 addr += PAGE_SIZE;
>         }
> @@ -595,7 +597,7 @@ static bool __init kfence_init_pool(void)
>
>                 /* Protect the right redzone. */
>                 if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> -                       goto err;
> +                       return addr;
>
>                 addr += 2 * PAGE_SIZE;
>         }
> @@ -608,9 +610,21 @@ static bool __init kfence_init_pool(void)
>          */
>         kmemleak_free(__kfence_pool);
>
> -       return true;
> +       return 0;
> +}
> +
> +static bool __init kfence_init_pool_early(void)
> +{
> +       unsigned long addr;
> +
> +       if (!__kfence_pool)
> +               return false;
> +
> +       addr = kfence_init_pool();
> +
> +       if (!addr)
> +               return true;
>
> -err:
>         /*
>          * Only release unprotected pages, and do not try to go back and change
>          * page attributes due to risk of failing to do so as well. If changing
> @@ -623,6 +637,26 @@ static bool __init kfence_init_pool(void)
>         return false;
>  }
>
> +static bool kfence_init_pool_late(void)
> +{
> +       unsigned long addr, free_size;
> +
> +       addr = kfence_init_pool();
> +
> +       if (!addr)
> +               return true;
> +
> +       /* Same as above. */
> +       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
> +#ifdef CONFIG_CONTIG_ALLOC
> +       free_contig_range(page_to_pfn(virt_to_page(addr)), free_size / PAGE_SIZE);
> +#else
> +       free_pages_exact((void *)addr, free_size);
> +#endif
> +       __kfence_pool = NULL;
> +       return false;
> +}
> +
>  /* === DebugFS Interface ==================================================== */
>
>  static int stats_show(struct seq_file *seq, void *v)
> @@ -771,31 +805,66 @@ void __init kfence_alloc_pool(void)
>                 pr_err("failed to allocate pool\n");
>  }
>
> +static void kfence_init_enable(void)
> +{
> +       if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
> +               static_branch_enable(&kfence_allocation_key);
> +       WRITE_ONCE(kfence_enabled, true);
> +       queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> +       pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
> +               CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
> +               (void *)(__kfence_pool + KFENCE_POOL_SIZE));
> +}
> +
>  void __init kfence_init(void)
>  {
> +       stack_hash_seed = (u32)random_get_entropy();
> +
>         /* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
>         if (!kfence_sample_interval)
>                 return;
>
> -       stack_hash_seed = (u32)random_get_entropy();
> -       if (!kfence_init_pool()) {
> +       if (!kfence_init_pool_early()) {
>                 pr_err("%s failed\n", __func__);
>                 return;
>         }
>
> -       if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
> -               static_branch_enable(&kfence_allocation_key);
> -       WRITE_ONCE(kfence_enabled, true);
> -       queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> -       pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
> -               CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
> -               (void *)(__kfence_pool + KFENCE_POOL_SIZE));
> +       kfence_init_enable();
> +}
> +
> +static int kfence_init_late(void)
> +{
> +       const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
> +#ifdef CONFIG_CONTIG_ALLOC
> +       struct page *pages;
> +
> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
> +       if (!pages)
> +               return -ENOMEM;
> +       __kfence_pool = page_to_virt(pages);
> +#else
> +       if (nr_pages > MAX_ORDER_NR_PAGES) {
> +               pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
> +               return -EINVAL;
> +       }
> +       __kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
> +       if (!__kfence_pool)
> +               return -ENOMEM;
> +#endif
> +
> +       if (!kfence_init_pool_late()) {
> +               pr_err("%s failed\n", __func__);
> +               return -EBUSY;
> +       }
> +
> +       kfence_init_enable();
> +       return 0;
>  }
>
>  static int kfence_enable_late(void)
>  {
>         if (!__kfence_pool)
> -               return -EINVAL;
> +               return kfence_init_late();
>
>         WRITE_ONCE(kfence_enabled, true);
>         queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> --
> 2.27.0
>
