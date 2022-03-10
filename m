Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8601C4D3E49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbiCJAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiCJAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:40:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ED124C1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646872797; x=1678408797;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=X2z+zSN/i5yI6VGeE+HYqJx2M+Kg5IqbBL0UPebJfPU=;
  b=KCbAbYfCA+11YRaJYwuzHkU2X99b3qn+eU/6yv7q3YQom6yVWfyix0Fr
   T5Vbh83hNXNGXzCHhBQH3eoW0Pyyf7H028L5ZtMvqJl8DIp8bhhyx1BNI
   B+VYctEIGD9eiBRyAMru6NnWEc2IRaALF390TUpQ1/OXCUzd/bw14KYZ+
   AKG93NVzHtiyvCdbtwcCtJzOjGTjwrYy7DohMl+maN1TrRKjkuJF5R9pr
   UGYd+c21f4NBsG7ZCplfzZbbRm2/wRcInZZCUHPO5tcDicb8/NEotGwEH
   7nTiHYh6lAkzegmfh0mtcga+iqvTLqZmnav2qfaF9bnvd4ETS2R1YfJl8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341554244"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="341554244"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:39:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513758433"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:39:55 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
References: <20220309144644.4278-1-osalvador@suse.de>
Date:   Thu, 10 Mar 2022 08:39:53 +0800
In-Reply-To: <20220309144644.4278-1-osalvador@suse.de> (Oscar Salvador's
        message of "Wed, 9 Mar 2022 15:46:44 +0100")
Message-ID: <87bkyefxnq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> Reported-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
> I think there is further room for improvement like should we call in to
> set_migration_target_nodes() when demotion is disabled via sysctl?
> I will have a look into that, but let us go with this quick fix for now.
> Also, I am not really strong about the Fixes tag, but it can be added
> if you think it makes sense.
> ---
>  include/linux/migrate.h |  5 +++++
>  mm/migrate.c            | 36 +-----------------------------------
>  mm/vmstat.c             | 10 +++++++++-
>  3 files changed, 15 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index db96e10eb8da..c64fe2923fb0 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -48,6 +48,11 @@ int folio_migrate_mapping(struct address_space *mapping,
>  		struct folio *newfolio, struct folio *folio, int extra_count);
>  
>  extern bool numa_demotion_enabled;
> +#ifdef CONFIG_HOTPLUG_CPU
> +extern void set_migration_target_nodes(void);
> +#else
> +static inline void set_migration_target_nodes() {}
> +#endif
>  #else
>  
>  static inline void putback_movable_pages(struct list_head *l) {}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7da064b4781..7847e4de01d7 100644
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
> @@ -3254,47 +3254,13 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
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
> -{
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
>  static int __init migrate_on_reclaim_init(void)
>  {
> -	int ret;
> -
>  	node_demotion = kmalloc_array(nr_node_ids,
>  				      sizeof(struct demotion_nodes),
>  				      GFP_KERNEL);
>  	WARN_ON(!node_demotion);
>  
> -	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
> -					NULL, migration_offline_cpu);
> -	/*
> -	 * In the unlikely case that this fails, the automatic
> -	 * migration targets may become suboptimal for nodes
> -	 * where N_CPU changes.  With such a small impact in a
> -	 * rare case, do not bother trying to do anything special.
> -	 */
> -	WARN_ON(ret < 0);
> -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> -				migration_online_cpu, NULL);
> -	WARN_ON(ret < 0);
> -

We need to call set_migration_target_nodes() during system boot
somewhere, either here or in init_mm_internals().

Best Regards,
Huang, Ying


>  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>  	return 0;
>  }
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4057372745d0..0529a83c8f89 100644
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
