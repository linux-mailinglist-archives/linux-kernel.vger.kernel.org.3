Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA9591F60
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHNKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:06:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A11D336
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 03:06:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so12152089pjo.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ATou+xY9oMgJmx0tDfOlqoZgEnh+mwbeWggAIMZYy2w=;
        b=pW8ONHvBfVxu7Ob9RysC2wjfRxfYfCIANJGZjTox9MkaUdarkjqJyk7dYKDD5xGkTb
         sDpX4/kcMEsH3TqPJ8frbYQoG/xIDnhdDxv7t3tANJ0qzynL/KEpX4RKrECCyA1FBKXM
         Hr168dBiMpMHYO3XfVfWuQ/0ZyWm54Vi3OgwMD2FT5N8Zk+ZLHjYI7kmto4TRjrvZOzL
         CJooZiYz7DhA+Jh7GjNwnGqG5e8o5Frn5ZmNXQpcWDAjc8sswwac9dvS2uM61fslJfeh
         wknzvRijffxOOCF0jTMUCEzCn6jckleiwrF9extK1A153LIm2fXorGqYgETG3kVTuiaW
         9p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ATou+xY9oMgJmx0tDfOlqoZgEnh+mwbeWggAIMZYy2w=;
        b=q3TiSqfjljCoOnvYP6ZGVdd5hfwoiZVrJ/hhFT1UVUI0KZC1NlcpH7R81jBh2lyGnD
         iRl7UMiwF0nunf8Ye5ZToA77vtujst6Rass2ykOPFBwGodWVLRBgi3sIFB2gD5PIUPPi
         qgprLI98+2FOtvHOyK3dTH84qNMZZS2NtsCMC9qlCRIEAvoBsG6dD4InpONnwnSMR28g
         IRFMbnmRTrOupphy3aoCSZWEwhQ9QDiOqXo1fJsJ1n9TP29jGv8PnP7HQn3FH9+AuIhX
         VhiGSCyzW0zxqqyeChOaHqeEzmfif0pmX/az7ARin65ygT1p0yNIkmucckkpPxIz/Og3
         dwkA==
X-Gm-Message-State: ACgBeo1bBlHNXeyP5ZmMFHovuHeipnlWhj75+li6cAH+ScTdfWWxuztz
        clJYTZcx950bjHUZ+e7WO+U=
X-Google-Smtp-Source: AA6agR50EREJxKBK0BZBU651dbILVdh1XO9j4YmHmeLCirzthQHfjX6yDkRwUoEygMezh6XPmFNxvQ==
X-Received: by 2002:a17:90a:898c:b0:1f3:8287:3fd9 with SMTP id v12-20020a17090a898c00b001f382873fd9mr13249051pjn.232.1660471600324;
        Sun, 14 Aug 2022 03:06:40 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b0016d88dc7745sm5067416plg.259.2022.08.14.03.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:06:39 -0700 (PDT)
Date:   Sun, 14 Aug 2022 19:06:33 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 00/15] common kmalloc v3
Message-ID: <YvjJKeiwMAg+7/Q5@hyeyoo>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <e77f9820-c818-d7af-185b-b8814313048b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77f9820-c818-d7af-185b-b8814313048b@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 05:08:31PM +0200, Vlastimil Babka wrote:
> On 7/12/22 15:39, Hyeonggon Yoo wrote:
> > This is v3 of common kmalloc series.
> > 
> > This series generalize most of kmalloc functions and move its
> > implementation into mm/slab_common.c.
> > 
> > I believe this series give better maintainability of code for SLAB and SLUB.
> > Please consider applying.
> > 
> > This series is based on slab/for-next and also available at
> > https://github.com/hygoni/linux/tree/slab-common-v3r0
> > 
> > Any feedbacks/reviews will be appreciated.
> 
> Hi, thanks for all your efforts. It's shaping up nicely so I think the next
> version will be ready to be added to -next after the 5.20 merge window.
> As I've finished the individual reviews, I'm looking at the result and see a
> bit more potential for cleanups, which could be perhaps incorporated to
> existing patches, or additionally:

Thank you for reviews and I too would like to add it to -next soon!

> 
> - kmalloc_large_node_notrace() has only one caller, can be removed and the
> caller can call __kmalloc_large_node_notrace() directly, especially if it's
> not __always_inline as I've IIRC suggested.

Will adjust in next version.

> - kmem_cache_alloc_trace() and kmem_cache_alloc_node_trace() are weird ones,
> they are in fact for kmalloc despite the name.

Yeah, I'm the one that would like to rename it to kmalloc_trace() and
kmalloc_node_trace().

> They depend on
> CONFIG_TRACING, yet if you look carefully, the !CONFIG_TRACING variant also
> goes through a trace_* function. The actual difference seems that
> slab_alloc() thus kasan_alloc() and kfence_alloc() don't get the orig_size
> that way, which is dubious. It might be worth trying to unify this as well?
> E.g.
>   - use only the CONFIG_TRACING variant, discard the other

Sounds okay.

>   - declare it in mm/slab.h, this is not for general usage

We can't completely remove it because its needed in include/linux/slab.h
for inlined kmalloc.

>   - single implementation in mm/slab_common.c that calls
>     __kmem_cache_alloc_node() from SLAB/SLUB and does the trace

While I love the idea of single implementation in mm/slab_common.c,
making use of __kmem_cache_alloc_node() and __kmem_cache_free() adds
a bit of overhead:
	it adds overhead of function call and can't benefit from inlining
	(including removing unnnecessary part of function code) 

So... what about including slab_common.c in sl?b.c,
so that compiler can treat sl?b.c and slab_common.c as a single translation unit?
(or split kmalloc implementation into kmalloc.c and do similar thing?)

Thanks!

---
Hyeonggon

diff --git a/mm/Makefile b/mm/Makefile
index 9a564f836403..bcee8495b531 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -3,7 +3,6 @@
 # Makefile for the linux memory manager.
 #

-KASAN_SANITIZE_slab_common.o := n
 KASAN_SANITIZE_slab.o := n
 KASAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_kmemleak.o := n
@@ -11,7 +10,6 @@ KCSAN_SANITIZE_kmemleak.o := n
 # These produce frequent data race reports: most of them are due to races on
 # the same word but accesses to different bits of that word. Re-enable KCSAN
 # for these when we have more consensus on what to do about them.
-KCSAN_SANITIZE_slab_common.o := n
 KCSAN_SANITIZE_slab.o := n
 KCSAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_page_alloc.o := n
@@ -21,7 +19,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
-KCOV_INSTRUMENT_slab_common.o := n
 KCOV_INSTRUMENT_slob.o := n
 KCOV_INSTRUMENT_slab.o := n
 KCOV_INSTRUMENT_slub.o := n
@@ -51,8 +48,7 @@ obj-y                 := filemap.o mempool.o oom_kill.o fadvise.o \
                           maccess.o page-writeback.o folio-compat.o \
                           readahead.o swap.o truncate.o vmscan.o shmem.o \
                           util.o mmzone.o vmstat.o backing-dev.o \
-                          mm_init.o percpu.o slab_common.o \
-                          compaction.o vmacache.o \
+                          mm_init.o percpu.o compaction.o vmacache.o \
                           interval_tree.o list_lru.o workingset.o \
                           debug.o gup.o mmap_lock.o $(mmu-y)

diff --git a/mm/slab.c b/mm/slab.c
index a5486ff8362a..a302a7c17b40 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -131,6 +131,8 @@

 #include       "slab.h"

+#include       "slab_common.c"
+
 /*
  * DEBUG       - 1 for kmem_cache_create() to honour; SLAB_RED_ZONE & SLAB_POISON.
  *               0 for faster, smaller code (especially in the critical paths).
@@ -3541,6 +3543,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);

+static __always_inline
 void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
                             int nodeid, size_t orig_size,
                             unsigned long caller)
@@ -3585,6 +3588,7 @@ void __do_kmem_cache_free(struct kmem_cache *cachep, void *objp,
        local_irq_restore(flags);
 }

+static __always_inline
 void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
                       unsigned long caller)
 {
diff --git a/mm/slab.h b/mm/slab.h
index 65023f000d42..4e43ab717d99 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -273,11 +273,6 @@ void create_kmalloc_caches(slab_flags_t);

 /* Find the kmalloc slab corresponding for a certain size */
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
-
-void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
-                             int node, size_t orig_size,
-                             unsigned long caller);
-void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
 #endif

 gfp_t kmalloc_fix_flags(gfp_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 83cfe91b6ab6..70d7393d31ae 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -898,6 +898,12 @@ void free_large_kmalloc(struct folio *folio, void *object)
        __free_pages(folio_page(folio, 0), order);
 }

+static __always_inline
+void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node,
+                             size_t orig_size, unsigned long caller);
+static __always_inline
+void __kmem_cache_free(struct kmem_cache *s, void *objp, unsigned long caller);
+
 static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
diff --git a/mm/slob.c b/mm/slob.c
index 45a061b8ba38..656f4f8b77d9 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -74,6 +74,9 @@
 #include <linux/atomic.h>

 #include "slab.h"
+
+#include "slab_common.c"
+
 /*
  * slob_block has a field 'units', which indicates size of block if +ve,
  * or offset of next block if -ve (in SLOB_UNITs).
diff --git a/mm/slub.c b/mm/slub.c
index 8083a6ee5f15..bd47a30049ae 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -45,6 +45,8 @@

 #include "internal.h"

+#include "slab_common.c"
+
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
@@ -3261,6 +3263,7 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);

+static __always_inline
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
                              int node, size_t orig_size,
                              unsigned long caller)
@@ -3505,6 +3508,7 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif

+static __always_inline
 void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
 {
        slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
