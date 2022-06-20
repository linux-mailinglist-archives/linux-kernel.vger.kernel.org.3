Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC95F551DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbiFTOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352288AbiFTOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:19:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1312245AFC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:35:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k22so8277103wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HAkMTw3RnZa1KmlhutNG14tDB6CYw3hV2uXbql6UXzk=;
        b=rsOpJuRQ634Ht78Ep9ObYxrBzRt/llobGkDoMHQjo/94HmvfKyKD9hZACJY7J2TgIM
         iRW3h4pwbDjRlxm8ppqDxkN0Hd0pEob4agFuEMa6ap2R52AFQpj1RoM8aeZfZfIjz3Fk
         gwPNVu273uMSEqaNLYrojjRWKXr2KHfwz/wjhSeFo/6uPPJcXJZmXyIbT6M/uar1LYO9
         RkHC7EN9k5fa17QXxW7EpEU/AbcuDukkhC2uSN+0eUWNlIlHuSnlW6RMXRsXcuFBjDQ9
         5KAiVETxgcMTOsKOyG3DfXK3rFKFDqxEZDTE2VpRiGY8PVi58GjLWhz+ytgG/CmqWxcw
         dCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAkMTw3RnZa1KmlhutNG14tDB6CYw3hV2uXbql6UXzk=;
        b=PJ+MdUN9ZN+gXG+gaf6A+JhtW3h7kc8jzoJsHkxg8NyNVvVUF5fOx4k37SWcaVxTzd
         L0zRqoWwGxhis0DRmXUwdVTAf95BoHwUWDjMCzIVSOGWuZccfCPrsM4zpEVmlztTcR1Y
         ApldvVjXY5nDG+3uPrFvdMuECBzGzVRMNMcCjX+PDQf7UgHPCER50JtKOt0PCyDyThRh
         Ne/C6lm34RkYKGofZU2X43XXculGMYQRIB1JfeH0MxT/fechly/4qVfTIPyXGLzdASL6
         W6O699XKXCyL+Nz4Z6i8wXh0XVHiw/CalUBdfC2tUECZa01dJ8PHQ/6STmTDnGR/A6lw
         vzvg==
X-Gm-Message-State: AJIora/awgTFB5vAhnwrK/BmTPuITzUgmx/FUHnFsb1iXLVhFvdrrrIU
        LM08NP9PPCPARfL53e8Di+tzCQ==
X-Google-Smtp-Source: AGRyM1uDBZ7ZcU+TuimOB800Vg2oQ3vHyIdea33vQaD4+rXTwns638kce4yys9G5U9X3EQvUO5kN9w==
X-Received: by 2002:adf:ec4f:0:b0:21b:90c0:139e with SMTP id w15-20020adfec4f000000b0021b90c0139emr4242107wrn.550.1655732126280;
        Mon, 20 Jun 2022 06:35:26 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3746:a989:7595:e29f])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm27203906wms.3.2022.06.20.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:35:25 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:35:19 +0200
From:   Marco Elver <elver@google.com>
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
Subject: Re: [PATCH 31/32] kasan: implement stack ring for tag-based modes
Message-ID: <YrB3l6A4hJmvsFp3@elver.google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
 <3cd76121903de13713581687ffa45e668ef1475a.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd76121903de13713581687ffa45e668ef1475a.1655150842.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
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

On Mon, Jun 13, 2022 at 10:14PM +0200, andrey.konovalov@linux.dev wrote:
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
> The ring buffer is lock-free.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> The number of entries in the stack ring is fixed in this version of the
> patch. We could either implement it as a config option or a command-line
> argument. I tilt towards the latter option and will implement it in v2
> unless there are objections.

Yes, that'd be good, along with just not allocating if no stacktraces
are requested per kasan.stacktrace=.

> ---
>  mm/kasan/kasan.h       | 20 ++++++++++++++
>  mm/kasan/report_tags.c | 61 ++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/tags.c        | 30 +++++++++++++++++++++
>  3 files changed, 111 insertions(+)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index c51cea31ced0..da9a3c56ef4b 100644
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
> @@ -227,6 +228,25 @@ struct kasan_free_meta {
>  
>  #endif /* CONFIG_KASAN_GENERIC */
>  
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +
> +struct kasan_stack_ring_entry {
> +	atomic64_t ptr;		/* void * */
> +	atomic64_t size;	/* size_t */
> +	atomic_t pid;		/* u32 */
> +	atomic_t stack;		/* depot_stack_handle_t */
> +	atomic_t is_free;	/* bool */

Per comments below, consider making these non-atomic.

> +};
> +
> +#define KASAN_STACK_RING_ENTRIES (32 << 10)
> +
> +struct kasan_stack_ring {
> +	atomic64_t pos;
> +	struct kasan_stack_ring_entry entries[KASAN_STACK_RING_ENTRIES];
> +};
> +
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>  /* Used in KUnit-compatible KASAN tests. */
>  struct kunit_kasan_status {
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index 5cbac2cdb177..21911d1883d3 100644
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
>  	/*
> @@ -24,5 +28,62 @@ static const char *get_bug_type(struct kasan_report_info *info)
>  
>  void kasan_complete_mode_report_info(struct kasan_report_info *info)
>  {
> +	u64 pos;
> +	struct kasan_stack_ring_entry *entry;
> +	void *object;
> +	u32 pid;
> +	depot_stack_handle_t stack;
> +	bool is_free;

If you switch away from atomic for kasan_stack_ring_entry members, you
can just replace the above with a 'struct kasan_stack_ring_entry' and
READ_ONCE() each entry into it below.

> +	bool alloc_found = false, free_found = false;
> +
>  	info->bug_type = get_bug_type(info);
> +
> +	if (!info->cache || !info->object)
> +		return;
> +
> +	pos = atomic64_read(&stack_ring.pos);
> +
> +	for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_ENTRIES; i--) {
> +		if (alloc_found && free_found)
> +			break;
> +
> +		entry = &stack_ring.entries[i % KASAN_STACK_RING_ENTRIES];
> +
> +		/* Paired with atomic64_set_release() in save_stack_info(). */
> +		object = (void *)atomic64_read_acquire(&entry->ptr);
> +
> +		if (kasan_reset_tag(object) != info->object ||
> +		    get_tag(object) != get_tag(info->access_addr))
> +			continue;
> +
> +		pid = atomic_read(&entry->pid);
> +		stack = atomic_read(&entry->stack);
> +		is_free = atomic_read(&entry->is_free);
> +
> +		/* Try detecting if the entry was changed while being read. */
> +		smp_mb();
> +		if (object != (void *)atomic64_read(&entry->ptr))
> +			continue;

What if the object was changed, but 'ptr' is the same? It might very
well be possible to then read half of the info of the previous object,
and half of the new object (e.g. pid is old, stack is new).

Is the assumption that it is extremely unlikely that this will happen
where 1) address is the same, and 2) tags are the same? And if it does
happen, it is unlikely that there'll be a bug on that address?

It might be worth stating this in comments.

Another thing is, if there's a bug, but concurrently you have tons of
allocations/frees that change the ring's entries at a very high rate,
how likely is it that the entire ring will have been wiped before the
entry of interest is found again?

One way to guard against this is to prevent modifications of the ring
while the ring is searched. This could be implemented with a
percpu-rwsem, which is almost free for read-lockers but very expensive
for write-lockers. Insertions only acquire a read-lock, but on a bug
when searching the ring, you have to acquire a write-lock. Although you
currently take the contention hit for incrementing 'pos', so a plain
rwlock might also be ok.

It would be good to understand the probabilities of these corner cases
with some average to worst case workloads, and optimize based on that.

> +
> +		if (is_free) {
> +			/*
> +			 * Second free of the same object.
> +			 * Give up on trying to find the alloc entry.
> +			 */
> +			if (free_found)
> +				break;
> +
> +			info->free_track.pid = pid;
> +			info->free_track.stack = stack;
> +			free_found = true;
> +		} else {
> +			/* Second alloc of the same object. Give up. */
> +			if (alloc_found)
> +				break;
> +
> +			info->alloc_track.pid = pid;
> +			info->alloc_track.stack = stack;
> +			alloc_found = true;
> +		}
> +	}
>  }
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 39a0481e5228..286011307695 100644
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
> @@ -16,11 +17,40 @@
>  #include <linux/types.h>
>  
>  #include "kasan.h"
> +#include "../slab.h"
> +
> +struct kasan_stack_ring stack_ring;

This is a very large struct. Can it be allocated by memblock_alloc()
very early on only if required (kasan.stacktrace= can still switch it
off, right?).

> +void save_stack_info(struct kmem_cache *cache, void *object,
> +			gfp_t flags, bool is_free)

static void save_stack_info(...)

> +{
> +	u64 pos;
> +	struct kasan_stack_ring_entry *entry;
> +	depot_stack_handle_t stack;
> +
> +	stack = kasan_save_stack(flags, true);
> +
> +	pos = atomic64_fetch_add(1, &stack_ring.pos);
> +	entry = &stack_ring.entries[pos % KASAN_STACK_RING_ENTRIES];
> +
> +	atomic64_set(&entry->size, cache->object_size);
> +	atomic_set(&entry->pid, current->pid);
> +	atomic_set(&entry->stack, stack);
> +	atomic_set(&entry->is_free, is_free);
> +

I don't see the point of these being atomic. You can make them normal
variables with the proper types, and use READ_ONCE() / WRITE_ONCE().

The only one where you truly need the atomic type is 'pos'.

> +	/*
> +	 * Paired with atomic64_read_acquire() in
> +	 * kasan_complete_mode_report_info().
> +	 */
> +	atomic64_set_release(&entry->ptr, (s64)object);

This could be smp_store_release() and 'ptr' can be just a normal pointer.

One thing that is not entirely impossible though (vs. re-reading same
pointer but inconsistent fields I mentioned above), is if something
wants to write to the ring, but stalls for a very long time before the
release of 'ptr', giving 'pos' the chance to wrap around and another
writer writing the same entry. Something like:

  T0					| T1
  --------------------------------------+--------------------------------
  WRITE_ONCE(entry->size, ..) 		| 
  WRITE_ONCE(entry->pid, ..)		| 
					| WRITE_ONCE(entry->size, ..)
					| WRITE_ONCE(entry->pid, ..)
  					| WRITE_ONCE(entry->stack, ..)
  					| WRITE_ONCE(entry->is_free, ..)
  					| smp_store_release(entry->ptr, ...)
  WRITE_ONCE(entry->stack, ..)		|
  WRITE_ONCE(entry->is_free, ..)	|
  smp_store_release(entry->ptr, ...)	|

Which results in some mix of T0's and T1's data.

The way to solve this is to implement a try-lock using 'ptr':

	#define BUSY_PTR ((void*)1)  // non-zero because initial values are 0
	old_ptr = READ_ONCE(entry->ptr);
	if (old_ptr == BUSY_PTR)
		goto next; /* Busy slot. */
	if (!try_cmpxchg(&entry->ptr, &old_ptr, BUSY_PTR))
		goto next; /* Busy slot. */
	... set fields as before ...
	smp_store_release(&entry->ptr, object);

> +}
>  
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
> +	save_stack_info(cache, object, flags, false);
>  }
>  
>  void kasan_save_free_info(struct kmem_cache *cache, void *object)
>  {
> +	save_stack_info(cache, object, GFP_NOWAIT, true);
>  }
> -- 
> 2.25.1
