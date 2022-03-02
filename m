Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B54CAC06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiCBRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiCBRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:32:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261DCF390
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:31:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6E0C1F44D;
        Wed,  2 Mar 2022 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646242296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCaxkf/MeD15emqd3jto+7dldJPoNs7ZDgHl++2i7/Q=;
        b=TsnK/WQ/2RcSmnV4Av79OwvY8DJ5bhNRLF2IumvzNnz1v/ti25wBvAgDHwoBY0JCfHHhC4
        RPN0HpUICRjRyo1vePf2u97nOTVwgoBFc6DQsql00g6trKNVeifQepNyhpx/rUz1SMM6J/
        7Q4ctTRCeEX7vGnSuzFhyg4LwIpl4wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646242296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCaxkf/MeD15emqd3jto+7dldJPoNs7ZDgHl++2i7/Q=;
        b=/TpSi0r9jG9stqerHnols26RX6IpDklcb9TLdzVX8PivEUYI/QWlcRgBDyALWg60ZhcPPa
        m4tKxTrQKoyL/CDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E6D513D38;
        Wed,  2 Mar 2022 17:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GHjeHfipH2LPTAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 17:31:36 +0000
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
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 3/6] mm/slub: use stackdepot to save stack trace in objects
Date:   Wed,  2 Mar 2022 18:31:19 +0100
Message-Id: <20220302173122.11939-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302173122.11939-1-vbabka@suse.cz>
References: <20220302173122.11939-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7221; i=vbabka@suse.cz; h=from:subject; bh=eeOZ5fy5ud8Gx6oj27Gp5M6+txyzYk+05T/mhWZvDLw=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiH6nn4maXb3uYS3GEk1NVGdCTCL8kvKjR22Fp51Pv IEfNg8SJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYh+p5wAKCRDgIcpz8YmpEL2uB/ 4hv3bPDFSTeEcdTs+TugzyjKszd2ZLLlceH3dc634uVHMR0Un3bSdMfrIlivlWdpfjXJ3eEsC+guXs bVXf17LrGghCVn8iQw+pYOS6GqMg7KUGRp8YZ12XNJ6MB8eWQ6kJOsenhT+dG00yw/osT/IJSti6fi X4zR0SS1///t7QTwiEqZE9qCnLKes62VvbnJKs3jU+MCf1cG6v04VTY5NSSu5UMVHeBxfe4Xr53wFy dfxhO+6gg1wzvhJKeFRiEr2hb6nuqQGFeKfGxGYigx28X5D/Zo4yML/hrm9KMhDy2y+WYwOj0aqtnG VmmkoVdWD0hpDCHSdnvpgEd+j1bQcC
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
 init/Kconfig     |  1 +
 mm/slab_common.c |  5 ++++
 mm/slub.c        | 71 +++++++++++++++++++++++++++---------------------
 3 files changed, 46 insertions(+), 31 deletions(-)

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
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23f2ab0713b7..e51d50d03000 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <linux/memcontrol.h>
+#include <linux/stackdepot.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kmem.h>
@@ -314,9 +315,13 @@ kmem_cache_create_usercopy(const char *name,
 	 * If no slub_debug was enabled globally, the static key is not yet
 	 * enabled by setup_slub_debug(). Enable it if the cache is being
 	 * created with any of the debugging flags passed explicitly.
+	 * It's also possible that this is the first cache created with
+	 * SLAB_STORE_USER and we should init stack_depot for it.
 	 */
 	if (flags & SLAB_DEBUG_FLAGS)
 		static_branch_enable(&slub_debug_enabled);
+	if (flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
+		stack_depot_init();
 #endif
 
 	mutex_lock(&slab_mutex);
diff --git a/mm/slub.c b/mm/slub.c
index 1fc451f4fe62..42cb79af70a0 100644
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
@@ -724,22 +725,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 	return kasan_reset_tag(p + alloc);
 }
 
-static void set_track(struct kmem_cache *s, void *object,
+static void noinline set_track(struct kmem_cache *s, void *object,
 			enum track_item alloc, unsigned long addr)
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
+	p->handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
 #endif
+
 	p->addr = addr;
 	p->cpu = smp_processor_id();
 	p->pid = current->pid;
@@ -759,20 +757,19 @@ static void init_tracking(struct kmem_cache *s, void *object)
 
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
 
@@ -1532,6 +1529,8 @@ static int __init setup_slub_debug(char *str)
 			global_slub_debug_changed = true;
 		} else {
 			slab_list_specified = true;
+			if (flags & SLAB_STORE_USER)
+				stack_depot_want_early_init = true;
 		}
 	}
 
@@ -1549,6 +1548,8 @@ static int __init setup_slub_debug(char *str)
 	}
 out:
 	slub_debug = global_flags;
+	if (slub_debug & SLAB_STORE_USER)
+		stack_depot_want_early_init = true;
 	if (slub_debug != 0 || slub_debug_string)
 		static_branch_enable(&slub_debug_enabled);
 	else
@@ -4352,18 +4353,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
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

