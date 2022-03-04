Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9117A4CDBF1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiCDSPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiCDSPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:15:45 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3B1CABF6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:14:57 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g1so18487936ybe.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgmWOr5X+Gju6wLd27yrRRMMaWYlUQXk8HNkXVZFAmo=;
        b=bbMZ5FUuoNRRL/OGX4cdDn7hjWZbYJIDda/k+M5en2JdTZhGU0nwzXAeKXteuGTzQm
         G3pCHqKOHVsZyZZy0P24JTD3YZciF4RkRxnf96ccZcossZ4YPK60orQ0ixcq2KpaEnjw
         KZLFeK7frKm4r4Gfosfx820+MECXYx+V7g/At8PD44S6x4suvf/D/xRVcu+MbbbY3kjL
         gPl5M/p02tsm3fHI/Hf9UMLOtcWggt06zo8MZet2YLEJ6Mz+X5kJ4rbw277L2SK6F/RA
         Nz2TWIomeWSiuL0ZIxfvY2lthKzw+C6d1fzNWvOrbphMkNOex5MtGSXbo3XUNl0UDM8c
         0Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgmWOr5X+Gju6wLd27yrRRMMaWYlUQXk8HNkXVZFAmo=;
        b=IzOT4SMqPayAzv1zT4PowG1sN2ellsbtqs43dGSZ/DRfqH1p78pW7lKQbEOsN8y2iJ
         ku6RwRZYwQWNxx3VXaw4idyxytzKwYmED7wZ2kIo0uv420wmPz92aInchqJpt5RGh+xu
         74A6qbhI1NQRGv/Mi+wuIwYdZi2t4llhuazHodXbeeNaYakXDNRoUYPAuJ483KxzESwB
         JYwN33zh7vYpzX5x2A8nIUlwcvgVa72kpMKF+EJrOkKmvFHL5GXF6uCHPHOnidxHoGJN
         LKQHKAWp0ykTFCxl3z8oIyQhsMzO+YC20codYV0HTTqGYloFaRFCgTT2ea6+kdZNa+ay
         c+HQ==
X-Gm-Message-State: AOAM5311h4O2LfcSUD3QHERgNau2f2ccG+NW0r7VCnyHEkLX/qaKCyTg
        8r2ruq437joP0Sj71kguW26yojQqijSxxW6Z73SQRA==
X-Google-Smtp-Source: ABdhPJzad+HZpqZOcf4SzFpNaNg1/k+wJTOYWQxQkGiq8SOuHUHEHl8BfwJBqzE/xdgZOtpIT02ppmuvLKNsJEftvjk=
X-Received: by 2002:a25:af92:0:b0:628:b791:281b with SMTP id
 g18-20020a25af92000000b00628b791281bmr11191902ybh.87.1646417695968; Fri, 04
 Mar 2022 10:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com> <20220303031505.28495-3-dtcccc@linux.alibaba.com>
In-Reply-To: <20220303031505.28495-3-dtcccc@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 19:14:19 +0100
Message-ID: <CANpmjNNg2EN-Fnn_=Na8zE4CwTdoLOWw0N9ir5m4JLZf82_zwA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kfence: Alloc kfence_pool after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 04:15, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>
> KFENCE aims at production environments, but it does not allow enabling
> after system startup because kfence_pool only alloc pages from memblock.
> Consider the following production scene:
> At first, for performance considerations, production machines do not
> enable KFENCE.
> However, after running for a while, the kernel is suspected to have
> memory errors. (e.g., a sibling machine crashed.)
> So other production machines need to enable KFENCE, but it's hard for
> them to reboot.

I think having this flexibility isn't bad, but your usecase just
doesn't make sense (to us at least, based on our experience).

So I would simply remove the above as it will give folks the wrong
impression. The below paragraph can be improved a little, but should
be enough.

> Allow enabling KFENCE by alloc pages after system startup, even if
> KFENCE is not enabled during booting.

The above doesn't parse very well -- my suggestion:
  "Allow enabling KFENCE after system startup by allocating its pool
via the page allocator. This provides the flexibility to enable KFENCE
even if it wasn't enabled at boot time."

> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
> This patch is similar to what the KFENCE(early version) do on ARM64.
> Instead of alloc_pages(), we'd prefer alloc_contig_pages() to get exact
> number of pages.
> I'm not sure about the impact of breaking __ro_after_init. I've tested
> with hackbench, and it seems no performance regression.
> Or any problem about security?

Performance would be the main consideration. However, I think
__read_mostly should be as good as __ro_after_init in terms of
performance.

> ---
>  mm/kfence/core.c | 96 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 76 insertions(+), 20 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 19eb123c0bba..ae69b2a113a4 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -93,7 +93,7 @@ static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
>  module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
>
>  /* The pool of pages used for guard pages and objects. */
> -char *__kfence_pool __ro_after_init;
> +char *__kfence_pool __read_mostly;
>  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>
>  /*
> @@ -534,17 +534,18 @@ static void rcu_guarded_free(struct rcu_head *h)
>         kfence_guarded_free((void *)meta->addr, meta, false);
>  }
>
> -static bool __init kfence_init_pool(void)
> +/*
> + * The main part of init kfence pool.

"Initialization of the KFENCE pool after its allocation."

> + * Return 0 if succeed. Otherwise return the address where error occurs.

"Return 0 on success; otherwise returns the address up to which
partial initialization succeeded."

> + */
> +static unsigned long __kfence_init_pool(void)

Keep this function simply named 'kfence_init_pool()' - it's a static
function, and we can be more descriptive with the other function
names.

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
> @@ -562,7 +563,7 @@ static bool __init kfence_init_pool(void)
>
>                 /* Verify we do not have a compound head page. */
>                 if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
> -                       goto err;
> +                       return addr;
>
>                 __SetPageSlab(&pages[i]);
>         }
> @@ -575,7 +576,7 @@ static bool __init kfence_init_pool(void)
>          */
>         for (i = 0; i < 2; i++) {
>                 if (unlikely(!kfence_protect(addr)))
> -                       goto err;
> +                       return addr;
>
>                 addr += PAGE_SIZE;
>         }
> @@ -592,7 +593,7 @@ static bool __init kfence_init_pool(void)
>
>                 /* Protect the right redzone. */
>                 if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> -                       goto err;
> +                       return addr;
>
>                 addr += 2 * PAGE_SIZE;
>         }
> @@ -605,9 +606,21 @@ static bool __init kfence_init_pool(void)
>          */
>         kmemleak_free(__kfence_pool);
>
> -       return true;
> +       return 0;
> +}
> +
> +static bool __init kfence_init_pool(void)

Just call this kfence_init_pool_early().

> +{
> +       unsigned long addr;
> +
> +       if (!__kfence_pool)
> +               return false;
> +
> +       addr = __kfence_init_pool();
> +
> +       if (!addr)
> +               return true;
>
> -err:
>         /*
>          * Only release unprotected pages, and do not try to go back and change
>          * page attributes due to risk of failing to do so as well. If changing
> @@ -620,6 +633,22 @@ static bool __init kfence_init_pool(void)
>         return false;
>  }
>
> +static bool kfence_init_pool_late(void)
> +{
> +       unsigned long addr, free_pages;
> +
> +       addr = __kfence_init_pool();
> +
> +       if (!addr)
> +               return true;
> +
> +       /* Same as above. */
> +       free_pages = (KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool)) / PAGE_SIZE;
> +       free_contig_range(page_to_pfn(virt_to_page(addr)), free_pages);
> +       __kfence_pool = NULL;
> +       return false;
> +}
> +
>  /* === DebugFS Interface ==================================================== */
>
>  static int stats_show(struct seq_file *seq, void *v)
> @@ -768,31 +797,58 @@ void __init kfence_alloc_pool(void)
>                 pr_err("failed to allocate pool\n");
>  }
>
> +static inline void __kfence_init(void)

Don't make this 'inline', I see no reason for it. If the compiler
thinks it's really worth inlining, it'll do it anyway.

Also, just call it 'kfence_init_enable()' (sprinkling '__' everywhere
really doesn't improve readability if we can avoid it).

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
>         if (!kfence_init_pool()) {
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
> +       __kfence_init();
> +}
> +
> +static int kfence_init_late(void)
> +{
> +       struct page *pages;
> +       const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;

Order 'nr_pages' above 'pages' (reverse xmas-tree).


> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
> +
> +       if (!pages)
> +               return -ENOMEM;
> +
> +       __kfence_pool = page_to_virt(pages);
> +
> +       if (!kfence_init_pool_late()) {
> +               pr_err("%s failed\n", __func__);
> +               return -EBUSY;
> +       }
> +
> +       __kfence_init();
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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220303031505.28495-3-dtcccc%40linux.alibaba.com.
