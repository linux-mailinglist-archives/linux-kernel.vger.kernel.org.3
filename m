Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78449535F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351344AbiE0Lhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351338AbiE0Lha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:37:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AFD63391
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:37:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B825219BA;
        Fri, 27 May 2022 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653651447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXusmkwxceHRkiBRNvi2J/m0PO64GWg/sAaKBfj8UU8=;
        b=AmN+/hYVTdrJ/h/J42ZCYYmDM4Dgmn6CaV9ou+7SeO2/c/G/hZlrCgesMu18ksdYlYogvo
        XhjvZnWLmtOC/Nd5NG0Q54jM2rRyZbuopAc5i5vjP+tXYOtlTlTnE86DjpIRqyYFurJAB+
        SxLoUaf9zKPpXiNlxJYqJwpqyzvjMbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653651447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXusmkwxceHRkiBRNvi2J/m0PO64GWg/sAaKBfj8UU8=;
        b=rQAh6frxpnaDTrAQtbuR3NK++g0Nu6ZG3ZhoJnsU98LdTqcl73maxXC6frRBYD8EEyJqgG
        5cR0OAYfa4QP83Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F72913AE3;
        Fri, 27 May 2022 11:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GEvpEve3kGKQDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 27 May 2022 11:37:27 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 1/1] lib/stackdepot: replace CONFIG_STACK_HASH_ORDER with automatic sizing
Date:   Fri, 27 May 2022 13:37:06 +0200
Message-Id: <20220527113706.24870-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527113706.24870-1-vbabka@suse.cz>
References: <20220527113706.24870-1-vbabka@suse.cz>
MIME-Version: 1.0
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

As Linus explained [1], setting the stackdepot hash table size as a
config option is suboptimal, especially as stackdepot becomes a
dependency of less specialized subsystems than initially (e.g. DRM,
networking, SLUB_DEBUG):

: (a) it introduces a new compile-time question that isn't sane to ask
: a regular user, but is now exposed to regular users.

: (b) this by default uses 1MB of memory for a feature that didn't in
: the past, so now if you have small machines you need to make sure you
: make a special kernel config for them.

Ideally we would employ rhashtable for fully automatic resizing, which
should be feasible for many of the new users, but problematic for the
original users with restricted context that call __stack_depot_save()
with can_alloc == false, i.e. KASAN.

However we can easily remove the config option and scale the hash table
automatically with system memory. The STACK_HASH_MASK constant becomes
stack_hash_mask variable and is used only in one mask operation, so the
overhead should be negligible to none. For early allocation we can
employ the existing alloc_large_system_hash() function and perform
similar scaling for the late allocation.

The existing limits of the config option (between 4k and 1M buckets)
are preserved, and scaling factor is set to one bucket per 16kB memory
so on 64bit the max 1M buckets (8MB memory) is achieved with 16GB
system, while a 1GB system will use 512kB.

If needed, the automatic scaling could be complemented with a boot-time
kernel parameter, but it feels pointless to add it without a specific
use case.

[1] https://lore.kernel.org/all/CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com/

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/Kconfig      |  9 ---------
 lib/stackdepot.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6a843639814f..1e7cf7c76ae6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -682,15 +682,6 @@ config STACKDEPOT_ALWAYS_INIT
 	bool
 	select STACKDEPOT
 
-config STACK_HASH_ORDER
-	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
-	range 12 20
-	default 20
-	depends on STACKDEPOT
-	help
-	 Select the hash size as a power of 2 for the stackdepot hash table.
-	 Choose a lower value to reduce the memory impact.
-
 config REF_TRACKER
 	bool
 	depends on STACKTRACE_SUPPORT
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ca0d086ef4a..f7b73ddfca77 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -145,10 +145,15 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	return stack;
 }
 
-#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER)
-#define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
+/* one hash table bucket entry per 16kB of memory */
+#define STACK_HASH_SCALE	14
+/* limited between 4k and 1M buckets */
+#define STACK_HASH_ORDER_MIN	12
+#define STACK_HASH_ORDER_MAX	20
 #define STACK_HASH_SEED 0x9747b28c
 
+static unsigned int stack_hash_mask;
+
 static bool stack_depot_disable;
 static struct stack_record **stack_table;
 
@@ -175,8 +180,6 @@ void __init stack_depot_want_early_init(void)
 
 int __init stack_depot_early_init(void)
 {
-	size_t size;
-
 	/* This is supposed to be called only once, from mm_init() */
 	if (WARN_ON(__stack_depot_early_init_passed))
 		return 0;
@@ -186,10 +189,15 @@ int __init stack_depot_early_init(void)
 	if (!__stack_depot_want_early_init || stack_depot_disable)
 		return 0;
 
-	size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
-	pr_info("Stack Depot early init allocating hash table with memblock_alloc, %zu bytes\n",
-		size);
-	stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
+	stack_table = alloc_large_system_hash("stackdepot",
+						sizeof(struct stack_record *),
+						0,
+						STACK_HASH_SCALE,
+						HASH_EARLY | HASH_ZERO,
+						NULL,
+						&stack_hash_mask,
+						1UL << STACK_HASH_ORDER_MIN,
+						1UL << STACK_HASH_ORDER_MAX);
 
 	if (!stack_table) {
 		pr_err("Stack Depot hash table allocation failed, disabling\n");
@@ -207,13 +215,30 @@ int stack_depot_init(void)
 
 	mutex_lock(&stack_depot_init_mutex);
 	if (!stack_depot_disable && !stack_table) {
-		pr_info("Stack Depot allocating hash table with kvcalloc\n");
-		stack_table = kvcalloc(STACK_HASH_SIZE, sizeof(struct stack_record *), GFP_KERNEL);
+		unsigned long entries;
+
+		entries = nr_free_buffer_pages();
+		entries = roundup_pow_of_two(entries);
+
+		if (STACK_HASH_SCALE > PAGE_SHIFT)
+			entries >>= (STACK_HASH_SCALE - PAGE_SHIFT);
+		else
+			entries <<= (PAGE_SHIFT - STACK_HASH_SCALE);
+
+		if (entries < 1UL << STACK_HASH_ORDER_MIN)
+			entries = 1UL << STACK_HASH_ORDER_MIN;
+		if (entries > 1UL << STACK_HASH_ORDER_MAX)
+			entries = 1UL << STACK_HASH_ORDER_MAX;
+
+		pr_info("Stack Depot allocating hash table of %lu entries with kvcalloc\n",
+				entries);
+		stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
 		if (!stack_table) {
 			pr_err("Stack Depot hash table allocation failed, disabling\n");
 			stack_depot_disable = true;
 			ret = -ENOMEM;
 		}
+		stack_hash_mask = entries - 1;
 	}
 	mutex_unlock(&stack_depot_init_mutex);
 	return ret;
@@ -386,7 +411,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-	bucket = &stack_table[hash & STACK_HASH_MASK];
+	bucket = &stack_table[hash & stack_hash_mask];
 
 	/*
 	 * Fast path: look the stack trace up without locking.
-- 
2.36.1

