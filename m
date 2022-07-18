Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC198578DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiGRWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiGRWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:42:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B42BB20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:42:14 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id l3so7774051qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Srf+AYvhoPZ4SANiE5r//Mtt56L7Cxm65IjKMxEOpbM=;
        b=TMkZVh5cRXYdusuziYLkDihvUfczQKJGa6SnTrPUBD0CFe8rd9W6aypO13w8ZEgafs
         pM6ghhD2hz2uvswuYMl+l6dJraSgQni8sAMSwXil/QcZDiJJV3GR8Zq6it/MOH15BqJx
         kf6Y8333ko9fS2NkYgAhl/4TnOXX8hc+aukzYLv+C5tcKIHdNXZT30Kh8aDSOPhLrktt
         ewAUNoNIUE7335HUHBDfeZf8kgbDs6gwTakDK2/qNrC//Ci+0Zzd6BjoCl5d8Jvh8tvk
         hgwJIPqBdyM8DznRS7IV18v+gtcOrgy/5PN6Vq9wd7wDB5Zwdr5R/lyBeCIB62iIVtFs
         HdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Srf+AYvhoPZ4SANiE5r//Mtt56L7Cxm65IjKMxEOpbM=;
        b=VRcBKdSiFjsHe2eVTMbPL+jko7yveGBnCtW9OcWCs/kO6EN6NYa4jdHmWlY1hxzt/H
         txtuMLG0/7eviWZM+p0MvUKdB2Wik93TCmc+ZJy+pKx+sZH5kt7RYwthQi/x3Kg2+yl4
         kFcm7/B+mL3HAWmr+CQseLJK7B8Mgumqi/UPLct0+y5pFdKxbWqfNwOE/p7q+xpF//kK
         7lluHO7cqagIJx12Vc0yAj+XXPSUO5fVjQL0jptjdfW3aqx4SJQlExzZeQEJ/Dr69oJM
         3lt5kEwYQ69X6THeyImYnncvPY196Dst/Hq2qiKt/qHXast884PdItt6k6EzhSVkMW2m
         RmpA==
X-Gm-Message-State: AJIora94q2BWzidDpu2rFRdUvWGi4/S71BdFDCHWxJPgfqI1wBQSjJCw
        yeniJUMv/DwQ9YZViVLO7m4WEgKX7Dtgcc6sFGW6hN/c
X-Google-Smtp-Source: AGRyM1shEhBbf2LtPRjG9yy2NUNITEJg83Tr7CVIPIIgx41eBcNi+fxHZ9b/xdC38HxZjPel/BrbLMsgkVhbY91ic/E=
X-Received: by 2002:a37:4644:0:b0:6af:271e:a510 with SMTP id
 t65-20020a374644000000b006af271ea510mr20013693qka.515.1658184133183; Mon, 18
 Jul 2022 15:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <3cd76121903de13713581687ffa45e668ef1475a.1655150842.git.andreyknvl@google.com>
 <YrB3l6A4hJmvsFp3@elver.google.com>
In-Reply-To: <YrB3l6A4hJmvsFp3@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 19 Jul 2022 00:42:02 +0200
Message-ID: <CA+fCnZd5iataHnyBv9CVaXKN-2Ac=yLdODweMDiQB70nHZtpOA@mail.gmail.com>
Subject: Re: [PATCH 31/32] kasan: implement stack ring for tag-based modes
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 3:35 PM Marco Elver <elver@google.com> wrote:
>
> > The number of entries in the stack ring is fixed in this version of the
> > patch. We could either implement it as a config option or a command-line
> > argument. I tilt towards the latter option and will implement it in v2
> > unless there are objections.
>
> Yes, that'd be good, along with just not allocating if no stacktraces
> are requested per kasan.stacktrace=.

Sounds good, will do in v2.

> > +struct kasan_stack_ring_entry {
> > +     atomic64_t ptr;         /* void * */
> > +     atomic64_t size;        /* size_t */
> > +     atomic_t pid;           /* u32 */
> > +     atomic_t stack;         /* depot_stack_handle_t */
> > +     atomic_t is_free;       /* bool */
>
> Per comments below, consider making these non-atomic.

Will do in v2.

> >  void kasan_complete_mode_report_info(struct kasan_report_info *info)
> >  {
> > +     u64 pos;
> > +     struct kasan_stack_ring_entry *entry;
> > +     void *object;
> > +     u32 pid;
> > +     depot_stack_handle_t stack;
> > +     bool is_free;
>
> If you switch away from atomic for kasan_stack_ring_entry members, you
> can just replace the above with a 'struct kasan_stack_ring_entry' and
> READ_ONCE() each entry into it below.

It would be a bit confusing to have two kasan_stack_ring_entry-based
variable in the function. I'll keep the current code if you don't
mind.

> > +     bool alloc_found = false, free_found = false;
> > +
> >       info->bug_type = get_bug_type(info);
> > +
> > +     if (!info->cache || !info->object)
> > +             return;
> > +
> > +     pos = atomic64_read(&stack_ring.pos);
> > +
> > +     for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_ENTRIES; i--) {
> > +             if (alloc_found && free_found)
> > +                     break;
> > +
> > +             entry = &stack_ring.entries[i % KASAN_STACK_RING_ENTRIES];
> > +
> > +             /* Paired with atomic64_set_release() in save_stack_info(). */
> > +             object = (void *)atomic64_read_acquire(&entry->ptr);
> > +
> > +             if (kasan_reset_tag(object) != info->object ||
> > +                 get_tag(object) != get_tag(info->access_addr))
> > +                     continue;
> > +
> > +             pid = atomic_read(&entry->pid);
> > +             stack = atomic_read(&entry->stack);
> > +             is_free = atomic_read(&entry->is_free);
> > +
> > +             /* Try detecting if the entry was changed while being read. */
> > +             smp_mb();
> > +             if (object != (void *)atomic64_read(&entry->ptr))
> > +                     continue;
>
> What if the object was changed, but 'ptr' is the same? It might very
> well be possible to then read half of the info of the previous object,
> and half of the new object (e.g. pid is old, stack is new).
>
> Is the assumption that it is extremely unlikely that this will happen
> where 1) address is the same, and 2) tags are the same? And if it does
> happen, it is unlikely that there'll be a bug on that address?
>
> It might be worth stating this in comments.

This part will be removed in v2 due to the addition of an rwlock, but
I'll add a comment about the stack ring being best-effort anyway.

> Another thing is, if there's a bug, but concurrently you have tons of
> allocations/frees that change the ring's entries at a very high rate,
> how likely is it that the entire ring will have been wiped before the
> entry of interest is found again?
>
> One way to guard against this is to prevent modifications of the ring
> while the ring is searched. This could be implemented with a
> percpu-rwsem, which is almost free for read-lockers but very expensive
> for write-lockers. Insertions only acquire a read-lock, but on a bug
> when searching the ring, you have to acquire a write-lock. Although you
> currently take the contention hit for incrementing 'pos', so a plain
> rwlock might also be ok.

Will add an rwlock in v2.

> It would be good to understand the probabilities of these corner cases
> with some average to worst case workloads, and optimize based on that.

With the new synchronizations and checks added in v2, the only
problematic issue is when the stack ring overflows. Please see my
response to your cover letter comment wrt this.

> > +struct kasan_stack_ring stack_ring;
>
> This is a very large struct. Can it be allocated by memblock_alloc()
> very early on only if required (kasan.stacktrace= can still switch it
> off, right?).

Will do in v2.

> > +void save_stack_info(struct kmem_cache *cache, void *object,
> > +                     gfp_t flags, bool is_free)
>
> static void save_stack_info(...)

Right, will do in v2.

> > +{
> > +     u64 pos;
> > +     struct kasan_stack_ring_entry *entry;
> > +     depot_stack_handle_t stack;
> > +
> > +     stack = kasan_save_stack(flags, true);
> > +
> > +     pos = atomic64_fetch_add(1, &stack_ring.pos);
> > +     entry = &stack_ring.entries[pos % KASAN_STACK_RING_ENTRIES];
> > +
> > +     atomic64_set(&entry->size, cache->object_size);
> > +     atomic_set(&entry->pid, current->pid);
> > +     atomic_set(&entry->stack, stack);
> > +     atomic_set(&entry->is_free, is_free);
> > +
>
> I don't see the point of these being atomic. You can make them normal
> variables with the proper types, and use READ_ONCE() / WRITE_ONCE().
>
> The only one where you truly need the atomic type is 'pos'.

Will do in v2.

> > +     /*
> > +      * Paired with atomic64_read_acquire() in
> > +      * kasan_complete_mode_report_info().
> > +      */
> > +     atomic64_set_release(&entry->ptr, (s64)object);
>
> This could be smp_store_release() and 'ptr' can be just a normal pointer.

Will do in v2.

> One thing that is not entirely impossible though (vs. re-reading same
> pointer but inconsistent fields I mentioned above), is if something
> wants to write to the ring, but stalls for a very long time before the
> release of 'ptr', giving 'pos' the chance to wrap around and another
> writer writing the same entry. Something like:
>
>   T0                                    | T1
>   --------------------------------------+--------------------------------
>   WRITE_ONCE(entry->size, ..)           |
>   WRITE_ONCE(entry->pid, ..)            |
>                                         | WRITE_ONCE(entry->size, ..)
>                                         | WRITE_ONCE(entry->pid, ..)
>                                         | WRITE_ONCE(entry->stack, ..)
>                                         | WRITE_ONCE(entry->is_free, ..)
>                                         | smp_store_release(entry->ptr, ...)
>   WRITE_ONCE(entry->stack, ..)          |
>   WRITE_ONCE(entry->is_free, ..)        |
>   smp_store_release(entry->ptr, ...)    |
>
> Which results in some mix of T0's and T1's data.
>
> The way to solve this is to implement a try-lock using 'ptr':
>
>         #define BUSY_PTR ((void*)1)  // non-zero because initial values are 0
>         old_ptr = READ_ONCE(entry->ptr);
>         if (old_ptr == BUSY_PTR)
>                 goto next; /* Busy slot. */
>         if (!try_cmpxchg(&entry->ptr, &old_ptr, BUSY_PTR))
>                 goto next; /* Busy slot. */
>         ... set fields as before ...
>         smp_store_release(&entry->ptr, object);

Sounds good, will do in v2.

Thank you, Marco!
