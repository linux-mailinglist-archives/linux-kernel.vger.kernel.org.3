Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4D5ADA75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIEU5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:57:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB706557B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:57:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w18so6921695qki.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A5axt41xdYGJpJPcn4Sev3jL+k5PJhD8nmirmVBCOls=;
        b=ltToOAezGCZGex5LTki91PDHQ+TdO1VRHjFFHP9gO96muSjfCXlFudGBI3zseKZhht
         bCtKZzRHpFsfdlIguJONu8bXsLHRnJVRtXFR6Mk1lNQscExdUmvXyLvpcDRiXSbBkO++
         PmyPPDRg0ruhJEQJ+jCdPZo0EMiuPH5tMNkZO9Sj6nm//DSmm0ummL3eaCrPDXrWmti2
         BJ5/8MOW16JFt1bYKNkYqcrNo//N8sJz+9np2ZaoCvpyfFz+rCreepxxPuTbiLPR2gBn
         JNsX8Ba4rPiHgS/yc1dxcX9HAUFt0NJaYYZa3plv6a34j6NEEKC7J7RqoQZ+2D2RrSE2
         sixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A5axt41xdYGJpJPcn4Sev3jL+k5PJhD8nmirmVBCOls=;
        b=zPmw0W08Ori0vgw2ICtqwptteyth/pH1lXWBArcFZl647YTeES8ulsp73dq4LRij+d
         dVQiA7Pi7a24KvFs/VFIPZh7N0CyUQGkAgjRrBf/WRfP3cK9L0Gu0bC0CBgJfhdG6med
         7Eh0mopDKLfBqShMIXu24+vvyCv/j3Zvb4dtPAxUV73yGxKDhukJDFs2gfiNP9zX2gkU
         uagwfO1yojheMguudw+K/TaJ56Hl3pmb/GIW+a3evB/v9Ln/YyxshxTUjtnskROWhQHB
         ZSVkd5so32cQFsZOomgRPbnkkufm2JgVjWjLAo68xRX33QnHUnzkpImrWvzwwyBUHZyy
         X39A==
X-Gm-Message-State: ACgBeo0ms5307ZIRvlWVXm2h5lo0lJfF6SRwQwj+O485PUcGzKjZicd2
        KYZ1mpE+pKZ3gmvbg7I8Je9B2zrf22Gqpv+gujw=
X-Google-Smtp-Source: AA6agR6vTBCt6zs18wrI5wIbmrr4kE+Gw9unMUAnSC1aHvWDAPPLe6V4FiSfMrvPpZpgjVjU/FLBxPJ8Jyc4zFU+O+I=
X-Received: by 2002:a05:620a:1298:b0:6be:9bec:b555 with SMTP id
 w24-20020a05620a129800b006be9becb555mr22895322qki.146.1662411450924; Mon, 05
 Sep 2022 13:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-2-osalvador@suse.de>
In-Reply-To: <20220905031012.4450-2-osalvador@suse.de>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Sep 2022 22:57:20 +0200
Message-ID: <CA+fCnZcNr2JeCkTF=uCxjPCJKFi_d1chv0tjubvMisUdQtCeRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/stackdepot: Add a refcount field in stack_record
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
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

On Mon, Sep 5, 2022 at 5:10 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> We want to filter out page_owner output and print only those
> stacks that have been repeated beyond a certain threshold.
> This gives us the chance to get rid of a lot of noise.
> In order to do that, we need to keep track of how many repeated stacks
> (for allocation) do we have, so we add a new refcount_t field
> in the stack_record struct.
>
> Note that this might increase the size of the struct for some
> architectures.
> E.g: x86_64 is not affected due to alignment, but x86 32bits might.
>
> The alternative would be to have some kind of struct like this:
>
> struct track_stacks {
>         struct stack_record *stack;
>         struct track_stacks *next;
>         refcount_t stack_count;
>
> But ithat would imply to perform more allocations and glue everything
> together, which would make the code more complex, so I think that
> going with a new field in the struct stack_record is good enough.
>
> Note that on __set_page_owner_handle(), page_owner->handle is set,
> and on __reset_page_owner(), page_owner->free_handle is set.
>
> We are interested in page_owner->handle, so when __set_page_owner()
> gets called, we derive the stack_record struct from page_owner->handle,
> and we increment its refcount_t field; and when __reset_page_owner()
> gets called, we derive its stack_record from page_owner->handle()
> and we decrement its refcount_t field.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h | 13 ++++++-
>  lib/stackdepot.c           | 79 +++++++++++++++++++++++++++++++-------
>  mm/kasan/common.c          |  3 +-
>  mm/page_owner.c            | 14 +++++--
>  4 files changed, 89 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index bc2797955de9..4e3a88f135ee 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -15,9 +15,16 @@
>
>  typedef u32 depot_stack_handle_t;
>
> +enum stack_depot_action {
> +       STACK_DEPOT_ACTION_NONE,
> +       STACK_DEPOT_ACTION_COUNT,
> +};

Hi Oscar,

Why do we need these actions? Why not just increment the refcount on
each stack trace save?

> +
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> -                                       gfp_t gfp_flags, bool can_alloc);
> +                                       gfp_t gfp_flags, bool can_alloc,
> +                                       enum stack_depot_action action);
> +void stack_depot_dec_count(depot_stack_handle_t handle);
>
>  /*
>   * Every user of stack depot has to call stack_depot_init() during its own init
> @@ -55,6 +62,10 @@ static inline int stack_depot_early_init(void)       { return 0; }
>
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries, gfp_t gfp_flags);
> +depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
> +                                            unsigned int nr_entries,
> +                                            gfp_t gfp_flags,
> +                                            enum stack_depot_action action);
>
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries);
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index e73fda23388d..a806ef58a385 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -64,6 +64,7 @@ struct stack_record {
>         u32 hash;                       /* Hash in the hastable */
>         u32 size;                       /* Number of frames in the stack */
>         union handle_parts handle;
> +       refcount_t count;               /* Number of the same repeated stacks */
>         unsigned long entries[];        /* Variable-sized array of entries. */
>  };
>
> @@ -140,6 +141,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>         stack->handle.slabindex = depot_index;
>         stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
>         stack->handle.valid = 1;
> +       refcount_set(&stack->count, 1);
>         memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
>         depot_offset += required_size;
>
> @@ -341,6 +343,29 @@ void stack_depot_print(depot_stack_handle_t stack)
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_print);
>
> +static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
> +{
> +       union handle_parts parts = { .handle = handle };
> +       void *slab;
> +       size_t offset = parts.offset << STACK_ALLOC_ALIGN;
> +       struct stack_record *stack;
> +
> +       if(!handle)
> +               return NULL;
> +
> +       if (parts.slabindex > depot_index) {
> +               WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
> +                    parts.slabindex, depot_index, handle);
> +               return NULL;
> +       }
> +       slab = stack_slabs[parts.slabindex];
> +       if (!slab)
> +               return NULL;
> +
> +       stack = slab + offset;
> +       return stack;
> +}
> +
>  /**
>   * stack_depot_fetch - Fetch stack entries from a depot
>   *
> @@ -353,30 +378,42 @@ EXPORT_SYMBOL_GPL(stack_depot_print);
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries)
>  {
> -       union handle_parts parts = { .handle = handle };
> -       void *slab;
> -       size_t offset = parts.offset << STACK_ALLOC_ALIGN;
>         struct stack_record *stack;
>
>         *entries = NULL;
>         if (!handle)
>                 return 0;
>
> -       if (parts.slabindex > depot_index) {
> -               WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
> -                       parts.slabindex, depot_index, handle);
> -               return 0;
> -       }
> -       slab = stack_slabs[parts.slabindex];
> -       if (!slab)
> +       stack = stack_depot_getstack(handle);
> +       if (!stack)
>                 return 0;
> -       stack = slab + offset;
>
>         *entries = stack->entries;
>         return stack->size;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_fetch);
>
> +static void stack_depot_inc_count(struct stack_record *stack)
> +{
> +       refcount_inc(&stack->count);
> +}
> +
> +void stack_depot_dec_count(depot_stack_handle_t handle)
> +{
> +       struct stack_record *stack = NULL;
> +
> +       stack = stack_depot_getstack(handle);
> +       if (stack) {
> +               /*
> +                * page_owner creates some stacks via create_dummy_stack().
> +                * We are not interested in those, so make sure we only decrement
> +                * "valid" stacks.
> +                */
> +               if (refcount_read(&stack->count) > 1)
> +                       refcount_dec(&stack->count);
> +       }
> +}
> +
>  /**
>   * __stack_depot_save - Save a stack trace from an array
>   *
> @@ -402,7 +439,8 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   */
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> -                                       gfp_t alloc_flags, bool can_alloc)
> +                                       gfp_t alloc_flags, bool can_alloc,
> +                                       enum stack_depot_action action)
>  {
>         struct stack_record *found = NULL, **bucket;
>         depot_stack_handle_t retval = 0;
> @@ -488,8 +526,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                 /* Nobody used this memory, ok to free it. */
>                 free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
>         }
> -       if (found)
> +       if (found) {
>                 retval = found->handle.handle;
> +               if (action == STACK_DEPOT_ACTION_COUNT)
> +                       stack_depot_inc_count(found);
> +       }
>  fast_exit:
>         return retval;
>  }
> @@ -511,6 +552,16 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries,
>                                       gfp_t alloc_flags)
>  {
> -       return __stack_depot_save(entries, nr_entries, alloc_flags, true);
> +       return __stack_depot_save(entries, nr_entries, alloc_flags, true,
> +                                 STACK_DEPOT_ACTION_NONE);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> +
> +depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
> +                                            unsigned int nr_entries,
> +                                            gfp_t alloc_flags,
> +                                            enum stack_depot_action action)
> +{
> +       return __stack_depot_save(entries, nr_entries, alloc_flags, true, action);
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_save_action);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 69f583855c8b..8077c6e70815 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>         unsigned int nr_entries;
>
>         nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -       return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> +       return __stack_depot_save(entries, nr_entries, flags, can_alloc,
> +                                 STACK_DEPOT_ACTION_NONE);
>  }
>
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..8730f377fa91 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c

Could you split out the stack depot and the page_owner changes into
separate patches?

> @@ -106,7 +106,8 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
>         return (void *)page_ext + page_owner_ops.offset;
>  }
>
> -static noinline depot_stack_handle_t save_stack(gfp_t flags)
> +static noinline depot_stack_handle_t save_stack(gfp_t flags,
> +                                               enum stack_depot_action action)
>  {
>         unsigned long entries[PAGE_OWNER_STACK_DEPTH];
>         depot_stack_handle_t handle;
> @@ -125,7 +126,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
>         current->in_page_owner = 1;
>
>         nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
> -       handle = stack_depot_save(entries, nr_entries, flags);
> +       handle = stack_depot_save_action(entries, nr_entries, flags, action);
>         if (!handle)
>                 handle = failure_handle;
>
> @@ -138,6 +139,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>         int i;
>         struct page_ext *page_ext;
>         depot_stack_handle_t handle;
> +       depot_stack_handle_t alloc_handle;
>         struct page_owner *page_owner;
>         u64 free_ts_nsec = local_clock();
>
> @@ -145,7 +147,10 @@ void __reset_page_owner(struct page *page, unsigned short order)
>         if (unlikely(!page_ext))
>                 return;
>
> -       handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> +       page_owner = get_page_owner(page_ext);
> +       alloc_handle = page_owner->handle;
> +
> +       handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_DEPOT_ACTION_NONE);
>         for (i = 0; i < (1 << order); i++) {
>                 __clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>                 page_owner = get_page_owner(page_ext);
> @@ -153,6 +158,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>                 page_owner->free_ts_nsec = free_ts_nsec;
>                 page_ext = page_ext_next(page_ext);
>         }
> +       stack_depot_dec_count(alloc_handle);
>  }
>
>  static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -189,7 +195,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>         if (unlikely(!page_ext))
>                 return;
>
> -       handle = save_stack(gfp_mask);
> +       handle = save_stack(gfp_mask, STACK_DEPOT_ACTION_COUNT);
>         __set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  }
>
> --
> 2.35.3
>
