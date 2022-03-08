Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D287C4D14AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiCHK2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbiCHK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:28:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59243634E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:27:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 763A7210E9;
        Tue,  8 Mar 2022 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646735264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N73gu50O85bYZ1Q0djNPPNKpF0IxOh/oir1CnV0OAZI=;
        b=wVqXgQCHNjsMMqYfWNZ8FNPqelZPjYRI6TDqOP3FZ+6WAilyLsjSdRbGw5bJv9P73sSomR
        03JR26sz9mXaF4ICdVC3H8hQVmpBf478P6AengGarHoeoHKWOXCBf9G7c7VTaELtWuOkeR
        1Y3N5yCyNA80qlArE551HnnbD6Iw6kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646735264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N73gu50O85bYZ1Q0djNPPNKpF0IxOh/oir1CnV0OAZI=;
        b=llsd9OIWA9yatRxOCyldL5u6WrQZg6CQN5MfDz/iv23GCywCJpJX1zlmiUyo4BuGd2YnVv
        1vVZAXi3AcqSBvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C15E213C84;
        Tue,  8 Mar 2022 10:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZhblK58vJ2KzRQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 08 Mar 2022 10:27:43 +0000
Date:   Tue, 8 Mar 2022 11:27:42 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
Message-ID: <YicvnkVODh5qbxTC@localhost.localdomain>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
 <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
 <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
 <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
 <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:32:20AM +0800, Huang, Ying wrote:
> -static int migration_online_cpu(unsigned int cpu)
> +static int migration_cpu_hotplug(unsigned int cpu)
>  {
> -	set_migration_target_nodes();
> -	return 0;
> -}
> +	static int nr_cpu_node_saved;
> +	int nr_cpu_node;
> +
> +	nr_cpu_node = num_node_state(N_CPU);
> +	if (nr_cpu_node != nr_cpu_node_saved) {
> +		set_migration_target_nodes();
> +		nr_cpu_node_saved = nr_cpu_node;
> +	}
>  
> -static int migration_offline_cpu(unsigned int cpu)
> -{
> -	set_migration_target_nodes();
>  	return 0;
>  }

These callbacks feel like re-inveting the wheel.
We do already have two functions that get called during cpu
online/offline, and that sets/clears N_CPU on the node properly.
And that is exactly what we want, so what about the following (only
compile-tested):

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index db96e10eb8da..031af2bb71dc 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -48,6 +48,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);

 extern bool numa_demotion_enabled;
+extern void set_migration_target_nodes(void);
 #else

 static inline void putback_movable_pages(struct list_head *l) {}
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..7847e4de01d7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3190,7 +3190,7 @@ static void __set_migration_target_nodes(void)
 /*
  * For callers that do not hold get_online_mems() already.
  */
-static void set_migration_target_nodes(void)
+void set_migration_target_nodes(void)
 {
 	get_online_mems();
 	__set_migration_target_nodes();
@@ -3254,47 +3254,13 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
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
-{
-	set_migration_target_nodes();
-	return 0;
-}
-
 static int __init migrate_on_reclaim_init(void)
 {
-	int ret;
-
 	node_demotion = kmalloc_array(nr_node_ids,
 				      sizeof(struct demotion_nodes),
 				      GFP_KERNEL);
 	WARN_ON(!node_demotion);

-	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
-					NULL, migration_offline_cpu);
-	/*
-	 * In the unlikely case that this fails, the automatic
-	 * migration targets may become suboptimal for nodes
-	 * where N_CPU changes.  With such a small impact in a
-	 * rare case, do not bother trying to do anything special.
-	 */
-	WARN_ON(ret < 0);
-	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
-				migration_online_cpu, NULL);
-	WARN_ON(ret < 0);
-
 	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
 	return 0;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..0529a83c8f89 100644
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

I think this is just easier and meets exactly the goal.

We could go even further and move the work left in
migrate_on_reclaim_init() to init_mm_internals().
(I __think__ we should be fine because there is no dependency
there, e.g: notifier being set up somewhere later after
init_mm_internals() has been called).

-- 
Oscar Salvador
SUSE Labs
