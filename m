Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398FF4CD0EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiCDJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiCDJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:19:52 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3574DEA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:19:04 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbc48104beso84433697b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogpwyNSkB4ze+rcozJwTBtfzGNJ0UlV8uYCn4crnYsc=;
        b=UhZft2kzf5nE70Sq3bmHrTWFkXzKM+N7MNLsonDi6hx57J9iVWwg8Eqok0ysl9MP32
         CONsjg+IocXmYXlxraaEe2L7D/l/2JjRntkLRfxZ0HDN0CFok+I+UqN/h3iuo57b/XPF
         PNvv0m6pwqQowQsKZc9uNLlaTnvIKLYXeRIAeEQKz5CHiKps8nEZiybOsktQ0DLsgsC+
         quc04OvyOKAleaseHJ5cRqiK4UbPYUDVaoVmnnmtsxg05uAMdEdP09mkXTwYjtn9G5Fl
         6qn1kAEtdOLZj5ymGQLEssH3ruOHT774r8jneuWe2mbMd9NuBdHu4Fz8Er7kHIldCVVA
         rq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogpwyNSkB4ze+rcozJwTBtfzGNJ0UlV8uYCn4crnYsc=;
        b=LTmw+S1HjmvLIGzoU2JCiF4G0NmMGf5GA+MMsmuTvSPRVU8xk0WOcjPsIkN52rFwv+
         ZvAV8KWTu7qWGEmtZ4lU0wpvj/X47bFmryk1YSVRJQemdO2fbZiZLbyLGgSUlzze7usK
         qT0xxcfPT+Rab6srpRgYfGC8saaFY3l6Afpfvhia3PwwK0LVmc87A+Jn1cXmOvuYBgGn
         N3FOzb3aGe7pO2QCpxXWCT0t3wGv+HIPCtmfH8/N81D+D71/4WKvOdZjkePyvbdF0i+9
         ikj+KFNTGlzl+YiAgmp5pLDcIuAO71ZOv3URS5RUHeoW5ADBcFIEHDANZ1mkvPU3SKo1
         YVSA==
X-Gm-Message-State: AOAM533oKBqJJzNHxXLt4EPiusg33Nh8ZKgRRXMOR1ySXeAe6SoTvTlS
        WTXSz1bZ2SzaY8a4z/kgNDhjuEUOEBgUuv17k+vMPg==
X-Google-Smtp-Source: ABdhPJx9WTQcUaKFDNhRGeQ5g9R7VDmaIMZXAhAiAylDhj8aX52dl4rpM1+jpP8F/IXHV5PL6pMT2OsYEoMgcVcNLGY=
X-Received: by 2002:a81:9ad7:0:b0:2db:f000:32e7 with SMTP id
 r206-20020a819ad7000000b002dbf00032e7mr15751512ywg.412.1646385543751; Fri, 04
 Mar 2022 01:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20220302173122.11939-1-vbabka@suse.cz> <20220302173122.11939-2-vbabka@suse.cz>
 <c923550e-c88e-aad4-ecc2-fa8a3d0a1f1c@suse.cz>
In-Reply-To: <c923550e-c88e-aad4-ecc2-fa8a3d0a1f1c@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 10:18:27 +0100
Message-ID: <CANpmjNNErTMNqN1n7gLyRsJrKjSyfN3dXyXfDA0Yeo-COObr4Q@mail.gmail.com>
Subject: Re: [PATCH v3r0 1/6] lib/stackdepot: allow requesting early
 initialization dynamically
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
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

On Thu, 3 Mar 2022 at 20:19, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Here's an updated version based on feedback so I don't re-send everything
> so soon after v2. Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v3r0
> There are only trivial adaptations in patch 3/6 to the stack depot init
> changes otherwise.
> Thanks, Vlastimil
>
> ----8<----
> From 230ebae0f83540574d167f9ba1f71d3f602ca410 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 2 Mar 2022 12:02:22 +0100
> Subject: [PATCH v3 1/6] lib/stackdepot: allow requesting early initialization
>  dynamically
>
> In a later patch we want to add stackdepot support for object owner
> tracking in slub caches, which is enabled by slub_debug boot parameter.
> This creates a bootstrap problem as some caches are created early in
> boot when slab_is_available() is false and thus stack_depot_init()
> tries to use memblock. But, as reported by Hyeonggon Yoo [1] we are
> already beyond memblock_free_all(). Ideally memblock allocation should
> fail, yet it succeeds, but later the system crashes, which is a
> separately handled issue.
>
> To resolve this boostrap issue in a robust way, this patch adds another
> way to request stack_depot_early_init(), which happens at a well-defined
> point of time. In addition to build-time CONFIG_STACKDEPOT_ALWAYS_INIT,
> code that's e.g. processing boot parameters (which happens early enough)
> can call a new function stack_depot_want_early_init(), which sets a flag
> that stack_depot_early_init() will check.
>
> In this patch we also convert page_owner to this approach. While it
> doesn't have the bootstrap issue as slub, it's also a functionality
> enabled by a boot param and can thus request stack_depot_early_init()
> with memblock allocation instead of later initialization with
> kvmalloc().
>
> As suggested by Mike, make stack_depot_early_init() only attempt
> memblock allocation and stack_depot_init() only attempt kvmalloc().
> Also change the latter to kvcalloc(). In both cases we can lose the
> explicit array zeroing, which the allocations do already.
>
> As suggested by Marco, provide empty implementations of the init
> functions for !CONFIG_STACKDEPOT builds to simplify the callers.
>
> [1] https://lore.kernel.org/all/YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal/
>
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good, thanks!

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/stackdepot.h | 26 ++++++++++++---
>  lib/stackdepot.c           | 67 +++++++++++++++++++++++++-------------
>  mm/page_owner.c            |  9 +++--
>  3 files changed, 73 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 17f992fe6355..bc2797955de9 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -20,18 +20,36 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         gfp_t gfp_flags, bool can_alloc);
>
>  /*
> - * Every user of stack depot has to call this during its own init when it's
> - * decided that it will be calling stack_depot_save() later.
> + * Every user of stack depot has to call stack_depot_init() during its own init
> + * when it's decided that it will be calling stack_depot_save() later. This is
> + * recommended for e.g. modules initialized later in the boot process, when
> + * slab_is_available() is true.
>   *
>   * The alternative is to select STACKDEPOT_ALWAYS_INIT to have stack depot
>   * enabled as part of mm_init(), for subsystems where it's known at compile time
>   * that stack depot will be used.
> + *
> + * Another alternative is to call stack_depot_want_early_init(), when the
> + * decision to use stack depot is taken e.g. when evaluating kernel boot
> + * parameters, which precedes the enablement point in mm_init().
> + *
> + * stack_depot_init() and stack_depot_want_early_init() can be called regardless
> + * of CONFIG_STACKDEPOT and are no-op when disabled. The actual save/fetch/print
> + * functions should only be called from code that makes sure CONFIG_STACKDEPOT
> + * is enabled.
>   */
> +#ifdef CONFIG_STACKDEPOT
>  int stack_depot_init(void);
>
> -#ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
> -static inline int stack_depot_early_init(void) { return stack_depot_init(); }
> +void __init stack_depot_want_early_init(void);
> +
> +/* This is supposed to be called only from mm_init() */
> +int __init stack_depot_early_init(void);
>  #else
> +static inline int stack_depot_init(void) { return 0; }
> +
> +static inline void stack_depot_want_early_init(void) { }
> +
>  static inline int stack_depot_early_init(void) { return 0; }
>  #endif
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index bf5ba9af0500..0a5916f1e7a3 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -66,6 +66,9 @@ struct stack_record {
>         unsigned long entries[];        /* Variable-sized array of entries. */
>  };
>
> +static bool __stack_depot_want_early_init __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
> +static bool __stack_depot_early_init_passed __initdata;
> +
>  static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
>
>  static int depot_index;
> @@ -162,38 +165,58 @@ static int __init is_stack_depot_disabled(char *str)
>  }
>  early_param("stack_depot_disable", is_stack_depot_disabled);
>
> -/*
> - * __ref because of memblock_alloc(), which will not be actually called after
> - * the __init code is gone, because at that point slab_is_available() is true
> - */
> -__ref int stack_depot_init(void)
> +void __init stack_depot_want_early_init(void)
> +{
> +       /* Too late to request early init now */
> +       WARN_ON(__stack_depot_early_init_passed);
> +
> +       __stack_depot_want_early_init = true;
> +}
> +
> +int __init stack_depot_early_init(void)
> +{
> +       size_t size;
> +       int i;
> +
> +       /* This is supposed to be called only once, from mm_init() */
> +       if (WARN_ON(__stack_depot_early_init_passed))
> +               return 0;
> +
> +       __stack_depot_early_init_passed = true;
> +
> +       if (!__stack_depot_want_early_init || stack_depot_disable)
> +               return 0;
> +
> +       pr_info("Stack Depot early init allocating hash table with memblock_alloc\n");
> +       size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> +       stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
> +
> +       if (!stack_table) {
> +               pr_err("Stack Depot hash table allocation failed, disabling\n");
> +               stack_depot_disable = true;
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +int stack_depot_init(void)
>  {
>         static DEFINE_MUTEX(stack_depot_init_mutex);
> +       int ret = 0;
>
>         mutex_lock(&stack_depot_init_mutex);
>         if (!stack_depot_disable && !stack_table) {
> -               size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> -               int i;
> -
> -               if (slab_is_available()) {
> -                       pr_info("Stack Depot allocating hash table with kvmalloc\n");
> -                       stack_table = kvmalloc(size, GFP_KERNEL);
> -               } else {
> -                       pr_info("Stack Depot allocating hash table with memblock_alloc\n");
> -                       stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
> -               }
> -               if (stack_table) {
> -                       for (i = 0; i < STACK_HASH_SIZE;  i++)
> -                               stack_table[i] = NULL;
> -               } else {
> +               pr_info("Stack Depot allocating hash table with kvcalloc\n");
> +               stack_table = kvcalloc(STACK_HASH_SIZE, sizeof(struct stack_record *), GFP_KERNEL);
> +               if (!stack_table) {
>                         pr_err("Stack Depot hash table allocation failed, disabling\n");
>                         stack_depot_disable = true;
> -                       mutex_unlock(&stack_depot_init_mutex);
> -                       return -ENOMEM;
> +                       ret = -ENOMEM;
>                 }
>         }
>         mutex_unlock(&stack_depot_init_mutex);
> -       return 0;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_init);
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 99e360df9465..4313f8212a83 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -42,7 +42,12 @@ static void init_early_allocated_pages(void);
>
>  static int __init early_page_owner_param(char *buf)
>  {
> -       return kstrtobool(buf, &page_owner_enabled);
> +       int ret = kstrtobool(buf, &page_owner_enabled);
> +
> +       if (page_owner_enabled)
> +               stack_depot_want_early_init();
> +
> +       return ret;
>  }
>  early_param("page_owner", early_page_owner_param);
>
> @@ -80,8 +85,6 @@ static __init void init_page_owner(void)
>         if (!page_owner_enabled)
>                 return;
>
> -       stack_depot_init();
> -
>         register_dummy_stack();
>         register_failure_stack();
>         register_early_stack();
> --
> 2.35.1
>
>
