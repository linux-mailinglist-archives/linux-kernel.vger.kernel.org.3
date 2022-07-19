Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B75798A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiGSLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiGSLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:41:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C123F304
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:41:41 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef5380669cso137429107b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xi609iWd+t1xpxJ70rNlw8Yfb5LgcoJNw18fVkapUSc=;
        b=mXoGlvDqg1Xak8fNrrAPXaZLGTkisG3gqkOez/GJCX8klSIoirhV61XNHDkNUM6q1+
         4CNX4Qkn7bmgiWDcO+MBzUqGkOg5vVvPWcIUnwBVQ/1uIQKqDzYri+SIW4EgWz/M/CDY
         Na6bItbeF65BGH3AcvtMtFv5vVGtLDhv1zx7ufNpTGOL3CcB7mNgXeOUPrQu3+fl4ACV
         ubc62d8XfJXpXj4ENO1Git/6Vja0GgEta/nKSIcqzW1UYVeKueUr0d8j+aifNnco4LD4
         k1Un1EpFT+up0iOJPjAnouXDRgC1RhaPLXcVoPKzXbZuUd9EBZ39YQys70pJnr7/RzUc
         RBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xi609iWd+t1xpxJ70rNlw8Yfb5LgcoJNw18fVkapUSc=;
        b=DXwewZ+Fz1y8C5jqYbY5gdakQ6oYtfQqLmr5mD4C0g/my1Qa/vbKx29lOgOHuEUyRx
         41I/kDXzrPseQXX4hEsjaUQeSrfwIUcWh/fzf0TpLJ8b9s2tf4bvAzOgVIy2m5QUWMBm
         VPEN8xTi7x67gROQdapUW/tAyKvS8XVFtKfo6Phsc0FIsj75QIwSu7lqFcAFe7YgcFXx
         uXPYxKePEPTsh0jvjS7OShwO+SPITImrSwBnTfexmitfb4kvm/K0kmAdLI5W5bS2FSnq
         nTkpkluUokdJjvecXLNQUYd5xNYINioE16DZQeg073h1e/no6tevOGX4av6sW0jt4G1/
         zyLg==
X-Gm-Message-State: AJIora8BysqQo89Fyf/0hDt4wcej5QbDyAutfGSX5wJaP6Whks/Yc+tX
        Fx5iZWDaMKS+K5uCDm+ozIKh+6V1jS9My+90PKlnTQ==
X-Google-Smtp-Source: AGRyM1umpwwQl+mM7wE1Ymxs73iZxo2rJwoQ4M5S8YNTd/RKBQkHaxU30mH7+ChcbBiei6IG2NMlaleqf9tGlEKXblM=
X-Received: by 2002:a0d:e60d:0:b0:31c:8046:8ff with SMTP id
 p13-20020a0de60d000000b0031c804608ffmr36027909ywe.412.1658230900185; Tue, 19
 Jul 2022 04:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658189199.git.andreyknvl@google.com> <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
In-Reply-To: <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Jul 2022 13:41:04 +0200
Message-ID: <CANpmjNMrwXxU0YCwvHo59RFDkoxA-MtdrRCSPoRW+KYG2ez-NQ@mail.gmail.com>
Subject: Re: [PATCH mm v2 30/33] kasan: implement stack ring for tag-based modes
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 at 02:15, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Implement storing stack depot handles for alloc/free stack traces for
> slab objects for the tag-based KASAN modes in a ring buffer.
>
> This ring buffer is referred to as the stack ring.
>
> On each alloc/free of a slab object, the tagged address of the object and
> the current stack trace are recorded in the stack ring.
>
> On each bug report, if the accessed address belongs to a slab object, the
> stack ring is scanned for matching entries. The newest entries are used to
> print the alloc/free stack traces in the report: one entry for alloc and
> one for free.
>
> The number of entries in the stack ring is fixed in this patch, but one of
> the following patches adds a command-line argument to control it.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v1->v2:
> - Only use the atomic type for pos, use READ/WRITE_ONCE() for the rest.
> - Rename KASAN_STACK_RING_ENTRIES to KASAN_STACK_RING_SIZE.
> - Rename object local variable in kasan_complete_mode_report_info() to
>   ptr to match the name in kasan_stack_ring_entry.
> - Detect stack ring entry slots that are being written to.
> - Use read-write lock to disallow reading half-written stack ring entries.
> - Add a comment about the stack ring being best-effort.
> ---
>  mm/kasan/kasan.h       | 21 ++++++++++++
>  mm/kasan/report_tags.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/tags.c        | 50 +++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 7df107dc400a..cfff81139d67 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -2,6 +2,7 @@
>  #ifndef __MM_KASAN_KASAN_H
>  #define __MM_KASAN_KASAN_H
>
> +#include <linux/atomic.h>
>  #include <linux/kasan.h>
>  #include <linux/kasan-tags.h>
>  #include <linux/kfence.h>
> @@ -233,6 +234,26 @@ struct kasan_free_meta {
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +
> +struct kasan_stack_ring_entry {
> +       void *ptr;
> +       size_t size;
> +       u32 pid;
> +       depot_stack_handle_t stack;
> +       bool is_free;
> +};
> +
> +#define KASAN_STACK_RING_SIZE (32 << 10)
> +
> +struct kasan_stack_ring {
> +       rwlock_t lock;
> +       atomic64_t pos;
> +       struct kasan_stack_ring_entry entries[KASAN_STACK_RING_SIZE];
> +};
> +
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>  /* Used in KUnit-compatible KASAN tests. */
>  struct kunit_kasan_status {
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index 5cbac2cdb177..a996489e6dac 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -4,8 +4,12 @@
>   * Copyright (c) 2020 Google, Inc.
>   */
>
> +#include <linux/atomic.h>
> +
>  #include "kasan.h"
>
> +extern struct kasan_stack_ring stack_ring;
> +
>  static const char *get_bug_type(struct kasan_report_info *info)
>  {
>         /*
> @@ -24,5 +28,77 @@ static const char *get_bug_type(struct kasan_report_info *info)
>
>  void kasan_complete_mode_report_info(struct kasan_report_info *info)
>  {
> +       unsigned long flags;
> +       u64 pos;
> +       struct kasan_stack_ring_entry *entry;
> +       void *ptr;
> +       u32 pid;
> +       depot_stack_handle_t stack;
> +       bool is_free;
> +       bool alloc_found = false, free_found = false;
> +
>         info->bug_type = get_bug_type(info);
> +
> +       if (!info->cache || !info->object)
> +               return;
> +       }
> +
> +       write_lock_irqsave(&stack_ring.lock, flags);
> +
> +       pos = atomic64_read(&stack_ring.pos);
> +
> +       /*
> +        * The loop below tries to find stack ring entries relevant to the
> +        * buggy object. This is a best-effort process.
> +        *
> +        * First, another object with the same tag can be allocated in place of
> +        * the buggy object. Also, since the number of entries is limited, the
> +        * entries relevant to the buggy object can be overwritten.
> +        */
> +
> +       for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
> +               if (alloc_found && free_found)
> +                       break;
> +
> +               entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
> +
> +               /* Paired with smp_store_release() in save_stack_info(). */
> +               ptr = (void *)smp_load_acquire(&entry->ptr);
> +
> +               if (kasan_reset_tag(ptr) != info->object ||
> +                   get_tag(ptr) != get_tag(info->access_addr))
> +                       continue;
> +
> +               pid = READ_ONCE(entry->pid);
> +               stack = READ_ONCE(entry->stack);
> +               is_free = READ_ONCE(entry->is_free);
> +
> +               /* Try detecting if the entry was changed while being read. */
> +               smp_mb();
> +               if (ptr != (void *)READ_ONCE(entry->ptr))
> +                       continue;

I thought the re-validation is no longer needed because of the rwlock
protection?

The rest looks fine now.

> +               if (is_free) {
> +                       /*
> +                        * Second free of the same object.
> +                        * Give up on trying to find the alloc entry.
> +                        */
> +                       if (free_found)
> +                               break;
> +
> +                       info->free_track.pid = pid;
> +                       info->free_track.stack = stack;
> +                       free_found = true;
> +               } else {
> +                       /* Second alloc of the same object. Give up. */
> +                       if (alloc_found)
> +                               break;
> +
> +                       info->alloc_track.pid = pid;
> +                       info->alloc_track.stack = stack;
> +                       alloc_found = true;
> +               }
> +       }
> +
> +       write_unlock_irqrestore(&stack_ring.lock, flags);
>  }
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 39a0481e5228..07828021c1f5 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2020 Google, Inc.
>   */
>
> +#include <linux/atomic.h>
>  #include <linux/init.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> @@ -16,11 +17,60 @@
>  #include <linux/types.h>
>
>  #include "kasan.h"
> +#include "../slab.h"
> +
> +/* Non-zero, as initial pointer values are 0. */
> +#define STACK_RING_BUSY_PTR ((void *)1)
> +
> +struct kasan_stack_ring stack_ring;
> +
> +static void save_stack_info(struct kmem_cache *cache, void *object,
> +                       gfp_t gfp_flags, bool is_free)
> +{
> +       unsigned long flags;
> +       depot_stack_handle_t stack;
> +       u64 pos;
> +       struct kasan_stack_ring_entry *entry;
> +       void *old_ptr;
> +
> +       stack = kasan_save_stack(gfp_flags, true);
> +
> +       /*
> +        * Prevent save_stack_info() from modifying stack ring
> +        * when kasan_complete_mode_report_info() is walking it.
> +        */
> +       read_lock_irqsave(&stack_ring.lock, flags);
> +
> +next:
> +       pos = atomic64_fetch_add(1, &stack_ring.pos);
> +       entry = &stack_ring.entries[pos % KASAN_STACK_RING_SIZE];
> +
> +       /* Detect stack ring entry slots that are being written to. */
> +       old_ptr = READ_ONCE(entry->ptr);
> +       if (old_ptr == STACK_RING_BUSY_PTR)
> +               goto next; /* Busy slot. */
> +       if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
> +               goto next; /* Busy slot. */
> +
> +       WRITE_ONCE(entry->size, cache->object_size);
> +       WRITE_ONCE(entry->pid, current->pid);
> +       WRITE_ONCE(entry->stack, stack);
> +       WRITE_ONCE(entry->is_free, is_free);
> +
> +       /*
> +        * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
> +        */
> +       smp_store_release(&entry->ptr, (s64)object);
> +
> +       read_unlock_irqrestore(&stack_ring.lock, flags);
> +}
>
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
> +       save_stack_info(cache, object, flags, false);
>  }
>
>  void kasan_save_free_info(struct kmem_cache *cache, void *object)
>  {
> +       save_stack_info(cache, object, GFP_NOWAIT, true);
>  }
> --
> 2.25.1
>
