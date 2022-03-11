Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D04D5819
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiCKCZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiCKCZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:25:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B147118629
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646965451; x=1678501451;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HruHtRlhAc0U3F4cVcvyFdaAF8MkYtwe6vqwcQ+MSbo=;
  b=J6OevDFZuE/D7aUHRPe+SXEfqZg2oEDpS2mI3MWihvd6u11nL2JBSBHW
   K1bMsumot5eocxbDZkqKXaWdejB2Fg05bGUbbDtX5PMnYW+BN/fqQlD86
   8fRotxtQAxmf4dJ5gPRLjzKal4ycVGYCr5dxe71btxESy5KLqUDPTjuwH
   Bmqaz1fH1XV5k7VZqyDdi88EKBFSBRvFvvI3UdLN2+uyddn47TL6FHU3P
   N9KhrvCEOrLjC1cAdk3ywygI4r0a9iH93HnuYOv5WadIYxaOJu2uA2Aok
   kfXJPwOm4Sb/7uyiYJBjnpXhYiED/2MRzhicEQ9+OzcR0vj6WjTd2snru
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255214446"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255214446"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="548320752"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:24:08 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
References: <20220310120749.23077-1-osalvador@suse.de>
Date:   Fri, 11 Mar 2022 10:24:07 +0800
In-Reply-To: <20220310120749.23077-1-osalvador@suse.de> (Oscar Salvador's
        message of "Thu, 10 Mar 2022 13:07:49 +0100")
Message-ID: <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> Abhishek reported that after patch [1], hotplug operations are
> taking ~double the expected time. [2]
>
> The reason behind is that the CPU callbacks that migrate_on_reclaim_init()
> sets always call set_migration_target_nodes() whenever a CPU is brought
> up/down.
> But we only care about numa nodes going from having cpus to become
> cpuless, and vice versa, as that influences the demotion_target order.
>
> We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
> that check exactly that, so get rid of the CPU callbacks in
> migrate_on_reclaim_init() and only call set_migration_target_nodes() from
> vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.
>
> [1] https://lore.kernel.org/linux-mm/20210721063926.3024591-2-ying.huang@intel.com/
> [2] https://lore.kernel.org/linux-mm/eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com/
>
> Reported-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
> v1 -> v2: - Fix prototype function declaration
>           - Fix build error on RISC
>           - Adressed feedback from Baolin and Huang
> ---
>  include/linux/migrate.h |  8 ++++++++
>  mm/migrate.c            | 41 +++++------------------------------------
>  mm/vmstat.c             | 13 ++++++++++++-
>  3 files changed, 25 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index db96e10eb8da..90e75d5a54d6 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -48,7 +48,15 @@ int folio_migrate_mapping(struct address_space *mapping,
>  		struct folio *newfolio, struct folio *folio, int extra_count);
>  
>  extern bool numa_demotion_enabled;
> +extern void migrate_on_reclaim_init(void);
> +#ifdef CONFIG_HOTPLUG_CPU
> +extern void set_migration_target_nodes(void);
>  #else
> +static inline void set_migration_target_nodes(void) {}
> +#endif
> +#else
> +
> +static inline void set_migration_target_nodes(void) {}
>  
>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7da064b4781..f9d5b6092a42 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3190,7 +3190,7 @@ static void __set_migration_target_nodes(void)
>  /*
>   * For callers that do not hold get_online_mems() already.
>   */
> -static void set_migration_target_nodes(void)
> +void set_migration_target_nodes(void)
>  {
>  	get_online_mems();
>  	__set_migration_target_nodes();
> @@ -3254,51 +3254,20 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>  	return notifier_from_errno(0);
>  }
>  
> -/*
> - * React to hotplug events that might affect the migration targets
> - * like events that online or offline NUMA nodes.
> - *
> - * The ordering is also currently dependent on which nodes have
> - * CPUs.  That means we need CPU on/offline notification too.
> - */
> -static int migration_online_cpu(unsigned int cpu)
> +void __init migrate_on_reclaim_init(void)
>  {
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
> -static int migration_offline_cpu(unsigned int cpu)
> -{
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
> -static int __init migrate_on_reclaim_init(void)
> -{
> -	int ret;
> -
>  	node_demotion = kmalloc_array(nr_node_ids,
>  				      sizeof(struct demotion_nodes),
>  				      GFP_KERNEL);
>  	WARN_ON(!node_demotion);
>  
> -	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
> -					NULL, migration_offline_cpu);
>  	/*
> -	 * In the unlikely case that this fails, the automatic
> -	 * migration targets may become suboptimal for nodes
> -	 * where N_CPU changes.  With such a small impact in a
> -	 * rare case, do not bother trying to do anything special.
> +	 * At this point, all numa nodes with memory/CPus have their state
> +	 * properly set, so we can build the demotion order now.
>  	 */
> -	WARN_ON(ret < 0);
> -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> -				migration_online_cpu, NULL);
> -	WARN_ON(ret < 0);
> -
> +	set_migration_target_nodes();
>  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -	return 0;
>  }
> -late_initcall(migrate_on_reclaim_init);
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
>  bool numa_demotion_enabled = false;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4057372745d0..9e9536df51b5 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -28,6 +28,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/page_ext.h>
>  #include <linux/page_owner.h>
> +#include <linux/migrate.h>
>  
>  #include "internal.h"
>  
> @@ -2043,7 +2044,12 @@ static void __init init_cpu_node_state(void)
>  static int vmstat_cpu_online(unsigned int cpu)
>  {
>  	refresh_zone_stat_thresholds();
> -	node_set_state(cpu_to_node(cpu), N_CPU);
> +
> +	if (!node_state(cpu_to_node(cpu), N_CPU)) {
> +		node_set_state(cpu_to_node(cpu), N_CPU);
> +		set_migration_target_nodes();
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2066,6 +2072,8 @@ static int vmstat_cpu_dead(unsigned int cpu)
>  		return 0;
>  
>  	node_clear_state(node, N_CPU);
> +	set_migration_target_nodes();
> +
>  	return 0;
>  }
>  
> @@ -2097,6 +2105,9 @@ void __init init_mm_internals(void)
>  
>  	start_shepherd_timer();
>  #endif
> +#if defined(CONFIG_MIGRATION) && defined(CONFIG_HOTPLUG_CPU)
> +	migrate_on_reclaim_init();
> +#endif

It may be unnecessary to be fixed in this patch.  But I think we need to
cleanup the kernel config dependencies of the demotion code at some time.

1. Even if !defined(CONFIG_HOTPLUG_CPU) &&
   !defined(CONFIG_MEMORY_HOTPLUG), we still need to allocate
   "node_demotion" and call set_migration_target_nodes() during boot time.

2. If !defined(CONFIG_MEMORY_HOTPLUG), we don't need
   migrate_on_reclaim_callback().

3. We need defined(CONFIG_NUMA) && defined(CONFIG_MIGRATION) for all
   these code.

Best Regards,
Huang, Ying

>  #ifdef CONFIG_PROC_FS
>  	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
>  	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
