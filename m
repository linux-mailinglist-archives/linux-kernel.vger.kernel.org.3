Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4C4F1E61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381330AbiDDVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379200AbiDDQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802635851
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FA1D210F4;
        Mon,  4 Apr 2022 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Msvh6m+t5rYoB11gb9lJtAm2YmxtlamKtBfXfIOctHA=;
        b=tlOMGI7kNSNyy2XuejrBGFf836Qy3z44eiz/mZrTq/6EQLL8eEbwOBjEmkdymnHKzzl7I+
        xg/MpwhH6iO+cOh6iLRJzp4+I9UgBPv6jG1Fuyof3z/QdP2HRknjDjBeYO+NOfHTPgIplf
        BZaZyWwz+Fzfk6IjO7o2gNtz4TwDExw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Msvh6m+t5rYoB11gb9lJtAm2YmxtlamKtBfXfIOctHA=;
        b=sMZ/KEKgA+a21s2WOtHvaiFSM98e28VjkRdAIhCVcH9KoppIuFRW+5wPIwkKTxNicqWQMO
        fo1IelcSJgf646Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0FBC13A89;
        Mon,  4 Apr 2022 16:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GLNTNq8fS2LjfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 16:41:19 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 1/6] lib/stackdepot: allow requesting early initialization dynamically
Date:   Mon,  4 Apr 2022 18:41:07 +0200
Message-Id: <20220404164112.18372-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404164112.18372-1-vbabka@suse.cz>
References: <20220404164112.18372-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7886; h=from:subject; bh=g13raqQ+rnG6rknZ2M+4fuKo89TMDIRw3HFuYCzSfK0=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiSx+jaLlmGkFJ39Gr8G3pJl5+AE10txtNwpy9PXCs wtDx4X6JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYksfowAKCRDgIcpz8YmpEGy9B/ 4ye/zmHC7nUHoPB5v5Z7YbJbuhVSD6qAUUS3grCPUqL+fy7gCmlAmYGuHShuU9+cZYEdJi54QV5bvs j0UsAgImm33hsWBUSlBtveKek6TtHefdzgefKxlDo8EGtA7CaHfffAFGHhEWJ/7OKv1wPlo3nwU9S1 FtULwgfLmU0GD/me12NCb22pFYJfr4/5QD34m9HBu/vxo+YHMNd6HbNHlWB1I1HFrzml7s8cOY5JkZ QpopD9eqRDO8Xhh9Bcmo0Wopbrd3gHQbQSMl8VbaG4C7yWz5cHcxFRqMnHZldbh1i2ouG3sGL2+P9k DkhMxTEEo9dBtz12zcBamASZce5ml9
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a later patch we want to add stackdepot support for object owner
tracking in slub caches, which is enabled by slub_debug boot parameter.
This creates a bootstrap problem as some caches are created early in
boot when slab_is_available() is false and thus stack_depot_init()
tries to use memblock. But, as reported by Hyeonggon Yoo [1] we are
already beyond memblock_free_all(). Ideally memblock allocation should
fail, yet it succeeds, but later the system crashes, which is a
separately handled issue.

To resolve this boostrap issue in a robust way, this patch adds another
way to request stack_depot_early_init(), which happens at a well-defined
point of time. In addition to build-time CONFIG_STACKDEPOT_ALWAYS_INIT,
code that's e.g. processing boot parameters (which happens early enough)
can call a new function stack_depot_want_early_init(), which sets a flag
that stack_depot_early_init() will check.

In this patch we also convert page_owner to this approach. While it
doesn't have the bootstrap issue as slub, it's also a functionality
enabled by a boot param and can thus request stack_depot_early_init()
with memblock allocation instead of later initialization with
kvmalloc().

As suggested by Mike, make stack_depot_early_init() only attempt
memblock allocation and stack_depot_init() only attempt kvmalloc().
Also change the latter to kvcalloc(). In both cases we can lose the
explicit array zeroing, which the allocations do already.

As suggested by Marco, provide empty implementations of the init
functions for !CONFIG_STACKDEPOT builds to simplify the callers.

[1] https://lore.kernel.org/all/YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal/

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/stackdepot.h | 26 ++++++++++++---
 lib/stackdepot.c           | 66 +++++++++++++++++++++++++-------------
 mm/page_owner.c            |  9 ++++--
 3 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 17f992fe6355..bc2797955de9 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -20,18 +20,36 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					gfp_t gfp_flags, bool can_alloc);
 
 /*
- * Every user of stack depot has to call this during its own init when it's
- * decided that it will be calling stack_depot_save() later.
+ * Every user of stack depot has to call stack_depot_init() during its own init
+ * when it's decided that it will be calling stack_depot_save() later. This is
+ * recommended for e.g. modules initialized later in the boot process, when
+ * slab_is_available() is true.
  *
  * The alternative is to select STACKDEPOT_ALWAYS_INIT to have stack depot
  * enabled as part of mm_init(), for subsystems where it's known at compile time
  * that stack depot will be used.
+ *
+ * Another alternative is to call stack_depot_want_early_init(), when the
+ * decision to use stack depot is taken e.g. when evaluating kernel boot
+ * parameters, which precedes the enablement point in mm_init().
+ *
+ * stack_depot_init() and stack_depot_want_early_init() can be called regardless
+ * of CONFIG_STACKDEPOT and are no-op when disabled. The actual save/fetch/print
+ * functions should only be called from code that makes sure CONFIG_STACKDEPOT
+ * is enabled.
  */
+#ifdef CONFIG_STACKDEPOT
 int stack_depot_init(void);
 
-#ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
-static inline int stack_depot_early_init(void)	{ return stack_depot_init(); }
+void __init stack_depot_want_early_init(void);
+
+/* This is supposed to be called only from mm_init() */
+int __init stack_depot_early_init(void);
 #else
+static inline int stack_depot_init(void) { return 0; }
+
+static inline void stack_depot_want_early_init(void) { }
+
 static inline int stack_depot_early_init(void)	{ return 0; }
 #endif
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index bf5ba9af0500..6c4644c9ed44 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -66,6 +66,9 @@ struct stack_record {
 	unsigned long entries[];	/* Variable-sized array of entries. */
 };
 
+static bool __stack_depot_want_early_init __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
+static bool __stack_depot_early_init_passed __initdata;
+
 static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
 
 static int depot_index;
@@ -162,38 +165,57 @@ static int __init is_stack_depot_disabled(char *str)
 }
 early_param("stack_depot_disable", is_stack_depot_disabled);
 
-/*
- * __ref because of memblock_alloc(), which will not be actually called after
- * the __init code is gone, because at that point slab_is_available() is true
- */
-__ref int stack_depot_init(void)
+void __init stack_depot_want_early_init(void)
+{
+	/* Too late to request early init now */
+	WARN_ON(__stack_depot_early_init_passed);
+
+	__stack_depot_want_early_init = true;
+}
+
+int __init stack_depot_early_init(void)
+{
+	size_t size;
+
+	/* This is supposed to be called only once, from mm_init() */
+	if (WARN_ON(__stack_depot_early_init_passed))
+		return 0;
+
+	__stack_depot_early_init_passed = true;
+
+	if (!__stack_depot_want_early_init || stack_depot_disable)
+		return 0;
+
+	pr_info("Stack Depot early init allocating hash table with memblock_alloc\n");
+	size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
+	stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
+
+	if (!stack_table) {
+		pr_err("Stack Depot hash table allocation failed, disabling\n");
+		stack_depot_disable = true;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int stack_depot_init(void)
 {
 	static DEFINE_MUTEX(stack_depot_init_mutex);
+	int ret = 0;
 
 	mutex_lock(&stack_depot_init_mutex);
 	if (!stack_depot_disable && !stack_table) {
-		size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
-		int i;
-
-		if (slab_is_available()) {
-			pr_info("Stack Depot allocating hash table with kvmalloc\n");
-			stack_table = kvmalloc(size, GFP_KERNEL);
-		} else {
-			pr_info("Stack Depot allocating hash table with memblock_alloc\n");
-			stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
-		}
-		if (stack_table) {
-			for (i = 0; i < STACK_HASH_SIZE;  i++)
-				stack_table[i] = NULL;
-		} else {
+		pr_info("Stack Depot allocating hash table with kvcalloc\n");
+		stack_table = kvcalloc(STACK_HASH_SIZE, sizeof(struct stack_record *), GFP_KERNEL);
+		if (!stack_table) {
 			pr_err("Stack Depot hash table allocation failed, disabling\n");
 			stack_depot_disable = true;
-			mutex_unlock(&stack_depot_init_mutex);
-			return -ENOMEM;
+			ret = -ENOMEM;
 		}
 	}
 	mutex_unlock(&stack_depot_init_mutex);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
diff --git a/mm/page_owner.c b/mm/page_owner.c
index fb3a05fdebdb..2743062e92c2 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -45,7 +45,12 @@ static void init_early_allocated_pages(void);
 
 static int __init early_page_owner_param(char *buf)
 {
-	return kstrtobool(buf, &page_owner_enabled);
+	int ret = kstrtobool(buf, &page_owner_enabled);
+
+	if (page_owner_enabled)
+		stack_depot_want_early_init();
+
+	return ret;
 }
 early_param("page_owner", early_page_owner_param);
 
@@ -83,8 +88,6 @@ static __init void init_page_owner(void)
 	if (!page_owner_enabled)
 		return;
 
-	stack_depot_init();
-
 	register_dummy_stack();
 	register_failure_stack();
 	register_early_stack();
-- 
2.35.1

