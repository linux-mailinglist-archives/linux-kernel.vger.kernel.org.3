Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3C4D87C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiCNPLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiCNPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:11:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A223D4A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:09:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10E0A212C6;
        Mon, 14 Mar 2022 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647270593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xv0XMOjzc2nVpzPaqM8A8/JAUFAEHxwN81VOoXfUJm0=;
        b=UuPE8ovyv3AHNXefwNj5dERkdHwsiy4gK9mDdaHy6sRlGh8V9qFwl7xbzrIVaXXWc9OznT
        6Fdy1gfhQ2WuPLUlgKiRFzFrko5N6yCUlZ6kdid8k7FRUHVlOEHaBYYyAy6zMirQANxhDn
        ZNTLoTMiMQbyuDdhgR+8QHURAUlQCgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647270593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xv0XMOjzc2nVpzPaqM8A8/JAUFAEHxwN81VOoXfUJm0=;
        b=+uA8a9HutVuOQkZnribjD1/nuDLfMzACUmxac+i+xtRNuDGrR6leocmXXnrjVq1GIs/af9
        4GZv2DJI4p/IarAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8612D13B35;
        Mon, 14 Mar 2022 15:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id se2uHcBaL2LyCwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 14 Mar 2022 15:09:52 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3] mm: Only re-generate demotion targets when a numa node changes its N_CPU state
Date:   Mon, 14 Mar 2022 16:09:45 +0100
Message-Id: <20220314150945.12694-1-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
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

Abhishek reported that after patch [1], hotplug operations are
taking ~double the expected time. [2]

The reason behind is that the CPU callbacks that migrate_on_reclaim_init()
sets always call set_migration_target_nodes() whenever a CPU is brought
up/down.
But we only care about numa nodes going from having cpus to become
cpuless, and vice versa, as that influences the demotion_target order.

We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
that check exactly that, so get rid of the CPU callbacks in
migrate_on_reclaim_init() and only call set_migration_target_nodes() from
vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.

[1] https://lore.kernel.org/linux-mm/20210721063926.3024591-2-ying.huang@intel.com/
[2] https://lore.kernel.org/linux-mm/eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com/

Fixes: 884a6e5d1f93b ("mm/migrate: update node demotion order on hotplug events")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 v2 -> v3:
           - Add feedback from Huang Ying
	   - Add tags
 v1 -> v2:
           - Add fedback from Huang Ying
           - Add feedback from Baolin Wang
---
 include/linux/migrate.h |  8 +++++++
 mm/migrate.c            | 47 +++++++++--------------------------------
 mm/vmstat.c             | 13 +++++++++++-
 3 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index db96e10eb8da..90e75d5a54d6 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -48,7 +48,15 @@ int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 
 extern bool numa_demotion_enabled;
+extern void migrate_on_reclaim_init(void);
+#ifdef CONFIG_HOTPLUG_CPU
+extern void set_migration_target_nodes(void);
 #else
+static inline void set_migration_target_nodes(void) {}
+#endif
+#else
+
+static inline void set_migration_target_nodes(void) {}
 
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
diff --git a/mm/migrate.c b/mm/migrate.c
index e8a6933af68d..2561881f03b2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3193,7 +3193,7 @@ static void __set_migration_target_nodes(void)
 /*
  * For callers that do not hold get_online_mems() already.
  */
-static void set_migration_target_nodes(void)
+void set_migration_target_nodes(void)
 {
 	get_online_mems();
 	__set_migration_target_nodes();
@@ -3257,51 +3257,24 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
 	return notifier_from_errno(0);
 }
 
-/*
- * React to hotplug events that might affect the migration targets
- * like events that online or offline NUMA nodes.
- *
- * The ordering is also currently dependent on which nodes have
- * CPUs.  That means we need CPU on/offline notification too.
- */
-static int migration_online_cpu(unsigned int cpu)
-{
-	set_migration_target_nodes();
-	return 0;
-}
-
-static int migration_offline_cpu(unsigned int cpu)
+void __init migrate_on_reclaim_init(void)
 {
-	set_migration_target_nodes();
-	return 0;
-}
-
-static int __init migrate_on_reclaim_init(void)
-{
-	int ret;
-
 	node_demotion = kmalloc_array(nr_node_ids,
 				      sizeof(struct demotion_nodes),
 				      GFP_KERNEL);
 	WARN_ON(!node_demotion);
 
-	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
-					NULL, migration_offline_cpu);
+	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
 	/*
-	 * In the unlikely case that this fails, the automatic
-	 * migration targets may become suboptimal for nodes
-	 * where N_CPU changes.  With such a small impact in a
-	 * rare case, do not bother trying to do anything special.
+	 * At this point, all numa nodes with memory/CPus have their state
+	 * properly set, so we can build the demotion order now.
+	 * Let us hold the cpu_hotplug lock just, as we could possibily have
+	 * CPU hotplug events during boot.
 	 */
-	WARN_ON(ret < 0);
-	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
-				migration_online_cpu, NULL);
-	WARN_ON(ret < 0);
-
-	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
-	return 0;
+	cpus_read_lock();
+	set_migration_target_nodes();
+	cpus_read_unlock();
 }
-late_initcall(migrate_on_reclaim_init);
 #endif /* CONFIG_HOTPLUG_CPU */
 
 bool numa_demotion_enabled = false;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..9e9536df51b5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -2043,7 +2044,12 @@ static void __init init_cpu_node_state(void)
 static int vmstat_cpu_online(unsigned int cpu)
 {
 	refresh_zone_stat_thresholds();
-	node_set_state(cpu_to_node(cpu), N_CPU);
+
+	if (!node_state(cpu_to_node(cpu), N_CPU)) {
+		node_set_state(cpu_to_node(cpu), N_CPU);
+		set_migration_target_nodes();
+	}
+
 	return 0;
 }
 
@@ -2066,6 +2072,8 @@ static int vmstat_cpu_dead(unsigned int cpu)
 		return 0;
 
 	node_clear_state(node, N_CPU);
+	set_migration_target_nodes();
+
 	return 0;
 }
 
@@ -2097,6 +2105,9 @@ void __init init_mm_internals(void)
 
 	start_shepherd_timer();
 #endif
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_HOTPLUG_CPU)
+	migrate_on_reclaim_init();
+#endif
 #ifdef CONFIG_PROC_FS
 	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
 	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
-- 
2.34.1

