Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79794DC77E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiCQN0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiCQN0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:26:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12425197AED
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:24:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF9F821108;
        Thu, 17 Mar 2022 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647523493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MDeAE84DRLdT9jTy1nr6IG8m6m2XkLXKMCgf9rNtHAE=;
        b=p6ZXeSgny6Tu58YnVcA0wv/EvTIaFQdn+VqHGWds/5zwIRG/22ulGIfKP1dTLUIAjbhiMb
        lQ48yGOMljRn9o0yb5mBRlYaLn7pN/jvBNY04rUreV9oAZLPHplVy+FC+/W2QS4M3EAX0M
        ZDKN0NbllGBtCNdE1oB0HPebCUsUbzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647523493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MDeAE84DRLdT9jTy1nr6IG8m6m2XkLXKMCgf9rNtHAE=;
        b=nheOVJ5H9rGvN+YbNv/kMHTF3T3D1p8eWb0ejrQDQj4HYk27fukhHOv5nUuGXpPcozo3BZ
        MUzuMa1jerXV7qDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3585013BA9;
        Thu, 17 Mar 2022 13:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sRQWCqU2M2IgEAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 17 Mar 2022 13:24:53 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm: Untangle config dependencies for demote-on-reclaim
Date:   Thu, 17 Mar 2022 14:24:50 +0100
Message-Id: <20220317132450.5116-1-osalvador@suse.de>
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

At the time demote-on-reclaim was introduced, it was tied to
CONFIG_HOTPLUG_CPU + CONFIG_MIGRATE, but that is not really
accurate.

The only two things we need to depen on is CONFIG_NUMA +
CONFIG_MIGRATE, so clean this up.
Furthermore, we only register the hotplug memory notifier
when the system has CONFIG_MEMORY_HOTPLUG.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/migrate.h |  5 ++++-
 mm/migrate.c            | 11 ++++++-----
 mm/vmstat.c             |  2 --
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index a4a336fd81fc..1efabe7bb5fc 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -49,14 +49,17 @@ int folio_migrate_mapping(struct address_space *mapping,
 
 extern bool numa_demotion_enabled;
 extern void migrate_on_reclaim_init(void);
-#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_NUMA
 extern void set_migration_target_nodes(void);
+extern void migrate_on_reclaim_init(void);
 #else
 static inline void set_migration_target_nodes(void) {}
+static inline void migrate_on_reclaim_init(void) {}
 #endif
 #else
 
 static inline void set_migration_target_nodes(void) {}
+static inline void migrate_on_reclaim_init(void) {}
 
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
diff --git a/mm/migrate.c b/mm/migrate.c
index 3364bfaddeef..118f71425241 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2144,7 +2144,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	return 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_NUMA */
 
 /*
  * node_demotion[] example:
@@ -2278,7 +2277,6 @@ int next_demotion_node(int node)
 	return target;
 }
 
-#if defined(CONFIG_HOTPLUG_CPU)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
@@ -2471,6 +2469,7 @@ void set_migration_target_nodes(void)
  * __set_migration_target_nodes() can be used as opposed to
  * set_migration_target_nodes().
  */
+#ifdef CONFIG_MEMORY_HOTPLUG
 static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
 						 unsigned long action, void *_arg)
 {
@@ -2516,6 +2515,7 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
 
 	return notifier_from_errno(0);
 }
+#endif
 
 void __init migrate_on_reclaim_init(void)
 {
@@ -2523,8 +2523,9 @@ void __init migrate_on_reclaim_init(void)
 				      sizeof(struct demotion_nodes),
 				      GFP_KERNEL);
 	WARN_ON(!node_demotion);
-
+#ifdef CONFIG_MEMORY_HOTPLUG
 	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
+#endif
 	/*
 	 * At this point, all numa nodes with memory/CPus have their state
 	 * properly set, so we can build the demotion order now.
@@ -2535,7 +2536,6 @@ void __init migrate_on_reclaim_init(void)
 	set_migration_target_nodes();
 	cpus_read_unlock();
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 bool numa_demotion_enabled = false;
 
@@ -2596,4 +2596,5 @@ static int __init numa_init_sysfs(void)
 	return err;
 }
 subsys_initcall(numa_init_sysfs);
-#endif
+#endif /* CONFIG_SYSFS */
+#endif /* CONFIG_NUMA */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b75b1a64b54c..f2d0dec1062d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2111,9 +2111,7 @@ void __init init_mm_internals(void)
 
 	start_shepherd_timer();
 #endif
-#if defined(CONFIG_MIGRATION) && defined(CONFIG_HOTPLUG_CPU)
 	migrate_on_reclaim_init();
-#endif
 #ifdef CONFIG_PROC_FS
 	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
 	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
-- 
2.34.1

