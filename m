Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CB5A8CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiIAEnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiIAEn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:43:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14000E1A92
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 21:43:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C8CA221E1;
        Thu,  1 Sep 2022 04:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662007376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOrpVxoLkMuflgUaHdVwwjK9xZD6TEf1SyG3O69U9sM=;
        b=oqUP1He733QNLVLXx7ZWAPtgoRicZnRMKKIqn8PvRcZFqUMfNU+jubRai5zZXdbSjGZfB2
        tKE3euSDQAC6MFj2MJXx5k6xZSq1IAA2fL0ZIZZsqjYwbGO3vlnds8nEelP7CxpLh+NQYZ
        o3Ilo8vI2yNYqqnLcy6r/u3kaQL7ueA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662007376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOrpVxoLkMuflgUaHdVwwjK9xZD6TEf1SyG3O69U9sM=;
        b=JHXCx1XeJ41HxPNZTsatF5O2LGA8NRw2HNBLQSosOcF4hihZSq3/QPnWCCbEBPm7bBx6OP
        zbzHRN1kgE6rixCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7CBD139C4;
        Thu,  1 Sep 2022 04:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +GvANU84EGPheAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 01 Sep 2022 04:42:55 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
Date:   Thu,  1 Sep 2022 06:42:47 +0200
Message-Id: <20220901044249.4624-2-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901044249.4624-1-osalvador@suse.de>
References: <20220901044249.4624-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to filter out page_owner output and print only those
stacks that have been repeated beyond a certain threshold.
This gives us the chance to get rid of a lot of noise.
In order to do that, we need to keep track of how many repeated stacks
(for allocation) do we have, so we add a new refcount_t field
in the stack_record struct.

Note that on __set_page_owner_handle(), page_owner->handle is set,
and on __reset_page_owner(), page_owner->free_handle is set.

We are interested in page_owner->handle, so when __set_page_owner()
gets called, we derive the stack_record struct from page_owner->handle,
and we increment its refcount_t field; and when __reset_page_owner()
gets called, we derive its stack_record from page_owner->handle()
and we decrement its refcount_t field.

This is a preparation for patch#2.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h | 13 ++++++-
 lib/stackdepot.c           | 79 +++++++++++++++++++++++++++++++-------
 mm/kasan/common.c          |  3 +-
 mm/page_owner.c            | 13 +++++--
 4 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index bc2797955de9..5ee0cf5be88f 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -15,9 +15,16 @@
 
 typedef u32 depot_stack_handle_t;
 
+typedef enum stack_action {
+	STACK_ACTION_NONE,
+	STACK_ACTION_INC,
+}stack_action_t;
+
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
-					gfp_t gfp_flags, bool can_alloc);
+					gfp_t gfp_flags, bool can_alloc,
+					stack_action_t action);
+void stack_depot_dec_count(depot_stack_handle_t handle);
 
 /*
  * Every user of stack depot has to call stack_depot_init() during its own init
@@ -55,6 +62,10 @@ static inline int stack_depot_early_init(void)	{ return 0; }
 
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
+depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
+					     unsigned int nr_entries,
+					     gfp_t gfp_flags,
+					     stack_action_t action);
 
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ca0d086ef4a..aeb59d3557e2 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -63,6 +63,7 @@ struct stack_record {
 	u32 hash;			/* Hash in the hastable */
 	u32 size;			/* Number of frames in the stack */
 	union handle_parts handle;
+	refcount_t count;		/* Number of the same repeated stacks */
 	unsigned long entries[];	/* Variable-sized array of entries. */
 };
 
@@ -139,6 +140,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.slabindex = depot_index;
 	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
+	refcount_set(&stack->count, 1);
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	depot_offset += required_size;
 
@@ -302,6 +304,29 @@ void stack_depot_print(depot_stack_handle_t stack)
 }
 EXPORT_SYMBOL_GPL(stack_depot_print);
 
+static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
+{
+	union handle_parts parts = { .handle = handle };
+	void *slab;
+	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
+	struct stack_record *stack;
+
+	if(!handle)
+		return NULL;
+
+	if (parts.slabindex > depot_index) {
+		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
+		     parts.slabindex, depot_index, handle);
+		return NULL;
+	}
+	slab = stack_slabs[parts.slabindex];
+	if (!slab)
+		return NULL;
+
+	stack = slab + offset;
+	return stack;
+}
+
 /**
  * stack_depot_fetch - Fetch stack entries from a depot
  *
@@ -314,30 +339,42 @@ EXPORT_SYMBOL_GPL(stack_depot_print);
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
-	union handle_parts parts = { .handle = handle };
-	void *slab;
-	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
 	struct stack_record *stack;
 
 	*entries = NULL;
 	if (!handle)
 		return 0;
 
-	if (parts.slabindex > depot_index) {
-		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
-			parts.slabindex, depot_index, handle);
-		return 0;
-	}
-	slab = stack_slabs[parts.slabindex];
-	if (!slab)
+	stack = stack_depot_getstack(handle);
+	if (!stack)
 		return 0;
-	stack = slab + offset;
 
 	*entries = stack->entries;
 	return stack->size;
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
+static void stack_depot_inc_count(struct stack_record *stack)
+{
+	refcount_inc(&stack->count);
+}
+
+void stack_depot_dec_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack = NULL;
+
+	stack = stack_depot_getstack(handle);
+	if (stack) {
+	/*
+	 * page_owner creates some stacks via create_dummy_stack().
+	 * We are not interested in those, so make sure we only decrement
+	 * "valid" stacks.
+	 */
+		if (refcount_read(&stack->count) > 1)
+			refcount_dec(&stack->count);
+	}
+}
+
 /**
  * __stack_depot_save - Save a stack trace from an array
  *
@@ -363,7 +400,8 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
-					gfp_t alloc_flags, bool can_alloc)
+					gfp_t alloc_flags, bool can_alloc,
+					stack_action_t action)
 {
 	struct stack_record *found = NULL, **bucket;
 	depot_stack_handle_t retval = 0;
@@ -449,8 +487,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		/* Nobody used this memory, ok to free it. */
 		free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
 	}
-	if (found)
+	if (found) {
 		retval = found->handle.handle;
+		if (action == STACK_ACTION_INC)
+			stack_depot_inc_count(found);
+	}
 fast_exit:
 	return retval;
 }
@@ -472,6 +513,16 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
 {
-	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true,
+				  STACK_ACTION_NONE);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
+
+depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
+					     unsigned int nr_entries,
+					     gfp_t alloc_flags,
+					     stack_action_t action)
+{
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true, action);
+}
+EXPORT_SYMBOL_GPL(stack_depot_save_action);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c40c0e7b3b5f..f434994f3b0d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -36,7 +36,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
-	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
+	return __stack_depot_save(entries, nr_entries, flags, can_alloc,
+				  STACK_ACTION_NONE);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..794f346d7520 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -106,7 +106,7 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
 	return (void *)page_ext + page_owner_ops.offset;
 }
 
-static noinline depot_stack_handle_t save_stack(gfp_t flags)
+static noinline depot_stack_handle_t save_stack(gfp_t flags, stack_action_t action)
 {
 	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
 	depot_stack_handle_t handle;
@@ -125,7 +125,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	current->in_page_owner = 1;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
-	handle = stack_depot_save(entries, nr_entries, flags);
+	handle = stack_depot_save_action(entries, nr_entries, flags, action);
 	if (!handle)
 		handle = failure_handle;
 
@@ -138,6 +138,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	int i;
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
+	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
@@ -145,7 +146,10 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
-	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
+	page_owner = get_page_owner(page_ext);
+	alloc_handle = page_owner->handle;
+
+	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_ACTION_NONE);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner = get_page_owner(page_ext);
@@ -153,6 +157,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner->free_ts_nsec = free_ts_nsec;
 		page_ext = page_ext_next(page_ext);
 	}
+	stack_depot_dec_count(alloc_handle);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -189,7 +194,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	if (unlikely(!page_ext))
 		return;
 
-	handle = save_stack(gfp_mask);
+	handle = save_stack(gfp_mask, STACK_ACTION_INC);
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 }
 
-- 
2.35.3

