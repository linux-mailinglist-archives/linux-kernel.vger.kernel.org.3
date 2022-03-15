Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255784D94B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiCOGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiCOGmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:42:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689A913D04
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647326457; x=1678862457;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8I1wLnG20Ik3u34S3KwlGd2TYvCo27NadTKc1KIB5X8=;
  b=XlXxiMx3rG2RdYSy5mjj1tCCQ+bh47gc+Xbdsyvh0/YiueOteEwc18w9
   BM/UGCAkT+8GOWg/ipQgxb0zdkmTYx2a3qyJS0cJspALj1hj4MZlgeE8k
   +Dfcn7KmELmNO7qDkAEm4BzF67ekB9IrP9dozYW8hdDp3UM81cYiI/c1G
   ow72F8eVi4beaIHqyrq1Gr2tVbpmUutOROOEp0oKvy0k+/n6qjTgUQ4MM
   mMInYUKcraSECRPVKcfy4EZur/tV83qZZ08fpZ2UFfI9YLlZwwruD6DH8
   F/ev8h4GsjrIPi+31dRurdKyoQuhdqMDYSXMTlu4pxm4z1vwmHY0svdyr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256177689"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="256177689"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:40:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515746056"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:40:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
References: <20220314150945.12694-1-osalvador@suse.de>
Date:   Tue, 15 Mar 2022 14:40:53 +0800
In-Reply-To: <20220314150945.12694-1-osalvador@suse.de> (Oscar Salvador's
        message of "Mon, 14 Mar 2022 16:09:45 +0100")
Message-ID: <87pmmn3eh6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Fixes: 884a6e5d1f93b ("mm/migrate: update node demotion order on hotplug events")
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reported-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  v2 -> v3:
>            - Add feedback from Huang Ying
> 	   - Add tags
>  v1 -> v2:
>            - Add fedback from Huang Ying
>            - Add feedback from Baolin Wang
> ---
>  include/linux/migrate.h |  8 +++++++
>  mm/migrate.c            | 47 +++++++++--------------------------------
>  mm/vmstat.c             | 13 +++++++++++-
>  3 files changed, 30 insertions(+), 38 deletions(-)
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
> index e8a6933af68d..2561881f03b2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3193,7 +3193,7 @@ static void __set_migration_target_nodes(void)
>  /*
>   * For callers that do not hold get_online_mems() already.
>   */
> -static void set_migration_target_nodes(void)
> +void set_migration_target_nodes(void)
>  {
>  	get_online_mems();
>  	__set_migration_target_nodes();
> @@ -3257,51 +3257,24 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
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
> -{
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
> -static int migration_offline_cpu(unsigned int cpu)
> +void __init migrate_on_reclaim_init(void)
>  {
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

CPUHP_MM_DEMOTION_DEAD and CPUHP_AP_MM_DEMOTION_ONLINE needs to be
deleted from include/linux/cpuhotplug.h too.

Best Regards,
Huang, Ying

> -					NULL, migration_offline_cpu);
> +	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>  	/*
> -	 * In the unlikely case that this fails, the automatic
> -	 * migration targets may become suboptimal for nodes
> -	 * where N_CPU changes.  With such a small impact in a
> -	 * rare case, do not bother trying to do anything special.
> +	 * At this point, all numa nodes with memory/CPus have their state
> +	 * properly set, so we can build the demotion order now.
> +	 * Let us hold the cpu_hotplug lock just, as we could possibily have
> +	 * CPU hotplug events during boot.
>  	 */
> -	WARN_ON(ret < 0);
> -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> -				migration_online_cpu, NULL);
> -	WARN_ON(ret < 0);
> -
> -	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -	return 0;
> +	cpus_read_lock();
> +	set_migration_target_nodes();
> +	cpus_read_unlock();
>  }
> -late_initcall(migrate_on_reclaim_init);
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
>  bool numa_demotion_enabled = false;

[snip]
