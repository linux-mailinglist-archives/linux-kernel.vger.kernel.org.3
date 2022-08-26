Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E725A2A71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiHZPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiHZPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:08:37 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEACDC09D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:08:20 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id qf15-20020a1709077f0f00b0073d6dfb7556so717119ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=omcyQ1o+RVSxzRVZJZY/qms7uBp4WMcvPZ8eVf62Bcs=;
        b=RA3+jZoNkZ6/iwxrpSVqaEjBMYHmdlwKi/r0P/ahW5EfxcEw95Fn/Idn7YL4qWBzll
         SY0uIX1NPhBlO4/v7JGD0C0GkUj5lA5653SGiEmNx4TDtgxGUvAKdSJ1fWOgyi06z/DG
         shPVR/vk4/TLqx/3mkmush3fs6dqtOR0yJmc+Nmy6aUkZqpT99d7lDvu0GcomBqNMqyN
         19J1+veiw9TqSFJT2q2s9xkLUwnPBJrzd2UWFkMwuPWi4IOaRL2IjhrBf3Js6HDjqwHq
         CmvYYiW1TiqGPg7RFvpwRKn+givLPrkzFJ3DaBqEgQYzQViRUdbgNutzUbpd5CLnFdln
         k03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=omcyQ1o+RVSxzRVZJZY/qms7uBp4WMcvPZ8eVf62Bcs=;
        b=t8jL5AQxGFyoBnCeebfNnTmZAi6Y5vWOFakGSUQFU9arbOprosLh1XzZjHcOTim7yu
         BupCBXbrM+Q+IhBK1gKY4qKChTNMl3SCF884fJPFNBfK6AISrzZdCjjr0aKMWj+SRKiY
         sXzeOafNN36c4e/uR7BkZF5IaNJWuMaJebD6ub9I6LjAzIZDoTwYbPF3ewddV0sBwv/g
         WBmkXhgwxS9ZWyUeY9jDEvF/l5usIlQhFLfOYCLXbTTCRz5P/uyuF8UyiVF/xT7qT2j4
         tJTumtmOa2x0k0NH7Pz74Xm4VAE22ZCMnDsopnqug3Jr4RQPUfgqV7Q/ssOp1ceEJtIs
         M5hg==
X-Gm-Message-State: ACgBeo0+R/9NovLXJpromJKnGXUISrWR/Tx4KDYNWTzjOxGw0iwZ01jW
        7oSP90vqitkDTFza3vuTNGeF1ZYmwMQ=
X-Google-Smtp-Source: AA6agR6A/llRpE6oXEfhGAAL2j75O1MUVXyWFGmAFUP5rzL7sdADsGx3VSQrZnp9gBHmtwE7SwLSgksGbo8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:270a:b0:446:c9e9:6e00 with SMTP id
 y10-20020a056402270a00b00446c9e96e00mr6913543edd.315.1661526498732; Fri, 26
 Aug 2022 08:08:18 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:25 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-3-glider@google.com>
Subject: [PATCH v5 02/44] stackdepot: reserve 5 extra bits in depot_stack_handle_t
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users (currently only KMSAN) may want to use spare bits in
depot_stack_handle_t. Let them do so by adding @extra_bits to
__stack_depot_save() to store arbitrary flags, and providing
stack_depot_get_extra_bits() to retrieve those flags.

Also adapt KASAN to the new prototype by passing extra_bits=0, as KASAN
does not intend to store additional information in the stack handle.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v4:
 -- per Marco Elver's request, fold "kasan: common: adapt to the new
    prototype of __stack_depot_save()" into this patch to prevent
    bisection breakages.

Link: https://linux-review.googlesource.com/id/I0587f6c777667864768daf07821d594bce6d8ff9
---
 include/linux/stackdepot.h |  8 ++++++++
 lib/stackdepot.c           | 29 ++++++++++++++++++++++++-----
 mm/kasan/common.c          |  2 +-
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index bc2797955de90..9ca7798d7a318 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -14,9 +14,15 @@
 #include <linux/gfp.h>
 
 typedef u32 depot_stack_handle_t;
+/*
+ * Number of bits in the handle that stack depot doesn't use. Users may store
+ * information in them.
+ */
+#define STACK_DEPOT_EXTRA_BITS 5
 
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
+					unsigned int extra_bits,
 					gfp_t gfp_flags, bool can_alloc);
 
 /*
@@ -59,6 +65,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
+unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
+
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e73fda23388d8..79e894cf84064 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -43,7 +43,8 @@
 #define STACK_ALLOC_OFFSET_BITS (STACK_ALLOC_ORDER + PAGE_SHIFT - \
 					STACK_ALLOC_ALIGN)
 #define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
-		STACK_ALLOC_NULL_PROTECTION_BITS - STACK_ALLOC_OFFSET_BITS)
+		STACK_ALLOC_NULL_PROTECTION_BITS - \
+		STACK_ALLOC_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
 #define STACK_ALLOC_SLABS_CAP 8192
 #define STACK_ALLOC_MAX_SLABS \
 	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_SLABS_CAP) ? \
@@ -56,6 +57,7 @@ union handle_parts {
 		u32 slabindex : STACK_ALLOC_INDEX_BITS;
 		u32 offset : STACK_ALLOC_OFFSET_BITS;
 		u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
+		u32 extra : STACK_DEPOT_EXTRA_BITS;
 	};
 };
 
@@ -77,6 +79,14 @@ static int next_slab_inited;
 static size_t depot_offset;
 static DEFINE_RAW_SPINLOCK(depot_lock);
 
+unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
+{
+	union handle_parts parts = { .handle = handle };
+
+	return parts.extra;
+}
+EXPORT_SYMBOL(stack_depot_get_extra_bits);
+
 static bool init_stack_slab(void **prealloc)
 {
 	if (!*prealloc)
@@ -140,6 +150,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.slabindex = depot_index;
 	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
+	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	depot_offset += required_size;
 
@@ -382,6 +393,7 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  *
  * @entries:		Pointer to storage array
  * @nr_entries:		Size of the storage array
+ * @extra_bits:		Flags to store in unused bits of depot_stack_handle_t
  * @alloc_flags:	Allocation gfp flags
  * @can_alloc:		Allocate stack slabs (increased chance of failure if false)
  *
@@ -393,6 +405,10 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  * If the stack trace in @entries is from an interrupt, only the portion up to
  * interrupt entry is saved.
  *
+ * Additional opaque flags can be passed in @extra_bits, stored in the unused
+ * bits of the stack handle, and retrieved using stack_depot_get_extra_bits()
+ * without calling stack_depot_fetch().
+ *
  * Context: Any context, but setting @can_alloc to %false is required if
  *          alloc_pages() cannot be used from the current context. Currently
  *          this is the case from contexts where neither %GFP_ATOMIC nor
@@ -402,10 +418,11 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
+					unsigned int extra_bits,
 					gfp_t alloc_flags, bool can_alloc)
 {
 	struct stack_record *found = NULL, **bucket;
-	depot_stack_handle_t retval = 0;
+	union handle_parts retval = { .handle = 0 };
 	struct page *page = NULL;
 	void *prealloc = NULL;
 	unsigned long flags;
@@ -489,9 +506,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
 	}
 	if (found)
-		retval = found->handle.handle;
+		retval.handle = found->handle.handle;
 fast_exit:
-	return retval;
+	retval.extra = extra_bits;
+
+	return retval.handle;
 }
 EXPORT_SYMBOL_GPL(__stack_depot_save);
 
@@ -511,6 +530,6 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
 {
-	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+	return __stack_depot_save(entries, nr_entries, 0, alloc_flags, true);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 69f583855c8be..94caa2d46a327 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -36,7 +36,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
-	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
+	return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
-- 
2.37.2.672.g94769d06f0-goog

