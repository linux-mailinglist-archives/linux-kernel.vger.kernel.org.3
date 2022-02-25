Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A154C4D33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiBYSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiBYSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6211C6ECD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:03:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8FBB2212CB;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645812231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYBgC654YOyqIzj+nr/ZMOYGBPujEA+DNalj91uaEjo=;
        b=S409eBQ/6jhIrHxTjAWKjqX4R+/jQx1XofPJUObdYqimrV/WrI9SIbu8ZBzsX+mYV/emXX
        rRzDkfHE+itvWaqLY6dpn45e0UX55eIiB7w2CH1gaSOEprPLCGssmpZMH8lPYrdh/zkn1L
        zjsWt+nEG4qrOozbW/shfJk7jNlR6ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645812231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYBgC654YOyqIzj+nr/ZMOYGBPujEA+DNalj91uaEjo=;
        b=PVoj6PBN7VvM31rcOb+phcXFte1j23TyLMaUQt3LVd63s81WogArepFvf5WM0IGSVf8+V0
        KVvZ5n9+oCI2pgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66C4D13C17;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6EpzGAcaGWKSRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 18:03:51 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/5] mm/slub: use stackdepot to save stack trace in objects
Date:   Fri, 25 Feb 2022 19:03:15 +0100
Message-Id: <20220225180318.20594-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225180318.20594-1-vbabka@suse.cz>
References: <20220225180318.20594-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8140; i=vbabka@suse.cz; h=from:subject; bh=vyil6k5CkzrVe9SILYZzc3TCpafunzEbHdQZK1bWvNI=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiGRni+yuTFRPJKBAyFq/XIMThXhIinG8u+XoQm8lK MajJgduJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYhkZ4gAKCRDgIcpz8YmpEMFkB/ 0a+kagjn6AC/bH+c6AHu5BBdP2klXzLqleakD9T2Hp5LsdClB6kiUMIWainCe6K2GVeXIN1XvuRfHz 0BE8LMVsYAS0U3czxvBwWoBBUwOmvsih3blI70SC310hytw5xMgJu67wDD4Hp6A+4gWSnhcJmOXqhC Kw7tWW0jj0uIwgyb0ZAK32+6nQ+3PGpnRohDKv3xO2vLUWD+3Uq8W2UZl/NwqKt8Xx1D0Y7uFEeEVy C4Z7IAvMgWBUoA5O/UTIRvzc/XrxTokw2BgNQevJrpG6Hqlk7uFH0VDYSZD0KLCe7wPzMyEFKi1isV /uXTPzRj/CYCVEa8izwMaJ8hwltmdQ
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

From: Oliver Glitta <glittao@gmail.com>

Many stack traces are similar so there are many similar arrays.
Stackdepot saves each unique stack only once.

Replace field addrs in struct track with depot_stack_handle_t handle.  Use
stackdepot to save stack trace.

The benefits are smaller memory overhead and possibility to aggregate
per-cache statistics in the following patch using the stackdepot handle
instead of matching stacks manually.

[ vbabka@suse.cz: rebase to 5.17-rc1 and adjust accordingly ]

This was initially merged as commit 788691464c29 and reverted by commit
ae14c63a9f20 due to several issues, that should now be fixed.
The problem of unconditional memory overhead by stackdepot has been
addressed by commit 2dba5eb1c73b ("lib/stackdepot: allow optional init
and stack_table allocation by kvmalloc()"), so the dependency on
stackdepot will result in extra memory usage only when a slab cache
tracking is actually enabled, and not for all CONFIG_SLUB_DEBUG builds.
The build failures on some architectures were also addressed, and the
reported issue with xfs/433 test did not reproduce on 5.17-rc1 with this
patch.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 init/Kconfig |  1 +
 mm/slub.c    | 88 +++++++++++++++++++++++++++++-----------------------
 2 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..b21dd3a4a106 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1871,6 +1871,7 @@ config SLUB_DEBUG
 	default y
 	bool "Enable SLUB debugging support" if EXPERT
 	depends on SLUB && SYSFS
+	select STACKDEPOT if STACKTRACE_SUPPORT
 	help
 	  SLUB has extensive debug support features. Disabling these can
 	  result in significant savings in code size. This also disables
diff --git a/mm/slub.c b/mm/slub.c
index 1fc451f4fe62..3140f763e819 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -26,6 +26,7 @@
 #include <linux/cpuset.h>
 #include <linux/mempolicy.h>
 #include <linux/ctype.h>
+#include <linux/stackdepot.h>
 #include <linux/debugobjects.h>
 #include <linux/kallsyms.h>
 #include <linux/kfence.h>
@@ -264,8 +265,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 #define TRACK_ADDRS_COUNT 16
 struct track {
 	unsigned long addr;	/* Called from address */
-#ifdef CONFIG_STACKTRACE
-	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
+#ifdef CONFIG_STACKDEPOT
+	depot_stack_handle_t handle;
 #endif
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
@@ -724,22 +725,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 	return kasan_reset_tag(p + alloc);
 }
 
-static void set_track(struct kmem_cache *s, void *object,
-			enum track_item alloc, unsigned long addr)
+static noinline void
+set_track(struct kmem_cache *s, void *object, enum track_item alloc,
+	  unsigned long addr, gfp_t flags)
 {
 	struct track *p = get_track(s, object, alloc);
 
-#ifdef CONFIG_STACKTRACE
+#ifdef CONFIG_STACKDEPOT
+	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
 
-	metadata_access_enable();
-	nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
-				      TRACK_ADDRS_COUNT, 3);
-	metadata_access_disable();
-
-	if (nr_entries < TRACK_ADDRS_COUNT)
-		p->addrs[nr_entries] = 0;
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+	p->handle = stack_depot_save(entries, nr_entries, flags);
 #endif
+
 	p->addr = addr;
 	p->cpu = smp_processor_id();
 	p->pid = current->pid;
@@ -759,20 +758,19 @@ static void init_tracking(struct kmem_cache *s, void *object)
 
 static void print_track(const char *s, struct track *t, unsigned long pr_time)
 {
+	depot_stack_handle_t handle __maybe_unused;
+
 	if (!t->addr)
 		return;
 
 	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
-#ifdef CONFIG_STACKTRACE
-	{
-		int i;
-		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
-			if (t->addrs[i])
-				pr_err("\t%pS\n", (void *)t->addrs[i]);
-			else
-				break;
-	}
+#ifdef CONFIG_STACKDEPOT
+	handle = READ_ONCE(t->handle);
+	if (handle)
+		stack_depot_print(handle);
+	else
+		pr_err("object allocation/free stack trace missing\n");
 #endif
 }
 
@@ -1304,9 +1302,9 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 	return 1;
 }
 
-static noinline int alloc_debug_processing(struct kmem_cache *s,
-					struct slab *slab,
-					void *object, unsigned long addr)
+static noinline int
+alloc_debug_processing(struct kmem_cache *s, struct slab *slab, void *object,
+		       unsigned long addr, gfp_t flags)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
@@ -1315,7 +1313,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 
 	/* Success perform special debug activities for allocs */
 	if (s->flags & SLAB_STORE_USER)
-		set_track(s, object, TRACK_ALLOC, addr);
+		set_track(s, object, TRACK_ALLOC, addr, flags);
 	trace(s, slab, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
@@ -1395,7 +1393,7 @@ static noinline int free_debug_processing(
 	}
 
 	if (s->flags & SLAB_STORE_USER)
-		set_track(s, object, TRACK_FREE, addr);
+		set_track(s, object, TRACK_FREE, addr, GFP_NOWAIT);
 	trace(s, slab, object, 0);
 	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
 	init_object(s, object, SLUB_RED_INACTIVE);
@@ -1632,7 +1630,8 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, unsigned long addr) { return 0; }
+	struct slab *slab, void *object, unsigned long addr,
+	gfp_t flags) { return 0; }
 
 static inline int free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
@@ -3033,7 +3032,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 check_new_slab:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, slab, freelist, addr)) {
+		if (!alloc_debug_processing(s, slab, freelist, addr, gfpflags)) {
 			/* Slab failed checks. Next slab needed */
 			goto new_slab;
 		} else {
@@ -4221,6 +4220,9 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->remote_node_defrag_ratio = 1000;
 #endif
 
+	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
+		stack_depot_init();
+
 	/* Initialize the pre-computed randomized freelist if slab is up */
 	if (slab_state >= UP) {
 		if (init_cache_random_seq(s))
@@ -4352,18 +4354,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 	objp = fixup_red_left(s, objp);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
-#ifdef CONFIG_STACKTRACE
-	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
-		kpp->kp_stack[i] = (void *)trackp->addrs[i];
-		if (!kpp->kp_stack[i])
-			break;
-	}
+#ifdef CONFIG_STACKDEPOT
+	{
+		depot_stack_handle_t handle;
+		unsigned long *entries;
+		unsigned int nr_entries;
+
+		handle = READ_ONCE(trackp->handle);
+		if (handle) {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
+				kpp->kp_stack[i] = (void *)entries[i];
+		}
 
-	trackp = get_track(s, objp, TRACK_FREE);
-	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
-		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
-		if (!kpp->kp_free_stack[i])
-			break;
+		trackp = get_track(s, objp, TRACK_FREE);
+		handle = READ_ONCE(trackp->handle);
+		if (handle) {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
+				kpp->kp_free_stack[i] = (void *)entries[i];
+		}
 	}
 #endif
 #endif
-- 
2.35.1

